/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Organizations
-- Description: Master data report showing organizations, classifications, address details and additional information attributes.
-- Excel Examle Output: https://www.enginatics.com/example/per-organizations/
-- Library Link: https://www.enginatics.com/reports/per-organizations/
-- Run Report: https://demo.enginatics.com/

select
haouv0.name business_group,
ftv.territory_short_name country,
xxen_util.meaning(haouv.type,'ORG_TYPE',3) type,
haouv.name organization,
mp.organization_code,
decode(haouv.internal_external_flag,'EXT','External','INT','Internal') internal_or_external,
&col_classification
hla.location_code,
nvl2(hla.address_line_1,hla.address_line_1||' ','')||
nvl2(hla.address_line_2,hla.address_line_2||' ','')||
nvl2(hla.address_line_3,hla.address_line_3||' ','')||
nvl2(hla.town_or_city,hla.town_or_city||' ','')||
nvl2(hla.region_2,hla.region_2||' ','')||
hla.postal_code address,
&col_attributes
haouv.date_to,
haouv.organization_id
from
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv0,
hr_locations_all hla,
fnd_territories_vl ftv,
(select xxen_util.meaning(hoi.org_information1,'ORG_CLASS',3) classification, hoi.* from hr_organization_information hoi where '&enable_classification'='Y' and hoi.org_information_context='CLASS' and hoi.org_information2='Y') hoi,
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
listagg(hoi0.classification,', ') within group (order by hoi0.classification) over (partition by hoi.organization_id) info_class
from
hr_org_info_types_by_class hoitbc,
(select xxen_util.meaning(hoi.org_information1,'ORG_CLASS',3) classification, hoi.* from hr_organization_information hoi) hoi0
where
hoi.org_information_context=hoitbc.org_information_type and
hoi.organization_id=hoi0.organization_id and
hoi0.org_information_context='CLASS' and
hoi0.org_information2='Y' and
hoi0.org_information1=hoitbc.org_classification
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
haouv.business_group_id=haouv0.organization_id(+) and
haouv.location_id=hla.location_id(+) and
hla.country=ftv.territory_code(+) and
haouv.organization_id=hoi.organization_id(+) and
haouv.organization_id=x.organization_id(+) and
haouv.organization_id=mp.organization_id(+)
order by
haouv0.name,
ftv.territory_short_name,
type,
haouv.name,
hoi.classification,
x.info_class,
x.information_type,
x.org_information_id,
x.column_seq_num