/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: QP Modifier Upload
-- Description: This upload supports the creation and update of Modifiers in Oracle Advanced Pricing.

The upload supports creation/update/deletion of the following entities within a Modifier List:

- Modifier List Qualifiers
- Modifier List Limits
- Modifier Lines
- Modifier Line Price Breaks. To enter the Modifier Price Breaks in the upload, repeat the Modifier Price Break Header Line and enter/adjust the Price Break Columns for each Price Break.
- Modifier Line Additional Buy Items.
- Modifier Line Get Items
- Modifier Line Pricing Attributes
- Modifier Line Qualifiers
- Modifier Line Limits

Notes:

When downloading existing Modifier data into the upload excel:
  - Modifier List level Qualifiers and Limits will be downloaded into separate rows in the excel
  - Modifier Line level Price Breaks, Additional Buy Items, Get Items, Pricing Attributes, Qualifiers, and Limits will be downloaded into separate rows in the excel

This is to minimize the duplication of data in the excel.  

However:
When entering List Header qualifiers and limits, these can be added in the same excel row.
When entering Modifier Lines for upload:  Price Breaks, Additional Buy Items, Get Items, Pricing Attributes, Line Qualifiers, and Limits can be added in the same excel row. 
i.e. You can upload an excel row containing a modifier line details with associated price break and pricing attribute and qualifier etc. 

Modifier Line Numbering
====================
The Modifier Numbering parameter determines if you want the system to automatically generate Modifier Numbers when creating new Modifiers or if the line number specified in the Line No column in the upload should be retained. If Automatic is specified, any Line Numbers specified in the upload excel for new modifier lines will be replaced by a system generated line number on upload.
The Line No column is required when entering modifier line details. The upload uses the combination of List Number, List Version, and Modifier Line No to identify the modifiers. If the combination already exists in Oracle the upload will update the existing modifier, otherwise it will create a new modifier.

Entering Qualifiers
===============
Qualifiers entered on a row with no modifier line details will be uploaded as a list level qualifier. 
Qualifiers entered on a row containing modifier line details will by default be uploaded as a modifier level qualifier. The Qualifier Assignment Level column can be used to override this default behaviour to assign the qualifier to the list header instead of the modifier. 
Qualifier Groups can be copied to the modifier by selecting the Qualifier Group and leaving all other qualifier columns blank. The upload will copy and attach all the qualifier group's qualifiers to the price list.
Alternatively, you can select specific qualifiers from a Qualifier Group by selecting the Qualifier Group and the Qualifier Group Qualifier ID. The upload excel will then default in the details of that qualifier into the excel. In this scenario you would enter each qualifier on a separate row in the excel. 

Entering Limits
===============
Limits entered on a row with no modifier line details will be uploaded as a list level limit. 
Limits entered on a row containing modifier line details will by default be uploaded as a line level limit. The Limit Assignment Level column can be used to override this default behaviour to assign the limit to the list header instead of the modifier Line. 
Limit No is required when entering limit details. The upload uses the combination of List Number, List Version, Modifier Line No (for modifier level limits), and the Limit No to identify the limit. If the combination already exists in Oracle the upload will update the existing limit, otherwise it will create a new modifier.


-- Excel Examle Output: https://www.enginatics.com/example/qp-modifier-upload/
-- Library Link: https://www.enginatics.com/reports/qp-modifier-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
:p_upload_mode upload_mode_,
to_number(null) upload_row,
:p_modifier_numbering modifier_numbering,
to_number(null) mod_list_row_id,
to_number(null) mod_line_row_id,
to_number(null) qualifier_group_row_id,
to_number(null) qualifier_row_id,
to_number(null) price_break_line_row_id,
to_number(null) pricing_attribute_row_id,
to_number(null) excluder_row_id,
to_number(null) buy_line_row_id,
to_number(null) get_line_row_id,
to_number(null) limit_row_id,
to_number(null) limit_att_row_id,
qp.*
from
(
--
-- Q1 List Header Qualifiers
--
select
--
-- Modifier List Header
qslhv.pte_code pte_code,
qslhv.source_system_code source_system_code,
xxen_util.meaning(qslhv.list_type_code,'LIST_TYPE_CODE',661) list_type,
qslhv.orig_system_header_ref list_orig_sys_ref,
qslhv.name list_number,
qslhv.version_no list_version,
qslhv.description list_name,
qslhv.comments list_description,
qslhv.currency_code list_currency,
xxen_util.meaning(nvl(qslhv.global_flag,'Y'),'YES_NO',0) global_list,
qp_util.get_ou_name(qslhv.orig_org_id) operating_unit,
qslhv.start_date_active list_effective_from,
qslhv.end_date_active list_effective_to,
xxen_util.meaning(nvl(qslhv.active_flag,'N'),'YES_NO',0) list_is_active,
xxen_util.meaning(decode(qslhv.automatic_flag,'Y','Y',null),'YES_NO',0) list_is_automatic,
(select qslhv2.name from qp_secu_list_headers_vl qslhv2 where qslhv2.list_header_id = qslhv.parent_list_header_id) list_parent_number,
(select qslhv2.version_no from qp_secu_list_headers_vl qslhv2 where qslhv2.list_header_id = qslhv.parent_list_header_id) list_parent_version,
xxen_util.meaning(decode(qslhv.ask_for_flag,'Y','Y',null),'YES_NO',0) list_is_ask_for,
xxen_util.meaning(qslhv.active_date_first_type,'EFFECTIVE_DATE_TYPES',661) list_date_type1,
qslhv.start_date_active_first list_date_type1_effective_from,
qslhv.end_date_active_first list_date_type1_effective_to,
xxen_util.meaning(qslhv.active_date_second_type,'EFFECTIVE_DATE_TYPES',661) list_date_type2,
qslhv.start_date_active_second list_date_type2_effective_from,
qslhv.end_date_active_second list_date_type2_effective_to,
xxen_util.meaning(decode(qslhv.gsa_indicator,'Y','Y',null),'YES_NO',0) list_gsa_indicator,
--
xxen_util.display_flexfield_context(661,'QP_LIST_HEADERS',qslhv.context) list_header_dff_context,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE1',qslhv.row_id,qslhv.attribute1) list_header_attribute1,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE2',qslhv.row_id,qslhv.attribute2) list_header_attribute2,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE3',qslhv.row_id,qslhv.attribute3) list_header_attribute3,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE4',qslhv.row_id,qslhv.attribute4) list_header_attribute4,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE5',qslhv.row_id,qslhv.attribute5) list_header_attribute5,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE6',qslhv.row_id,qslhv.attribute6) list_header_attribute6,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE7',qslhv.row_id,qslhv.attribute7) list_header_attribute7,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE8',qslhv.row_id,qslhv.attribute8) list_header_attribute8,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE9',qslhv.row_id,qslhv.attribute9) list_header_attribute9,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE10',qslhv.row_id,qslhv.attribute10) list_header_attribute10,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE11',qslhv.row_id,qslhv.attribute11) list_header_attribute11,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE12',qslhv.row_id,qslhv.attribute12) list_header_attribute12,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE13',qslhv.row_id,qslhv.attribute13) list_header_attribute13,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE14',qslhv.row_id,qslhv.attribute14) list_header_attribute14,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE15',qslhv.row_id,qslhv.attribute15) list_header_attribute15,
--
-- Modifier Line
-- summary
null line_orig_sys_ref,
null line_no,
null line_modifier_level,
null line_modifier_type,
to_date(null) line_effective_from,
to_date(null) line_effective_to,
null delete_modifier_line,
null line_automatic,
null line_allow_override,
null line_pricing_phase,
null line_incompatibility_group,
to_number(null) line_bucket,
null line_proration_type,
to_number(null) line_comparison_value,
null line_product_attribute,
null line_product_value,
null line_product_description,
to_number(null) line_precedence,
null line_volume_type,
null line_price_break_type,
null line_operator,
null line_product_uom,
null line_value_from,
null line_value_to,
-- Discounts/Charges
null charge_name,
null include_on_returns,
null formula,
null application_method,
to_number(null) value,
--- Promotion Upgrade
null upgrade_item,
--  Promotion Terms
null terms_attribute,
null terms_value,
--  Coupons
null coupon_modifier_no,
-- Price Break Header
null pbh_adjustment_type,
null pbh_accumulation_attribute,
null pbh_net_amount_calculation,
-- Price Break Line
null price_break_orig_sys_ref,
to_number(null) price_break_value_from,
to_number(null) price_break_value_to,
null price_break_application_method,
to_number(null) price_break_value,
null price_break_formula,
to_number(null) price_break_benefit_quantity,
null price_break_benefit_uom,
to_number(null) price_break_accrual_conv_rate,
null delete_price_break,
-- Accruals
null accrue,
to_number(null) benefit_qty,
null benefit_uom,
to_date(null) expiration_date,
to_date(null) expiration_period_start_date,
to_number(null) expiration_periods,
null expiration_period_type,
to_number(null) accrual_redemption_rate,
to_number(null) accrual_conversion_rate,
null rebate_transaction_type,
-- Line DFF Attributes
null list_line_dff_context,
null list_line_attribute1,
null list_line_attribute2,
null list_line_attribute3,
null list_line_attribute4,
null list_line_attribute5,
null list_line_attribute6,
null list_line_attribute7,
null list_line_attribute8,
null list_line_attribute9,
null list_line_attribute10,
null list_line_attribute11,
null list_line_attribute12,
null list_line_attribute13,
null list_line_attribute14,
null list_line_attribute15,
--
-- Additional Buy Products
null buy_orig_sys_ref,
to_number(null) buy_group_no,
null buy_product_attribute,
null buy_product_value,
null buy_pricing_attribute,
null buy_operator,
null buy_value_from,
null buy_value_to,
null buy_uom,
null delete_buy_item,
--
-- Get Products
null get_orig_sys_ref,
null get_product_attribute,
null get_product_value,
null get_product_uom,
to_number(null) get_quantity,
null get_uom,
null get_price_list,
to_number(null) get_price,
null get_formula,
null get_application_method,
to_number(null) get_value,
null delete_get_item,
--
-- Pricing Attributes
null pricing_attribute_orig_sys_ref,
null pricing_attribute_context,
null pricing_attribute,
null pricing_attribute_operator,
null pricing_attribute_value_from,
null pricing_attribute_val_fr_desc,
null pricing_attribute_value_to,
null delete_pricing_attribute,
--
-- Excluder
null excluder_orig_sys_ref,
null excluder_flag,
null excluder_product_attribute,
null excluder_product_value,
null excluder_product_description,
null delete_excluder,
--
-- Qualifiers
xxen_util.meaning('HEADER','ZX_ROUNDING_LEVEL',0) qualifier_assignment_level,
xxen_qp_upload.get_orig_sys_ref('QUALIFIER',qqv.qualifier_id) qualifier_orig_sys_ref,
qqv.rule_name qualifier_group,
to_number(null) qualifier_group_qualifier_id,
qqv.qualifier_grouping_no qualifier_grouping_number,
qp_util.get_context('QP_ATTR_DEFNS_QUALIFIER',qqv.qualifier_context) qualifier_context,
qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_QUALIFIER',qqv.qualifier_context,qqv.qualifier_attribute) qualifier_attribute,
xxen_util.meaning(decode(qqv.qualify_hier_descendents_flag,'Y','Y',null),'YES_NO',0) qualifier_applies_party_hier,
qqv.qualifier_precedence qualifier_precedence,
qqv.comparision_operator_code qualifier_operator,
rtrim(replace(
 qp_util.get_attribute_value
 ('QP_ATTR_DEFNS_QUALIFIER',
  qqv.qualifier_context,
  qp_qp_form_pricing_attr.get_segment_name('QP_ATTR_DEFNS_QUALIFIER',qqv.qualifier_context, qqv.qualifier_attribute),
  qqv.qualifier_attr_value,
  qqv.comparision_operator_code
 ),chr(0),null)
) qualifier_value_from,
rtrim(replace(
 qp_util.get_attribute_value_meaning
 ('QP_ATTR_DEFNS_QUALIFIER',
  qqv.qualifier_context,
  qp_qp_form_pricing_attr.get_segment_name('QP_ATTR_DEFNS_QUALIFIER',qqv.qualifier_context, qqv.qualifier_attribute),
  qqv.qualifier_attr_value,
  qqv.comparision_operator_code
 ),chr(0),null)
) qualifier_value_from_desc,
qp_util.get_attribute_value
('QP_ATTR_DEFNS_QUALIFIER',
 qqv.qualifier_context,
 qp_qp_form_pricing_attr.get_segment_name('QP_ATTR_DEFNS_QUALIFIER',qqv.qualifier_context, qqv.qualifier_attribute),
 qqv.qualifier_attr_value_to,
 qqv.comparision_operator_code
) qualifier_value_to,
qqv.start_date_active qualifier_start_date,
qqv.end_date_active qualifier_end_date,
null delete_qualifier,
--
xxen_util.display_flexfield_context(661,'QP_QUALIFIERS',qqv.context) qualifier_dff_context,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE1',qqv.row_id,qqv.attribute1) qualifier_attribute1,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE2',qqv.row_id,qqv.attribute2) qualifier_attribute2,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE3',qqv.row_id,qqv.attribute3) qualifier_attribute3,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE4',qqv.row_id,qqv.attribute4) qualifier_attribute4,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE5',qqv.row_id,qqv.attribute5) qualifier_attribute5,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE6',qqv.row_id,qqv.attribute6) qualifier_attribute6,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE7',qqv.row_id,qqv.attribute7) qualifier_attribute7,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE8',qqv.row_id,qqv.attribute8) qualifier_attribute8,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE9',qqv.row_id,qqv.attribute9) qualifier_attribute9,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE10',qqv.row_id,qqv.attribute10) qualifier_attribute10,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE11',qqv.row_id,qqv.attribute11) qualifier_attribute11,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE12',qqv.row_id,qqv.attribute12) qualifier_attribute12,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE13',qqv.row_id,qqv.attribute13) qualifier_attribute13,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE14',qqv.row_id,qqv.attribute14) qualifier_attribute14,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE15',qqv.row_id,qqv.attribute15) qualifier_attribute15,
--
-- Limits
null limit_assignment_level,
to_number(null) limit_no,
null limit_basis,
null limit_enforced,
to_number(null) limit_amount,
null limit_by_organization,
null limit_constraint_1,
null limit_context_1,
null limit_attribute_1,
null limit_constraint_2,
null limit_context_2,
null limit_attribute_2,
null limit_when_exceeded,
null limit_hold,
null delete_limit,
-- Limit Other Attributes
null limit_oth_att_constraint,
null limit_oth_att_context,
null limit_oth_att_attribute,
null limit_oth_att_value,
null limit_other_att_meaning,
null delete_limit_oth_att,
--
-- IDs
qslhv.list_header_id modifier_list_id,
to_number(null) modifier_line_id,
to_number(null) price_break_line_id,
to_number(null) buy_line_id,
to_number(null) get_line_id,
to_number(null) pricing_attribute_id,
to_number(null) excluder_id,
qqv.qualifier_id qualifier_id,
to_number(null) limit_id,
to_number(null) limit_attribute_id,
'List Qualifier' row_type,
1.0 seq
from
qp_secu_list_headers_vl qslhv,
qp_qualifiers_v qqv
where
1=1 and
:p_show_header_qualifiers = 'Y' and
nvl(qslhv.pte_code,'ORDFUL') <> 'LOGSTX' and
nvl(qslhv.pte_code,'ORDFUL') = :p_pte_code and
nvl(qslhv.source_system_code,'QP') = :p_appl_sn and
nvl(qslhv.list_source_code,'null') not in ('BSO','OKS') and
qslhv.update_flag = 'Y' and
((nvl(:p_gsa_pricing,'N') = 'N' and
  nvl(qslhv.gsa_indicator,'N') = 'N' and
  ((qp_util.get_qp_status = 'I' and qslhv.list_type_code in ('DLT', 'SLT', 'PRO', 'DEL', 'CHARGES')) or
   (qp_util.get_qp_status = 'S' and qslhv.list_type_code in ('DLT', 'SLT', 'CHARGES'))
  )
 ) or
 (nvl(:p_gsa_pricing,'N') = 'Y' and
  nvl(qslhv.gsa_indicator,'N') = 'Y' and
  qslhv.list_type_code = 'DLT' and
  qslhv.active_flag = 'Y'
 )
) and
(qslhv.global_flag = 'Y' or mo_global.check_access(qslhv.orig_org_id) = 'Y') and
--
qslhv.list_header_id = qqv.list_header_id and
qqv.list_line_id = -1 and
(nvl(:p_gsa_pricing,'N') = 'N' or
 not (qqv.qualifier_context = 'CUSTOMER' and qqv.qualifier_attribute = 'QUALIFIER_ATTRIBUTE15' and qqv.qualifier_attr_value = 'Y')
) and
exists
(select
 null
 from
 qp_modifier_summary_v qmsv
 where
 2=2 and
 qslhv.list_header_id = qmsv.list_header_id and
 (qmsv.pricing_attribute_context is null or qmsv.pricing_attribute_context = 'VOLUME') and
 nvl(qmsv.excluder_flag,'N') = 'N'
)
--
union
--
-- Q2 List Header Limits
--
select
--
-- Modifier List Header
qslhv.pte_code pte_code,
qslhv.source_system_code source_system_code,
xxen_util.meaning(qslhv.list_type_code,'LIST_TYPE_CODE',661) list_type,
qslhv.orig_system_header_ref list_orig_sys_ref,
qslhv.name list_number,
qslhv.version_no list_version,
qslhv.description list_name,
qslhv.comments list_description,
qslhv.currency_code list_currency,
xxen_util.meaning(nvl(qslhv.global_flag,'Y'),'YES_NO',0) global_list,
qp_util.get_ou_name(qslhv.orig_org_id) operating_unit,
qslhv.start_date_active list_effective_from,
qslhv.end_date_active list_effective_to,
xxen_util.meaning(nvl(qslhv.active_flag,'N'),'YES_NO',0) list_is_active,
xxen_util.meaning(decode(qslhv.automatic_flag,'Y','Y',null),'YES_NO',0) list_is_automatic,
(select qslhv2.name from qp_secu_list_headers_vl qslhv2 where qslhv2.list_header_id = qslhv.parent_list_header_id) list_parent_number,
(select qslhv2.version_no from qp_secu_list_headers_vl qslhv2 where qslhv2.list_header_id = qslhv.parent_list_header_id) list_parent_version,
xxen_util.meaning(decode(qslhv.ask_for_flag,'Y','Y',null),'YES_NO',0) list_is_ask_for,
xxen_util.meaning(qslhv.active_date_first_type,'EFFECTIVE_DATE_TYPES',661) list_date_type1,
qslhv.start_date_active_first list_date_type1_effective_from,
qslhv.end_date_active_first list_date_type1_effective_to,
xxen_util.meaning(qslhv.active_date_second_type,'EFFECTIVE_DATE_TYPES',661) list_date_type2,
qslhv.start_date_active_second list_date_type2_effective_from,
qslhv.end_date_active_second list_date_type2_effective_to,
xxen_util.meaning(decode(qslhv.gsa_indicator,'Y','Y',null),'YES_NO',0) list_gsa_indicator,
--
xxen_util.display_flexfield_context(661,'QP_LIST_HEADERS',qslhv.context) list_header_dff_context,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE1',qslhv.row_id,qslhv.attribute1) list_header_attribute1,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE2',qslhv.row_id,qslhv.attribute2) list_header_attribute2,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE3',qslhv.row_id,qslhv.attribute3) list_header_attribute3,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE4',qslhv.row_id,qslhv.attribute4) list_header_attribute4,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE5',qslhv.row_id,qslhv.attribute5) list_header_attribute5,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE6',qslhv.row_id,qslhv.attribute6) list_header_attribute6,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE7',qslhv.row_id,qslhv.attribute7) list_header_attribute7,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE8',qslhv.row_id,qslhv.attribute8) list_header_attribute8,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE9',qslhv.row_id,qslhv.attribute9) list_header_attribute9,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE10',qslhv.row_id,qslhv.attribute10) list_header_attribute10,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE11',qslhv.row_id,qslhv.attribute11) list_header_attribute11,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE12',qslhv.row_id,qslhv.attribute12) list_header_attribute12,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE13',qslhv.row_id,qslhv.attribute13) list_header_attribute13,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE14',qslhv.row_id,qslhv.attribute14) list_header_attribute14,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE15',qslhv.row_id,qslhv.attribute15) list_header_attribute15,
--
-- Modifier Line
-- summary
null line_orig_sys_ref,
null line_no,
null line_modifier_level,
null line_modifier_type,
to_date(null) line_effective_from,
to_date(null) line_effective_to,
null delete_modifier_line,
null line_automatic,
null line_allow_override,
null line_pricing_phase,
null line_incompatibility_group,
to_number(null) line_bucket,
null line_proration_type,
to_number(null) line_comparison_value,
null line_product_attribute,
null line_product_value,
null line_product_description,
to_number(null) line_precedence,
null line_volume_type,
null line_price_break_type,
null line_operator,
null line_product_uom,
null line_value_from,
null line_value_to,
-- Discounts/Charges
null charge_name,
null include_on_returns,
null formula,
null application_method,
to_number(null) value,
--- Promotion Upgrade
null upgrade_item,
--  Promotion Terms
null terms_attribute,
null terms_value,
--  Coupons
null coupon_modifier_no,
-- Price Break Header
null pbh_adjustment_type,
null pbh_accumulation_attribute,
null pbh_net_amount_calculation,
-- Price Break Line
null price_break_orig_sys_ref,
to_number(null) price_break_value_from,
to_number(null) price_break_value_to,
null price_break_application_method,
to_number(null) price_break_value,
null price_break_formula,
to_number(null) price_break_benefit_quantity,
null price_break_benefit_uom,
to_number(null) price_break_accrual_conv_rate,
null delete_price_break,
-- Accruals
null accrue,
to_number(null) benefit_qty,
null benefit_uom,
to_date(null) expiration_date,
to_date(null) expiration_period_start_date,
to_number(null) expiration_periods,
null expiration_period_type,
to_number(null) accrual_redemption_rate,
to_number(null) accrual_conversion_rate,
null rebate_transaction_type,
-- Line DFF Attributes
null list_line_dff_context,
null list_line_attribute1,
null list_line_attribute2,
null list_line_attribute3,
null list_line_attribute4,
null list_line_attribute5,
null list_line_attribute6,
null list_line_attribute7,
null list_line_attribute8,
null list_line_attribute9,
null list_line_attribute10,
null list_line_attribute11,
null list_line_attribute12,
null list_line_attribute13,
null list_line_attribute14,
null list_line_attribute15,
--
-- Additional Buy Products
null buy_orig_sys_ref,
to_number(null) buy_group_no,
null buy_product_attribute,
null buy_product_value,
null buy_pricing_attribute,
null buy_operator,
null buy_value_from,
null buy_value_to,
null buy_uom,
null delete_buy_item,
--
-- Get Products
null get_orig_sys_ref,
null get_product_attribute,
null get_product_value,
null get_product_uom,
to_number(null) get_quantity,
null get_uom,
null get_price_list,
to_number(null) get_price,
null get_formula,
null get_application_method,
to_number(null) get_value,
null delete_get_item,
--
-- Pricing Attributes
null pricing_attribute_orig_sys_ref,
null pricing_attribute_context,
null pricing_attribute,
null pricing_attribute_operator,
null pricing_attribute_value_from,
null pricing_attribute_val_fr_desc,
null pricing_attribute_value_to,
null delete_pricing_attribute,
--
-- Excluder
null excluder_orig_sys_ref,
null excluder_flag,
null excluder_product_attribute,
null excluder_product_value,
null excluder_product_description,
null delete_excluder,
--
-- Qualifiers
null qualifier_assignment_level,
null qualifier_orig_sys_ref,
null qualifier_group,
to_number(null) qualifier_group_qualifier_id,
to_number(null) qualifier_grouping_number,
null qualifier_context,
null qualifier_attribute,
null qualifier_applies_party_hier,
to_number(null) qualifier_precedence,
null qualifier_operator,
null qualifier_value_from,
null qualifier_value_from_desc,
null qualifier_value_to,
to_date(null) qualifier_start_date,
to_date(null) qualifier_end_date,
null delete_qualifier,
--
null qualifier_dff_context,
null qualifier_attribute1,
null qualifier_attribute2,
null qualifier_attribute3,
null qualifier_attribute4,
null qualifier_attribute5,
null qualifier_attribute6,
null qualifier_attribute7,
null qualifier_attribute8,
null qualifier_attribute9,
null qualifier_attribute10,
null qualifier_attribute11,
null qualifier_attribute12,
null qualifier_attribute13,
null qualifier_attribute14,
null qualifier_attribute15,
--
-- Limits
xxen_util.meaning('HEADER','ZX_ROUNDING_LEVEL',0) limit_assignment_level,
qlv.limit_number limit_no,
xxen_util.meaning(qlv.basis,'QP_LIMIT_BASIS',661) limit_basis,
xxen_util.meaning(qlv.limit_level_code,'LIMIT_LEVEL',661) limit_enforced,
qlv.amount limit_amount,
xxen_util.meaning(decode(qlv.organization_flag,'Y','Y',null),'YES_NO',0) limit_by_organization,
xxen_util.meaning(qlv.multival_attr1_type,'LIMIT_ATTRIBUTE_TYPE',661) limit_constraint_1,
case qlv.multival_attr1_type
when 'QUALIFIER' then qp_util.get_context('QP_ATTR_DEFNS_QUALIFIER',qlv.multival_attr1_context)
when 'PRODUCT' then qp_util.get_context('QP_ATTR_DEFNS_PRICING',qlv.multival_attr1_context)
else null
end limit_context_1,
case qlv.multival_attr1_type
when 'QUALIFIER' then qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_QUALIFIER',qlv.multival_attr1_context,qlv.multival_attribute1)
when 'PRODUCT' then qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qlv.multival_attr1_context,qlv.multival_attribute1)
else null
end limit_attribute_1,
xxen_util.meaning(qlv.multival_attr2_type,'LIMIT_ATTRIBUTE_TYPE',661) limit_constraint_2,
case qlv.multival_attr2_type
when 'QUALIFIER' then qp_util.get_context('QP_ATTR_DEFNS_QUALIFIER',qlv.multival_attr2_context)
when 'PRODUCT' then qp_util.get_context('QP_ATTR_DEFNS_PRICING',qlv.multival_attr2_context)
else null
end limit_context_2,
case qlv.multival_attr2_type
when 'QUALIFIER' then qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_QUALIFIER',qlv.multival_attr2_context,qlv.multival_attribute2)
when 'PRODUCT' then qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qlv.multival_attr2_context,qlv.multival_attribute2)
else null
end limit_attribute_2,
xxen_util.meaning(qlv.limit_exceed_action_code,'LIMIT_EXCEED_ACTION',661) limit_when_exceeded,
xxen_util.meaning(decode(qlv.limit_hold_flag,'Y','Y',null),'YES_NO',0) limit_hold,
null delete_limit,
-- Limit Other Attributes
xxen_util.meaning(qlav.limit_attribute_type,'LIMIT_ATTRIBUTE_TYPE',661) limit_oth_att_constraint,
case qlav.limit_attribute_type
when 'QUALIFIER' then qp_util.get_context('QP_ATTR_DEFNS_QUALIFIER',qlav.limit_attribute_context)
when 'PRODUCT' then qp_util.get_context('QP_ATTR_DEFNS_PRICING',qlav.limit_attribute_context)
else null
end limit_oth_att_context,
case qlav.limit_attribute_type
when 'QUALIFIER' then qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_QUALIFIER',qlav.limit_attribute_context,qlav.limit_attribute)
when 'PRODUCT' then qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qlav.limit_attribute_context,qlav.limit_attribute)
else null
end limit_oth_att_attribute,
--
case qlav.limit_attribute_type
when 'QUALIFIER' then
  rtrim(replace(
   qp_util.get_attribute_value
   ('QP_ATTR_DEFNS_QUALIFIER',
    qlav.limit_attribute_context,
    qp_qp_form_pricing_attr.get_segment_name('QP_ATTR_DEFNS_QUALIFIER',qlav.limit_attribute_context,qlav.limit_attribute),
    qlav.limit_attr_value,
    qlav.comparison_operator_code
   ),chr(0),null)
  )
