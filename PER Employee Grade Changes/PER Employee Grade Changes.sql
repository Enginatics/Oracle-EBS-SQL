/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Employee Grade Changes
-- Description: List of employees with their grade changes.
-- Excel Examle Output: https://www.enginatics.com/example/per-employee-grade-changes/
-- Library Link: https://www.enginatics.com/reports/per-employee-grade-changes/
-- Run Report: https://demo.enginatics.com/

select
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
(select pap.name from per_all_positions pap where pap.position_id=paaf_old.position_id) old_position,
(select pap.name from per_all_positions pap where pap.position_id=paaf_new.position_id) new_position,
papf.person_id,
papf.effective_start_date person_start_date,
papf.effective_end_date person_end_date
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
paaf_old.effective_end_date+1=paaf_new.effective_start_date