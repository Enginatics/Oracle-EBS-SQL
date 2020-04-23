/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
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
xxen_util.user_name(furgd.user_id) user_name,
frv.responsibility_name responsibility,
fav.application_name application,
furgd.start_date,
furgd.end_date,
xxen_util.user_name(furgd.created_by) assigned_by,
xxen_util.client_time(furgd.creation_date) assignment_date,
xxen_util.user_name(furgd.last_updated_by) last_updated_by,
xxen_util.client_time(furgd.last_update_date) last_update_date,
fu.start_date user_start_date,
fu.end_date user_end_date,
xxen_util.user_name(fu.created_by) user_created_by,
xxen_util.client_time(fu.creation_date) user_creation_date,
xxen_util.user_name(fu.last_updated_by) user_last_updated_by,
xxen_util.client_time(fu.last_update_date) user_last_update_date
from
fnd_user_resp_groups_direct furgd,
fnd_user fu,
fnd_responsibility_vl frv,
fnd_application_vl fav
where
1=1 and
furgd.user_id=fu.user_id and
furgd.responsibility_application_id=frv.application_id and
furgd.responsibility_id=frv.responsibility_id and
furgd.responsibility_application_id=fav.application_id
order by
case when nvl(fu.end_date,sysdate)>=trunc(sysdate) then 1 else 2 end,
fu.user_name,
case when nvl(furgd.end_date,sysdate)>=trunc(sysdate) then 1 else 2 end,
frv.responsibility_name