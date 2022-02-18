/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Organization Access
-- Description: Master data report for Inventory orgs, with org code, application, responsibility and creation information. Allows BR100 creation.
-- Excel Examle Output: https://www.enginatics.com/example/inv-organization-access/
-- Library Link: https://www.enginatics.com/reports/inv-organization-access/
-- Run Report: https://demo.enginatics.com/

select
oav.organization_code,
oav.organization_name,
oav.application_name application,
oav.responsibility_name responsibility,
oav.comments,
xxen_util.user_name(oav.created_by) created_by,
xxen_util.client_time(oav.creation_date) creation_date,
xxen_util.user_name(oav.last_updated_by) last_updated_by,
xxen_util.client_time(oav.last_update_date) last_update_date
from
org_access_v oav
where
1=1
order by
oav.organization_code,
oav.organization_name,
oav.application_name,
oav.responsibility_name