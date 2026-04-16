/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER New Hires
-- Description: Employees hired within a specified date range, showing hire date, organization, job, position, grade, location, supervisor, employment category, and probation details. Useful for onboarding tracking and new hire analysis.
-- Excel Examle Output: https://www.enginatics.com/example/per-new-hires/
-- Library Link: https://www.enginatics.com/reports/per-new-hires/
-- Run Report: https://demo.enginatics.com/

select
haouv.name business_group,
papf.employee_number,
papf.full_name,
papf.email_address,
xxen_util.meaning(papf.sex,'SEX',3) gender,
pptv.user_person_type person_type,
papf.original_date_of_hire hire_date,
ppos.date_start service_start_date,
ppos.adjusted_svc_date adjusted_service_date,
haouv2.name organization,
pjv.name job,
hapft.name position,
pgv.name grade,
hla.location_code location,
pastv.user_status assignment_status,
papf2.full_name supervisor_name,
xxen_util.meaning(paaf.employment_category,'EMP_CAT',3) employment_category,
paypf.payroll_name,
paaf.normal_hours,
xxen_util.meaning(paaf.frequency,'FREQUENCY',3) frequency,
paaf.probation_period,
xxen_util.meaning(paaf.probation_unit,'QUALIFYING_UNITS',3) probation_uom,
paaf.date_probation_end,
xxen_util.user_name(papf.created_by) created_by,
xxen_util.client_time(papf.creation_date) creation_date
from
hr_all_organization_units_vl haouv,
(select papf.* from per_all_people_f papf where sysdate between papf.effective_start_date and papf.effective_end_date) papf,
per_person_types_v pptv,
per_periods_of_service ppos,
(select paaf.* from per_all_assignments_f paaf where sysdate between paaf.effective_start_date and paaf.effective_end_date) paaf,
per_assignment_status_types_v pastv,
(select papf.* from per_all_people_f papf where sysdate between papf.effective_start_date and papf.effective_end_date) papf2,
hr_all_organization_units_vl haouv2,
per_jobs_vl pjv,
hr_all_positions_f_tl hapft,
per_grades_vl pgv,
hr_locations_all hla,
(select paypf.* from pay_all_payrolls_f paypf where sysdate between paypf.effective_start_date and paypf.effective_end_date) paypf
where
1=1 and
papf.business_group_id=haouv.organization_id and
papf.person_type_id=pptv.person_type_id and
pptv.system_person_type in ('EMP','EMP_APL') and
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
paaf.location_id=hla.location_id(+) and
paaf.payroll_id=paypf.payroll_id(+)
order by
haouv.name,
papf.original_date_of_hire desc,
papf.full_name