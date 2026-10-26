/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Position Upload
-- Description: Upload to create and update positions as in the Position window (Define Position): name, type, organization, job, hiring status, location, FTE and headcount, hiring information, work terms, supervisor, relief and successor positions and the Additional Position Details flexfield.
-- Positions are date tracked. Changes are made as of the Effective Date: when Datetrack Mode is blank, the position is corrected if the Effective Date is the start date of its current record, and otherwise a change is inserted from the Effective Date.
-- A row whose Name does not exist in the business group creates the position with hrpositionapi.createposition. Name is the concatenated Position flexfield segments; changing it on a downloaded row renames the position. Organization and job cannot be changed once the position exists.
-- Excel Example Output: https://www.enginatics.com/example/per-position-upload/
-- Library Link: https://www.enginatics.com/reports/per-position-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
to_number(null) position_id_out,
hapf.position_id,
pbg.name business_group,
:effective_date effective_date,
null datetrack_mode,
hapft.name,
hapf.date_effective start_date,
xxen_util.meaning(hapf.position_type,'POSITION_TYPE',3) position_type,
xxen_util.yes(hapf.permanent_temporary_flag) permanent,
xxen_util.yes(hapf.seasonal_flag) seasonal,
(select haouv.name from hr_all_organization_units_vl haouv where hapf.organization_id=haouv.organization_id) organization,
(select pjv.name from per_jobs_vl pjv where hapf.job_id=pjv.job_id) job,
(select pstv.shared_type_name from per_shared_types_vl pstv where hapf.availability_status_id=pstv.shared_type_id) hiring_status,
(select hlav.location_code from hr_locations_all_vl hlav where hapf.location_id=hlav.location_id) location,
hapf.fte,
hapf.max_persons headcount,
xxen_util.meaning(hapf.bargaining_unit_cd,'BARGAINING_UNIT_CODE',3) bargaining_unit,
hapf.earliest_hire_date,
hapf.fill_by_date,
xxen_util.yes(hapf.permit_recruitment_flag) permit_recruiting,
(select papf2.payroll_name from pay_all_payrolls_f papf2 where hapf.pay_freq_payroll_id=papf2.payroll_id and :effective_date between papf2.effective_start_date and papf2.effective_end_date) payroll,
(select ppb.name from per_pay_bases ppb where hapf.pay_basis_id=ppb.pay_basis_id) salary_basis,
(select pgv.name from per_grades_vl pgv where hapf.entry_grade_id=pgv.grade_id) entry_grade,
hapf.probation_period probation_duration,
xxen_util.meaning(hapf.probation_period_unit_cd,'FREQUENCY',3) probation_units,
hapf.overlap_period overlap_duration,
xxen_util.meaning(hapf.overlap_unit_cd,'FREQUENCY',3) overlap_units,
hapf.working_hours,
xxen_util.meaning(hapf.frequency,'FREQUENCY',3) frequency,
hapf.time_normal_start start_time,
hapf.time_normal_finish end_time,
(select papf.employee_number from per_all_people_f papf where hapf.supervisor_id=papf.person_id and :effective_date between papf.effective_start_date and papf.effective_end_date) supervisor_number,
(select papf.full_name from per_all_people_f papf where hapf.supervisor_id=papf.person_id and :effective_date between papf.effective_start_date and papf.effective_end_date) supervisor_name,
xxen_util.yes(hapf.replacement_required_flag) replacement_required,
(select hapft2.name from hr_all_positions_f_tl hapft2 where hapf.supervisor_position_id=hapft2.position_id and hapft2.language=userenv('lang')) supervisor_position,
(select hapft2.name from hr_all_positions_f_tl hapft2 where hapf.relief_position_id=hapft2.position_id and hapft2.language=userenv('lang')) relief_position,
(select hapft2.name from hr_all_positions_f_tl hapft2 where hapf.successor_position_id=hapft2.position_id and hapft2.language=userenv('lang')) successor_position,
xxen_util.display_flexfield_context(800,'PER_POSITIONS',hapf.attribute_category) pos_attribute_category,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE1',hapf.rowid,hapf.attribute1) pos_attribute1,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE2',hapf.rowid,hapf.attribute2) pos_attribute2,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE3',hapf.rowid,hapf.attribute3) pos_attribute3,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE4',hapf.rowid,hapf.attribute4) pos_attribute4,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE5',hapf.rowid,hapf.attribute5) pos_attribute5,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE6',hapf.rowid,hapf.attribute6) pos_attribute6,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE7',hapf.rowid,hapf.attribute7) pos_attribute7,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE8',hapf.rowid,hapf.attribute8) pos_attribute8,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE9',hapf.rowid,hapf.attribute9) pos_attribute9,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE10',hapf.rowid,hapf.attribute10) pos_attribute10,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE11',hapf.rowid,hapf.attribute11) pos_attribute11,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE12',hapf.rowid,hapf.attribute12) pos_attribute12,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE13',hapf.rowid,hapf.attribute13) pos_attribute13,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE14',hapf.rowid,hapf.attribute14) pos_attribute14,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE15',hapf.rowid,hapf.attribute15) pos_attribute15,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE16',hapf.rowid,hapf.attribute16) pos_attribute16,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE17',hapf.rowid,hapf.attribute17) pos_attribute17,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE18',hapf.rowid,hapf.attribute18) pos_attribute18,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE19',hapf.rowid,hapf.attribute19) pos_attribute19,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE20',hapf.rowid,hapf.attribute20) pos_attribute20,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE21',hapf.rowid,hapf.attribute21) pos_attribute21,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE22',hapf.rowid,hapf.attribute22) pos_attribute22,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE23',hapf.rowid,hapf.attribute23) pos_attribute23,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE24',hapf.rowid,hapf.attribute24) pos_attribute24,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE25',hapf.rowid,hapf.attribute25) pos_attribute25,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE26',hapf.rowid,hapf.attribute26) pos_attribute26,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE27',hapf.rowid,hapf.attribute27) pos_attribute27,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE28',hapf.rowid,hapf.attribute28) pos_attribute28,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE29',hapf.rowid,hapf.attribute29) pos_attribute29,
xxen_util.display_flexfield_value(800,'PER_POSITIONS',hapf.attribute_category,'ATTRIBUTE30',hapf.rowid,hapf.attribute30) pos_attribute30,
0 upload_row
from
per_business_groups pbg,
hr_all_positions_f hapf,
hr_all_positions_f_tl hapft
where
1=1 and
pbg.business_group_id=:business_group_id and
hapf.business_group_id=pbg.business_group_id and
:effective_date between hapf.effective_start_date and hapf.effective_end_date and
hapf.position_id=hapft.position_id and
hapft.language=userenv('lang')