when 'PRODUCT' then
  qp_price_list_line_util.get_product_value('QP_ATTR_DEFNS_PRICING' ,qlav.limit_attribute_context,qlav.limit_attribute,qlav.limit_attr_value)
else null
end limit_oth_att_value,
case qlav.limit_attribute_type
when 'QUALIFIER' then
  rtrim(replace(
   qp_util.get_attribute_value_meaning
   ('QP_ATTR_DEFNS_QUALIFIER',
    qlav.limit_attribute_context,
    qp_qp_form_pricing_attr.get_segment_name('QP_ATTR_DEFNS_QUALIFIER',qlav.limit_attribute_context,qlav.limit_attribute),
    qlav.limit_attr_value,
    qlav.comparison_operator_code
   ),chr(0),null)
  )
when 'PRODUCT' then
  xxen_qp_upload.get_product_description
  (qslhv.pte_code,
   qp_util.get_context('QP_ATTR_DEFNS_PRICING',qlav.limit_attribute_context),
   qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qlav.limit_attribute_context,qlav.limit_attribute),
   qlav.limit_attr_value,
   qp_price_list_line_util.Get_Product_Value('QP_ATTR_DEFNS_PRICING' ,qlav.limit_attribute_context,qlav.limit_attribute,qlav.limit_attr_value)
  )
