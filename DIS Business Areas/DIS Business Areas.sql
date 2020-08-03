/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Business Areas
-- Description: Summary report showing Discoverer business areas, with an access account showing how many times a business area's folder was used within the past x number of days.
-- Excel Examle Output: https://www.enginatics.com/example/dis-business-areas/
-- Library Link: https://www.enginatics.com/reports/dis-business-areas/
-- Run Report: https://demo.enginatics.com/

select
eb.ba_name business_area,
eb.ba_description business_area_description,
eb.ba_developer_key business_area_identifier,
eqs.access_count,
eqs.last_accessed,
(select count(*) from &eul.eul5_ba_obj_links ebol where eb.ba_id=ebol.bol_ba_id) folder_count,
xxen_util.dis_user_name(eb.ba_created_by) created_by,
xxen_util.client_time(eb.ba_created_date) creation_date,
xxen_util.dis_user_name(eb.ba_updated_by) last_updated_by,
xxen_util.client_time(eb.ba_updated_date) last_update_date
from
&eul.eul5_bas eb,
(
select
eqs.bol_ba_id,
count(*) access_count,
max(eqs.qs_created_date) last_accessed
from
(
select distinct
eqs.qs_id,
ebol.bol_ba_id,
eqs.qs_created_date
from
(
select
trim(regexp_substr(eqs.qs_object_use_key,'[^\.]+',1,rowgen.column_value)) obj_id,
eqs.*
from
&eul.eul5_qpp_stats eqs,
table(xxen_util.rowgen(regexp_count(eqs.qs_object_use_key,'\.')+1)) rowgen
where
2=2
) eqs,
&eul.eul5_ba_obj_links ebol
where
translate(eqs.obj_id,'x0123456789','x') is null and
eqs.obj_id=ebol.bol_obj_id
) eqs
group by
eqs.bol_ba_id
) eqs
where
1=1 and
eb.ba_id=eqs.bol_ba_id(+)
order by
eb.ba_id