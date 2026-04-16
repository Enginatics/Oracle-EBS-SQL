/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Terminations and Separations
-- Description: Terminated employees within a specified date range, showing termination date, leaving reason, length of service, last organization, job, position, grade, and supervisor. Useful for turnover analysis and exit tracking.
-- Excel Examle Output: https://www.enginatics.com/example/per-terminations-and-separations/
-- Library Link: https://www.enginatics.com/reports/per-terminations-and-separations/
-- Run Report: https://demo.enginatics.com/

select
haouv.name business_group,
papf.employee_number,
papf.full_name,
papf.email_address,
xxen_util.meaning(papf.sex,'SEX',3) gender,
papf.original_date_of_hire hire_date,
ppos.actual_termination_date termination_date,
ppos.final_process_date,
ppos.last_standard_process_date,
ppos.notified_termination_date,
xxen_util.meaning(ppos.leaving_reason,'LEAV_REAS',3) leaving_reason,
trunc(months_between(ppos.actual_termination_date,papf.original_date_of_hire)/12) service_years,
mod(trunc(months_between(ppos.actual_termination_date,papf.original_date_of_hire)),12) service_months,
haouv2.name organization,
pjv.name job,
hapft.name position,
pgv.name grade,
hla.location_code location,
papf2.full_name supervisor_name,
xxen_util.meaning(paaf.employment_category,'EMP_CAT',3) employment_category,
paypf.payroll_name,
ppos.accepted_termination_date,
ppos.projected_termination_date,
xxen_util.user_name(ppos.last_updated_by) last_updated_by,
xxen_util.client_time(ppos.last_update_date) last_update_date
from
hr_all_organization_units_vl haouv,
per_all_people_f papf,
per_periods_of_service ppos,
per_all_assignments_f paaf,
(select papf.* from per_all_people_f papf where sysdate between papf.effective_start_date and papf.effective_end_date) papf2,
hr_all_organization_units_vl haouv2,
per_jobs_vl pjv,
hr_all_positions_f_tl hapft,
per_grades_vl pgv,
hr_locations_all hla,
(select paypf.* from pay_all_payrolls_f paypf where sysdate between paypf.effective_start_date and paypf.effective_end_date) paypf
where
1=1 and
ppos.actual_termination_date is not null and
ppos.person_id=papf.person_id and
ppos.actual_termination_date between papf.effective_start_date and papf.effective_end_date and
papf.business_group_id=haouv.organization_id and
ppos.person_id=paaf.person_id and
ppos.actual_termination_date between paaf.effective_start_date and paaf.effective_end_date and
paaf.primary_flag='Y' and
paaf.assignment_type='E' and
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
ppos.actual_termination_date desc,
papf.full_name