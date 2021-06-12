/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ONT Order Headers
-- Description: Detail Sales Order or Quote header report, including status, amount and invoice status information.
-- Excel Examle Output: https://www.enginatics.com/example/ont-order-headers/
-- Library Link: https://www.enginatics.com/reports/ont-order-headers/
-- Run Report: https://demo.enginatics.com/

select
x.operating_unit,
x.customer,
x.account_number,
x.order_number,
x.quote_number,
x.source_type,
x.source_document,
x.type,
x.order_type,
x.customer_po,
hp1.party_name ship_to_customer,
hca1.account_number ship_to_account,
hcsua1.location ship_to_location,
(select hz_format_pub.format_address(hps1.location_id,null,null,' , ') from dual) ship_to_address,
ftv1.territory_short_name ship_to_country,
hp2.party_name bill_to_customer,
hca2.account_number bill_to_account,
hcsua2.location bill_to_location,
(select hz_format_pub.format_address(hps2.location_id,null,null,' , ') from dual) bill_to_address,
ftv2.territory_short_name bill_to_country,
x.ordered_date,
x.price_list,
x.salesperson,
x.invoice_salesperson,
x.order_source,
x.order_source_reference,
x.header_status,
x.currency,
x.subtotal,
x.tax,
nvl(x.line_charges_total,0)+nvl(x.header_charges,0) charges,
nvl(x.subtotal,0)+nvl(x.tax,0)+nvl(x.line_charges_total,0)+nvl(x.header_charges,0) total,
x.payment_terms,
x.invoice_number,
x.invoice_date,
x.invoice_status,
x.invoiced_amount,
x.warehouse,
x.ship_method,
x.line_set,
x.freight_terms,
x.fob,
x.shipment_priority,
x.shipping_instructions,
x.packing_instructions,
x.quantity,
x.uom,
x.extended_price,
x.line_charges,
x.tax_code,
x.tax_amount,
x.request_date,
x.promise_date,
x.schedule_ship_date,
x.actual_shipment_date,
x.shipped_quantity,
x.shippable_flag,
x.order_category,
x.created_by,
x.creation_date,
x.last_updated_by,
x.last_update_date,
x.header_id
from
(
select distinct
haouv.name operating_unit,
hp.party_name customer,
hca.account_number,
ooha.order_number,
nvl(ooha.quote_number,regexp_substr(ooha.orig_sys_document_ref,'^(\d+).',1,1,null,1)) quote_number,
decode(ooha.source_document_type_id,10,'Requisitions',2,'Orders',16,'Quotes',7,'Incidents',(select oos0.name from oe_order_sources oos0 where ooha.source_document_type_id=oos0.order_source_id)) source_type,
case ooha.source_document_type_id
when 10 then (select prha.segment1 from po_requisition_headers_all prha where ooha.source_document_id=prha.requisition_header_id)
when 2 then (select to_char(ooha0.order_number) from oe_order_headers_all ooha0 where ooha.source_document_id=ooha0.header_id)
when 16 then (select aqha.quote_number||':'||aqha.quote_version from aso_quote_headers_all aqha where ooha.source_document_id=aqha.quote_header_id)
when 7 then (select ciab.incident_number from cs_incidents_all_b ciab where ooha.source_document_id=ciab.incident_id)
end source_document,
decode(ooha.transaction_phase_code,'N','Quote','Order') type,
ottt.name order_type,
nvl(oola.cust_po_number,ooha.cust_po_number) customer_po,
xxen_util.client_time(ooha.ordered_date) ordered_date,
(select qlhv.name from qp_list_headers_vl qlhv where ooha.price_list_id=qlhv.list_header_id) price_list,
jrrev.resource_name salesperson,
max(jrrev2.resource_name) keep (dense_rank last order by rcta.customer_trx_id) over (partition by oola.header_id) invoice_salesperson,
oos.name order_source,
ooha.orig_sys_document_ref order_source_reference,
xxen_util.meaning(ooha.flow_status_code,'FLOW_STATUS',660) header_status,
ooha.transactional_curr_code currency,
sum(decode(oola.cancelled_flag,'N',oola.extended_price)) over (partition by oola.header_id) subtotal,
sum(decode(oola.cancelled_flag,'N',oola.tax_amount)) over (partition by oola.header_id) tax,
sum(decode(oola.cancelled_flag,'N',oola.line_charges)) over (partition by oola.header_id) line_charges_total,
(select sum(decode(opa.credit_or_charge_flag,'C',-1,1)*opa.operand) from oe_price_adjustments opa where ooha.header_id=opa.header_id and opa.line_id is null and opa.list_line_type_code='FREIGHT_CHARGE' and opa.applied_flag='Y') header_charges,
(select rtv.name from ra_terms_vl rtv where ooha.payment_term_id=rtv.term_id) payment_terms,
max(rcta.trx_number) keep (dense_rank last order by rcta.customer_trx_id) over (partition by oola.header_id) invoice_number,
max(rcta.trx_date) keep (dense_rank last order by rcta.customer_trx_id) over (partition by oola.header_id) invoice_date,
xxen_util.meaning(max(rcta.status_trx) keep (dense_rank last order by rcta.customer_trx_id) over (partition by oola.header_id),'PAYMENT_SCHEDULE_STATUS',222) invoice_status,
sum(rctla.extended_amount) over (partition by oola.header_id) invoiced_amount,
(select mp.organization_code from mtl_parameters mp where ooha.ship_from_org_id=mp.organization_id) warehouse,
xxen_util.meaning(ooha.shipping_method_code,'SHIP_METHOD',3) ship_method,
xxen_util.meaning(ooha.customer_preference_set_code,'REQUEST_DATE_TYPE',660) line_set,
xxen_util.meaning(ooha.freight_terms_code,'FREIGHT_TERMS',660) freight_terms,
xxen_util.meaning(ooha.fob_point_code,'FOB',222) fob,
xxen_util.meaning(ooha.shipment_priority_code,'SHIPMENT_PRIORITY',660) shipment_priority,
ooha.shipping_instructions,
ooha.packing_instructions,
sum(oola.ordered_quantity) over (partition by oola.header_id) quantity,
max(oola.order_quantity_uom) over (partition by oola.header_id) uom,
sum(oola.extended_price) over (partition by oola.header_id) extended_price,
sum(oola.line_charges) over (partition by oola.header_id) line_charges,
max(oola.tax_code) over (partition by oola.header_id) tax_code,
sum(oola.tax_amount) over (partition by oola.header_id) tax_amount,
xxen_util.client_time(min(oola.request_date) over (partition by oola.header_id)) request_date,
xxen_util.client_time(min(oola.promise_date) over (partition by oola.header_id)) promise_date,
xxen_util.client_time(min(oola.schedule_ship_date) over (partition by oola.header_id)) schedule_ship_date,
xxen_util.client_time(min(oola.actual_shipment_date) over (partition by oola.header_id)) actual_shipment_date,
sum(oola.shipped_quantity) over (partition by oola.header_id) shipped_quantity,
xxen_util.meaning(decode(max(oola.shippable_flag) over (partition by oola.header_id),'Y','Y'),'YES_NO',0) shippable_flag,
xxen_util.meaning(ooha.order_category_code,'ORDER_CATEGORY',660) order_category,
xxen_util.user_name(ooha.created_by) created_by,
xxen_util.client_time(ooha.creation_date) creation_date,
xxen_util.user_name(ooha.last_updated_by) last_updated_by,
xxen_util.client_time(ooha.last_update_date) last_update_date,
ooha.header_id,
ooha.ship_to_org_id,
ooha.invoice_to_org_id
from
hr_all_organization_units_vl haouv,
oe_order_headers_all ooha,
(
select
decode(oola.line_category_code,'RETURN',-1,1)*oola.unit_selling_price*oola.ordered_quantity extended_price,
decode(oola.line_category_code,'RETURN',-1,1)*oola.tax_value tax_amount,
(
select
sum(decode(opa.credit_or_charge_flag,'C',-1,1)*decode(opa.arithmetic_operator,'LUMPSUM',case when oola.ordered_quantity>0 then opa.operand end,oola.ordered_quantity*opa.adjusted_amount)) line_charges
from
oe_price_adjustments opa
where
oola.line_id=opa.line_id and
opa.list_line_type_code='FREIGHT_CHARGE' and
opa.applied_flag='Y'
) line_charges,
max(oola.open_flag) over (partition by oola.header_id) max_open_flag,
oola.*
from
oe_order_lines_all oola
) oola,
oe_transaction_types_tl ottt,
hz_cust_accounts hca,
hz_parties hp,
oe_order_sources oos,
jtf_rs_salesreps jrs,
jtf_rs_salesreps jrs2,
jtf_rs_resource_extns_vl jrrev,
jtf_rs_resource_extns_vl jrrev2,
ra_customer_trx_lines_all rctla,
ra_customer_trx_all rcta
where
1=1 and
haouv.organization_id=ooha.org_id and
ooha.sold_to_org_id=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
ooha.order_type_id=ottt.transaction_type_id(+) and
ottt.language(+)=userenv('lang') and
ooha.order_source_id=oos.order_source_id(+) and
ooha.header_id=oola.header_id(+) and
ooha.salesrep_id=jrs.salesrep_id(+) and
ooha.org_id=jrs.org_id(+) and
jrs.resource_id=jrrev.resource_id(+) and
to_char(oola.line_id)=rctla.interface_line_attribute6(+) and
rctla.interface_line_context(+) in ('INTERCOMPANY','ORDER ENTRY') and
rctla.customer_trx_id=rcta.customer_trx_id(+) and
rcta.primary_salesrep_id=jrs2.salesrep_id(+) and
rcta.org_id=jrs2.org_id(+) and
jrs2.resource_id=jrrev2.resource_id(+)
) x,
hz_cust_site_uses_all hcsua1,
hz_cust_site_uses_all hcsua2,
hz_cust_acct_sites_all hcasa1,
hz_cust_acct_sites_all hcasa2,
hz_cust_accounts hca1,
hz_cust_accounts hca2,
hz_parties hp1,
hz_parties hp2,
hz_party_sites hps1,
hz_party_sites hps2,
hz_locations hl1,
hz_locations hl2,
fnd_territories_vl ftv1,
fnd_territories_vl ftv2
where
x.ship_to_org_id=hcsua1.site_use_id(+) and
x.invoice_to_org_id=hcsua2.site_use_id(+) and
hcsua1.cust_acct_site_id=hcasa1.cust_acct_site_id(+) and
hcsua2.cust_acct_site_id=hcasa2.cust_acct_site_id(+) and
hcasa1.cust_account_id=hca1.cust_account_id(+) and
hcasa2.cust_account_id=hca2.cust_account_id(+) and
hca1.party_id=hp1.party_id(+) and
hca2.party_id=hp2.party_id(+) and
hcasa1.party_site_id=hps1.party_site_id(+) and
hcasa2.party_site_id=hps2.party_site_id(+) and
hps1.location_id=hl1.location_id(+) and
hps2.location_id=hl2.location_id(+) and
hl1.country=ftv1.territory_code(+) and
hl2.country=ftv2.territory_code(+)
order by
x.operating_unit,
x.account_number,
x.order_number