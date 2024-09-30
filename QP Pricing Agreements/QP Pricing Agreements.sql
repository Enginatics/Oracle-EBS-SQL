/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: QP Pricing Agreements
-- Description: Report detailing QP Pricing Agreements
-- Excel Examle Output: https://www.enginatics.com/example/qp-pricing-agreements/
-- Library Link: https://www.enginatics.com/reports/qp-pricing-agreements/
-- Run Report: https://demo.enginatics.com/

with
qpa as
(
 select
 -- agreement
 opcv.agreement_name,
 opcv.agreement_num,
 opcv.revision,
 opcv.revision_date,
 xxen_util.meaning(opcv.revision_reason_code,'QP_REVISION_REASON_CODE',661) revision_reason,
 opcv.start_date_active,
 opcv.end_date_active,
 opcv.customer,
 opcv.customer_number,
 opcv.agreement_type,
 opcv.agreement_contact,
 opcv.salesrep,
 opcv.purchase_order_num,
 opcv.signature_date,
 xxen_util.meaning(opcv.agreement_source_code,'AGREEMENT_SOURCE_CODE',661) agreement_source,
 -- pricing
 xxen_util.meaning(opcv.list_type_code,'LIST_TYPE_CODE',661) price_list_type,
 opcv.price_list,
 opcv.currency_code,
 (select qclv.name from qp_currency_lists_vl qclv where qclv.currency_header_id = opcv.currency_header_id) multi_currency_conversion,
 opcv.rounding_factor,
 opcv.description,
 opcv.ship_method_code,
 opcv.freight_terms,
 opcv.comments,
 -- Payment
 opcv.term,
 opcv.invoice_name,
 opcv.address1,
 opcv.address2,
 opcv.address3,
 opcv.invoice_contact,
 opcv.accounting_rule,
 opcv.invoicing_rule,
 xxen_util.meaning(opcv.override_arule_flag,'YES_NO',0) override_accounting_rule,
 xxen_util.meaning(opcv.override_irule_flag,'YES_NO',0) override_invoicing_rule,
-- dff
 oab.context agreement_dff_context,
 xxen_util.display_flexfield_value(661,'OE_AGREEMENTS','ATTRIBUTE1',oab.rowid,oab.attribute1) agreement_attribute1,
 xxen_util.display_flexfield_value(661,'OE_AGREEMENTS','ATTRIBUTE2',oab.rowid,oab.attribute2) agreement_attribute2,
 xxen_util.display_flexfield_value(661,'OE_AGREEMENTS','ATTRIBUTE3',oab.rowid,oab.attribute3) agreement_attribute3,
 xxen_util.display_flexfield_value(661,'OE_AGREEMENTS','ATTRIBUTE4',oab.rowid,oab.attribute4) agreement_attribute4,
 xxen_util.display_flexfield_value(661,'OE_AGREEMENTS','ATTRIBUTE5',oab.rowid,oab.attribute5) agreement_attribute5,
 xxen_util.display_flexfield_value(661,'OE_AGREEMENTS','ATTRIBUTE6',oab.rowid,oab.attribute6) agreement_attribute6,
 xxen_util.display_flexfield_value(661,'OE_AGREEMENTS','ATTRIBUTE7',oab.rowid,oab.attribute7) agreement_attribute7,
 xxen_util.display_flexfield_value(661,'OE_AGREEMENTS','ATTRIBUTE8',oab.rowid,oab.attribute8) agreement_attribute8,
 xxen_util.display_flexfield_value(661,'OE_AGREEMENTS','ATTRIBUTE9',oab.rowid,oab.attribute9) agreement_attribute9,
 xxen_util.display_flexfield_value(661,'OE_AGREEMENTS','ATTRIBUTE10',oab.rowid,oab.attribute10) agreement_attribute10,
 xxen_util.display_flexfield_value(661,'OE_AGREEMENTS','ATTRIBUTE11',oab.rowid,oab.attribute11) agreement_attribute11,
 xxen_util.display_flexfield_value(661,'OE_AGREEMENTS','ATTRIBUTE12',oab.rowid,oab.attribute12) agreement_attribute12,
 xxen_util.display_flexfield_value(661,'OE_AGREEMENTS','ATTRIBUTE13',oab.rowid,oab.attribute13) agreement_attribute13,
 xxen_util.display_flexfield_value(661,'OE_AGREEMENTS','ATTRIBUTE14',oab.rowid,oab.attribute14) agreement_attribute14,
 xxen_util.display_flexfield_value(661,'OE_AGREEMENTS','ATTRIBUTE15',oab.rowid,oab.attribute15) agreement_attribute15,
 -- audit
 xxen_util.user_name(opcv.created_by,'N') agreement_created_by,
 xxen_util.client_time(opcv.creation_date) agreement_creation_date,
 xxen_util.user_name(opcv.last_updated_by,'N') agreement_last_updated_by,
 xxen_util.client_time(opcv.last_update_date) agreement_last_update_date,
 -- ids
 opcv.agreement_id,
 opcv.price_list_id
 from
 oe_pricing_contracts_v opcv,
 oe_agreements_b oab
 where
 1=1 and
 opcv.agreement_id = oab.agreement_id and
 opcv.price_list_id in
 (select
  qslhv.list_header_id
  from
  qp_secu_list_headers_v qslhv
  where qslhv.list_type_code in ('PRL','AGR') and
  qslhv.view_flag = 'Y'
 )
),
qll as
(
 select /*+ leading(qp_list_lines_v.qppr) use_nl(qp_list_lines_v.qpll) no_expand */
 -- agreement lines
 qllv.list_line_no,
 mciav.customer_item_number customer_item,
 mciav.concatenated_address address,
 mciav.customer_category address_category,
 qllv.product_attr_val_disp product_value,
 msiv.description product_description,
 qllv.product_uom_code uom,
 case when qllv.primary_uom_flag = 'Y' then xxen_util.meaning('Y','YES_NO',0) else null end primary_uom_flag,
 xxen_util.meaning(qllv.list_line_type_code,'LIST_LINE_TYPE_CODE',661) line_type,
 xxen_util.meaning(qllv.price_break_type_code,'PRICE_BREAK_TYPE_CODE',661) price_break_type,
 xxen_util.meaning(qllv.arithmetic_operator,'ARITHMETIC_OPERATOR',661) application_method,
 --qllv.accum_attribute accumulation_attribute,
 qllv.break_uom_code break_uom,
 qllv.break_uom_attribute,
 qllv.operand value,
 qpfv1.name dynamic_formula,
 qpfv2.name statis_formula,
 qllv.start_date_active line_start_date,
 qllv.end_date_active line_end_date,
 qllv.product_precedence precedence,
 qllv.comments line_comments,
 qllv.revision line_revsion,
 xxen_util.meaning(qllv.revision_reason_code,'QP_REVISION_REASON_CODE',661) line_revision_reason,
 qllv.revision_date line_revision_date,
 -- dff
 qllv.context line_dff_context,
 xxen_util.display_flexfield_value(661,'QP_LIST_LINES','ATTRIBUTE1',qllv.row_id,qllv.attribute1) line_attribue1,
 xxen_util.display_flexfield_value(661,'QP_LIST_LINES','ATTRIBUTE2',qllv.row_id,qllv.attribute2) line_attribue2,
 xxen_util.display_flexfield_value(661,'QP_LIST_LINES','ATTRIBUTE3',qllv.row_id,qllv.attribute3) line_attribue3,
 xxen_util.display_flexfield_value(661,'QP_LIST_LINES','ATTRIBUTE4',qllv.row_id,qllv.attribute4) line_attribue4,
 xxen_util.display_flexfield_value(661,'QP_LIST_LINES','ATTRIBUTE5',qllv.row_id,qllv.attribute5) line_attribue5,
 xxen_util.display_flexfield_value(661,'QP_LIST_LINES','ATTRIBUTE6',qllv.row_id,qllv.attribute6) line_attribue6,
 xxen_util.display_flexfield_value(661,'QP_LIST_LINES','ATTRIBUTE7',qllv.row_id,qllv.attribute7) line_attribue7,
 xxen_util.display_flexfield_value(661,'QP_LIST_LINES','ATTRIBUTE8',qllv.row_id,qllv.attribute8) line_attribue8,
 xxen_util.display_flexfield_value(661,'QP_LIST_LINES','ATTRIBUTE9',qllv.row_id,qllv.attribute9) line_attribue9,
 xxen_util.display_flexfield_value(661,'QP_LIST_LINES','ATTRIBUTE10',qllv.row_id,qllv.attribute10) line_attribue10,
 xxen_util.display_flexfield_value(661,'QP_LIST_LINES','ATTRIBUTE11',qllv.row_id,qllv.attribute11) line_attribue11,
 xxen_util.display_flexfield_value(661,'QP_LIST_LINES','ATTRIBUTE12',qllv.row_id,qllv.attribute12) line_attribue12,
 xxen_util.display_flexfield_value(661,'QP_LIST_LINES','ATTRIBUTE13',qllv.row_id,qllv.attribute13) line_attribue13,
 xxen_util.display_flexfield_value(661,'QP_LIST_LINES','ATTRIBUTE14',qllv.row_id,qllv.attribute14) line_attribue14,
 xxen_util.display_flexfield_value(661,'QP_LIST_LINES','ATTRIBUTE15',qllv.row_id,qllv.attribute15) line_attribue15,
 -- audit
 xxen_util.user_name(qllv.created_by,'N') created_by,
 xxen_util.client_time(qllv.creation_date) creation_date,
 xxen_util.user_name(qllv.last_updated_by,'N') last_updated_by,
 xxen_util.client_time(qllv.last_update_date) last_update_date,
 -- ids
 qllv.list_header_id,
 qllv.pa_list_header_id,
 qllv.list_line_id
from
 qp_list_lines_v qllv,
 mtl_system_items_vl msiv,
 qp_price_formulas_vl qpfv1,
 qp_price_formulas_vl qpfv2,
 mtl_customer_items_all_v mciav
where
 2=2 and
 qllv.product_attribute_context = 'ITEM' and
 (qllv.product_attribute<>'PRICING_ATTRIBUTE1' or
  msiv.inventory_item_id is not null
 ) and
 case when qllv.product_attribute_context = 'ITEM' and qllv.product_attribute = 'PRICING_ATTRIBUTE1' then qllv.product_attr_value end = msiv.inventory_item_id(+) and
 msiv.organization_id (+) = qp_util.get_item_validation_org and
 qllv.price_by_formula_id = qpfv1.price_formula_id(+) and
 qllv.generate_using_formula_id = qpfv2.price_formula_id(+) and
 qllv.customer_item_id = mciav.customer_item_id (+)
),
qpb as
(
 select
 qpbv.pricing_attr_value_from price_break_value_from,
 qpbv.pricing_attr_value_to price_break_value_to,
 qpbv.operand price_break_value,
 qp_qp_form_pricing_attr.Get_Formula(qpbv.price_by_formula_id) price_break_formula,
 qp_qp_form_pricing_attr.Get_Meaning (qpbv.arithmetic_operator, 'ARITHMETIC_OPERATOR') price_break_application_method,
 qpbv.benefit_qty price_break_benefit_qty,
 qpbv.benefit_uom_code price_break_benefit_uom,
 qpbv.accrual_conversion_rate price_break_accrual_conv_rate,
 xxen_util.client_time(qpbv.creation_date) creation_date,
 xxen_util.user_name(qpbv.created_by,'N') created_by,
 xxen_util.client_time(qpbv.last_update_date) last_update_date,
 xxen_util.user_name(qpbv.last_updated_by,'N') last_updated_by,
 qpbv.list_line_id list_line_id,
 qpbv.list_header_id list_header_id,
 qpbv.parent_list_line_id parent_list_line_id
 from
 qp_price_breaks_v qpbv
),
qpat as
(
 select
 qp_qp_form_pricing_attr.Get_Attribute ('QP_ATTR_DEFNS_PRICING', qpa.product_attribute_context, qpa.product_attribute) product_attribute,
 qp_price_list_line_util.Get_Product_Value ('QP_ATTR_DEFNS_PRICING', qpa.product_attribute_context, qpa.product_attribute, qpa.product_attr_value) product_attribute_value,
 qp_qp_form_pricing_attr.Get_Attribute ('QP_ATTR_DEFNS_PRICING',qpa.pricing_attribute_context,qpa.pricing_attribute) pricing_attribute,
 qpa.comparison_operator_code pricing_attribute_operator,
 qpa.pricing_attr_value_from pricing_attribute_value_from,
 qpa.pricing_attr_value_to pricing_attribute_value_to,
 qpa.product_uom_code pricing_attribute_buy_uom,
 xxen_util.client_time(qpa.creation_date) creation_date,
 xxen_util.user_name(qpa.created_by,'N') created_by,
 xxen_util.client_time(qpa.last_update_date) last_update_date,
 xxen_util.user_name(qpa.last_updated_by,'N') last_updated_by,
 qpa.list_line_id list_line_id,
 qpa.list_header_id list_header_id
 from
  qp_pricing_attributes qpa
 where
 nvl(qpa.pricing_attribute_context, 'VOLUME') <> 'VOLUME' and
 ( qpa.pricing_attribute_context != 'PRICING ATTRIBUTE' or
   (qpa.pricing_attribute_context = 'PRICING ATTRIBUTE' and qpa.pricing_attribute != 'PRICING_ATTRIBUTE11')
 )
)
--
-- Main Query Starts Here
--
select
x.*
from
(
 -- Q1 Pricing Agreements and Lines
 select
 -- agreement
 qpa.agreement_name,
 qpa.agreement_num,
 qpa.revision,
 qpa.revision_date,
 qpa.revision_reason,
 qpa.start_date_active,
 qpa.end_date_active,
 qpa.customer,
 qpa.customer_number,
 qpa.agreement_type,
 qpa.agreement_contact,
 qpa.salesrep,
 qpa.purchase_order_num,
 qpa.signature_date,
 qpa.agreement_source,
 -- pricing
 qpa.price_list_type,
 qpa.price_list,
 qpa.currency_code,
 qpa.multi_currency_conversion,
 qpa.rounding_factor,
 qpa.description,
 qpa.ship_method_code,
 qpa.freight_terms,
 qpa.comments,
 -- Payment
 qpa.term,
 qpa.invoice_name,
 qpa.address1,
 qpa.address2,
 qpa.address3,
 qpa.invoice_contact,
 qpa.accounting_rule,
 qpa.invoicing_rule,
 qpa.override_accounting_rule,
 qpa.override_invoicing_rule,
 -- agreement lines
 qll.line_type,
 qll.list_line_no,
 qll.customer_item,
 qll.address,
 qll.address_category,
 qll.product_value,
 qll.product_description,
 qll.uom,
 qll.primary_uom_flag,
 qll.price_break_type,
 qll.application_method,
 --qll.accumulation_attribute,
 qll.break_uom,
 qll.break_uom_attribute,
 qll.value,
 qll.dynamic_formula,
 qll.statis_formula,
 qll.line_start_date,
 qll.line_end_date,
 qll.precedence,
 qll.line_comments,
 qll.line_revsion,
 qll.line_revision_reason,
 qll.line_revision_date,
 -- price breaks
 qpb.price_break_value_from,
 qpb.price_break_value_to,
 qpb.price_break_value,
 qpb.price_break_formula,
 qpb.price_break_application_method,
 qpb.price_break_benefit_qty,
 qpb.price_break_benefit_uom,
 qpb.price_break_accrual_conv_rate,
 -- pricing attributes
 qpat.product_attribute,
 qpat.product_attribute_value,
 qpat.pricing_attribute,
 qpat.pricing_attribute_operator,
 qpat.pricing_attribute_value_from,
 qpat.pricing_attribute_value_to,
 qpat.pricing_attribute_buy_uom,
 -- dff
 qpa.agreement_dff_context,
 qpa.agreement_attribute1,
 qpa.agreement_attribute2,
 qpa.agreement_attribute3,
 qpa.agreement_attribute4,
 qpa.agreement_attribute5,
 qpa.agreement_attribute6,
 qpa.agreement_attribute7,
 qpa.agreement_attribute8,
 qpa.agreement_attribute9,
 qpa.agreement_attribute10,
 qpa.agreement_attribute11,
 qpa.agreement_attribute12,
 qpa.agreement_attribute13,
 qpa.agreement_attribute14,
 qpa.agreement_attribute15,
 qll.line_dff_context,
 qll.line_attribue1,
 qll.line_attribue2,
 qll.line_attribue3,
 qll.line_attribue4,
 qll.line_attribue5,
 qll.line_attribue6,
 qll.line_attribue7,
 qll.line_attribue8,
 qll.line_attribue9,
 qll.line_attribue10,
 qll.line_attribue11,
 qll.line_attribue12,
 qll.line_attribue13,
 qll.line_attribue14,
 qll.line_attribue15,
 -- audit
 qpa.agreement_created_by,
 qpa.agreement_creation_date,
 qpa.agreement_last_updated_by,
 qpa.agreement_last_update_date,
 qll.created_by,
 qll.creation_date,
 qll.last_updated_by,
 qll.last_update_date,
 -- ids
 qpa.agreement_id,
 qpa.price_list_id,
 qll.list_line_id,
 --
 1 sort_order
 from
 qpa,
 qll,
 qpb,
 qpat
 where
 qpa.price_list_id = qll.list_header_id (+) and
 qpa.price_list_id = qll.pa_list_header_id (+) and
 nvl2(qll.list_line_id,-1,-1) = qpb.parent_list_line_id (+) and
 nvl2(qll.list_line_id,-1,-1) = qpat.list_line_id (+)
 union all
 -- Q2 Price Breaks
 select
 -- agreement
 qpa.agreement_name,
 qpa.agreement_num,
 qpa.revision,
 qpa.revision_date,
 qpa.revision_reason,
 qpa.start_date_active,
 qpa.end_date_active,
 qpa.customer,
 qpa.customer_number,
 qpa.agreement_type,
 qpa.agreement_contact,
 qpa.salesrep,
 qpa.purchase_order_num,
 qpa.signature_date,
 qpa.agreement_source,
 -- pricing
 qpa.price_list_type,
 qpa.price_list,
 qpa.currency_code,
 qpa.multi_currency_conversion,
 qpa.rounding_factor,
 qpa.description,
 qpa.ship_method_code,
 qpa.freight_terms,
 qpa.comments,
 -- Payment
 qpa.term,
 qpa.invoice_name,
 qpa.address1,
 qpa.address2,
 qpa.address3,
 qpa.invoice_contact,
 qpa.accounting_rule,
 qpa.invoicing_rule,
 qpa.override_accounting_rule,
 qpa.override_invoicing_rule,
 -- agreement lines
 'Price Break' line_type,
 qll.list_line_no,
 qll.customer_item,
 qll.address,
 qll.address_category,
 qll.product_value,
 qll.product_description,
 qll.uom,
 qll.primary_uom_flag,
 qll.price_break_type,
 qll.application_method,
 --qll.accumulation_attribute,
 qll.break_uom,
 qll.break_uom_attribute,
 qll.value,
 qll.dynamic_formula,
 qll.statis_formula,
 qll.line_start_date,
 qll.line_end_date,
 qll.precedence,
 qll.line_comments,
 qll.line_revsion,
 qll.line_revision_reason,
 qll.line_revision_date,
 -- price breaks
 qpb.price_break_value_from,
 qpb.price_break_value_to,
 qpb.price_break_value,
 qpb.price_break_formula,
 qpb.price_break_application_method,
 qpb.price_break_benefit_qty,
 qpb.price_break_benefit_uom,
 qpb.price_break_accrual_conv_rate,
 -- pricing attributes
 qpat.product_attribute,
 qpat.product_attribute_value,
 qpat.pricing_attribute,
 qpat.pricing_attribute_operator,
 qpat.pricing_attribute_value_from,
 qpat.pricing_attribute_value_to,
 qpat.pricing_attribute_buy_uom,
 -- dff
 qpa.agreement_dff_context,
 qpa.agreement_attribute1,
 qpa.agreement_attribute2,
 qpa.agreement_attribute3,
 qpa.agreement_attribute4,
 qpa.agreement_attribute5,
 qpa.agreement_attribute6,
 qpa.agreement_attribute7,
 qpa.agreement_attribute8,
 qpa.agreement_attribute9,
 qpa.agreement_attribute10,
 qpa.agreement_attribute11,
 qpa.agreement_attribute12,
 qpa.agreement_attribute13,
 qpa.agreement_attribute14,
 qpa.agreement_attribute15,
 qll.line_dff_context,
 qll.line_attribue1,
 qll.line_attribue2,
 qll.line_attribue3,
 qll.line_attribue4,
 qll.line_attribue5,
 qll.line_attribue6,
 qll.line_attribue7,
 qll.line_attribue8,
 qll.line_attribue9,
 qll.line_attribue10,
 qll.line_attribue11,
 qll.line_attribue12,
 qll.line_attribue13,
 qll.line_attribue14,
 qll.line_attribue15,
 -- audit
 qpa.agreement_created_by,
 qpa.agreement_creation_date,
 qpa.agreement_last_updated_by,
 qpa.agreement_last_update_date,
 qpb.created_by,
 qpb.creation_date,
 qpb.last_updated_by,
 qpb.last_update_date,
 -- ids
 qpa.agreement_id,
 qpa.price_list_id,
 qll.list_line_id,
 --
 2 sort_order
 from
 qpa,
 qll,
 qpb,
 qpat
 where
 :p_show_price_breaks = 'Y' and
 qpa.price_list_id = qll.list_header_id and
 qpa.price_list_id = qll.pa_list_header_id and
 qll.list_line_id = qpb.parent_list_line_id and
 nvl2(qll.list_line_id,-1,-1) = qpat.list_line_id (+)
 union all
 -- Q3 Pricing Attributes
 select
 -- agreement
 qpa.agreement_name,
 qpa.agreement_num,
 qpa.revision,
 qpa.revision_date,
 qpa.revision_reason,
 qpa.start_date_active,
 qpa.end_date_active,
 qpa.customer,
 qpa.customer_number,
 qpa.agreement_type,
 qpa.agreement_contact,
 qpa.salesrep,
 qpa.purchase_order_num,
 qpa.signature_date,
 qpa.agreement_source,
 -- pricing
 qpa.price_list_type,
 qpa.price_list,
 qpa.currency_code,
 qpa.multi_currency_conversion,
 qpa.rounding_factor,
 qpa.description,
 qpa.ship_method_code,
 qpa.freight_terms,
 qpa.comments,
 -- Payment
 qpa.term,
 qpa.invoice_name,
 qpa.address1,
 qpa.address2,
 qpa.address3,
 qpa.invoice_contact,
 qpa.accounting_rule,
 qpa.invoicing_rule,
 qpa.override_accounting_rule,
 qpa.override_invoicing_rule,
 -- agreement lines
 'Pricing Attribute' line_type,
 qll.list_line_no,
 qll.customer_item,
 qll.address,
 qll.address_category,
 qll.product_value,
 qll.product_description,
 qll.uom,
 qll.primary_uom_flag,
 qll.price_break_type,
 qll.application_method,
 --qll.accumulation_attribute,
 qll.break_uom,
 qll.break_uom_attribute,
 qll.value,
 qll.dynamic_formula,
 qll.statis_formula,
 qll.line_start_date,
 qll.line_end_date,
 qll.precedence,
 qll.line_comments,
 qll.line_revsion,
 qll.line_revision_reason,
 qll.line_revision_date,
 -- price breaks
 qpb.price_break_value_from,
 qpb.price_break_value_to,
 qpb.price_break_value,
 qpb.price_break_formula,
 qpb.price_break_application_method,
 qpb.price_break_benefit_qty,
 qpb.price_break_benefit_uom,
 qpb.price_break_accrual_conv_rate,
 -- pricing attributes
 qpat.product_attribute,
 qpat.product_attribute_value,
 qpat.pricing_attribute,
 qpat.pricing_attribute_operator,
 qpat.pricing_attribute_value_from,
 qpat.pricing_attribute_value_to,
 qpat.pricing_attribute_buy_uom,
 -- dff
 qpa.agreement_dff_context,
 qpa.agreement_attribute1,
 qpa.agreement_attribute2,
 qpa.agreement_attribute3,
 qpa.agreement_attribute4,
 qpa.agreement_attribute5,
 qpa.agreement_attribute6,
 qpa.agreement_attribute7,
 qpa.agreement_attribute8,
 qpa.agreement_attribute9,
 qpa.agreement_attribute10,
 qpa.agreement_attribute11,
 qpa.agreement_attribute12,
 qpa.agreement_attribute13,
 qpa.agreement_attribute14,
 qpa.agreement_attribute15,
 qll.line_dff_context,
 qll.line_attribue1,
 qll.line_attribue2,
 qll.line_attribue3,
 qll.line_attribue4,
 qll.line_attribue5,
 qll.line_attribue6,
 qll.line_attribue7,
 qll.line_attribue8,
 qll.line_attribue9,
 qll.line_attribue10,
 qll.line_attribue11,
 qll.line_attribue12,
 qll.line_attribue13,
 qll.line_attribue14,
 qll.line_attribue15,
 -- audit
 qpa.agreement_created_by,
 qpa.agreement_creation_date,
 qpa.agreement_last_updated_by,
 qpa.agreement_last_update_date,
 qpat.created_by,
 qpat.creation_date,
 qpat.last_updated_by,
 qpat.last_update_date,
 -- ids
 qpa.agreement_id,
 qpa.price_list_id,
 qll.list_line_id,
 --
 3 sort_order
 from
 qpa,
 qll,
 qpb,
 qpat
 where
 :p_show_pricing_attributes = 'Y' and
 qpa.price_list_id = qll.list_header_id and
 qpa.price_list_id = qll.pa_list_header_id and
 nvl2(qll.list_line_id,-1,-1) = qpb.parent_list_line_id (+) and
 qll.list_line_id = qpat.list_line_id
) x
order by
x.agreement_name,
x.list_line_no,
x.sort_order,
x.price_break_value_from,
x.price_break_value