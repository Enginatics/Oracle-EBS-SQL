/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ONT Order Upload
-- Description: Upload to Create, Update, Book and Cancel Sales Orders in Oracle Order Management.
Supports creating new orders, updating existing orders, adding new lines to existing orders, booking orders and cancelling orders.
-- Excel Examle Output: https://www.enginatics.com/example/ont-order-upload/
-- Library Link: https://www.enginatics.com/reports/ont-order-upload/
-- Run Report: https://demo.enginatics.com/

select
case when :order_action is not null then xxen_upload.action_meaning(xxen_upload.action_update) end action_,
case when :order_action is not null then xxen_upload.status_meaning(xxen_upload.status_new) end status_,
case when :order_action is not null then xxen_util.description('U_EXCEL_MSG_VALIDATION_PENDING','XXEN_REPORT_TRANSLATIONS',0) end message_,
null modified_columns_,
to_number(null) request_id_,
:debug_level debug_level,
haouv.name operating_unit,
-- Header Main Tab - Left Side
hp.party_name customer,
hca.account_number customer_number,
nvl(oola.cust_po_number,ooha.cust_po_number) customer_po,
(select hcsua.location from hz_cust_site_uses_all hcsua where hcsua.site_use_id=ooha.ship_to_org_id) header_ship_to,
(select hcsua.location from hz_cust_site_uses_all hcsua where hcsua.site_use_id=ooha.invoice_to_org_id) header_bill_to,
-- Header Main Tab - Right Side
to_char(ooha.order_number) upload_order_identifier,
ooha.order_number,
ottt.name order_type,
xxen_util.client_time(ooha.ordered_date) ordered_date,
(select qslhv.name from qp_secu_list_headers_v qslhv where qslhv.list_header_id=ooha.price_list_id) header_price_list,
(select nvl(jrret.resource_name,jrs.name) from jtf_rs_salesreps jrs, jtf_rs_resource_extns_tl jrret where jrs.resource_id=jrret.resource_id(+) and jrret.language(+)=userenv('lang') and jrs.salesrep_id=ooha.salesrep_id and jrs.org_id=ooha.org_id) header_salesrep,
xxen_util.meaning(ooha.flow_status_code,'FLOW_STATUS',660) header_status,
:order_action order_action,
ooha.transactional_curr_code currency,
-- Header Others Tab - Left Side
(select rtv.name from ra_terms_vl rtv where rtv.term_id=ooha.payment_term_id) header_payment_terms,
(select mp.organization_code from mtl_parameters mp where mp.organization_id=ooha.ship_from_org_id) header_warehouse,
xxen_util.meaning(ooha.fob_point_code,'FOB',222) header_fob_point,
ooha.shipping_instructions header_shipping_instructions,
xxen_util.meaning(ooha.tax_exempt_flag,'TAX_CONTROL_FLAG',222) header_tax_handling,
xxen_util.meaning(ooha.tax_exempt_reason_code,'TAX_REASON',0) header_tax_exempt_reason,
ooha.tax_exempt_number header_tax_exempt_number,
oos.name order_source,
-- Header Others Tab - Right Side
xxen_util.meaning(ooha.sales_channel_code,'SALES_CHANNEL',660) header_sales_channel,
(select osmv.meaning from oe_ship_methods_v osmv where osmv.lookup_code=ooha.shipping_method_code) header_shipping_method,
xxen_util.meaning(ooha.freight_terms_code,'FREIGHT_TERMS',660) header_freight_terms,
xxen_util.meaning(ooha.shipment_priority_code,'SHIPMENT_PRIORITY',660) header_shipment_priority,
ooha.packing_instructions header_packing_instructions,
-- Header Additional Fields
xxen_util.client_time(ooha.request_date) header_request_date,
ooha.cust_po_number header_cust_po_number,
(select oav.name||' : '||oav.revision from oe_agreements_vl oav where oav.agreement_id=ooha.agreement_id) header_agreement,
xxen_util.meaning(ooha.demand_class_code,'DEMAND_CLASS',3) header_demand_class,
(select rar.name from ra_rules rar where rar.rule_id=ooha.accounting_rule_id) header_accounting_rule,
(select rar.name from ra_rules rar where rar.rule_id=ooha.invoicing_rule_id) header_invoicing_rule,
(select hcsua.location from hz_cust_site_uses_all hcsua where hcsua.site_use_id=ooha.deliver_to_org_id) header_deliver_to,
-- Source Reference Fields
nvl(ooha.quote_number,regexp_substr(ooha.orig_sys_document_ref,'^(\d+).',1,1,null,1)) quote_number,
decode(ooha.source_document_type_id,10,'Requisitions',2,'Orders',16,'Quotes',7,'Incidents',(select oos0.name from oe_order_sources oos0 where ooha.source_document_type_id=oos0.order_source_id)) source_type,
case ooha.source_document_type_id
when 10 then (select prha.segment1 from po_requisition_headers_all prha where ooha.source_document_id=prha.requisition_header_id)
when 2 then (select to_char(ooha0.order_number) from oe_order_headers_all ooha0 where ooha.source_document_id=ooha0.header_id)
when 16 then (select aqha.quote_number||':'||aqha.quote_version from aso_quote_headers_all aqha where ooha.source_document_id=aqha.quote_header_id)
when 7 then (select ciab.incident_number from cs_incidents_all_b ciab where ooha.source_document_id=ciab.incident_id)
end source_document,
decode(ooha.transaction_phase_code,'N','Quote','Order') type,
xxen_util.meaning(ooha.order_category_code,'ORDER_CATEGORY',660) order_category,
-- Line Items Main
rtrim(oola.line_number||'.'||oola.shipment_number||'.'||oola.option_number||'.'||oola.component_number||'.'||oola.service_number,'.') line,
ottt2.name line_type,
msiv.concatenated_segments item,
msiv.description,
oola.ordered_quantity,
oola.order_quantity_uom uom,
xxen_util.meaning(oola.flow_status_code,'LINE_FLOW_STATUS',660) line_status,
to_char(null) cancel_reason,
to_char(null) cancel_comments,
oola.item_type_code item_type,
xxen_util.meaning(oola.line_category_code,'ORDER_CATEGORY',660) line_category,
-- Line Pricing Tab
(select qslhv.name from qp_secu_list_headers_v qslhv where qslhv.list_header_id=oola.price_list_id) line_price_list,
oola.unit_list_price,
oola.unit_selling_price,
xxen_util.meaning(oola.calculate_price_flag,'CALCULATE_PRICE_FLAG',660) calculate_price,
-- Line Discount
(select qplhv.name from qp_list_headers_vl qplhv, oe_price_adjustments opa where opa.line_id=oola.line_id and opa.list_line_type_code='DIS' and opa.applied_flag='Y' and opa.list_header_id=qplhv.list_header_id and rownum=1) discount_modifier,
(select opa.list_line_no from oe_price_adjustments opa where opa.line_id=oola.line_id and opa.list_line_type_code='DIS' and opa.applied_flag='Y' and rownum=1) discount_line,
(select xxen_util.meaning(opa.arithmetic_operator,'ARITHMETIC_OPERATOR',661) from oe_price_adjustments opa where opa.line_id=oola.line_id and opa.list_line_type_code='DIS' and opa.applied_flag='Y' and rownum=1) discount_type,
(select opa.operand from oe_price_adjustments opa where opa.line_id=oola.line_id and opa.list_line_type_code='DIS' and opa.applied_flag='Y' and rownum=1) discount_value,
-- Line Shipping Tab
(select mp.organization_code from mtl_parameters mp where mp.organization_id=oola.ship_from_org_id) line_warehouse,
xxen_util.meaning(oola.source_type_code,'SOURCE_TYPE',660) line_source_type,
xxen_util.client_time(oola.request_date) line_request_date,
xxen_util.client_time(oola.schedule_ship_date) schedule_ship_date,
xxen_util.client_time(oola.promise_date) promise_date,
-- Line Addresses Tab
(select hcsua.location from hz_cust_site_uses_all hcsua where hcsua.site_use_id=oola.ship_to_org_id) line_ship_to,
(select hcsua.location from hz_cust_site_uses_all hcsua where hcsua.site_use_id=oola.invoice_to_org_id) line_bill_to,
-- Line Others Tab
(select nvl(jrret.resource_name,jrs.name) from jtf_rs_salesreps jrs, jtf_rs_resource_extns_tl jrret where jrs.resource_id=jrret.resource_id(+) and jrret.language(+)=userenv('lang') and jrs.salesrep_id=oola.salesrep_id and jrs.org_id=oola.org_id) line_salesrep,
oola.cust_po_number line_cust_po_number,
oola.customer_line_number,
(select osmv.meaning from oe_ship_methods_v osmv where osmv.lookup_code=oola.shipping_method_code) line_shipping_method,
xxen_util.meaning(oola.freight_terms_code,'FREIGHT_TERMS',660) line_freight_terms,
(select ppa.segment1 from pa_projects_all ppa where ppa.project_id=oola.project_id) project,
(select pt.task_number from pa_tasks pt where pt.task_id=oola.task_id) task,
-- Line Tax
xxen_util.meaning(oola.tax_exempt_flag,'TAX_CONTROL_FLAG',222) line_tax_handling,
xxen_util.meaning(oola.tax_exempt_reason_code,'TAX_REASON',0) line_tax_exempt_reason,
oola.tax_exempt_number line_tax_exempt_number,
oola.tax_code tax_classification_code,
-- Line Returns
xxen_util.meaning(oola.return_reason_code,'CREDIT_MEMO_REASON',222) return_reason,
-- Order Header DFF Attributes
xxen_util.display_flexfield_context(660,'OE_HEADER_ATTRIBUTES',ooha.context) order_header_dff_context,
xxen_util.display_flexfield_value(660,'OE_HEADER_ATTRIBUTES',ooha.context,'ATTRIBUTE1',ooha.rowid,ooha.attribute1) order_header_attribute1,
xxen_util.display_flexfield_value(660,'OE_HEADER_ATTRIBUTES',ooha.context,'ATTRIBUTE2',ooha.rowid,ooha.attribute2) order_header_attribute2,
xxen_util.display_flexfield_value(660,'OE_HEADER_ATTRIBUTES',ooha.context,'ATTRIBUTE3',ooha.rowid,ooha.attribute3) order_header_attribute3,
xxen_util.display_flexfield_value(660,'OE_HEADER_ATTRIBUTES',ooha.context,'ATTRIBUTE4',ooha.rowid,ooha.attribute4) order_header_attribute4,
xxen_util.display_flexfield_value(660,'OE_HEADER_ATTRIBUTES',ooha.context,'ATTRIBUTE5',ooha.rowid,ooha.attribute5) order_header_attribute5,
xxen_util.display_flexfield_value(660,'OE_HEADER_ATTRIBUTES',ooha.context,'ATTRIBUTE6',ooha.rowid,ooha.attribute6) order_header_attribute6,
xxen_util.display_flexfield_value(660,'OE_HEADER_ATTRIBUTES',ooha.context,'ATTRIBUTE7',ooha.rowid,ooha.attribute7) order_header_attribute7,
xxen_util.display_flexfield_value(660,'OE_HEADER_ATTRIBUTES',ooha.context,'ATTRIBUTE8',ooha.rowid,ooha.attribute8) order_header_attribute8,
xxen_util.display_flexfield_value(660,'OE_HEADER_ATTRIBUTES',ooha.context,'ATTRIBUTE9',ooha.rowid,ooha.attribute9) order_header_attribute9,
xxen_util.display_flexfield_value(660,'OE_HEADER_ATTRIBUTES',ooha.context,'ATTRIBUTE10',ooha.rowid,ooha.attribute10) order_header_attribute10,
xxen_util.display_flexfield_value(660,'OE_HEADER_ATTRIBUTES',ooha.context,'ATTRIBUTE11',ooha.rowid,ooha.attribute11) order_header_attribute11,
xxen_util.display_flexfield_value(660,'OE_HEADER_ATTRIBUTES',ooha.context,'ATTRIBUTE12',ooha.rowid,ooha.attribute12) order_header_attribute12,
xxen_util.display_flexfield_value(660,'OE_HEADER_ATTRIBUTES',ooha.context,'ATTRIBUTE13',ooha.rowid,ooha.attribute13) order_header_attribute13,
xxen_util.display_flexfield_value(660,'OE_HEADER_ATTRIBUTES',ooha.context,'ATTRIBUTE14',ooha.rowid,ooha.attribute14) order_header_attribute14,
xxen_util.display_flexfield_value(660,'OE_HEADER_ATTRIBUTES',ooha.context,'ATTRIBUTE15',ooha.rowid,ooha.attribute15) order_header_attribute15,
xxen_util.display_flexfield_value(660,'OE_HEADER_ATTRIBUTES',ooha.context,'ATTRIBUTE16',ooha.rowid,ooha.attribute16) order_header_attribute16,
xxen_util.display_flexfield_value(660,'OE_HEADER_ATTRIBUTES',ooha.context,'ATTRIBUTE17',ooha.rowid,ooha.attribute17) order_header_attribute17,
xxen_util.display_flexfield_value(660,'OE_HEADER_ATTRIBUTES',ooha.context,'ATTRIBUTE18',ooha.rowid,ooha.attribute18) order_header_attribute18,
xxen_util.display_flexfield_value(660,'OE_HEADER_ATTRIBUTES',ooha.context,'ATTRIBUTE19',ooha.rowid,ooha.attribute19) order_header_attribute19,
xxen_util.display_flexfield_value(660,'OE_HEADER_ATTRIBUTES',ooha.context,'ATTRIBUTE20',ooha.rowid,ooha.attribute20) order_header_attribute20,
-- Order Header TP Attributes
xxen_util.display_flexfield_context(660,'OE_HEADER_TP_ATTRIBUTES',ooha.tp_context) order_header_tp_context,
xxen_util.display_flexfield_value(660,'OE_HEADER_TP_ATTRIBUTES',ooha.tp_context,'TP_ATTRIBUTE1',ooha.rowid,ooha.tp_attribute1) order_header_tp_attribute1,
xxen_util.display_flexfield_value(660,'OE_HEADER_TP_ATTRIBUTES',ooha.tp_context,'TP_ATTRIBUTE2',ooha.rowid,ooha.tp_attribute2) order_header_tp_attribute2,
xxen_util.display_flexfield_value(660,'OE_HEADER_TP_ATTRIBUTES',ooha.tp_context,'TP_ATTRIBUTE3',ooha.rowid,ooha.tp_attribute3) order_header_tp_attribute3,
xxen_util.display_flexfield_value(660,'OE_HEADER_TP_ATTRIBUTES',ooha.tp_context,'TP_ATTRIBUTE4',ooha.rowid,ooha.tp_attribute4) order_header_tp_attribute4,
xxen_util.display_flexfield_value(660,'OE_HEADER_TP_ATTRIBUTES',ooha.tp_context,'TP_ATTRIBUTE5',ooha.rowid,ooha.tp_attribute5) order_header_tp_attribute5,
xxen_util.display_flexfield_value(660,'OE_HEADER_TP_ATTRIBUTES',ooha.tp_context,'TP_ATTRIBUTE6',ooha.rowid,ooha.tp_attribute6) order_header_tp_attribute6,
xxen_util.display_flexfield_value(660,'OE_HEADER_TP_ATTRIBUTES',ooha.tp_context,'TP_ATTRIBUTE7',ooha.rowid,ooha.tp_attribute7) order_header_tp_attribute7,
xxen_util.display_flexfield_value(660,'OE_HEADER_TP_ATTRIBUTES',ooha.tp_context,'TP_ATTRIBUTE8',ooha.rowid,ooha.tp_attribute8) order_header_tp_attribute8,
xxen_util.display_flexfield_value(660,'OE_HEADER_TP_ATTRIBUTES',ooha.tp_context,'TP_ATTRIBUTE9',ooha.rowid,ooha.tp_attribute9) order_header_tp_attribute9,
xxen_util.display_flexfield_value(660,'OE_HEADER_TP_ATTRIBUTES',ooha.tp_context,'TP_ATTRIBUTE10',ooha.rowid,ooha.tp_attribute10) order_header_tp_attribute10,
xxen_util.display_flexfield_value(660,'OE_HEADER_TP_ATTRIBUTES',ooha.tp_context,'TP_ATTRIBUTE11',ooha.rowid,ooha.tp_attribute11) order_header_tp_attribute11,
xxen_util.display_flexfield_value(660,'OE_HEADER_TP_ATTRIBUTES',ooha.tp_context,'TP_ATTRIBUTE12',ooha.rowid,ooha.tp_attribute12) order_header_tp_attribute12,
xxen_util.display_flexfield_value(660,'OE_HEADER_TP_ATTRIBUTES',ooha.tp_context,'TP_ATTRIBUTE13',ooha.rowid,ooha.tp_attribute13) order_header_tp_attribute13,
xxen_util.display_flexfield_value(660,'OE_HEADER_TP_ATTRIBUTES',ooha.tp_context,'TP_ATTRIBUTE14',ooha.rowid,ooha.tp_attribute14) order_header_tp_attribute14,
xxen_util.display_flexfield_value(660,'OE_HEADER_TP_ATTRIBUTES',ooha.tp_context,'TP_ATTRIBUTE15',ooha.rowid,ooha.tp_attribute15) order_header_tp_attribute15,
-- Order Line DFF Attributes
xxen_util.display_flexfield_context(660,'OE_LINE_ATTRIBUTES',oola.context) order_line_dff_context,
xxen_util.display_flexfield_value(660,'OE_LINE_ATTRIBUTES',oola.context,'ATTRIBUTE1',oola.rowid,oola.attribute1) order_line_attribute1,
xxen_util.display_flexfield_value(660,'OE_LINE_ATTRIBUTES',oola.context,'ATTRIBUTE2',oola.rowid,oola.attribute2) order_line_attribute2,
xxen_util.display_flexfield_value(660,'OE_LINE_ATTRIBUTES',oola.context,'ATTRIBUTE3',oola.rowid,oola.attribute3) order_line_attribute3,
xxen_util.display_flexfield_value(660,'OE_LINE_ATTRIBUTES',oola.context,'ATTRIBUTE4',oola.rowid,oola.attribute4) order_line_attribute4,
xxen_util.display_flexfield_value(660,'OE_LINE_ATTRIBUTES',oola.context,'ATTRIBUTE5',oola.rowid,oola.attribute5) order_line_attribute5,
xxen_util.display_flexfield_value(660,'OE_LINE_ATTRIBUTES',oola.context,'ATTRIBUTE6',oola.rowid,oola.attribute6) order_line_attribute6,
xxen_util.display_flexfield_value(660,'OE_LINE_ATTRIBUTES',oola.context,'ATTRIBUTE7',oola.rowid,oola.attribute7) order_line_attribute7,
xxen_util.display_flexfield_value(660,'OE_LINE_ATTRIBUTES',oola.context,'ATTRIBUTE8',oola.rowid,oola.attribute8) order_line_attribute8,
xxen_util.display_flexfield_value(660,'OE_LINE_ATTRIBUTES',oola.context,'ATTRIBUTE9',oola.rowid,oola.attribute9) order_line_attribute9,
xxen_util.display_flexfield_value(660,'OE_LINE_ATTRIBUTES',oola.context,'ATTRIBUTE10',oola.rowid,oola.attribute10) order_line_attribute10,
xxen_util.display_flexfield_value(660,'OE_LINE_ATTRIBUTES',oola.context,'ATTRIBUTE11',oola.rowid,oola.attribute11) order_line_attribute11,
xxen_util.display_flexfield_value(660,'OE_LINE_ATTRIBUTES',oola.context,'ATTRIBUTE12',oola.rowid,oola.attribute12) order_line_attribute12,
xxen_util.display_flexfield_value(660,'OE_LINE_ATTRIBUTES',oola.context,'ATTRIBUTE13',oola.rowid,oola.attribute13) order_line_attribute13,
xxen_util.display_flexfield_value(660,'OE_LINE_ATTRIBUTES',oola.context,'ATTRIBUTE14',oola.rowid,oola.attribute14) order_line_attribute14,
xxen_util.display_flexfield_value(660,'OE_LINE_ATTRIBUTES',oola.context,'ATTRIBUTE15',oola.rowid,oola.attribute15) order_line_attribute15,
xxen_util.display_flexfield_value(660,'OE_LINE_ATTRIBUTES',oola.context,'ATTRIBUTE16',oola.rowid,oola.attribute16) order_line_attribute16,
xxen_util.display_flexfield_value(660,'OE_LINE_ATTRIBUTES',oola.context,'ATTRIBUTE17',oola.rowid,oola.attribute17) order_line_attribute17,
xxen_util.display_flexfield_value(660,'OE_LINE_ATTRIBUTES',oola.context,'ATTRIBUTE18',oola.rowid,oola.attribute18) order_line_attribute18,
xxen_util.display_flexfield_value(660,'OE_LINE_ATTRIBUTES',oola.context,'ATTRIBUTE19',oola.rowid,oola.attribute19) order_line_attribute19,
xxen_util.display_flexfield_value(660,'OE_LINE_ATTRIBUTES',oola.context,'ATTRIBUTE20',oola.rowid,oola.attribute20) order_line_attribute20,
-- Order Line TP Attributes
xxen_util.display_flexfield_context(660,'OE_LINE_TP_ATTRIBUTES',oola.tp_context) order_line_tp_context,
xxen_util.display_flexfield_value(660,'OE_LINE_TP_ATTRIBUTES',oola.tp_context,'TP_ATTRIBUTE1',oola.rowid,oola.tp_attribute1) order_line_tp_attribute1,
xxen_util.display_flexfield_value(660,'OE_LINE_TP_ATTRIBUTES',oola.tp_context,'TP_ATTRIBUTE2',oola.rowid,oola.tp_attribute2) order_line_tp_attribute2,
xxen_util.display_flexfield_value(660,'OE_LINE_TP_ATTRIBUTES',oola.tp_context,'TP_ATTRIBUTE3',oola.rowid,oola.tp_attribute3) order_line_tp_attribute3,
xxen_util.display_flexfield_value(660,'OE_LINE_TP_ATTRIBUTES',oola.tp_context,'TP_ATTRIBUTE4',oola.rowid,oola.tp_attribute4) order_line_tp_attribute4,
xxen_util.display_flexfield_value(660,'OE_LINE_TP_ATTRIBUTES',oola.tp_context,'TP_ATTRIBUTE5',oola.rowid,oola.tp_attribute5) order_line_tp_attribute5,
xxen_util.display_flexfield_value(660,'OE_LINE_TP_ATTRIBUTES',oola.tp_context,'TP_ATTRIBUTE6',oola.rowid,oola.tp_attribute6) order_line_tp_attribute6,
xxen_util.display_flexfield_value(660,'OE_LINE_TP_ATTRIBUTES',oola.tp_context,'TP_ATTRIBUTE7',oola.rowid,oola.tp_attribute7) order_line_tp_attribute7,
xxen_util.display_flexfield_value(660,'OE_LINE_TP_ATTRIBUTES',oola.tp_context,'TP_ATTRIBUTE8',oola.rowid,oola.tp_attribute8) order_line_tp_attribute8,
xxen_util.display_flexfield_value(660,'OE_LINE_TP_ATTRIBUTES',oola.tp_context,'TP_ATTRIBUTE9',oola.rowid,oola.tp_attribute9) order_line_tp_attribute9,
xxen_util.display_flexfield_value(660,'OE_LINE_TP_ATTRIBUTES',oola.tp_context,'TP_ATTRIBUTE10',oola.rowid,oola.tp_attribute10) order_line_tp_attribute10,
xxen_util.display_flexfield_value(660,'OE_LINE_TP_ATTRIBUTES',oola.tp_context,'TP_ATTRIBUTE11',oola.rowid,oola.tp_attribute11) order_line_tp_attribute11,
xxen_util.display_flexfield_value(660,'OE_LINE_TP_ATTRIBUTES',oola.tp_context,'TP_ATTRIBUTE12',oola.rowid,oola.tp_attribute12) order_line_tp_attribute12,
xxen_util.display_flexfield_value(660,'OE_LINE_TP_ATTRIBUTES',oola.tp_context,'TP_ATTRIBUTE13',oola.rowid,oola.tp_attribute13) order_line_tp_attribute13,
xxen_util.display_flexfield_value(660,'OE_LINE_TP_ATTRIBUTES',oola.tp_context,'TP_ATTRIBUTE14',oola.rowid,oola.tp_attribute14) order_line_tp_attribute14,
xxen_util.display_flexfield_value(660,'OE_LINE_TP_ATTRIBUTES',oola.tp_context,'TP_ATTRIBUTE15',oola.rowid,oola.tp_attribute15) order_line_tp_attribute15,
--Who columns
xxen_util.user_name(ooha.created_by) header_created_by,
xxen_util.client_time(ooha.creation_date) header_creation_date,
xxen_util.user_name(ooha.last_updated_by) header_last_updated_by,
xxen_util.client_time(ooha.last_update_date) header_last_update_date,
xxen_util.user_name(oola.created_by) line_created_by,
xxen_util.client_time(oola.creation_date) line_creation_date,
xxen_util.user_name(oola.last_updated_by) line_last_updated_by,
xxen_util.client_time(oola.last_update_date) line_last_update_date,
--Id columns
ooha.header_id,
oola.line_id,
null upload_row
from
hr_all_organization_units_vl haouv,
oe_order_headers_all ooha,
oe_transaction_types_tl ottt,
oe_transaction_types_tl ottt2,
mtl_system_items_vl msiv,
hz_cust_accounts hca,
hz_parties hp,
oe_order_sources oos,
oe_order_lines_all oola
where
1=1 and
2=2 and
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
oola.ship_from_org_id=msiv.organization_id(+)