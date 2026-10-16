/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INL Pending Actual Charges
-- Description: Estimated landed cost charges per shipment line, charge type and charging party that no AP invoice has been matched to yet, aged by shipment date at the As of Date. It lists the freight, duty and brokerage invoices still to be received and the accrual exposure they carry.
-- Estimated Amount is the current estimate in functional currency, including estimate changes made after the shipment was submitted, and Original Estimated Amount the first calculation. A charge type stops being pending on a receipt line once any invoice of that type is matched to it, whatever the amount.
-- A charge invoice that Payables has matched but that has not reached the shipment yet, because it is still in the LCM matches interface or failed there, shows its amount, interface status and invoice number in the Interface columns. Such a charge stays pending until the Landed Cost Management matches import has processed it.
-- Shipment lines closed for matching are excluded unless Include Closed for Matching is set.
-- Excel Example Output: https://www.enginatics.com/example/inl-pending-actual-charges/
-- Library Link: https://www.enginatics.com/reports/inl-pending-actual-charges/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
mp.organization_code,
hp.party_name charging_party,
pcfv.name charge_type,
ish.ship_num shipment_number,
ish.ship_date shipment_date,
xxen_util.meaning(ish.ship_status_code,'INL_SHIP_STATUSES',0) shipment_status,
rsh.receipt_num,
(select min(rt.transaction_date) from rcv_transactions rt where rsl.shipment_line_id=rt.shipment_line_id and rt.transaction_type='RECEIVE') receipt_date,
trunc(:as_of_date)-trunc(ish.ship_date) age_days,
case
when trunc(:as_of_date)-trunc(ish.ship_date)<=30 then '0-30'
when trunc(:as_of_date)-trunc(ish.ship_date)<=60 then '31-60'
when trunc(:as_of_date)-trunc(ish.ship_date)<=90 then '61-90'
when trunc(:as_of_date)-trunc(ish.ship_date)<=180 then '91-180'
else '181+'
end aging_bucket,
isl.ship_line_num shipment_line,
aps.vendor_name supplier,
pha.segment1 po_number,
pla.line_num po_line,
msiv.concatenated_segments item,
msiv.description item_description,
isl.primary_qty quantity,
isl.primary_uom_code uom,
gl.currency_code,
x.current_amt estimated_amount,
x.estimated_amt original_estimated_amount,
mi.interface_amt interface_matched_amount,
xxen_util.meaning(mi.processing_status_code,'INL_PROCESSING_STATUS',0) interface_status,
mi.invoice_numbers interface_invoice_numbers,
xxen_util.yes(isl.closed_for_matching_flag) closed_for_matching,
xxen_util.yes(ish.pending_matching_flag) shipment_pending_matching
from
(
select
ia.ship_header_id,
nvl(isl.parent_ship_line_id,isl.ship_line_id) ship_line_id,
icl.charge_line_type_id,
sum(decode(ia.adjustment_num,0,ia.allocation_amt,0)) estimated_amt,
sum(decode(ia.adjustment_num,ish.adjustment_num,ia.allocation_amt,0)) current_amt,
max(icl.party_id) keep (dense_rank last order by ia.adjustment_num) party_id
from
inl_ship_headers_all ish,
inl_allocations ia,
inl_ship_lines_all isl,
inl_charge_lines icl
where
1=1 and
2=2 and
ish.simulation_id is null and
ish.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
ish.ship_header_id=ia.ship_header_id and
ia.adjustment_num in (0,ish.adjustment_num) and
ia.landed_cost_flag='Y' and
ia.from_parent_table_name='INL_CHARGE_LINES' and
ia.ship_line_id=isl.ship_line_id and
ia.from_parent_table_id=icl.charge_line_id
group by
ia.ship_header_id,
nvl(isl.parent_ship_line_id,isl.ship_line_id),
icl.charge_line_type_id
) x,
(
select
y.ship_line_id,
y.charge_line_type_id,
sum(y.matched_amt) interface_amt,
max(y.processing_status_code) processing_status_code,
listagg(y.invoice_num,', ') within group (order by y.invoice_num) invoice_numbers
from
(
select
nvl(rt.lcm_shipment_line_id,decode(imi.to_parent_table_name,'INL_SHIP_LINES',imi.to_parent_table_id)) ship_line_id,
imi.charge_line_type_id,
aia.invoice_num,
max(imi.processing_status_code) processing_status_code,
sum(imi.matched_amt*nvl(imi.matched_curr_conversion_rate,1)) matched_amt
from
inl_matches_int imi,
rcv_transactions rt,
ap_invoice_distributions_all aida,
ap_invoices_all aia
where
imi.match_type_code='CHARGE' and
imi.from_parent_table_name='AP_INVOICE_DISTRIBUTIONS' and
imi.from_parent_table_id not in (select im.from_parent_table_id from inl_matches im where im.from_parent_table_name='AP_INVOICE_DISTRIBUTIONS') and
decode(imi.to_parent_table_name,'RCV_TRANSACTIONS',imi.to_parent_table_id)=rt.transaction_id(+) and
imi.from_parent_table_id=aida.invoice_distribution_id(+) and
aida.invoice_id=aia.invoice_id(+)
group by
nvl(rt.lcm_shipment_line_id,decode(imi.to_parent_table_name,'INL_SHIP_LINES',imi.to_parent_table_id)),
imi.charge_line_type_id,
aia.invoice_num
) y
group by
y.ship_line_id,
y.charge_line_type_id
) mi,
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
x.current_amt<>0 and
(x.ship_line_id,x.charge_line_type_id) not in
(
select
im.to_parent_table_id,
im.charge_line_type_id
from
inl_matches im
where
im.ship_header_id=x.ship_header_id and
im.match_type_code='CHARGE' and
im.to_parent_table_name='INL_SHIP_LINES'
) and
(nvl(isl.closed_for_matching_flag,'N')='N' or :include_closed_for_matching='Y') and
x.ship_line_id=mi.ship_line_id(+) and
x.charge_line_type_id=mi.charge_line_type_id(+) and
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
hp.party_name,
pcfv.name,
ish.ship_date,
ish.ship_num,
isl.ship_line_num
