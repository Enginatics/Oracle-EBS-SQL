/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INL Landed Cost Estimated vs Actual
-- Description: Landed cost per Landed Cost Management shipment line and cost component (item price, each charge type and each tax), comparing the estimate with the current landed cost.
-- Estimated Amount is the allocation of the shipment's first landed cost calculation (adjustment 0) and Current Amount the allocation of its latest adjustment, both in functional currency. A component without a matched AP invoice still carries its estimate; an estimate changed in the Shipment Workbench after submission shows as a variance without a match.
-- LCM allocates a charge to the shipment lines by the charge type's allocation basis, so Current Amount per line can differ from Matched Amount, which is the amount distributed to that receipt line on the AP invoice. The shipment totals agree.
-- Excel Example Output: https://www.enginatics.com/example/inl-landed-cost-estimated-vs-actual/
-- Library Link: https://www.enginatics.com/reports/inl-landed-cost-estimated-vs-actual/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
mp.organization_code,
ish.ship_num shipment_number,
ish.ship_date shipment_date,
xxen_util.meaning(ish.ship_status_code,'INL_SHIP_STATUSES',0) shipment_status,
isl.ship_line_num shipment_line,
aps.vendor_name supplier,
pha.segment1 po_number,
pla.line_num po_line,
plla.shipment_num po_shipment,
rsh.receipt_num,
msiv.concatenated_segments item,
msiv.description item_description,
(select ftv.territory_short_name from fnd_territories_vl ftv where nvl(rsl.country_of_origin_code,plla.country_of_origin_code)=ftv.territory_code) country_of_origin,
isl.primary_qty quantity,
isl.primary_uom_code uom,
xxen_util.meaning(x.component_type,'INL_COMPONENT_TYPES',0) component_type,
decode(x.component_type,'CHARGE',pcfv.name,'TAX',x.tax_code) component,
hp.party_name charging_party,
gl.currency_code,
x.estimated_amt estimated_amount,
x.current_amt current_amount,
x.current_amt-x.estimated_amt variance,
round(100*(x.current_amt-x.estimated_amt)/nullif(x.estimated_amt,0),2) variance_percent,
x.estimated_amt/nullif(isl.primary_qty,0) estimated_unit_amount,
x.current_amt/nullif(isl.primary_qty,0) current_unit_amount,
m.matched_amt matched_amount,
xxen_util.yes(nvl2(m.matched_amt,'Y',null)) matched,
m.invoice_numbers
from
(
select
ia.ship_header_id,
nvl(isl.parent_ship_line_id,isl.ship_line_id) ship_line_id,
decode(ia.from_parent_table_name,'INL_SHIP_LINES','ITEM','INL_CHARGE_LINES','CHARGE','INL_TAX_LINES','TAX') component_type,
icl.charge_line_type_id,
itl.tax_code,
sum(decode(ia.adjustment_num,0,ia.allocation_amt,0)) estimated_amt,
sum(decode(ia.adjustment_num,ish.adjustment_num,ia.allocation_amt,0)) current_amt,
max(icl.party_id) keep (dense_rank last order by ia.adjustment_num) party_id
from
inl_ship_headers_all ish,
inl_allocations ia,
inl_ship_lines_all isl,
inl_charge_lines icl,
inl_tax_lines itl
where
1=1 and
2=2 and
ish.simulation_id is null and
ish.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
ish.ship_header_id=ia.ship_header_id and
ia.adjustment_num in (0,ish.adjustment_num) and
ia.landed_cost_flag='Y' and
ia.ship_line_id=isl.ship_line_id and
decode(ia.from_parent_table_name,'INL_CHARGE_LINES',ia.from_parent_table_id)=icl.charge_line_id(+) and
decode(ia.from_parent_table_name,'INL_TAX_LINES',ia.from_parent_table_id)=itl.tax_line_id(+)
group by
ia.ship_header_id,
nvl(isl.parent_ship_line_id,isl.ship_line_id),
ia.from_parent_table_name,
icl.charge_line_type_id,
itl.tax_code
) x,
(
select
y.ship_line_id,
y.component_type,
y.charge_line_type_id,
y.tax_code,
sum(y.matched_amt) matched_amt,
listagg(y.invoice_num,', ') within group (order by y.invoice_num) invoice_numbers
from
(
select
im.to_parent_table_id ship_line_id,
im.match_type_code component_type,
decode(im.match_type_code,'CHARGE',im.charge_line_type_id) charge_line_type_id,
decode(im.match_type_code,'TAX',im.tax_code) tax_code,
aia.invoice_num,
sum(decode(im.match_type_code,'TAX',im.nrec_tax_amt,im.matched_amt)*nvl(im.matched_curr_conversion_rate,1)) matched_amt
from
inl_ship_headers_all ish,
inl_matches im,
ap_invoice_distributions_all aida,
ap_invoices_all aia
where
1=1 and
ish.simulation_id is null and
ish.ship_header_id=im.ship_header_id and
im.match_type_code in ('ITEM','CHARGE','TAX') and
im.to_parent_table_name='INL_SHIP_LINES' and
im.from_parent_table_name='AP_INVOICE_DISTRIBUTIONS' and
im.match_id not in (select im2.parent_match_id from inl_matches im2 where im2.parent_match_id is not null) and
im.from_parent_table_id=aida.invoice_distribution_id and
aida.invoice_id=aia.invoice_id
group by
im.to_parent_table_id,
im.match_type_code,
decode(im.match_type_code,'CHARGE',im.charge_line_type_id),
decode(im.match_type_code,'TAX',im.tax_code),
aia.invoice_num
) y
group by
y.ship_line_id,
y.component_type,
y.charge_line_type_id,
y.tax_code
) m,
inl_ship_headers_all ish,
inl_ship_lines_all isl,
inl_ship_line_groups islg,
hr_all_organization_units_vl haouv,
mtl_parameters mp,
org_organization_definitions ood,
gl_ledgers gl,
mtl_system_items_vl msiv,
ap_suppliers aps,
po_line_locations_all plla,
po_lines_all pla,
po_headers_all pha,
rcv_shipment_lines rsl,
rcv_shipment_headers rsh,
pon_cost_factors_vl pcfv,
hz_parties hp
where
3=3 and
x.ship_line_id=m.ship_line_id(+) and
x.component_type=m.component_type(+) and
nvl(x.charge_line_type_id,-1)=nvl(m.charge_line_type_id(+),-1) and
nvl(x.tax_code,'x')=nvl(m.tax_code(+),'x') and
x.ship_header_id=ish.ship_header_id and
x.ship_line_id=isl.ship_line_id and
isl.ship_line_group_id=islg.ship_line_group_id and
ish.org_id=haouv.organization_id and
ish.organization_id=mp.organization_id and
ish.organization_id=ood.organization_id and
ood.set_of_books_id=gl.ledger_id and
isl.inventory_item_id=msiv.inventory_item_id and
ish.organization_id=msiv.organization_id and
islg.party_id=aps.party_id(+) and
decode(isl.ship_line_src_type_code,'PO',isl.ship_line_source_id)=plla.line_location_id(+) and
plla.po_line_id=pla.po_line_id(+) and
plla.po_header_id=pha.po_header_id(+) and
isl.ship_line_id=rsl.lcm_shipment_line_id(+) and
rsl.shipment_header_id=rsh.shipment_header_id(+) and
x.charge_line_type_id=pcfv.price_element_type_id(+) and
x.party_id=hp.party_id(+)
order by
haouv.name,
mp.organization_code,
ish.ship_date,
ish.ship_num,
isl.ship_line_num,
decode(x.component_type,'ITEM',1,'CHARGE',2,3),
component
