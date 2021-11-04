/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ONT Transaction Types Listing
-- Description: Imported Oracle standard Order Management transaction types listing, enhanced to show the setup across all operating units
Description: Transaction Types Listing Report
Application: Order Management
Source: Transaction Types Listing Report (XML)
Short Name: OEXORDTP_XML
DB package: ONT_OEXORDTP_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/ont-transaction-types-listing/
-- Library Link: https://www.enginatics.com/reports/ont-transaction-types-listing/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
ottt.name transaction_type_name,
ottt.description,
otta.start_date_active,
otta.end_date_active,
xxen_util.meaning(otta.transaction_type_code,'TRANSACTION_TYPE',660) transaction_type,
xxen_util.meaning(otta.order_category_code,'ORDER_CATEGORY',660) order_category,
xxen_util.meaning(otta.agreement_type_code,'AGREEMENT_TYPE',660) agreement_type,
ottt1.name default_inbound_line_type,
ottt2.name default_outbound_line_type,
xxen_util.meaning(otta.agreement_required_flag,'YES_NO',0) agreement_required_flag,
xxen_util.meaning(otta.po_required_flag,'YES_NO',0) po_required_flag,
oplv.name price_list,
xxen_util.meaning(otta.enforce_line_prices_flag,'YES_NO',0) enforce_line_prices_flag,
occr1.name entry_credit_check_rule,
occr2.name shipping_credit_check_rule,
ood.organization_name warehouse,
orf.description shipping_method,
xxen_util.meaning(otta.shipment_priority_code,'SHIPMENT_PRIORITY',660) shipment_priority,
xxen_util.meaning(otta.freight_terms_code,'FREIGHT_TERMS',660) freight_terms,
xxen_util.meaning(otta.fob_point_code,'FOB',222) fob,
xxen_util.meaning(otta.ship_source_type_code,'SHIPMENT SOURCE TYPE',201) shipment_source_type,
xxen_util.meaning(otta.demand_class_code,'DEMAND_CLASS',3) demand_class,
xxen_util.meaning(otta.scheduling_level_code,'SCHEDULING_LEVEL',660) scheduling_level,
otta.depot_repair_code,
rr1.name invoicing_rule,
rr2.name accounting_rule,
rbs1.name invoicing_source,
rbs2.name non_delivery_invoice_source,
otta.accounting_credit_method_code,
otta.invoicing_credit_method_code,
rctt.name receivables_transaction_type,
otta.cost_of_goods_sold_account,
fcv.name currency_code,
gdct.user_conversion_type,
xxen_util.meaning(otta.auto_scheduling_flag,'YES_NO',0) auto_scheduling_flag,
xxen_util.meaning(otta.inspection_required_flag,'YES_NO',0) inspection_required_flag,
gcck.concatenated_segments cogs_account,
xxen_util.segments_description(otta.cost_of_goods_sold_account) cogs_description,
xxen_util.user_name(otta.created_by) created_by,
xxen_util.client_time(otta.creation_date) creation_date,
xxen_util.user_name(otta.last_updated_by) last_updated_by,
xxen_util.client_time(otta.last_update_date) last_update_date,
otta.org_id,
otta.transaction_type_id
from
hr_all_organization_units_vl haouv,
oe_transaction_types_all otta,
oe_transaction_types_tl ottt,
oe_transaction_types_tl ottt1,
oe_transaction_types_tl ottt2,
oe_price_lists_v oplv,
oe_credit_check_rules occr1,
oe_credit_check_rules occr2,
org_organization_definitions ood,
org_freight orf,
ra_rules rr1,
ra_rules rr2,
ra_batch_sources rbs1,
ra_batch_sources rbs2,
ra_cust_trx_types rctt,
fnd_currencies_vl fcv,
gl_daily_conversion_types gdct,
gl_code_combinations_kfv gcck
where
1=1 and
haouv.organization_id=otta.org_id and
otta.transaction_type_id=ottt.transaction_type_id and
otta.default_inbound_line_type_id=ottt1.transaction_type_id(+) and
otta.default_outbound_line_type_id=ottt2.transaction_type_id(+) and
ottt.language=userenv('lang') and
ottt1.language(+)=userenv('lang') and
ottt2.language(+)=userenv('lang') and
otta.price_list_id=oplv.price_list_id(+) and
otta.entry_credit_check_rule_id=occr1.credit_check_rule_id(+) and
otta.shipping_credit_check_rule_id=occr2.credit_check_rule_id(+) and
otta.warehouse_id=ood.organization_id(+) and
otta.shipping_method_code=orf.freight_code(+) and
otta.org_id=orf.organization_id(+) and
otta.invoicing_rule_id=rr1.rule_id(+) and
otta.accounting_rule_id=rr2.rule_id(+) and
otta.invoice_source_id=rbs1.batch_source_id(+) and
otta.non_delivery_invoice_source_id=rbs2.batch_source_id(+) and
otta.cust_trx_type_id=rctt.cust_trx_type_id(+) and
otta.currency_code=fcv.currency_code(+) and
otta.conversion_type_code=gdct.conversion_type(+) and
otta.cost_of_goods_sold_account=gcck.code_combination_id(+)
order by
haouv.name,
ottt.name