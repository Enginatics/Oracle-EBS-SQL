/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Employee Length of Service
-- Description: Active employees with calculated length of service in years and months, based on the adjusted service date (or hire date if not set). Shows milestone years (multiples of 5), next service anniversary, age, and current assignment details. Useful for recognition programs, benefits eligibility, and workforce tenure analysis.
-- Excel Examle Output: https://www.enginatics.com/example/per-employee-length-of-service/
-- Library Link: https://www.enginatics.com/reports/per-employee-length-of-service/
-- Run Report: https://demo.enginatics.com/

select
haouv.name business_group,
papf.employee_number,
papf.full_name,
papf.email_address,
xxen_util.meaning(papf.sex,'SEX',3) gender,
papf.date_of_birth,
trunc(months_between(sysdate,papf.date_of_birth)/12) age,
papf.original_date_of_hire hire_date,
ppos.adjusted_svc_date adjusted_service_date,
trunc(months_between(sysdate,nvl(ppos.adjusted_svc_date,papf.original_date_of_hire))/12) service_years,
mod(trunc(months_between(sysdate,nvl(ppos.adjusted_svc_date,papf.original_date_of_hire))),12) service_months,
case
when mod(trunc(months_between(sysdate,nvl(ppos.adjusted_svc_date,papf.original_date_of_hire))/12),5)=0
and trunc(months_between(sysdate,nvl(ppos.adjusted_svc_date,papf.original_date_of_hire))/12)>0
then trunc(months_between(sysdate,nvl(ppos.adjusted_svc_date,papf.original_date_of_hire))/12)
end milestone_years,
add_months(nvl(ppos.adjusted_svc_date,papf.original_date_of_hire),
ceil(months_between(sysdate,nvl(ppos.adjusted_svc_date,papf.original_date_of_hire))/12)*12) next_anniversary,
haouv2.name organization,
pjv.name job,
hapft.name position,
pgv.name grade,
hla.location_code location,
papf2.full_name supervisor_name,
xxen_util.meaning(paaf.employment_category,'EMP_CAT',3) employment_category,
pastv.user_status assignment_status
from
hr_all_organization_units_vl haouv,
(select papf.* from per_all_people_f papf where sysdate between papf.effective_start_date and papf.effective_end_date) papf,
per_periods_of_service ppos,
(select paaf.* from per_all_assignments_f paaf where sysdate between paaf.effective_start_date and paaf.effective_end_date) paaf,
per_assignment_status_types_v pastv,
(select papf.* from per_all_people_f papf where sysdate between papf.effective_start_date and papf.effective_end_date) papf2,
hr_all_organization_units_vl haouv2,
per_jobs_vl pjv,
hr_all_positions_f_tl hapft,
per_grades_vl pgv,
hr_locations_all hla
where
1=1 and
papf.business_group_id=haouv.organization_id and
papf.person_id=ppos.person_id and
ppos.actual_termination_date is null and
papf.person_id=paaf.person_id and
paaf.primary_flag='Y' and
paaf.assignment_type='E' and
paaf.assignment_status_type_id=pastv.assignment_status_type_id and
paaf.supervisor_id=papf2.person_id(+) and
paaf.organization_id=haouv2.organization_id and
paaf.job_id=pjv.job_id(+) and
paaf.position_id=hapft.position_id(+) and
hapft.language(+)=userenv('lang') and
paaf.grade_id=pgv.grade_id(+) and
paaf.location_id=hla.location_id(+)
order by
haouv.name,
trunc(months_between(sysdate,nvl(ppos.adjusted_svc_date,papf.original_date_of_hire))/12) desc,
papf.full_name