/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Invoice Upload 11i
-- Description: AP Invoice Upload which uses Payables Open Interface Import as a standard program to create invoices.
This upload also triggers Standard "Invoice Validation" program as a post processor.
-- Excel Examle Output: https://www.enginatics.com/example/ap-invoice-upload-11i/
-- Library Link: https://www.enginatics.com/reports/ap-invoice-upload-11i/
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
null                    row_id,
null batch_name,
null submit_validation,
--
alc.displayed_field     source,
haouv.name              operating_unit,
pv.vendor_name         supplier_name,
pv.segment1            supplier_number,
pvsa.vendor_site_code   supplier_site,
xxen_util.meaning(aia.invoice_type_lookup_code,'INVOICE TYPE',200) invoice_type,
aia.invoice_num         invoice_number,
aia.description         invoice_description,
(select pha.segment1 from po_headers_all pha where pha.po_header_id = aia.po_header_id) invoice_po_number,
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
nvl(xxen_util.meaning(apsa.payment_method_lookup_code,'PAYMENT METHOD',200),apsa.payment_method_lookup_code) payment_method,
(select flvv.meaning from fnd_lookup_values_vl flvv where flvv.lookup_type='PAY GROUP' and flvv.view_application_id = 201 and flvv.lookup_code = aia.pay_group_lookup_code) payment_group,
--apsa.payment_priority,  -- only applicable for payment request invoice type
(select aag.name from ap_awt_groups aag where aag.group_id = aia.awt_group_id) invoice_awt_group,
--aia.ussgl_transaction_code, -- not imported by the Payables Import process
--
aida.distribution_line_number line_number,
xxen_util.meaning(aida.line_type_lookup_code,'INVOICE DISTRIBUTION TYPE',200) line_type,
aida.amount line_amount,
aida.description line_description,
aida.quantity_invoiced quantity,
aida.unit_price,
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
--(select adsa.distribution_set_name from ap_distribution_sets_all adsa where adsa.distribution_set_id = pvsa.distribution_set_id and adsa.org_id = aida.org_id) distribution_set,
null distribution_set, -- No destination in base table in 11i,
--
(select hecv.full_name || ' (' || hecv.employee_num || ')' from hr_employees_current_v hecv where hecv.employee_id = aia.requester_id) requester,
--
(select pha.segment1 from po_headers_all pha where pha.po_header_id = pda.po_header_id) po_number,
(select pra.release_num from po_releases_all pra,po_line_locations_all plla where pra.po_release_id = plla.po_release_id and plla.line_location_id = pda.line_location_id) po_release_num,
(select pla.line_num from po_lines_all pla where pla.po_line_id = pda.po_line_id) po_line_num,
(select plla.shipment_num from po_line_locations_all plla where plla.line_location_id = pda.line_location_id) po_shipment_num,
 pda.distribution_num  po_distribution_num,
