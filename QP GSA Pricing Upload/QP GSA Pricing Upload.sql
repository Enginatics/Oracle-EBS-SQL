/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: QP GSA Pricing Upload
-- Description: This upload supports the creation and update of GSA Pricing Setup in Oracle Advanced Pricing.
-- The upload supports creation/update/deletion of the following entities within a GSA Pricing List:
-- - GSA Lists (created as a Modifier List)
-- - GSA List Qualifiers (created as a Modifier List Qualifier)
-- - GSA List Lines (created as Modifier Lines)
-- Notes:
-- When downloading existing GSA Lists into the upload excel; the List level Qualifiers and the List Lines will be downloaded into separate rows in the excel. This is to minimize the duplication of data in the excel.
-- However:
-- When entering List Header qualifiers, these can be added in the same excel row as the List Lines (i.e. You can upload an excel row containing list line details and a list header qualifier).
-- Modifier Line Numbering
-- ====================
-- The Modifier Numbering report parameter determines if you want the system to automatically generate Modifier Numbers when creating new GSA List Lines or if the line number specified in the Line No column in the upload should be retained. If Automatic is specified, any Line Numbers specified in the upload excel for new GSA List Lines will be replaced by a system generated line number on upload.
-- The Line No column is required when entering list line details. The upload uses the combination of List Number, List Version, and Line No to identify the GSA List Line. If the combination already exists in Oracle the upload will update the existing GSA List Line, otherwise it will create a new GSA List Line.
-- Excel Example Output: https://www.enginatics.com/example/qp-gsa-pricing-upload/
-- Library Link: https://www.enginatics.com/reports/qp-gsa-pricing-upload/
-- Run Report: https://demo.enginatics.com/

select
case when :p_override_list_line = 'Y' then xxen_upload.action_meaning(xxen_upload.action_create) else null end action_,
case when :p_override_list_line = 'Y' then xxen_upload.status_meaning(xxen_upload.status_new) else null end status_,
case when :p_override_list_line = 'Y' then xxen_util.description('U_EXCEL_MSG_VALIDATION_PENDING','XXEN_REPORT_TRANSLATIONS',0) else null end message_,
null request_id_,
null modified_columns_,
:p_upload_mode upload_mode_,
:p_override_list_line override_list_line_,
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
null line_automatic,
null line_allow_override,
null line_proration_type,
null line_pricing_phase,
null line_incompatibility_group,
to_number(null) line_bucket,
null line_product_attribute,
null line_product_value,
null line_product_description,
to_number(null) line_precedence,
null line_product_uom,
-- Discounts/Charges
null application_method,
to_number(null) value,
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
-- Qualifiers
xxen_util.meaning('HEADER','ZX_ROUNDING_LEVEL',0) qualifier_assignment_level,
xxen_qp_upload.get_orig_sys_ref('QUALIFIER',qqv.qualifier_id) qualifier_orig_sys_ref,
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
-- IDs
qslhv.list_header_id modifier_list_id,
to_number(null) modifier_line_id,
qqv.qualifier_id qualifier_id,
'Modifier List' row_type,
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
-- Q2 Modifier Lines
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
xxen_util.meaning(decode(qmsv.automatic_flag,'Y','Y',null),'YES_NO',0) line_automatic,
xxen_util.meaning(decode(qmsv.override_flag,'Y','Y',null),'YES_NO',0) line_allow_override,
qmsv.proration_type line_proration_type,
qmsv.pricing_phase line_pricing_phase,
qmsv.incompatibility_grp line_incompatibility_group,
qmsv.pricing_group_sequence line_bucket,
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
qmsv.product_uom_code line_product_uom,
-- Discounts/Charges
qmsv.arithmetic_operator_type application_method,
qmsv.operand value,
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
-- Qualifiers
null qualifier_assignment_level,
null qualifier_orig_sys_ref,
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
-- IDs
qslhv.list_header_id modifier_list_id,
qmsv.list_line_id modifier_line_id,
to_number(null) qualifier_id,
'Modifier Line' row_type,
2.0 seq
from
qp_secu_list_headers_vl qslhv,
qp_modifier_summary_v qmsv
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
nvl(qmsv.excluder_flag,'N') = 'N'
) qp
where
:p_upload_mode like '%' || xxen_upload.action_update and
nvl(:p_category_set_id,-99) = nvl(:p_category_set_id,-99)