else null
end limit_other_att_meaning,
null delete_limit_oth_att,
--
-- IDs
qslhv.list_header_id modifier_list_id,
to_number(null) modifier_line_id,
to_number(null) price_break_line_id,
to_number(null) buy_line_id,
to_number(null) get_line_id,
to_number(null) pricing_attribute_id,
to_number(null) excluder_id,
to_number(null) qualifier_id,
qlv.limit_id,
qlav.limit_attribute_id,
'List Limit' row_type,
1.1 seq
from
qp_secu_list_headers_vl qslhv,
qp_limits_v qlv,
qp_limit_attributes_v qlav
where
1=1 and
:p_show_header_limits = 'Y' and
nvl(qslhv.pte_code,'ORDFUL') <> 'LOGSTX' and
nvl(qslhv.pte_code,'ORDFUL') = :p_pte_code and
nvl(qslhv.source_system_code,'QP') = :p_appl_sn and
nvl(qslhv.list_source_code,'null') not in ('BSO','OKS') and
qslhv.update_flag = 'Y' and
((nvl(:p_gsa_pricing,'N') = 'N' and
  nvl(qslhv.gsa_indicator,'N') = 'N' and
  ((qp_util.get_qp_status = 'I' and qslhv.list_type_code in ('DLT', 'SLT', 'PRO', 'DEL', 'CHARGES')) or
   (qp_util.get_qp_status = 'S' and qslhv.list_type_code in ('DLT', 'SLT', 'CHARGES'))
  )
 ) or
 (nvl(:p_gsa_pricing,'N') = 'Y' and
  nvl(qslhv.gsa_indicator,'N') = 'Y' and
  qslhv.list_type_code = 'DLT' and
  qslhv.active_flag = 'Y'
 )
) and
(qslhv.global_flag = 'Y' or mo_global.check_access(qslhv.orig_org_id) = 'Y') and
--
qslhv.list_header_id = qlv.list_header_id and
qlv.list_line_id = -1 and
qlv.limit_id = qlav.limit_id (+) and
exists
(select
 null
 from
 qp_modifier_summary_v qmsv
 where
 2=2 and
 qslhv.list_header_id = qmsv.list_header_id and
 (qmsv.pricing_attribute_context is null or qmsv.pricing_attribute_context = 'VOLUME') and
 nvl(qmsv.excluder_flag,'N') = 'N'
)
--
union
--
-- Q3 Modifier Line Price Breaks
--
select
--
-- Modifier List Header
qslhv.pte_code pte_code,
qslhv.source_system_code source_system_code,
xxen_util.meaning(qslhv.list_type_code,'LIST_TYPE_CODE',661) list_type,
qslhv.orig_system_header_ref list_orig_sys_ref,
qslhv.name list_number,
qslhv.version_no list_version,
qslhv.description list_name,
qslhv.comments list_description,
qslhv.currency_code list_currency,
xxen_util.meaning(nvl(qslhv.global_flag,'Y'),'YES_NO',0) global_list,
qp_util.get_ou_name(qslhv.orig_org_id) operating_unit,
qslhv.start_date_active list_effective_from,
qslhv.end_date_active list_effective_to,
xxen_util.meaning(nvl(qslhv.active_flag,'N'),'YES_NO',0) list_is_active,
xxen_util.meaning(decode(qslhv.automatic_flag,'Y','Y',null),'YES_NO',0) list_is_automatic,
(select qslhv2.name from qp_secu_list_headers_vl qslhv2 where qslhv2.list_header_id = qslhv.parent_list_header_id) list_parent_number,
(select qslhv2.version_no from qp_secu_list_headers_vl qslhv2 where qslhv2.list_header_id = qslhv.parent_list_header_id) list_parent_version,
xxen_util.meaning(decode(qslhv.ask_for_flag,'Y','Y',null),'YES_NO',0) list_is_ask_for,
xxen_util.meaning(qslhv.active_date_first_type,'EFFECTIVE_DATE_TYPES',661) list_date_type1,
qslhv.start_date_active_first list_date_type1_effective_from,
qslhv.end_date_active_first list_date_type1_effective_to,
xxen_util.meaning(qslhv.active_date_second_type,'EFFECTIVE_DATE_TYPES',661) list_date_type2,
qslhv.start_date_active_second list_date_type2_effective_from,
qslhv.end_date_active_second list_date_type2_effective_to,
xxen_util.meaning(decode(qslhv.gsa_indicator,'Y','Y',null),'YES_NO',0) list_gsa_indicator,
--
xxen_util.display_flexfield_context(661,'QP_LIST_HEADERS',qslhv.context) list_header_dff_context,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE1',qslhv.row_id,qslhv.attribute1) list_header_attribute1,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE2',qslhv.row_id,qslhv.attribute2) list_header_attribute2,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE3',qslhv.row_id,qslhv.attribute3) list_header_attribute3,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE4',qslhv.row_id,qslhv.attribute4) list_header_attribute4,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE5',qslhv.row_id,qslhv.attribute5) list_header_attribute5,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE6',qslhv.row_id,qslhv.attribute6) list_header_attribute6,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE7',qslhv.row_id,qslhv.attribute7) list_header_attribute7,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE8',qslhv.row_id,qslhv.attribute8) list_header_attribute8,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE9',qslhv.row_id,qslhv.attribute9) list_header_attribute9,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE10',qslhv.row_id,qslhv.attribute10) list_header_attribute10,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE11',qslhv.row_id,qslhv.attribute11) list_header_attribute11,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE12',qslhv.row_id,qslhv.attribute12) list_header_attribute12,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE13',qslhv.row_id,qslhv.attribute13) list_header_attribute13,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE14',qslhv.row_id,qslhv.attribute14) list_header_attribute14,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE15',qslhv.row_id,qslhv.attribute15) list_header_attribute15,
--
-- Modifier Line
-- summary
xxen_qp_upload.get_orig_sys_ref('LINE',qmsv.list_line_id) line_orig_sys_ref,
qmsv.list_line_no line_no,
qmsv.modifier_level line_modifier_level,
qmsv.list_line_type line_modifier_type,
qmsv.start_date_active line_effective_from,
qmsv.end_date_active line_effective_to,
null delete_modifier_line,
xxen_util.meaning(decode(qmsv.automatic_flag,'Y','Y',null),'YES_NO',0) line_automatic,
xxen_util.meaning(decode(qmsv.override_flag,'Y','Y',null),'YES_NO',0) line_allow_override,
qmsv.pricing_phase line_pricing_phase,
qmsv.incompatibility_grp line_incompatibility_group,
qmsv.pricing_group_sequence line_bucket,
qmsv.proration_type line_proration_type,
qmsv.estim_gl_value line_comparison_value,
qmsv.product_attribute_type line_product_attribute,
qmsv.product_attr_value line_product_value,
xxen_qp_upload.get_product_description(qslhv.pte_code,qp_util.get_context('QP_ATTR_DEFNS_PRICING',qmsv.product_attribute_context),qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qmsv.product_attribute_context,qmsv.product_attr),qmsv.product_attr_val,qmsv.product_attr_value) line_product_description,
qmsv.product_precedence line_precedence,
qmsv.pricing_attribute line_volume_type,
qmsv.price_break_type line_price_break_type,
qmsv.comparison_operator_code line_operator,
qmsv.product_uom_code line_product_uom,
qmsv.pricing_attr_value_from line_value_from,
qmsv.pricing_attr_value_to line_value_to,
-- Discounts/Charges
qmsv.charge_name charge_name,
xxen_util.meaning(decode(qmsv.include_on_returns_flag,'Y','Y',null),'YES_NO',0) include_on_returns,
qmsv.formula formula,
qmsv.arithmetic_operator_type application_method,
qmsv.operand value,
--- Promotion Upgrade
qmsv.related_item upgrade_item,
-- Promotion Terms
qmsv.substitution_attribute terms_attribute,
qmsv.substitution_value terms_value,
-- Coupons
qmsv.coup_list_line_no coupon_modifier_no,
-- Price Break Header
(select
 xxen_util.meaning(qll.list_line_type_code,'LIST_LINE_TYPE_CODE',661)
 from
 qp_list_lines  qll
 where
 qll.list_line_id = (select min(qrm.to_rltd_modifier_id) from qp_rltd_modifiers qrm where qrm.from_rltd_modifier_id = qmsv.list_line_id)
) pbh_adjustment_type,
qmsv.accum_attribute pbh_accumulation_attribute,
xxen_util.meaning(qmsv.net_amount_flag,'QP_NET_AMOUNT_CALCULATION',661) pbh_net_amount_calculation,
-- Price Break Line
xxen_qp_upload.get_orig_sys_ref('LINE',qpbv.list_line_id) price_break_orig_sys_ref,
qpbv.pricing_attr_value_from_number price_break_value_from,
qpbv.pricing_attr_value_to_number price_break_value_to,
xxen_util.meaning(qpbv.arithmetic_operator,'ARITHMETIC_OPERATOR',661) price_break_application_method,
qpbv.operand price_break_value,
nvl2(qpbv.price_by_formula_id,qp_qp_form_pricing_attr.get_formula(qpbv.price_by_formula_id),null) price_break_formula,
qpbv.benefit_qty price_break_benefit_quantity,
qpbv.benefit_uom_code price_break_benefit_uom,
qpbv.accrual_conversion_rate price_break_accrual_conv_rate,
null delete_price_break,
-- Accruals
xxen_util.meaning(decode(qmsv.db_accrual_flag,'Y','Y',null),'YES_NO',0) accrue,
qmsv.db_benefit_qty benefit_qty,
qmsv.db_benefit_uom_code benefit_uom,
qmsv.db_expiration_date expiration_date,
qmsv.db_exp_period_start_date expiration_period_start_date,
qmsv.db_number_expiration_periods expiration_periods,
qmsv.db_expiration_period_uom expiration_period_type,
qmsv.db_estim_accrual_rate accrual_redemption_rate,
qmsv.db_accrual_conversion_rate accrual_conversion_rate,
decode(qmsv.list_line_type_code,'DIS',qmsv.rebate_transaction_type,'PBH',qmsv.brk_reb_transaction_type,null) rebate_transaction_type,
-- Line DFF Attributes
xxen_util.display_flexfield_context(661,'QP_LIST_LINES',qmsv.context) list_line_dff_context,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE1',qmsv.row_id,qmsv.attribute1) list_line_attribute1,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE2',qmsv.row_id,qmsv.attribute2) list_line_attribute2,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE3',qmsv.row_id,qmsv.attribute3) list_line_attribute3,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE4',qmsv.row_id,qmsv.attribute4) list_line_attribute4,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE5',qmsv.row_id,qmsv.attribute5) list_line_attribute5,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE6',qmsv.row_id,qmsv.attribute6) list_line_attribute6,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE7',qmsv.row_id,qmsv.attribute7) list_line_attribute7,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE8',qmsv.row_id,qmsv.attribute8) list_line_attribute8,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE9',qmsv.row_id,qmsv.attribute9) list_line_attribute9,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE10',qmsv.row_id,qmsv.attribute10) list_line_attribute10,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE11',qmsv.row_id,qmsv.attribute11) list_line_attribute11,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE12',qmsv.row_id,qmsv.attribute12) list_line_attribute12,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE13',qmsv.row_id,qmsv.attribute13) list_line_attribute13,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE14',qmsv.row_id,qmsv.attribute14) list_line_attribute14,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE15',qmsv.row_id,qmsv.attribute15) list_line_attribute15,
--
-- Additional Buy Products
null buy_orig_sys_ref,
to_number(null) buy_group_no,
null buy_product_attribute,
null buy_product_value,
null buy_pricing_attribute,
null buy_operator,
null buy_value_from,
null buy_value_to,
null buy_uom,
null delete_buy_item,
--
-- Get Products
null get_orig_sys_ref,
null get_product_attribute,
null get_product_value,
null get_product_uom,
to_number(null) get_quantity,
null get_uom,
null get_price_list,
to_number(null) get_price,
null get_formula,
null get_application_method,
to_number(null) get_value,
null delete_get_item,
--
-- Pricing Attributes
null pricing_attribute_orig_sys_ref,
null pricing_attribute_context,
null pricing_attribute,
null pricing_attribute_operator,
null pricing_attribute_value_from,
null pricing_attribute_val_fr_desc,
null pricing_attribute_value_to,
null delete_pricing_attribute,
--
-- Excluder
null excluder_orig_sys_ref,
null excluder_flag,
null excluder_product_attribute,
null excluder_product_value,
null excluder_product_description,
null delete_excluder,
--
-- Qualifiers
null qualifier_assignment_level,
null qualifier_orig_sys_ref,
null qualifier_group,
to_number(null) qualifier_group_qualifier_id,
to_number(null) qualifier_grouping_number,
null qualifier_context,
null qualifier_attribute,
null qualifier_applies_party_hier,
to_number(null) qualifier_precedence,
null qualifier_operator,
null qualifier_value_from,
null qualifier_value_from_desc,
null qualifier_value_to,
to_date(null) qualifier_start_date,
to_date(null) qualifier_end_date,
null delete_qualifier,
--
null qualifier_dff_context,
null qualifier_attribute1,
null qualifier_attribute2,
null qualifier_attribute3,
null qualifier_attribute4,
null qualifier_attribute5,
null qualifier_attribute6,
null qualifier_attribute7,
null qualifier_attribute8,
null qualifier_attribute9,
null qualifier_attribute10,
null qualifier_attribute11,
null qualifier_attribute12,
null qualifier_attribute13,
null qualifier_attribute14,
null qualifier_attribute15,
--
-- Limits
null limit_assignment_level,
to_number(null) limit_no,
null limit_basis,
null limit_enforced,
to_number(null) limit_amount,
null limit_by_organization,
null limit_constraint_1,
null limit_context_1,
null limit_attribute_1,
null limit_constraint_2,
null limit_context_2,
null limit_attribute_2,
null limit_when_exceeded,
null limit_hold,
null delete_limit,
-- Limit Other Attributes
null limit_oth_att_constraint,
null limit_oth_att_context,
null limit_oth_att_attribute,
null limit_oth_att_value,
null limit_other_att_meaning,
null delete_limit_oth_att,
--
-- IDs
qslhv.list_header_id modifier_list_id,
qmsv.list_line_id modifier_line_id,
qpbv.list_line_id price_break_line_id,
to_number(null) buy_line_id,
to_number(null) get_line_id,
to_number(null) pricing_attribute_id,
to_number(null) excluder_id,
to_number(null) qualifier_id,
to_number(null) limit_id,
to_number(null) limit_attribute_id,
'Price Break' row_type,
2.0 seq
from
qp_secu_list_headers_vl qslhv,
qp_modifier_summary_v qmsv,
qp_price_breaks_v qpbv
where
1=1 and
2=2 and
:p_show_modifier_lines = 'Y' and
:p_show_price_breaks = 'Y' and
nvl(qslhv.pte_code,'ORDFUL') <> 'LOGSTX' and
nvl(qslhv.pte_code,'ORDFUL') = :p_pte_code and
nvl(qslhv.source_system_code,'QP') = :p_appl_sn and
nvl(qslhv.list_source_code,'null') not in ('BSO','OKS') and
qslhv.update_flag = 'Y' and
((nvl(:p_gsa_pricing,'N') = 'N' and
  nvl(qslhv.gsa_indicator,'N') = 'N' and
  ((qp_util.get_qp_status = 'I' and qslhv.list_type_code in ('DLT', 'SLT', 'PRO', 'DEL', 'CHARGES')) or
   (qp_util.get_qp_status = 'S' and qslhv.list_type_code in ('DLT', 'SLT', 'CHARGES'))
  )
 ) or
 (nvl(:p_gsa_pricing,'N') = 'Y' and
  nvl(qslhv.gsa_indicator,'N') = 'Y' and
  qslhv.list_type_code = 'DLT' and
  qslhv.active_flag = 'Y'
 )
) and
(qslhv.global_flag = 'Y' or mo_global.check_access(qslhv.orig_org_id) = 'Y') and
-- modifier lines
qslhv.list_header_id = qmsv.list_header_id and
(qmsv.pricing_attribute_context is null or qmsv.pricing_attribute_context = 'VOLUME') and
nvl(qmsv.excluder_flag,'N') = 'N' and
qmsv.list_line_type_code = 'PBH' and
-- price breaks
qmsv.list_line_id = qpbv.parent_list_line_id
--
union
--
-- Q4 Modifier Additional Buy Products
--
select
--
-- Modifier List Header
qslhv.pte_code pte_code,
qslhv.source_system_code source_system_code,
xxen_util.meaning(qslhv.list_type_code,'LIST_TYPE_CODE',661) list_type,
qslhv.orig_system_header_ref list_orig_sys_ref,
qslhv.name list_number,
qslhv.version_no list_version,
qslhv.description list_name,
qslhv.comments list_description,
qslhv.currency_code list_currency,
xxen_util.meaning(nvl(qslhv.global_flag,'Y'),'YES_NO',0) global_list,
qp_util.get_ou_name(qslhv.orig_org_id) operating_unit,
qslhv.start_date_active list_effective_from,
qslhv.end_date_active list_effective_to,
xxen_util.meaning(nvl(qslhv.active_flag,'N'),'YES_NO',0) list_is_active,
xxen_util.meaning(decode(qslhv.automatic_flag,'Y','Y',null),'YES_NO',0) list_is_automatic,
(select qslhv2.name from qp_secu_list_headers_vl qslhv2 where qslhv2.list_header_id = qslhv.parent_list_header_id) list_parent_number,
(select qslhv2.version_no from qp_secu_list_headers_vl qslhv2 where qslhv2.list_header_id = qslhv.parent_list_header_id) list_parent_version,
xxen_util.meaning(decode(qslhv.ask_for_flag,'Y','Y',null),'YES_NO',0) list_is_ask_for,
xxen_util.meaning(qslhv.active_date_first_type,'EFFECTIVE_DATE_TYPES',661) list_date_type1,
qslhv.start_date_active_first list_date_type1_effective_from,
qslhv.end_date_active_first list_date_type1_effective_to,
xxen_util.meaning(qslhv.active_date_second_type,'EFFECTIVE_DATE_TYPES',661) list_date_type2,
qslhv.start_date_active_second list_date_type2_effective_from,
qslhv.end_date_active_second list_date_type2_effective_to,
xxen_util.meaning(decode(qslhv.gsa_indicator,'Y','Y',null),'YES_NO',0) list_gsa_indicator,
--
xxen_util.display_flexfield_context(661,'QP_LIST_HEADERS',qslhv.context) list_header_dff_context,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE1',qslhv.row_id,qslhv.attribute1) list_header_attribute1,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE2',qslhv.row_id,qslhv.attribute2) list_header_attribute2,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE3',qslhv.row_id,qslhv.attribute3) list_header_attribute3,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE4',qslhv.row_id,qslhv.attribute4) list_header_attribute4,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE5',qslhv.row_id,qslhv.attribute5) list_header_attribute5,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE6',qslhv.row_id,qslhv.attribute6) list_header_attribute6,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE7',qslhv.row_id,qslhv.attribute7) list_header_attribute7,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE8',qslhv.row_id,qslhv.attribute8) list_header_attribute8,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE9',qslhv.row_id,qslhv.attribute9) list_header_attribute9,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE10',qslhv.row_id,qslhv.attribute10) list_header_attribute10,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE11',qslhv.row_id,qslhv.attribute11) list_header_attribute11,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE12',qslhv.row_id,qslhv.attribute12) list_header_attribute12,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE13',qslhv.row_id,qslhv.attribute13) list_header_attribute13,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE14',qslhv.row_id,qslhv.attribute14) list_header_attribute14,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE15',qslhv.row_id,qslhv.attribute15) list_header_attribute15,
--
-- Modifier Line
-- summary
xxen_qp_upload.get_orig_sys_ref('LINE',qmsv.list_line_id) line_orig_sys_ref,
qmsv.list_line_no line_no,
qmsv.modifier_level line_modifier_level,
qmsv.list_line_type line_modifier_type,
qmsv.start_date_active line_effective_from,
qmsv.end_date_active line_effective_to,
null delete_modifier_line,
xxen_util.meaning(decode(qmsv.automatic_flag,'Y','Y',null),'YES_NO',0) line_automatic,
xxen_util.meaning(decode(qmsv.override_flag,'Y','Y',null),'YES_NO',0) line_allow_override,
qmsv.pricing_phase line_pricing_phase,
qmsv.incompatibility_grp line_incompatibility_group,
qmsv.pricing_group_sequence line_bucket,
qmsv.proration_type line_proration_type,
qmsv.estim_gl_value line_comparison_value,
qmsv.product_attribute_type line_product_attribute,
qmsv.product_attr_value line_product_value,
xxen_qp_upload.get_product_description(qslhv.pte_code,qp_util.get_context('QP_ATTR_DEFNS_PRICING',qmsv.product_attribute_context),qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qmsv.product_attribute_context,qmsv.product_attr),qmsv.product_attr_val,qmsv.product_attr_value) line_product_description,
qmsv.product_precedence line_precedence,
qmsv.pricing_attribute line_volume_type,
qmsv.price_break_type line_price_break_type,
qmsv.comparison_operator_code line_operator,
qmsv.product_uom_code line_product_uom,
qmsv.pricing_attr_value_from line_value_from,
qmsv.pricing_attr_value_to line_value_to,
-- Discounts/Charges
qmsv.charge_name charge_name,
xxen_util.meaning(decode(qmsv.include_on_returns_flag,'Y','Y',null),'YES_NO',0) include_on_returns,
qmsv.formula formula,
qmsv.arithmetic_operator_type application_method,
qmsv.operand value,
--- Promotion Upgrade
qmsv.related_item upgrade_item,
-- Promotion Terms
qmsv.substitution_attribute terms_attribute,
qmsv.substitution_value terms_value,
-- Coupons
qmsv.coup_list_line_no coupon_modifier_no,
-- Price Break Header
(select
 xxen_util.meaning(qll.list_line_type_code,'LIST_LINE_TYPE_CODE',661)
 from
 qp_list_lines  qll
 where
 qll.list_line_id = (select min(qrm.to_rltd_modifier_id) from qp_rltd_modifiers qrm where qrm.from_rltd_modifier_id = qmsv.list_line_id)
) pbh_adjustment_type,
qmsv.accum_attribute pbh_accumulation_attribute,
xxen_util.meaning(qmsv.net_amount_flag,'QP_NET_AMOUNT_CALCULATION',661) pbh_net_amount_calculation,
-- Price Break Line
null price_break_orig_sys_ref,
to_number(null) price_break_value_from,
to_number(null) price_break_value_to,
null price_break_application_method,
to_number(null) price_break_value,
null price_break_formula,
to_number(null) price_break_benefit_quantity,
null price_break_benefit_uom,
to_number(null) price_break_accrual_conv_rate,
null delete_price_break,
-- Accruals
xxen_util.meaning(decode(qmsv.db_accrual_flag,'Y','Y',null),'YES_NO',0) accrue,
qmsv.db_benefit_qty benefit_qty,
qmsv.db_benefit_uom_code benefit_uom,
qmsv.db_expiration_date expiration_date,
qmsv.db_exp_period_start_date expiration_period_start_date,
qmsv.db_number_expiration_periods expiration_periods,
qmsv.db_expiration_period_uom expiration_period_type,
qmsv.db_estim_accrual_rate accrual_redemption_rate,
qmsv.db_accrual_conversion_rate accrual_conversion_rate,
decode(qmsv.list_line_type_code,'DIS',qmsv.rebate_transaction_type,'PBH',qmsv.brk_reb_transaction_type,null) rebate_transaction_type,
-- Line DFF Attributes
xxen_util.display_flexfield_context(661,'QP_LIST_LINES',qmsv.context) list_line_dff_context,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE1',qmsv.row_id,qmsv.attribute1) list_line_attribute1,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE2',qmsv.row_id,qmsv.attribute2) list_line_attribute2,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE3',qmsv.row_id,qmsv.attribute3) list_line_attribute3,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE4',qmsv.row_id,qmsv.attribute4) list_line_attribute4,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE5',qmsv.row_id,qmsv.attribute5) list_line_attribute5,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE6',qmsv.row_id,qmsv.attribute6) list_line_attribute6,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE7',qmsv.row_id,qmsv.attribute7) list_line_attribute7,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE8',qmsv.row_id,qmsv.attribute8) list_line_attribute8,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE9',qmsv.row_id,qmsv.attribute9) list_line_attribute9,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE10',qmsv.row_id,qmsv.attribute10) list_line_attribute10,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE11',qmsv.row_id,qmsv.attribute11) list_line_attribute11,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE12',qmsv.row_id,qmsv.attribute12) list_line_attribute12,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE13',qmsv.row_id,qmsv.attribute13) list_line_attribute13,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE14',qmsv.row_id,qmsv.attribute14) list_line_attribute14,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE15',qmsv.row_id,qmsv.attribute15) list_line_attribute15,
--
-- Additional Buy Products
xxen_qp_upload.get_orig_sys_ref('LIST_LINE',qpav.list_line_id) buy_orig_sys_ref,
qpav.rltd_modifier_grp_no buy_group_no,
qp_qp_form_pricing_attr.get_attribute ('QP_ATTR_DEFNS_PRICING', qpav.product_attribute_context, qpav.product_attribute) buy_product_attribute,
qp_price_list_line_util.get_product_value ('QP_ATTR_DEFNS_PRICING', qpav.product_attribute_context, qpav.product_attribute, qpav.product_attr_value) buy_product_value,
qp_qp_form_pricing_attr.get_attribute ('QP_ATTR_DEFNS_PRICING',qpav.pricing_attribute_context,qpav.pricing_attribute) buy_pricing_attribute,
qpav.comparison_operator_code buy_operator,
qpav.pricing_attr_value_from buy_value_from,
qpav.pricing_attr_value_to buy_value_to,
qpav.product_uom_code buy_uom,
null delete_buy_item,
--
-- Get Products
null get_orig_sys_ref,
null get_product_attribute,
null get_product_value,
null get_product_uom,
to_number(null) get_quantity,
null get_uom,
null get_price_list,
to_number(null) get_price,
null get_formula,
null get_application_method,
to_number(null) get_value,
null delete_get_item,
--
-- Pricing Attributes
null pricing_attribute_orig_sys_ref,
null pricing_attribute_context,
null pricing_attribute,
null pricing_attribute_operator,
null pricing_attribute_value_from,
null pricing_attribute_val_fr_desc,
null pricing_attribute_value_to,
null delete_pricing_attribute,
--
-- Excluder
null excluder_orig_sys_ref,
null excluder_flag,
null excluder_product_attribute,
null excluder_product_value,
null excluder_product_description,
null delete_excluder,
--
-- Qualifiers
null qualifier_assignment_level,
null qualifier_orig_sys_ref,
null qualifier_group,
to_number(null) qualifier_group_qualifier_id,
to_number(null) qualifier_grouping_number,
null qualifier_context,
null qualifier_attribute,
null qualifier_applies_party_hier,
to_number(null) qualifier_precedence,
null qualifier_operator,
null qualifier_value_from,
null qualifier_value_from_desc,
null qualifier_value_to,
to_date(null) qualifier_start_date,
to_date(null) qualifier_end_date,
null delete_qualifier,
--
null qualifier_dff_context,
null qualifier_attribute1,
null qualifier_attribute2,
null qualifier_attribute3,
null qualifier_attribute4,
null qualifier_attribute5,
null qualifier_attribute6,
null qualifier_attribute7,
null qualifier_attribute8,
null qualifier_attribute9,
null qualifier_attribute10,
null qualifier_attribute11,
null qualifier_attribute12,
null qualifier_attribute13,
null qualifier_attribute14,
null qualifier_attribute15,
--
-- Limits
null limit_assignment_level,
to_number(null) limit_no,
null limit_basis,
null limit_enforced,
to_number(null) limit_amount,
null limit_by_organization,
null limit_constraint_1,
null limit_context_1,
null limit_attribute_1,
null limit_constraint_2,
null limit_context_2,
null limit_attribute_2,
null limit_when_exceeded,
null limit_hold,
null delete_limit,
-- Limit Other Attributes
null limit_oth_att_constraint,
null limit_oth_att_context,
null limit_oth_att_attribute,
null limit_oth_att_value,
null limit_other_att_meaning,
null delete_limit_oth_att,
--
-- IDs
qslhv.list_header_id modifier_list_id,
qmsv.list_line_id modifier_line_id,
to_number(null) price_break_line_id,
qpav.list_line_id buy_line_id,
to_number(null) get_line_id,
to_number(null) pricing_attribute_id,
to_number(null) excluder_id,
to_number(null) qualifier_id,
to_number(null) limit_id,
to_number(null) limit_attribute_id,
'Buy' row_type,
2.1 seq
from
qp_secu_list_headers_vl qslhv,
qp_modifier_summary_v qmsv,
qp_pricing_attr_v qpav
where
1=1 and
2=2 and
:p_show_modifier_lines = 'Y' and
:p_show_promotional_items = 'Y' and
nvl(qslhv.pte_code,'ORDFUL') <> 'LOGSTX' and
nvl(qslhv.pte_code,'ORDFUL') = :p_pte_code and
nvl(qslhv.source_system_code,'QP') = :p_appl_sn and
nvl(qslhv.list_source_code,'null') not in ('BSO','OKS') and
qslhv.update_flag = 'Y' and
((nvl(:p_gsa_pricing,'N') = 'N' and
  nvl(qslhv.gsa_indicator,'N') = 'N' and
  ((qp_util.get_qp_status = 'I' and qslhv.list_type_code in ('DLT', 'SLT', 'PRO', 'DEL', 'CHARGES')) or
   (qp_util.get_qp_status = 'S' and qslhv.list_type_code in ('DLT', 'SLT', 'CHARGES'))
  )
 ) or
 (nvl(:p_gsa_pricing,'N') = 'Y' and
  nvl(qslhv.gsa_indicator,'N') = 'Y' and
  qslhv.list_type_code = 'DLT' and
  qslhv.active_flag = 'Y'
 )
) and
(qslhv.global_flag = 'Y' or mo_global.check_access(qslhv.orig_org_id) = 'Y') and
-- modifier lines
qslhv.list_header_id = qmsv.list_header_id and
(qmsv.pricing_attribute_context is null or qmsv.pricing_attribute_context = 'VOLUME') and
nvl(qmsv.excluder_flag,'N') = 'N' and
qmsv.list_line_type_code in ('PRG','OID') and
-- price breaks
qmsv.list_line_id = qpav.parent_list_line_id
--
union
--
-- Q5 Modifier Get Products
--
select
--
-- Modifier List Header
qslhv.pte_code pte_code,
qslhv.source_system_code source_system_code,
xxen_util.meaning(qslhv.list_type_code,'LIST_TYPE_CODE',661) list_type,
qslhv.orig_system_header_ref list_orig_sys_ref,
qslhv.name list_number,
qslhv.version_no list_version,
qslhv.description list_name,
qslhv.comments list_description,
qslhv.currency_code list_currency,
xxen_util.meaning(nvl(qslhv.global_flag,'Y'),'YES_NO',0) global_list,
qp_util.get_ou_name(qslhv.orig_org_id) operating_unit,
qslhv.start_date_active list_effective_from,
qslhv.end_date_active list_effective_to,
xxen_util.meaning(nvl(qslhv.active_flag,'N'),'YES_NO',0) list_is_active,
xxen_util.meaning(decode(qslhv.automatic_flag,'Y','Y',null),'YES_NO',0) list_is_automatic,
(select qslhv2.name from qp_secu_list_headers_vl qslhv2 where qslhv2.list_header_id = qslhv.parent_list_header_id) list_parent_number,
(select qslhv2.version_no from qp_secu_list_headers_vl qslhv2 where qslhv2.list_header_id = qslhv.parent_list_header_id) list_parent_version,
xxen_util.meaning(decode(qslhv.ask_for_flag,'Y','Y',null),'YES_NO',0) list_is_ask_for,
xxen_util.meaning(qslhv.active_date_first_type,'EFFECTIVE_DATE_TYPES',661) list_date_type1,
qslhv.start_date_active_first list_date_type1_effective_from,
qslhv.end_date_active_first list_date_type1_effective_to,
xxen_util.meaning(qslhv.active_date_second_type,'EFFECTIVE_DATE_TYPES',661) list_date_type2,
qslhv.start_date_active_second list_date_type2_effective_from,
qslhv.end_date_active_second list_date_type2_effective_to,
xxen_util.meaning(decode(qslhv.gsa_indicator,'Y','Y',null),'YES_NO',0) list_gsa_indicator,
--
xxen_util.display_flexfield_context(661,'QP_LIST_HEADERS',qslhv.context) list_header_dff_context,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE1',qslhv.row_id,qslhv.attribute1) list_header_attribute1,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE2',qslhv.row_id,qslhv.attribute2) list_header_attribute2,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE3',qslhv.row_id,qslhv.attribute3) list_header_attribute3,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE4',qslhv.row_id,qslhv.attribute4) list_header_attribute4,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE5',qslhv.row_id,qslhv.attribute5) list_header_attribute5,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE6',qslhv.row_id,qslhv.attribute6) list_header_attribute6,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE7',qslhv.row_id,qslhv.attribute7) list_header_attribute7,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE8',qslhv.row_id,qslhv.attribute8) list_header_attribute8,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE9',qslhv.row_id,qslhv.attribute9) list_header_attribute9,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE10',qslhv.row_id,qslhv.attribute10) list_header_attribute10,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE11',qslhv.row_id,qslhv.attribute11) list_header_attribute11,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE12',qslhv.row_id,qslhv.attribute12) list_header_attribute12,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE13',qslhv.row_id,qslhv.attribute13) list_header_attribute13,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE14',qslhv.row_id,qslhv.attribute14) list_header_attribute14,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE15',qslhv.row_id,qslhv.attribute15) list_header_attribute15,
--
-- Modifier Line
-- summary
xxen_qp_upload.get_orig_sys_ref('LINE',qmsv.list_line_id) line_orig_sys_ref,
qmsv.list_line_no line_no,
qmsv.modifier_level line_modifier_level,
qmsv.list_line_type line_modifier_type,
qmsv.start_date_active line_effective_from,
qmsv.end_date_active line_effective_to,
null delete_modifier_line,
xxen_util.meaning(decode(qmsv.automatic_flag,'Y','Y',null),'YES_NO',0) line_automatic,
xxen_util.meaning(decode(qmsv.override_flag,'Y','Y',null),'YES_NO',0) line_allow_override,
qmsv.pricing_phase line_pricing_phase,
qmsv.incompatibility_grp line_incompatibility_group,
qmsv.pricing_group_sequence line_bucket,
qmsv.proration_type line_proration_type,
qmsv.estim_gl_value line_comparison_value,
qmsv.product_attribute_type line_product_attribute,
qmsv.product_attr_value line_product_value,
xxen_qp_upload.get_product_description(qslhv.pte_code,qp_util.get_context('QP_ATTR_DEFNS_PRICING',qmsv.product_attribute_context),qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qmsv.product_attribute_context,qmsv.product_attr),qmsv.product_attr_val,qmsv.product_attr_value) line_product_description,
qmsv.product_precedence line_precedence,
qmsv.pricing_attribute line_volume_type,
qmsv.price_break_type line_price_break_type,
qmsv.comparison_operator_code line_operator,
qmsv.product_uom_code line_product_uom,
qmsv.pricing_attr_value_from line_value_from,
qmsv.pricing_attr_value_to line_value_to,
-- Discounts/Charges
qmsv.charge_name charge_name,
xxen_util.meaning(decode(qmsv.include_on_returns_flag,'Y','Y',null),'YES_NO',0) include_on_returns,
qmsv.formula formula,
qmsv.arithmetic_operator_type application_method,
qmsv.operand value,
--- Promotion Upgrade
qmsv.related_item upgrade_item,
-- Promotion Terms
qmsv.substitution_attribute terms_attribute,
qmsv.substitution_value terms_value,
-- Coupons
qmsv.coup_list_line_no coupon_modifier_no,
-- Price Break Header
(select
 xxen_util.meaning(qll.list_line_type_code,'LIST_LINE_TYPE_CODE',661)
 from
 qp_list_lines  qll
 where
 qll.list_line_id = (select min(qrm.to_rltd_modifier_id) from qp_rltd_modifiers qrm where qrm.from_rltd_modifier_id = qmsv.list_line_id and qrm.rltd_modifier_grp_type = 'PRICE BREAK')
) pbh_adjustment_type,
qmsv.accum_attribute pbh_accumulation_attribute,
xxen_util.meaning(qmsv.net_amount_flag,'QP_NET_AMOUNT_CALCULATION',661) pbh_net_amount_calculation,
-- Price Break Line
null price_break_orig_sys_ref,
to_number(null) price_break_value_from,
to_number(null) price_break_value_to,
null price_break_application_method,
to_number(null) price_break_value,
null price_break_formula,
to_number(null) price_break_benefit_quantity,
null price_break_benefit_uom,
to_number(null) price_break_accrual_conv_rate,
null delete_price_break,
-- Accruals
xxen_util.meaning(decode(qmsv.db_accrual_flag,'Y','Y',null),'YES_NO',0) accrue,
qmsv.db_benefit_qty benefit_qty,
qmsv.db_benefit_uom_code benefit_uom,
qmsv.db_expiration_date expiration_date,
qmsv.db_exp_period_start_date expiration_period_start_date,
qmsv.db_number_expiration_periods expiration_periods,
qmsv.db_expiration_period_uom expiration_period_type,
qmsv.db_estim_accrual_rate accrual_redemption_rate,
qmsv.db_accrual_conversion_rate accrual_conversion_rate,
decode(qmsv.list_line_type_code,'DIS',qmsv.rebate_transaction_type,'PBH',qmsv.brk_reb_transaction_type,null) rebate_transaction_type,
-- Line DFF Attributes
xxen_util.display_flexfield_context(661,'QP_LIST_LINES',qmsv.context) list_line_dff_context,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE1',qmsv.row_id,qmsv.attribute1) list_line_attribute1,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE2',qmsv.row_id,qmsv.attribute2) list_line_attribute2,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE3',qmsv.row_id,qmsv.attribute3) list_line_attribute3,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE4',qmsv.row_id,qmsv.attribute4) list_line_attribute4,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE5',qmsv.row_id,qmsv.attribute5) list_line_attribute5,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE6',qmsv.row_id,qmsv.attribute6) list_line_attribute6,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE7',qmsv.row_id,qmsv.attribute7) list_line_attribute7,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE8',qmsv.row_id,qmsv.attribute8) list_line_attribute8,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE9',qmsv.row_id,qmsv.attribute9) list_line_attribute9,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE10',qmsv.row_id,qmsv.attribute10) list_line_attribute10,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE11',qmsv.row_id,qmsv.attribute11) list_line_attribute11,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE12',qmsv.row_id,qmsv.attribute12) list_line_attribute12,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE13',qmsv.row_id,qmsv.attribute13) list_line_attribute13,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE14',qmsv.row_id,qmsv.attribute14) list_line_attribute14,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE15',qmsv.row_id,qmsv.attribute15) list_line_attribute15,
--
-- Additional Buy Products
null buy_orig_sys_ref,
to_number(null) buy_group_no,
null buy_product_attribute,
null buy_product_value,
null buy_pricing_attribute,
null buy_operator,
null buy_value_from,
null buy_value_to,
null buy_uom,
null delete_buy_item,
--
-- Get Products
xxen_qp_upload.get_orig_sys_ref('LIST_LINE',qpagv.list_line_id) get_orig_sys_ref,
qp_qp_form_pricing_attr.get_attribute ('QP_ATTR_DEFNS_PRICING', qpagv.product_attribute_context, qpagv.product_attribute) get_product_attribute,
qp_price_list_line_util.get_product_value ('QP_ATTR_DEFNS_PRICING', qpagv.product_attribute_context, qpagv.product_attribute, qpagv.product_attr_value) get_product_value,
qpagv.product_uom_code get_product_uom,
qpagv.benefit_qty get_quantity,
qpagv.benefit_uom_code get_uom,
(select qslhv.name from qp_secu_list_headers_vl qslhv,qp_list_lines qll where qslhv.list_header_id = qll.list_header_id and qll.list_line_id = qpagv.benefit_price_list_line_id) get_price_list,
(select nvl(qll.operand,0) from qp_list_lines qll where qll.list_line_id = qpagv.benefit_price_list_line_id) get_price,
qp_qp_form_pricing_attr.get_formula(qpagv.price_by_formula_id) get_formula,
qp_qp_form_pricing_attr.get_meaning(qpagv.arithmetic_operator,'ARITHMETIC_OPERATOR') get_application_method,
qpagv.operand get_value,
null delete_get_item,
--
-- Pricing Attributes
null pricing_attribute_orig_sys_ref,
null pricing_attribute_context,
null pricing_attribute,
null pricing_attribute_operator,
null pricing_attribute_value_from,
null pricing_attribute_val_fr_desc,
null pricing_attribute_value_to,
null delete_pricing_attribute,
--
-- Excluder
null excluder_orig_sys_ref,
null excluder_flag,
null excluder_product_attribute,
null excluder_product_value,
null excluder_product_description,
null delete_excluder,
--
-- Qualifiers
null qualifier_assignment_level,
null qualifier_orig_sys_ref,
null qualifier_group,
to_number(null) qualifier_group_qualifier_id,
to_number(null) qualifier_grouping_number,
null qualifier_context,
null qualifier_attribute,
null qualifier_applies_party_hier,
to_number(null) qualifier_precedence,
null qualifier_operator,
null qualifier_value_from,
null qualifier_value_from_desc,
null qualifier_value_to,
to_date(null) qualifier_start_date,
to_date(null) qualifier_end_date,
null delete_qualifier,
--
null qualifier_dff_context,
null qualifier_attribute1,
null qualifier_attribute2,
null qualifier_attribute3,
null qualifier_attribute4,
null qualifier_attribute5,
null qualifier_attribute6,
null qualifier_attribute7,
null qualifier_attribute8,
null qualifier_attribute9,
null qualifier_attribute10,
null qualifier_attribute11,
null qualifier_attribute12,
null qualifier_attribute13,
null qualifier_attribute14,
null qualifier_attribute15,
--
-- Limits
null limit_assignment_level,
to_number(null) limit_no,
null limit_basis,
null limit_enforced,
to_number(null) limit_amount,
null limit_by_organization,
null limit_constraint_1,
null limit_context_1,
null limit_attribute_1,
null limit_constraint_2,
null limit_context_2,
null limit_attribute_2,
null limit_when_exceeded,
null limit_hold,
null delete_limit,
-- Limit Other Attributes
null limit_oth_att_constraint,
null limit_oth_att_context,
null limit_oth_att_attribute,
null limit_oth_att_value,
null limit_other_att_meaning,
null delete_limit_oth_att,
--
-- IDs
qslhv.list_header_id modifier_list_id,
qmsv.list_line_id modifier_line_id,
to_number(null) price_break_line_id,
to_number(null) buy_line_id,
qpagv.list_line_id get_line_id,
to_number(null) pricing_attribute_id,
to_number(null) excluder_id,
to_number(null) qualifier_id,
to_number(null) limit_id,
to_number(null) limit_attribute_id,
'Get' row_type,
2.2 seq
from
qp_secu_list_headers_vl qslhv,
qp_modifier_summary_v qmsv,
qp_pricing_attr_get_v qpagv
where
1=1 and
2=2 and
:p_show_modifier_lines = 'Y' and
:p_show_promotional_items = 'Y' and
nvl(qslhv.pte_code,'ORDFUL') <> 'LOGSTX' and
nvl(qslhv.pte_code,'ORDFUL') = :p_pte_code and
nvl(qslhv.source_system_code,'QP') = :p_appl_sn and
nvl(qslhv.list_source_code,'null') not in ('BSO','OKS') and
qslhv.update_flag = 'Y' and
((nvl(:p_gsa_pricing,'N') = 'N' and
  nvl(qslhv.gsa_indicator,'N') = 'N' and
  ((qp_util.get_qp_status = 'I' and qslhv.list_type_code in ('DLT', 'SLT', 'PRO', 'DEL', 'CHARGES')) or
   (qp_util.get_qp_status = 'S' and qslhv.list_type_code in ('DLT', 'SLT', 'CHARGES'))
  )
 ) or
 (nvl(:p_gsa_pricing,'N') = 'Y' and
  nvl(qslhv.gsa_indicator,'N') = 'Y' and
  qslhv.list_type_code = 'DLT' and
  qslhv.active_flag = 'Y'
 )
) and
(qslhv.global_flag = 'Y' or mo_global.check_access(qslhv.orig_org_id) = 'Y') and
-- modifier lines
qslhv.list_header_id = qmsv.list_header_id and
(qmsv.pricing_attribute_context is null or qmsv.pricing_attribute_context = 'VOLUME') and
nvl(qmsv.excluder_flag,'N') = 'N' and
qmsv.list_line_type_code in ('PRG','OID') and
-- price breaks
qmsv.list_line_id = qpagv.parent_list_line_id
--
union
--
-- Q6 Modifier Lines + Pricing Attributes
--
select
--
-- Modifier List Header
qslhv.pte_code pte_code,
qslhv.source_system_code source_system_code,
xxen_util.meaning(qslhv.list_type_code,'LIST_TYPE_CODE',661) list_type,
qslhv.orig_system_header_ref list_orig_sys_ref,
qslhv.name list_number,
qslhv.version_no list_version,
qslhv.description list_name,
qslhv.comments list_description,
qslhv.currency_code list_currency,
xxen_util.meaning(nvl(qslhv.global_flag,'Y'),'YES_NO',0) global_list,
qp_util.get_ou_name(qslhv.orig_org_id) operating_unit,
qslhv.start_date_active list_effective_from,
qslhv.end_date_active list_effective_to,
xxen_util.meaning(nvl(qslhv.active_flag,'N'),'YES_NO',0) list_is_active,
xxen_util.meaning(decode(qslhv.automatic_flag,'Y','Y',null),'YES_NO',0) list_is_automatic,
(select qslhv2.name from qp_secu_list_headers_vl qslhv2 where qslhv2.list_header_id = qslhv.parent_list_header_id) list_parent_number,
(select qslhv2.version_no from qp_secu_list_headers_vl qslhv2 where qslhv2.list_header_id = qslhv.parent_list_header_id) list_parent_version,
xxen_util.meaning(decode(qslhv.ask_for_flag,'Y','Y',null),'YES_NO',0) list_is_ask_for,
xxen_util.meaning(qslhv.active_date_first_type,'EFFECTIVE_DATE_TYPES',661) list_date_type1,
qslhv.start_date_active_first list_date_type1_effective_from,
qslhv.end_date_active_first list_date_type1_effective_to,
xxen_util.meaning(qslhv.active_date_second_type,'EFFECTIVE_DATE_TYPES',661) list_date_type2,
qslhv.start_date_active_second list_date_type2_effective_from,
qslhv.end_date_active_second list_date_type2_effective_to,
xxen_util.meaning(decode(qslhv.gsa_indicator,'Y','Y',null),'YES_NO',0) list_gsa_indicator,
--
xxen_util.display_flexfield_context(661,'QP_LIST_HEADERS',qslhv.context) list_header_dff_context,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE1',qslhv.row_id,qslhv.attribute1) list_header_attribute1,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE2',qslhv.row_id,qslhv.attribute2) list_header_attribute2,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE3',qslhv.row_id,qslhv.attribute3) list_header_attribute3,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE4',qslhv.row_id,qslhv.attribute4) list_header_attribute4,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE5',qslhv.row_id,qslhv.attribute5) list_header_attribute5,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE6',qslhv.row_id,qslhv.attribute6) list_header_attribute6,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE7',qslhv.row_id,qslhv.attribute7) list_header_attribute7,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE8',qslhv.row_id,qslhv.attribute8) list_header_attribute8,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE9',qslhv.row_id,qslhv.attribute9) list_header_attribute9,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE10',qslhv.row_id,qslhv.attribute10) list_header_attribute10,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE11',qslhv.row_id,qslhv.attribute11) list_header_attribute11,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE12',qslhv.row_id,qslhv.attribute12) list_header_attribute12,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE13',qslhv.row_id,qslhv.attribute13) list_header_attribute13,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE14',qslhv.row_id,qslhv.attribute14) list_header_attribute14,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE15',qslhv.row_id,qslhv.attribute15) list_header_attribute15,
--
-- Modifier Line
-- summary
xxen_qp_upload.get_orig_sys_ref('LINE',qmsv.list_line_id) line_orig_sys_ref,
qmsv.list_line_no line_no,
qmsv.modifier_level line_modifier_level,
qmsv.list_line_type line_modifier_type,
qmsv.start_date_active line_effective_from,
qmsv.end_date_active line_effective_to,
null delete_modifier_line,
xxen_util.meaning(decode(qmsv.automatic_flag,'Y','Y',null),'YES_NO',0) line_automatic,
xxen_util.meaning(decode(qmsv.override_flag,'Y','Y',null),'YES_NO',0) line_allow_override,
qmsv.pricing_phase line_pricing_phase,
qmsv.incompatibility_grp line_incompatibility_group,
qmsv.pricing_group_sequence line_bucket,
qmsv.proration_type line_proration_type,
qmsv.estim_gl_value line_comparison_value,
qmsv.product_attribute_type line_product_attribute,
qmsv.product_attr_value line_product_value,
xxen_qp_upload.get_product_description
(qslhv.pte_code,
 qp_util.get_context('QP_ATTR_DEFNS_PRICING',qmsv.product_attribute_context),
 qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qmsv.product_attribute_context,qmsv.product_attr),
 qmsv.product_attr_val,
 qmsv.product_attr_value
) line_product_description,
qmsv.product_precedence line_precedence,
qmsv.pricing_attribute line_volume_type,
qmsv.price_break_type line_price_break_type,
qmsv.comparison_operator_code line_operator,
qmsv.product_uom_code line_product_uom,
qmsv.pricing_attr_value_from line_value_from,
qmsv.pricing_attr_value_to line_value_to,
-- Discounts/Charges
qmsv.charge_name charge_name,
xxen_util.meaning(decode(qmsv.include_on_returns_flag,'Y','Y',null),'YES_NO',0) include_on_returns,
qmsv.formula formula,
qmsv.arithmetic_operator_type application_method,
qmsv.operand value,
--- Promotion Upgrade
qmsv.related_item upgrade_item,
-- Promotion Terms
qmsv.substitution_attribute terms_attribute,
qmsv.substitution_value terms_value,
-- Coupons
qmsv.coup_list_line_no coupon_modifier_no,
-- Price Break Header
(select
 xxen_util.meaning(qll.list_line_type_code,'LIST_LINE_TYPE_CODE',661)
 from
 qp_list_lines  qll
 where
 qll.list_line_id = (select min(qrm.to_rltd_modifier_id) from qp_rltd_modifiers qrm where qrm.from_rltd_modifier_id = qmsv.list_line_id)
) pbh_adjustment_type,
qmsv.accum_attribute pbh_accumulation_attribute,
xxen_util.meaning(qmsv.net_amount_flag,'QP_NET_AMOUNT_CALCULATION',661) pbh_net_amount_calculation,
-- Price Break Line
null price_break_orig_sys_ref,
to_number(null) price_break_value_from,
to_number(null) price_break_value_to,
null price_break_application_method,
to_number(null) price_break_value,
null price_break_formula,
to_number(null) price_break_benefit_quantity,
null price_break_benefit_uom,
to_number(null) price_break_accrual_conv_rate,
null delete_price_break,
-- Accruals
xxen_util.meaning(decode(qmsv.db_accrual_flag,'Y','Y',null),'YES_NO',0) accrue,
qmsv.db_benefit_qty benefit_qty,
qmsv.db_benefit_uom_code benefit_uom,
qmsv.db_expiration_date expiration_date,
qmsv.db_exp_period_start_date expiration_period_start_date,
qmsv.db_number_expiration_periods expiration_periods,
qmsv.db_expiration_period_uom expiration_period_type,
qmsv.db_estim_accrual_rate accrual_redemption_rate,
qmsv.db_accrual_conversion_rate accrual_conversion_rate,
decode(qmsv.list_line_type_code,'DIS',qmsv.rebate_transaction_type,'PBH',qmsv.brk_reb_transaction_type,null) rebate_transaction_type,
-- Line DFF Attributes
xxen_util.display_flexfield_context(661,'QP_LIST_LINES',qmsv.context) list_line_dff_context,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE1',qmsv.row_id,qmsv.attribute1) list_line_attribute1,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE2',qmsv.row_id,qmsv.attribute2) list_line_attribute2,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE3',qmsv.row_id,qmsv.attribute3) list_line_attribute3,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE4',qmsv.row_id,qmsv.attribute4) list_line_attribute4,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE5',qmsv.row_id,qmsv.attribute5) list_line_attribute5,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE6',qmsv.row_id,qmsv.attribute6) list_line_attribute6,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE7',qmsv.row_id,qmsv.attribute7) list_line_attribute7,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE8',qmsv.row_id,qmsv.attribute8) list_line_attribute8,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE9',qmsv.row_id,qmsv.attribute9) list_line_attribute9,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE10',qmsv.row_id,qmsv.attribute10) list_line_attribute10,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE11',qmsv.row_id,qmsv.attribute11) list_line_attribute11,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE12',qmsv.row_id,qmsv.attribute12) list_line_attribute12,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE13',qmsv.row_id,qmsv.attribute13) list_line_attribute13,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE14',qmsv.row_id,qmsv.attribute14) list_line_attribute14,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE15',qmsv.row_id,qmsv.attribute15) list_line_attribute15,
--
-- Additional Buy Products
null buy_orig_sys_ref,
to_number(null) buy_group_no,
null buy_product_attribute,
null buy_product_value,
null buy_pricing_attribute,
null buy_operator,
null buy_value_from,
null buy_value_to,
null buy_uom,
null delete_buy_item,
--
-- Get Products
null get_orig_sys_ref,
null get_product_attribute,
null get_product_value,
null get_product_uom,
to_number(null) get_quantity,
null get_uom,
null get_price_list,
to_number(null) get_price,
null get_formula,
null get_application_method,
to_number(null) get_value,
null delete_get_item,
--
-- Pricing Attributes
decode(qpa.excluder_flag,'N',qpa.orig_sys_pricing_attr_ref) pricing_attribute_orig_sys_ref,
decode(qpa.excluder_flag,'N',qp_util.get_context('QP_ATTR_DEFNS_PRICING',qpa.pricing_attribute_context)) pricing_attribute_context,
decode(qpa.excluder_flag,'N',qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qpa.pricing_attribute_context, qpa.pricing_attribute)) pricing_attribute,
decode(qpa.excluder_flag,'N',qpa.comparison_operator_code,null) pricing_attribute_operator,
decode(qpa.excluder_flag,'N',
rtrim(replace(
 qp_util.get_attribute_value
  ('QP_ATTR_DEFNS_PRICING',
   qpa.pricing_attribute_context,
   qp_qp_form_pricing_attr.get_segment_name('QP_ATTR_DEFNS_PRICING',qpa.pricing_attribute_context, qpa.pricing_attribute),
   qpa.pricing_attr_value_from,
   qpa.comparison_operator_code
  ),chr(0),null)
)) pricing_attribute_value_from,
decode(qpa.excluder_flag,'N',
rtrim(replace(
 qp_util.get_attribute_value_meaning
 ('QP_ATTR_DEFNS_PRICING',
  qpa.pricing_attribute_context,
  qp_qp_form_pricing_attr.get_segment_name('QP_ATTR_DEFNS_PRICING',qpa.pricing_attribute_context, qpa.pricing_attribute),
  qpa.pricing_attr_value_from,
  qpa.comparison_operator_code
 ),chr(0),null)
)) pricing_attribute_val_fr_desc,
decode(qpa.excluder_flag,'N',
qp_util.get_attribute_value
('QP_ATTR_DEFNS_PRICING',
 qpa.pricing_attribute_context,
 qp_qp_form_pricing_attr.get_segment_name('QP_ATTR_DEFNS_PRICING',qpa.pricing_attribute_context, qpa.pricing_attribute),
 qpa.pricing_attr_value_to,
 qpa.comparison_operator_code
)) pricing_attribute_value_to,
null delete_pricing_attribute,
--
-- Excluder
decode(qpa.excluder_flag,'Y',qpa.orig_sys_pricing_attr_ref) excluder_orig_sys_ref,
decode(qpa.excluder_flag,'Y',xxen_util.yes(qpa.excluder_flag)) excluder_flag,
decode(qpa.excluder_flag,'Y',qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qpa.product_attribute_context,qpa.product_attribute)) excluder_product_attribute,
decode(qpa.excluder_flag,'Y',qp_price_list_line_util.get_product_value('QP_ATTR_DEFNS_PRICING',qpa.product_attribute_context,qpa.product_attribute,qpa.product_attr_value)) excluder_product_value,
decode(qpa.excluder_flag,'Y',
xxen_qp_upload.get_product_description
(qslhv.pte_code,
 qp_util.get_context('QP_ATTR_DEFNS_PRICING',qpa.product_attribute_context),
 qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qpa.product_attribute_context,qpa.product_attribute),
 qpa.product_attr_value,
 qp_price_list_line_util.get_product_value('QP_ATTR_DEFNS_PRICING',qpa.product_attribute_context,qpa.product_attribute,qpa.product_attr_value)
 )) excluder_product_description,
