/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PAY Employee Salary
-- Excel Examle Output: https://www.enginatics.com/example/pay-employee-salary/
-- Library Link: https://www.enginatics.com/reports/pay-employee-salary/
-- Run Report: https://demo.enginatics.com/

select
haouv0.name business_group,
ppf.employee_number, 
ppf.full_name employee_name,
ppp.change_date date_From,
nvl(ppp.proposed_salary_n,0)-(lag(ppp.proposed_salary_n) over (order by ppp.change_date)) change_amount,
round(((nvl(ppp.proposed_salary_n,0)-(lag(ppp.proposed_salary_n) over (order by ppp.change_date)))/ppp.proposed_salary_n)*100,2) change_percentage,
ppp.proposed_salary_n salary,
(ppp.proposed_salary_n*ppb.pay_annualization_factor) Annualized_Salary,
pet.input_currency_code currency,
ppb.name salary_basis,
ppp.approved status, 
ppp.pay_proposal_id
from
hr_all_organization_units_vl haouv0,
per_pay_proposals ppp,
per_performance_reviews ppr,
per_all_assignments_f paa,
per_all_people_f ppf,
per_pay_bases ppb,
pay_input_values_f piv,
pay_element_types_f pet
where
1=1 and
haouv0.organization_id=paa.business_group_id and
ppp.performance_review_id=ppr.performance_review_id(+) and
paa.assignment_id=ppp.assignment_id and
paa.person_id=ppf.person_id and
ppp.change_date between paa.effective_start_date and paa.effective_end_date and
paa.pay_basis_id=ppb.pay_basis_id(+) and
ppb.input_value_id=piv.input_value_id and
piv.element_type_id=pet.element_type_id and
ppp.change_date between piv.effective_start_date and piv.effective_end_date and
ppp.change_date between pet.effective_start_date and pet.effective_end_date
--AND PPF.EMPLOYEE_NUMBER='30987'
--AND PAA.ASSIGNMENT_NUMBER  ='471-96-6472'
group by
haouv0.name,
ppf.employee_number,
ppf.full_name,
ppp.change_date,
ppp.date_to,
nvl(ppp.proposed_salary_n, 0),
ppp.proposed_salary_n,
ppp.change_date,
NVL (ppp.proposed_salary_n, 0),
ppp.proposed_salary_n,
(ppp.proposed_salary_n * ppb.pay_annualization_factor),
ppp.change_date,
pet.input_currency_code,
ppb.name,
ppp.approved,
ppp.pay_proposal_id
order by change_date desc