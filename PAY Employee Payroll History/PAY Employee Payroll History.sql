/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PAY Employee Payroll History
-- Excel Examle Output: https://www.enginatics.com/example/pay-employee-payroll-history/
-- Library Link: https://www.enginatics.com/reports/pay-employee-payroll-history/
-- Run Report: https://demo.enginatics.com/

select distinct
haouv.name business_group,
ppf.employee_number,
ppf.full_name,
ppa.effective_date Payroll_Run_Date,
tp.period_name,
sum(decode(pec.classification_name,'Earnings',to_number(rrv.result_value))) Earnings,
sum(decode(pec.classification_name,'Involuntary Deductions',to_number(rrv.result_value))) Involuntary_Deductions,
sum(decode(pec.classification_name,'Employer Charges',to_number(rrv.result_value))) Employer_Charges,
sum(decode(pec.classification_name,'Information',to_number(rrv.result_value))) Information
from
hr_all_organization_units_vl haouv,
per_all_people_f ppf,
per_all_assignments_f paf,
pay_assignment_actions pas,
pay_payroll_actions ppa,
pay_run_results rr,
pay_run_result_values rrv,
pay_element_types_f ety,
pay_input_values_f I,
per_time_periods tp,
pay_element_classifications_vl pec
where
1=1 and
haouv.organization_id=paf.business_group_id and
ppf.person_id=paf.person_id and
paf.assignment_id=pas.assignment_id and
pas.assignment_action_id=rr.assignment_action_id and
ppa.payroll_action_id=pas.payroll_action_id and
rr.element_type_id=ety.element_type_id and
i.element_type_id=ety.element_type_id and
rrv.run_result_id=rr.run_result_id and
rrv.input_value_id=i.input_value_id and
tp.time_period_id=ppa.time_period_id and
ety.classification_id=pec.classification_id and
i.name='Pay Value'
--and ppa.effective_date between :p_st_effect_date  and :p_end_effect_date and
--ppf.employee_number =nvl(:p_emp_number,ppf.employee_number)
group by
haouv.name,
ppf.employee_number,
ppf.person_id,
ppf.full_name,
ppa.time_period_id,
ppa.effective_date,
tp.period_name,
paf.organization_id
order by ppf.employee_number