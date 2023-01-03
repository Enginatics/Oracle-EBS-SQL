/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: XLE Legal Entities
-- Description: Legal entities, establishments, jurisdictions and registrations
-- Excel Examle Output: https://www.enginatics.com/example/xle-legal-entities/
-- Library Link: https://www.enginatics.com/reports/xle-legal-entities/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
nvl(hg.geography_name,max(hg.geography_name) over (partition by xep.legal_entity_id)) jurisdiction_country,
xep0.name parent_legal_entity,
xep.type,
xep.name,
hp.party_number,
hla.location_code,
nvl2(hla.address_line_1,hla.address_line_1||' ','')||
nvl2(hla.address_line_2,hla.address_line_2||' ','')||
nvl2(hla.address_line_3,hla.address_line_3||' ','')||
nvl2(hla.town_or_city,hla.town_or_city||' ','')||
nvl2(hla.region_2,hla.region_2||' ','')||
hla.postal_code address,
ftv.territory_short_name country,
xep.main_establishment,
xep.effective_from,
xep.effective_to,
xxen_util.meaning(xjv.legislative_cat_code,'LEGISLATIVE_CATEGORY',222) legislative_category,
xjv.name jurisdiction_name,
xr.registered_name,
xr.registration_number,
nvl2(flvv.meaning,flvv.meaning||' ('||flvv.description||')',null) registration_code,
hp0.party_name legalauth_name,
nvl2(hl.address1,hl.address1||' ','')||
nvl2(hl.address2,hl.address2||' ','')||
nvl2(hl.city,hl.city||' ','')||
nvl2(hl.state,hl.state||' ','')||
nvl2(hl.country,hl.country||' ','')||
hl.postal_code legalauth_address
from
(
select
'Legal Entity' type,
xep.party_id,
xep.legal_entity_id,
'XLE_ENTITY_PROFILES' source_table,
xep.legal_entity_id source_id,
xep.name,
xep.effective_from,
xep.effective_to,
null main_establishment
from
xle_entity_profiles xep
union all
select
'Establishment' type,
xestp.party_id,
xestp.legal_entity_id,
'XLE_ETB_PROFILES' source_table,
xestp.establishment_id source_id,
xestp.name,
xestp.effective_from,
xestp.effective_to,
decode(xestp.main_establishment_flag,'Y','Yes') main_establishment
from
xle_entity_profiles xep,
xle_etb_profiles xestp
where
xep.legal_entity_id=xestp.legal_entity_id
) xep,
hz_parties hp,
xle_entity_profiles xep0,
xle_registrations xr,
xle_jurisdictions_vl xjv,
hz_geographies hg,
fnd_lookup_values_vl flvv,
hr_locations_all hla,
fnd_territories_vl ftv,
hz_parties hp0,
hz_party_sites hps,
hz_locations hl
where
xep.party_id=hp.party_id and
xep.legal_entity_id=xep0.legal_entity_id and
xep.source_table=xr.source_table(+) and
xep.source_id=xr.source_id(+) and
xr.jurisdiction_id=xjv.jurisdiction_id(+) and
xjv.geography_id=hg.geography_id(+) and
xjv.registration_code_le=flvv.lookup_code(+) and
flvv.lookup_type(+)='XLE_REG_CODE' and
flvv.view_application_id(+)=204 and
flvv.security_group_id(+)=0 and
xr.location_id=hla.location_id(+) and
hla.country=ftv.territory_code(+) and
xr.issuing_authority_id=hp0.party_id(+) and
xr.issuing_authority_site_id=hps.party_site_id(+) and
hps.location_id=hl.location_id(+)
) x
where
1=1
order by
x.jurisdiction_country,
x.parent_legal_entity,
x.type desc,
x.main_establishment,
x.effective_to desc,
x.party_number,
x.legislative_category,
x.registration_number