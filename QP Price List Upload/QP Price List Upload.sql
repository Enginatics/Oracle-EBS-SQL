/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: QP Price List Upload
-- Description: This upload supports the creation and update of Standard Price Lists in Oracle Advanced Pricing.

The upload supports creation/update/deletion of the following entities within the Price List:

- Price List Lines

- Price Breaks

To enter the Price Breaks in the upload, repeat the Price Break Header Line and enter/adjust the Price Break Columns for each Price Break.

- Price List Line Pricing Attributes

By default, the upload will treat all rows with the same Product, Unit of Measure, and Start Date as the same Price List Line.

If you have different Price List Lines that use the same Product, Unit of Measure and Start Date but which have different Pricing Attribute assignments, the use the ‘Line No’ column to distinguish the different Price List Lines. If not specified, then all rows with the same Product, Unit of Measure, and Start Date will be uploaded as a single Price List Line and any Pricing Attributes will be added to that Price List Line. 

The Line Number entered here is not uploaded to Oracle. It is only used by the upload to distinguish different lines with the same product, Unit of Measure, and Start date.

- Price Lists Qualifiers

Qualifier Groups can be copied to the Price List by selecting the Qualifier Group and leaving all other qualifier columns blank. The upload will copy and attach all the qualifier group's qualifiers to the price list.
Alternatively, you can select specific qualifiers from a Qualifier Group by selecting the Qualifier Group and the Qualifier Group Qualifier ID. The upload excel will then default in the details of that qualifier into the excel. In this scenario you would enter each qualifier on  a separate row in the excel. 

- Secondary Price Lists

Note:
When downloading existing Price List data into the upload excel:
  - Header level Qualifiers and Secondary Price Lists will be downloaded into separate rows in the excel
  - Line level Price Breaks and Pricing Attributes will be downloaded into separate rows in the excel

This is to minimize the duplication of data in the excel. However, when entering data for upload Qualifiers, Secondary Price Lists, Price Breaks, and Pricing Attributes can be added in the same excel row.
i.e. You can upload an excel row containing a header level qualifier, header level secondary price list, price list line details with associated price break and pricing attribute. 