null delete_excluder,
--
-- Qualifiers
null qualifier_assignment_level,
null qualifier_orig_sys_ref,
null qualifier_group,
to_number(null) qualifier_group_qualifier_id,
to_number(null) qualifier_grouping_number,
null qualifier_context,
null qualifier_attribute,
null qualifier_applies_party_hier,
to_number(null) qualifier_precedence,
null qualifier_operator,
null qualifier_value_from,
null qualifier_value_from_desc,
null qualifier_value_to,
to_date(null) qualifier_start_date,
to_date(null) qualifier_end_date,
null delete_qualifier,
--
null qualifier_dff_context,
null qualifier_attribute1,
null qualifier_attribute2,
null qualifier_attribute3,
null qualifier_attribute4,
null qualifier_attribute5,
null qualifier_attribute6,
null qualifier_attribute7,
null qualifier_attribute8,
null qualifier_attribute9,
null qualifier_attribute10,
null qualifier_attribute11,
null qualifier_attribute12,
null qualifier_attribute13,
null qualifier_attribute14,
null qualifier_attribute15,
--
-- Limits
null limit_assignment_level,
to_number(null) limit_no,
null limit_basis,
null limit_enforced,
to_number(null) limit_amount,
null limit_by_organization,
null limit_constraint_1,
null limit_context_1,
null limit_attribute_1,
null limit_constraint_2,
null limit_context_2,
null limit_attribute_2,
null limit_when_exceeded,
null limit_hold,
null delete_limit,
-- Limit Other Attributes
null limit_oth_att_constraint,
null limit_oth_att_context,
null limit_oth_att_attribute,
null limit_oth_att_value,
null limit_other_att_meaning,
null delete_limit_oth_att,
--
-- IDs
qslhv.list_header_id modifier_list_id,
qmsv.list_line_id modifier_line_id,
to_number(null) price_break_line_id,
to_number(null) buy_line_id,
to_number(null) get_line_id,
decode(qpa.excluder_flag,'N',qpa.pricing_attribute_id) pricing_attribute_id,
decode(qpa.excluder_flag,'Y',qpa.pricing_attribute_id) excluder_id,
to_number(null) qualifier_id,
to_number(null) limit_id,
to_number(null) limit_attribute_id,
'Modifier Line' row_type,
2.3 seq
from
qp_secu_list_headers_vl qslhv,
qp_modifier_summary_v qmsv,
qp_pricing_attributes qpa
where
1=1 and
2=2 and
:p_show_modifier_lines = 'Y' and
nvl(qslhv.pte_code,'ORDFUL') <> 'LOGSTX' and
nvl(qslhv.pte_code,'ORDFUL') = :p_pte_code and
nvl(qslhv.source_system_code,'QP') = :p_appl_sn and
nvl(qslhv.list_source_code,'null') not in ('BSO','OKS') and
((nvl(:p_gsa_pricing,'N') = 'N' and
  nvl(qslhv.gsa_indicator,'N') = 'N' and
  ((qp_util.get_qp_status = 'I' and qslhv.list_type_code in ('DLT', 'SLT', 'PRO', 'DEL', 'CHARGES')) or
   (qp_util.get_qp_status = 'S' and qslhv.list_type_code in ('DLT', 'SLT', 'CHARGES'))
  )
 ) or
 (nvl(:p_gsa_pricing,'N') = 'Y' and
  nvl(qslhv.gsa_indicator,'N') = 'Y' and
  qslhv.list_type_code = 'DLT' and
  qslhv.active_flag = 'Y'
 )
) and
(qslhv.global_flag = 'Y' or mo_global.check_access(qslhv.orig_org_id) = 'Y') and
-- modifier lines
qslhv.list_header_id = qmsv.list_header_id and
(qmsv.pricing_attribute_context is null or qmsv.pricing_attribute_context = 'VOLUME') and
nvl(qmsv.excluder_flag,'N') = 'N' and
(qmsv.list_line_type_code not in ('PBH','PRG','OID') or
 qpa.pricing_attribute_id is not null or
 (qmsv.list_line_type_code = 'PBH' and
  (nvl(:p_show_price_breaks,'N') != 'Y' or
   not exists (select null from qp_price_breaks_v qpbv where qpbv.parent_list_line_id = qmsv.list_line_id)
  )
 ) or
 (qmsv.list_line_type_code in ('PRG','OID') and
  (nvl(:p_show_promotional_items,'N') != 'Y' or
   (not exists (select null from qp_pricing_attr_v qpav where qpav.parent_list_line_id = qmsv.list_line_id) and
    not exists (select null from qp_pricing_attr_get_v qpagv where qpagv.parent_list_line_id = qmsv.list_line_id)
   )
  )
 )
) and
-- pricing attributes
nvl2(:p_show_pricing_attributes||:p_show_excluders,qmsv.list_line_id,null) = qpa.list_line_id (+) and
qpa.product_attribute_context (+) = 'ITEM' and
(qpa.list_line_id is null or
 (:p_show_pricing_attributes = 'Y' and
  qpa.excluder_flag = 'N' and
  qpa.pricing_attribute is not null and
  nvl(qpa.pricing_attribute_context,'') != 'VOLUME'
 ) or
 (:p_show_excluders = 'Y' and
  qpa.excluder_flag = 'Y' and
  qpa.pricing_attribute is null
 )
)
--
union
--
-- Q7 Modifier Line Qualifiers
--
select
--
-- Modifier List Header
qslhv.pte_code pte_code,
qslhv.source_system_code source_system_code,
xxen_util.meaning(qslhv.list_type_code,'LIST_TYPE_CODE',661) list_type,
qslhv.orig_system_header_ref list_orig_sys_ref,
qslhv.name list_number,
qslhv.version_no list_version,
qslhv.description list_name,
qslhv.comments list_description,
qslhv.currency_code list_currency,
xxen_util.meaning(nvl(qslhv.global_flag,'Y'),'YES_NO',0) global_list,
qp_util.get_ou_name(qslhv.orig_org_id) operating_unit,
qslhv.start_date_active list_effective_from,
qslhv.end_date_active list_effective_to,
xxen_util.meaning(nvl(qslhv.active_flag,'N'),'YES_NO',0) list_is_active,
xxen_util.meaning(decode(qslhv.automatic_flag,'Y','Y',null),'YES_NO',0) list_is_automatic,
(select qslhv2.name from qp_secu_list_headers_vl qslhv2 where qslhv2.list_header_id = qslhv.parent_list_header_id) list_parent_number,
(select qslhv2.version_no from qp_secu_list_headers_vl qslhv2 where qslhv2.list_header_id = qslhv.parent_list_header_id) list_parent_version,
xxen_util.meaning(decode(qslhv.ask_for_flag,'Y','Y',null),'YES_NO',0) list_is_ask_for,
xxen_util.meaning(qslhv.active_date_first_type,'EFFECTIVE_DATE_TYPES',661) list_date_type1,
qslhv.start_date_active_first list_date_type1_effective_from,
qslhv.end_date_active_first list_date_type1_effective_to,
xxen_util.meaning(qslhv.active_date_second_type,'EFFECTIVE_DATE_TYPES',661) list_date_type2,
qslhv.start_date_active_second list_date_type2_effective_from,
qslhv.end_date_active_second list_date_type2_effective_to,
xxen_util.meaning(decode(qslhv.gsa_indicator,'Y','Y',null),'YES_NO',0) list_gsa_indicator,
--
xxen_util.display_flexfield_context(661,'QP_LIST_HEADERS',qslhv.context) list_header_dff_context,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE1',qslhv.row_id,qslhv.attribute1) list_header_attribute1,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE2',qslhv.row_id,qslhv.attribute2) list_header_attribute2,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE3',qslhv.row_id,qslhv.attribute3) list_header_attribute3,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE4',qslhv.row_id,qslhv.attribute4) list_header_attribute4,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE5',qslhv.row_id,qslhv.attribute5) list_header_attribute5,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE6',qslhv.row_id,qslhv.attribute6) list_header_attribute6,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE7',qslhv.row_id,qslhv.attribute7) list_header_attribute7,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE8',qslhv.row_id,qslhv.attribute8) list_header_attribute8,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE9',qslhv.row_id,qslhv.attribute9) list_header_attribute9,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE10',qslhv.row_id,qslhv.attribute10) list_header_attribute10,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE11',qslhv.row_id,qslhv.attribute11) list_header_attribute11,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE12',qslhv.row_id,qslhv.attribute12) list_header_attribute12,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE13',qslhv.row_id,qslhv.attribute13) list_header_attribute13,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE14',qslhv.row_id,qslhv.attribute14) list_header_attribute14,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE15',qslhv.row_id,qslhv.attribute15) list_header_attribute15,
--
-- Modifier Line
-- summary
xxen_qp_upload.get_orig_sys_ref('LINE',qmsv.list_line_id) line_orig_sys_ref,
qmsv.list_line_no line_no,
qmsv.modifier_level line_modifier_level,
qmsv.list_line_type line_modifier_type,
qmsv.start_date_active line_effective_from,
qmsv.end_date_active line_effective_to,
null delete_modifier_line,
xxen_util.meaning(decode(qmsv.automatic_flag,'Y','Y',null),'YES_NO',0) line_automatic,
xxen_util.meaning(decode(qmsv.override_flag,'Y','Y',null),'YES_NO',0) line_allow_override,
qmsv.pricing_phase line_pricing_phase,
qmsv.incompatibility_grp line_incompatibility_group,
qmsv.pricing_group_sequence line_bucket,
qmsv.proration_type line_proration_type,
qmsv.estim_gl_value line_comparison_value,
qmsv.product_attribute_type line_product_attribute,
qmsv.product_attr_value line_product_value,
xxen_qp_upload.get_product_description(qslhv.pte_code,qp_util.get_context('QP_ATTR_DEFNS_PRICING',qmsv.product_attribute_context),qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qmsv.product_attribute_context,qmsv.product_attr),qmsv.product_attr_val,qmsv.product_attr_value) line_product_description,
qmsv.product_precedence line_precedence,
qmsv.pricing_attribute line_volume_type,
qmsv.price_break_type line_price_break_type,
qmsv.comparison_operator_code line_operator,
qmsv.product_uom_code line_product_uom,
qmsv.pricing_attr_value_from line_value_from,
qmsv.pricing_attr_value_to line_value_to,
-- Discounts/Charges
qmsv.charge_name charge_name,
xxen_util.meaning(decode(qmsv.include_on_returns_flag,'Y','Y',null),'YES_NO',0) include_on_returns,
qmsv.formula formula,
qmsv.arithmetic_operator_type application_method,
qmsv.operand value,
--- Promotion Upgrade
qmsv.related_item upgrade_item,
-- Promotion Terms
qmsv.substitution_attribute terms_attribute,
qmsv.substitution_value terms_value,
-- Coupons
qmsv.coup_list_line_no coupon_modifier_no,
-- Price Break Header
(select
 xxen_util.meaning(qll.list_line_type_code,'LIST_LINE_TYPE_CODE',661)
 from
 qp_list_lines  qll
 where
 qll.list_line_id = (select min(qrm.to_rltd_modifier_id) from qp_rltd_modifiers qrm where qrm.from_rltd_modifier_id = qmsv.list_line_id)
) pbh_adjustment_type,
qmsv.accum_attribute pbh_accumulation_attribute,
xxen_util.meaning(qmsv.net_amount_flag,'QP_NET_AMOUNT_CALCULATION',661) pbh_net_amount_calculation,
-- Price Break Line
null price_break_orig_sys_ref,
to_number(null) price_break_value_from,
to_number(null) price_break_value_to,
null price_break_application_method,
to_number(null) price_break_value,
null price_break_formula,
to_number(null) price_break_benefit_quantity,
null price_break_benefit_uom,
to_number(null) price_break_accrual_conv_rate,
null delete_price_break,
-- Accruals
xxen_util.meaning(decode(qmsv.db_accrual_flag,'Y','Y',null),'YES_NO',0) accrue,
qmsv.db_benefit_qty benefit_qty,
qmsv.db_benefit_uom_code benefit_uom,
qmsv.db_expiration_date expiration_date,
qmsv.db_exp_period_start_date expiration_period_start_date,
qmsv.db_number_expiration_periods expiration_periods,
qmsv.db_expiration_period_uom expiration_period_type,
qmsv.db_estim_accrual_rate accrual_redemption_rate,
qmsv.db_accrual_conversion_rate accrual_conversion_rate,
decode(qmsv.list_line_type_code,'DIS',qmsv.rebate_transaction_type,'PBH',qmsv.brk_reb_transaction_type,null) rebate_transaction_type,
-- Line DFF Attributes
xxen_util.display_flexfield_context(661,'QP_LIST_LINES',qmsv.context) list_line_dff_context,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE1',qmsv.row_id,qmsv.attribute1) list_line_attribute1,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE2',qmsv.row_id,qmsv.attribute2) list_line_attribute2,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE3',qmsv.row_id,qmsv.attribute3) list_line_attribute3,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE4',qmsv.row_id,qmsv.attribute4) list_line_attribute4,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE5',qmsv.row_id,qmsv.attribute5) list_line_attribute5,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE6',qmsv.row_id,qmsv.attribute6) list_line_attribute6,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE7',qmsv.row_id,qmsv.attribute7) list_line_attribute7,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE8',qmsv.row_id,qmsv.attribute8) list_line_attribute8,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE9',qmsv.row_id,qmsv.attribute9) list_line_attribute9,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE10',qmsv.row_id,qmsv.attribute10) list_line_attribute10,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE11',qmsv.row_id,qmsv.attribute11) list_line_attribute11,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE12',qmsv.row_id,qmsv.attribute12) list_line_attribute12,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE13',qmsv.row_id,qmsv.attribute13) list_line_attribute13,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE14',qmsv.row_id,qmsv.attribute14) list_line_attribute14,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE15',qmsv.row_id,qmsv.attribute15) list_line_attribute15,
--
-- Additional Buy Products
null buy_orig_sys_ref,
to_number(null) buy_group_no,
null buy_product_attribute,
null buy_product_value,
null buy_pricing_attribute,
null buy_operator,
null buy_value_from,
null buy_value_to,
null buy_uom,
null delete_buy_item,
--
-- Get Products
null get_orig_sys_ref,
null get_product_attribute,
null get_product_value,
null get_product_uom,
to_number(null) get_quantity,
null get_uom,
null get_price_list,
to_number(null) get_price,
null get_formula,
null get_application_method,
to_number(null) get_value,
null delete_get_item,
--
-- Pricing Attributes
null pricing_attribute_orig_sys_ref,
null pricing_attribute_context,
null pricing_attribute,
null pricing_attribute_operator,
null pricing_attribute_value_from,
null pricing_attribute_val_fr_desc,
null pricing_attribute_value_to,
null delete_pricing_attribute,
--
-- Excluder
null excluder_orig_sys_ref,
null excluder_flag,
null excluder_product_attribute,
null excluder_product_value,
null excluder_product_description,
null delete_excluder,
--
-- Qualifiers
xxen_util.meaning('LINE','ZX_ROUNDING_LEVEL',0) qualifier_assignment_level,
xxen_qp_upload.get_orig_sys_ref('QUALIFIER',qqv.qualifier_id) qualifier_orig_sys_ref,
qqv.rule_name qualifier_group,
to_number(null) qualifier_group_qualifier_id,
qqv.qualifier_grouping_no qualifier_grouping_number,
qp_util.get_context('QP_ATTR_DEFNS_QUALIFIER',qqv.qualifier_context) qualifier_context,
qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_QUALIFIER',qqv.qualifier_context,qqv.qualifier_attribute) qualifier_attribute,
xxen_util.meaning(decode(qqv.qualify_hier_descendents_flag,'Y','Y',null),'YES_NO',0) qualifier_applies_party_hier,
qqv.qualifier_precedence qualifier_precedence,
qqv.comparision_operator_code qualifier_operator,
rtrim(replace(
 qp_util.get_attribute_value
 ('QP_ATTR_DEFNS_QUALIFIER',
  qqv.qualifier_context,
  qp_qp_form_pricing_attr.get_segment_name('QP_ATTR_DEFNS_QUALIFIER',qqv.qualifier_context, qqv.qualifier_attribute),
  qqv.qualifier_attr_value,
  qqv.comparision_operator_code
 ),chr(0),null)
) qualifier_value_from,
rtrim(replace(
 qp_util.get_attribute_value_meaning
 ('QP_ATTR_DEFNS_QUALIFIER',
  qqv.qualifier_context,
  qp_qp_form_pricing_attr.get_segment_name('QP_ATTR_DEFNS_QUALIFIER',qqv.qualifier_context, qqv.qualifier_attribute),
  qqv.qualifier_attr_value,
  qqv.comparision_operator_code
 ),chr(0),null)
) qualifier_value_from_desc,
qp_util.get_attribute_value
('QP_ATTR_DEFNS_QUALIFIER',
 qqv.qualifier_context,
 qp_qp_form_pricing_attr.get_segment_name('QP_ATTR_DEFNS_QUALIFIER',qqv.qualifier_context, qqv.qualifier_attribute),
 qqv.qualifier_attr_value_to,
 qqv.comparision_operator_code
) qualifier_value_to,
qqv.start_date_active qualifier_start_date,
qqv.end_date_active qualifier_end_date,
null delete_qualifier,
--
xxen_util.display_flexfield_context(661,'QP_QUALIFIERS',qqv.context) qualifier_dff_context,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE1',qqv.row_id,qqv.attribute1) qualifier_attribute1,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE2',qqv.row_id,qqv.attribute2) qualifier_attribute2,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE3',qqv.row_id,qqv.attribute3) qualifier_attribute3,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE4',qqv.row_id,qqv.attribute4) qualifier_attribute4,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE5',qqv.row_id,qqv.attribute5) qualifier_attribute5,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE6',qqv.row_id,qqv.attribute6) qualifier_attribute6,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE7',qqv.row_id,qqv.attribute7) qualifier_attribute7,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE8',qqv.row_id,qqv.attribute8) qualifier_attribute8,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE9',qqv.row_id,qqv.attribute9) qualifier_attribute9,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE10',qqv.row_id,qqv.attribute10) qualifier_attribute10,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE11',qqv.row_id,qqv.attribute11) qualifier_attribute11,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE12',qqv.row_id,qqv.attribute12) qualifier_attribute12,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE13',qqv.row_id,qqv.attribute13) qualifier_attribute13,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE14',qqv.row_id,qqv.attribute14) qualifier_attribute14,
xxen_util.display_flexfield_value(661,'QP_QUALIFIERS',qqv.context,'ATTRIBUTE15',qqv.row_id,qqv.attribute15) qualifier_attribute15,
--
-- Limits
null limit_assignment_level,
to_number(null) limit_no,
null limit_basis,
null limit_enforced,
to_number(null) limit_amount,
null limit_by_organization,
null limit_constraint_1,
null limit_context_1,
null limit_attribute_1,
null limit_constraint_2,
null limit_context_2,
null limit_attribute_2,
null limit_when_exceeded,
null limit_hold,
null delete_limit,
-- Limit Other Attributes
null limit_oth_att_constraint,
null limit_oth_att_context,
null limit_oth_att_attribute,
null limit_oth_att_value,
null limit_other_att_meaning,
null delete_limit_oth_att,
--
-- IDs
qslhv.list_header_id modifier_list_id,
qmsv.list_line_id modifier_line_id,
to_number(null) price_break_line_id,
to_number(null) buy_line_id,
to_number(null) get_line_id,
to_number(null) pricing_attribute_id,
to_number(null) excluder_id,
qqv.qualifier_id qualifier_id,
to_number(null) limit_id,
to_number(null) limit_attribute_id,
'Line Qualifier' row_type,
2.4 seq
from
qp_secu_list_headers_vl qslhv,
qp_modifier_summary_v qmsv,
qp_qualifiers_v qqv
where
1=1 and
2=2 and
:p_show_modifier_lines = 'Y' and
:p_show_line_qualifiers = 'Y' and
nvl(qslhv.pte_code,'ORDFUL') <> 'LOGSTX' and
nvl(qslhv.pte_code,'ORDFUL') = :p_pte_code and
nvl(qslhv.source_system_code,'QP') = :p_appl_sn and
nvl(qslhv.list_source_code,'null') not in ('BSO','OKS') and
qslhv.update_flag = 'Y' and
((nvl(:p_gsa_pricing,'N') = 'N' and
  nvl(qslhv.gsa_indicator,'N') = 'N' and
  ((qp_util.get_qp_status = 'I' and qslhv.list_type_code in ('DLT', 'SLT', 'PRO', 'DEL', 'CHARGES')) or
   (qp_util.get_qp_status = 'S' and qslhv.list_type_code in ('DLT', 'SLT', 'CHARGES'))
  )
 ) or
 (nvl(:p_gsa_pricing,'N') = 'Y' and
  nvl(qslhv.gsa_indicator,'N') = 'Y' and
  qslhv.list_type_code = 'DLT' and
  qslhv.active_flag = 'Y'
 )
) and
(qslhv.global_flag = 'Y' or mo_global.check_access(qslhv.orig_org_id) = 'Y') and
-- modifier lines
qslhv.list_header_id = qmsv.list_header_id and
(qmsv.pricing_attribute_context is null or qmsv.pricing_attribute_context = 'VOLUME') and
nvl(qmsv.excluder_flag,'N') = 'N' and
--
qmsv.list_header_id = qqv.list_header_id and
qmsv.list_line_id = qqv.list_line_id
--
union
--
-- Q8 Modifier Line Limits
--
select
--
-- Modifier List Header
qslhv.pte_code pte_code,
qslhv.source_system_code source_system_code,
xxen_util.meaning(qslhv.list_type_code,'LIST_TYPE_CODE',661) list_type,
qslhv.orig_system_header_ref list_orig_sys_ref,
qslhv.name list_number,
qslhv.version_no list_version,
qslhv.description list_name,
qslhv.comments list_description,
qslhv.currency_code list_currency,
xxen_util.meaning(nvl(qslhv.global_flag,'Y'),'YES_NO',0) global_list,
qp_util.get_ou_name(qslhv.orig_org_id) operating_unit,
qslhv.start_date_active list_effective_from,
qslhv.end_date_active list_effective_to,
xxen_util.meaning(nvl(qslhv.active_flag,'N'),'YES_NO',0) list_is_active,
xxen_util.meaning(decode(qslhv.automatic_flag,'Y','Y',null),'YES_NO',0) list_is_automatic,
(select qslhv2.name from qp_secu_list_headers_vl qslhv2 where qslhv2.list_header_id = qslhv.parent_list_header_id) list_parent_number,
(select qslhv2.version_no from qp_secu_list_headers_vl qslhv2 where qslhv2.list_header_id = qslhv.parent_list_header_id) list_parent_version,
xxen_util.meaning(decode(qslhv.ask_for_flag,'Y','Y',null),'YES_NO',0) list_is_ask_for,
xxen_util.meaning(qslhv.active_date_first_type,'EFFECTIVE_DATE_TYPES',661) list_date_type1,
qslhv.start_date_active_first list_date_type1_effective_from,
qslhv.end_date_active_first list_date_type1_effective_to,
xxen_util.meaning(qslhv.active_date_second_type,'EFFECTIVE_DATE_TYPES',661) list_date_type2,
qslhv.start_date_active_second list_date_type2_effective_from,
qslhv.end_date_active_second list_date_type2_effective_to,
xxen_util.meaning(decode(qslhv.gsa_indicator,'Y','Y',null),'YES_NO',0) list_gsa_indicator,
--
xxen_util.display_flexfield_context(661,'QP_LIST_HEADERS',qslhv.context) list_header_dff_context,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE1',qslhv.row_id,qslhv.attribute1) list_header_attribute1,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE2',qslhv.row_id,qslhv.attribute2) list_header_attribute2,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE3',qslhv.row_id,qslhv.attribute3) list_header_attribute3,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE4',qslhv.row_id,qslhv.attribute4) list_header_attribute4,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE5',qslhv.row_id,qslhv.attribute5) list_header_attribute5,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE6',qslhv.row_id,qslhv.attribute6) list_header_attribute6,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE7',qslhv.row_id,qslhv.attribute7) list_header_attribute7,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE8',qslhv.row_id,qslhv.attribute8) list_header_attribute8,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE9',qslhv.row_id,qslhv.attribute9) list_header_attribute9,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE10',qslhv.row_id,qslhv.attribute10) list_header_attribute10,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE11',qslhv.row_id,qslhv.attribute11) list_header_attribute11,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE12',qslhv.row_id,qslhv.attribute12) list_header_attribute12,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE13',qslhv.row_id,qslhv.attribute13) list_header_attribute13,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE14',qslhv.row_id,qslhv.attribute14) list_header_attribute14,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE15',qslhv.row_id,qslhv.attribute15) list_header_attribute15,
--
-- Modifier Line
-- summary
xxen_qp_upload.get_orig_sys_ref('LINE',qmsv.list_line_id) line_orig_sys_ref,
qmsv.list_line_no line_no,
qmsv.modifier_level line_modifier_level,
qmsv.list_line_type line_modifier_type,
qmsv.start_date_active line_effective_from,
qmsv.end_date_active line_effective_to,
null delete_modifier_line,
xxen_util.meaning(decode(qmsv.automatic_flag,'Y','Y',null),'YES_NO',0) line_automatic,
xxen_util.meaning(decode(qmsv.override_flag,'Y','Y',null),'YES_NO',0) line_allow_override,
qmsv.pricing_phase line_pricing_phase,
qmsv.incompatibility_grp line_incompatibility_group,
qmsv.pricing_group_sequence line_bucket,
qmsv.proration_type line_proration_type,
qmsv.estim_gl_value line_comparison_value,
qmsv.product_attribute_type line_product_attribute,
qmsv.product_attr_value line_product_value,
xxen_qp_upload.get_product_description(qslhv.pte_code,qp_util.get_context('QP_ATTR_DEFNS_PRICING',qmsv.product_attribute_context),qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qmsv.product_attribute_context,qmsv.product_attr),qmsv.product_attr_val,qmsv.product_attr_value) line_product_description,
qmsv.product_precedence line_precedence,
qmsv.pricing_attribute line_volume_type,
qmsv.price_break_type line_price_break_type,
qmsv.comparison_operator_code line_operator,
qmsv.product_uom_code line_product_uom,
qmsv.pricing_attr_value_from line_value_from,
qmsv.pricing_attr_value_to line_value_to,
-- Discounts/Charges
qmsv.charge_name charge_name,
xxen_util.meaning(decode(qmsv.include_on_returns_flag,'Y','Y',null),'YES_NO',0) include_on_returns,
qmsv.formula formula,
qmsv.arithmetic_operator_type application_method,
qmsv.operand value,
--- Promotion Upgrade
qmsv.related_item upgrade_item,
-- Promotion Terms
qmsv.substitution_attribute terms_attribute,
qmsv.substitution_value terms_value,
-- Coupons
qmsv.coup_list_line_no coupon_modifier_no,
-- Price Break Header
(select
 xxen_util.meaning(qll.list_line_type_code,'LIST_LINE_TYPE_CODE',661)
 from
 qp_list_lines  qll
 where
 qll.list_line_id = (select min(qrm.to_rltd_modifier_id) from qp_rltd_modifiers qrm where qrm.from_rltd_modifier_id = qmsv.list_line_id)
) pbh_adjustment_type,
qmsv.accum_attribute pbh_accumulation_attribute,
xxen_util.meaning(qmsv.net_amount_flag,'QP_NET_AMOUNT_CALCULATION',661) pbh_net_amount_calculation,
-- Price Break Line
null price_break_orig_sys_ref,
to_number(null) price_break_value_from,
to_number(null) price_break_value_to,
null price_break_application_method,
to_number(null) price_break_value,
null price_break_formula,
to_number(null) price_break_benefit_quantity,
null price_break_benefit_uom,
to_number(null) price_break_accrual_conv_rate,
null delete_price_break,
-- Accruals
xxen_util.meaning(decode(qmsv.db_accrual_flag,'Y','Y',null),'YES_NO',0) accrue,
qmsv.db_benefit_qty benefit_qty,
qmsv.db_benefit_uom_code benefit_uom,
qmsv.db_expiration_date expiration_date,
qmsv.db_exp_period_start_date expiration_period_start_date,
qmsv.db_number_expiration_periods expiration_periods,
qmsv.db_expiration_period_uom expiration_period_type,
qmsv.db_estim_accrual_rate accrual_redemption_rate,
qmsv.db_accrual_conversion_rate accrual_conversion_rate,
decode(qmsv.list_line_type_code,'DIS',qmsv.rebate_transaction_type,'PBH',qmsv.brk_reb_transaction_type,null) rebate_transaction_type,
-- Line DFF Attributes
xxen_util.display_flexfield_context(661,'QP_LIST_LINES',qmsv.context) list_line_dff_context,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE1',qmsv.row_id,qmsv.attribute1) list_line_attribute1,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE2',qmsv.row_id,qmsv.attribute2) list_line_attribute2,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE3',qmsv.row_id,qmsv.attribute3) list_line_attribute3,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE4',qmsv.row_id,qmsv.attribute4) list_line_attribute4,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE5',qmsv.row_id,qmsv.attribute5) list_line_attribute5,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE6',qmsv.row_id,qmsv.attribute6) list_line_attribute6,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE7',qmsv.row_id,qmsv.attribute7) list_line_attribute7,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE8',qmsv.row_id,qmsv.attribute8) list_line_attribute8,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE9',qmsv.row_id,qmsv.attribute9) list_line_attribute9,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE10',qmsv.row_id,qmsv.attribute10) list_line_attribute10,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE11',qmsv.row_id,qmsv.attribute11) list_line_attribute11,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE12',qmsv.row_id,qmsv.attribute12) list_line_attribute12,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE13',qmsv.row_id,qmsv.attribute13) list_line_attribute13,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE14',qmsv.row_id,qmsv.attribute14) list_line_attribute14,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qmsv.context,'ATTRIBUTE15',qmsv.row_id,qmsv.attribute15) list_line_attribute15,
--
-- Additional Buy Products
null buy_orig_sys_ref,
to_number(null) buy_group_no,
null buy_product_attribute,
null buy_product_value,
null buy_pricing_attribute,
null buy_operator,
null buy_value_from,
null buy_value_to,
null buy_uom,
null delete_buy_item,
--
-- Get Products
null get_orig_sys_ref,
null get_product_attribute,
null get_product_value,
null get_product_uom,
to_number(null) get_quantity,
null get_uom,
null get_price_list,
to_number(null) get_price,
null get_formula,
null get_application_method,
to_number(null) get_value,
null delete_get_item,
--
-- Pricing Attributes
null pricing_attribute_orig_sys_ref,
null pricing_attribute_context,
null pricing_attribute,
null pricing_attribute_operator,
null pricing_attribute_value_from,
null pricing_attribute_val_fr_desc,
null pricing_attribute_value_to,
null delete_pricing_attribute,
--
-- Excluder
null excluder_orig_sys_ref,
null excluder_flag,
null excluder_product_attribute,
null excluder_product_value,
null excluder_product_description,
null delete_excluder,
--
-- Qualifiers
null qualifier_assignment_level,
null qualifier_orig_sys_ref,
null qualifier_group,
to_number(null) qualifier_group_qualifier_id,
to_number(null) qualifier_grouping_number,
null qualifier_context,
null qualifier_attribute,
null qualifier_applies_party_hier,
to_number(null) qualifier_precedence,
null qualifier_operator,
null qualifier_value_from,
null qualifier_value_from_desc,
null qualifier_value_to,
to_date(null) qualifier_start_date,
to_date(null) qualifier_end_date,
null delete_qualifier,
--
null qualifier_dff_context,
null qualifier_attribute1,
null qualifier_attribute2,
null qualifier_attribute3,
null qualifier_attribute4,
null qualifier_attribute5,
null qualifier_attribute6,
null qualifier_attribute7,
null qualifier_attribute8,
null qualifier_attribute9,
null qualifier_attribute10,
null qualifier_attribute11,
null qualifier_attribute12,
null qualifier_attribute13,
null qualifier_attribute14,
null qualifier_attribute15,
--
-- Limits
xxen_util.meaning('LINE','ZX_ROUNDING_LEVEL',0) limit_assignment_level,
qlv.limit_number limit_no,
xxen_util.meaning(qlv.basis,'QP_LIMIT_BASIS',661) limit_basis,
xxen_util.meaning(qlv.limit_level_code,'LIMIT_LEVEL',661) limit_enforced,
qlv.amount limit_amount,
xxen_util.meaning(decode(qlv.organization_flag,'Y','Y',null),'YES_NO',0) limit_by_organization,
xxen_util.meaning(qlv.multival_attr1_type,'LIMIT_ATTRIBUTE_TYPE',661) limit_constraint_1,
case qlv.multival_attr1_type
when 'QUALIFIER' then qp_util.get_context('QP_ATTR_DEFNS_QUALIFIER',qlv.multival_attr1_context)
when 'PRODUCT' then qp_util.get_context('QP_ATTR_DEFNS_PRICING',qlv.multival_attr1_context)
else null
end limit_context_1,
case qlv.multival_attr1_type
when 'QUALIFIER' then qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_QUALIFIER',qlv.multival_attr1_context,qlv.multival_attribute1)
when 'PRODUCT' then qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qlv.multival_attr1_context,qlv.multival_attribute1)
else null
end limit_attribute_1,
xxen_util.meaning(qlv.multival_attr2_type,'LIMIT_ATTRIBUTE_TYPE',661) limit_constraint_2,
case qlv.multival_attr2_type
when 'QUALIFIER' then qp_util.get_context('QP_ATTR_DEFNS_QUALIFIER',qlv.multival_attr2_context)
when 'PRODUCT' then qp_util.get_context('QP_ATTR_DEFNS_PRICING',qlv.multival_attr2_context)
else null
end limit_context_2,
case qlv.multival_attr2_type
when 'QUALIFIER' then qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_QUALIFIER',qlv.multival_attr2_context,qlv.multival_attribute2)
when 'PRODUCT' then qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qlv.multival_attr2_context,qlv.multival_attribute2)
else null
end limit_attribute_2,
xxen_util.meaning(qlv.limit_exceed_action_code,'LIMIT_EXCEED_ACTION',661) limit_when_exceeded,
xxen_util.meaning(decode(qlv.limit_hold_flag,'Y','Y',null),'YES_NO',0) limit_hold,
null delete_limit,
-- Limit Other Attributes
xxen_util.meaning(qlav.limit_attribute_type,'LIMIT_ATTRIBUTE_TYPE',661) limit_oth_att_constraint,
case qlav.limit_attribute_type
when 'QUALIFIER' then qp_util.get_context('QP_ATTR_DEFNS_QUALIFIER',qlav.limit_attribute_context)
when 'PRODUCT' then qp_util.get_context('QP_ATTR_DEFNS_PRICING',qlav.limit_attribute_context)
else null
end limit_oth_att_context,
case qlav.limit_attribute_type
when 'QUALIFIER' then qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_QUALIFIER',qlav.limit_attribute_context,qlav.limit_attribute)
when 'PRODUCT' then qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qlav.limit_attribute_context,qlav.limit_attribute)
else null
end limit_oth_att_attribute,
--
case qlav.limit_attribute_type
when 'QUALIFIER' then
  rtrim(replace(
   qp_util.get_attribute_value
   ('QP_ATTR_DEFNS_QUALIFIER',
    qlav.limit_attribute_context,
    qp_qp_form_pricing_attr.get_segment_name('QP_ATTR_DEFNS_QUALIFIER',qlav.limit_attribute_context,qlav.limit_attribute),
    qlav.limit_attr_value,
    qlav.comparison_operator_code
   ),chr(0),null)
  )
