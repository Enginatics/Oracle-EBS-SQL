/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PER Security Profiles
-- Description: Security profiles and operating units that they give access to.
-- Excel Examle Output: https://www.enginatics.com/example/per-security-profiles/
-- Library Link: https://www.enginatics.com/reports/per-security-profiles/
-- Run Report: https://demo.enginatics.com/

select
psp.security_profile_name,
(select haouv0.name from hr_all_organization_units_vl haouv0 where psp.business_group_id=haouv0.organization_id) business_group,
haouv.name operating_unit,
ftv.territory_short_name country,
hla.location_code,
decode(psp.org_security_mode,'NONE','View all (no security)','HIER','Organization hierarchy and/or organization list','OU','Single operating unit','OU_INV','Operating unit and inventory organizations') organization_security_mode,
xxen_util.meaning(psp.view_all_flag,'YES_NO',0) view_all_operating_units,
xxen_util.user_name(psp.created_by) created_by,
xxen_util.client_time(psp.creation_date) creation_date,
xxen_util.user_name(psp.last_updated_by) last_updated_by,
xxen_util.client_time(psp.last_update_date) last_update_date,
psp.security_profile_id
from
(
select
nvl(pol.organization_id,nvl(hou.organization_id,hou0.organization_id)) operating_unit_id,
psp.*
from
per_security_profiles psp,
(select pol.* from per_organization_list pol, hr_operating_units hou where pol.organization_id=hou.organization_id and hou.usable_flag is null) pol,
(select hou.* from hr_operating_units hou where hou.usable_flag is null) hou,
(select -1 view_all, hou.* from hr_operating_units hou where hou.usable_flag is null) hou0
where
decode(psp.view_all_flag,'N',psp.security_profile_id)=pol.security_profile_id(+) and
decode(psp.view_all_flag,'Y',psp.business_group_id)=hou.business_group_id(+) and
decode(psp.view_all_flag,'Y',nvl2(psp.business_group_id,null,-1))=hou0.view_all(+)
) psp,
hr_all_organization_units_vl haouv,
hr_locations_all hla,
fnd_territories_vl ftv
where
1=1 and
psp.operating_unit_id=haouv.organization_id(+) and
haouv.location_id=hla.location_id(+) and
hla.country=ftv.territory_code(+)
order by
psp.security_profile_name,
ftv.territory_short_name,
haouv.name