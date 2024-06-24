/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: QP Modifier Details
-- Description: Imported from BI Publisher
Description: Modifier Details Report for QP
Application: Advanced Pricing
Source: Modifier Details (XML)
Short Name: QPXPRMLS_XML
DB package: QP_QPXPRMLS_XMLP_PKG

he Modifier Details (columns) are repeated across all rows pertaining to the Modifier
The List Line Details (columns) are repeated across all rows pertaining to the List Line

For a given modifier the row sequence is:
-  Modifier Level Qualifiers (sorted by qualifier group, qualifier grouping number)
- Modifier List Lines (sorted by list line number)

For each Modifier List the row sequence is:
- List Line record type
- List Line - Qualifiers (sorted by qualifier group, qualifier grouping number)
- List Line - Price Breaks
- List Line - Pricing Attributes 

You can filter on the Record Type column to restrict the data based on what you want to review (e.g just the Modifier Qualifiers, or just the Modifier Lines, or just the Line Level Qualifiers etc).

-- Excel Examle Output: https://www.enginatics.com/example/qp-modifier-details/
-- Library Link: https://www.enginatics.com/reports/qp-modifier-details/
-- Run Report: https://demo.enginatics.com/

with
q1 as
(
 select
  a.name modifier_number,
  a.description modifier_name,
  a.version_no version,
  a.comments description,
  a.currency_code currency,
  a.start_date_active modifier_effective_from,
  a.end_date_active modifier_effective_to,
  QP_QPXPRMLS_XMLP_PKG.cf_line_type_codeformula(a.list_type_code) type,
  a.automatic_flag modifier_automatc_flag,
  a.active_flag modifier_active_flag,
  a.ask_for_flag ask_for,
  a.global_flag,
  QP_QPXPRMLS_XMLP_PKG.cf_parent_numberformula(a.parent_list_header_id) parent_number,
  QP_QPXPRMLS_XMLP_PKG.cf_parent_versionformula(a.parent_list_header_id) parent_version,
  a.active_date_first_type data_type_1,
  a.start_date_active_first data_type_1_effective_from,
  a.end_date_active_first data_type_1_effective_to,
  a.active_date_second_type data_type_2,
  a.start_date_active_second data_type_2_effective_from,
  a.end_date_active_second data_type_2_effective_to,
  --
  --a.list_type_code,
  --a.gsa_indicator,
  a.parent_list_header_id parent_list_header_id1,
  a.list_header_id list_header_id1,
  xxen_util.client_time(a.creation_date) creation_date,
  xxen_util.user_name(a.created_by,'N') created_by,
  xxen_util.client_time(a.last_update_date) last_update_date,
  xxen_util.user_name(a.last_updated_by,'N') last_updated_by
 from
  qp_secu_list_headers_vl a
 where
  1=1 and
  a.list_type_code not in ('PRL','AGR') and
  nvl(a.PTE_CODE, 'ORDFUL') <> 'LOGSTX'
),
--
--
q2 as
(
 select
  a.rule_name qualifier_group,
  a.qualifier_grouping_no qualifier_grouping_number,
  a.start_date_active qualifier_start_date,
  a.end_date_active   qualifier_end_date,
  a.qualifier_context,
  QP_QPXPRMLS_XMLP_PKG.cf_qualifier_attributeformula(a.qualifier_context, a.qualifier_attribute) qualifier_attribute,
  qualify_hier_descendents_flag applies_to_party_hierarchy,
  a.comparision_operator_code qualifier_operator_code,
  QP_QPXPRMLS_XMLP_PKG.cf_attr_value_fromformula(a.qualifier_context, a.qualifier_attribute, a.qualifier_attr_value, a.comparision_operator_code,qualifier_datatype,a.comparision_operator_code) qualifier_value_from,
  QP_QPXPRMLS_XMLP_PKG.cf_attr_value_toformula(a.qualifier_context, a.qualifier_attribute, a.qualifier_attr_value_to, a.comparision_operator_code,qualifier_datatype,a.comparision_operator_code,a.qualifier_attr_value) qualifier_value_to,
  --
  --a.qualifier_attribute,
  --a.qualifier_attr_value,
  --a.qualifier_attr_value_to,
  --a.qualifier_datatype,
  a.list_header_id list_header_id2,
  a.list_line_id list_line_id2,
  xxen_util.client_time(a.creation_date) creation_date,
  xxen_util.user_name(a.created_by,'N') created_by,
  xxen_util.client_time(a.last_update_date) last_update_date,
  xxen_util.user_name(a.last_updated_by,'N') last_updated_by
 from
  qp_qualifiers_v a
 order by
  a.qualifier_grouping_no
),
--
--
q3 as
(
 select
  a.list_line_no list_line_no,
  a.modifier_level,
  a.start_date_active line_effective_from,
  a.end_date_active line_effective_to,
  a.list_line_type,
  a.print_on_invoice_flag,
  a.automatic_flag line_automatic_flag,
  a.override_flag line_override_flag,
  a.pricing_phase line_phase,
  a.pricing_group_sequence line_bucket,
  a.proration_type line_proration_type,
  a.estim_gl_value comparison_value,
  (select ql.meaning from qp_lookups ql where ql.lookup_type = 'QP_NET_AMOUNT_CALCULATION' and ql.lookup_code = a.net_amount_flag) net_amount_calculation,
  a.incompatibility_grp line_incompatibility_group,
  a.product_attribute_type line_product_attribute_type,
  a.comparison_operator_code line_comparison_operator_code,
  a.product_attr_value line_product_value,
  a.product_precedence line_precedence,
  a.product_uom_code line_uom,
  a.pricing_attribute line_volume_type,
  a.pricing_attr_value_from line_value_from,
  a.pricing_attr_value_to line_value_to,
  a.price_break_type line_price_break_type,
  a.accum_attribute accumulation_attribute,
  a.charge_name,
  a.formula line_formula,
  a.arithmetic_operator_type line_appl_method,
  a.operand line_value,
  a.include_on_returns_flag,
  a.accrual_flag,
  --
  a.related_item upgrade_item,
  --
  a.substitution_attribute terms_attribute,
  a.substitution_value terms_value,
  --
  decode(a.list_line_type_code,'CIE',a.expiration_date,null) coupon_expire_date,
  decode(a.list_line_type_code,'CIE',a.expiration_period_start_date,null) coupon_expire_prd_start_date,
  decode(a.list_line_type_code,'CIE',a.number_expiration_periods,null) coupon_expire_periods,
  decode(a.list_line_type_code,'CIE',a.expiration_period_uom,null) expire_period_type,
  decode(a.list_line_type_code,'CIE',a.benefit_qty,null) coupon_benefit_qty,
  decode(a.list_line_type_code,'CIE',a.benefit_uom_code,null) coupon_benefit_uom,
  decode(a.list_line_type_code,'CIE',a.estim_accrual_rate,null) estimated_benefit_rate,
  decode(a.list_line_type_code,'CIE',a.accrual_conversion_rate,null) coupon_conversion_rate,
  case when a.list_line_type_code = 'CIE'
  then
   (select
     qll.list_line_no
    from
     qp_list_lines qll
    where
     qll.list_line_id =
       (select
         qr.to_rltd_modifier_id
        from
         qp_rltd_modifiers qr,
         qp_list_lines ql
        where
         qr.from_rltd_modifier_id = ql.list_line_id and
         qr.from_rltd_modifier_id = a.list_line_id and
         qr.rltd_modifier_grp_type = 'COUPON'
       )
   )
  else
   null
  end coupon_modifier_number,
  --
--  a.list_line_type_code,
--  a.charge_subtype_code,
--  a.net_amount_flag,
  a.list_line_id list_line_id3,
  a.list_header_id list_header_id3,
  xxen_util.client_time(a.creation_date) creation_date,
  xxen_util.user_name(a.created_by,'N') created_by,
  xxen_util.client_time(a.last_update_date) last_update_date,
  xxen_util.user_name(a.last_updated_by,'N') last_updated_by
 from
  qp_modifier_summary_v a
 where
  2=2 and
  a.list_line_type_code IN ('DIS', 'OID', 'TSN', 'CIE', 'PBH', 'IUE', 'SUR', 'FREIGHT_CHARGE', 'PRG') and
  not exists
   (select
     null
    from
     qp_rltd_modifiers q
    where
     a.list_line_id = q.to_rltd_modifier_id
   )
),
--
--
q4 as
(
 select
  b.pricing_attr_value_from price_break_attr_value_from,
  b.pricing_attr_value_to price_break_attr_value_to,
  QP_QP_Form_Pricing_Attr.Get_Formula(b.price_by_formula_id) formula,
  QP_QP_Form_Pricing_Attr.Get_Meaning (b.arithmetic_operator, 'ARITHMETIC_OPERATOR') application_method,
  b.operand value,
  b.benefit_qty,
  b.benefit_uom_code benefit_uom,
  b.accrual_conversion_rate,
  --
--  b.price_by_formula_id,
--  b.arithmetic_operator,
--  b.pricing_attribute_datatype,
--  b.accrual_flag,
--  b.pricing_attribute_context,
--  b.pricing_attribute,
--  b.pricing_attribute_id,
  b.list_line_id list_line_id4,
  b.list_header_id list_header_id4,
  b.parent_list_line_id parent_list_line_id4,
  xxen_util.client_time(b.creation_date) creation_date,
  xxen_util.user_name(b.created_by,'N') created_by,
  xxen_util.client_time(b.last_update_date) last_update_date,
  xxen_util.user_name(b.last_updated_by,'N') last_updated_by
 from
  qp_price_breaks_v b
),
--
--
q5 as
(
 select
  a.rltd_modifier_grp_no related_modifier_group_number,
  QP_QP_Form_Pricing_Attr.Get_Attribute ('QP_ATTR_DEFNS_PRICING', a.product_attribute_context, a.product_attribute) product_attribute,
  QP_Price_List_Line_Util.Get_Product_Value ('QP_ATTR_DEFNS_PRICING', a.product_attribute_context, a.product_attribute, a.product_attr_value) product_attribute_value,
  QP_QP_Form_Pricing_Attr.Get_Attribute ('QP_ATTR_DEFNS_PRICING',a.pricing_attribute_context,a.pricing_attribute) pricing_attribute,
  a.comparison_operator_code operator,
  a.pricing_attr_value_from value_from,
  a.pricing_attr_value_to value_to,
  a.product_uom_code buy_uom,
  --
--  a.product_attribute,
--  a.product_attr_value,
--  a.pricing_attribute,
--  a.product_attribute_context,
--  a.pricing_attribute_context,
--  a.product_attribute_datatype,
--  a.pricing_attribute_datatype,
--  a.pricing_attribute_id,
  a.list_line_id list_line_id5,
  a.list_header_id list_header_id5,
  a.parent_list_line_id parent_list_line_id5,
  xxen_util.client_time(a.creation_date) creation_date,
  xxen_util.user_name(a.created_by,'N') created_by,
  xxen_util.client_time(a.last_update_date) last_update_date,
  xxen_util.user_name(a.last_updated_by,'N') last_updated_by
 from
  qp_pricing_attr_v a
),
--
--
q6 as
(
 select
  QP_QP_Form_Pricing_Attr.Get_Attribute ('QP_ATTR_DEFNS_PRICING', g.product_attribute_context, g.product_attribute) product_attribute,
  QP_Price_List_Line_Util.Get_Product_Value ('QP_ATTR_DEFNS_PRICING', g.product_attribute_context, g.product_attribute, g.product_attr_value) product_attribute_value,
  g.product_uom_code product_attribute_uom,
  g.benefit_qty get_quantity,
  g.benefit_uom_code get_uom,
  (select qll.operand from qp_list_lines qll where qll.list_line_id = g.benefit_price_list_line_id) get_price,
  QP_QP_Form_Pricing_Attr.Get_Formula(g.price_by_formula_id) formula,
  QP_QP_Form_Pricing_Attr.Get_Meaning(g.arithmetic_operator, 'ARITHMETIC_OPERATOR') application_method,
  g.operand value,
 --
--  g.product_attribute,
--  g.product_attr_value,
--  g.benefit_price_list_line_id,
--  g.price_by_formula_id,
--  g.arithmetic_operator,
--  g.product_attribute_context,
--  g.pricing_attribute_context,
--  g.product_attribute_datatype,
--  g.pricing_attribute_datatype,
--  g.pricing_attribute_id,
  g.list_line_id list_line_id6,
  g.list_header_id list_header_id6,
  g.parent_list_line_id parent_list_line_id6,
  xxen_util.client_time(g.creation_date) creation_date,
  xxen_util.user_name(g.created_by,'N') created_by,
  xxen_util.client_time(g.last_update_date) last_update_date,
  xxen_util.user_name(g.last_updated_by,'N') last_updated_by
 from
  qp_pricing_attr_get_v g
)
------------------------------------
-- Main Query starts here
------------------------------------
select
x.*
from
(
-- List Header Qualifiers
-- Q1, Q2
select /*+ push_pred(q2) push_pred(q3) push_pred(q4) push_pred(q5) push_pred(q6) */
 q1.modifier_number,
 q1.modifier_name,
 q1.version,
 q1.description,
 q1.currency,
 q1.modifier_effective_from,
 q1.modifier_effective_to,
 q1.type,
 q1.modifier_automatc_flag,
 q1.modifier_active_flag,
 q1.ask_for,
 q1.global_flag,
 q1.parent_number,
 q1.parent_version,
 q1.data_type_1,
 q1.data_type_1_effective_from,
 q1.data_type_1_effective_to,
 q1.data_type_2,
 q1.data_type_2_effective_from,
 q1.data_type_2_effective_to,
 --
 'Qualifier' record_type,
 --
 q2.qualifier_group,
 q2.qualifier_grouping_number,
 q2.qualifier_start_date,
 q2.qualifier_end_date,
 q2.qualifier_context,
 q2.qualifier_attribute,
 q2.applies_to_party_hierarchy,
 q2.qualifier_operator_code,
 q2.qualifier_value_from,
 q2.qualifier_value_to,
 --
 q3.list_line_no,
 q3.modifier_level,
 q3.line_effective_from,
 q3.line_effective_to,
 q3.list_line_type,
 q3.print_on_invoice_flag,
 q3.line_automatic_flag,
 q3.line_override_flag,
 q3.line_phase,
 q3.line_bucket,
 q3.line_proration_type,
 q3.comparison_value,
 q3.net_amount_calculation,
 q3.line_incompatibility_group,
 q3.line_product_attribute_type,
 q3.line_comparison_operator_code,
 q3.line_product_value,
 q3.line_precedence,
 q3.line_uom,
 q3.line_volume_type,
 q3.line_value_from,
 q3.line_value_to,
 q3.line_price_break_type,
 q3.accumulation_attribute,
 q3.charge_name,
 q3.line_formula,
 q3.line_appl_method,
 q3.line_value,
 q3.include_on_returns_flag,
 q3.accrual_flag,
 q3.upgrade_item,
 q3.terms_attribute,
 q3.terms_value,
 q3.coupon_expire_date,
 q3.coupon_expire_prd_start_date,
 q3.coupon_expire_periods,
 q3.expire_period_type,
 q3.coupon_benefit_qty,
 q3.coupon_benefit_uom,
 q3.estimated_benefit_rate,
 q3.coupon_conversion_rate,
 q3.coupon_modifier_number,
 --
 q5.related_modifier_group_number,
 q4.price_break_attr_value_from,
 q4.price_break_attr_value_to,
 q5.product_attribute,
 q5.product_attribute_value,
 q6.product_attribute_uom,
 q5.pricing_attribute,
 q5.operator,
 q4.formula,
 q4.application_method,
 q4.value,
 q5.value_from,
 q5.value_to,
 q4.benefit_qty,
 q4.benefit_uom,
 q4.accrual_conversion_rate,
 q5.buy_uom,
 q6.get_quantity,
 q6.get_uom,
 q6.get_price,
 --
 q2.creation_date,
 q2.created_by,
 q2.last_update_date,
 q2.last_updated_by,
 --
 1 sort_order
from
 q1,
 q2,
 q3,
 q4,
 q5,
 q6
where
 q1.list_header_id1 = q2.list_header_id2 and
 q2.list_line_id2 = -1 and
 nvl2(q1.list_header_id1,-1,-1) = q3.list_header_id3 (+) and
 nvl2(q3.list_line_id3,-1,-1) = q4.parent_list_line_id4 (+) and
 nvl2(q3.list_line_id3,-1,-1) = q5.parent_list_line_id5 (+) and
 nvl2(q3.list_line_id3,-1,-1) = q6.parent_list_line_id6 (+)
--
union
-- List Lines
-- Q1, Q3
select /*+ push_pred(q2) push_pred(q3) push_pred(q4) push_pred(q5) push_pred(q6) */
 q1.modifier_number,
 q1.modifier_name,
 q1.version,
 q1.description,
 q1.currency,
 q1.modifier_effective_from,
 q1.modifier_effective_to,
 q1.type,
 q1.modifier_automatc_flag,
 q1.modifier_active_flag,
 q1.ask_for,
 q1.global_flag,
 q1.parent_number,
 q1.parent_version,
 q1.data_type_1,
 q1.data_type_1_effective_from,
 q1.data_type_1_effective_to,
 q1.data_type_2,
 q1.data_type_2_effective_from,
 q1.data_type_2_effective_to,
 --
 'List Line' record_type,
 --
 q2.qualifier_group,
 q2.qualifier_grouping_number,
 q2.qualifier_start_date,
 q2.qualifier_end_date,
 q2.qualifier_context,
 q2.qualifier_attribute,
 q2.applies_to_party_hierarchy,
 q2.qualifier_operator_code,
 q2.qualifier_value_from,
 q2.qualifier_value_to,
 --
 q3.list_line_no,
 q3.modifier_level,
 q3.line_effective_from,
 q3.line_effective_to,
 q3.list_line_type,
 q3.print_on_invoice_flag,
 q3.line_automatic_flag,
 q3.line_override_flag,
 q3.line_phase,
 q3.line_bucket,
 q3.line_proration_type,
 q3.comparison_value,
 q3.net_amount_calculation,
 q3.line_incompatibility_group,
 q3.line_product_attribute_type,
 q3.line_comparison_operator_code,
 q3.line_product_value,
 q3.line_precedence,
 q3.line_uom,
 q3.line_volume_type,
 q3.line_value_from,
 q3.line_value_to,
 q3.line_price_break_type,
 q3.accumulation_attribute,
 q3.charge_name,
 q3.line_formula,
 q3.line_appl_method,
 q3.line_value,
 q3.include_on_returns_flag,
 q3.accrual_flag,
 q3.upgrade_item,
 q3.terms_attribute,
 q3.terms_value,
 q3.coupon_expire_date,
 q3.coupon_expire_prd_start_date,
 q3.coupon_expire_periods,
 q3.expire_period_type,
 q3.coupon_benefit_qty,
 q3.coupon_benefit_uom,
 q3.estimated_benefit_rate,
 q3.coupon_conversion_rate,
 q3.coupon_modifier_number,
 --
 q5.related_modifier_group_number,
 q4.price_break_attr_value_from,
 q4.price_break_attr_value_to,
 q5.product_attribute,
 q5.product_attribute_value,
 q6.product_attribute_uom,
 q5.pricing_attribute,
 q5.operator,
 q4.formula,
 q4.application_method,
 q4.value,
 q5.value_from,
 q5.value_to,
 q4.benefit_qty,
 q4.benefit_uom,
 q4.accrual_conversion_rate,
 q5.buy_uom,
 q6.get_quantity,
 q6.get_uom,
 q6.get_price,
 --
 q3.creation_date,
 q3.created_by,
 q3.last_update_date,
 q3.last_updated_by,
 --
 2 sort_order
from
 q1,
 q2,
 q3,
 q4,
 q5,
 q6
where
 nvl2(q1.list_header_id1,-1,-1) = q2.list_header_id2 (+) and
 q1.list_header_id1 = q3.list_header_id3 and
 nvl2(q3.list_line_id3,-1,-1) = q4.parent_list_line_id4 (+) and
 nvl2(q3.list_line_id3,-1,-1) = q5.parent_list_line_id5 (+) and
 nvl2(q3.list_line_id3,-1,-1) = q6.parent_list_line_id6 (+)
 --and
 --not exists
 --(select 'X' from q2 where q3.list_line_id3 = q2.list_line_id2
 -- union
 --(select 'X' from q4 where q3.list_line_id3 = q4.parent_list_line_id4
 -- union
 -- select 'X' from q5 where q3.list_line_id3 = q5.parent_list_line_id5
 -- union
 -- select 'X' from q6 where q3.list_line_id3 = q6.parent_list_line_id6
 --)
--
union
-- List Line Qualifiers
-- Q1, Q3, Q2
select /*+ push_pred(q2) push_pred(q3) push_pred(q4) push_pred(q5) push_pred(q6) */
 q1.modifier_number,
 q1.modifier_name,
 q1.version,
 q1.description,
 q1.currency,
 q1.modifier_effective_from,
 q1.modifier_effective_to,
 q1.type,
 q1.modifier_automatc_flag,
 q1.modifier_active_flag,
 q1.ask_for,
 q1.global_flag,
 q1.parent_number,
 q1.parent_version,
 q1.data_type_1,
 q1.data_type_1_effective_from,
 q1.data_type_1_effective_to,
 q1.data_type_2,
 q1.data_type_2_effective_from,
 q1.data_type_2_effective_to,
 --
 'List Line - Qualifier' record_type,
 --
 q2.qualifier_group,
 q2.qualifier_grouping_number,
 q2.qualifier_start_date,
 q2.qualifier_end_date,
 q2.qualifier_context,
 q2.qualifier_attribute,
 q2.applies_to_party_hierarchy,
 q2.qualifier_operator_code,
 q2.qualifier_value_from,
 q2.qualifier_value_to,
 --
 q3.list_line_no,
 q3.modifier_level,
 q3.line_effective_from,
 q3.line_effective_to,
 q3.list_line_type,
 q3.print_on_invoice_flag,
 q3.line_automatic_flag,
 q3.line_override_flag,
 q3.line_phase,
 q3.line_bucket,
 q3.line_proration_type,
 q3.comparison_value,
 q3.net_amount_calculation,
 q3.line_incompatibility_group,
 q3.line_product_attribute_type,
 q3.line_comparison_operator_code,
 q3.line_product_value,
 q3.line_precedence,
 q3.line_uom,
 q3.line_volume_type,
 q3.line_value_from,
 q3.line_value_to,
 q3.line_price_break_type,
 q3.accumulation_attribute,
 q3.charge_name,
 q3.line_formula,
 q3.line_appl_method,
 q3.line_value,
 q3.include_on_returns_flag,
 q3.accrual_flag,
 q3.upgrade_item,
 q3.terms_attribute,
 q3.terms_value,
 q3.coupon_expire_date,
 q3.coupon_expire_prd_start_date,
 q3.coupon_expire_periods,
 q3.expire_period_type,
 q3.coupon_benefit_qty,
 q3.coupon_benefit_uom,
 q3.estimated_benefit_rate,
 q3.coupon_conversion_rate,
 q3.coupon_modifier_number,
 --
 q5.related_modifier_group_number,
 q4.price_break_attr_value_from,
 q4.price_break_attr_value_to,
 q5.product_attribute,
 q5.product_attribute_value,
 q6.product_attribute_uom,
 q5.pricing_attribute,
 q5.operator,
 q4.formula,
 q4.application_method,
 q4.value,
 q5.value_from,
 q5.value_to,
 q4.benefit_qty,
 q4.benefit_uom,
 q4.accrual_conversion_rate,
 q5.buy_uom,
 q6.get_quantity,
 q6.get_uom,
 q6.get_price,
 --
 q2.creation_date,
 q2.created_by,
 q2.last_update_date,
 q2.last_updated_by,
 --
 3 sort_order
from
 q1,
 q2,
 q3,
 q4,
 q5,
 q6
where
 q1.list_header_id1 = q3.list_header_id3 and
 q3.list_header_id3 = q2.list_header_id2 and
 q3.list_line_id3   = q2.list_line_id2 and
 nvl2(q3.list_line_id3,-1,-1) = q4.parent_list_line_id4 (+) and
 nvl2(q3.list_line_id3,-1,-1) = q5.parent_list_line_id5 (+) and
 nvl2(q3.list_line_id3,-1,-1) = q6.parent_list_line_id6 (+)
--
union
-- Price Breaks
-- Q1, Q3, Q4
select /*+ push_pred(q2) push_pred(q3) push_pred(q4) push_pred(q5) push_pred(q6) */
 q1.modifier_number,
 q1.modifier_name,
 q1.version,
 q1.description,
 q1.currency,
 q1.modifier_effective_from,
 q1.modifier_effective_to,
 q1.type,
 q1.modifier_automatc_flag,
 q1.modifier_active_flag,
 q1.ask_for,
 q1.global_flag,
 q1.parent_number,
 q1.parent_version,
 q1.data_type_1,
 q1.data_type_1_effective_from,
 q1.data_type_1_effective_to,
 q1.data_type_2,
 q1.data_type_2_effective_from,
 q1.data_type_2_effective_to,
 --
 'List Line - Price Break' record_type,
 --
 q2.qualifier_group,
 q2.qualifier_grouping_number,
 q2.qualifier_start_date,
 q2.qualifier_end_date,
 q2.qualifier_context,
 q2.qualifier_attribute,
 q2.applies_to_party_hierarchy,
 q2.qualifier_operator_code,
 q2.qualifier_value_from,
 q2.qualifier_value_to,
 --
 q3.list_line_no,
 q3.modifier_level,
 q3.line_effective_from,
 q3.line_effective_to,
 q3.list_line_type,
 q3.print_on_invoice_flag,
 q3.line_automatic_flag,
 q3.line_override_flag,
 q3.line_phase,
 q3.line_bucket,
 q3.line_proration_type,
 q3.comparison_value,
 q3.net_amount_calculation,
 q3.line_incompatibility_group,
 q3.line_product_attribute_type,
 q3.line_comparison_operator_code,
 q3.line_product_value,
 q3.line_precedence,
 q3.line_uom,
 q3.line_volume_type,
 q3.line_value_from,
 q3.line_value_to,
 q3.line_price_break_type,
 q3.accumulation_attribute,
 q3.charge_name,
 q3.line_formula,
 q3.line_appl_method,
 q3.line_value,
 q3.include_on_returns_flag,
 q3.accrual_flag,
 q3.upgrade_item,
 q3.terms_attribute,
 q3.terms_value,
 q3.coupon_expire_date,
 q3.coupon_expire_prd_start_date,
 q3.coupon_expire_periods,
 q3.expire_period_type,
 q3.coupon_benefit_qty,
 q3.coupon_benefit_uom,
 q3.estimated_benefit_rate,
 q3.coupon_conversion_rate,
 q3.coupon_modifier_number,
 --
 q5.related_modifier_group_number,
 q4.price_break_attr_value_from,
 q4.price_break_attr_value_to,
 q5.product_attribute,
 q5.product_attribute_value,
 q6.product_attribute_uom,
 q5.pricing_attribute,
 q5.operator,
 q4.formula,
 q4.application_method,
 q4.value,
 q5.value_from,
 q5.value_to,
 q4.benefit_qty,
 q4.benefit_uom,
 q4.accrual_conversion_rate,
 q5.buy_uom,
 q6.get_quantity,
 q6.get_uom,
 q6.get_price,
 --
 q4.creation_date,
 q4.created_by,
 q4.last_update_date,
 q4.last_updated_by,
 --
 4 sort_order
from
 q1,
 q2,
 q3,
 q4,
 q5,
 q6
where
 nvl2(q1.list_header_id1,-1,-1) = q2.list_header_id2 (+) and
 q1.list_header_id1 = q3.list_header_id3 and
 q3.list_line_id3 = q4.parent_list_line_id4 and
 nvl2(q3.list_line_id3,-1,-1) = q5.parent_list_line_id5 (+) and
 nvl2(q3.list_line_id3,-1,-1) = q6.parent_list_line_id6 (+)
--
union
-- Pricing Attributes
-- Q1, Q3, Q5
select /*+ push_pred(q2) push_pred(q3) push_pred(q4) push_pred(q5) push_pred(q6) */
 q1.modifier_number,
 q1.modifier_name,
 q1.version,
 q1.description,
 q1.currency,
 q1.modifier_effective_from,
 q1.modifier_effective_to,
 q1.type,
 q1.modifier_automatc_flag,
 q1.modifier_active_flag,
 q1.ask_for,
 q1.global_flag,
 q1.parent_number,
 q1.parent_version,
 q1.data_type_1,
 q1.data_type_1_effective_from,
 q1.data_type_1_effective_to,
 q1.data_type_2,
 q1.data_type_2_effective_from,
 q1.data_type_2_effective_to,
 --
 'List Line - Pricing Attribute' record_type,
 --
 q2.qualifier_group,
 q2.qualifier_grouping_number,
 q2.qualifier_start_date,
 q2.qualifier_end_date,
 q2.qualifier_context,
 q2.qualifier_attribute,
 q2.applies_to_party_hierarchy,
 q2.qualifier_operator_code,
 q2.qualifier_value_from,
 q2.qualifier_value_to,
 --
 q3.list_line_no,
 q3.modifier_level,
 q3.line_effective_from,
 q3.line_effective_to,
 q3.list_line_type,
 q3.print_on_invoice_flag,
 q3.line_automatic_flag,
 q3.line_override_flag,
 q3.line_phase,
 q3.line_bucket,
 q3.line_proration_type,
 q3.comparison_value,
 q3.net_amount_calculation,
 q3.line_incompatibility_group,
 q3.line_product_attribute_type,
 q3.line_comparison_operator_code,
 q3.line_product_value,
 q3.line_precedence,
 q3.line_uom,
 q3.line_volume_type,
 q3.line_value_from,
 q3.line_value_to,
 q3.line_price_break_type,
 q3.accumulation_attribute,
 q3.charge_name,
 q3.line_formula,
 q3.line_appl_method,
 q3.line_value,
 q3.include_on_returns_flag,
 q3.accrual_flag,
 q3.upgrade_item,
 q3.terms_attribute,
 q3.terms_value,
 q3.coupon_expire_date,
 q3.coupon_expire_prd_start_date,
 q3.coupon_expire_periods,
 q3.expire_period_type,
 q3.coupon_benefit_qty,
 q3.coupon_benefit_uom,
 q3.estimated_benefit_rate,
 q3.coupon_conversion_rate,
 q3.coupon_modifier_number,
 --
 q5.related_modifier_group_number,
 q4.price_break_attr_value_from,
 q4.price_break_attr_value_to,
 q5.product_attribute,
 q5.product_attribute_value,
 q6.product_attribute_uom,
 q5.pricing_attribute,
 q5.operator,
 q4.formula,
 q4.application_method,
 q4.value,
 q5.value_from,
 q5.value_to,
 q4.benefit_qty,
 q4.benefit_uom,
 q4.accrual_conversion_rate,
 q5.buy_uom,
 q6.get_quantity,
 q6.get_uom,
 q6.get_price,
 --
 q5.creation_date,
 q5.created_by,
 q5.last_update_date,
 q5.last_updated_by,
 --
 5 sort_order
from
 q1,
 q2,
 q3,
 q4,
 q5,
 q6
where
 nvl2(q1.list_header_id1,-1,-1) = q2.list_header_id2 (+) and
 q1.list_header_id1 = q3.list_header_id3 and
 nvl2(q3.list_line_id3,-1,-1) = q4.parent_list_line_id4 (+) and
 q3.list_line_id3 = q5.parent_list_line_id5 and
 nvl2(q3.list_line_id3,-1,-1) = q6.parent_list_line_id6 (+)
--
union
-- Get Pricing Attributes
-- Q1, Q3, Q6
select /*+ push_pred(q2) push_pred(q3) push_pred(q4) push_pred(q5) push_pred(q6) */
 q1.modifier_number,
 q1.modifier_name,
 q1.version,
 q1.description,
 q1.currency,
 q1.modifier_effective_from,
 q1.modifier_effective_to,
 q1.type,
 q1.modifier_automatc_flag,
 q1.modifier_active_flag,
 q1.ask_for,
 q1.global_flag,
 q1.parent_number,
 q1.parent_version,
 q1.data_type_1,
 q1.data_type_1_effective_from,
 q1.data_type_1_effective_to,
 q1.data_type_2,
 q1.data_type_2_effective_from,
 q1.data_type_2_effective_to,
 --
 'List Line - Pricing Attribute' record_type,
 --
 q2.qualifier_group,
 q2.qualifier_grouping_number,
 q2.qualifier_start_date,
 q2.qualifier_end_date,
 q2.qualifier_context,
 q2.qualifier_attribute,
 q2.applies_to_party_hierarchy,
 q2.qualifier_operator_code,
 q2.qualifier_value_from,
 q2.qualifier_value_to,
 --
 q3.list_line_no,
 q3.modifier_level,
 q3.line_effective_from,
 q3.line_effective_to,
 q3.list_line_type,
 q3.print_on_invoice_flag,
 q3.line_automatic_flag,
 q3.line_override_flag,
 q3.line_phase,
 q3.line_bucket,
 q3.line_proration_type,
 q3.comparison_value,
 q3.net_amount_calculation,
 q3.line_incompatibility_group,
 q3.line_product_attribute_type,
 q3.line_comparison_operator_code,
 q3.line_product_value,
 q3.line_precedence,
 q3.line_uom,
 q3.line_volume_type,
 q3.line_value_from,
 q3.line_value_to,
 q3.line_price_break_type,
 q3.accumulation_attribute,
 q3.charge_name,
 q3.line_formula,
 q3.line_appl_method,
 q3.line_value,
 q3.include_on_returns_flag,
 q3.accrual_flag,
 q3.upgrade_item,
 q3.terms_attribute,
 q3.terms_value,
 q3.coupon_expire_date,
 q3.coupon_expire_prd_start_date,
 q3.coupon_expire_periods,
 q3.expire_period_type,
 q3.coupon_benefit_qty,
 q3.coupon_benefit_uom,
 q3.estimated_benefit_rate,
 q3.coupon_conversion_rate,
 q3.coupon_modifier_number,
 --
 q5.related_modifier_group_number,
 q4.price_break_attr_value_from,
 q4.price_break_attr_value_to,
 q6.product_attribute,
 q6.product_attribute_value,
 q6.product_attribute_uom,
 q5.pricing_attribute,
 q5.operator,
 q6.formula,
 q6.application_method,
 q6.value,
 q5.value_from,
 q5.value_to,
 q4.benefit_qty,
 q4.benefit_uom,
 q4.accrual_conversion_rate,
 q5.buy_uom,
 q6.get_quantity,
 q6.get_uom,
 q6.get_price,
 --
 q6.creation_date,
 q6.created_by,
 q6.last_update_date,
 q6.last_updated_by,
 --
 6 sort_order
from
 q1,
 q2,
 q3,
 q4,
 q5,
 q6
where
 nvl2(q1.list_header_id1,-1,-1) = q2.list_header_id2 (+) and
 q1.list_header_id1 = q3.list_header_id3 and
 nvl2(q3.list_line_id3,-1,-1) = q4.parent_list_line_id4 (+) and
 nvl2(q3.list_line_id3,-1,-1) = q5.parent_list_line_id5 (+) and
 q3.list_line_id3 = q6.parent_list_line_id6
) x
order by
x.modifier_number,
decode(x.sort_order,1,1,2),
x.list_line_no,
x.sort_order,
x.qualifier_group,
x.qualifier_grouping_number