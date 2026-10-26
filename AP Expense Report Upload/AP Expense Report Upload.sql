/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Expense Report Upload
-- Description: Creates and updates expense reports - the Excel equivalent of the Payables Expense Reports form (Invoices > Entry > Expense Reports) - and transfers them to Payables invoices with Expense Report Export.
-- Each row is one expense report line, with the expense report header columns repeated on every line. The header values are taken from the first row of each expense report. An expense report is identified by Employee and Invoice Num.
-- Each expense report is processed as a whole: when any of its rows fails validation, none of its rows are saved. The Amount must equal the total of the lines; leave it unchanged to set it to the total of the lines.
-- The account of a line defaults from the GL Account of the expense report, overlaid with the account segments of the expense item, as in the form. Set Delete Line to Yes to delete a line.
-- With Submit Expense Report Export set to Yes, Expense Report Export runs for the operating units of the uploaded expense reports and creates the Payables invoices. As in Payables, it transfers every expense report pending export in the operating unit, also those not in the upload file. Rows of an expense report that it did not transfer (rejected, or on hold) show the reason as an error, and the expense report can be corrected and uploaded again. An exported expense report cannot be changed.
-- Excel Example Output: https://www.enginatics.com/example/ap-expense-report-upload/
-- Library Link: https://www.enginatics.com/reports/ap-expense-report-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
haouv.name operating_unit,
ppx.full_name employee_name,
nvl(ppx.employee_number,ppx.npw_number) employee_number,
aerha.week_end_date report_date,
aerha.invoice_num,
aerha.default_currency_code currency,
aerha.total amount,
aerha.description,
(select alc.displayed_field from ap_lookup_codes alc where alc.lookup_type='HOLD CODE' and aerha.hold_lookup_code=alc.lookup_code) hold,
xxen_util.meaning(aerha.expense_check_address_flag,'HOME_OFFICE',3) send_to,
gcck_h.concatenated_segments gl_account,
aera.report_type template,
gdct.user_conversion_type exchange_rate_type,
aerha.default_exchange_date exchange_date,
aerha.default_exchange_rate exchange_rate,
aag_h.name withholding_tax_group,
xxen_util.yes(case when aerha.vouchno<>0 then 'Y' end) exported,
aerha.reject_code export_rejection,
xxen_util.display_flexfield_context(200,'AP_EXPENSE_REPORT_HEADERS',aerha.attribute_category) header_attribute_category,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_HEADERS',aerha.attribute_category,'ATTRIBUTE1',aerha.rowid,aerha.attribute1) header_attribute1,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_HEADERS',aerha.attribute_category,'ATTRIBUTE2',aerha.rowid,aerha.attribute2) header_attribute2,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_HEADERS',aerha.attribute_category,'ATTRIBUTE3',aerha.rowid,aerha.attribute3) header_attribute3,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_HEADERS',aerha.attribute_category,'ATTRIBUTE4',aerha.rowid,aerha.attribute4) header_attribute4,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_HEADERS',aerha.attribute_category,'ATTRIBUTE5',aerha.rowid,aerha.attribute5) header_attribute5,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_HEADERS',aerha.attribute_category,'ATTRIBUTE6',aerha.rowid,aerha.attribute6) header_attribute6,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_HEADERS',aerha.attribute_category,'ATTRIBUTE7',aerha.rowid,aerha.attribute7) header_attribute7,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_HEADERS',aerha.attribute_category,'ATTRIBUTE8',aerha.rowid,aerha.attribute8) header_attribute8,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_HEADERS',aerha.attribute_category,'ATTRIBUTE9',aerha.rowid,aerha.attribute9) header_attribute9,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_HEADERS',aerha.attribute_category,'ATTRIBUTE10',aerha.rowid,aerha.attribute10) header_attribute10,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_HEADERS',aerha.attribute_category,'ATTRIBUTE11',aerha.rowid,aerha.attribute11) header_attribute11,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_HEADERS',aerha.attribute_category,'ATTRIBUTE12',aerha.rowid,aerha.attribute12) header_attribute12,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_HEADERS',aerha.attribute_category,'ATTRIBUTE13',aerha.rowid,aerha.attribute13) header_attribute13,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_HEADERS',aerha.attribute_category,'ATTRIBUTE14',aerha.rowid,aerha.attribute14) header_attribute14,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_HEADERS',aerha.attribute_category,'ATTRIBUTE15',aerha.rowid,aerha.attribute15) header_attribute15,
aerla.distribution_line_number line_number,
aerla.item_description item,
aerla.amount line_amount,
gcck_l.concatenated_segments line_gl_account,
aerla.vat_code tax_code,
aag_l.name line_withholding_tax_group,
aerla.merchant_name,
aerla.merchant_document_number,
aerla.merchant_tax_reg_number,
aerla.merchant_taxpayer_id,
aerla.start_expense_date receipt_date,
ftv.territory_short_name country_of_supply,
aerla.merchant_reference reference,
aerla.receipt_currency_code receipt_currency,
aerla.receipt_conversion_rate receipt_exchange_rate,
aerla.receipt_currency_amount receipt_amount,
aerla.justification,
xxen_util.yes(aerla.receipt_verified_flag) receipt_verified,
xxen_util.yes(aerla.receipt_required_flag) receipt_required,
xxen_util.yes(aerla.receipt_missing_flag) receipt_missing,
ppa.segment1 project,
pt.task_number task,
aerla.expenditure_type,
haouv_exp.name expenditure_organization,
aerla.expenditure_item_date,
xxen_util.display_flexfield_context(200,'AP_EXPENSE_REPORT_LINES',aerla.attribute_category) line_attribute_category,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_LINES',aerla.attribute_category,'ATTRIBUTE1',aerla.rowid,aerla.attribute1) line_attribute1,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_LINES',aerla.attribute_category,'ATTRIBUTE2',aerla.rowid,aerla.attribute2) line_attribute2,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_LINES',aerla.attribute_category,'ATTRIBUTE3',aerla.rowid,aerla.attribute3) line_attribute3,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_LINES',aerla.attribute_category,'ATTRIBUTE4',aerla.rowid,aerla.attribute4) line_attribute4,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_LINES',aerla.attribute_category,'ATTRIBUTE5',aerla.rowid,aerla.attribute5) line_attribute5,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_LINES',aerla.attribute_category,'ATTRIBUTE6',aerla.rowid,aerla.attribute6) line_attribute6,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_LINES',aerla.attribute_category,'ATTRIBUTE7',aerla.rowid,aerla.attribute7) line_attribute7,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_LINES',aerla.attribute_category,'ATTRIBUTE8',aerla.rowid,aerla.attribute8) line_attribute8,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_LINES',aerla.attribute_category,'ATTRIBUTE9',aerla.rowid,aerla.attribute9) line_attribute9,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_LINES',aerla.attribute_category,'ATTRIBUTE10',aerla.rowid,aerla.attribute10) line_attribute10,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_LINES',aerla.attribute_category,'ATTRIBUTE11',aerla.rowid,aerla.attribute11) line_attribute11,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_LINES',aerla.attribute_category,'ATTRIBUTE12',aerla.rowid,aerla.attribute12) line_attribute12,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_LINES',aerla.attribute_category,'ATTRIBUTE13',aerla.rowid,aerla.attribute13) line_attribute13,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_LINES',aerla.attribute_category,'ATTRIBUTE14',aerla.rowid,aerla.attribute14) line_attribute14,
xxen_util.display_flexfield_value(200,'AP_EXPENSE_REPORT_LINES',aerla.attribute_category,'ATTRIBUTE15',aerla.rowid,aerla.attribute15) line_attribute15,
null delete_line,
:p_submit_export submit_export,
aerha.report_header_id,
aerla.report_line_id,
null upload_row
from
ap_expense_report_headers_all aerha,
hr_all_organization_units_vl haouv,
per_people_x ppx,
gl_code_combinations_kfv gcck_h,
ap_expense_reports_all aera,
gl_daily_conversion_types gdct,
ap_awt_groups aag_h,
ap_expense_report_lines_all aerla,
gl_code_combinations_kfv gcck_l,
ap_awt_groups aag_l,
fnd_territories_vl ftv,
pa_projects_all ppa,
pa_tasks pt,
hr_all_organization_units_vl haouv_exp
where
1=1 and
aerha.source='XpenseXpress' and
aerha.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat) and
aerha.org_id=haouv.organization_id and
aerha.employee_id=ppx.person_id(+) and
aerha.employee_ccid=gcck_h.code_combination_id(+) and
aerha.expense_report_id=aera.expense_report_id(+) and
aerha.default_exchange_rate_type=gdct.conversion_type(+) and
aerha.awt_group_id=aag_h.group_id(+) and
aerha.report_header_id=aerla.report_header_id(+) and
nvl(aerla.itemization_parent_id(+),0)<>-1 and
aerla.code_combination_id=gcck_l.code_combination_id(+) and
aerla.awt_group_id=aag_l.group_id(+) and
aerla.country_of_supply=ftv.territory_code(+) and
aerla.project_id=ppa.project_id(+) and
aerla.task_id=pt.task_id(+) and
aerla.expenditure_organization_id=haouv_exp.organization_id(+)
