/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Invoice Upload
-- Description: AP Invoice Upload
-- Excel Examle Output: https://www.enginatics.com/example/ap-invoice-upload/
-- Library Link: https://www.enginatics.com/reports/ap-invoice-upload/
-- Run Report: https://demo.enginatics.com/

/*
&report_table_name
*/
select
x.*
from
(
with
q_dual as (select * from dual) -- dummy to allow the lexical to follow
&error_with_query
&success_with_query
select
null                    action_,
null                    status_,
null                    message_,
null                    request_id_,
to_number(null)         inv_int_id,
to_number(null)         line_int_id,
null batch_name,
null submit_validation,
null invoice_calculate_tax,
null invoice_inclusive_of_tax,
--
alc.displayed_field     source,
haouv.name              operating_unit,
asu.vendor_name         supplier_name,
asu.segment1            supplier_number,
assa.vendor_site_code   supplier_site,
xxen_util.meaning(aia.invoice_type_lookup_code,'INVOICE TYPE',200) invoice_type,
(select fdsc.name from fnd_doc_sequence_categories fdsc where fdsc.application_id = 200 and fdsc.table_name in ('AP_INVOICES','AP_INVOICES_ALL') and fdsc.code = aia.doc_category_code) document_category,
aia.invoice_num         invoice_number,
aia.description         invoice_description,
(select pha.segment1 from po_headers_all pha where pha.po_header_id = nvl(aia.po_header_id,aia.quick_po_header_id)) invoice_po_number,
aia.invoice_date,
aia.gl_date,
aia.invoice_amount,
aia.amount_applicable_to_discount,
aia.invoice_currency_code  invoice_currency,
(select gdct.user_conversion_type from gl_daily_conversion_types gdct where gdct.conversion_type = aia.exchange_rate_type) exchange_rate_type,
aia.exchange_date,
aia.exchange_rate,
(select ate.name from ap_terms ate where ate.term_id = aia.terms_id) terms,
aia.terms_date,
aia.goods_received_date,
aia.invoice_received_date,
xxen_util.meaning(aia.exclusive_payment_flag,'YES_NO',0) exclusive_payment_flag,
aia.payment_currency_code payment_currency,
(select gdct.user_conversion_type from gl_daily_conversion_types gdct where gdct.conversion_type = aia.payment_cross_rate_type) payment_cross_rate_type,
aia.payment_cross_rate_date,
aia.payment_cross_rate,
(select ipmv.payment_method_name from iby_payment_methods_vl ipmv where ipmv.payment_method_code = aia.payment_method_code) payment_method,
(select idcv.meaning from iby_delivery_channels_vl idcv where idcv.delivery_channel_code = aia.delivery_channel_code) payment_delivery_channel,
(select iprv.meaning from iby_payment_reasons_vl iprv where iprv.payment_reason_code = aia.payment_reason_code) payment_reason,
aia.payment_reason_comments,
(select flvv.meaning from fnd_lookup_values_vl flvv where flvv.lookup_type='PAY GROUP' and flvv.view_application_id = 201 and flvv.lookup_code = aia.pay_group_lookup_code) payment_group,
--apsa.payment_priority,  -- only applicable for payment request invoiece type
(select aag.name from ap_awt_groups aag where aag.group_id = aia.awt_group_id) invoice_awt_group,
(select aag.name from ap_awt_groups aag where aag.group_id = aia.awt_group_id) payment_awt_group,
--aia.ussgl_transaction_code, -- not imported by the Payables Import process
--
aila.line_number,
xxen_util.meaning(aila.line_type_lookup_code,'INVOICE LINE TYPE',200) line_type,
aila.amount line_amount,
aila.description line_description,
aila.quantity_invoiced quantity,
aila.unit_meas_lookup_code uom,
aila.unit_price,
--
aila.line_group_number line_prorate_group,
xxen_util.meaning(aila.prorate_across_all_items,'YES_NO',0) prorate_flag,
--
(select
  fsfa.alias_name
 from
  fnd_shorthand_flex_aliases fsfa
 where
  fsfa.application_id = 101 and
  fsfa.id_flex_code = 'GL#' and
  fsfa.id_flex_num = gcck.chart_of_accounts_id and
  fsfa.concatenated_segments = gcck.concatenated_segments and
  fsfa.enabled_flag = 'Y' and
  trunc(sysdate) between nvl(fsfa.start_date_active,trunc(sysdate)) and nvl(fsfa.end_date_active,trunc(sysdate)) and
  rownum <= 1
) distribution_account_alias,
gcck.concatenated_segments distribution_account,
(select adsa.distribution_set_name from ap_distribution_sets_all adsa where adsa.distribution_set_id = aila.distribution_set_id and adsa.org_id = aila.org_id) distribution_set,
--
(select hecv.full_name || ' (' || hecv.employee_num || ')' from hr_employees_current_v hecv where hecv.employee_id = aila.requester_id) requester,
--
(select pha.segment1 from po_headers_all pha where pha.po_header_id = aila.po_header_id) po_number,
(select pra.release_num from po_releases_all pra where pra.po_release_id = aila.po_release_id) po_release_num,
(select pla.line_num from po_lines_all pla where pla.po_line_id = aila.po_line_id) po_line_num,
(select plla.shipment_num from po_line_locations_all plla where plla.line_location_id = aila.po_line_location_id) po_shipment_num,
(select pda.distribution_num from po_distributions_all pda where pda.po_distribution_id = aila.po_distribution_id) po_distribution_num,
(select rsh.receipt_num from rcv_shipment_headers rsh, rcv_shipment_lines rsl where rsh.shipment_header_id = rsl.shipment_header_id and rsl.shipment_line_id = aila.rcv_shipment_line_id) po_receipt_num,
(select rsl.line_num from rcv_shipment_lines rsl where rsl.shipment_line_id = aila.rcv_shipment_line_id) po_receipt_line_num,
--
aila.manufacturer,
aila.model_number,
aila.serial_number,
aila.warranty_number,
xxen_util.meaning(aila.assets_tracking_flag,'YES_NO',0) track_as_asset,
(select fbc.book_type_name from fa_book_controls fbc where fbc.book_type_code = aila.asset_book_type_code) asset_book,
(select fck.concatenated_segments from fa_categories_b_kfv fck where fck.category_id = aila.asset_category_id) asset_category,
--
(select ppev.project_number from pa_projects_expend_v ppev where ppev.project_id = aila.project_id) project,
(select ptev.task_number from pa_tasks_expend_v ptev where ptev.task_id = aila.task_id) task,
aila.expenditure_item_date,
aila.expenditure_type,
(select poev.name from pa_organizations_expend_v poev where poev.organization_id = aila.expenditure_organization_id) expenditure_organization,
aila.pa_quantity project_quantity,
-- tax
aila.type_1099 income_tax_type,
aila.income_tax_region,
--xm.taxation_country
(select
 ft.territory_short_name
 from
 fnd_territories_vl ft
 where
 ft.territory_code = aia.taxation_country
) taxation_country,
-- xm.tax_classification,
(select
  zicv.meaning
 from
  zx_input_classifications_v zicv
 where
  zicv.lookup_type = 'ZX_INPUT_CLASSIFICATIONS' and
  zicv.lookup_code = aila.tax_classification_code and
  (zicv.org_id = aila.org_id or zicv.org_id = -99) and
  zicv.enabled_flag = 'Y' and
  trunc(sysdate) between nvl(zicv.start_date_active, trunc(sysdate)) and nvl(zicv.end_date_active, trunc(sysdate)) and
  rownum <= 1
) tax_classification,
-- xm.primary_intended_use,
(select
  zfiuv.classification_name
 from
  zx_fc_intended_use_v zfiuv
 where
  (zfiuv.country_code = aia.taxation_country or zfiuv.country_code is null) and
  trunc(sysdate) between nvl(zfiuv.effective_from,trunc(sysdate)) and nvl(zfiuv.effective_to,trunc(sysdate)) and
  trunc(sysdate) <= nvl(zfiuv.disable_date,trunc(sysdate)) and
  zfiuv.classification_code = aila.primary_intended_use and
  rownum <= 1
) primary_intended_use,
-- xm.ship_to_location,
(select
  hlat.location_code
 from
  hr_locations_all_tl hlat
 where
  hlat.location_id = aila.ship_to_location_id and
  hlat.language = userenv('LANG') and
  rownum <= 1
) ship_to_location,
-- xm.product_fiscal_classification,
(select
  zfpcv.classification_name
 from
  zx_fc_product_fiscal_v zfpcv
 where
  (zfpcv.country_code = aia.taxation_country or zfpcv.country_code is null) and
  (zfpcv.effective_to >= trunc(sysdate) or zfpcv.effective_to is null) and
  zfpcv.classification_code = aila.product_fisc_classification and
  rownum <= 1
) product_fiscal_classification,
-- xm.fiscal_classification,
(select
  zfudv.classification_name
 from
  zx_fc_user_defined_v zfudv
 where
  (zfudv.country_code = aia.taxation_country or zfudv.country_code is null) and
  trunc(sysdate) between nvl(zfudv.effective_from,trunc(sysdate)) and nvl(zfudv.effective_to,trunc(sysdate)) and
  zfudv.classification_code = aila.user_defined_fisc_class and
  rownum <= 1
) fiscal_classification,
-- xm.business_category,
(select
  zfbcv.classification_name
 from
  zx_fc_business_categories_v zfbcv
 where
  (zfbcv.country_code = aia.taxation_country or zfbcv.country_code is null) and
  trunc(sysdate) between nvl(zfbcv.effective_from,trunc(sysdate)) and nvl(zfbcv.effective_to,trunc(sysdate)) and
  zfbcv.application_id = 200 and
  zfbcv.entity_code = 'AP_INVOICES' and
  zfbcv.event_class_code IN ('STANDARD INVOICES','PREPAYMENT INVOICES','EXPENSE REPORTS') and
  zfbcv.classification_code = aila.trx_business_category and
  rownum <= 1
) business_category,
-- xm.product_type,
(select
  zptv.classification_name
 from
  zx_product_types_v zptv
 where
  zptv.classification_code = aila.product_type and
  rownum <= 1
) product_type,
-- xm.product_category
(select
  zfpcv.classification_name
 from
  zx_fc_product_categories_v zfpcv
 where
  (zfpcv.country_code = aia.taxation_country or zfpcv.country_code is null) and
  trunc(sysdate) between nvl(zfpcv.effective_from,trunc(sysdate)) and nvl(zfpcv.effective_to,trunc(sysdate)) and
  zfpcv.classification_code = aila.product_category and
  rownum <= 1
) product_category,
-- tax line only columns
aila.tax_regime_code tax_regime,
aila.tax tax,
aila.tax_status_code tax_status,
aila.tax_jurisdiction_code tax_jurisdiction,
aila.tax_rate_code tax_rate_name,
aila.tax_rate tax_rate,
--
aila.assessable_value,
(select aag.name from ap_awt_groups aag where aag.group_id = aila.awt_group_id) line_invoice_awt_group,
(select aag.name from ap_awt_groups aag where aag.group_id = aila.awt_group_id) line_payment_awt_group,
--
(select flvv.meaning from fnd_lookup_values_vl flvv where flvv.lookup_type='IBY_BANK_CHARGE_BEARER' and flvv.view_application_id = 0 and flvv.lookup_code = aia.bank_charge_bearer) bank_charge_bearer,
aia.remittance_message1,
aia.remittance_message2,
aia.remittance_message3,
aia.unique_remittance_identifier,
aia.uri_check_digit,
--
aia.reference_1 invoice_reference_1,
aia.reference_2 invoice_reference_2,
aia.reference_key1 invoice_reference_key1,
aia.reference_key2 invoice_reference_key2,
aia.reference_key3 invoice_reference_key3,
aia.reference_key4 invoice_reference_key4,
aia.reference_key5 invoice_reference_key5,
aila.reference_1 line_reference_1,
aila.reference_2 line_reference_2,
aila.reference_key1 line_reference_key1,
aila.reference_key2 line_reference_key2,
aila.reference_key3 line_reference_key3,
aila.reference_key4 line_reference_key4,
aila.reference_key5 line_reference_key5,
--
xxen_util.display_flexfield_context(200,'AP_INVOICES',aia.attribute_category) invoice_attribute_category,
xxen_util.display_flexfield_value(200,'AP_INVOICES',aia.attribute_category,'ATTRIBUTE1',aia.rowid,aia.attribute1) ap_inv_attribute1,
xxen_util.display_flexfield_value(200,'AP_INVOICES',aia.attribute_category,'ATTRIBUTE2',aia.rowid,aia.attribute2) ap_inv_attribute2,
xxen_util.display_flexfield_value(200,'AP_INVOICES',aia.attribute_category,'ATTRIBUTE3',aia.rowid,aia.attribute3) ap_inv_attribute3,
xxen_util.display_flexfield_value(200,'AP_INVOICES',aia.attribute_category,'ATTRIBUTE4',aia.rowid,aia.attribute4) ap_inv_attribute4,
xxen_util.display_flexfield_value(200,'AP_INVOICES',aia.attribute_category,'ATTRIBUTE5',aia.rowid,aia.attribute5) ap_inv_attribute5,
xxen_util.display_flexfield_value(200,'AP_INVOICES',aia.attribute_category,'ATTRIBUTE6',aia.rowid,aia.attribute6) ap_inv_attribute6,
xxen_util.display_flexfield_value(200,'AP_INVOICES',aia.attribute_category,'ATTRIBUTE7',aia.rowid,aia.attribute7) ap_inv_attribute7,
xxen_util.display_flexfield_value(200,'AP_INVOICES',aia.attribute_category,'ATTRIBUTE8',aia.rowid,aia.attribute8) ap_inv_attribute8,
xxen_util.display_flexfield_value(200,'AP_INVOICES',aia.attribute_category,'ATTRIBUTE9',aia.rowid,aia.attribute9) ap_inv_attribute9,
xxen_util.display_flexfield_value(200,'AP_INVOICES',aia.attribute_category,'ATTRIBUTE10',aia.rowid,aia.attribute10) ap_inv_attribute10,
xxen_util.display_flexfield_value(200,'AP_INVOICES',aia.attribute_category,'ATTRIBUTE11',aia.rowid,aia.attribute11) ap_inv_attribute11,
xxen_util.display_flexfield_value(200,'AP_INVOICES',aia.attribute_category,'ATTRIBUTE12',aia.rowid,aia.attribute12) ap_inv_attribute12,
xxen_util.display_flexfield_value(200,'AP_INVOICES',aia.attribute_category,'ATTRIBUTE13',aia.rowid,aia.attribute13) ap_inv_attribute13,
xxen_util.display_flexfield_value(200,'AP_INVOICES',aia.attribute_category,'ATTRIBUTE14',aia.rowid,aia.attribute14) ap_inv_attribute14,
xxen_util.display_flexfield_value(200,'AP_INVOICES',aia.attribute_category,'ATTRIBUTE15',aia.rowid,aia.attribute15) ap_inv_attribute15,
xxen_util.display_flexfield_context(200,'AP_INVOICE_LINES',aila.attribute_category) line_attribute_category,
xxen_util.display_flexfield_value(200,'AP_INVOICE_LINES',aila.attribute_category,'ATTRIBUTE1',aila.rowid,aila.attribute1) ap_inv_line_attribute1,
xxen_util.display_flexfield_value(200,'AP_INVOICE_LINES',aila.attribute_category,'ATTRIBUTE2',aila.rowid,aila.attribute2) ap_inv_line_attribute2,
xxen_util.display_flexfield_value(200,'AP_INVOICE_LINES',aila.attribute_category,'ATTRIBUTE3',aila.rowid,aila.attribute3) ap_inv_line_attribute3,
xxen_util.display_flexfield_value(200,'AP_INVOICE_LINES',aila.attribute_category,'ATTRIBUTE4',aila.rowid,aila.attribute4) ap_inv_line_attribute4,
xxen_util.display_flexfield_value(200,'AP_INVOICE_LINES',aila.attribute_category,'ATTRIBUTE5',aila.rowid,aila.attribute5) ap_inv_line_attribute5,
xxen_util.display_flexfield_value(200,'AP_INVOICE_LINES',aila.attribute_category,'ATTRIBUTE6',aila.rowid,aila.attribute6) ap_inv_line_attribute6,
xxen_util.display_flexfield_value(200,'AP_INVOICE_LINES',aila.attribute_category,'ATTRIBUTE7',aila.rowid,aila.attribute7) ap_inv_line_attribute7,
xxen_util.display_flexfield_value(200,'AP_INVOICE_LINES',aila.attribute_category,'ATTRIBUTE8',aila.rowid,aila.attribute8) ap_inv_line_attribute8,
xxen_util.display_flexfield_value(200,'AP_INVOICE_LINES',aila.attribute_category,'ATTRIBUTE9',aila.rowid,aila.attribute9) ap_inv_line_attribute9,
xxen_util.display_flexfield_value(200,'AP_INVOICE_LINES',aila.attribute_category,'ATTRIBUTE10',aila.rowid,aila.attribute10) ap_inv_line_attribute10,
xxen_util.display_flexfield_value(200,'AP_INVOICE_LINES',aila.attribute_category,'ATTRIBUTE11',aila.rowid,aila.attribute11) ap_inv_line_attribute11,
xxen_util.display_flexfield_value(200,'AP_INVOICE_LINES',aila.attribute_category,'ATTRIBUTE12',aila.rowid,aila.attribute12) ap_inv_line_attribute12,
xxen_util.display_flexfield_value(200,'AP_INVOICE_LINES',aila.attribute_category,'ATTRIBUTE13',aila.rowid,aila.attribute13) ap_inv_line_attribute13,
xxen_util.display_flexfield_value(200,'AP_INVOICE_LINES',aila.attribute_category,'ATTRIBUTE14',aila.rowid,aila.attribute14) ap_inv_line_attribute14,
xxen_util.display_flexfield_value(200,'AP_INVOICE_LINES',aila.attribute_category,'ATTRIBUTE15',aila.rowid,aila.attribute15) ap_inv_line_attribute15,
null attachment_category_,
null attachment_title_,
null attachment_description_,
null attachment_type_,
null attachment_content_,
null attachment_file_id_
from
ap_invoices_all aia,
ap_payment_schedules_all apsa,
ap_invoice_lines_all aila,
hr_all_organization_units_vl haouv,
ap_suppliers asu,
ap_supplier_sites_all assa,
gl_code_combinations_kfv gcck,
ap_lookup_codes alc
where
aia.invoice_id = apsa.invoice_id (+) and
aia.invoice_id = aila.invoice_id and
aia.vendor_id = asu.vendor_id and
aia.vendor_site_id = assa.vendor_site_id and
aia.org_id = haouv.organization_id and
aila.default_dist_ccid = gcck.code_combination_id (+) and
alc.lookup_type = 'SOURCE' and
alc.lookup_code = aia.source and
haouv.name = :p_operating_unit and
alc.displayed_field = :p_source and
:p_batch_name = :p_batch_name and
nvl(:p_tax_inclusive_flag,'?') = nvl(:p_tax_inclusive_flag,'?') and
nvl(:p_calulate_tax_flag,'?') = nvl(:p_calulate_tax_flag,'?') and
nvl(:p_gl_date,sysdate) = nvl(:p_gl_date,sysdate) and
nvl(:p_submit_validation,'N') = nvl(:p_submit_validation,'N') and
nvl(:p_default_taxation_country,'XX') = nvl(:p_default_taxation_country,'XX') and
1=0
&not_use_first_block
&processed_run_query
&processed_run
) x
order by
x.operating_unit,
x.invoice_date,
x.supplier_name,
x.invoice_number,
x.line_number