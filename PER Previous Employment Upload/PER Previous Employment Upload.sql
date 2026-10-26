/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Previous Employment Upload
-- Description: Upload to create, update and delete previous employment as in the Previous Employment window of the People form: previous employers with address, country, type, period of service and the Additional Previous Employer Details flexfield, and the jobs held there with employee category, period and the Additional Previous Job Details flexfield.
-- Each row holds a previous employer and optionally one of its jobs; the employer columns repeat on every job row. A row is matched to an existing employer by the hidden id of a downloaded row, otherwise by employee, employer name and employer start date, and to an existing job by job name and start date within the employer.
-- The assignment usages of previous jobs (Assignment Details region) are not part of the upload.
-- Excel Example Output: https://www.enginatics.com/example/per-previous-employment-upload/
-- Library Link: https://www.enginatics.com/reports/per-previous-employment-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
to_number(null) previous_employer_id_out,
to_number(null) previous_job_id_out,
ppe.previous_employer_id,
ppj.previous_job_id,
pbg.name business_group,
papf.employee_number,
papf.full_name,
ppe.employer_name employer,
ppe.start_date employer_start_date,
ppe.end_date employer_end_date,
ppe.employer_address,
(select ftv.territory_short_name from fnd_territories_vl ftv where ppe.employer_country=ftv.territory_code) employer_country,
xxen_util.meaning(ppe.employer_type,'PREV_EMP_TYPE',3) employer_type,
xxen_util.meaning(ppe.employer_subtype,'PREV_EMP_SUBTYPE',3) employer_subtype,
ppe.period_years employer_years,
ppe.period_months employer_months,
ppe.period_days employer_days,
ppe.description employer_description,
xxen_util.yes(ppe.all_assignments) employer_all_assignments,
null delete_employer,
xxen_util.display_flexfield_context(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category) pem_attribute_category,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE1',ppe.rowid,ppe.pem_attribute1) pem_attribute1,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE2',ppe.rowid,ppe.pem_attribute2) pem_attribute2,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE3',ppe.rowid,ppe.pem_attribute3) pem_attribute3,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE4',ppe.rowid,ppe.pem_attribute4) pem_attribute4,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE5',ppe.rowid,ppe.pem_attribute5) pem_attribute5,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE6',ppe.rowid,ppe.pem_attribute6) pem_attribute6,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE7',ppe.rowid,ppe.pem_attribute7) pem_attribute7,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE8',ppe.rowid,ppe.pem_attribute8) pem_attribute8,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE9',ppe.rowid,ppe.pem_attribute9) pem_attribute9,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE10',ppe.rowid,ppe.pem_attribute10) pem_attribute10,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE11',ppe.rowid,ppe.pem_attribute11) pem_attribute11,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE12',ppe.rowid,ppe.pem_attribute12) pem_attribute12,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE13',ppe.rowid,ppe.pem_attribute13) pem_attribute13,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE14',ppe.rowid,ppe.pem_attribute14) pem_attribute14,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE15',ppe.rowid,ppe.pem_attribute15) pem_attribute15,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE16',ppe.rowid,ppe.pem_attribute16) pem_attribute16,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE17',ppe.rowid,ppe.pem_attribute17) pem_attribute17,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE18',ppe.rowid,ppe.pem_attribute18) pem_attribute18,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE19',ppe.rowid,ppe.pem_attribute19) pem_attribute19,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE20',ppe.rowid,ppe.pem_attribute20) pem_attribute20,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE21',ppe.rowid,ppe.pem_attribute21) pem_attribute21,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE22',ppe.rowid,ppe.pem_attribute22) pem_attribute22,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE23',ppe.rowid,ppe.pem_attribute23) pem_attribute23,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE24',ppe.rowid,ppe.pem_attribute24) pem_attribute24,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE25',ppe.rowid,ppe.pem_attribute25) pem_attribute25,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE26',ppe.rowid,ppe.pem_attribute26) pem_attribute26,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE27',ppe.rowid,ppe.pem_attribute27) pem_attribute27,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE28',ppe.rowid,ppe.pem_attribute28) pem_attribute28,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE29',ppe.rowid,ppe.pem_attribute29) pem_attribute29,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_EMPLOYERS',ppe.pem_attribute_category,'PEM_ATTRIBUTE30',ppe.rowid,ppe.pem_attribute30) pem_attribute30,
ppj.start_date job_start_date,
ppj.end_date job_end_date,
ppj.job_name job,
xxen_util.meaning(ppj.employment_category,'EMPLOYEE_CATG',3) employee_category,
ppj.period_years job_years,
ppj.period_months job_months,
ppj.period_days job_days,
ppj.description job_description,
xxen_util.yes(ppj.all_assignments) job_all_assignments,
null delete_job,
xxen_util.display_flexfield_context(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category) pjo_attribute_category,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE1',ppj.rowid,ppj.pjo_attribute1) pjo_attribute1,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE2',ppj.rowid,ppj.pjo_attribute2) pjo_attribute2,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE3',ppj.rowid,ppj.pjo_attribute3) pjo_attribute3,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE4',ppj.rowid,ppj.pjo_attribute4) pjo_attribute4,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE5',ppj.rowid,ppj.pjo_attribute5) pjo_attribute5,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE6',ppj.rowid,ppj.pjo_attribute6) pjo_attribute6,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE7',ppj.rowid,ppj.pjo_attribute7) pjo_attribute7,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE8',ppj.rowid,ppj.pjo_attribute8) pjo_attribute8,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE9',ppj.rowid,ppj.pjo_attribute9) pjo_attribute9,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE10',ppj.rowid,ppj.pjo_attribute10) pjo_attribute10,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE11',ppj.rowid,ppj.pjo_attribute11) pjo_attribute11,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE12',ppj.rowid,ppj.pjo_attribute12) pjo_attribute12,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE13',ppj.rowid,ppj.pjo_attribute13) pjo_attribute13,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE14',ppj.rowid,ppj.pjo_attribute14) pjo_attribute14,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE15',ppj.rowid,ppj.pjo_attribute15) pjo_attribute15,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE16',ppj.rowid,ppj.pjo_attribute16) pjo_attribute16,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE17',ppj.rowid,ppj.pjo_attribute17) pjo_attribute17,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE18',ppj.rowid,ppj.pjo_attribute18) pjo_attribute18,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE19',ppj.rowid,ppj.pjo_attribute19) pjo_attribute19,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE20',ppj.rowid,ppj.pjo_attribute20) pjo_attribute20,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE21',ppj.rowid,ppj.pjo_attribute21) pjo_attribute21,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE22',ppj.rowid,ppj.pjo_attribute22) pjo_attribute22,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE23',ppj.rowid,ppj.pjo_attribute23) pjo_attribute23,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE24',ppj.rowid,ppj.pjo_attribute24) pjo_attribute24,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE25',ppj.rowid,ppj.pjo_attribute25) pjo_attribute25,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE26',ppj.rowid,ppj.pjo_attribute26) pjo_attribute26,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE27',ppj.rowid,ppj.pjo_attribute27) pjo_attribute27,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE28',ppj.rowid,ppj.pjo_attribute28) pjo_attribute28,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE29',ppj.rowid,ppj.pjo_attribute29) pjo_attribute29,
xxen_util.display_flexfield_value(800,'PER_PREVIOUS_JOBS',ppj.pjo_attribute_category,'PJO_ATTRIBUTE30',ppj.rowid,ppj.pjo_attribute30) pjo_attribute30,
0 upload_row
from
per_business_groups pbg,
per_all_people_f papf,
per_previous_employers ppe,
per_previous_jobs ppj
where
1=1 and
pbg.business_group_id=:business_group_id and
papf.business_group_id=pbg.business_group_id and
trunc(sysdate) between papf.effective_start_date and papf.effective_end_date and
papf.person_id=ppe.person_id and
ppe.previous_employer_id=ppj.previous_employer_id(+)
