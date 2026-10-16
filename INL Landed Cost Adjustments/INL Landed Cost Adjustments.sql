/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INL Landed Cost Adjustments
-- Description: Landed cost adjustments processed by Cost Management, with the receiving accounting they generated.
-- One row per accounting line of each adjustment: the adjustment of the receipt (Receiving Inspection against Landed Cost Absorption) and, for delivered quantities, the adjustment of the delivery (Purchase Price Variance in a standard cost organization, otherwise the inventory or expense account). Adjustment Value, the unit landed cost change times the receipt quantity, is shown on the first row of each adjustment only, so that it can be summed.
-- Adjustments still pending or in error in the interface are listed by CAC Interface Error Summary.
-- Excel Example Output: https://www.enginatics.com/example/inl-landed-cost-adjustments/
-- Library Link: https://www.enginatics.com/reports/inl-landed-cost-adjustments/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
mp.organization_code,
clat.transaction_date,
msiv.concatenated_segments item,
msiv.description item_description,
ish.ship_num shipment_number,
isl.ship_line_num shipment_line,
pha.segment1 po_number,
pla.line_num po_line,
rsh.receipt_num,
rt.primary_quantity receipt_quantity,
rt.primary_unit_of_measure uom,
gl.currency_code,
clat.prior_landed_cost prior_unit_landed_cost,
clat.new_landed_cost new_unit_landed_cost,
clat.new_landed_cost-clat.prior_landed_cost unit_landed_cost_change,
decode(row_number() over (partition by clat.transaction_id order by rae.accounting_event_id, rrsl.rcv_sub_ledger_id),1,(clat.new_landed_cost-clat.prior_landed_cost)*rt.primary_quantity) adjustment_value,
(select xetv.name from rcv_accounting_event_types raet, xla_event_types_vl xetv where rae.event_type_id=raet.event_type_id and raet.event_type_name=xetv.event_type_code and xetv.application_id=707) event_type,
rae.primary_quantity event_quantity,
rrsl.accounting_date,
rrsl.period_name,
rrsl.accounting_line_type,
gcck.concatenated_segments account,
xxen_util.segments_description(gcck.code_combination_id) account_description,
rrsl.accounted_dr,
rrsl.accounted_cr,
nvl(rrsl.accounted_dr,0)-nvl(rrsl.accounted_cr,0) accounted_net,
clat.transaction_id
from
cst_lc_adj_transactions clat,
rcv_transactions rt,
rcv_shipment_headers rsh,
inl_ship_lines_all isl,
inl_ship_headers_all ish,
po_lines_all pla,
po_headers_all pha,
hr_all_organization_units_vl haouv,
mtl_parameters mp,
org_organization_definitions ood,
gl_ledgers gl,
mtl_system_items_vl msiv,
rcv_accounting_events rae,
rcv_receiving_sub_ledger rrsl,
gl_code_combinations_kfv gcck
where
1=1 and
clat.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
clat.rcv_transaction_id=rt.transaction_id and
rt.shipment_header_id=rsh.shipment_header_id and
rt.lcm_shipment_line_id=isl.ship_line_id(+) and
isl.ship_header_id=ish.ship_header_id(+) and
rt.po_line_id=pla.po_line_id(+) and
rt.po_header_id=pha.po_header_id(+) and
ood.operating_unit=haouv.organization_id and
clat.organization_id=mp.organization_id and
clat.organization_id=ood.organization_id and
ood.set_of_books_id=gl.ledger_id and
clat.inventory_item_id=msiv.inventory_item_id and
clat.organization_id=msiv.organization_id and
clat.transaction_id=rae.event_source_id(+) and
rae.event_source(+)='LC_ADJUSTMENTS' and
rae.accounting_event_id=rrsl.accounting_event_id(+) and
rrsl.code_combination_id=gcck.code_combination_id(+)
order by
haouv.name,
mp.organization_code,
clat.transaction_date,
clat.transaction_id,
rae.accounting_event_id,
rrsl.rcv_sub_ledger_id
