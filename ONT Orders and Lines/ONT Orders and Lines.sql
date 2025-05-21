/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ONT Orders and Lines
-- Description: Detail Sales Order or Quote header report with line item details including status, cost, project and shipping information.
-- Excel Examle Output: https://www.enginatics.com/example/ont-orders-and-lines/
-- Library Link: https://www.enginatics.com/reports/ont-orders-and-lines/
-- Run Report: https://demo.enginatics.com/

select
x.operating_unit,
x.customer,
x.customer_number,
x.order_number,
x.quote_number,
x.source_type,
x.source_document,
x.type,
x.order_type,
x.customer_po,
hp1.party_name ship_to_customer,
hca1.account_number ship_to_customer_number,
hcsua1.location ship_to_location,
(select hz_format_pub.format_address(hps1.location_id,null,null,' , ') from dual) ship_to_address,
ftv1.territory_short_name ship_to_country,
coalesce(hcsua1.tax_reference,hp1.tax_reference,hp1.jgzz_fiscal_code) ship_to_tax_reference,
hp2.party_name bill_to_customer,
hca2.account_number bill_to_customer_number,
hcsua2.location bill_to_location,
(select hz_format_pub.format_address(hps2.location_id,null,null,' , ') from dual) bill_to_address,
ftv2.territory_short_name bill_to_country,
coalesce(hcsua2.tax_reference,hp2.tax_reference,hp2.jgzz_fiscal_code) bill_to_tax_reference,
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
nvl(x.line_charges_total,0) + nvl(x.header_charges,0) charges,
nvl(x.subtotal,0) + nvl(x.tax,0) + nvl(x.line_charges_total,0) + nvl(x.header_charges,0) total,
x.payment_terms,
x.invoice_class,
x.invoice_type,
x.invoice_number,
x.invoice_date,
x.invoice_gl_date,
x.invoice_status,
x.invoice_currency,
x.invoice_line,
case when row_number() over (partition by x.line_id order by wnd.name nulls last) = 1 then x.invoice_amount else null end invoice_amount,
case when row_number() over (partition by x.line_id order by wnd.name nulls last) = 1 then x.invoice_accounted_amount else null end invoice_accounted_amount,
x.warehouse,
x.shipping_method,
x.line_set,
x.freight_terms,
x.fob,
x.shipment_priority,
x.shipping_instructions,
x.packing_instructions,
x.payment_type,
x.line,
x.line_type,
x.line_status,
x.cancelled_flag,
x.cancel_date,
x.cancelled_by,
x.cancel_reason,
case when row_number() over (partition by x.line_id order by wnd.name nulls last) = 1 then x.cancelled_quantity else null end cancelled_quantity,
case when row_number() over (partition by x.line_id order by wnd.name nulls last) = 1 then x.cancelled_amount else null end cancelled_amount,
x.item,
x.description,
x.item_type,
&category_columns
x.uom,
x.list_price,
x.discounted_price,
x.unit_selling_price,
case when row_number() over (partition by x.line_id order by wnd.name nulls last) = 1 then x.quantity else null end quantity,
case when row_number() over (partition by x.line_id order by wnd.name nulls last) = 1 then x.extended_price else null end extended_price,
case when row_number() over (partition by x.line_id order by wnd.name nulls last) = 1 then x.line_charges else null end line_charges,
case when row_number() over (partition by x.line_id order by wnd.name nulls last) = 1 then x.tax_amount else null end tax_amount,
x.tax_code,
x.calculate_price_flag,
case when row_number() over (partition by x.line_id order by wnd.name nulls last) = 1 then x.pricing_quantity else null end pricing_quantity,
x.pricing_uom,
x.pricing_date,
x.request_date,
x.promise_date,
x.schedule_ship_date,
x.actual_shipment_date,
case when row_number() over (partition by x.line_id order by wnd.name nulls last) = 1 then x.shipped_quantity else null end shipped_quantity,
x.shippable_flag,
x.ship_set,
wnd.name delivery,
wda.next_step,
x.project,
x.task,
&dff_columns2
x.header_created_by,
x.header_creation_date,
x.header_last_updated_by,
x.header_last_update_date,
x.line_created_by,
x.line_creation_date,
x.line_last_updated_by,
x.line_last_update_date,
x.order_category,
x.line_category,
x.header_id,
x.line_id,
x.line_number,
x.line_days_late,
x.line_quantity_short,
xxen_util.meaning(x.line_shipped_flag,'YES_NO',0) line_shipped,
x.order_date_type_code,
x.split_line,
x.orig_line_id,
x.orig_line_promise_date,
case when row_number() over (partition by x.line_id order by wnd.name nulls last) = 1 and x.line_id = x.orig_line_id then x.orig_line_quantity else null end orig_line_quantity,
x.orig_line_delivery_lead_time,
x.orig_line_actual_shipment_date,
case when row_number() over (partition by x.line_id order by wnd.name nulls last) = 1 and x.line_id = x.orig_line_id then x.orig_line_tot_shipped_quantity else null end orig_line_tot_shipped_quantity,
nvl(xxen_util.meaning(x.deliv_in_full,'YES_NO',0),'N/A') line_dif,
nvl(xxen_util.meaning(x.deliv_on_time,'YES_NO',0),'N/A') line_dot,
nvl(xxen_util.meaning(decode(x.deliv_in_full||x.deliv_on_time,null,null,'YY','Y','N'),'YES_NO',0),'N/A') line_difot,
nvl(xxen_util.meaning(min(x.deliv_in_full) over (partition by x.header_id),'YES_NO',0),'N/A') orders_dif,
nvl(xxen_util.meaning(min(x.deliv_on_time) over (partition by x.header_id),'YES_NO',0),'N/A') orders_dot,
nvl(xxen_util.meaning(decode(min(x.deliv_in_full) over (partition by x.header_id)||min(x.deliv_on_time) over (partition by x.header_id),null,null,'YY','Y','N'),'YES_NO',0),'N/A') orders_difot
from
(
select /*+ push_pred(oolh) push_pred(oolh2) push_pred(wda) */ distinct
haouv.name operating_unit,
hp.party_name customer,
hca.account_number customer_number,
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
max(jrrev2.resource_name) keep (dense_rank last order by rcta.customer_trx_id) over (partition by rctla.interface_line_attribute6) invoice_salesperson,
oos.name order_source,
ooha.orig_sys_document_ref order_source_reference,
xxen_util.meaning(ooha.flow_status_code,'FLOW_STATUS',660) header_status,
ooha.transactional_curr_code currency,
oola.ord_subtotal subtotal,
oola.ord_tax tax,
oola.ord_line_charges_total line_charges_total,
(select sum(decode(opa.credit_or_charge_flag,'C',-1,1)*opa.operand) from oe_price_adjustments opa where ooha.header_id=opa.header_id and opa.line_id is null and opa.list_line_type_code='FREIGHT_CHARGE' and opa.applied_flag='Y') header_charges,
(select rtv.name from ra_terms_vl rtv where nvl(oola.payment_term_id,ooha.payment_term_id)=rtv.term_id) payment_terms,
xxen_util.meaning(max(rctta.type) keep (dense_rank last order by rcta.customer_trx_id) over (partition by rctla.interface_line_attribute6),'INV/CM/ADJ',222) invoice_class,
max(rctta.name) keep (dense_rank last order by rcta.customer_trx_id) over (partition by rctla.interface_line_attribute6) invoice_type,
max(rcta.trx_number) keep (dense_rank last order by rcta.customer_trx_id) over (partition by rctla.interface_line_attribute6) invoice_number,
max(rcta.trx_date) keep (dense_rank last order by rcta.customer_trx_id) over (partition by rctla.interface_line_attribute6) invoice_date,
max(rctlgda0.gl_date) keep (dense_rank last order by rcta.customer_trx_id) over (partition by rctla.interface_line_attribute6) invoice_gl_date,
xxen_util.meaning(max(rcta.status_trx) keep (dense_rank last order by rcta.customer_trx_id) over (partition by rctla.interface_line_attribute6),'PAYMENT_SCHEDULE_STATUS',222) invoice_status,
(select /*+ push_pred(x) */ distinct
 listagg(x.line_number,', ') within group (order by x.line_number) over ()
 from
 (select
  rctla.interface_line_context,
  rctla.interface_line_attribute6,
  rctla.line_number,
  sum(lengthb(rctla.line_number)+2) over (partition by rctla.interface_line_attribute6 order by rctla.line_number rows between unbounded preceding and current row) len
  from
  ra_customer_trx_lines_all rctla
  where
  rctla.line_type != 'FREIGHT'
 ) x
 where
 x.interface_line_context in ('INTERCOMPANY','ORDER ENTRY') and
 x.interface_line_attribute6=to_char(oola.line_id) and
 x.len <= 4000
) invoice_line,
sum(rctla.extended_amount) over (partition by rctla.interface_line_attribute6) invoice_amount,
max(rcta.invoice_currency_code) keep (dense_rank last order by rcta.customer_trx_id) over (partition by rctla.interface_line_attribute6) invoice_currency,
sum(rctlgda.acctd_amount) over (partition by rctla.interface_line_attribute6) invoice_accounted_amount,
(select mp.organization_code from mtl_parameters mp where nvl(oola.ship_from_org_id,ooha.ship_from_org_id)=mp.organization_id) warehouse,
(select wcv.carrier_name from wsh_carriers_v wcv where oola.freight_carrier_code=wcv.freight_code) freight_carrier,
xxen_util.meaning(nvl(oola.shipping_method_code,ooha.shipping_method_code),'SHIP_METHOD',3) shipping_method,
xxen_util.meaning(ooha.customer_preference_set_code,'REQUEST_DATE_TYPE',660) line_set,
xxen_util.meaning(nvl(oola.freight_terms_code,ooha.freight_terms_code),'FREIGHT_TERMS',660) freight_terms,
xxen_util.meaning(nvl(oola.fob_point_code,ooha.fob_point_code),'FOB',222) fob,
xxen_util.meaning(nvl(oola.shipment_priority_code,ooha.shipment_priority_code),'SHIPMENT_PRIORITY',660) shipment_priority,
nvl(oola.shipping_instructions,ooha.shipping_instructions) shipping_instructions,
nvl(oola.packing_instructions,ooha.packing_instructions) packing_instructions,
xxen_util.meaning(nvl(oola.payment_type_code,ooha.payment_type_code),'PAYMENT TYPE',660) payment_type,
rtrim(oola.line_number||'.'||oola.shipment_number||'.'||oola.option_number||'.'||oola.component_number||'.'||oola.service_number,'.') line,
ottt2.name line_type,
xxen_util.meaning(oola.flow_status_code,'LINE_FLOW_STATUS',660) line_status,
msiv.concatenated_segments item,
msiv.description,
xxen_util.meaning(oola.item_type_code,'ITEM_TYPE',660) item_type,
oola.ordered_quantity quantity,
oola.order_quantity_uom uom,
oola.unit_list_price list_price,
oola.discounted_price,
oola.unit_selling_price,
oola.extended_price,
oola.line_charges,
oola.tax_code,
oola.tax_amount,
xxen_util.meaning(oola.calculate_price_flag,'CALCULATE_PRICE_FLAG',660) calculate_price_flag,
oola.pricing_quantity,
oola.pricing_quantity_uom pricing_uom,
oola.pricing_date,
xxen_util.client_time(oola.request_date) request_date,
xxen_util.client_time(oola.promise_date) promise_date,
xxen_util.client_time(oola.schedule_ship_date) schedule_ship_date,
xxen_util.client_time(oola.actual_shipment_date) actual_shipment_date,
oola.shipped_quantity,
xxen_util.meaning(decode(oola.shippable_flag,'Y','Y'),'YES_NO',0) shippable_flag,
(select os.set_name from oe_sets os where oola.ship_set_id=os.set_id) ship_set,
xxen_util.meaning(case when ooha.cancelled_flag='Y' or oola.cancelled_flag='Y' then 'Y' end,'YES_NO',0) cancelled_flag,
xxen_util.client_time(oolh.hist_creation_date) cancel_date,
xxen_util.user_name(oolh.hist_created_by) cancelled_by,
xxen_util.meaning(oer.reason_code,'CANCEL_CODE',660) cancel_reason,
decode(oola.cancelled_flag,'Y',oola.cancelled_quantity) cancelled_quantity,
decode(oola.cancelled_flag,'Y',oola.cancelled_quantity)*oola.unit_selling_price cancelled_amount,
ppa.project_number project,
pt.task_number task,
&dff_columns
xxen_util.user_name(ooha.created_by) header_created_by,
xxen_util.client_time(ooha.creation_date) header_creation_date,
xxen_util.user_name(ooha.last_updated_by) header_last_updated_by,
xxen_util.client_time(ooha.last_update_date) header_last_update_date,
xxen_util.user_name(oola.created_by) line_created_by,
xxen_util.client_time(oola.creation_date) line_creation_date,
xxen_util.user_name(oola.last_updated_by) line_last_updated_by,
xxen_util.client_time(oola.last_update_date) line_last_update_date,
xxen_util.meaning(ooha.order_category_code,'ORDER_CATEGORY',660) order_category,
xxen_util.meaning(oola.line_category_code,'ORDER_CATEGORY',660) line_category,
ooha.header_id,
oola.line_number,
oola.shipment_number,
oola.option_number,
oola.component_number,
oola.service_number,
oola.line_id,
nvl(oola.ship_to_org_id,ooha.ship_to_org_id) ship_to_org_id,
nvl(oola.invoice_to_org_id,ooha.invoice_to_org_id) invoice_to_org_id,
ooha.order_date_type_code,
oola.split_line,
oola.orig_line_id_ orig_line_id,
case
when oola.ordered_quantity<=0 or oola.is_shippable='N' then null
when oola.shipped_quantity<0 then 'Y'
else 'N'
end line_shipped_flag,
case when oola.ordered_quantity>0 and oola.is_shippable='Y' then greatest(trunc(decode(nvl(ooha.order_date_type_code,'SHIP'),'SHIP',nvl(oola.actual_shipment_date,sysdate),nvl(oola.actual_shipment_date,sysdate) + nvl(oola.delivery_lead_time,0)))-trunc(oola.promise_date),0) end line_days_late,
case when oola.ordered_quantity>0 and oola.is_shippable='Y' then greatest(oola.ordered_quantity-nvl(oola.shipped_quantity,0),0) end line_quantity_short,
coalesce(oolh2.delivery_lead_time,oola2.delivery_lead_time,oola.delivery_lead_time,0) orig_line_delivery_lead_time,
xxen_util.client_time(trunc(coalesce(oolh2.promise_date,oola2.promise_date,oola.promise_date))) orig_line_promise_date,
oola.orig_line_quantity,
xxen_util.client_time(trunc(coalesce(oolh2.actual_shipment_date,oola2.actual_shipment_date,oola.actual_shipment_date))) orig_line_actual_shipment_date,
oola.orig_line_tot_shipped_quantity,
case
when oola.orig_line_quantity<=0 or oola.is_shippable='N' then null
when oola.orig_line_quantity<=nvl(oola.orig_line_tot_shipped_quantity,0) then 'Y'
else 'N'
end deliv_in_full,
case
when oola.orig_line_quantity<=0 or oola.is_shippable='N' then null
when trunc(coalesce(oolh2.actual_shipment_date,oola2.actual_shipment_date,oola.actual_shipment_date,coalesce(oolh2.promise_date,oola2.promise_date,oola.promise_date)+1))
     + decode(nvl(ooha.order_date_type_code,'SHIP'),'SHIP',0,nvl(coalesce(oolh2.delivery_lead_time,oola2.delivery_lead_time,oola.delivery_lead_time),0))
     <= trunc(coalesce(oolh2.promise_date,oola2.promise_date,oola.promise_date))
then 'Y'
else 'N'
end deliv_on_time,
oola.inventory_item_id,
oola.ship_from_org_id
from
hr_all_organization_units_vl haouv,
oe_order_headers_all ooha,
(
select
nvl(oola.orig_line_id,oola.line_id) orig_line_id_,
sum(oola.ordered_quantity) over (partition by nvl(oola.orig_line_id,oola.line_id)) orig_line_quantity,
sum(oola.shipped_quantity) over (partition by nvl(oola.orig_line_id,oola.line_id)) orig_line_tot_shipped_quantity,
sum(decode(oola.cancelled_flag,'N',oola.extended_price)) over (partition by oola.header_id) ord_subtotal,
sum(decode(oola.cancelled_flag,'N',oola.tax_amount)) over (partition by oola.header_id) ord_tax,
sum(decode(oola.cancelled_flag,'N',oola.line_charges)) over (partition by oola.header_id) ord_line_charges_total,
oola.*
from
(
select
nvl(
(select sum(decode(opa.credit_or_charge_flag,'C',-1,1)*opa.operand) from oe_price_adjustments opa where oola.line_id=opa.line_id and opa.arithmetic_operator='NEWPRICE' and opa.list_line_type_code='DIS' and opa.applied_flag='Y'), --new price
oola.unit_list_price-
nvl(oola.unit_list_price*(select sum(decode(opa.credit_or_charge_flag,'C',-1,1)*opa.operand)/100 from oe_price_adjustments opa where oola.line_id=opa.line_id and opa.arithmetic_operator='%' and opa.list_line_type_code='DIS' and opa.applied_flag='Y'),0)- --percentage discount
nvl((select sum(decode(opa.credit_or_charge_flag,'C',-1,1)*opa.operand) from oe_price_adjustments opa where oola.line_id=opa.line_id and opa.arithmetic_operator='AMT' and opa.list_line_type_code='DIS' and opa.applied_flag='Y'),0) --absolute amount discount
) discounted_price,
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
sum(decode(oola.line_category_code,'ORDER',oola.shipped_quantity,0)) over (partition by oola.header_id) ord_shipped_qty,
case when oola.shippable_flag='Y' and oola.line_category_code<>'RETURN' and oola.cancelled_flag='N' then 'Y' end is_shippable,
xxen_util.meaning(nvl2(oola.split_from_line_id,'Y',null),'YES_NO',0) split_line,
case when oola.split_from_line_id is not null then xxen_util.orig_order_line_id(oola.split_from_line_id) end orig_line_id,
oola.*
from
oe_order_lines_all oola
where
2=2 and
oola.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
) oola
) oola,
oe_transaction_types_tl ottt,
oe_transaction_types_tl ottt2,
mtl_system_items_vl msiv,
hz_cust_accounts hca,
hz_parties hp,
oe_order_sources oos,
jtf_rs_salesreps jrs,
jtf_rs_salesreps jrs2,
jtf_rs_resource_extns_vl jrrev,
jtf_rs_resource_extns_vl jrrev2,
(
select ppa.project_id, ppa.segment1 project_number from pa_projects_all ppa union
select psm.project_id, psm.project_number from pjm_seiban_numbers psm
) ppa,
pa_tasks pt,
ra_customer_trx_lines_all rctla,
ra_customer_trx_all rcta,
ra_cust_trx_types_all rctta,
(select rctlgda.* from ra_cust_trx_line_gl_dist_all rctlgda where rctlgda.account_class='REC' and rctlgda.latest_rec_flag='Y') rctlgda0,
(select rctlgda.customer_trx_line_id, sum(rctlgda.acctd_amount) acctd_amount from ra_cust_trx_line_gl_dist_all rctlgda where rctlgda.account_set_flag='N' group by rctlgda.customer_trx_line_id) rctlgda,
(
select distinct
oolh.line_id,
min(oolh.hist_creation_date) over (partition by oolh.line_id) hist_creation_date,
min(oolh.hist_created_by) keep (dense_rank first order by oolh.hist_creation_date) over (partition by oolh.line_id) hist_created_by,
min(oolh.reason_id) keep (dense_rank first order by oolh.hist_creation_date) over (partition by oolh.line_id) reason_id
from
oe_order_lines_history oolh
where
oolh.hist_type_code='CANCELLATION'
) oolh,
(
select distinct
oolh.line_id,
min(oolh.delivery_lead_time) keep (dense_rank first order by oolh.hist_creation_date) over (partition by oolh.line_id) delivery_lead_time,
min(oolh.promise_date) keep (dense_rank first order by oolh.hist_creation_date) over (partition by oolh.line_id) promise_date,
min(oolh.actual_shipment_date) keep (dense_rank first order by oolh.hist_creation_date) over (partition by oolh.line_id) actual_shipment_date
from
oe_order_lines_history oolh
) oolh2,
oe_reasons oer,
oe_order_lines_all oola2
where
1=1 and
haouv.organization_id=ooha.org_id and
ooha.sold_to_org_id=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
ooha.order_type_id=ottt.transaction_type_id(+) and
ottt.language(+)=userenv('lang') and
ooha.order_source_id=oos.order_source_id(+) and
ooha.header_id=oola.header_id(+) and
oola.line_type_id=ottt2.transaction_type_id(+) and
ottt2.language(+)=userenv('lang') and
oola.inventory_item_id=msiv.inventory_item_id(+) and
oola.ship_from_org_id=msiv.organization_id(+) and
ooha.salesrep_id=jrs.salesrep_id(+) and
ooha.org_id=jrs.org_id(+) and
jrs.resource_id=jrrev.resource_id(+) and
oola.project_id=ppa.project_id(+) and
oola.task_id=pt.task_id(+) and
to_char(oola.line_id)=rctla.interface_line_attribute6(+) and
rctla.interface_line_context(+) in ('INTERCOMPANY','ORDER ENTRY') and
rctla.customer_trx_id=rcta.customer_trx_id(+) and
rcta.cust_trx_type_id=rctta.cust_trx_type_id(+) and
rcta.org_id=rctta.org_id(+) and
rcta.customer_trx_id=rctlgda0.customer_trx_id(+) and
rctla.customer_trx_line_id=rctlgda.customer_trx_line_id(+) and
rcta.primary_salesrep_id=jrs2.salesrep_id(+) and
rcta.org_id=jrs2.org_id(+) and
jrs2.resource_id=jrrev2.resource_id(+) and
oola.line_id=oolh.line_id(+) and
oolh.reason_id=oer.reason_id(+) and
oola.orig_line_id=oola2.line_id(+) and
oola.orig_line_id=oolh2.line_id(+)
) x,
(
select distinct
wdd.source_line_id,
wda.delivery_id,
xxen_util.wsh_next_step(wdd.container_flag,wdd.released_status,wdd.source_code,wdd.inv_interfaced_flag,wdd.oe_interfaced_flag,wdd.client_id,wdd.replenishment_status,wdd.move_order_line_id) next_step
from
wsh_delivery_details wdd,
wsh_delivery_assignments wda
where
wdd.source_code='OE' and
wdd.delivery_detail_id=wda.delivery_detail_id
) wda,
wsh_new_deliveries wnd,
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
x.line_id=wda.source_line_id(+) and
wda.delivery_id=wnd.delivery_id(+) and
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
x.customer_number,
x.order_number,
x.line_number,
x.shipment_number,
nvl(x.option_number,-1),
nvl(x.component_number,-1),
nvl(x.service_number,-1),
wnd.name nulls last