-- Excel Examle Output: https://www.enginatics.com/example/qp-price-list-upload/
-- Library Link: https://www.enginatics.com/reports/qp-price-list-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
:p_upload_mode upload_mode_,
:p_disable_excel_validation no_excel_validation_,
to_number(null) price_list_row_id,
to_number(null) qualifier_group_row_id,
to_number(null) qualifier_row_id,
to_number(null) secondary_price_list_row_id,
to_number(null) price_list_line_row_id,
to_number(null) price_break_line_row_id,
to_number(null) pricing_attribute_row_id,
qp.*
from
(
--
-- Q1 List Header Qualifiers
--
select
-- Price List Header
qslhv.pte_code pte_code,
qslhv.source_system_code source_system_code,
xxen_util.meaning(qslhv.list_type_code,'LIST_TYPE_CODE',661) type,
qslhv.orig_system_header_ref list_orig_sys_ref,
qslhv.name name,
qslhv.description description,
xxen_util.meaning(nvl(qslhv.global_flag,'Y'),'YES_NO',0) global,
qp_util.get_ou_name(qslhv.orig_org_id) operating_unit,
qslhv.currency_code currency,
(select qclv.name from qp_currency_lists_vl qclv where qslhv.currency_header_id=qclv.currency_header_id) multi_currency_conversion,
qslhv.rounding_factor round_to,
xxen_util.meaning(nvl(qslhv.active_flag,'N'),'YES_NO',0) active,
qslhv.start_date_active effective_from,
qslhv.end_date_active effective_to,
xxen_util.meaning(qslhv.freight_terms_code,'FREIGHT_TERMS',660) freight_terms,
qslhv.ship_method_code ship_method,
(select rtt.name from ra_terms_tl rtt where qslhv.terms_id=rtt.term_id and rtt.language(+)=userenv('lang')) payment_term,
xxen_util.meaning(decode(qslhv.mobile_download,'Y','Y',null),'YES_NO',0) mobile_download,
qslhv.comments comments,
-- Price List DFF Attributes
xxen_util.display_flexfield_context(661,'QP_LIST_HEADERS',qslhv.context) price_list_dff_context,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE1',qslhv.row_id,qslhv.attribute1) price_list_attribute1,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE2',qslhv.row_id,qslhv.attribute2) price_list_attribute2,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE3',qslhv.row_id,qslhv.attribute3) price_list_attribute3,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE4',qslhv.row_id,qslhv.attribute4) price_list_attribute4,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE5',qslhv.row_id,qslhv.attribute5) price_list_attribute5,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE6',qslhv.row_id,qslhv.attribute6) price_list_attribute6,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE7',qslhv.row_id,qslhv.attribute7) price_list_attribute7,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE8',qslhv.row_id,qslhv.attribute8) price_list_attribute8,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE9',qslhv.row_id,qslhv.attribute9) price_list_attribute9,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE10',qslhv.row_id,qslhv.attribute10) price_list_attribute10,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE11',qslhv.row_id,qslhv.attribute11) price_list_attribute11,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE12',qslhv.row_id,qslhv.attribute12) price_list_attribute12,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE13',qslhv.row_id,qslhv.attribute13) price_list_attribute13,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE14',qslhv.row_id,qslhv.attribute14) price_list_attribute14,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE15',qslhv.row_id,qslhv.attribute15) price_list_attribute15,
-- Price List Lines
null line_orig_sys_ref,
to_number(null) line_no,
null line_product_context,
null line_product_attribute,
null line_product_value,
null line_product_attribute_desc,
null line_product_uom,
null line_primary_uom_flag,
null line_type,
null line_price_break_type,
null line_application_method,
null line_accumulation_attribute,
null line_break_uom,
null line_break_uom_attribute,
to_number(null) line_value,
null line_dynamic_formula,
null line_static_formula,
to_date(null) line_start_date,
to_date(null) line_end_date,
to_number(null) line_precedence,
null delete_line,
-- Price Breaks
null price_break_orig_sys_ref,
null price_break_pricing_context,
null price_break_pricing_attribute,
to_number(null) price_break_value_from,
to_number(null) price_break_value_to,
to_number(null) price_break_price,
null price_break_application_method,
null price_break_formula,
to_number(null) price_break_recurring_value,
null delete_price_break,
-- Price List Line Pricing Attributes
null pricing_attribute_orig_sys_ref,
null pricing_attribute_context,
null pricing_attribute,
null pricing_attribute_operator,
null pricing_attribute_value_from,
null pricing_attribute_val_fr_desc,
null pricing_attribute_value_to,
null delete_pricing_attribute,
-- Price List Line DFF Attributes
null price_list_line_dff_context,
null price_list_line_attribute1,
null price_list_line_attribute2,
null price_list_line_attribute3,
null price_list_line_attribute4,
null price_list_line_attribute5,
null price_list_line_attribute6,
null price_list_line_attribute7,
null price_list_line_attribute8,
null price_list_line_attribute9,
null price_list_line_attribute10,
null price_list_line_attribute11,
null price_list_line_attribute12,
null price_list_line_attribute13,
null price_list_line_attribute14,
null price_list_line_attribute15,
-- Price List Qualifiers
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
-- Secondary Price Lists
null sec_price_list_orig_sys_ref,
null secondary_price_list,
to_number(null) secondary_price_list_precedenc,
null delete_secondary_price_list,
-- IDs
qslhv.list_header_id price_list_id,
qqv.qualifier_id qualifier_id,
to_number(null) sec_price_list_qualifier_id,
to_number(null) price_list_line_id,
to_number(null) price_break_line_id,
to_number(null) pricing_attribute_id,
'Qualifier' row_type,
1 seq
from
qp_secu_list_headers_vl qslhv,
qp_qualifiers_v qqv
where
1=1 and
:p_show_qualifiers = 'Y' and
nvl(qslhv.pte_code,'ORDFUL') <> 'LOGSTX' and
nvl(qslhv.pte_code,'ORDFUL') = :p_pte_code and
nvl(qslhv.source_system_code,'QP') = :p_appl_sn and
nvl(qslhv.list_source_code,'null') not in ('BSO','OKS') and
qslhv.update_flag = 'Y' and
(qslhv.global_flag = 'Y' or mo_global.check_access(qslhv.orig_org_id) = 'Y') and
--
qslhv.list_header_id = qqv.list_header_id and
qqv.list_line_id = -1 and
qqv.qualifier_context != 'MODLIST' and
qqv.qualifier_attribute != 'QUALIFIER_ATTRIBUTE4' and
--
exists
(select
 null
 from
 qp_list_lines_v qllv
 where
 2=2 and
 qslhv.list_header_id = qllv.list_header_id and
 qllv.list_line_type_code in ('PBH','PLL') and
 qllv.product_attribute_context = 'ITEM' and
 ( (qllv.product_attribute = 'PRICING_ATTRIBUTE1' and
    exists (select null from mtl_system_items msi where msi.inventory_item_id = to_number(decode(translate(qllv.product_attr_value,'.0123456789','.'),null,qllv.product_attr_value,null)) and msi.organization_id = qp_util.get_item_validation_org)
   ) or
   (qllv.product_attribute != 'PRICING_ATTRIBUTE1'
   )
 )
)
--
union
--
-- Q2 List Header Secondary Price Lists
--
select
-- Price List Header
qslhv.pte_code pte_code,
qslhv.source_system_code source_system_code,
xxen_util.meaning(qslhv.list_type_code,'LIST_TYPE_CODE',661) type,
qslhv.orig_system_header_ref list_orig_sys_ref,
qslhv.name name,
qslhv.description description,
xxen_util.meaning(nvl(qslhv.global_flag,'Y'),'YES_NO',0) global,
qp_util.get_ou_name(qslhv.orig_org_id) operating_unit,
qslhv.currency_code currency,
(select qclv.name from qp_currency_lists_vl qclv where qslhv.currency_header_id=qclv.currency_header_id) multi_currency_conversion,
qslhv.rounding_factor round_to,
xxen_util.meaning(nvl(qslhv.active_flag,'N'),'YES_NO',0) active,
qslhv.start_date_active effective_from,
qslhv.end_date_active effective_to,
xxen_util.meaning(qslhv.freight_terms_code,'FREIGHT_TERMS',660) freight_terms,
qslhv.ship_method_code ship_method,
(select rtt.name from ra_terms_tl rtt where qslhv.terms_id=rtt.term_id and rtt.language(+)=userenv('lang')) payment_term,
xxen_util.meaning(decode(qslhv.mobile_download,'Y','Y',null),'YES_NO',0) mobile_download,
qslhv.comments comments,
-- Price List DFF Attributes
xxen_util.display_flexfield_context(661,'QP_LIST_HEADERS',qslhv.context) price_list_dff_context,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE1',qslhv.row_id,qslhv.attribute1) price_list_attribute1,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE2',qslhv.row_id,qslhv.attribute2) price_list_attribute2,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE3',qslhv.row_id,qslhv.attribute3) price_list_attribute3,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE4',qslhv.row_id,qslhv.attribute4) price_list_attribute4,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE5',qslhv.row_id,qslhv.attribute5) price_list_attribute5,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE6',qslhv.row_id,qslhv.attribute6) price_list_attribute6,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE7',qslhv.row_id,qslhv.attribute7) price_list_attribute7,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE8',qslhv.row_id,qslhv.attribute8) price_list_attribute8,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE9',qslhv.row_id,qslhv.attribute9) price_list_attribute9,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE10',qslhv.row_id,qslhv.attribute10) price_list_attribute10,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE11',qslhv.row_id,qslhv.attribute11) price_list_attribute11,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE12',qslhv.row_id,qslhv.attribute12) price_list_attribute12,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE13',qslhv.row_id,qslhv.attribute13) price_list_attribute13,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE14',qslhv.row_id,qslhv.attribute14) price_list_attribute14,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE15',qslhv.row_id,qslhv.attribute15) price_list_attribute15,
-- Price List Lines
null line_orig_sys_ref,
to_number(null) line_no,
null line_product_context,
null line_product_attribute,
null line_product_value,
null line_product_attribute_desc,
null line_product_uom,
null line_primary_uom_flag,
null line_type,
null line_price_break_type,
null line_application_method,
null line_accumulation_attribute,
null line_break_uom,
null line_break_uom_attribute,
to_number(null) line_value,
null line_dynamic_formula,
null line_static_formula,
to_date(null) line_start_date,
to_date(null) line_end_date,
to_number(null) line_precedence,
null delete_line,
-- Price Breaks
null price_break_orig_sys_ref,
null price_break_pricing_context,
null price_break_pricing_attribute,
to_number(null) price_break_value_from,
to_number(null) price_break_value_to,
to_number(null) price_break_price,
null price_break_application_method,
null price_break_formula,
to_number(null) price_break_recurring_value,
null delete_price_break,
-- Price List Line Pricing Attributes
null pricing_attribute_orig_sys_ref,
null pricing_attribute_context,
null pricing_attribute,
null pricing_attribute_operator,
null pricing_attribute_value_from,
null pricing_attribute_val_fr_desc,
null pricing_attribute_value_to,
null delete_pricing_attribute,
-- Price List Line DFF Attributes
null price_list_line_dff_context,
null price_list_line_attribute1,
null price_list_line_attribute2,
null price_list_line_attribute3,
null price_list_line_attribute4,
null price_list_line_attribute5,
null price_list_line_attribute6,
null price_list_line_attribute7,
null price_list_line_attribute8,
null price_list_line_attribute9,
null price_list_line_attribute10,
null price_list_line_attribute11,
null price_list_line_attribute12,
null price_list_line_attribute13,
null price_list_line_attribute14,
null price_list_line_attribute15,
-- Price List Qualifiers
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
-- Qualifier DFF Attributes
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
-- Secondary Price Lists
xxen_qp_upload.get_orig_sys_ref('LIST_HEADER',qsplv.list_header_id) sec_price_list_orig_sys_ref,
qsplv.name secondary_price_list,
qsplv.precedence secondary_price_list_precedenc,
null delete_secondary_price_list,
-- IDs
qslhv.list_header_id price_list_id,
to_number(null) qualifier_id,
qsplv.qualifier_id sec_price_list_qualifier_id,
to_number(null) price_list_line_id,
to_number(null) price_break_line_id,
to_number(null) pricing_attribute_id,
'Secondary Price List' row_type,
2 seq
from
qp_secu_list_headers_vl qslhv,
qp_secondary_price_lists_v qsplv
where
1=1 and
:p_show_secondary_price_lists = 'Y' and
nvl(qslhv.pte_code,'ORDFUL') <> 'LOGSTX' and
nvl(qslhv.pte_code,'ORDFUL') = :p_pte_code and
nvl(qslhv.source_system_code,'QP') = :p_appl_sn and
nvl(qslhv.list_source_code,'null') not in ('BSO','OKS') and
qslhv.update_flag = 'Y' and
(qslhv.global_flag = 'Y' or mo_global.check_access(qslhv.orig_org_id) = 'Y') and
--
qslhv.list_header_id = qsplv.parent_price_list_id and
--
exists
(select
 null
 from
 qp_list_lines_v qllv
 where
 2=2 and
 qslhv.list_header_id = qllv.list_header_id and
 qllv.list_line_type_code in ('PBH','PLL') and
 qllv.product_attribute_context = 'ITEM' and
 ( (qllv.product_attribute = 'PRICING_ATTRIBUTE1' and
    exists (select null from mtl_system_items msi where msi.inventory_item_id = to_number(decode(translate(qllv.product_attr_value,'.0123456789','.'),null,qllv.product_attr_value,null)) and msi.organization_id = qp_util.get_item_validation_org)
   ) or
   (qllv.product_attribute != 'PRICING_ATTRIBUTE1'
   )
 )
)
--
union
--
-- Q3 Price Lists Lines - Pricing Attributes
--
select
-- Price List Header
qslhv.pte_code pte_code,
qslhv.source_system_code source_system_code,
xxen_util.meaning(qslhv.list_type_code,'LIST_TYPE_CODE',661) type,
qslhv.orig_system_header_ref list_orig_sys_ref,
qslhv.name name,
qslhv.description description,
xxen_util.meaning(nvl(qslhv.global_flag,'Y'),'YES_NO',0) global,
qp_util.get_ou_name(qslhv.orig_org_id) operating_unit,
qslhv.currency_code currency,
(select qclv.name from qp_currency_lists_vl qclv where qslhv.currency_header_id=qclv.currency_header_id) multi_currency_conversion,
qslhv.rounding_factor round_to,
xxen_util.meaning(nvl(qslhv.active_flag,'N'),'YES_NO',0) active,
qslhv.start_date_active effective_from,
qslhv.end_date_active effective_to,
xxen_util.meaning(qslhv.freight_terms_code,'FREIGHT_TERMS',660) freight_terms,
qslhv.ship_method_code ship_method,
(select rtt.name from ra_terms_tl rtt where qslhv.terms_id=rtt.term_id and rtt.language(+)=userenv('lang'))payment_term,
xxen_util.meaning(decode(qslhv.mobile_download,'Y','Y',null),'YES_NO',0) mobile_download,
qslhv.comments comments,
-- Price List DFF Attributes
xxen_util.display_flexfield_context(661,'QP_LIST_HEADERS',qslhv.context) price_list_dff_context,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE1',qslhv.row_id,qslhv.attribute1) price_list_attribute1,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE2',qslhv.row_id,qslhv.attribute2) price_list_attribute2,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE3',qslhv.row_id,qslhv.attribute3) price_list_attribute3,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE4',qslhv.row_id,qslhv.attribute4) price_list_attribute4,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE5',qslhv.row_id,qslhv.attribute5) price_list_attribute5,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE6',qslhv.row_id,qslhv.attribute6) price_list_attribute6,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE7',qslhv.row_id,qslhv.attribute7) price_list_attribute7,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE8',qslhv.row_id,qslhv.attribute8) price_list_attribute8,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE9',qslhv.row_id,qslhv.attribute9) price_list_attribute9,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE10',qslhv.row_id,qslhv.attribute10) price_list_attribute10,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE11',qslhv.row_id,qslhv.attribute11) price_list_attribute11,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE12',qslhv.row_id,qslhv.attribute12) price_list_attribute12,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE13',qslhv.row_id,qslhv.attribute13) price_list_attribute13,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE14',qslhv.row_id,qslhv.attribute14) price_list_attribute14,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE15',qslhv.row_id,qslhv.attribute15) price_list_attribute15,
-- Price List Lines
xxen_qp_upload.get_orig_sys_ref('LINE',qllv.list_line_id) line_orig_sys_ref,
qllv.list_line_no line_no,
qp_util.get_context('QP_ATTR_DEFNS_PRICING',qllv.product_attribute_context) line_product_context,
qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qllv.product_attribute_context, qllv.product_attribute) line_product_attribute,
qllv.product_attr_val_disp line_product_value,
xxen_qp_upload.get_product_description(qslhv.pte_code,qp_util.get_context('QP_ATTR_DEFNS_PRICING',qllv.product_attribute_context),qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qllv.product_attribute_context,qllv.product_attribute),qllv.product_attr_value,qllv.product_attr_val_disp) line_product_attribute_desc,
qllv.product_uom_code line_product_uom,
xxen_util.meaning(decode(qllv.primary_uom_flag,'Y','Y',null),'YES_NO',0) line_primary_uom_flag,
xxen_util.meaning(qllv.list_line_type_code,'LIST_LINE_TYPE_CODE',661) line_type,
xxen_util.meaning(qllv.price_break_type_code,'PRICE_BREAK_TYPE_CODE',661) line_price_break_type,
xxen_util.meaning(qllv.arithmetic_operator,'ARITHMETIC_OPERATOR',661) line_application_method,
replace(qllv.accum_attribute,chr(0),'') line_accumulation_attribute,
qllv.break_uom_code line_break_uom,
qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qllv.break_uom_context,qllv.break_uom_attribute) line_break_uom_attribute,
qllv.operand line_value,
nvl2(qllv.price_by_formula_id,qp_qp_form_pricing_attr.get_formula(qllv.price_by_formula_id),null) line_dynamic_formula,
nvl2(qllv.generate_using_formula_id,qp_qp_form_pricing_attr.get_formula(qllv.generate_using_formula_id),null) line_static_formula,
qllv.start_date_active line_start_date,
qllv.end_date_active line_end_date,
qllv.product_precedence line_precedence,
null delete_line,
-- Price Breaks
null price_break_orig_sys_ref,
null price_break_pricing_context,
null price_break_pricing_attribute,
to_number(null) price_break_value_from,
to_number(null) price_break_value_to,
to_number(null) price_break_price,
null price_break_application_method,
null price_break_formula,
to_number(null) price_break_recurring_value,
null delete_price_break,
-- Price List Line Pricing Attributes
qpa.orig_sys_pricing_attr_ref pricing_attribute_orig_sys_ref,
qp_util.get_context('QP_ATTR_DEFNS_PRICING',qpa.pricing_attribute_context) pricing_attribute_context,
qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qpa.pricing_attribute_context, qpa.pricing_attribute) pricing_attribute,
qpa.comparison_operator_code pricing_attribute_operator,
rtrim(replace(
 qp_util.get_attribute_value
  ('QP_ATTR_DEFNS_PRICING',
   qpa.pricing_attribute_context,
   qp_qp_form_pricing_attr.get_segment_name('QP_ATTR_DEFNS_PRICING',qpa.pricing_attribute_context, qpa.pricing_attribute),
   qpa.pricing_attr_value_from,
   qpa.comparison_operator_code
  ),chr(0),null)
) pricing_attribute_value_from,
rtrim(replace(
 qp_util.get_attribute_value_meaning
 ('QP_ATTR_DEFNS_PRICING',
  qpa.pricing_attribute_context,
  qp_qp_form_pricing_attr.get_segment_name('QP_ATTR_DEFNS_PRICING',qpa.pricing_attribute_context, qpa.pricing_attribute),
  qpa.pricing_attr_value_from,
  qpa.comparison_operator_code
 ),chr(0),null)
) pricing_attribute_val_fr_desc,
qp_util.get_attribute_value
('QP_ATTR_DEFNS_PRICING',
 qpa.pricing_attribute_context,
 qp_qp_form_pricing_attr.get_segment_name('QP_ATTR_DEFNS_PRICING',qpa.pricing_attribute_context, qpa.pricing_attribute),
 qpa.pricing_attr_value_to,
 qpa.comparison_operator_code
) pricing_attribute_value_to,
null delete_pricing_attribute,
-- Price List Line DFF Attributes
xxen_util.display_flexfield_context(661,'QP_LIST_LINES',qllv.context) price_list_line_dff_context,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE1',qllv.row_id,qllv.attribute1) price_list_line_attribute1,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE2',qllv.row_id,qllv.attribute2) price_list_line_attribute2,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE3',qllv.row_id,qllv.attribute3) price_list_line_attribute3,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE4',qllv.row_id,qllv.attribute4) price_list_line_attribute4,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE5',qllv.row_id,qllv.attribute5) price_list_line_attribute5,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE6',qllv.row_id,qllv.attribute6) price_list_line_attribute6,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE7',qllv.row_id,qllv.attribute7) price_list_line_attribute7,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE8',qllv.row_id,qllv.attribute8) price_list_line_attribute8,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE9',qllv.row_id,qllv.attribute9) price_list_line_attribute9,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE10',qllv.row_id,qllv.attribute10) price_list_line_attribute10,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE11',qllv.row_id,qllv.attribute11) price_list_line_attribute11,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE12',qllv.row_id,qllv.attribute12) price_list_line_attribute12,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE13',qllv.row_id,qllv.attribute13) price_list_line_attribute13,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE14',qllv.row_id,qllv.attribute14) price_list_line_attribute14,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE15',qllv.row_id,qllv.attribute15) price_list_line_attribute15,
-- Price List Qualifiers
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
-- Qualifier DFF Attributes
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
-- Secondary Price Lists
null sec_price_list_orig_sys_ref,
null secondary_price_list,
to_number(null) secondary_price_list_precedenc,
null delete_secondary_price_list,
-- IDs
qslhv.list_header_id price_list_id,
to_number(null)qualifier_id,
to_number(null) sec_price_list_qualifier_id,
qllv.list_line_id price_list_line_id,
to_number(null) price_break_line_id,
qpa.pricing_attribute_id pricing_attribute_id,
'List Line' row_type,
3 seq
from
qp_secu_list_headers_vl qslhv,
qp_list_lines_v qllv,
qp_pricing_attributes qpa
where
1=1 and
2=2 and
:p_show_price_list_lines = 'Y' and
nvl(qslhv.pte_code,'ORDFUL') <> 'LOGSTX' and
nvl(qslhv.pte_code,'ORDFUL') = :p_pte_code and
nvl(qslhv.source_system_code,'QP') = :p_appl_sn and
nvl(qslhv.list_source_code,'null') not in ('BSO','OKS') and
qslhv.update_flag = 'Y' and
(qslhv.global_flag = 'Y' or mo_global.check_access(qslhv.orig_org_id) = 'Y') and
--
qslhv.list_header_id = qllv.list_header_id and
qllv.list_line_type_code in ('PBH','PLL') and
qllv.product_attribute_context = 'ITEM' and
( (qllv.product_attribute= 'PRICING_ATTRIBUTE1' and
   exists (select null from mtl_system_items msi where msi.inventory_item_id = to_number(decode(translate(qllv.product_attr_value,'.0123456789','.'),null,qllv.product_attr_value,null)) and msi.organization_id = qp_util.get_item_validation_org)
  ) or
  (qllv.product_attribute != 'PRICING_ATTRIBUTE1'
  )
) and
--
nvl2(:p_show_pricing_attributes,qllv.list_line_id,null) = qpa.list_line_id (+) and
qpa.pricing_attribute (+) is not null and
--
( (qllv.list_line_type_code = 'PLL') or
  (qllv.list_line_type_code = 'PBH' and
   (qpa.pricing_attribute is not null or
    not exists (select null from qp_price_breaks_v qpbv where qpbv.parent_list_line_id = qllv.list_line_id)
   )
  )
)
union
--
-- Q4 Price Breaks
--
select
-- Price List Header
qslhv.pte_code pte_code,
qslhv.source_system_code source_system_code,
xxen_util.meaning(qslhv.list_type_code,'LIST_TYPE_CODE',661) type,
qslhv.orig_system_header_ref list_orig_sys_ref,
qslhv.name name,
qslhv.description description,
xxen_util.meaning(nvl(qslhv.global_flag,'Y'),'YES_NO',0) global,
qp_util.get_ou_name(qslhv.orig_org_id) operating_unit,
qslhv.currency_code currency,
(select qclv.name from qp_currency_lists_vl qclv where qslhv.currency_header_id=qclv.currency_header_id) multi_currency_conversion,
qslhv.rounding_factor round_to,
xxen_util.meaning(nvl(qslhv.active_flag,'N'),'YES_NO',0) active,
qslhv.start_date_active effective_from,
qslhv.end_date_active effective_to,
xxen_util.meaning(qslhv.freight_terms_code,'FREIGHT_TERMS',660) freight_terms,
qslhv.ship_method_code ship_method,
(select rtt.name from ra_terms_tl rtt where qslhv.terms_id=rtt.term_id and rtt.language(+)=userenv('lang'))payment_term,
xxen_util.meaning(decode(qslhv.mobile_download,'Y','Y',null),'YES_NO',0) mobile_download,
qslhv.comments comments,
-- Price List DFF Attributes
xxen_util.display_flexfield_context(661,'QP_LIST_HEADERS',qslhv.context) price_list_dff_context,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE1',qslhv.row_id,qslhv.attribute1) price_list_attribute1,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE2',qslhv.row_id,qslhv.attribute2) price_list_attribute2,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE3',qslhv.row_id,qslhv.attribute3) price_list_attribute3,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE4',qslhv.row_id,qslhv.attribute4) price_list_attribute4,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE5',qslhv.row_id,qslhv.attribute5) price_list_attribute5,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE6',qslhv.row_id,qslhv.attribute6) price_list_attribute6,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE7',qslhv.row_id,qslhv.attribute7) price_list_attribute7,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE8',qslhv.row_id,qslhv.attribute8) price_list_attribute8,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE9',qslhv.row_id,qslhv.attribute9) price_list_attribute9,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE10',qslhv.row_id,qslhv.attribute10) price_list_attribute10,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE11',qslhv.row_id,qslhv.attribute11) price_list_attribute11,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE12',qslhv.row_id,qslhv.attribute12) price_list_attribute12,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE13',qslhv.row_id,qslhv.attribute13) price_list_attribute13,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE14',qslhv.row_id,qslhv.attribute14) price_list_attribute14,
xxen_util.display_flexfield_value(661,'QP_LIST_HEADERS',qslhv.context,'ATTRIBUTE15',qslhv.row_id,qslhv.attribute15) price_list_attribute15,
-- Price List Lines
xxen_qp_upload.get_orig_sys_ref('LINE',qllv.list_line_id) line_orig_sys_ref,
qllv.list_line_no line_no,
qp_util.get_context('QP_ATTR_DEFNS_PRICING',qllv.product_attribute_context) line_product_context,
qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qllv.product_attribute_context, qllv.product_attribute) line_product_attribute,
qllv.product_attr_val_disp line_product_value,
xxen_qp_upload.get_product_description(qslhv.pte_code,qp_util.get_context('QP_ATTR_DEFNS_PRICING',qllv.product_attribute_context),qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qllv.product_attribute_context,qllv.product_attribute),qllv.product_attr_value,qllv.product_attr_val_disp) line_product_attribute_desc,
qllv.product_uom_code line_product_uom,
xxen_util.meaning(decode(qllv.primary_uom_flag,'Y','Y',null),'YES_NO',0) line_primary_uom_flag,
xxen_util.meaning(qllv.list_line_type_code,'LIST_LINE_TYPE_CODE',661) line_type,
xxen_util.meaning(qllv.price_break_type_code,'PRICE_BREAK_TYPE_CODE',661) line_price_break_type,
xxen_util.meaning(qllv.arithmetic_operator,'ARITHMETIC_OPERATOR',661) line_application_method,
replace(qllv.accum_attribute,chr(0),'') line_accumulation_attribute,
qllv.break_uom_code line_break_uom,
qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qllv.break_uom_context,qllv.break_uom_attribute) line_break_uom_attribute,
qllv.operand line_value,
nvl2(qllv.price_by_formula_id,qp_qp_form_pricing_attr.get_formula(qllv.price_by_formula_id),null) line_dynamic_formula,
nvl2(qllv.generate_using_formula_id,qp_qp_form_pricing_attr.get_formula(qllv.generate_using_formula_id),null) line_static_formula,
qllv.start_date_active line_start_date,
qllv.end_date_active line_end_date,
qllv.product_precedence line_precedence,
null delete_line,
-- Price Breaks
xxen_qp_upload.get_orig_sys_ref('LINE',qpbv.list_line_id) price_break_orig_sys_ref,
qp_util.Get_Context('QP_ATTR_DEFNS_PRICING',qpbv.pricing_attribute_context) price_break_pricing_context,
qp_qp_form_pricing_attr.get_attribute('QP_ATTR_DEFNS_PRICING',qpbv.pricing_attribute_context,qpbv.pricing_attribute) price_break_pricing_attribute,
qpbv.pricing_attr_value_from_number price_break_value_from,
qpbv.pricing_attr_value_to_number price_break_value_to,
qpbv.operand price_break_price,
xxen_util.meaning(qpbv.arithmetic_operator,'ARITHMETIC_OPERATOR',661) price_break_application_method,
nvl2(qpbv.price_by_formula_id,qp_qp_form_pricing_attr.get_formula(qpbv.price_by_formula_id),null) price_break_formula,
qpbv.recurring_value price_break_recurring_value,
null delete_price_break,
-- Price List Line Pricing Attributes
null pricing_attribute_orig_sys_ref,
null pricing_attribute_context,
null pricing_attribute,
null pricing_attribute_operator,
null pricing_attribute_value_from,
null pricing_attribute_val_fr_desc,
null pricing_attribute_value_to,
null delete_pricing_attribute,
-- Price List Line DFF Attributes
xxen_util.display_flexfield_context(661,'QP_LIST_LINES',qllv.context) price_list_line_dff_context,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE1',qllv.row_id,qllv.attribute1) price_list_line_attribute1,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE2',qllv.row_id,qllv.attribute2) price_list_line_attribute2,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE3',qllv.row_id,qllv.attribute3) price_list_line_attribute3,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE4',qllv.row_id,qllv.attribute4) price_list_line_attribute4,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE5',qllv.row_id,qllv.attribute5) price_list_line_attribute5,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE6',qllv.row_id,qllv.attribute6) price_list_line_attribute6,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE7',qllv.row_id,qllv.attribute7) price_list_line_attribute7,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE8',qllv.row_id,qllv.attribute8) price_list_line_attribute8,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE9',qllv.row_id,qllv.attribute9) price_list_line_attribute9,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE10',qllv.row_id,qllv.attribute10) price_list_line_attribute10,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE11',qllv.row_id,qllv.attribute11) price_list_line_attribute11,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE12',qllv.row_id,qllv.attribute12) price_list_line_attribute12,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE13',qllv.row_id,qllv.attribute13) price_list_line_attribute13,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE14',qllv.row_id,qllv.attribute14) price_list_line_attribute14,
xxen_util.display_flexfield_value(661,'QP_LIST_LINES',qllv.context,'ATTRIBUTE15',qllv.row_id,qllv.attribute15) price_list_line_attribute15,
-- Price List Qualifiers
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
-- Qualifier DFF Attributes
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
-- Secondary Price Lists
null sec_price_list_orig_sys_ref,
null secondary_price_list,
to_number(null) secondary_price_list_precedenc,
null delete_secondary_price_list,
-- IDs
qslhv.list_header_id price_list_id,
to_number(null)qualifier_id,
to_number(null) sec_price_list_qualifier_id,
qllv.list_line_id price_list_line_id,
qpbv.list_line_id price_break_line_id,
to_number(null) pricing_attribute_id,
'Price Break' row_type,
3 seq
from
qp_secu_list_headers_vl qslhv,
qp_list_lines_v qllv,
qp_price_breaks_v qpbv
where
1=1 and
2=2 and
:p_show_price_list_lines = 'Y' and
nvl(qslhv.pte_code,'ORDFUL') <> 'LOGSTX' and
nvl(qslhv.pte_code,'ORDFUL') = :p_pte_code and
nvl(qslhv.source_system_code,'QP') = :p_appl_sn and
nvl(qslhv.list_source_code,'null') not in ('BSO','OKS') and
qslhv.update_flag = 'Y' and
(qslhv.global_flag = 'Y' or mo_global.check_access(qslhv.orig_org_id) = 'Y') and
--
qslhv.list_header_id = qllv.list_header_id and
qllv.list_line_type_code = 'PBH' and
qllv.product_attribute_context = 'ITEM' and
( (qllv.product_attribute= 'PRICING_ATTRIBUTE1' and
   exists (select null from mtl_system_items msi where msi.inventory_item_id = to_number(decode(translate(qllv.product_attr_value,'.0123456789','.'),null,qllv.product_attr_value,null)) and msi.organization_id = qp_util.get_item_validation_org)
  ) or
  (qllv.product_attribute != 'PRICING_ATTRIBUTE1'
  )
) and
--
qllv.list_line_id = qpbv.parent_list_line_id
--
) qp
where
:p_upload_mode like '%' || xxen_upload.action_update and
nvl(:p_category_set_id,-99) = nvl(:p_category_set_id,-99)