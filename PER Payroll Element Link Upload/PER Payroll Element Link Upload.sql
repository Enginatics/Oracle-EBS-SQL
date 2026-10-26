/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Payroll Element Link Upload
-- Description: Upload to create, update and end date element links as in the Element Link form: the element, the eligibility criteria (organization, job, position, grade, people group, location, salary basis, employment category, payroll or all payrolls), standard link, costing, qualifying conditions and the Further Information flexfield.
-- Changes are made as of the Effective Date. When Datetrack Mode is blank, the link is corrected if the Effective Date is the start date of its current record, and otherwise a change is inserted from the Effective Date (Update, or Update - Insert when later changes exist).
-- The element and the eligibility criteria of an existing link cannot be changed, as in the form. A new row with the criteria of an existing link of the element updates that link. Entering an End Date end dates the link on that date, clearing it removes the end date.
-- Costing and Balancing take the segment values the form shows (segments enabled for the Element and Balancing levels), separated by the flexfield delimiter. People Group takes the concatenated segment values. New combinations are created as needed.
-- Link input values are not maintained by this upload.
-- Excel Example Output: https://www.enginatics.com/example/per-payroll-element-link-upload/
-- Library Link: https://www.enginatics.com/reports/per-payroll-element-link-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
to_number(null) element_link_id_out,
pelf.element_link_id,
pbg.name business_group,
petfv.element_name,
petfv.description element_description,
(select pecv.classification_name from pay_element_classifications_vl pecv where petfv.classification_id=pecv.classification_id) classification,
xxen_util.meaning(petfv.processing_type,'PROCESSING_TYPE',3) processing_type,
xxen_util.yes(pelf.standard_link_flag) standard,
:effective_date effective_date,
null datetrack_mode,
(select min(pelf2.effective_start_date) from pay_element_links_f pelf2 where pelf.element_link_id=pelf2.element_link_id) start_date,
(select nullif(max(pelf2.effective_end_date),to_date('31-12-4712','DD-MM-YYYY')) from pay_element_links_f pelf2 where pelf.element_link_id=pelf2.element_link_id) end_date,
(select haouv.name from hr_all_organization_units_vl haouv where pelf.organization_id=haouv.organization_id) organization,
(select pjv.name from per_jobs_vl pjv where pelf.job_id=pjv.job_id) job,
(select hpf.name from hr_positions_f hpf where pelf.position_id=hpf.position_id and :effective_date between hpf.effective_start_date and hpf.effective_end_date) position,
(select pgv.name from per_grades_vl pgv where pelf.grade_id=pgv.grade_id) grade,
(select ppg.group_name from pay_people_groups ppg where pelf.people_group_id=ppg.people_group_id) people_group,
(select hlav.location_code from hr_locations_all_vl hlav where pelf.location_id=hlav.location_id) location,
(select ppb.name from per_pay_bases ppb where pelf.pay_basis_id=ppb.pay_basis_id) salary_basis,
xxen_util.meaning(pelf.employment_category,'EMP_CAT',3) employment_category,
(select papf.payroll_name from pay_all_payrolls_f papf where pelf.payroll_id=papf.payroll_id and :effective_date between papf.effective_start_date and papf.effective_end_date) payroll,
xxen_util.yes(pelf.link_to_all_payrolls_flag) link_to_all_payrolls,
xxen_util.meaning(pelf.costable_type,'COSTABLE_TYPE',3) costable_type,
xxen_util.yes(pelf.transfer_to_gl_flag) transfer_to_gl,
(select pes.element_set_name from pay_element_sets pes where pelf.element_set_id=pes.element_set_id) distribution_set,
xxen_hr_upload.cost_keyflex_dsp(pelf.cost_allocation_keyflex_id,'ELEMENT') costing,
xxen_hr_upload.cost_keyflex_dsp(pelf.balancing_keyflex_id,'BALANCING') balancing,
pelf.qualifying_age,
pelf.qualifying_length_of_service,
xxen_util.meaning(pelf.qualifying_units,'QUALIFYING_UNITS',3) qualifying_units,
xxen_util.display_flexfield_context(801,'PAY_ELEMENT_LINKS',pelf.attribute_category) link_attribute_category,
xxen_util.display_flexfield_value(801,'PAY_ELEMENT_LINKS',pelf.attribute_category,'ATTRIBUTE1',pelf.rowid,pelf.attribute1) link_attribute1,
xxen_util.display_flexfield_value(801,'PAY_ELEMENT_LINKS',pelf.attribute_category,'ATTRIBUTE2',pelf.rowid,pelf.attribute2) link_attribute2,
xxen_util.display_flexfield_value(801,'PAY_ELEMENT_LINKS',pelf.attribute_category,'ATTRIBUTE3',pelf.rowid,pelf.attribute3) link_attribute3,
xxen_util.display_flexfield_value(801,'PAY_ELEMENT_LINKS',pelf.attribute_category,'ATTRIBUTE4',pelf.rowid,pelf.attribute4) link_attribute4,
xxen_util.display_flexfield_value(801,'PAY_ELEMENT_LINKS',pelf.attribute_category,'ATTRIBUTE5',pelf.rowid,pelf.attribute5) link_attribute5,
xxen_util.display_flexfield_value(801,'PAY_ELEMENT_LINKS',pelf.attribute_category,'ATTRIBUTE6',pelf.rowid,pelf.attribute6) link_attribute6,
xxen_util.display_flexfield_value(801,'PAY_ELEMENT_LINKS',pelf.attribute_category,'ATTRIBUTE7',pelf.rowid,pelf.attribute7) link_attribute7,
xxen_util.display_flexfield_value(801,'PAY_ELEMENT_LINKS',pelf.attribute_category,'ATTRIBUTE8',pelf.rowid,pelf.attribute8) link_attribute8,
xxen_util.display_flexfield_value(801,'PAY_ELEMENT_LINKS',pelf.attribute_category,'ATTRIBUTE9',pelf.rowid,pelf.attribute9) link_attribute9,
xxen_util.display_flexfield_value(801,'PAY_ELEMENT_LINKS',pelf.attribute_category,'ATTRIBUTE10',pelf.rowid,pelf.attribute10) link_attribute10,
xxen_util.display_flexfield_value(801,'PAY_ELEMENT_LINKS',pelf.attribute_category,'ATTRIBUTE11',pelf.rowid,pelf.attribute11) link_attribute11,
xxen_util.display_flexfield_value(801,'PAY_ELEMENT_LINKS',pelf.attribute_category,'ATTRIBUTE12',pelf.rowid,pelf.attribute12) link_attribute12,
xxen_util.display_flexfield_value(801,'PAY_ELEMENT_LINKS',pelf.attribute_category,'ATTRIBUTE13',pelf.rowid,pelf.attribute13) link_attribute13,
xxen_util.display_flexfield_value(801,'PAY_ELEMENT_LINKS',pelf.attribute_category,'ATTRIBUTE14',pelf.rowid,pelf.attribute14) link_attribute14,
xxen_util.display_flexfield_value(801,'PAY_ELEMENT_LINKS',pelf.attribute_category,'ATTRIBUTE15',pelf.rowid,pelf.attribute15) link_attribute15,
xxen_util.display_flexfield_value(801,'PAY_ELEMENT_LINKS',pelf.attribute_category,'ATTRIBUTE16',pelf.rowid,pelf.attribute16) link_attribute16,
xxen_util.display_flexfield_value(801,'PAY_ELEMENT_LINKS',pelf.attribute_category,'ATTRIBUTE17',pelf.rowid,pelf.attribute17) link_attribute17,
xxen_util.display_flexfield_value(801,'PAY_ELEMENT_LINKS',pelf.attribute_category,'ATTRIBUTE18',pelf.rowid,pelf.attribute18) link_attribute18,
xxen_util.display_flexfield_value(801,'PAY_ELEMENT_LINKS',pelf.attribute_category,'ATTRIBUTE19',pelf.rowid,pelf.attribute19) link_attribute19,
xxen_util.display_flexfield_value(801,'PAY_ELEMENT_LINKS',pelf.attribute_category,'ATTRIBUTE20',pelf.rowid,pelf.attribute20) link_attribute20,
0 upload_row
from
per_business_groups pbg,
pay_element_links_f pelf,
pay_element_types_f_vl petfv
where
1=1 and
pbg.business_group_id=:business_group_id and
pbg.business_group_id=pelf.business_group_id and
:effective_date between pelf.effective_start_date and pelf.effective_end_date and
pelf.element_type_id=petfv.element_type_id and
:effective_date between petfv.effective_start_date and petfv.effective_end_date
