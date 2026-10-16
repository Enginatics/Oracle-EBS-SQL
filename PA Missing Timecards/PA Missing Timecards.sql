/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Missing Timecards
-- Description: Active employees who have not submitted timecards for a given week ending date, showing employee details, job, organization, and supervisor.
-- Timecard Source Project Expenditures lists employees without a project expenditure for the week ending date. OTL Timecards lists employees without an OTL timecard whose period contains the week ending date, including employees who do not charge projects.
-- Excel Example Output: https://www.enginatics.com/example/pa-missing-timecards/
-- Library Link: https://www.enginatics.com/reports/pa-missing-timecards/
-- Run Report: https://demo.enginatics.com/

select
haouv.name business_group,
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
(
:timecard_source='OTL' or
not exists (
select null
from pa_expenditures_all pea
where
pea.incurred_by_person_id=ppx.person_id and
pea.expenditure_ending_date=:week_ending_date
)
) and
(
nvl(:timecard_source,'PA')='PA' or
ppx.person_id not in (
select
hts.resource_id
from
hxc_timecard_summary hts
where
:week_ending_date between trunc(hts.start_time) and trunc(hts.stop_time)
)
)
order by
haouv.name,
haouv2.name,
ppx.full_name
