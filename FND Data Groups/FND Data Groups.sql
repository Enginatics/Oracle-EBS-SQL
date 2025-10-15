/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Data Groups
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/fnd-data-groups/
-- Library Link: https://www.enginatics.com/reports/fnd-data-groups/
-- Run Report: https://demo.enginatics.com/

select
fdg.data_group_name,
fdg.description data_group_description,
fav.application_name application,
fou.oracle_username,
xxen_util.user_name(fdgu.created_by) created_by,
xxen_util.client_time(fdgu.creation_date) creation_date,
xxen_util.user_name(fdgu.last_updated_by) last_updated_by,
xxen_util.client_time(fdgu.last_update_date) last_update_date,
fdg.data_group_id
from
fnd_data_groups fdg,
fnd_data_group_units fdgu,
fnd_application_vl fav,
fnd_oracle_userid fou
where
1=1 and
fdg.data_group_id=fdgu.data_group_id and
fdgu.application_id=fav.application_id and
fdgu.oracle_id=fou.oracle_id
order by
fdg.data_group_name,
fdg.description,
fav.application_name