/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Internal Requisitions and Sales Orders
-- Description: Report to display internal sales orders and requisition numbers, with aging dates and other useful information.
-- Excel Examle Output: https://www.enginatics.com/example/po-internal-requisitions-and-sales-orders/
-- Library Link: https://www.enginatics.com/reports/po-internal-requisitions-and-sales-orders/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv.name operating_unit,
mp.organization_code ship_from_org,
mp2.organization_code ship_to_org,
msiv.concatenated_segments item,
msiv.description item_description,
muomv.uom_code uom_code,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
misv.inventory_item_status_code item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_or_buy,
&category_columns
hp.party_name customer,
hca.account_number customer_number,
ooha.order_number sales_order_number,
rtrim(oola.line_number||'.'||oola.shipment_number||'.'||oola.option_number||'.'||oola.component_number||'.'||oola.service_number,'.') sales_order_line,
xxen_util.yes(oola.open_flag) open,
ooha.orig_sys_document_ref requisition_number,
xxen_util.meaning(prha.type_lookup_code,'REQUISITION TYPE',201) requisition_type,
ottt.name order_type,
oola.flow_status_code status,
hp.address1 address_line_1,
hp.address2 address_line_2,
hcsua.location location_number,
hl.city,
hl.state,
hl.county,
hl.country,
nvl(msiv.preprocessing_lead_time,0) supp_preprocessing_lead_time,
nvl(msiv.full_lead_time,0) supp_processing_lead_time,
nvl(msiv.postprocessing_lead_time,0) supp_postprocessing_lead_time,
nvl(msiv.fixed_lead_time,0) supp_fixed_lead_time,
nvl(msiv.variable_lead_time,0) supp_variable_lead_time,
nvl(msiv.cum_manufacturing_lead_time,0) supp_cum_mfg_lead_time,
nvl(msiv.cumulative_total_lead_time,0) supp_cum_total_lead_time,
nvl(msiv.lead_time_lot_size,0) supp_lead_time_lot_size,
xxen_util.meaning(oola.shipping_method_code,'SHIP_METHOD',3) shipping_method_code,
nvl(
(
select mism.intransit_time 
from 
mtl_interorg_ship_methods mism 
where
mism.from_organization_id=oola.ship_from_org_id and 
mism.to_organization_id=prla.destination_organization_id and 
mism.ship_method=oola.shipping_method_code
),0) transit_lead_time,
nvl(msiv_to.preprocessing_lead_time,0) cust_preprocessing_lead_time,
nvl(msiv_to.full_lead_time,0) cust_processing_lead_time,
nvl(msiv_to.postprocessing_lead_time,0) cust_postprocessing_lead_time,
nvl(msiv_to.fixed_lead_time,0) cust_fixed_lead_time,
nvl(msiv_to.variable_lead_time,0) cust_variable_lead_time,
nvl(msiv_to.cum_manufacturing_lead_time,0) cust_cum_mfg_lead_time,
nvl(msiv_to.cumulative_total_lead_time,0) cust_cum_total_lead_time,
nvl(msiv_to.lead_time_lot_size,0) cust_lead_time_lot_size,
xxen_util.client_time(prla.need_by_date) need_by_date,
xxen_util.client_time(oola.request_date) request_date,
xxen_util.client_time(oola.promise_date) promise_date,
xxen_util.client_time(oola.schedule_ship_date) schedule_ship_date,
xxen_util.client_time(oola.schedule_arrival_date) schedule_arrival_date,
xxen_util.client_time(oola.actual_shipment_date) actual_shipment_date,
xxen_util.client_time((select min(rt.transaction_date) from rcv_transactions rt where prla.requisition_line_id=rt.requisition_line_id)) receipt_date,
trunc(sysdate-ooha.request_date) days_outstanding,
case
when sysdate-ooha.request_date<31  then '30 days'
when sysdate-ooha.request_date<61  then '31 to 60 days'
when sysdate-ooha.request_date<91  then '61 to 90 days'
when sysdate-ooha.request_date<121 then '91 to 120 days'
when sysdate-ooha.request_date<151 then '121 to 150 days'
when sysdate-ooha.request_date<181 then '151 to 180 days'
else 'Over 180 days'
end aging_date,
oola.order_quantity_uom order_uom,
oola.ordered_quantity,
oola.shipped_quantity,
decode(oola.cancelled_flag,'Y',oola.cancelled_quantity) cancelled_quantity,
gl.currency_code,
cic.item_cost unit_cost,
xxen_util.meaning(nvl(oola.freight_terms_code,ooha.freight_terms_code),'FREIGHT_TERMS',660) freight_terms,
xxen_util.meaning(nvl(oola.fob_point_code,ooha.fob_point_code),'FOB',222) fob,
round(oola.ordered_quantity*cic.item_cost,2) cogs_amount,
xxen_util.user_name(prha.created_by) ir_created_by,
xxen_util.client_time(prha.creation_date) ir_creation_date,
xxen_util.user_name(prha.last_updated_by) ir_last_updated_by,
xxen_util.client_time(prha.last_update_date) ir_last_update_date,
xxen_util.user_name(oola.created_by) so_created_by,
xxen_util.client_time(oola.creation_date) so_creation_date,
xxen_util.user_name(oola.last_updated_by) so_last_updated_by,
xxen_util.client_time(oola.last_update_date) so_last_update_date
from
po_requisition_lines_all prla,
po_requisition_headers_all prha,
mtl_parameters mp2,
oe_order_lines_all oola,
oe_order_headers_all ooha,
oe_transaction_types_tl ottt,
org_organization_definitions ood,
hr_all_organization_units_vl haouv,
mtl_parameters mp,
gl_ledgers gl,
mtl_system_items_vl msiv,
mtl_item_status_vl misv,
mtl_units_of_measure_vl muomv,
cst_item_costs cic,
hz_cust_accounts hca,
hz_parties hp,
hz_cust_site_uses_all hcsua,
hz_cust_acct_sites_all hcasa,
hz_party_sites hps,
hz_locations hl,
mtl_system_items_vl msiv_to
where
1=1 and
(
prla.destination_organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) or
oola.ship_from_org_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
) and
nvl(:organization_type,'Either')=nvl(:organization_type,'Either') and
prla.requisition_header_id=prha.requisition_header_id and
prla.destination_organization_id=mp2.organization_id and
prla.requisition_line_id=oola.source_document_line_id and
oola.source_document_type_id=10 and --internal requisitions
oola.order_source_id=10 and --internal requisitions
oola.line_category_code='ORDER' and
oola.header_id=ooha.header_id and
oola.line_type_id=ottt.transaction_type_id and
ottt.language=userenv('lang') and
oola.ship_from_org_id=ood.organization_id and
sysdate<nvl(ood.disable_date,sysdate+1) and --only active orgs
ood.operating_unit=haouv.organization_id and
ood.set_of_books_id=gl.ledger_id and
oola.ship_from_org_id=mp.organization_id and
oola.inventory_item_id=msiv.inventory_item_id and
oola.ship_from_org_id=msiv.organization_id and
msiv.inventory_item_status_code=misv.inventory_item_status_code and
msiv.primary_uom_code=muomv.uom_code and
msiv.inventory_item_id=cic.inventory_item_id and
msiv.organization_id=cic.organization_id and
mp.primary_cost_method=cic.cost_type_id and
oola.sold_to_org_id=hca.cust_account_id and
hca.party_id=hp.party_id and
oola.ship_to_org_id=hcsua.site_use_id and
hcsua.cust_acct_site_id=hcasa.cust_acct_site_id and
hcasa.party_site_id=hps.party_site_id and
hps.location_id=hl.location_id and
prla.item_id=msiv_to.inventory_item_id(+) and
prla.destination_organization_id=msiv_to.organization_id(+)
order by
nvl(gl.short_name,gl.name),
operating_unit,
mp.organization_code,
mp2.organization_code,
msiv.concatenated_segments,
hp.party_name,
ooha.order_number,
oola.line_number