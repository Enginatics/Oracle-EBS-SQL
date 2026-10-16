/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Person Assignment Upload
-- Description: Upload to create and update employee assignments as in the Assignment window of the People form: organization, job, position, grade, payroll, location, status, categories, supervisor, probation and notice periods, standard conditions, statutory information, salary basis, people group and the Additional Assignment Details flexfield.
-- Changes are made as of the Effective Date. When Datetrack Mode is blank, the assignment is corrected if the Effective Date is its start date, and otherwise a change is inserted from the Effective Date (Update, or Update - Insert when later changes exist).
-- A new row without an existing Assignment Number creates a secondary assignment with hrassignmentapi.createsecondaryempasg. The primary assignment is created when the person is hired with the PER Person Upload.
-- A Status of another system status suspends, reactivates or terminates the assignment. People Group and Statutory Information take the concatenated segment values and create new combinations as needed.
-- Excel Example Output: https://www.enginatics.com/example/per-person-assignment-upload/
-- Library Link: https://www.enginatics.com/reports/per-person-assignment-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
to_number(null) assignment_id_out,
paaf.assignment_id,
pbg.name business_group,
papf.employee_number,
papf.full_name,
paaf.assignment_number,
xxen_util.yes(paaf.primary_flag) primary_assignment,
:effective_date effective_date,
null datetrack_mode,
(select haouv.name from hr_all_organization_units_vl haouv where paaf.organization_id=haouv.organization_id) organization,
(select ppg.group_name from pay_people_groups ppg where paaf.people_group_id=ppg.people_group_id) people_group,
(select pjv.name from per_jobs_vl pjv where paaf.job_id=pjv.job_id) job,
(select hpf.name from hr_positions_f hpf where paaf.position_id=hpf.position_id and :effective_date between hpf.effective_start_date and hpf.effective_end_date) position,
(select pgv.name from per_grades_vl pgv where paaf.grade_id=pgv.grade_id) grade,
(select papf2.payroll_name from pay_all_payrolls_f papf2 where paaf.payroll_id=papf2.payroll_id and :effective_date between papf2.effective_start_date and papf2.effective_end_date) payroll,
(select hlav.location_code from hr_locations_all_vl hlav where paaf.location_id=hlav.location_id) location,
(select pastv.user_status from per_assignment_status_types_v pastv where paaf.assignment_status_type_id=pastv.assignment_status_type_id) assignment_status,
xxen_util.meaning(paaf.employment_category,'EMP_CAT',3) assignment_category,
xxen_util.meaning(paaf.employee_category,'EMPLOYEE_CATG',3) employee_category,
(select papf3.employee_number from per_all_people_f papf3 where paaf.supervisor_id=papf3.person_id and :effective_date between papf3.effective_start_date and papf3.effective_end_date) supervisor_number,
(select papf3.full_name from per_all_people_f papf3 where paaf.supervisor_id=papf3.person_id and :effective_date between papf3.effective_start_date and papf3.effective_end_date) supervisor_name,
paaf.probation_period,
xxen_util.meaning(paaf.probation_unit,'QUALIFYING_UNITS',3) probation_units,
paaf.date_probation_end probation_end_date,
paaf.notice_period,
xxen_util.meaning(paaf.notice_period_uom,'QUALIFYING_UNITS',3) notice_period_units,
paaf.normal_hours working_hours,
xxen_util.meaning(paaf.frequency,'FREQUENCY',3) frequency,
paaf.time_normal_start start_time,
paaf.time_normal_finish end_time,
xxen_util.meaning(paaf.hourly_salaried_code,'HOURLY_SALARIED_CODE',3) hourly_salaried,
xxen_util.yes(paaf.work_at_home) working_at_home,
(select hsck.concatenated_segments from hr_soft_coding_keyflex hsck where paaf.soft_coding_keyflex_id=hsck.soft_coding_keyflex_id) statutory_information,
(select ppb.name from per_pay_bases ppb where paaf.pay_basis_id=ppb.pay_basis_id) salary_basis,
paaf.internal_address_line internal_address,
xxen_util.meaning(paaf.change_reason,'EMP_ASSIGN_REASON',3) change_reason,
xxen_util.yes(paaf.manager_flag) manager,
xxen_util.meaning(paaf.bargaining_unit_code,'BARGAINING_UNIT_CODE',3) bargaining_unit,
xxen_util.yes(paaf.labour_union_member_flag) union_member,
xxen_util.display_flexfield_context(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category) ass_attribute_category,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE1',paaf.rowid,paaf.ass_attribute1) ass_attribute1,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE2',paaf.rowid,paaf.ass_attribute2) ass_attribute2,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE3',paaf.rowid,paaf.ass_attribute3) ass_attribute3,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE4',paaf.rowid,paaf.ass_attribute4) ass_attribute4,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE5',paaf.rowid,paaf.ass_attribute5) ass_attribute5,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE6',paaf.rowid,paaf.ass_attribute6) ass_attribute6,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE7',paaf.rowid,paaf.ass_attribute7) ass_attribute7,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE8',paaf.rowid,paaf.ass_attribute8) ass_attribute8,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE9',paaf.rowid,paaf.ass_attribute9) ass_attribute9,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE10',paaf.rowid,paaf.ass_attribute10) ass_attribute10,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE11',paaf.rowid,paaf.ass_attribute11) ass_attribute11,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE12',paaf.rowid,paaf.ass_attribute12) ass_attribute12,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE13',paaf.rowid,paaf.ass_attribute13) ass_attribute13,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE14',paaf.rowid,paaf.ass_attribute14) ass_attribute14,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE15',paaf.rowid,paaf.ass_attribute15) ass_attribute15,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE16',paaf.rowid,paaf.ass_attribute16) ass_attribute16,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE17',paaf.rowid,paaf.ass_attribute17) ass_attribute17,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE18',paaf.rowid,paaf.ass_attribute18) ass_attribute18,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE19',paaf.rowid,paaf.ass_attribute19) ass_attribute19,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE20',paaf.rowid,paaf.ass_attribute20) ass_attribute20,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE21',paaf.rowid,paaf.ass_attribute21) ass_attribute21,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE22',paaf.rowid,paaf.ass_attribute22) ass_attribute22,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE23',paaf.rowid,paaf.ass_attribute23) ass_attribute23,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE24',paaf.rowid,paaf.ass_attribute24) ass_attribute24,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE25',paaf.rowid,paaf.ass_attribute25) ass_attribute25,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE26',paaf.rowid,paaf.ass_attribute26) ass_attribute26,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE27',paaf.rowid,paaf.ass_attribute27) ass_attribute27,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE28',paaf.rowid,paaf.ass_attribute28) ass_attribute28,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE29',paaf.rowid,paaf.ass_attribute29) ass_attribute29,
xxen_util.display_flexfield_value(800,'PER_ASSIGNMENTS',paaf.ass_attribute_category,'ASS_ATTRIBUTE30',paaf.rowid,paaf.ass_attribute30) ass_attribute30,
0 upload_row
from
per_business_groups pbg,
per_all_people_f papf,
per_all_assignments_f paaf
where
1=1 and
pbg.business_group_id=:business_group_id and
papf.business_group_id=pbg.business_group_id and
:effective_date between papf.effective_start_date and papf.effective_end_date and
papf.current_employee_flag='Y' and
papf.person_id=paaf.person_id and
paaf.assignment_type='E' and
:effective_date between paaf.effective_start_date and paaf.effective_end_date
