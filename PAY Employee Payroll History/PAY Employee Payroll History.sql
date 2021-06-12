/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PAY Employee Payroll History
-- Description: Master data report with one line per employee including employee number, name, payroll period and earnings.

-- Excel Examle Output: https://www.enginatics.com/example/pay-employee-payroll-history/
-- Library Link: https://www.enginatics.com/reports/pay-employee-payroll-history/
-- Run Report: https://demo.enginatics.com/

select distinct
haouv.name business_group,
papf.employee_number,
papf.full_name,
ppa.effective_date payroll_run_date,
ptp.period_name,
sum(decode(pec.classification_name,'Earnings',to_number(prrv.result_value))) earnings,
sum(decode(pec.classification_name,'Involuntary Deductions',to_number(prrv.result_value))) involuntary_deductions,
sum(decode(pec.classification_name,'Employer Charges',to_number(prrv.result_value))) employer_charges,
sum(decode(pec.classification_name,'Information',to_number(prrv.result_value))) information,
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
order by
papf.employee_number