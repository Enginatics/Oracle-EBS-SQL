/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Organizations
-- Description: Organizations, classifications, address details and additional information attributes.
-- Excel Examle Output: https://www.enginatics.com/example/per-organizations
-- Library Link: https://www.enginatics.com/reports/per-organizations
-- Run Report: https://demo.enginatics.com/


select
haout0.name business_group,
ftv.territory_short_name country,
flv1.meaning type,
haout.name organization,
mp.organization_code,
decode(haou.internal_external_flag,'EXT','External','INT','Internal') internal_or_external,
&col_classification
hla.location_code,
nvl2(hla.address_line_1,hla.address_line_1||' ','')||
nvl2(hla.address_line_2,hla.address_line_2||' ','')||
nvl2(hla.address_line_3,hla.address_line_3||' ','')||
nvl2(hla.town_or_city,hla.town_or_city||' ','')||
nvl2(hla.region_2,hla.region_2||' ','')||
hla.postal_code address,
&col_attributes
haou.organization_id
from
hr_all_organization_units haou,
hr_all_organization_units haou0,
hr_all_organization_units_tl haout,
hr_all_organization_units_tl haout0,
fnd_lookup_values flv1,
hr_locations_all hla,
fnd_territories_vl ftv,
(select hoi.* from hr_organization_information hoi where '&enable_classification'='Y' and hoi.org_information_context='CLASS' and hoi.org_information2='Y') hoi,
fnd_lookup_values flv2,
(
select
fdfcuv.application_id,
fdfcuv.descriptive_flexfield_name,
fdfcuv.application_column_name,
fdfcuv.column_seq_num,
fdfcuv.form_left_prompt attribute_name,
decode(fdfcuv.application_column_name,
'ORG_INFORMATION1',hoi.org_information1,
'ORG_INFORMATION2',hoi.org_information2,
'ORG_INFORMATION3',hoi.org_information3,
'ORG_INFORMATION4',hoi.org_information4,
'ORG_INFORMATION5',hoi.org_information5,
'ORG_INFORMATION6',hoi.org_information6,
'ORG_INFORMATION7',hoi.org_information7,
'ORG_INFORMATION8',hoi.org_information8,
'ORG_INFORMATION9',hoi.org_information9,
'ORG_INFORMATION10',hoi.org_information10,
'ORG_INFORMATION11',hoi.org_information11,
'ORG_INFORMATION12',hoi.org_information12,
'ORG_INFORMATION13',hoi.org_information13,
'ORG_INFORMATION14',hoi.org_information14,
'ORG_INFORMATION15',hoi.org_information15,
'ORG_INFORMATION16',hoi.org_information16,
'ORG_INFORMATION17',hoi.org_information17,
'ORG_INFORMATION18',hoi.org_information18,
'ORG_INFORMATION19',hoi.org_information19,
'ORG_INFORMATION20',hoi.org_information20
) system_value,
(select distinct
listagg(flv.meaning,', ') within group (order by flv.meaning) over (partition by hoi.organization_id) info_class
from
hr_org_info_types_by_class hoitbc,
hr_organization_information hoi0,
fnd_lookup_values flv
where
hoi.org_information_context=hoitbc.org_information_type and
hoi.organization_id=hoi0.organization_id and
hoi0.org_information_context='CLASS' and
hoi0.org_information2='Y' and
hoi0.org_information1=hoitbc.org_classification and
hoi0.org_information1=flv.lookup_code(+) and
flv.lookup_type(+)='ORG_CLASS' and
flv.language(+)=userenv('lang') and
flv.view_application_id(+)=3 and
flv.security_group_id(+)=0
) info_class,
hoit.displayed_org_information_type information_type,
hoi.*,
hoi.rowid row_id
from
hr_organization_information hoi,
fnd_descr_flex_col_usage_vl fdfcuv,
hr_org_information_types hoit
where
2=2 and
'&enable_attributes'='Y' and
hoi.org_information_context<>'CLASS' and
hoi.org_information_context=fdfcuv.descriptive_flex_context_code and
fdfcuv.application_id=800 and
fdfcuv.descriptive_flexfield_name='Org Developer DF' and
hoi.org_information_context=hoit.org_information_type(+)
) x,
mtl_parameters mp
where
1=1 and
haou.business_group_id=haou0.organization_id(+) and
haou.organization_id=haout.organization_id and
haou0.organization_id=haout0.organization_id and
haout.language=userenv('lang') and
haout0.language=userenv('lang') and
haou.organization_id=mp.organization_id(+) and
haou.type=flv1.lookup_code(+) and
flv1.lookup_type(+)='ORG_TYPE' and
flv2.lookup_type(+)='ORG_CLASS' and
flv1.language(+)=userenv('lang') and
flv2.language(+)=userenv('lang') and
flv1.view_application_id(+)=3 and
flv2.view_application_id(+)=3 and
flv1.security_group_id(+)=0 and
flv2.security_group_id(+)=0 and
haou.location_id=hla.location_id(+) and
hla.country=ftv.territory_code(+) and
haou.organization_id=hoi.organization_id(+) and
hoi.org_information1=flv2.lookup_code(+) and
haou.organization_id=x.organization_id(+)
order by
haou0.name,
ftv.territory_short_name,
flv1.meaning,
haou.name,
flv2.meaning,
x.info_class,
x.information_type,
x.org_information_id,
x.column_seq_num