/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ZX Party Tax Profiles
-- Description: E-Business Tax party tax profiles and tax registration details
-- Excel Examle Output: https://www.enginatics.com/example/zx-party-tax-profiles/
-- Library Link: https://www.enginatics.com/reports/zx-party-tax-profiles/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.meaning(zptp.party_type_code,'ZX_PTP_PARTY_TYPE',0) party_type,
coalesce(zptp.party_name,hp.party_name) party_name,
hp.party_number,
zptp.party_site_number,
case
when zptp.party_type_code in ('FIRST_PARTY','LEGAL_ESTABLISHMENT','OU') then nvl(hla.address_line_1, '')||' '||nvl(hla.address_line_2,'')||' '||nvl(hla.address_line_3,'')||' '||nvl(hla.town_or_city,'')||' '||nvl(hla.postal_code,'')||' '||nvl(hla.region_1,'')||' '||nvl(hla.region_2,'')||' '||nvl(hla.region_3,'')
when zptp.party_type_code='THIRD_PARTY_SITE' then zptp.address
when zptp.party_type_code in ('TAX_AUTHORITY','TAX_PARTNER') then nvl(hp.address1,'')||' '||nvl(hp.address2,'')||' '||nvl(hp.address3,'')||' '||nvl(hp.address4,'')||' '||nvl(hp.city,'')||' '||nvl(hp.state,'')||' '||nvl(hp.province,'')||' '||nvl(hp.postal_code,'')
end address,
(select ftv.territory_short_name from fnd_territories_vl ftv where nvl(hla.country,zptp.country)=ftv.territory_code) country,
xxen_util.meaning(decode(zptp.self_assess_flag,'Y','Y'),'YES_NO',0) self_assess_flag,
zptp.tax_classification_code tax_classification,
xxen_util.meaning(zptp.rounding_level_code,'ZX_ROUNDING_LEVEL',0) rounding_level,
xxen_util.meaning(zptp.rounding_rule_code,'ZX_ROUNDING_RULE',0) rounding_rule,
xxen_util.meaning(decode(zptp.inclusive_tax_flag,'Y','Y'),'YES_NO',0) inclusive_tax_flag,
zr.tax_regime_code,
zr.tax,
zr.tax_jurisdiction_code,
zr.registration_number,
(select hp2.party_name from hz_parties hp2 where zptp2.party_id=hp2.party_id) issuing_tax_authority,
zr.effective_from,
xfiv.activity_category business_activity_type,
xfiv.activity_code business_activity_code,
xfiv.activity_description code_description,
xxen_util.user_name(zptp.created_by) profile_created_by,
xxen_util.client_time(zptp.creation_date) profile_creation_date,
xxen_util.user_name(zptp.last_updated_by) profile_last_updated_by,
xxen_util.client_time(zptp.last_update_date) profile_last_update_date,
xxen_util.user_name(zr.created_by) registration_created_by,
xxen_util.client_time(zr.creation_date) registration_creation_date,
xxen_util.user_name(zr.last_updated_by) registration_last_updated_by,
xxen_util.client_time(zr.last_update_date) registration_last_update_date,
zptp.party_tax_profile_id,
zptp.party_id
from
(
select
coalesce(xep.name,xep2.name,haouv.name) party_name,
nvl(nvl(hps.party_site_name,hl.short_description),hl.address1||' '||hl.city||' '||hl.state) party_site_name,
hl.address1||' '||hl.city||' '||hl.state address,
hps.party_site_number,
coalesce(xep.location_id,xep2.location_id,haouv.location_id) location_id,
case when zptp.party_type_code in ('THIRD_PARTY','TAX_AUTHORITY','TAX_PARTNER') then zptp.party_id when zptp.party_type_code='THIRD_PARTY_SITE' then hps.party_id end hp_party_id,
hl.country,
zptp.*
from
zx_party_tax_profile zptp,
(
select
xep.name,
xep.party_id,
xr.location_id
from
xle_entity_profiles xep,
xle_registrations xr,
xle_jurisdictions_vl xjv
where
xep.legal_entity_id=xr.source_id and
xr.source_table='XLE_ENTITY_PROFILES' and
xr.jurisdiction_id=xjv.jurisdiction_id and
xjv.identifying_flag='Y' and
sysdate between nvl(xep.effective_from,sysdate) and nvl(xep.effective_to,sysdate) and
xep.transacting_entity_flag='Y'
) xep,
(
select
xep.name,
xep.party_id,
xr.location_id
from
xle_etb_profiles xep,
xle_registrations xr,
xle_entity_profiles xlep
where
xlep.legal_entity_id=xep.legal_entity_id and
xlep.transacting_entity_flag='Y' and
xep.establishment_id=xr.source_id(+) and
xr.source_table (+)='XLE_ETB_PROFILES' and
nvl(xr.identifying_flag,'Y')='Y' and
sysdate between nvl(xep.effective_from,sysdate) and nvl(xep.effective_to,sysdate)
) xep2,
hr_all_organization_units_vl haouv,
hz_party_sites hps,
hz_locations hl
where
1=1 and
decode(zptp.party_type_code,'FIRST_PARTY',zptp.party_id)=xep.party_id(+) and
decode(zptp.party_type_code,'LEGAL_ESTABLISHMENT',zptp.party_id)=xep2.party_id(+) and
decode(zptp.party_type_code,'OU',zptp.party_id)=haouv.organization_id(+) and
decode(zptp.party_type_code,'THIRD_PARTY_SITE',zptp.party_id)=hps.party_site_id(+) and
hps.location_id=hl.location_id(+)
) zptp,
hz_parties hp,
hr_locations_all hla,
(select zr.* from zx_registrations zr where sysdate between nvl(zr.effective_from,sysdate) and nvl(zr.effective_to,sysdate)) zr,
zx_party_tax_profile zptp2,
xle_firstparty_information_v xfiv
where
2=2 and
zptp.hp_party_id=hp.party_id(+) and
zptp.location_id=hla.location_id(+) and
zptp.party_tax_profile_id=zr.party_tax_profile_id(+) and
zr.tax_authority_id=zptp2.party_tax_profile_id(+) and
case when zptp.party_type_code in ('FIRST_PARTY','LEGAL_ESTABLISHMENT') then zptp.party_id end=xfiv.party_id(+)
order by
party_type,
party_name