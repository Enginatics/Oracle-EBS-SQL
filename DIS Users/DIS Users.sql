/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Users
-- Description: Discoverer end user layer users of different types (application user, responsibility, database user)
-- Excel Examle Output: https://www.enginatics.com/example/dis-users
-- Library Link: https://www.enginatics.com/reports/dis-users
-- Run Report: https://demo.enginatics.com/


select
eeu.eu_id,
xxen_util.dis_user_type(eeu.eu_username) type,
xxen_util.dis_user_name(eeu.eu_username) name,
eqs.access_count,
eqs.last_accessed,
xxen_util.dis_user_name(eeu.eu_created_by) created_by,
eeu.eu_created_date creation_date,
xxen_util.dis_user_name(eeu.eu_updated_by) last_updated_by,
eeu.eu_updated_date last_update_date
from
&eul.eul5_eul_users eeu,
(
select
eqs.qs_created_by,
count(*) access_count,
max(eqs.qs_created_date) last_accessed
from
&eul.eul5_qpp_stats eqs
where
2=2
group by
eqs.qs_created_by
) eqs
where
1=1 and
eeu.eu_username=eqs.qs_created_by(+)
order by
eeu.eu_updated_date desc