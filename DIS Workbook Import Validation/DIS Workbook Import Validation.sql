/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Workbook Import Validation
-- Description: Discoverer workbook migraton validation report showing the workbooks, sheets, how ofthen they were accessed within the given number of days, columns for the number of records in the different import process tables, and the created blitz report and template information.
-- Excel Examle Output: https://www.enginatics.com/example/dis-workbook-import-validation/
-- Library Link: https://www.enginatics.com/reports/dis-workbook-import-validation/
-- Run Report: https://demo.enginatics.com/

select
x.owner,
x.workbook,
x.description,
x.workbook_exists,
x.sheet,
x.access_count,
x.last_accessed,
x.last_accessed_by,
x.object_use_key,
x.last_updated_by,
x.last_update_date,
x.doc_id,
xxen_util.meaning(nvl2(xdwx.doc_id,'Y',null),'YES_NO',0) eex_uploaded,
xdw.count flattened_count,
xrtv.report_name,
xrtv.template_name,
xrtv.description template_description
from
(
select
nvl(xxen_util.dis_user_name(ed.doc_eu_id,:eul),xxen_util.user_name(eqs.qs_doc_owner_)) owner,
nvl(ed.doc_name,eqs.qs_doc_name) workbook,
xxen_util.meaning(nvl2(ed.doc_name,'Y',null),'YES_NO',0) workbook_exists,
eqs.qs_doc_details sheet,
eqs.access_count,
eqs.last_accessed,
xxen_util.dis_user_name(eqs.last_accessed_by) last_accessed_by,
eqs.qs_object_use_key object_use_key,
xxen_util.dis_user_name(ed.doc_updated_by) last_updated_by,
ed.doc_updated_date last_update_date,
ed.doc_id,
ed.doc_description description
from
&eul.eul5_documents ed
&full join
(
select distinct
eqs.qs_doc_name,
eqs.qs_doc_owner_,
eqs.qs_doc_details,
count(*) access_count,
max(eqs.qs_created_date) last_accessed,
max(eqs.qs_created_by) keep (dense_rank first order by eqs.qs_created_date desc) last_accessed_by,
eqs.qs_object_use_key
from
(select x.*
from
(
select
max(eqs.qs_object_use_key) keep (dense_rank last order by eqs.qs_id) over (partition by eqs.qs_doc_name,eqs.qs_doc_details,eqs.qs_doc_owner_) max_object_use_key,
eqs.*
from
(select upper(eqs.qs_doc_owner) qs_doc_owner_, eqs.* from &eul.eul5_qpp_stats eqs where 2=2 &or_owner_restriction) eqs
) x
where
x.qs_object_use_key=x.max_object_use_key
) eqs
group by
eqs.qs_doc_name,
eqs.qs_doc_owner_,
eqs.qs_doc_details,
eqs.qs_object_use_key
) eqs
on
ed.doc_name=eqs.qs_doc_name and
xxen_util.dis_user_name(ed.doc_eu_id,:eul,'N')=eqs.qs_doc_owner_
) x,
(select xdwx.* from xxen_discoverer_workbook_xmls xdwx where xdwx.eul=:eul) xdwx,
(select xdw.doc_id, count(*) count from xxen_discoverer_workbooks xdw where xdw.eul=:eul group by xdw.eul, xdw.doc_id) xdw,
(select regexp_substr(xrtv.description,chr(10)||'Sheet: (.+)',1,1,null,1) sheet, regexp_substr(xrtv.description,chr(10)||'Doc Id: (\d+)',1,1,null,1) doc_id, xrtv.* from xxen_report_templates_v xrtv where regexp_substr(xrtv.report_description,chr(10)||'EUL: (\w+)',1,1,null,1)=:eul) xrtv
where
1=1 and
x.doc_id=xdwx.doc_id(+) and
x.doc_id=xdw.doc_id(+) and
x.doc_id=xrtv.doc_id(+) and
x.sheet=xrtv.sheet(+)
order by
x.owner,
x.workbook,
x.sheet