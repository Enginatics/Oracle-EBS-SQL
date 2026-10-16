/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Workbook Conversion Selection
-- Description: Lists the Discoverer workbook xmls uploaded to Blitz Report (Setup>Tools>Import>XML Upload), enriched with information supporting the decision which workbooks to convert: latest run date, run count and distinct users from the end user layer's usage statistics, last update and creation date from the workbook definition, owner, description and sheet count.
-- Set Convert Workbook to Yes for each workbook that should be converted to Blitz Report and upload the file. The selection is stored on the staged workbook xml, and the 'Blitz Report Discoverer Import' concurrent program converts the selected workbooks.
-- With the Submit Import parameter set to Yes, the upload submits the 'Blitz Report Discoverer Import' itself after storing the selection, waits for it to complete, and reports per workbook how many Blitz reports and templates exist for its worksheets. A workbook whose worksheet folder sets could not all be converted is reported as an error row.
-- The usage statistics are informational only: workbooks without any usage history are listed as well, with an empty run count and last run date.
-- The migration process is described in the following link: https://www.enginatics.com/blog/discoverer-replacement-with-blitz-report/
-- Excel Example Output: https://www.enginatics.com/example/dis-workbook-conversion-selection/
-- Library Link: https://www.enginatics.com/reports/dis-workbook-conversion-selection/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
xxen_util.yes(x.convert_flag) convert_workbook,
null modified_columns_,
x.workbook,
x.owner,
x.workbook_description,
x.sheet_count,
xxen_util.client_time(eqs.last_run_date) last_run_date,
eqs.run_count,
eqs.distinct_users,
xxen_util.yes(x.in_eul) exists_in_eul,
xxen_util.yes(decode(x.convert_flag,'C','Y')) converted,
conv.blitz_report,
xxen_util.client_time(conv.blitz_report_created) blitz_report_created,
xxen_util.client_time(conv.blitz_report_updated) blitz_report_updated,
xxen_util.yes(conv.folder_set_converted) folder_set_converted,
xxen_util.client_time(x.doc_updated_date) workbook_last_updated,
x.doc_updated_by workbook_updated_by,
xxen_util.client_time(x.doc_created_date) workbook_created,
x.doc_created_by workbook_created_by,
xxen_util.client_time(x.eex_upload_date) eex_upload_date,
xxen_util.client_time(x.last_update_date) last_updated,
x.doc_id workbook_id,
x.eul,
:submit_import submit_import,
:report_name_prefix report_name_prefix,
rownum upload_row
from
(
select
xdwx.convert_flag,
nvl(ed.doc_name,xmlcast(xmlquery('/EndUserLayerExport/Document/@Name' passing xdwx.xml returning content) as varchar2(100))) workbook,
nvl(xxen_util.dis_user_name(ed.doc_eu_id,:eul),xxen_util.dis_user_name(xmlcast(xmlquery('/EndUserLayerExport/Document/ElementRef[@Type="EulUser"]/UniqueIdent/@Username' passing xdwx.xml returning content) as varchar2(64)),null,:eul)) owner,
nvl(ed.doc_description,xmlcast(xmlquery('/EndUserLayerExport/Document/@Description' passing xdwx.xml returning content) as varchar2(4000))) workbook_description,
xmlcast(xmlquery('count(/EndUserLayerExport/Document/Workbook/Sheet)' passing xdwx.xml returning content) as number) sheet_count,
nvl2(ed.doc_id,'Y',null) in_eul,
ed.doc_updated_date,
ed.doc_updated_by,
ed.doc_created_date,
ed.doc_created_by,
xdwx.creation_date eex_upload_date,
xdwx.last_update_date,
xdwx.doc_id,
xdwx.eul
from
xxen_discoverer_workbook_xmls xdwx,
&eul.eul5_documents ed
where
upper(xdwx.eul)=upper(:eul) and
xdwx.doc_id=ed.doc_id(+)
) x,
(
select
upper(regexp_replace(eqs.qs_doc_name,'\.dis$',null,1,1,'i')) doc_name_,
max(eqs.qs_created_date) last_run_date,
count(*) run_count,
count(distinct eqs.qs_created_by) distinct_users
from
&eul.eul5_qpp_stats eqs
group by
upper(regexp_replace(eqs.qs_doc_name,'\.dis$',null,1,1,'i'))
) eqs,
(
select
y.doc_id,
listagg(y.report_name,chr(10)) within group (order by y.report_name) blitz_report,
min(y.creation_date) blitz_report_created,
max(y.last_update_date) blitz_report_updated,
max(y.converted) folder_set_converted
from
(
select distinct
z.doc_id,
xrv.report_name,
xrv.creation_date,
xrv.last_update_date,
nvl2(xrv.report_name,'Y',null) converted
from
(
select /*+ no_merge */
xds.doc_id,
xxen_xdo.sheet_object_use_key(xds.eul,xds.doc_id,xds.sheet_name) object_use_key
from
(
select /*+ no_merge */ distinct
xds.eul,
xds.doc_id,
xds.sheet_name
from
xxen_discoverer_sheets xds,
xxen_discoverer_workbook_xmls xdwx
where
upper(xds.eul)=upper(:eul) and
xds.eul=xdwx.eul and
xds.doc_id=xdwx.doc_id
) xds
where
xxen_xdo.helper_sheet(xds.eul,xds.doc_id,xds.sheet_name) is null
) z,
(
select
regexp_substr(xrv.description,chr(10)||'Object IDs: (.+)'||chr(10),1,1,null,1) object_use_key,
xrv.report_name,
xrv.creation_date,
xrv.last_update_date
from
xxen_reports_v xrv
where
xrv.description like '%'||chr(10)||'Object IDs: %'||chr(10)||'EUL: '||:eul
) xrv
where
z.object_use_key is not null and
z.object_use_key=xrv.object_use_key(+)
) y
group by
y.doc_id
) conv
where
1=1 and
upper(regexp_replace(x.workbook,'\.dis$',null,1,1,'i'))=eqs.doc_name_(+) and
x.doc_id=conv.doc_id(+)
