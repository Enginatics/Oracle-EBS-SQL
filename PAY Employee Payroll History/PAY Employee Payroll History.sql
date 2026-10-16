/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PAY Employee Payroll History
-- Description: Payroll results per employee and payroll run date: run result Pay Values summed by element classification.
-- Net Pay is Earnings plus Supplemental Earnings minus Pre-Tax, Tax, Voluntary and Involuntary Deductions, which equals the prepayment amount of the US payroll. Imputed Earnings and Information elements do not count towards it.
-- Previous Net Pay is the employee's net pay of the preceding payroll run date within the selected run date range, so the first run date of an employee has no variance. Use Variance % Over to list only changes above a percentage.
-- Excel Example Output: https://www.enginatics.com/example/pay-employee-payroll-history/
-- Library Link: https://www.enginatics.com/reports/pay-employee-payroll-history/
-- Run Report: https://demo.enginatics.com/

select
y.business_group,
y.employee_number,
y.full_name,
y.payroll_run_date,
y.period_name,
y.earnings,
y.involuntary_deductions,
y.employer_charges,
y.information,
y.supplemental_earnings,
y.pre_tax_deductions,
y.tax_deductions,
y.voluntary_deductions,
y.total_deductions,
y.net_pay,
y.previous_net_pay,
y.net_pay-y.previous_net_pay net_pay_variance,
case when y.previous_net_pay<>0 then round(100*(y.net_pay-y.previous_net_pay)/abs(y.previous_net_pay),2) end net_pay_variance_percent,
y.employee_number_and_name
from
(
select
x.*,
x.earnings_+x.supplemental_earnings_-x.total_deductions_ net_pay,
lag(x.earnings_+x.supplemental_earnings_-x.total_deductions_) over (partition by x.person_id order by x.payroll_run_date) previous_net_pay
from
(
select distinct
haouv.name business_group,
papf.employee_number,
papf.full_name,
papf.person_id,
ppa.effective_date payroll_run_date,
ptp.period_name,
sum(decode(pec.classification_name,'Earnings',to_number(prrv.result_value))) earnings,
sum(decode(pec.classification_name,'Involuntary Deductions',to_number(prrv.result_value))) involuntary_deductions,
sum(decode(pec.classification_name,'Employer Charges',to_number(prrv.result_value))) employer_charges,
sum(decode(pec.classification_name,'Information',to_number(prrv.result_value))) information,
sum(decode(pec.classification_name,'Supplemental Earnings',to_number(prrv.result_value))) supplemental_earnings,
sum(decode(pec.classification_name,'Pre-Tax Deductions',to_number(prrv.result_value))) pre_tax_deductions,
sum(decode(pec.classification_name,'Tax Deductions',to_number(prrv.result_value))) tax_deductions,
sum(decode(pec.classification_name,'Voluntary Deductions',to_number(prrv.result_value))) voluntary_deductions,
sum(case when pec.classification_name in ('Pre-Tax Deductions','Tax Deductions','Voluntary Deductions','Involuntary Deductions') then to_number(prrv.result_value) end) total_deductions,
nvl(sum(decode(pec.classification_name,'Earnings',to_number(prrv.result_value))),0) earnings_,
nvl(sum(decode(pec.classification_name,'Supplemental Earnings',to_number(prrv.result_value))),0) supplemental_earnings_,
nvl(sum(case when pec.classification_name in ('Pre-Tax Deductions','Tax Deductions','Voluntary Deductions','Involuntary Deductions') then to_number(prrv.result_value) end),0) total_deductions_,
papf.employee_number||' - '||papf.full_name employee_number_and_name
from
hr_all_organization_units_vl haouv,
(select papf.* from per_all_people_f papf where :effective_date between papf.effective_start_date and papf.effective_end_date) papf,
(select paaf.* from per_all_assignments_f paaf where :effective_date between paaf.effective_start_date and paaf.effective_end_date) paaf,
pay_assignment_actions pas,
pay_payroll_actions ppa,
pay_run_results prr,
pay_run_result_values prrv,
(select petf.* from pay_element_types_f petf where :effective_date between petf.effective_start_date and petf.effective_end_date) petf,
(select pivf.* from pay_input_values_f pivf where :effective_date between pivf.effective_start_date and pivf.effective_end_date) pivf,
per_time_periods ptp,
pay_element_classifications_vl pec
where
1=1 and
haouv.organization_id=paaf.business_group_id and
papf.person_id=paaf.person_id and
paaf.assignment_id=pas.assignment_id and
pas.assignment_action_id=prr.assignment_action_id and
ppa.payroll_action_id=pas.payroll_action_id and
prr.element_type_id=petf.element_type_id and
pivf.element_type_id=petf.element_type_id and
prrv.run_result_id=prr.run_result_id and
prrv.input_value_id=pivf.input_value_id and
ptp.time_period_id=ppa.time_period_id and
petf.classification_id=pec.classification_id and
pivf.name='Pay Value'
group by
haouv.name,
papf.employee_number,
papf.person_id,
papf.full_name,
ppa.time_period_id,
ppa.effective_date,
ptp.period_name,
paaf.organization_id
) x
) y
where
2=2
order by
y.employee_number,
y.payroll_run_date
