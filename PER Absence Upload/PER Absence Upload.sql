/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Absence Upload
-- Description: Upload to create, update and delete person absences as in the Absence Detail window: absence type and reason, notification, projected and actual dates and times, duration, late notification, authorizer and replacement, and the Additional Absence Details flexfield.
-- A row is matched to an existing absence by the hidden absence id of a downloaded row, otherwise by employee, absence type and start date (actual, or projected when there is no actual start). Absences are created and updated with hrpersonabsenceapi, which also maintains the element entry of absence types linked to an element. Durations left blank are calculated by the api.
-- Set Delete Absence to Yes to delete a downloaded absence.
-- Excel Example Output: https://www.enginatics.com/example/per-absence-upload/
-- Library Link: https://www.enginatics.com/reports/per-absence-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
to_number(null) absence_id_out,
paa.absence_attendance_id absence_id,
pbg.name business_group,
papf.employee_number,
papf.full_name,
paatv.name absence_type,
xxen_util.meaning(paatv.absence_category,'ABSENCE_CATEGORY',3) category,
(select xxen_util.meaning(paar.name,'ABSENCE_REASON',3) from per_abs_attendance_reasons paar where paa.abs_attendance_reason_id=paar.abs_attendance_reason_id) reason,
paa.occurrence,
paa.date_notification notified,
paa.date_projected_start projected_start,
paa.time_projected_start projected_start_time,
paa.date_projected_end projected_end,
paa.time_projected_end projected_end_time,
paa.date_start actual_start,
paa.time_start actual_start_time,
paa.date_end actual_end,
paa.time_end actual_end_time,
paa.absence_days duration_days,
paa.absence_hours duration_hours,
paa.reason_for_notification_delay reason_for_late_notification,
xxen_util.yes(paa.accept_late_notification_flag) accept_late_notification,
(select papf2.employee_number from per_all_people_f papf2 where paa.authorising_person_id=papf2.person_id and coalesce(paa.date_start,paa.date_projected_start,trunc(sysdate)) between papf2.effective_start_date and papf2.effective_end_date) authorized_by_number,
(select papf2.full_name from per_all_people_f papf2 where paa.authorising_person_id=papf2.person_id and coalesce(paa.date_start,paa.date_projected_start,trunc(sysdate)) between papf2.effective_start_date and papf2.effective_end_date) authorized_by_name,
(select papf2.employee_number from per_all_people_f papf2 where paa.replacement_person_id=papf2.person_id and coalesce(paa.date_start,paa.date_projected_start,trunc(sysdate)) between papf2.effective_start_date and papf2.effective_end_date) replaced_by_number,
(select papf2.full_name from per_all_people_f papf2 where paa.replacement_person_id=papf2.person_id and coalesce(paa.date_start,paa.date_projected_start,trunc(sysdate)) between papf2.effective_start_date and papf2.effective_end_date) replaced_by_name,
null delete_absence,
xxen_util.display_flexfield_context(800,'PER_ABSENCE_ATTENDANCES',paa.attribute_category) abs_attribute_category,
xxen_util.display_flexfield_value(800,'PER_ABSENCE_ATTENDANCES',paa.attribute_category,'ATTRIBUTE1',paa.rowid,paa.attribute1) abs_attribute1,
xxen_util.display_flexfield_value(800,'PER_ABSENCE_ATTENDANCES',paa.attribute_category,'ATTRIBUTE2',paa.rowid,paa.attribute2) abs_attribute2,
xxen_util.display_flexfield_value(800,'PER_ABSENCE_ATTENDANCES',paa.attribute_category,'ATTRIBUTE3',paa.rowid,paa.attribute3) abs_attribute3,
xxen_util.display_flexfield_value(800,'PER_ABSENCE_ATTENDANCES',paa.attribute_category,'ATTRIBUTE4',paa.rowid,paa.attribute4) abs_attribute4,
xxen_util.display_flexfield_value(800,'PER_ABSENCE_ATTENDANCES',paa.attribute_category,'ATTRIBUTE5',paa.rowid,paa.attribute5) abs_attribute5,
xxen_util.display_flexfield_value(800,'PER_ABSENCE_ATTENDANCES',paa.attribute_category,'ATTRIBUTE6',paa.rowid,paa.attribute6) abs_attribute6,
xxen_util.display_flexfield_value(800,'PER_ABSENCE_ATTENDANCES',paa.attribute_category,'ATTRIBUTE7',paa.rowid,paa.attribute7) abs_attribute7,
xxen_util.display_flexfield_value(800,'PER_ABSENCE_ATTENDANCES',paa.attribute_category,'ATTRIBUTE8',paa.rowid,paa.attribute8) abs_attribute8,
xxen_util.display_flexfield_value(800,'PER_ABSENCE_ATTENDANCES',paa.attribute_category,'ATTRIBUTE9',paa.rowid,paa.attribute9) abs_attribute9,
xxen_util.display_flexfield_value(800,'PER_ABSENCE_ATTENDANCES',paa.attribute_category,'ATTRIBUTE10',paa.rowid,paa.attribute10) abs_attribute10,
xxen_util.display_flexfield_value(800,'PER_ABSENCE_ATTENDANCES',paa.attribute_category,'ATTRIBUTE11',paa.rowid,paa.attribute11) abs_attribute11,
xxen_util.display_flexfield_value(800,'PER_ABSENCE_ATTENDANCES',paa.attribute_category,'ATTRIBUTE12',paa.rowid,paa.attribute12) abs_attribute12,
xxen_util.display_flexfield_value(800,'PER_ABSENCE_ATTENDANCES',paa.attribute_category,'ATTRIBUTE13',paa.rowid,paa.attribute13) abs_attribute13,
xxen_util.display_flexfield_value(800,'PER_ABSENCE_ATTENDANCES',paa.attribute_category,'ATTRIBUTE14',paa.rowid,paa.attribute14) abs_attribute14,
xxen_util.display_flexfield_value(800,'PER_ABSENCE_ATTENDANCES',paa.attribute_category,'ATTRIBUTE15',paa.rowid,paa.attribute15) abs_attribute15,
xxen_util.display_flexfield_value(800,'PER_ABSENCE_ATTENDANCES',paa.attribute_category,'ATTRIBUTE16',paa.rowid,paa.attribute16) abs_attribute16,
xxen_util.display_flexfield_value(800,'PER_ABSENCE_ATTENDANCES',paa.attribute_category,'ATTRIBUTE17',paa.rowid,paa.attribute17) abs_attribute17,
xxen_util.display_flexfield_value(800,'PER_ABSENCE_ATTENDANCES',paa.attribute_category,'ATTRIBUTE18',paa.rowid,paa.attribute18) abs_attribute18,
xxen_util.display_flexfield_value(800,'PER_ABSENCE_ATTENDANCES',paa.attribute_category,'ATTRIBUTE19',paa.rowid,paa.attribute19) abs_attribute19,
xxen_util.display_flexfield_value(800,'PER_ABSENCE_ATTENDANCES',paa.attribute_category,'ATTRIBUTE20',paa.rowid,paa.attribute20) abs_attribute20,
0 upload_row
from
per_business_groups pbg,
per_all_people_f papf,
per_absence_attendances paa,
per_abs_attendance_types_vl paatv
where
1=1 and
pbg.business_group_id=:business_group_id and
papf.business_group_id=pbg.business_group_id and
trunc(sysdate) between papf.effective_start_date and papf.effective_end_date and
papf.person_id=paa.person_id and
paa.absence_attendance_type_id=paatv.absence_attendance_type_id