(select rsh.receipt_num from rcv_shipment_headers rsh,rcv_shipment_lines rsl,rcv_transactions rtxns where rsl.shipment_line_id = rtxns.shipment_line_id and aida.rcv_transaction_id = rtxns.transaction_id and rsl.shipment_header_id = rsh.shipment_header_id) po_receipt_num,
(select rsl.line_num from rcv_shipment_lines rsl,rcv_transactions rtxns where rsl.shipment_line_id = rtxns.shipment_line_id and aida.rcv_transaction_id = rtxns.transaction_id) po_receipt_line_num,
--
xxen_util.meaning(aida.assets_tracking_flag,'YES_NO',0) track_as_asset,
--
(select pap.segment1 from pa_projects_all pap where pap.project_id = aida.project_id) project,
(select pat.task_number from pa_tasks pat where pat.task_id = aida.task_id) task,
aida.expenditure_item_date,
aida.expenditure_type,
(select hou.name from hr_organization_units hou where hou.organization_id = aida.expenditure_organization_id) expenditure_organization,
aida.pa_quantity project_quantity,
-- tax
aida.type_1099 income_tax_type,
aida.income_tax_region,
aida.amount_includes_tax_flag,
(select
 atc.name
 from
 ap_tax_codes atc
 where atc.tax_id=aida.tax_code_id
) tax_code,
(select aag.name from ap_awt_groups aag where aag.group_id = aida.awt_group_id) line_invoice_awt_group,
--
aida.reference_1 line_reference_1,
aida.reference_2 line_reference_2,
--
aia.attribute_category invoice_attribute_category,
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
aida.attribute_category line_attribute_category,
xxen_util.display_flexfield_value(200,'AP_INVOICE_DISTRIBUTIONS',aida.attribute_category,'ATTRIBUTE1',aida.rowid,aida.attribute1) ap_inv_line_attribute1,
xxen_util.display_flexfield_value(200,'AP_INVOICE_DISTRIBUTIONS',aida.attribute_category,'ATTRIBUTE2',aida.rowid,aida.attribute2) ap_inv_line_attribute2,
xxen_util.display_flexfield_value(200,'AP_INVOICE_DISTRIBUTIONS',aida.attribute_category,'ATTRIBUTE3',aida.rowid,aida.attribute3) ap_inv_line_attribute3,
xxen_util.display_flexfield_value(200,'AP_INVOICE_DISTRIBUTIONS',aida.attribute_category,'ATTRIBUTE4',aida.rowid,aida.attribute4) ap_inv_line_attribute4,
xxen_util.display_flexfield_value(200,'AP_INVOICE_DISTRIBUTIONS',aida.attribute_category,'ATTRIBUTE5',aida.rowid,aida.attribute5) ap_inv_line_attribute5,
xxen_util.display_flexfield_value(200,'AP_INVOICE_DISTRIBUTIONS',aida.attribute_category,'ATTRIBUTE6',aida.rowid,aida.attribute6) ap_inv_line_attribute6,
xxen_util.display_flexfield_value(200,'AP_INVOICE_DISTRIBUTIONS',aida.attribute_category,'ATTRIBUTE7',aida.rowid,aida.attribute7) ap_inv_line_attribute7,
xxen_util.display_flexfield_value(200,'AP_INVOICE_DISTRIBUTIONS',aida.attribute_category,'ATTRIBUTE8',aida.rowid,aida.attribute8) ap_inv_line_attribute8,
xxen_util.display_flexfield_value(200,'AP_INVOICE_DISTRIBUTIONS',aida.attribute_category,'ATTRIBUTE9',aida.rowid,aida.attribute9) ap_inv_line_attribute9,
xxen_util.display_flexfield_value(200,'AP_INVOICE_DISTRIBUTIONS',aida.attribute_category,'ATTRIBUTE10',aida.rowid,aida.attribute10) ap_inv_line_attribute10,
xxen_util.display_flexfield_value(200,'AP_INVOICE_DISTRIBUTIONS',aida.attribute_category,'ATTRIBUTE11',aida.rowid,aida.attribute11) ap_inv_line_attribute11,
xxen_util.display_flexfield_value(200,'AP_INVOICE_DISTRIBUTIONS',aida.attribute_category,'ATTRIBUTE12',aida.rowid,aida.attribute12) ap_inv_line_attribute12,
xxen_util.display_flexfield_value(200,'AP_INVOICE_DISTRIBUTIONS',aida.attribute_category,'ATTRIBUTE13',aida.rowid,aida.attribute13) ap_inv_line_attribute13,
xxen_util.display_flexfield_value(200,'AP_INVOICE_DISTRIBUTIONS',aida.attribute_category,'ATTRIBUTE14',aida.rowid,aida.attribute14) ap_inv_line_attribute14,
xxen_util.display_flexfield_value(200,'AP_INVOICE_DISTRIBUTIONS',aida.attribute_category,'ATTRIBUTE15',aida.rowid,aida.attribute15) ap_inv_line_attribute15,
null attachment_category_,
null attachment_title_,
null attachment_description_,
null attachment_type_,
null attachment_content_,
null attachment_file_id_
from
ap_invoices_all aia,
ap_payment_schedules_all apsa,
ap_invoice_distributions_all aida,
po_distributions_all pda,
hr_all_organization_units_vl haouv,
po_vendors pv,
po_vendor_sites_all pvsa,
gl_code_combinations_kfv gcck,
ap_lookup_codes alc
where
aia.invoice_id = apsa.invoice_id (+) and
aia.invoice_id = aida.invoice_id and
aia.vendor_id = pv.vendor_id and
aia.vendor_site_id = pvsa.vendor_site_id and
aia.org_id = haouv.organization_id and
aida.po_distribution_id=pda.po_distribution_id(+) and
aida.dist_code_combination_id = gcck.code_combination_id (+) and
alc.lookup_type = 'SOURCE' and
alc.lookup_code = aia.source and
haouv.name = :p_operating_unit and
alc.displayed_field = :p_source and
:p_batch_name = :p_batch_name and
nvl(:p_gl_date,sysdate) = nvl(:p_gl_date,sysdate) and
nvl(:p_submit_validation,'N') = nvl(:p_submit_validation,'N') and
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