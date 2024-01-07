/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ONT Transaction Types and Line WF Processes
-- Description: Master data report showing the setup of order management transaction types and associated line types and workflow processes.
-- Excel Examle Output: https://www.enginatics.com/example/ont-transaction-types-and-line-wf-processes/
-- Library Link: https://www.enginatics.com/reports/ont-transaction-types-and-line-wf-processes/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
ottt.name transaction_type,
ottt.description,
decode(otta.sales_document_type_code,'B','Sales Agreement','O','Sales Order') sales_document_type,
initcap(otta.order_category_code) order_category,
initcap(otta.transaction_type_code) transaction_type_code,
nvl(wav1.display_name,owa1.process_name) fulfillment_flow,
nvl(wav2.display_name,owa2.process_name) negotiation_flow,
otta.start_date_active start_date,
otta.end_date_active end_date,
xtv.template_name layout_template,
oktta.description contract_template,
&columns
ottt2.name default_return_line_type,
ottt3.name default_order_line_type,
qlht.name price_list,
occr1.name ordering_cr_check_rule,
occr2.name packing_cr_check_rule,
occr3.name picking_cr_check_rule,
occr4.name shipping_cr_check_rule,
ood.organization_name warehouse,
otta.shipment_priority_code shipment_priority,
xxen_util.meaning(otta.fob_point_code,'FOB',222) fob,
xxen_util.meaning(otta.demand_class_code,'DEMAND_CLASS',3) demand_class,
xxen_util.meaning(otta.freight_terms_code,'FREIGHT_TERMS',660) freight_terms,
rr1.name invoicing_rule,
rr2.name accounting_rule,
rctta.name receivables_transaction_type,
gcck.concatenated_segments cost_of_goods_sold_account,
otta.currency_code currency
from
hr_all_organization_units_vl haouv,
oe_transaction_types_all otta,
org_organization_definitions ood,
qp_list_headers_tl qlht,
oe_credit_check_rules occr1,
oe_credit_check_rules occr2,
oe_credit_check_rules occr3,
oe_credit_check_rules occr4,
ra_rules rr1,
ra_rules rr2,
ra_cust_trx_types_all rctta,
gl_code_combinations_kfv gcck,
(select owa.* from oe_workflow_assignments owa where owa.line_type_id is null and sysdate between owa.start_date_active and nvl(owa.end_date_active,sysdate)) owa1,
(select owa.* from oe_workflow_assignments owa where owa.line_type_id is null and sysdate between owa.start_date_active and nvl(owa.end_date_active,sysdate)) owa2,
(select owa.* from oe_workflow_assignments owa where '&show_line'='Y' and owa.line_type_id is not null and nvl(owa.wf_item_type,'OEOL')='OEOL') owa3,
(select wav.* from wf_activities_vl wav where wav.type='PROCESS' and wav.runnable_flag='Y' and sysdate between wav.begin_date and nvl(wav.end_date,sysdate)) wav1,
(select wav.* from wf_activities_vl wav where wav.type='PROCESS' and wav.runnable_flag='Y' and sysdate between wav.begin_date and nvl(wav.end_date,sysdate)) wav2,
(select wav.* from wf_activities_vl wav where wav.type='PROCESS' and wav.runnable_flag='Y' and sysdate between wav.begin_date and nvl(wav.end_date,sysdate)) wav3,
oe_transaction_types_tl ottt,
oe_transaction_types_tl ottt1,
oe_transaction_types_tl ottt2,
oe_transaction_types_tl ottt3,
xdo_templates_vl xtv,
okc_terms_templates_all oktta
where
1=1 and
haouv.organization_id=otta.org_id and
otta.warehouse_id=ood.organization_id(+) and
otta.price_list_id=qlht.list_header_id(+) and
qlht.language(+)=userenv('lang') and
otta.entry_credit_check_rule_id=occr1.credit_check_rule_id(+) and
otta.packing_credit_check_rule_id=occr2.credit_check_rule_id(+) and
otta.picking_credit_check_rule_id=occr3.credit_check_rule_id(+) and
otta.shipping_credit_check_rule_id=occr4.credit_check_rule_id(+) and
otta.invoicing_rule_id=rr1.rule_id(+) and
otta.accounting_rule_id=rr2.rule_id(+) and
otta.cust_trx_type_id=rctta.cust_trx_type_id(+) and
otta.org_id=rctta.org_id(+) and
otta.cost_of_goods_sold_account=gcck.code_combination_id(+) and
decode(otta.transaction_type_code,'ORDER',otta.transaction_type_id)=owa1.order_type_id(+) and
decode(otta.transaction_type_code,'ORDER',otta.transaction_type_id)=owa2.order_type_id(+) and
decode(otta.transaction_type_code,'ORDER',otta.transaction_type_id)=owa3.order_type_id(+) and
decode(otta.transaction_type_code,'ORDER',decode(otta.sales_document_type_code,'B','OEBH','O','OEOH'))=owa1.wf_item_type(+) and
decode(otta.transaction_type_code,'ORDER','OENH')=owa2.wf_item_type(+) and
owa1.process_name=wav1.name(+) and
owa2.process_name=wav2.name(+) and
owa3.process_name=wav3.name(+) and
owa1.wf_item_type =wav1.item_type(+) and
owa2.wf_item_type=wav2.item_type(+) and
wav3.item_type(+)='OEOL' and
otta.transaction_type_id=ottt.transaction_type_id and
otta.default_inbound_line_type_id=ottt1.transaction_type_id(+) and
otta.default_outbound_line_type_id=ottt2.transaction_type_id(+) and
owa3.line_type_id=ottt3.transaction_type_id(+) and
ottt.language(+)=userenv('lang') and
ottt1.language(+)=userenv('lang') and
ottt2.language(+)=userenv('lang') and
ottt3.language(+)=userenv('lang') and
otta.layout_template_id=xtv.template_id(+) and
otta.contract_template_id=oktta.template_id(+)
order by
haouv.name,
otta.transaction_type_code desc,
otta.order_category_code,
otta.sales_document_type_code,
ottt.name,
ottt3.name,
owa3.item_type_code,
nvl(wav3.display_name,owa3.process_name),
owa3.start_date_active desc