/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Expenses
-- Description: Detail AP expense report listing corresponding AP invoices with status, line details, expense type and expense justification. Including projects task related expenses.
-- Excel Examle Output: https://www.enginatics.com/example/ap-expenses/
-- Library Link: https://www.enginatics.com/reports/ap-expenses/
-- Run Report: https://demo.enginatics.com/

select
gl.name Ledger,
hou.name operating_unit,
ppx.full_name employee_name,
xxen_util.meaning(aerha.source,'SOURCE',200) source,
decode(ppx.current_npw_flag, 'Y', ppx.npw_number, ppx.employee_number) employee_number,
aerha.invoice_num expense_report_number,
aerha.description purpose,
case when aerha.source in ('Both Pay','CREDIT CARD') then aps.vendor_name end card_provider,
trunc(aerha.week_end_date) expense_report_date,
aerha.total expense_amount,
aerha.default_currency_code currency,
gcck.concatenated_segments gl_account,
nvl(aerha.report_submitted_date,aerha.creation_date) report_submitted_date,
initcap(aerha.receipts_status) original_receipt_status,
aerha.receipts_received_date,
&image_receipt_columns
xxen_util.meaning(case when aerha.audit_code in ('PAPERLESS_AUDIT','RECEIPT_BASED') and nvl(aerha.workflow_approved_flag,'M') in ('N','M') then 'Y' end,'YES_NO',0) requires_audit,
xxen_util.meaning(nvl2(aaq.auditor_id,'Y',null),'YES_NO',0) auditor_assigned,
ap_web_audit_utils.get_audit_reason(aerha.report_header_id) audit_reason,
decode(aaq.auditor_id,-1,fnd_message.get_string('SQLAP','OIE_AUD_FALLBACK_AUDITOR'),xxen_util.user_name(aaq.auditor_id)) auditor,
xxen_util.meaning(nvl(aerha.audit_code,'AUDIT'),'OIE_AUDIT_TYPES',200) audit_type,
xxen_util.user_name(aerha.last_audited_by) last_audited_by,
xxen_util.user_name(aerha.last_updated_by) last_updated_by,
ap_web_expense_form.get_num_total_violations(aerha.report_header_id) num_total_violations,
ap_web_expense_form.get_num_violation_lines(aerha.report_header_id) num_violation_lines,
aerha.report_filing_number,
xxen_util.meaning(nvl2(aia.cancelled_date,'CANCELLED',aerha.expense_status_code),'EXPENSE REPORT STATUS',200) expense_status,
decode(aerha.workflow_approved_flag,'S','saved','I','implicit save','R','manager rejected','T','returned to preparer','M','manager approved','P','payables approved','A','automatically approved','W','withdrawn','Y','manager and payables approved','submitted') workflow_approved_status,
xxen_util.meaning(case when aerha.workflow_approved_flag in ('Y','A','M') then 'Y' end,'YES_NO',0) mgmt_reviewed,
xxen_util.meaning(case when aerha.audit_code='AUTO_APPROVE' or aerha.workflow_approved_flag='A' then 'Y' end,'YES_NO',0) auto_approved,
(select ppx.full_name from per_people_x ppx where aerha.expense_current_approver_id=ppx.person_id) current_approver,
xxen_util.meaning(nvl2(aerha.holding_report_header_id,'Y',null),'YES_NO',0) hold_flag,
xxen_util.meaning(case when aerha.workflow_approved_flag in ('Y','A','P') or aerha.audit_code='AUTO_APPROVE' then 'Y' end,'YES_NO',0) ap_reviewed,
xxen_util.meaning(nvl2(aia.invoice_num,'Y',null),'YES_NO',0) ap_invoice_created,
xxen_util.meaning(aia.payment_status_flag,'INVOICE PAYMENT STATUS',200) payment_status,
(
select
max(aca.check_date)
from
ap_invoice_payments_all aipa,
ap_checks_all aca
where
aia.invoice_id=aipa.invoice_id and
aipa.check_id=aca.check_id and
aca.void_date is null and
aca.stopped_date is null
) payment_date,
&lines_columns
&per_diem_columns
aerha.expense_report_id
from
gl_ledgers gl,
hr_operating_units hou,
ap_expense_report_headers_all aerha,
per_people_x ppx,
gl_code_combinations_kfv gcck,
ap_aud_queues aaq,
ap_suppliers aps,
ap_invoices_all aia,
(select aerla.* from ap_expense_report_lines_all aerla where '&show_lines'='Y') aerla,
&per_diem_table
(select aerda.* from ap_exp_report_dists_all aerda where '&show_lines'='Y') aerda,
gl_code_combinations_kfv gcck2,
gms_awards_all gaa
&proj_tasks_tables
where
1=1 and
aerha.set_of_books_id=gl.ledger_id and
hou.organization_id=aerha.org_id and
aerha.employee_id=ppx.person_id(+) and
aerha.employee_ccid=gcck.code_combination_id(+) and
aerha.vendor_id=aps.vendor_id(+) and
aerha.vouchno=aia.invoice_id(+) and
aerha.report_header_id=aaq.expense_report_id(+) and
aerha.report_header_id=aerla.report_header_id(+) and
&per_diem_join
aerla.report_line_id=aerda.report_line_id(+) and
aerda.code_combination_id=gcck2.code_combination_id(+) and
aerda.award_id=gaa.award_id(+)
&proj_tasks_joins