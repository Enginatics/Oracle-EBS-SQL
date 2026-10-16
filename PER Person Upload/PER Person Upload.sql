/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Person Upload
-- Description: Upload to create and update people as in the People form (Combined Person and Assignment form, People window): employees, contingent workers and applicants, their personal details, Further Person Information and Additional Personal Details flexfields.
-- A new person is created with hremployeeapi, hrcontingentworkerapi or hrapplicantapi depending on the system type of the Person Type. The Latest Start Date is the hire, placement or application date, and the API creates the default primary assignment in the business group. Use the PER Person Assignment Upload for the assignment details.
-- Person details are changed as of the Effective Date. When Datetrack Mode is blank, the record is corrected if the Effective Date is its start date, and otherwise a change is inserted from the Effective Date (Update, or Update - Insert when later changes exist).
-- Entering a Termination Date terminates an employee (with the Final Process Date if given) or ends a contingent worker placement. Changing the Person Type of an ex-employee to an employee person type rehires the employee on the Latest Start Date.
-- Existing people are matched by the hidden person id when downloaded, otherwise by Person Number: the employee number, contingent worker number or applicant number according to the Person Type.
-- Excel Example Output: https://www.enginatics.com/example/per-person-upload/
-- Library Link: https://www.enginatics.com/reports/per-person-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
to_number(null) person_id_out,
papf.person_id,
pbg.name business_group,
decode(pptuf.system_person_type,'CWK',papf.npw_number,'EX_CWK',papf.npw_number,'APL',papf.applicant_number,'EX_APL',papf.applicant_number,papf.employee_number) person_number,
papf.full_name,
papf.last_name,
papf.first_name,
xxen_util.meaning(papf.title,'TITLE',3) title,
papf.pre_name_adjunct prefix,
papf.suffix,
papf.middle_names,
xxen_util.meaning(papf.sex,'SEX',3) gender,
pptt.user_person_type person_type,
papf.national_identifier,
:effective_date effective_date,
null datetrack_mode,
coalesce(ppos.date_start,ppop.date_start,papf.start_date) latest_start_date,
papf.date_of_birth birth_date,
papf.town_of_birth,
papf.region_of_birth,
(select ftv.territory_short_name from fnd_territories_vl ftv where papf.country_of_birth=ftv.territory_code) country_of_birth,
xxen_util.meaning(papf.marital_status,'MAR_STATUS',3) marital_status,
xxen_util.meaning(papf.nationality,'NATIONALITY',3) nationality,
xxen_util.meaning(papf.registered_disabled_flag,'REGISTERED_DISABLED',3) registered_disabled,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION1',papf.rowid,papf.per_information1) per_information1,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION2',papf.rowid,papf.per_information2) per_information2,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION3',papf.rowid,papf.per_information3) per_information3,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION4',papf.rowid,papf.per_information4) per_information4,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION5',papf.rowid,papf.per_information5) per_information5,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION6',papf.rowid,papf.per_information6) per_information6,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION7',papf.rowid,papf.per_information7) per_information7,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION8',papf.rowid,papf.per_information8) per_information8,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION9',papf.rowid,papf.per_information9) per_information9,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION10',papf.rowid,papf.per_information10) per_information10,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION11',papf.rowid,papf.per_information11) per_information11,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION12',papf.rowid,papf.per_information12) per_information12,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION13',papf.rowid,papf.per_information13) per_information13,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION14',papf.rowid,papf.per_information14) per_information14,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION15',papf.rowid,papf.per_information15) per_information15,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION16',papf.rowid,papf.per_information16) per_information16,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION17',papf.rowid,papf.per_information17) per_information17,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION18',papf.rowid,papf.per_information18) per_information18,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION19',papf.rowid,papf.per_information19) per_information19,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION20',papf.rowid,papf.per_information20) per_information20,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION21',papf.rowid,papf.per_information21) per_information21,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION22',papf.rowid,papf.per_information22) per_information22,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION23',papf.rowid,papf.per_information23) per_information23,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION24',papf.rowid,papf.per_information24) per_information24,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION25',papf.rowid,papf.per_information25) per_information25,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION26',papf.rowid,papf.per_information26) per_information26,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION27',papf.rowid,papf.per_information27) per_information27,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION28',papf.rowid,papf.per_information28) per_information28,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION29',papf.rowid,papf.per_information29) per_information29,
xxen_util.display_flexfield_value(800,'Person Developer DF',papf.per_information_category,'PER_INFORMATION30',papf.rowid,papf.per_information30) per_information30,
papf.office_number office,
papf.internal_location location,
papf.mailstop,
papf.email_address email,
xxen_util.meaning(papf.expense_check_send_to_address,'HOME_OFFICE',3) mail_to,
papf.honors,
papf.known_as preferred_name,
papf.previous_last_name,
(select flv.description from fnd_languages_vl flv where papf.correspondence_language=flv.language_code) correspondence_language,
papf.date_employee_data_verified date_last_verified,
xxen_util.meaning(papf.student_status,'STUDENT_STATUS',3) student_status,
xxen_util.yes(papf.on_military_service) on_military_service,
xxen_util.yes(papf.second_passport_exists) second_passport,
papf.original_date_of_hire date_first_hired,
nvl(ppos.actual_termination_date,ppop.actual_termination_date) termination_date,
nvl(xxen_util.meaning(ppos.leaving_reason,'LEAV_REAS',3),xxen_util.meaning(ppop.termination_reason,'HR_CWK_TERMINATION_REASONS',3)) leaving_reason,
nvl(ppos.final_process_date,ppop.final_process_date) final_process_date,
xxen_util.display_flexfield_context(800,'PER_PEOPLE',papf.attribute_category) per_attribute_category,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE1',papf.rowid,papf.attribute1) per_attribute1,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE2',papf.rowid,papf.attribute2) per_attribute2,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE3',papf.rowid,papf.attribute3) per_attribute3,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE4',papf.rowid,papf.attribute4) per_attribute4,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE5',papf.rowid,papf.attribute5) per_attribute5,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE6',papf.rowid,papf.attribute6) per_attribute6,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE7',papf.rowid,papf.attribute7) per_attribute7,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE8',papf.rowid,papf.attribute8) per_attribute8,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE9',papf.rowid,papf.attribute9) per_attribute9,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE10',papf.rowid,papf.attribute10) per_attribute10,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE11',papf.rowid,papf.attribute11) per_attribute11,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE12',papf.rowid,papf.attribute12) per_attribute12,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE13',papf.rowid,papf.attribute13) per_attribute13,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE14',papf.rowid,papf.attribute14) per_attribute14,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE15',papf.rowid,papf.attribute15) per_attribute15,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE16',papf.rowid,papf.attribute16) per_attribute16,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE17',papf.rowid,papf.attribute17) per_attribute17,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE18',papf.rowid,papf.attribute18) per_attribute18,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE19',papf.rowid,papf.attribute19) per_attribute19,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE20',papf.rowid,papf.attribute20) per_attribute20,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE21',papf.rowid,papf.attribute21) per_attribute21,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE22',papf.rowid,papf.attribute22) per_attribute22,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE23',papf.rowid,papf.attribute23) per_attribute23,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE24',papf.rowid,papf.attribute24) per_attribute24,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE25',papf.rowid,papf.attribute25) per_attribute25,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE26',papf.rowid,papf.attribute26) per_attribute26,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE27',papf.rowid,papf.attribute27) per_attribute27,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE28',papf.rowid,papf.attribute28) per_attribute28,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE29',papf.rowid,papf.attribute29) per_attribute29,
xxen_util.display_flexfield_value(800,'PER_PEOPLE',papf.attribute_category,'ATTRIBUTE30',papf.rowid,papf.attribute30) per_attribute30,
0 upload_row
from
per_business_groups pbg,
per_all_people_f papf,
(
select
pptuf.person_id,
max(ppt.person_type_id) keep (dense_rank first order by decode(ppt.system_person_type,'EMP',1,'CWK',2,'APL',3,'EX_EMP',4,'EX_CWK',5,6)) person_type_id,
max(ppt.system_person_type) keep (dense_rank first order by decode(ppt.system_person_type,'EMP',1,'CWK',2,'APL',3,'EX_EMP',4,'EX_CWK',5,6)) system_person_type
from
per_person_type_usages_f pptuf,
per_person_types ppt
where
:effective_date between pptuf.effective_start_date and pptuf.effective_end_date and
pptuf.person_type_id=ppt.person_type_id and
ppt.business_group_id=:business_group_id and
ppt.system_person_type in ('EMP','CWK','APL','EX_EMP','EX_CWK','EX_APL')
group by
pptuf.person_id
) pptuf,
per_person_types_tl pptt,
(
select
ppos.person_id,
ppos.date_start,
ppos.actual_termination_date,
ppos.final_process_date,
ppos.leaving_reason,
row_number() over (partition by ppos.person_id order by ppos.date_start desc) rn
from
per_periods_of_service ppos
where
ppos.business_group_id=:business_group_id and
ppos.date_start<=:effective_date
) ppos,
(
select
ppop.person_id,
ppop.date_start,
ppop.actual_termination_date,
ppop.final_process_date,
ppop.termination_reason,
row_number() over (partition by ppop.person_id order by ppop.date_start desc) rn
from
per_periods_of_placement ppop
where
ppop.business_group_id=:business_group_id and
ppop.date_start<=:effective_date
) ppop
where
1=1 and
pbg.business_group_id=:business_group_id and
papf.business_group_id=pbg.business_group_id and
:effective_date between papf.effective_start_date and papf.effective_end_date and
papf.person_id=pptuf.person_id and
pptuf.person_type_id=pptt.person_type_id and
pptt.language=userenv('lang') and
papf.person_id=ppos.person_id(+) and
ppos.rn(+)=1 and
papf.person_id=ppop.person_id(+) and
ppop.rn(+)=1
