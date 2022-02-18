/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND User Responsibilities
-- Description: Similar to report FND Access Control, but also shows inactive / end dated user responsibilities while FND Access Control shows currently active assigned responsibilities only.
Same as Oracle's 'Active Users' report.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-user-responsibilities/
-- Library Link: https://www.enginatics.com/reports/fnd-user-responsibilities/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.user_name(furg.user_id) user_name,
frv.responsibility_name responsibility,
fav.application_name application,
furg.start_date,
furg.end_date,
furg.type,
xxen_util.user_name(furg.created_by) assigned_by,
xxen_util.client_time(furg.creation_date) assignment_date,
xxen_util.user_name(furg.last_updated_by) last_updated_by,
xxen_util.client_time(furg.last_update_date) last_update_date,
fu.start_date user_start_date,
fu.end_date user_end_date,
xxen_util.user_name(fu.created_by) user_created_by,
xxen_util.client_time(fu.creation_date) user_creation_date,
xxen_util.user_name(fu.last_updated_by) user_last_updated_by,
xxen_util.client_time(fu.last_update_date) user_last_update_date
from
(
select 'Direct' type, furgd.* from fnd_user_resp_groups_direct furgd union all
select 'Indirect' type, furgi.* from fnd_user_resp_groups_indirect furgi
) furg,
fnd_user fu,
fnd_responsibility_vl frv,
fnd_application_vl fav
where
1=1 and
furg.user_id=fu.user_id and
furg.responsibility_application_id=frv.application_id and
furg.responsibility_id=frv.responsibility_id and
furg.responsibility_application_id=fav.application_id
order by
case when nvl(fu.end_date,sysdate)>=trunc(sysdate) then 1 else 2 end,
fu.user_name,
case when nvl(furg.end_date,sysdate)>=trunc(sysdate) then 1 else 2 end,
frv.responsibility_name