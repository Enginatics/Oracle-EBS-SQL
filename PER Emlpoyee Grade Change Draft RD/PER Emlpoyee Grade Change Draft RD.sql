/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Emlpoyee Grade Change - Draft RD
-- Description: Query to get the list of employees with their grade changes.

Like to add the ability to show:
1. All or only active employees
2. All or only active assignments
-- Excel Examle Output: https://www.enginatics.com/example/per-emlpoyee-grade-change-draft-rd
-- Library Link: https://www.enginatics.com/reports/per-emlpoyee-grade-change-draft-rd
-- Run Report: https://demo.enginatics.com/


select 
papf.person_id,
papf.employee_number,
papf.first_name,
papf.last_name,
papf.full_name,
papf.email_address,
pbg.name business_group,
paaf_new.effective_start_date change_date,
pg_old.name old_grade, 
pg_new.name new_grade,
pj_old.name old_job,
pj_new.name new_job,
(select pap.name from per_all_positions pap where pap.position_id=paaf_old.position_id) Old_Position,
(select pap.name from per_all_positions pap where pap.position_id=paaf_new.position_id) New_Position
from 
per_all_people_f papf,
per_business_groups pbg,
per_all_assignments_f paaf_old,
per_all_assignments_f paaf_new,
per_grades pg_old,
per_grades pg_new,
per_jobs pj_old,
per_jobs pj_new
where 
1=1 and 
papf.person_id=paaf_old.person_id and
papf.person_id=paaf_new.person_id and
papf.business_group_id=pbg.business_group_id and
paaf_old.person_id=paaf_new.person_id and
paaf_old.assignment_type='E' and 
paaf_old.primary_flag='Y' and
paaf_new.assignment_type='E' and
paaf_new.primary_flag='Y' and
paaf_old.grade_id=pg_old.grade_id and 
paaf_new.grade_id=pg_new.grade_id and
paaf_old.grade_id<>paaf_new.grade_id and 
paaf_old.job_id=pj_old.job_id(+) and 
paaf_new.job_id=pj_new.job_id(+) and
paaf_old.effective_end_date+1=paaf_new.effective_start_date and
trunc(sysdate) between papf.effective_start_date and papf.effective_end_date and
trunc(sysdate) between paaf_new.effective_start_date and paaf_new.effective_end_date