/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Person Extra Information Upload
-- Description: Upload to create and update Person Extra Information Types (EITs) within Oracle HRMS - the People form > Others > Extra Information > Extra Person Information window.
-- Scope:
-- - Generic upload covering all person extra information types. The Information Type parameter/column lists every enabled context of the Extra Person Info DDF flexfield (titled Extra Person Information), which holds the registered EIT types.
-- - The segment values are loaded as raw Information 1..30 columns (peiinformation1..30), matching the order of the information type's flexfield segments.
-- - Create new person extra information records and update existing ones (auto-detected by the hidden Person Extra Information ID downloaded in Create, Update mode).
-- Notes:
-- - A person can hold multiple records of the same information type (e.g. one per year), so existing rows are matched by the hidden Person Extra Information ID, not by person and type.
-- - The information type must be eligible for the person; ineligible types are rejected by the API.
-- - For information type segments validated against a value set, enter the stored value the segment expects.
-- Excel Example Output: https://www.enginatics.com/example/per-person-extra-information-upload/
-- Library Link: https://www.enginatics.com/reports/per-person-extra-information-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
to_number(null) person_extra_info_id_out,
ppei.person_extra_info_id,
papf.employee_number,
papf.full_name,
pbg.name business_group,
fdfcv.descriptive_flex_context_name information_type,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION1',ppei.rowid,ppei.pei_information1) pei_information1,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION2',ppei.rowid,ppei.pei_information2) pei_information2,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION3',ppei.rowid,ppei.pei_information3) pei_information3,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION4',ppei.rowid,ppei.pei_information4) pei_information4,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION5',ppei.rowid,ppei.pei_information5) pei_information5,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION6',ppei.rowid,ppei.pei_information6) pei_information6,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION7',ppei.rowid,ppei.pei_information7) pei_information7,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION8',ppei.rowid,ppei.pei_information8) pei_information8,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION9',ppei.rowid,ppei.pei_information9) pei_information9,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION10',ppei.rowid,ppei.pei_information10) pei_information10,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION11',ppei.rowid,ppei.pei_information11) pei_information11,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION12',ppei.rowid,ppei.pei_information12) pei_information12,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION13',ppei.rowid,ppei.pei_information13) pei_information13,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION14',ppei.rowid,ppei.pei_information14) pei_information14,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION15',ppei.rowid,ppei.pei_information15) pei_information15,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION16',ppei.rowid,ppei.pei_information16) pei_information16,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION17',ppei.rowid,ppei.pei_information17) pei_information17,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION18',ppei.rowid,ppei.pei_information18) pei_information18,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION19',ppei.rowid,ppei.pei_information19) pei_information19,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION20',ppei.rowid,ppei.pei_information20) pei_information20,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION21',ppei.rowid,ppei.pei_information21) pei_information21,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION22',ppei.rowid,ppei.pei_information22) pei_information22,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION23',ppei.rowid,ppei.pei_information23) pei_information23,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION24',ppei.rowid,ppei.pei_information24) pei_information24,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION25',ppei.rowid,ppei.pei_information25) pei_information25,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION26',ppei.rowid,ppei.pei_information26) pei_information26,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION27',ppei.rowid,ppei.pei_information27) pei_information27,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION28',ppei.rowid,ppei.pei_information28) pei_information28,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION29',ppei.rowid,ppei.pei_information29) pei_information29,
xxen_util.display_flexfield_value(800,'Extra Person Info DDF',ppei.pei_information_category,'PEI_INFORMATION30',ppei.rowid,ppei.pei_information30) pei_information30,
0 upload_row
from
per_business_groups pbg,
per_all_people_f papf,
per_people_extra_info ppei,
fnd_descr_flex_contexts_vl fdfcv
where
1=1 and
pbg.business_group_id=:p_business_group and
papf.business_group_id=pbg.business_group_id and
trunc(sysdate) between papf.effective_start_date and papf.effective_end_date and
ppei.person_id=papf.person_id and
fdfcv.application_id=800 and
fdfcv.descriptive_flexfield_name='Extra Person Info DDF' and
fdfcv.descriptive_flex_context_code=ppei.pei_information_category and
fdfcv.enabled_flag='Y'
