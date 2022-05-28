/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Access Privileges
-- Description: Discoverer access privileges
-- Excel Examle Output: https://www.enginatics.com/example/dis-access-privileges/
-- Library Link: https://www.enginatics.com/reports/dis-access-privileges/
-- Run Report: https://demo.enginatics.com/

select
eap.user_type,
xxen_util.dis_user_name(eap.username) user_name,
decode(eap.ap_type,'GBA','Business Area','GD','Workbook','GP','Privilege',eap.ap_type) access_type,
coalesce(eb.ba_name,ed.doc_name,
decode(eap.gp_app_id,
1000,'Desktop and Plus',
1001,'Create/Edit Query',
1002,'Item Drill',
1003,'Drill Out',
1004,'Grant Workbook',
1005,'Collect Query Statistics',
1006,'Administration',
1007,'Set Privilege',
1008,'Create/Edit Business Area',
1009,'Format Business Area',
1010,'Create/Edit Summaries',
1012,'Schedule Workbooks',
1014,'Save Workbooks to Database',
1015,'Manage Scheduled Workbooks',
1024,'Create link',
eap.gp_app_id
)
,eap.ap_type) name,
nvl(eb.ba_developer_key,ed.doc_developer_key) identifier,
xxen_util.dis_user_name(ed.doc_eu_id,:eul) owner,
nvl(eqs1.access_count,eqs2.access_count) access_count,
nvl(eqs1.last_accessed,eqs2.last_accessed) last_accessed,
xxen_util.meaning(decode(eap.ap_priv_level,1,'Y'),'YES_NO',0) allow_administration,
xxen_util.dis_user_name(eap.ap_created_by) created_by,
eap.ap_created_date creation_date,
xxen_util.dis_user_name(eap.ap_updated_by) last_updated_by,
eap.ap_updated_date last_update_date
from
(
select xxen_util.dis_user_type(eap.ap_eu_id,:eul) user_type, xxen_util.dis_user(eap.ap_eu_id,:eul) username, eap.* from &eul.eul5_access_privs eap union all
select
xxen_util.dis_user_type(ed.doc_eu_id,:eul) user_type,
xxen_util.dis_user(ed.doc_eu_id,:eul) username,
null ap_id,
'Workbook Owner' ap_type,
null ap_eu_id,
null ap_priv_level,
null gp_app_id,
null gba_ba_id,
ed.doc_id gd_doc_id,
null element_state,
ed.doc_created_by ap_created_by,
ed.doc_created_date ap_created_date,
xxen_util.dis_user_name(ed.doc_updated_by) last_updated_by,
ed.doc_updated_date last_update_date,
null notm
from
&eul.eul5_documents ed
) eap,
&eul.eul5_bas eb,
&eul.eul5_documents ed,
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
) eqs1,
(
select
eqs.qs_doc_name,
count(*) access_count,
max(eqs.qs_created_date) last_accessed
from
&eul.eul5_qpp_stats eqs
where
2=2
group by
eqs.qs_doc_name
) eqs2,
(
select distinct
furg.responsibility_id,
furg.responsibility_application_id application_id
from
&eul.eul5_qpp_stats eqs,
fnd_user_resp_groups furg
where
2=2 and
translate(substr(eqs.qs_created_by,2),'x0123456789','x') is null and
substr(eqs.qs_created_by,2)=furg.user_id
) eqs3,
(
select distinct
to_number(substr(eqs.qs_created_by,2)) user_id
from
&eul.eul5_qpp_stats eqs
where
2=2 and
translate(substr(eqs.qs_created_by,2),'x0123456789','x') is null
) eqs4
where
1=1 and
not (eap.ap_type='GP' and eap.gp_app_id in (1013,1018)) and
eap.gba_ba_id=eb.ba_id(+) and
eap.gd_doc_id=ed.doc_id(+) and
eap.gba_ba_id=eqs1.bol_ba_id(+) and
ed.doc_name=eqs2.qs_doc_name(+) and
decode(eap.user_type,'Responsibility',substr(eap.username,2,instr(eap.username,'#',1,2)-2))=eqs3.responsibility_id(+) and
decode(eap.user_type,'Responsibility',substr(eap.username,instr(eap.username,'#',1,2)+1))=eqs3.application_id(+) and
decode(eap.user_type,'User',substr(eap.username,instr(eap.username,'#')+1))=eqs4.user_id(+)
order by
access_type,
user_name,
name,
identifier