when 'PRODUCT' then
  qp_price_list_line_util.get_product_value('QP_ATTR_DEFNS_PRICING' ,qlav.limit_attribute_context,qlav.limit_attribute,qlav.limit_attr_value)
else null
end limit_oth_att_value,
case qlav.limit_attribute_type
when 'QUALIFIER' then
  rtrim(replace(
   qp_util.get_attribute_value_meaning
   ('QP_ATTR_DEFNS_QUALIFIER',
    qlav.limit_attribute_context,
    qp_qp_form_pricing_attr.get_segment_name('QP_ATTR_DEFNS_QUALIFIER',qlav.limit_attribute_context,qlav.limit_attribute),
    qlav.limit_attr_value,
    qlav.comparison_operator_code
   ),chr(0),null)
  )
when 'PRODUCT' then
  xxen_qp_upload.get_product_description
  (qslhv.pte_code,
   qp_util.get_context('QP_ATTR_DEFNS_PRICING',qlav.limit_attribute_context),
   qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qlav.limit_attribute_context,qlav.limit_attribute),
   qlav.limit_attr_value,
   qp_price_list_line_util.Get_Product_Value('QP_ATTR_DEFNS_PRICING' ,qlav.limit_attribute_context,qlav.limit_attribute,qlav.limit_attr_value)
  )
