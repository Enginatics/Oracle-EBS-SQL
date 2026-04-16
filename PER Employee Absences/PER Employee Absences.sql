/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Employee Absences
-- Description: Employee absence and attendance records showing absence type, category, dates, duration in days and hours, reason, authorizing person, replacement person, and approval status. Useful for leave management, absence tracking, and compliance reporting.
-- Excel Examle Output: https://www.enginatics.com/example/per-employee-absences/
-- Library Link: https://www.enginatics.com/reports/per-employee-absences/
-- Run Report: https://demo.enginatics.com/

select
haouv.name business_group,
papf.employee_number,
papf.full_name,
haouv2.name organization,
pjv.name job,
hapft.name position,
hla.location_code location,
paat.name absence_type,
xxen_util.meaning(paat.absence_category,'ABSENCE_CATEGORY',3) absence_category,
paa.date_start absence_start_date,
paa.date_end absence_end_date,
paa.time_start,
paa.time_end,
paa.absence_days,
paa.absence_hours,
paar.name absence_reason,
paa.date_notification notification_date,
paa.date_projected_start projected_start_date,
paa.date_projected_end projected_end_date,
papf2.full_name authorizing_person,
papf3.full_name replacement_person,
xxen_util.meaning(paa.approval_status,'ABSENCE_APPROVAL_STATUS',3) approval_status,
paa.occurrence,
xxen_util.user_name(paa.created_by) created_by,
xxen_util.client_time(paa.creation_date) creation_date,
xxen_util.user_name(paa.last_updated_by) last_updated_by,
xxen_util.client_time(paa.last_update_date) last_update_date
from
hr_all_organization_units_vl haouv,
(select papf.* from per_all_people_f papf where sysdate between papf.effective_start_date and papf.effective_end_date) papf,
per_absence_attendances paa,
per_absence_attendance_types paat,
per_abs_attendance_reasons paar,
(select papf.* from per_all_people_f papf where sysdate between papf.effective_start_date and papf.effective_end_date) papf2,
(select papf.* from per_all_people_f papf where sysdate between papf.effective_start_date and papf.effective_end_date) papf3,
(select paaf.* from per_all_assignments_f paaf where sysdate between paaf.effective_start_date and paaf.effective_end_date) paaf,
hr_all_organization_units_vl haouv2,
per_jobs_vl pjv,
hr_all_positions_f_tl hapft,
hr_locations_all hla
where
1=1 and
paa.person_id=papf.person_id and
papf.business_group_id=haouv.organization_id and
paa.absence_attendance_type_id=paat.absence_attendance_type_id and
paa.abs_attendance_reason_id=paar.abs_attendance_reason_id(+) and
paa.authorising_person_id=papf2.person_id(+) and
paa.replacement_person_id=papf3.person_id(+) and
paa.person_id=paaf.person_id(+) and
paaf.primary_flag(+)='Y' and
paaf.assignment_type(+)='E' and
paaf.organization_id=haouv2.organization_id(+) and
paaf.job_id=pjv.job_id(+) and
paaf.position_id=hapft.position_id(+) and
hapft.language(+)=userenv('lang') and
paaf.location_id=hla.location_id(+)
order by
haouv.name,
papf.full_name,
paa.date_start desc