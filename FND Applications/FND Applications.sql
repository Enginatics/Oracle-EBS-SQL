/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Applications
-- Description: Shows all applications, their installation status, correponding database schema and application top name
-- Excel Examle Output: https://www.enginatics.com/example/fnd-applications
-- Library Link: https://www.enginatics.com/reports/fnd-applications
-- Run Report: https://demo.enginatics.com/


select
fav.application_name,
fav.application_short_name,
fav.product_code,
fou.oracle_username,
xxen_util.meaning(decode(du.editions_enabled,'Y','Y'),'YES_NO',0) editions_enabled,
xxen_util.meaning(fpi.status,'FND_PRODUCT_STATUS',0) status,
fav.basepath,
fav.description,
fav.application_id,
du.account_status db_account_status,
du.created db_account_created,
xxen_util.user_name(fav.created_by) created_by,
xxen_util.client_time(fav.creation_date) creation_date,
(select xxen_util.meaning('Y','YES_NO',0) from xxen_report_license_key xrlk where fav.application_short_name=xrlk.custom_application_short_name) blitz_report_installation
from
fnd_application_vl fav,
fnd_product_installations fpi,
fnd_oracle_userid fou,
dba_users du
where
1=1 and
fav.application_id=fpi.application_id(+) and
fpi.oracle_id=fou.oracle_id(+) and
fou.oracle_username=du.username(+)
order by
fav.application_short_name