/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Workbook Import Validation
-- Description: Discoverer workbook migration validation report showing every workbook and worksheet next to its conversion state: whether the workbook xml is uploaded, selected for conversion or converted, the object use key derived from the workbook xml, and the migrated Blitz report and template.
-- Workbooks known only from the end user layer and workbooks whose xml was uploaded after deletion from Discoverer are both listed, so gaps in either direction are visible. The Not yet imported parameter restricts to worksheets without a migrated template.
-- The Accessed after parameter restricts the output to workbooks with recorded usage since that date, the same scope the DIS Workbook Export Script lists for export; left blank, every workbook is shown including those never accessed. The usage statistics columns show access count, last accessed date and user within the same window.
-- Excel Example Output: https://www.enginatics.com/example/dis-workbook-import-validation/
-- Library Link: https://www.enginatics.com/reports/dis-workbook-import-validation/
-- Run Report: https://demo.enginatics.com/

select
y.owner,
y.workbook,
y.description,
y.workbook_exists,
y.eex_uploaded,
y.selected_for_conversion,
y.converted,
y.sheet,
y.object_use_key,
xrv.report_name,
xrtv.template_name,
xrtv.description template_description,
eqs.access_count,
eqs.last_accessed,
eqs.last_accessed_by,
y.last_updated_by,
y.last_update_date,
y.doc_id,
xdw.count flattened_count
from
(
select
x.*,
xds.sheet_name sheet,
xds.object_use_key
from
(
select
nvl(xxen_util.dis_user_name(ed.doc_eu_id,:eul),xxen_util.dis_user_name(xmlcast(xmlquery('/EndUserLayerExport/Document/ElementRef[@Type="EulUser"]/UniqueIdent/@Username' passing xdwx.xml returning content) as varchar2(64)),null,:eul)) owner,
nvl(ed.doc_name,xmlcast(xmlquery('/EndUserLayerExport/Document/@Name' passing xdwx.xml returning content) as varchar2(100))) workbook,
nvl(ed.doc_description,xmlcast(xmlquery('/EndUserLayerExport/Document/@Description' passing xdwx.xml returning content) as varchar2(4000))) description,
xxen_util.meaning(nvl2(ed.doc_id,'Y',null),'YES_NO',0) workbook_exists,
xxen_util.meaning(nvl2(xdwx.doc_id,'Y',null),'YES_NO',0) eex_uploaded,
xxen_util.yes(decode(xdwx.convert_flag,'Y','Y')) selected_for_conversion,
xxen_util.yes(decode(xdwx.convert_flag,'C','Y')) converted,
xxen_util.dis_user_name(ed.doc_updated_by) last_updated_by,
ed.doc_updated_date last_update_date,
nvl(ed.doc_id,xdwx.doc_id) doc_id,
ed.doc_eu_id
from
&eul.eul5_documents ed
full join
(select xdwx.* from xxen_discoverer_workbook_xmls xdwx where upper(xdwx.eul)=upper(:eul)) xdwx
on
ed.doc_id=xdwx.doc_id
) x,
(
select /*+ no_merge */
xds.doc_id,
xds.sheet_name,
xxen_xdo.sheet_object_use_key(:eul,xds.doc_id,xds.sheet_name) object_use_key
from
(select /*+ no_merge */ distinct xds.doc_id, xds.sheet_name from xxen_discoverer_sheets xds where upper(xds.eul)=upper(:eul)) xds
) xds
where
x.doc_id=xds.doc_id(+)
) y,
(
select
upper(regexp_replace(eqs.qs_doc_name,'\.dis$',null,1,1,'i')) doc_name_,
count(*) access_count,
max(eqs.qs_created_date) last_accessed,
xxen_util.dis_user_name(max(eqs.qs_created_by) keep (dense_rank first order by eqs.qs_created_date desc)) last_accessed_by
from
&eul.eul5_qpp_stats eqs
where
2=2
group by
upper(regexp_replace(eqs.qs_doc_name,'\.dis$',null,1,1,'i'))
) eqs,
(select xdw.doc_id, count(*) count from xxen_discoverer_workbooks xdw where upper(xdw.eul)=upper(:eul) group by xdw.doc_id) xdw,
(
select
regexp_substr(xrv.description,chr(10)||'Object IDs: (.+)'||chr(10),1,1,null,1) object_use_key,
xrv.report_name
from
xxen_reports_v xrv
where
xrv.description like '%'||chr(10)||'Object IDs: %'||chr(10)||'EUL: '||:eul
) xrv,
(select regexp_substr(xrtv.description,chr(10)||'Sheet: (.+)',1,1,null,1) sheet, regexp_substr(xrtv.description,chr(10)||'Doc Id: (\d+)',1,1,null,1) doc_id, xrtv.* from xxen_report_templates_v xrtv where regexp_substr(xrtv.report_description,chr(10)||'EUL: (\w+)',1,1,null,1)=:eul) xrtv
where
1=1 and
upper(regexp_replace(y.workbook,'\.dis$',null,1,1,'i'))=eqs.doc_name_(+) and
y.doc_id=xdw.doc_id(+) and
y.object_use_key=xrv.object_use_key(+) and
y.doc_id=xrtv.doc_id(+) and
y.sheet=xrtv.sheet(+)
order by
y.owner,
y.workbook,
y.sheet
