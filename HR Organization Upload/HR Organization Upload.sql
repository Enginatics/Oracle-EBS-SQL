/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: HR Organization Upload
-- Description: Upload to create and update organizations, organization classifications, and organization information types within Oracle HRMS.

Scope:
- Create new organizations, assign classifications and information types, and specify the information type attributes
- Update existing organization data, classifications (enable/disable), and the information type attributes
- Supports all organization classification types: Business Groups (excluding creation of new Business Groups), HR Organization, Operating Unit, GRE/Legal Entity, Company Cost Center, Inventory Organization, etc.
- Supports creation/update of single-row (GS) and multi-row (GM) organization information types and their attributes (org_information1..20) with dynamic LOVs and segment labels
- Supports creation/update of the Cost Allocation Key Flexfield segments against the HR Organization Classification (ORGANIZATION qualified segments only)


Constraints:
- Organizations can only be created/updated within the Business Group associated with the current responsibility
- Business Group creation is not supported - use the Define Organizations form
- The following organization information types cannot be updated via the API once created: Business Group Information, Canada Employer Identification. These can be created but not subsequently modified by this upload
- Only supports the creation and update of the single-row DFF and multi-row DFF information types. 
- Organization information segments that reference self-referencing data may require a two-step upload: first create the info type, then update the self-referencing attribute in a second pass
-- Excel Examle Output: https://www.enginatics.com/example/hr-organization-upload/
-- Library Link: https://www.enginatics.com/reports/hr-organization-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
to_number(null) organization_id_out,
to_number(null) class_org_info_id_out,
to_number(null) org_info_id_out,
haou.organization_id,
hoi_class.org_information_id class_org_info_id,
hoi.org_information_id org_info_id,
pbg.name business_group,
haout.name organization_name,
xxen_util.meaning(haou.type,'ORG_TYPE',3) organization_type,
haou.date_from,
haou.date_to,
hl.location_code location,
xxen_util.meaning(haou.internal_external_flag,'INTL_EXTL',3) internal_external,
haou.internal_address_line,
xxen_util.display_flexfield_context(800,'PER_ORGANIZATION_UNITS',haou.attribute_category) org_dff_context,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE1',haou.rowid,haou.attribute1) org_attribute1,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE2',haou.rowid,haou.attribute2) org_attribute2,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE3',haou.rowid,haou.attribute3) org_attribute3,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE4',haou.rowid,haou.attribute4) org_attribute4,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE5',haou.rowid,haou.attribute5) org_attribute5,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE6',haou.rowid,haou.attribute6) org_attribute6,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE7',haou.rowid,haou.attribute7) org_attribute7,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE8',haou.rowid,haou.attribute8) org_attribute8,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE9',haou.rowid,haou.attribute9) org_attribute9,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE10',haou.rowid,haou.attribute10) org_attribute10,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE11',haou.rowid,haou.attribute11) org_attribute11,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE12',haou.rowid,haou.attribute12) org_attribute12,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE13',haou.rowid,haou.attribute13) org_attribute13,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE14',haou.rowid,haou.attribute14) org_attribute14,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE15',haou.rowid,haou.attribute15) org_attribute15,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE16',haou.rowid,haou.attribute16) org_attribute16,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE17',haou.rowid,haou.attribute17) org_attribute17,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE18',haou.rowid,haou.attribute18) org_attribute18,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE19',haou.rowid,haou.attribute19) org_attribute19,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE20',haou.rowid,haou.attribute20) org_attribute20,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE21',haou.rowid,haou.attribute21) org_attribute21,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE22',haou.rowid,haou.attribute22) org_attribute22,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE23',haou.rowid,haou.attribute23) org_attribute23,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE24',haou.rowid,haou.attribute24) org_attribute24,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE25',haou.rowid,haou.attribute25) org_attribute25,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE26',haou.rowid,haou.attribute26) org_attribute26,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE27',haou.rowid,haou.attribute27) org_attribute27,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE28',haou.rowid,haou.attribute28) org_attribute28,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE29',haou.rowid,haou.attribute29) org_attribute29,
xxen_util.display_flexfield_value(800,'PER_ORGANIZATION_UNITS',haou.attribute_category,'ATTRIBUTE30',haou.rowid,haou.attribute30) org_attribute30,
xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3) classification,
xxen_util.meaning(hoi_class.org_information2,'YES_NO',0) enabled,
hoi.displayed_org_information_type org_information_type,
nvl(hoi.classification_has_mandatory,'N') classification_has_mandatory,
nvl(hoi.mandatory_flag,'N') info_type_mandatory,
xxen_per_upload.org_info_segment_labels(xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3),hoi.displayed_org_information_type,pbg.legislation_code) org_info_segment_labels,
xxen_per_upload.org_info_segment_label(xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3),hoi.displayed_org_information_type,'ORG_INFORMATION1',pbg.legislation_code) org_info_label1,
xxen_per_upload.display_org_info_value(hoi.org_information_context,'ORG_INFORMATION1',hoi.hoi_rowid,hoi.org_information1,pbg.business_group_id,haou.organization_id,hoi.org_information_id) org_information1,
xxen_per_upload.org_info_segment_label(xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3),hoi.displayed_org_information_type,'ORG_INFORMATION2',pbg.legislation_code) org_info_label2,
xxen_per_upload.display_org_info_value(hoi.org_information_context,'ORG_INFORMATION2',hoi.hoi_rowid,hoi.org_information2,pbg.business_group_id,haou.organization_id,hoi.org_information_id) org_information2,
xxen_per_upload.org_info_segment_label(xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3),hoi.displayed_org_information_type,'ORG_INFORMATION3',pbg.legislation_code) org_info_label3,
xxen_per_upload.display_org_info_value(hoi.org_information_context,'ORG_INFORMATION3',hoi.hoi_rowid,hoi.org_information3,pbg.business_group_id,haou.organization_id,hoi.org_information_id) org_information3,
xxen_per_upload.org_info_segment_label(xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3),hoi.displayed_org_information_type,'ORG_INFORMATION4',pbg.legislation_code) org_info_label4,
xxen_per_upload.display_org_info_value(hoi.org_information_context,'ORG_INFORMATION4',hoi.hoi_rowid,hoi.org_information4,pbg.business_group_id,haou.organization_id,hoi.org_information_id) org_information4,
xxen_per_upload.org_info_segment_label(xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3),hoi.displayed_org_information_type,'ORG_INFORMATION5',pbg.legislation_code) org_info_label5,
xxen_per_upload.display_org_info_value(hoi.org_information_context,'ORG_INFORMATION5',hoi.hoi_rowid,hoi.org_information5,pbg.business_group_id,haou.organization_id,hoi.org_information_id) org_information5,
xxen_per_upload.org_info_segment_label(xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3),hoi.displayed_org_information_type,'ORG_INFORMATION6',pbg.legislation_code) org_info_label6,
xxen_per_upload.display_org_info_value(hoi.org_information_context,'ORG_INFORMATION6',hoi.hoi_rowid,hoi.org_information6,pbg.business_group_id,haou.organization_id,hoi.org_information_id) org_information6,
xxen_per_upload.org_info_segment_label(xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3),hoi.displayed_org_information_type,'ORG_INFORMATION7',pbg.legislation_code) org_info_label7,
xxen_per_upload.display_org_info_value(hoi.org_information_context,'ORG_INFORMATION7',hoi.hoi_rowid,hoi.org_information7,pbg.business_group_id,haou.organization_id,hoi.org_information_id) org_information7,
xxen_per_upload.org_info_segment_label(xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3),hoi.displayed_org_information_type,'ORG_INFORMATION8',pbg.legislation_code) org_info_label8,
xxen_per_upload.display_org_info_value(hoi.org_information_context,'ORG_INFORMATION8',hoi.hoi_rowid,hoi.org_information8,pbg.business_group_id,haou.organization_id,hoi.org_information_id) org_information8,
xxen_per_upload.org_info_segment_label(xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3),hoi.displayed_org_information_type,'ORG_INFORMATION9',pbg.legislation_code) org_info_label9,
xxen_per_upload.display_org_info_value(hoi.org_information_context,'ORG_INFORMATION9',hoi.hoi_rowid,hoi.org_information9,pbg.business_group_id,haou.organization_id,hoi.org_information_id) org_information9,
xxen_per_upload.org_info_segment_label(xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3),hoi.displayed_org_information_type,'ORG_INFORMATION10',pbg.legislation_code) org_info_label10,
xxen_per_upload.display_org_info_value(hoi.org_information_context,'ORG_INFORMATION10',hoi.hoi_rowid,hoi.org_information10,pbg.business_group_id,haou.organization_id,hoi.org_information_id) org_information10,
xxen_per_upload.org_info_segment_label(xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3),hoi.displayed_org_information_type,'ORG_INFORMATION11',pbg.legislation_code) org_info_label11,
xxen_per_upload.display_org_info_value(hoi.org_information_context,'ORG_INFORMATION11',hoi.hoi_rowid,hoi.org_information11,pbg.business_group_id,haou.organization_id,hoi.org_information_id) org_information11,
xxen_per_upload.org_info_segment_label(xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3),hoi.displayed_org_information_type,'ORG_INFORMATION12',pbg.legislation_code) org_info_label12,
xxen_per_upload.display_org_info_value(hoi.org_information_context,'ORG_INFORMATION12',hoi.hoi_rowid,hoi.org_information12,pbg.business_group_id,haou.organization_id,hoi.org_information_id) org_information12,
xxen_per_upload.org_info_segment_label(xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3),hoi.displayed_org_information_type,'ORG_INFORMATION13',pbg.legislation_code) org_info_label13,
xxen_per_upload.display_org_info_value(hoi.org_information_context,'ORG_INFORMATION13',hoi.hoi_rowid,hoi.org_information13,pbg.business_group_id,haou.organization_id,hoi.org_information_id) org_information13,
xxen_per_upload.org_info_segment_label(xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3),hoi.displayed_org_information_type,'ORG_INFORMATION14',pbg.legislation_code) org_info_label14,
xxen_per_upload.display_org_info_value(hoi.org_information_context,'ORG_INFORMATION14',hoi.hoi_rowid,hoi.org_information14,pbg.business_group_id,haou.organization_id,hoi.org_information_id) org_information14,
xxen_per_upload.org_info_segment_label(xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3),hoi.displayed_org_information_type,'ORG_INFORMATION15',pbg.legislation_code) org_info_label15,
xxen_per_upload.display_org_info_value(hoi.org_information_context,'ORG_INFORMATION15',hoi.hoi_rowid,hoi.org_information15,pbg.business_group_id,haou.organization_id,hoi.org_information_id) org_information15,
xxen_per_upload.org_info_segment_label(xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3),hoi.displayed_org_information_type,'ORG_INFORMATION16',pbg.legislation_code) org_info_label16,
xxen_per_upload.display_org_info_value(hoi.org_information_context,'ORG_INFORMATION16',hoi.hoi_rowid,hoi.org_information16,pbg.business_group_id,haou.organization_id,hoi.org_information_id) org_information16,
xxen_per_upload.org_info_segment_label(xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3),hoi.displayed_org_information_type,'ORG_INFORMATION17',pbg.legislation_code) org_info_label17,
xxen_per_upload.display_org_info_value(hoi.org_information_context,'ORG_INFORMATION17',hoi.hoi_rowid,hoi.org_information17,pbg.business_group_id,haou.organization_id,hoi.org_information_id) org_information17,
xxen_per_upload.org_info_segment_label(xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3),hoi.displayed_org_information_type,'ORG_INFORMATION18',pbg.legislation_code) org_info_label18,
xxen_per_upload.display_org_info_value(hoi.org_information_context,'ORG_INFORMATION18',hoi.hoi_rowid,hoi.org_information18,pbg.business_group_id,haou.organization_id,hoi.org_information_id) org_information18,
xxen_per_upload.org_info_segment_label(xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3),hoi.displayed_org_information_type,'ORG_INFORMATION19',pbg.legislation_code) org_info_label19,
xxen_per_upload.display_org_info_value(hoi.org_information_context,'ORG_INFORMATION19',hoi.hoi_rowid,hoi.org_information19,pbg.business_group_id,haou.organization_id,hoi.org_information_id) org_information19,
xxen_per_upload.org_info_segment_label(xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3),hoi.displayed_org_information_type,'ORG_INFORMATION20',pbg.legislation_code) org_info_label20,
xxen_per_upload.display_org_info_value(hoi.org_information_context,'ORG_INFORMATION20',hoi.hoi_rowid,hoi.org_information20,pbg.business_group_id,haou.organization_id,hoi.org_information_id) org_information20,
pcak.segment1 cost_alloc_segment1,
pcak.segment2 cost_alloc_segment2,
pcak.segment3 cost_alloc_segment3,
pcak.segment4 cost_alloc_segment4,
pcak.segment5 cost_alloc_segment5,
pcak.segment6 cost_alloc_segment6,
pcak.segment7 cost_alloc_segment7,
pcak.segment8 cost_alloc_segment8,
pcak.segment9 cost_alloc_segment9,
pcak.segment10 cost_alloc_segment10,
pcak.segment11 cost_alloc_segment11,
pcak.segment12 cost_alloc_segment12,
pcak.segment13 cost_alloc_segment13,
pcak.segment14 cost_alloc_segment14,
pcak.segment15 cost_alloc_segment15,
pcak.segment16 cost_alloc_segment16,
pcak.segment17 cost_alloc_segment17,
pcak.segment18 cost_alloc_segment18,
pcak.segment19 cost_alloc_segment19,
pcak.segment20 cost_alloc_segment20,
pcak.segment21 cost_alloc_segment21,
pcak.segment22 cost_alloc_segment22,
pcak.segment23 cost_alloc_segment23,
pcak.segment24 cost_alloc_segment24,
pcak.segment25 cost_alloc_segment25,
pcak.segment26 cost_alloc_segment26,
pcak.segment27 cost_alloc_segment27,
pcak.segment28 cost_alloc_segment28,
pcak.segment29 cost_alloc_segment29,
pcak.segment30 cost_alloc_segment30,
0 upload_row
from
hr_all_organization_units haou,
hr_all_organization_units_tl haout,
per_business_groups pbg,
hr_locations_all hl,
pay_cost_allocation_keyflex pcak,
hr_organization_information hoi_class,
(select
hoi.org_information_id,
hoi.organization_id,
hoi.rowid hoi_rowid,
hoi.org_information_context,
hoi.org_information1,
hoi.org_information2,
hoi.org_information3,
hoi.org_information4,
hoi.org_information5,
hoi.org_information6,
hoi.org_information7,
hoi.org_information8,
hoi.org_information9,
hoi.org_information10,
hoi.org_information11,
hoi.org_information12,
hoi.org_information13,
hoi.org_information14,
hoi.org_information15,
hoi.org_information16,
hoi.org_information17,
hoi.org_information18,
hoi.org_information19,
hoi.org_information20,
hic.org_classification,
nvl(hic.mandatory_flag,'N') mandatory_flag,
hitl.displayed_org_information_type,
nvl(max(hic.mandatory_flag) over (partition by hoi.organization_id,hic.org_classification),'N') classification_has_mandatory,
first_value(xxen_util.meaning(hic.org_classification,'ORG_CLASS',3)) over (partition by hoi.organization_id,hoi.org_information_context order by hoi2.org_information2 desc,nvl(hic.mandatory_flag,'N') desc,xxen_util.meaning(hic.org_classification,'ORG_CLASS',3)) first_classification_name
from
hr_organization_information hoi,
hr_org_info_types_by_class hic,
hr_org_information_types hit,
hr_org_information_types_tl hitl,
hr_organization_information hoi2,
fnd_descr_flex_contexts fdfcx
where
hoi.org_information_context<>'CLASS' and
hoi.org_information_context=hit.org_information_type and
(hit.legislation_code=:p_legislation_code or hit.legislation_code is null) and
hit.navigation_method in ('GS','GM') and
hoi.org_information_context=hic.org_information_type and
nvl(hic.enabled_flag,'Y')='Y' and
hoi2.organization_id=hoi.organization_id and
hoi2.org_information_context='CLASS' and
hoi2.org_information1=hic.org_classification and
hit.org_information_type=hitl.org_information_type and
hitl.language=userenv('lang') and
fdfcx.application_id=800 and
fdfcx.descriptive_flexfield_name='Org Developer DF' and
fdfcx.descriptive_flex_context_code=hit.org_information_type and
fdfcx.enabled_flag='Y'
) hoi
where
1=1 and
:p_upload_mode like '%' || xxen_upload.action_update and
pbg.business_group_id=:p_business_group and
pbg.organization_id=haou.business_group_id and
haou.organization_id=haout.organization_id and
haout.language=userenv('lang') and
haou.location_id=hl.location_id(+) and
case when hoi.org_classification = 'HR_ORG' then haou.cost_allocation_keyflex_id end=pcak.cost_allocation_keyflex_id(+) and
haou.organization_id=hoi_class.organization_id(+) and
hoi_class.org_information_context(+)='CLASS' and
haou.organization_id=hoi.organization_id(+) and
hoi_class.org_information1=hoi.org_classification(+) and
xxen_util.meaning(hoi_class.org_information1,'ORG_CLASS',3)=hoi.first_classification_name(+)