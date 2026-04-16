/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Headcount by Organization
-- Description: Active employee and contingent worker headcount summarized by business group, organization, location, job, grade, and employment category. Includes gender breakdown and average service years and age. Use Excel pivot tables for flexible grouping and analysis.
-- Excel Examle Output: https://www.enginatics.com/example/per-headcount-by-organization/
-- Library Link: https://www.enginatics.com/reports/per-headcount-by-organization/
-- Run Report: https://demo.enginatics.com/

select
haouv.name business_group,
haouv2.name organization,
hla.location_code location,
hla.country,
pjv.name job,
pgv.name grade,
xxen_util.meaning(paaf.employment_category,'EMP_CAT',3) employment_category,
pptv.user_person_type person_type,
count(*) headcount,
sum(case when papf.sex='M' then 1 else 0 end) male_count,
sum(case when papf.sex='F' then 1 else 0 end) female_count,
round(avg(months_between(coalesce(:effective_date,sysdate),papf.original_date_of_hire)/12),1) avg_service_years,
round(avg(months_between(coalesce(:effective_date,sysdate),papf.date_of_birth)/12),1) avg_age
from
hr_all_organization_units_vl haouv,
(select papf.* from per_all_people_f papf where coalesce(:effective_date,sysdate) between papf.effective_start_date and papf.effective_end_date) papf,
per_person_types_v pptv,
(select paaf.* from per_all_assignments_f paaf where coalesce(:effective_date,sysdate) between paaf.effective_start_date and paaf.effective_end_date) paaf,
per_assignment_status_types past,
hr_all_organization_units_vl haouv2,
per_jobs_vl pjv,
per_grades_vl pgv,
hr_locations_all hla
where
1=1 and
papf.business_group_id=haouv.organization_id and
papf.person_id=paaf.person_id and
papf.person_type_id=pptv.person_type_id and
paaf.assignment_status_type_id=past.assignment_status_type_id and
past.per_system_status='ACTIVE_ASSIGN' and
paaf.primary_flag='Y' and
paaf.assignment_type in ('E','C') and
paaf.organization_id=haouv2.organization_id and
paaf.job_id=pjv.job_id(+) and
paaf.grade_id=pgv.grade_id(+) and
paaf.location_id=hla.location_id(+)
group by
haouv.name,
haouv2.name,
hla.location_code,
hla.country,
pjv.name,
pgv.name,
xxen_util.meaning(paaf.employment_category,'EMP_CAT',3),
pptv.user_person_type
order by
haouv.name,
haouv2.name,
hla.location_code,
pjv.name,
pgv.name