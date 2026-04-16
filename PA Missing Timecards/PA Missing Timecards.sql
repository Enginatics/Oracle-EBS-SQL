/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Missing Timecards
-- Description: Active employees who have not submitted timecards for a given week ending date, showing employee details, job, organization, and supervisor.
-- Excel Examle Output: https://www.enginatics.com/example/pa-missing-timecards/
-- Library Link: https://www.enginatics.com/reports/pa-missing-timecards/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
ppx.employee_number,
ppx.full_name employee_name,
(select pj.name from per_jobs pj where pj.job_id=paf.job_id) job,
haouv2.name organization,
(select ppx2.full_name from per_people_x ppx2 where ppx2.person_id=paf.supervisor_id) supervisor,
ppx.email_address
from
per_people_x ppx,
per_assignments_f paf,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv2
where
1=1 and
ppx.person_id=paf.person_id and
paf.primary_flag='Y' and
paf.assignment_type='E' and
trunc(sysdate) between paf.effective_start_date and paf.effective_end_date and
paf.business_group_id=haouv.organization_id and
paf.organization_id=haouv2.organization_id and
haouv.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
not exists (
select null
from pa_expenditures_all pea
where
pea.incurred_by_person_id=ppx.person_id and
pea.expenditure_ending_date=:week_ending_date
)
order by
haouv.name,
haouv2.name,
ppx.full_name