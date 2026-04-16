/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Expense Policy Violations
-- Description: Expense report policy violations showing violation type, allowable amount, exceeded amount and expense line details for each violation. Based on Oracle iExpense policy enforcement.
-- Excel Examle Output: https://www.enginatics.com/example/ap-expense-policy-violations/
-- Library Link: https://www.enginatics.com/reports/ap-expense-policy-violations/
-- Run Report: https://demo.enginatics.com/

select
gl.name ledger,
hou.name operating_unit,
ppx.full_name employee_name,
decode(ppx.current_npw_flag,'Y',ppx.npw_number,ppx.employee_number) employee_number,
aerha.invoice_num expense_report_number,
aerha.description purpose,
trunc(aerha.week_end_date) expense_report_date,
xxen_util.meaning(nvl2(aia.cancelled_date,'CANCELLED',aerha.expense_status_code),'EXPENSE REPORT STATUS',200) expense_status,
xxen_util.meaning(aerha.source,'SOURCE',200) source,
aerha.total expense_report_amount,
aerha.default_currency_code currency,
aerla.distribution_line_number line_number,
nvl(aerpa.web_friendly_prompt,aerpa.prompt) expense_type,
aerla.category_code expense_category,
aerla.start_expense_date,
aerla.end_expense_date,
aerla.amount line_amount,
aerla.submitted_amount,
aerla.receipt_currency_code,
aerla.receipt_currency_amount,
aerla.item_description,
aerla.justification,
aerla.merchant_name,
aerla.location,
apva.violation_number,
xxen_util.meaning(apva.violation_type,'OIE_POL_VIOLATION_TYPES',200) violation_type,
apva.violation_date,
apva.allowable_amount,
apva.exceeded_amount,
apva.func_currency_allowable_amt functional_allowable_amount,
gcck.concatenated_segments expense_account,
nvl(aerha.report_submitted_date,aerha.creation_date) report_submitted_date,
(select ppx0.full_name from per_people_x ppx0 where aerha.expense_current_approver_id=ppx0.person_id) current_approver,
xxen_util.meaning(nvl(aerha.audit_code,'AUDIT'),'OIE_AUDIT_TYPES',200) audit_type,
aerha.report_header_id
from
gl_ledgers gl,
hr_operating_units hou,
ap_expense_report_headers_all aerha,
per_people_x ppx,
ap_expense_report_lines_all aerla,
ap_expense_report_params_all aerpa,
ap_pol_violations_all apva,
gl_code_combinations_kfv gcck,
ap_invoices_all aia
where
1=1 and
aerha.set_of_books_id=gl.ledger_id and
hou.organization_id=aerha.org_id and
aerha.employee_id=ppx.person_id(+) and
aerha.report_header_id=aerla.report_header_id and
aerla.report_header_id=apva.report_header_id and
aerla.distribution_line_number=apva.distribution_line_number and
aerla.web_parameter_id=aerpa.parameter_id(+) and
aerla.code_combination_id=gcck.code_combination_id(+) and
aerha.vouchno=aia.invoice_id(+)
order by
nvl(aerha.report_submitted_date,aerha.creation_date) desc,
aerha.invoice_num,
aerla.distribution_line_number,
apva.violation_number