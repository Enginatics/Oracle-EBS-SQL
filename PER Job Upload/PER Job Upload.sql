/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Job Upload
-- Description: Upload to create and update jobs as in the Job window (Define Job): job group, name, dates, approval authority, additional employment rights, benchmark job and the Additional Job Details flexfield.
-- A row whose Name does not exist in the job group creates the job. Name is the concatenated Job flexfield segments of the job group's structure; changing it on a downloaded row renames the job. End a job by entering its Date To.
-- Evaluation, requirements and valid grades of the Job window are not part of the upload.
-- Excel Example Output: https://www.enginatics.com/example/per-job-upload/
-- Library Link: https://www.enginatics.com/reports/per-job-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
to_number(null) job_id_out,
pj.job_id,
pbg.name business_group,
(select pjg.displayed_name from per_job_groups pjg where pj.job_group_id=pjg.job_group_id) job_group,
pjt.name,
pj.date_from,
pj.date_to,
pj.approval_authority,
xxen_util.yes(pj.emp_rights_flag) additional_employment_rights,
xxen_util.yes(pj.benchmark_job_flag) benchmark_job,
(select pjt2.name from per_jobs_tl pjt2 where pj.benchmark_job_id=pjt2.job_id and pjt2.language=userenv('lang')) benchmark_job_name,
xxen_util.display_flexfield_context(800,'PER_JOBS',pj.attribute_category) job_attribute_category,
xxen_util.display_flexfield_value(800,'PER_JOBS',pj.attribute_category,'ATTRIBUTE1',pj.rowid,pj.attribute1) job_attribute1,
xxen_util.display_flexfield_value(800,'PER_JOBS',pj.attribute_category,'ATTRIBUTE2',pj.rowid,pj.attribute2) job_attribute2,
xxen_util.display_flexfield_value(800,'PER_JOBS',pj.attribute_category,'ATTRIBUTE3',pj.rowid,pj.attribute3) job_attribute3,
xxen_util.display_flexfield_value(800,'PER_JOBS',pj.attribute_category,'ATTRIBUTE4',pj.rowid,pj.attribute4) job_attribute4,
xxen_util.display_flexfield_value(800,'PER_JOBS',pj.attribute_category,'ATTRIBUTE5',pj.rowid,pj.attribute5) job_attribute5,
xxen_util.display_flexfield_value(800,'PER_JOBS',pj.attribute_category,'ATTRIBUTE6',pj.rowid,pj.attribute6) job_attribute6,
xxen_util.display_flexfield_value(800,'PER_JOBS',pj.attribute_category,'ATTRIBUTE7',pj.rowid,pj.attribute7) job_attribute7,
xxen_util.display_flexfield_value(800,'PER_JOBS',pj.attribute_category,'ATTRIBUTE8',pj.rowid,pj.attribute8) job_attribute8,
xxen_util.display_flexfield_value(800,'PER_JOBS',pj.attribute_category,'ATTRIBUTE9',pj.rowid,pj.attribute9) job_attribute9,
xxen_util.display_flexfield_value(800,'PER_JOBS',pj.attribute_category,'ATTRIBUTE10',pj.rowid,pj.attribute10) job_attribute10,
xxen_util.display_flexfield_value(800,'PER_JOBS',pj.attribute_category,'ATTRIBUTE11',pj.rowid,pj.attribute11) job_attribute11,
xxen_util.display_flexfield_value(800,'PER_JOBS',pj.attribute_category,'ATTRIBUTE12',pj.rowid,pj.attribute12) job_attribute12,
xxen_util.display_flexfield_value(800,'PER_JOBS',pj.attribute_category,'ATTRIBUTE13',pj.rowid,pj.attribute13) job_attribute13,
xxen_util.display_flexfield_value(800,'PER_JOBS',pj.attribute_category,'ATTRIBUTE14',pj.rowid,pj.attribute14) job_attribute14,
xxen_util.display_flexfield_value(800,'PER_JOBS',pj.attribute_category,'ATTRIBUTE15',pj.rowid,pj.attribute15) job_attribute15,
xxen_util.display_flexfield_value(800,'PER_JOBS',pj.attribute_category,'ATTRIBUTE16',pj.rowid,pj.attribute16) job_attribute16,
xxen_util.display_flexfield_value(800,'PER_JOBS',pj.attribute_category,'ATTRIBUTE17',pj.rowid,pj.attribute17) job_attribute17,
xxen_util.display_flexfield_value(800,'PER_JOBS',pj.attribute_category,'ATTRIBUTE18',pj.rowid,pj.attribute18) job_attribute18,
xxen_util.display_flexfield_value(800,'PER_JOBS',pj.attribute_category,'ATTRIBUTE19',pj.rowid,pj.attribute19) job_attribute19,
xxen_util.display_flexfield_value(800,'PER_JOBS',pj.attribute_category,'ATTRIBUTE20',pj.rowid,pj.attribute20) job_attribute20,
0 upload_row
from
per_business_groups pbg,
per_jobs pj,
per_jobs_tl pjt
where
1=1 and
pbg.business_group_id=:business_group_id and
pj.business_group_id=pbg.business_group_id and
pj.job_id=pjt.job_id and
pjt.language=userenv('lang')
