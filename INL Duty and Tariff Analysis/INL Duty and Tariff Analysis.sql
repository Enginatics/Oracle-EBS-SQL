/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INL Duty and Tariff Analysis
-- Description: Duty, other charges and taxes per landed cost shipment line, with tariff code, country of origin and supplier, to analyse duty rates and the landed cost uplift on the item value.
-- The charge types counted as duty are selected in the Duty Charge Type parameter, all other charges are Other Charges. Amounts are the current landed cost allocations in functional currency, Duty Estimated the first calculation. LCM allocates a charge to the shipment lines by the charge type's allocation basis, so an actual duty invoice matched to the shipment is spread over its lines, and the duty rate per line reflects that allocation rather than the customs entry line.
-- Oracle has no standard HTS field: the tariff code is the item's category in the Tariff Code Category Set, an item category set holding the HTS codes.
-- Excel Example Output: https://www.enginatics.com/example/inl-duty-and-tariff-analysis/
-- Library Link: https://www.enginatics.com/reports/inl-duty-and-tariff-analysis/
-- Run Report: https://demo.enginatics.com/

select
y.*
from
(
select
haouv.name operating_unit,
mp.organization_code,
ish.ship_num shipment_number,
ish.ship_date shipment_date,
isl.ship_line_num shipment_line,
aps.vendor_name supplier,
(select ftv.territory_short_name from fnd_territories_vl ftv where nvl(rsl.country_of_origin_code,plla.country_of_origin_code)=ftv.territory_code) country_of_origin,
(
select
max(mck.concatenated_segments)
from
mtl_category_sets_vl mcsv,
mtl_item_categories mic,
mtl_categories_kfv mck
where
mcsv.category_set_name=:tariff_code_category_set and
mcsv.category_set_id=mic.category_set_id and
isl.inventory_item_id=mic.inventory_item_id and
ish.organization_id=mic.organization_id and
mic.category_id=mck.category_id
) tariff_code,
pha.segment1 po_number,
pla.line_num po_line,
rsh.receipt_num,
msiv.concatenated_segments item,
msiv.description item_description,
isl.primary_qty quantity,
isl.primary_uom_code uom,
gl.currency_code,
z.item_value,
z.duty_estimated,
z.duty,
z.duty-z.duty_estimated duty_variance,
round(100*z.duty/nullif(z.item_value,0),2) duty_rate_percent,
z.duty/nullif(isl.primary_qty,0) duty_per_unit,
xxen_util.yes(z.duty_matched) duty_matched,
z.other_charges,
z.taxes,
z.item_value+z.duty+z.other_charges+z.taxes landed_cost,
(z.item_value+z.duty+z.other_charges+z.taxes)/nullif(isl.primary_qty,0) unit_landed_cost,
round(100*(z.duty+z.other_charges+z.taxes)/nullif(z.item_value,0),2) landed_cost_uplift_percent
from
(
select
x.ship_header_id,
x.ship_line_id,
sum(decode(x.component_type,'ITEM',x.current_amt,0)) item_value,
sum(case when x.component_type='CHARGE' and 4=4 then x.estimated_amt else 0 end) duty_estimated,
sum(case when x.component_type='CHARGE' and 4=4 then x.current_amt else 0 end) duty,
max(case when x.component_type='CHARGE' and 4=4 then x.matched end) duty_matched,
sum(decode(x.component_type,'CHARGE',x.current_amt,0))-sum(case when x.component_type='CHARGE' and 4=4 then x.current_amt else 0 end) other_charges,
sum(decode(x.component_type,'TAX',x.current_amt,0)) taxes
from
(
select
w.*,
case when w.charge_line_type_id in (
select
im.charge_line_type_id
from
inl_matches im
where
w.ship_header_id=im.ship_header_id and
w.ship_line_id=im.to_parent_table_id and
im.match_type_code='CHARGE' and
im.to_parent_table_name='INL_SHIP_LINES'
) then 'Y' end matched
from
(
select
ia.ship_header_id,
nvl(isl.parent_ship_line_id,isl.ship_line_id) ship_line_id,
decode(ia.from_parent_table_name,'INL_SHIP_LINES','ITEM','INL_CHARGE_LINES','CHARGE','INL_TAX_LINES','TAX') component_type,
icl.charge_line_type_id,
pcfv.name charge_type,
sum(decode(ia.adjustment_num,0,ia.allocation_amt,0)) estimated_amt,
sum(decode(ia.adjustment_num,ish.adjustment_num,ia.allocation_amt,0)) current_amt
from
inl_ship_headers_all ish,
inl_allocations ia,
inl_ship_lines_all isl,
inl_charge_lines icl,
pon_cost_factors_vl pcfv
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
icl.charge_line_type_id=pcfv.price_element_type_id(+)
group by
ia.ship_header_id,
nvl(isl.parent_ship_line_id,isl.ship_line_id),
ia.from_parent_table_name,
icl.charge_line_type_id,
pcfv.name
) w
) x
group by
x.ship_header_id,
x.ship_line_id
) z,
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
rcv_shipment_headers rsh
where
3=3 and
z.ship_header_id=ish.ship_header_id and
z.ship_line_id=isl.ship_line_id and
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
rsl.shipment_header_id=rsh.shipment_header_id(+)
) y
where
5=5
order by
y.operating_unit,
y.organization_code,
y.shipment_date,
y.shipment_number,
y.shipment_line
