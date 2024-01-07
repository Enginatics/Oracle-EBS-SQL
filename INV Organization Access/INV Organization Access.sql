/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Organization Access
-- Description: Inventory organization access for all responsibilities, either through hr security profile or individual org_access assignment.
-- Excel Examle Output: https://www.enginatics.com/example/inv-organization-access/
-- Library Link: https://www.enginatics.com/reports/inv-organization-access/
-- Run Report: https://demo.enginatics.com/

select
oav.organization_code,
oav.organization_name,
(select xxen_util.meaning('Y','YES_NO',0) from mtl_parameters mp where oav.organization_id=mp.organization_id and mp.organization_id=mp.master_organization_id) is_master_org,
fav.application_name application,
frv.responsibility_name responsibility,
oa.comments,
xxen_util.user_name(oa.created_by) created_by,
xxen_util.client_time(oa.creation_date) creation_date,
xxen_util.user_name(oa.last_updated_by) last_updated_by,
xxen_util.client_time(oa.last_update_date) last_update_date
from
org_access_view oav,
org_access oa,
fnd_responsibility_vl frv,
fnd_application_vl fav
where
1=1 and
oav.organization_id=oa.organization_id(+) and
oav.responsibility_id=oa.responsibility_id(+) and
oav.resp_application_id=oa.resp_application_id(+) and
oav.responsibility_id=frv.responsibility_id and
oav.resp_application_id=frv.application_id and
oav.resp_application_id=fav.application_id
order by
oav.organization_code,
oav.organization_name,
fav.application_name,
frv.responsibility_name