else null
end limit_other_att_meaning,
null delete_limit_oth_att,
--
-- IDs
qslhv.list_header_id modifier_list_id,
qmsv.list_line_id modifier_line_id,
to_number(null) price_break_line_id,
to_number(null) buy_line_id,
to_number(null) get_line_id,
to_number(null) pricing_attribute_id,
to_number(null) excluder_id,
to_number(null) qualifier_id,
qlv.limit_id,
qlav.limit_attribute_id,
'Line Limit' row_type,
2.5 seq
from
qp_secu_list_headers_vl qslhv,
qp_modifier_summary_v qmsv,
qp_limits_v qlv,
qp_limit_attributes_v qlav
where
1=1 and
2=2 and
:p_show_modifier_lines = 'Y' and
:p_show_line_limits = 'Y' and
nvl(qslhv.pte_code,'ORDFUL') <> 'LOGSTX' and
nvl(qslhv.pte_code,'ORDFUL') = :p_pte_code and
nvl(qslhv.source_system_code,'QP') = :p_appl_sn and
nvl(qslhv.list_source_code,'null') not in ('BSO','OKS') and
qslhv.update_flag = 'Y' and
((nvl(:p_gsa_pricing,'N') = 'N' and
  nvl(qslhv.gsa_indicator,'N') = 'N' and
  ((qp_util.get_qp_status = 'I' and qslhv.list_type_code in ('DLT', 'SLT', 'PRO', 'DEL', 'CHARGES')) or
   (qp_util.get_qp_status = 'S' and qslhv.list_type_code in ('DLT', 'SLT', 'CHARGES'))
  )
 ) or
 (nvl(:p_gsa_pricing,'N') = 'Y' and
  nvl(qslhv.gsa_indicator,'N') = 'Y' and
  qslhv.list_type_code = 'DLT' and
  qslhv.active_flag = 'Y'
 )
) and
(qslhv.global_flag = 'Y' or mo_global.check_access(qslhv.orig_org_id) = 'Y') and
-- modifier lines
qslhv.list_header_id = qmsv.list_header_id and
(qmsv.pricing_attribute_context is null or qmsv.pricing_attribute_context = 'VOLUME') and
nvl(qmsv.excluder_flag,'N') = 'N' and
-- limits
qmsv.list_header_id = qlv.list_header_id and
qmsv.list_line_id = qlv.list_line_id and
qlv.limit_id = qlav.limit_id (+)
) qp
where
:p_upload_mode like '%' || xxen_upload.action_update and
nvl(:p_category_set_id,-99) = nvl(:p_category_set_id,-99)