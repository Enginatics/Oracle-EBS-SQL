/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Applications
-- Description: Shows all applications, their installation status, correponding database schema, application top name and audit status
-- Excel Examle Output: https://www.enginatics.com/example/fnd-applications/
-- Library Link: https://www.enginatics.com/reports/fnd-applications/
-- Run Report: https://demo.enginatics.com/

select
fav.application_name,
fav.application_short_name,
fav.product_code,
fou.oracle_username,
(select fou2.oracle_username from fnd_data_group_units fdgu, fnd_oracle_userid fou2 where fav.application_id=fdgu.application_id and fdgu.data_group_id=0 and fdgu.oracle_id=fou2.oracle_id) datagroup_username,
xxen_util.yes(du.editions_enabled) editions_enabled,
xxen_util.meaning(fpi.status,'FND_PRODUCT_STATUS',0) status,
fpi.patch_level,
fav.basepath,
fav.description,
xxen_util.meaning(decode(fas.state,'R','Y'),'YES_NO',0) audit_enabled,
fav.application_id,
du.account_status db_account_status,
du.created db_account_created,
xxen_util.meaning(fmpi.status,'YES_NO',0) multi_org_status,
xxen_util.user_name(fav.created_by) created_by,
xxen_util.client_time(fav.creation_date) creation_date,
xxen_util.user_name(fav.last_updated_by) last_updated_by,
xxen_util.client_time(fav.last_update_date) last_update_date,
(select xxen_util.meaning('Y','YES_NO',0) from xxen_report_license_key xrlk where fav.application_short_name=xrlk.custom_application_short_name) blitz_report_installation
from
fnd_application_vl fav,
fnd_product_installations fpi,
fnd_oracle_userid fou,
dba_users du,
fnd_audit_schemas fas,
fnd_mo_product_init fmpi
where
1=1 and
fav.application_id=fpi.application_id(+) and
fpi.oracle_id=fou.oracle_id(+) and
fou.oracle_username=du.username(+) and
fou.oracle_id=fas.oracle_id(+) and
fav.application_short_name=fmpi.application_short_name(+)
order by
fav.application_short_name