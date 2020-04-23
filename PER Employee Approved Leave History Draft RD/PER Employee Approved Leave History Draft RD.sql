/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Employee Approved Leave History - Draft RD
-- Excel Examle Output: https://www.enginatics.com/example/per-employee-approved-leave-history-draft-rd
-- Library Link: https://www.enginatics.com/reports/per-employee-approved-leave-history-draft-rd
-- Run Report: https://demo.enginatics.com/


select
papf.employee_number, 
papf.full_name requester_name,
pbg.name business_group,
paat.name leave_type, 
to_char(paa.date_start,'DD-Mon-RRRR') Leave_Start,
to_char(paa.date_end,'DD-Mon-RRRR') Leave_end,
paa.date_notification,
to_char(trunc(paa.creation_date),'DD-Mon-RRRR') approval_date,
to_char(trunc(psth.last_update_date),'DD-Mon-RRRR') Last_update,
papf1.full_name approver_name
from
per_all_people_f papf,
per_business_groups pbg,
per_absence_attendances paa,
per_absence_attendance_types paat,
pqh_ss_transaction_history psth,
per_all_people_f papf1,
fnd_user fu,
pqh_ss_step_history pssh
where 1=1 and 
sysdate between papf.effective_start_date and papf.effective_end_date and
papf.business_group_id=pbg.business_group_id and
papf.person_id=paa.person_id and
paa.absence_attendance_type_id=paat.absence_attendance_type_id and
paat.date_end is null and
paa.absence_attendance_id=pssh.pk1 and
pssh.transaction_history_id=psth.transaction_history_id and
psth.process_name='HR_GENERIC_APPROVAL_PRC' and
fu.user_id=paa.created_by and
fu.employee_id=papf1.person_id and
trunc(sysdate) between papf1.effective_start_date and papf1.effective_end_date
order by 1,2,3,5