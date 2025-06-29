/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: QP Price Lists
-- Description: Master data report showing the setup of price lists including item prices, calculation methods, terms and dates.
-- Excel Examle Output: https://www.enginatics.com/example/qp-price-lists/
-- Library Link: https://www.enginatics.com/reports/qp-price-lists/
-- Run Report: https://demo.enginatics.com/

select
qlhv.name price_list,
qlhv.description,
xxen_util.yes(qlhv.global_flag) global,
qlhv.currency_code currency,
fcv.name currency_name,
qclv.name multi_currency_name,
qlhv.rounding_factor,
qllv.start_date_active start_date,
qllv.end_date_active end_date,
qllv.product_attribute_context product_context,
qllv.product_uom_code uom,
qllv.product_attr_val_disp item,
msiv.description item_description,
xxen_util.meaning(qllv.list_line_type_code,'LIST_LINE_TYPE_CODE',661) line_type,
xxen_util.meaning(qllv.arithmetic_operator,'ARITHMETIC_OPERATOR',661) application_method,
xxen_util.meaning(qllv.price_break_type_code,'PRICE_BREAK_TYPE_CODE',661) price_break_type,
qllv.operand value,
qllv.product_precedence precedence,
qlhv.pte_code pricing_transaction_entity,
qlhv.source_system_code,
xxen_util.meaning(qllv.comparison_operator_code,'COMPARISON_OPERATOR',661) operator,
xxen_util.meaning(qlhv.list_type_code,'LIST_TYPE_CODE',661) list_type,
qlhv.list_type_code list_type_code,
xxen_util.meaning(qlhv.source_system_code,'SOURCE_SYSTEM',661) source_system,
qpfv.name formula,
--qp_qpxprcst_xmlp_pkg.cf_product_attributeformula(qllv.product_attribute_context, qllv.product_attribute) product_attribute,
--qp_qpxprcst_xmlp_pkg.cf_product_attr_val_dispformul(qllv.product_attribute_context, qllv.product_attribute, qllv.product_attr_value, qllv.product_attr_val_disp) product_attr_val_disp,
hca.account_number,
hp.party_name customer_name,
xxen_util.meaning(qlhv.ship_method_code,'SHIP_METHOD',3) ship_method,
xxen_util.meaning(qlhv.freight_terms_code,'FREIGHT_TERMS',660) freight_terms,
rtt.name payment_term,
haouv.name operating_unit,
xxen_util.user_name(qllv.created_by) created_by,
xxen_util.client_time(qllv.creation_date) creation_date,
xxen_util.user_name(qllv.last_updated_by) last_updated_by,
xxen_util.client_time(qllv.last_update_date) last_update_date,
qlhv.list_header_id,
qllv.list_line_id
from
qp_list_headers_vl qlhv,
qp_list_lines_v qllv,
mtl_system_items_vl msiv,
qp_currency_lists_vl qclv,
fnd_currencies_vl fcv,
ra_terms_tl rtt,
hz_cust_accounts hca,
hz_parties hp,
hr_all_organization_units_vl haouv,
qp_price_formulas_vl qpfv
where
1=1 and
qlhv.list_header_id=qllv.list_header_id and
(qllv.product_attribute<>'PRICING_ATTRIBUTE1' or msiv.inventory_item_id is not null) and
case when qllv.product_attribute_context='ITEM' and qllv.product_attribute='PRICING_ATTRIBUTE1' then qllv.product_attr_value end=msiv.inventory_item_id(+) and
msiv.organization_id(+)=fnd_profile.value('QP_ORGANIZATION_ID') and
qlhv.currency_header_id=qclv.currency_header_id(+) and
qlhv.currency_code=fcv.currency_code(+) and
qlhv.terms_id=rtt.term_id(+) and
rtt.language(+)=userenv('lang') and
qlhv.sold_to_org_id=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
qlhv.orig_org_id=haouv.organization_id(+) and
qllv.price_by_formula_id=qpfv.price_formula_id(+)
order by
qlhv.name,
qllv.product_attr_val_disp,
qllv.start_date_active desc