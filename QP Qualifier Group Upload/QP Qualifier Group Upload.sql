/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: QP Qualifier Group Upload
-- Description: This upload supports the creation and update of Qualifier Groups in Oracle Advanced Pricing.

-- Excel Examle Output: https://www.enginatics.com/example/qp-qualifier-group-upload/
-- Library Link: https://www.enginatics.com/reports/qp-qualifier-group-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
:p_upload_mode upload_mode_,
:p_disable_excel_validation no_excel_validation_,
:p_pte_code pte_code,
:p_appl_sn source_system_code,
to_number(null) qualifier_rule_row_id,
to_number(null) qualifier_row_id,
-- Qualifier Group
qqr.name rule_name,
qqr.description rule_description,
-- Qualifier Group DFF Attributes
xxen_util.display_flexfield_context(661,'QP_QUALIFIER_RULES',qqr.context) qualifier_rule_dff_context,
xxen_util.display_flexfield_value(661,'QP_QUALIFIER_RULES',qqr.context,'ATTRIBUTE1',qqr.rowid,qqr.attribute1) qualifier_rule_attribute1,
xxen_util.display_flexfield_value(661,'QP_QUALIFIER_RULES',qqr.context,'ATTRIBUTE2',qqr.rowid,qqr.attribute2) qualifier_rule_attribute2,
xxen_util.display_flexfield_value(661,'QP_QUALIFIER_RULES',qqr.context,'ATTRIBUTE3',qqr.rowid,qqr.attribute3) qualifier_rule_attribute3,
xxen_util.display_flexfield_value(661,'QP_QUALIFIER_RULES',qqr.context,'ATTRIBUTE4',qqr.rowid,qqr.attribute4) qualifier_rule_attribute4,
xxen_util.display_flexfield_value(661,'QP_QUALIFIER_RULES',qqr.context,'ATTRIBUTE5',qqr.rowid,qqr.attribute5) qualifier_rule_attribute5,
xxen_util.display_flexfield_value(661,'QP_QUALIFIER_RULES',qqr.context,'ATTRIBUTE6',qqr.rowid,qqr.attribute6) qualifier_rule_attribute6,
xxen_util.display_flexfield_value(661,'QP_QUALIFIER_RULES',qqr.context,'ATTRIBUTE7',qqr.rowid,qqr.attribute7) qualifier_rule_attribute7,
xxen_util.display_flexfield_value(661,'QP_QUALIFIER_RULES',qqr.context,'ATTRIBUTE8',qqr.rowid,qqr.attribute8) qualifier_rule_attribute8,
xxen_util.display_flexfield_value(661,'QP_QUALIFIER_RULES',qqr.context,'ATTRIBUTE9',qqr.rowid,qqr.attribute9) qualifier_rule_attribute9,
xxen_util.display_flexfield_value(661,'QP_QUALIFIER_RULES',qqr.context,'ATTRIBUTE10',qqr.rowid,qqr.attribute10) qualifier_rule_attribute10,
xxen_util.display_flexfield_value(661,'QP_QUALIFIER_RULES',qqr.context,'ATTRIBUTE11',qqr.rowid,qqr.attribute11) qualifier_rule_attribute11,
xxen_util.display_flexfield_value(661,'QP_QUALIFIER_RULES',qqr.context,'ATTRIBUTE12',qqr.rowid,qqr.attribute12) qualifier_rule_attribute12,
xxen_util.display_flexfield_value(661,'QP_QUALIFIER_RULES',qqr.context,'ATTRIBUTE13',qqr.rowid,qqr.attribute13) qualifier_rule_attribute13,
xxen_util.display_flexfield_value(661,'QP_QUALIFIER_RULES',qqr.context,'ATTRIBUTE14',qqr.rowid,qqr.attribute14) qualifier_rule_attribute14,
xxen_util.display_flexfield_value(661,'QP_QUALIFIER_RULES',qqr.context,'ATTRIBUTE15',qqr.rowid,qqr.attribute15) qualifier_rule_attribute15,
--  Qualifiers
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
-- Qualifier DFF Attributes
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
-- IDs
qqr.qualifier_rule_id,
qqv.qualifier_id,
1 seq
from
qp_qualifier_rules qqr,
qp_qualifiers_v qqv
where
1=1 and
:p_upload_mode like '%' || xxen_upload.action_update and
qqr.qualifier_rule_id = qqv.qualifier_rule_id