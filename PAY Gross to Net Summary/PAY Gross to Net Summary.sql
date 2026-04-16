/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PAY Gross to Net Summary
-- Description: Payroll gross-to-net summary per employee and pay period, showing gross pay (earnings), pre-tax deductions, involuntary deductions (tax), voluntary deductions, employer charges, and calculated net pay. Based on completed payroll run results. Useful for payroll reconciliation and compensation analysis.
-- Excel Examle Output: https://www.enginatics.com/example/pay-gross-to-net-summary/
-- Library Link: https://www.enginatics.com/reports/pay-gross-to-net-summary/
-- Run Report: https://demo.enginatics.com/

select
x.*,
x.gross_pay-x.involuntary_deductions-x.voluntary_deductions-x.pre_tax_deductions net_pay
from
(
select
haouv.name business_group,
papf.employee_number,
papf.full_name,
haouv2.name organization,
pjv.name job,
hla.location_code location,
paypf.payroll_name,
ptp.period_name,
ptp.start_date period_start_date,
ptp.end_date period_end_date,
sum(case when pec.classification_name in ('Earnings','Supplemental Earnings','Imputed Earnings','Non-payroll Payments') then nvl(prrv.result_value,0) end) gross_pay,
sum(case when pec.classification_name in ('Pre-Tax Deductions') then nvl(prrv.result_value,0) end) pre_tax_deductions,
sum(case when pec.classification_name in ('Involuntary Deductions','Tax Deductions') then nvl(prrv.result_value,0) end) involuntary_deductions,
sum(case when pec.classification_name in ('Voluntary Deductions') then nvl(prrv.result_value,0) end) voluntary_deductions,
sum(case when pec.classification_name in ('Employer Charges','Employer Liabilities') then nvl(prrv.result_value,0) end) employer_charges
from
hr_all_organization_units_vl haouv,
(select papf.* from per_all_people_f papf where sysdate between papf.effective_start_date and papf.effective_end_date) papf,
(select paaf.* from per_all_assignments_f paaf where sysdate between paaf.effective_start_date and paaf.effective_end_date) paaf,
hr_all_organization_units_vl haouv2,
per_jobs_vl pjv,
hr_locations_all hla,
pay_assignment_actions paa,
pay_payroll_actions ppa,
per_time_periods ptp,
pay_all_payrolls_f paypf,
pay_run_results prr,
pay_run_result_values prrv,
pay_input_values_f pivf,
pay_element_types_f petf,
pay_element_classifications pec
where
1=1 and
papf.business_group_id=haouv.organization_id and
papf.person_id=paaf.person_id and
paaf.primary_flag='Y' and
paaf.assignment_type='E' and
paaf.organization_id=haouv2.organization_id and
paaf.job_id=pjv.job_id(+) and
paaf.location_id=hla.location_id(+) and
paaf.assignment_id=paa.assignment_id and
paa.payroll_action_id=ppa.payroll_action_id and
ppa.action_type in ('R','Q','B','I','V') and
ppa.action_status='C' and
ppa.time_period_id=ptp.time_period_id and
ppa.payroll_id=paypf.payroll_id and
ptp.start_date between paypf.effective_start_date and paypf.effective_end_date and
paa.assignment_action_id=prr.assignment_action_id and
prr.run_result_id=prrv.run_result_id and
prrv.input_value_id=pivf.input_value_id and
ptp.start_date between pivf.effective_start_date and pivf.effective_end_date and
pivf.name='Pay Value' and
prr.element_type_id=petf.element_type_id and
ptp.start_date between petf.effective_start_date and petf.effective_end_date and
petf.classification_id=pec.classification_id
group by
haouv.name,
papf.employee_number,
papf.full_name,
haouv2.name,
pjv.name,
hla.location_code,
paypf.payroll_name,
ptp.period_name,
ptp.start_date,
ptp.end_date
) x
order by
x.business_group,
x.payroll_name,
x.period_start_date desc,
x.full_name