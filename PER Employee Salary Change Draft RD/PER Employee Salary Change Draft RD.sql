/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Employee Salary Change - Draft RD
-- Description: Query to get the last Salary change details for employees.

Can add:
whether to look at just the recent salary change?
or salary change history.... If yes, then the last condition in where clause to be dynamically added/removed
-- Excel Examle Output: https://www.enginatics.com/example/per-employee-salary-change-draft-rd/
-- Library Link: https://www.enginatics.com/reports/per-employee-salary-change-draft-rd/
-- Run Report: https://demo.enginatics.com/

select 
papf.person_id,
papf.employee_number,     
papf.first_name,
papf.last_name,
papf.full_name,
pbg.name business_group,
paaf.supervisor_id,
(select x.full_name from per_all_people_f x where x.person_id=paaf.supervisor_id and paaf.effective_start_date between x.effective_start_date and x.effective_end_date) supervisor_name,
fct.currency_code,
ppp_old.proposed_salary_n old_sal,
ppp_new.proposed_salary_n new_sal,
ppp_new.change_date,
pj.name Current_job,
pg.name Current_grade,
pap.name current_position
from 
per_all_people_f papf,
per_business_groups pbg,
per_all_assignments_f paaf,
per_jobs pj,
per_grades pg,
per_all_positions pap,
fnd_currencies_tl fct,
per_pay_proposals ppp_old,
per_pay_proposals ppp_new
where 
1=1 and
papf.business_group_id=pbg.business_group_id and
trunc(sysdate) between papf.effective_start_date and papf.effective_end_date and
trunc(sysdate) between paaf.effective_start_date and paaf.effective_end_date and
papf.person_id=paaf.person_id and
paaf.assignment_type='E' and
paaf.primary_flag='Y' and
paaf.job_id=pj.job_id(+) and
paaf.grade_id=pg.grade_id(+) and
paaf.position_id=pap.position_id(+) and
paaf.assignment_id=ppp_old.assignment_id and
ppp_new.assignment_id=paaf.assignment_id and
per_saladmin_utility.get_currency (ppp_old.assignment_id,ppp_old.change_date)=fct.name and
fct.language=userenv('LANG') and
ppp_new.last_change_date=ppp_old.change_date and
ppp_new.change_date=(select max(x.change_date) from per_pay_proposals x where x.assignment_id=paaf.assignment_id)