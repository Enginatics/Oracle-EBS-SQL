/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Converter Diagnostic Dump
-- Description: Diagnostic dump of all metadata and flattened staging data needed to reproduce the xxen_xdo Discoverer-to-Blitz conversion logic offline.

Outputs a single result set with rows discriminated by the data_type column. Each row populates only the columns relevant to its data_type; all others are null. The dump is used by a Python parser to investigate why workbook or worksheets in discoverer eex files are not converted into Blitz templates or reports

Data types emitted: OBJECT_USE_KEY (one per object_use_key in scope, with link to existing Blitz report if imported), WORKBOOK_LINK (object_use_key to doc_id/sheet_name/qs_id link), EUL_OBJ (eul5_objs metadata per folder, with dis_folder_sql2 for COBJ/CUO), QPP_STAT (eul5_qpp_stats per qs_id with join key_ids), KEY_CONS (eul5_key_cons rows for referenced keys), EXPRESSION (eul5_expressions rows with formula1 CLOB), STAGING_WORKBOOK (xxen_discoverer_workbooks rows), STAGING_SHEET (xxen_discoverer_sheets rows), STAGING_PIVOT (xxen_discoverer_pivot_fields rows), ITEM_SQL (per-item SQL via dis_formula_sql / xml_expression_to_sql), JOIN_PREDICATE (per-join SQL via dis_formula_sql), FROM_FRAGMENT (per-folder FROM-clause entry).

Filter parameters: End User Layer (required), Object Use Key (optional, restrict to specific OUKs), Include Imported (default Yes - include OUKs already converted to Blitz reports).
-- Excel Examle Output: https://www.enginatics.com/example/dis-converter-diagnostic-dump/
-- Library Link: https://www.enginatics.com/reports/dis-converter-diagnostic-dump/
-- Run Report: https://demo.enginatics.com/

with
scope as (
select /*+ materialize */
ed.doc_id,
z.qs_doc_details sheet_name,
z.qs_object_use_key object_use_key,
z.qs_id,
z.qs_doc_name doc_name,
z.qs_doc_owner doc_owner
from
(
select y.* from
(
select
max(x.qs_id) over (partition by x.qs_doc_name,x.qs_doc_details,x.qs_doc_owner_) max_qs_id,
x.* from
(
select
max(eqs.qs_object_use_key) keep (dense_rank last order by eqs.qs_id) over (partition by eqs.qs_doc_name,eqs.qs_doc_details,eqs.qs_doc_owner_) max_object_use_key,
eqs.*
from
(select upper(eqs.qs_doc_owner) qs_doc_owner_, eqs.* from &eul.eul5_qpp_stats eqs) eqs
where
1=1
) x
where
x.qs_object_use_key=x.max_object_use_key
) y
where
y.qs_id=y.max_qs_id
) z,
(select distinct min(ed.doc_id) keep (dense_rank first order by ed.doc_batch) over (partition by ed.doc_eu_id, ed.doc_name) doc_id, ed.doc_name, xxen_util.dis_user_name(ed.doc_eu_id,'&eul','N') doc_owner from &eul.eul5_documents ed) ed,
xxen_discoverer_workbook_xmls xdwx
where
z.qs_doc_name=ed.doc_name and
z.qs_doc_owner_=ed.doc_owner and
xdwx.eul='&eul' and
xdwx.doc_id=ed.doc_id and
2=2
),
scope_ouk as (
select distinct sc.object_use_key from scope sc
),
scope_doc as (
select distinct sc.doc_id from scope sc
),
scope_qs as (
select distinct sc.qs_id, sc.object_use_key from scope sc
),
obj_from_ouk as (
select distinct
sc.object_use_key,
to_number(x.obj_id) obj_id
from
scope sc,
(
select
sc2.object_use_key,
trim(regexp_substr(sc2.object_use_key,'[^\.]+',1,rowgen.column_value)) obj_id
from
(select distinct sc.object_use_key from scope sc) sc2,
table(xxen_util.rowgen(regexp_count(sc2.object_use_key,'\.')+1)) rowgen
) x
where
sc.object_use_key=x.object_use_key and
translate(x.obj_id,'x0123456789','x') is null
),
key_ids_per_ouk as (
select distinct
sc.object_use_key,
dbms_lob.substr(regexp_substr(x.key_ids,'[^,]+',1,rowgen.column_value),20,1) key_id
from
scope sc,
(
select
sc2.object_use_key,
xxen_util.dis_qs_exp_ids((select max(s.qs_id) from scope s where s.object_use_key=sc2.object_use_key),'&eul','joins') key_ids
from
(select distinct sc.object_use_key from scope sc) sc2
) x,
table(xxen_util.rowgen(regexp_count(x.key_ids,','))) rowgen
where
sc.object_use_key=x.object_use_key
),
join_qs_per_ouk as (
select distinct
sc.object_use_key,
dbms_lob.substr(regexp_substr(x.key_ids,'[^,]+',1,rowgen.column_value),20,1) key_id,
x.qs_id
from
scope sc,
(
select
sc2.object_use_key,
eqs.qs_id,
xxen_util.dis_qs_exp_ids(eqs.qs_id,'&eul','joins') key_ids
from
(select distinct sc.object_use_key from scope sc) sc2,
(
select distinct
sc3.object_use_key,
max(eqs.qs_id) over (partition by sc3.object_use_key, xxen_xdo.bmp(eqs.qs_jbmp0),xxen_xdo.bmp(eqs.qs_jbmp1),xxen_xdo.bmp(eqs.qs_jbmp2),xxen_xdo.bmp(eqs.qs_jbmp3),xxen_xdo.bmp(eqs.qs_jbmp4),xxen_xdo.bmp(eqs.qs_jbmp5),xxen_xdo.bmp(eqs.qs_jbmp6),xxen_xdo.bmp(eqs.qs_jbmp7)) qs_id
from
&eul.eul5_qpp_stats eqs,
(select distinct sc.object_use_key from scope sc) sc3,
scope sc4
where
sc3.object_use_key=sc4.object_use_key and
sc4.qs_id=eqs.qs_id
) eqs
where
sc2.object_use_key=eqs.object_use_key
) x,
table(xxen_util.rowgen(regexp_count(x.key_ids,','))) rowgen
where
sc.object_use_key=x.object_use_key
),
obj_from_joins as (
select distinct
ki.object_use_key,
decode(rowgen.column_value,1,ekc.key_obj_id,ekc.fk_obj_id_remote) obj_id
from
key_ids_per_ouk ki,
&eul.eul5_key_cons ekc,
table(xxen_util.rowgen(2)) rowgen
where
ki.key_id=ekc.key_id
),
obj_from_ref as (
select distinct
sc.object_use_key,
xxen_util.dis_obj_id(xdw.ref_object_key,'&eul') obj_id
from
scope sc,
xxen_discoverer_workbooks xdw
where
xdw.eul='&eul' and
xdw.doc_id=sc.doc_id and
xdw.ref_object_key is not null
union
select distinct
sc.object_use_key,
xxen_util.dis_obj_id(xds.ref_object_key,'&eul') obj_id
from
scope sc,
xxen_discoverer_sheets xds
where
xds.eul='&eul' and
xds.doc_id=sc.doc_id and
xds.sheet_name=sc.sheet_name and
xds.ref_object_key is not null
),
all_obj_ids as (
select distinct obj_id from obj_from_ouk where obj_id is not null
union
select distinct obj_id from obj_from_joins where obj_id is not null
union
select distinct obj_id from obj_from_ref where obj_id is not null
),
key_ids_all as (
select distinct ki.key_id from key_ids_per_ouk ki
),
exp_ids_all as (
select distinct ee.exp_id
from
&eul.eul5_expressions ee, key_ids_all ki
where
ee.jp_key_id=ki.key_id
union
select distinct ee.exp_id
from
&eul.eul5_expressions ee, all_obj_ids ao
where
ee.it_obj_id=ao.obj_id
)
select
'OBJECT_USE_KEY' data_type,
sc.object_use_key,
to_number(null) obj_id,
to_number(null) doc_id,
cast(null as varchar2(4000)) sheet_name,
to_number(null) qs_id,
to_number(null) exp_id,
to_number(null) key_id,
to_number(null) key_2_id,
cast(null as varchar2(4000)) item_key,
cast(null as varchar2(30)) ref_type,
cast(null as varchar2(4000)) ref_key,
cast(null as varchar2(4000)) ref_object_key,
cast(null as varchar2(4000)) parent_object_key,
cast(null as varchar2(30)) class_name,
cast(null as varchar2(4000)) item_name,
cast(null as varchar2(30)) item_type,
cast(null as varchar2(80)) column_alias,
cast(null as varchar2(30)) display_item_type,
cast(null as varchar2(30)) view_type,
cast(null as varchar2(30)) field_type,
cast(null as varchar2(30)) exp_type,
cast(null as varchar2(30)) obj_type,
cast(null as varchar2(120)) sobj_ext_table,
cast(null as varchar2(30)) obj_ext_owner,
cast(null as varchar2(240)) obj_name,
cast(null as varchar2(240)) doc_name,
cast(null as varchar2(120)) doc_owner,
to_number(null) display_sequence,
to_number(null) sort_order,
cast(null as varchar2(1)) distinct_flag,
cast(null as varchar2(30)) subtotals,
case when xrv.report_id is not null then 'IMPORTED' else 'NEW' end status,
xrv.report_id blitz_report_id,
xrv.report_name blitz_report_name,
xrv.sql_text clob_1,
to_clob(null) clob_2
from
scope_ouk sc,
(select xrv.* from xxen_reports_v xrv where xrv.description like '%'||chr(10)||'Object IDs: %'||chr(10)||'EUL: '||'&eul') xrv
where
xrv.description(+) like '%'||chr(10)||'Object IDs: '||sc.object_use_key||chr(10)||'%'
union all
select
'WORKBOOK_LINK',
sc.object_use_key,
to_number(null),
sc.doc_id,
sc.sheet_name,
sc.qs_id,
to_number(null),
to_number(null),
to_number(null),
cast(null as varchar2(4000)),
cast(null as varchar2(30)),
cast(null as varchar2(4000)),
cast(null as varchar2(4000)),
cast(null as varchar2(4000)),
cast(null as varchar2(30)),
cast(null as varchar2(4000)),
cast(null as varchar2(30)),
cast(null as varchar2(80)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(120)),
cast(null as varchar2(30)),
cast(null as varchar2(240)),
sc.doc_name,
sc.doc_owner,
to_number(null),
to_number(null),
cast(null as varchar2(1)),
cast(null as varchar2(30)),
cast(null as varchar2(20)),
to_number(null),
cast(null as varchar2(240)),
to_clob(null),
to_clob(null)
from
scope sc
union all
select
'EUL_OBJ',
cast(null as varchar2(4000)),
eo.obj_id,
to_number(null),
cast(null as varchar2(4000)),
to_number(null),
to_number(null),
to_number(null),
to_number(null),
cast(null as varchar2(4000)),
cast(null as varchar2(30)),
cast(null as varchar2(4000)),
eo.obj_developer_key,
cast(null as varchar2(4000)),
cast(null as varchar2(30)),
cast(null as varchar2(4000)),
cast(null as varchar2(30)),
cast(null as varchar2(80)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
eo.obj_type,
eo.sobj_ext_table||nvl2(eo.obj_ext_db_link,'@'||eo.obj_ext_db_link,null),
eo.obj_ext_owner,
eo.obj_name,
cast(null as varchar2(240)),
cast(null as varchar2(120)),
to_number(null),
to_number(null),
cast(null as varchar2(1)),
cast(null as varchar2(30)),
cast(null as varchar2(20)),
to_number(null),
cast(null as varchar2(240)),
to_clob(null),
case when eo.obj_type in ('COBJ','CUO') then xxen_util.dis_folder_sql2(eo.obj_id,'&eul') end
from
&eul.eul5_objs eo,
all_obj_ids ao
where
eo.obj_id=ao.obj_id
union all
select
'QPP_STAT',
sq.object_use_key,
to_number(null),
to_number(null),
eqs.qs_doc_details,
eqs.qs_id,
to_number(null),
to_number(null),
to_number(null),
cast(null as varchar2(4000)),
cast(null as varchar2(30)),
cast(null as varchar2(4000)),
cast(null as varchar2(4000)),
cast(null as varchar2(4000)),
cast(null as varchar2(30)),
cast(null as varchar2(4000)),
cast(null as varchar2(30)),
cast(null as varchar2(80)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(120)),
cast(null as varchar2(30)),
cast(null as varchar2(240)),
eqs.qs_doc_name,
eqs.qs_doc_owner,
to_number(null),
to_number(null),
cast(null as varchar2(1)),
cast(null as varchar2(30)),
cast(null as varchar2(20)),
to_number(null),
cast(null as varchar2(240)),
to_clob(xxen_util.dis_qs_exp_ids(eqs.qs_id,'&eul','joins')),
to_clob(null)
from
&eul.eul5_qpp_stats eqs,
scope_qs sq
where
eqs.qs_id=sq.qs_id
union all
select
'KEY_CONS',
cast(null as varchar2(4000)),
ekc.key_obj_id,
to_number(null),
cast(null as varchar2(4000)),
to_number(null),
to_number(null),
ekc.key_id,
ekc.fk_obj_id_remote,
cast(null as varchar2(4000)),
cast(null as varchar2(30)),
cast(null as varchar2(4000)),
cast(null as varchar2(4000)),
cast(null as varchar2(4000)),
cast(null as varchar2(30)),
cast(null as varchar2(4000)),
cast(null as varchar2(30)),
cast(null as varchar2(80)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(120)),
cast(null as varchar2(30)),
cast(null as varchar2(240)),
cast(null as varchar2(240)),
cast(null as varchar2(120)),
to_number(null),
to_number(null),
cast(null as varchar2(1)),
cast(null as varchar2(30)),
cast(null as varchar2(20)),
to_number(null),
cast(null as varchar2(240)),
to_clob(null),
to_clob(null)
from
&eul.eul5_key_cons ekc,
key_ids_all ki
where
ekc.key_id=to_number(ki.key_id)
union all
select
'EXPRESSION',
cast(null as varchar2(4000)),
ee.it_obj_id,
to_number(null),
cast(null as varchar2(4000)),
to_number(null),
ee.exp_id,
ee.jp_key_id,
to_number(null),
cast(null as varchar2(4000)),
cast(null as varchar2(30)),
cast(null as varchar2(4000)),
cast(null as varchar2(4000)),
cast(null as varchar2(4000)),
cast(null as varchar2(30)),
ee.exp_name,
cast(null as varchar2(30)),
cast(null as varchar2(80)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
ee.exp_type,
cast(null as varchar2(30)),
cast(null as varchar2(120)),
cast(null as varchar2(30)),
cast(null as varchar2(240)),
cast(null as varchar2(240)),
cast(null as varchar2(120)),
to_number(null),
to_number(null),
cast(null as varchar2(1)),
cast(null as varchar2(30)),
cast(null as varchar2(20)),
to_number(null),
cast(null as varchar2(240)),
to_clob(ee.exp_formula1),
to_clob(null)
from
&eul.eul5_expressions ee,
exp_ids_all ei
where
ee.exp_id=ei.exp_id
union all
select
'STAGING_WORKBOOK',
cast(null as varchar2(4000)),
to_number(null),
xdw.doc_id,
cast(null as varchar2(4000)),
to_number(null),
to_number(null),
to_number(null),
to_number(null),
xdw.item_key,
xdw.ref_type,
xdw.ref_key,
xdw.ref_object_key,
cast(null as varchar2(4000)),
xdw.class,
xdw.item_name,
cast(null as varchar2(30)),
cast(null as varchar2(80)),
xdw.display_item_type,
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(120)),
cast(null as varchar2(30)),
cast(null as varchar2(240)),
xdw.doc_name,
xdw.doc_owner,
to_number(null),
to_number(null),
cast(null as varchar2(1)),
cast(null as varchar2(30)),
cast(null as varchar2(20)),
to_number(null),
cast(null as varchar2(240)),
xdw.expression_string,
to_clob(null)
from
xxen_discoverer_workbooks xdw,
scope_doc sd
where
xdw.eul='&eul' and
xdw.doc_id=sd.doc_id
union all
select
'STAGING_SHEET',
cast(null as varchar2(4000)),
to_number(null),
xds.doc_id,
xds.sheet_name,
to_number(null),
to_number(null),
to_number(null),
to_number(null),
xds.item_key,
cast(null as varchar2(30)),
cast(null as varchar2(4000)),
xds.ref_object_key,
cast(null as varchar2(4000)),
xds.class,
xds.item_name,
xds.item_type,
cast(null as varchar2(80)),
cast(null as varchar2(30)),
xds.view_type,
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(120)),
cast(null as varchar2(30)),
cast(null as varchar2(240)),
xds.doc_name,
xds.doc_owner,
xds.display_sequence,
xds.sort_order,
xds.distinct_flag,
xds.subtotals,
cast(null as varchar2(20)),
to_number(null),
cast(null as varchar2(240)),
to_clob(null),
to_clob(null)
from
xxen_discoverer_sheets xds,
scope sc
where
xds.eul='&eul' and
xds.doc_id=sc.doc_id and
xds.sheet_name=sc.sheet_name
union all
select
'STAGING_PIVOT',
cast(null as varchar2(4000)),
to_number(null),
xdpf.doc_id,
xdpf.sheet_name,
to_number(null),
to_number(null),
to_number(null),
to_number(null),
xdpf.item_key,
cast(null as varchar2(30)),
cast(null as varchar2(4000)),
cast(null as varchar2(4000)),
cast(null as varchar2(4000)),
cast(null as varchar2(30)),
cast(null as varchar2(4000)),
cast(null as varchar2(30)),
cast(null as varchar2(80)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
xdpf.field_type,
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(120)),
cast(null as varchar2(30)),
cast(null as varchar2(240)),
cast(null as varchar2(240)),
cast(null as varchar2(120)),
xdpf.seq_no,
to_number(null),
cast(null as varchar2(1)),
cast(null as varchar2(30)),
cast(null as varchar2(20)),
to_number(null),
cast(null as varchar2(240)),
to_clob(null),
to_clob(null)
from
xxen_discoverer_pivot_fields xdpf,
scope sc
where
xdpf.eul='&eul' and
xdpf.doc_id=sc.doc_id and
xdpf.sheet_name=sc.sheet_name
union all
select
'ITEM_SQL',
sc.object_use_key,
to_number(null),
sc.doc_id,
sc.sheet_name,
to_number(null),
to_number(null),
to_number(null),
to_number(null),
xdwv.item_key,
xdwv.ref_type,
xdwv.ref_key,
xdwv.ref_object_key,
xdwv.parent_object_key,
'DisplaySequence',
xdwv.item_name,
xds.item_type,
xdwv.column_alias,
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(120)),
cast(null as varchar2(30)),
cast(null as varchar2(240)),
cast(null as varchar2(240)),
cast(null as varchar2(120)),
xds.display_sequence,
to_number(null),
cast(null as varchar2(1)),
cast(null as varchar2(30)),
cast(null as varchar2(20)),
to_number(null),
cast(null as varchar2(240)),
case when xdwv.ref_type='EulItem' then
to_clob(xxen_api.dis_formula_sql(xxen_util.dis_exp_id(xdwv.ref_object_key, xdwv.ref_item_name, xdwv.eul), xdwv.eul)) else
trim(chr(10) from xxen_api.xml_expression_to_sql('Calculation', xdwv.eul, xdwv.doc_id, xdwv.ref_key, xdwv.expression_string, xxen_util.dis_obj_id(xdwv.parent_object_key, xdwv.eul)))
end,
to_clob(null)
from
scope sc,
xxen_discoverer_sheets xds,
xxen_discoverer_workbooks_v xdwv
where
xds.eul='&eul' and
xds.doc_id=sc.doc_id and
xds.sheet_name=sc.sheet_name and
xds.class='DisplaySequence' and
xdwv.eul=xds.eul and
xdwv.doc_id=xds.doc_id and
xdwv.item_key=xds.item_key and
xdwv.sql_text is not null
union all
select
'JOIN_PREDICATE',
jq.object_use_key,
to_number(null),
to_number(null),
cast(null as varchar2(4000)),
jq.qs_id,
ee.exp_id,
ee.jp_key_id,
to_number(null),
cast(null as varchar2(4000)),
cast(null as varchar2(30)),
cast(null as varchar2(4000)),
cast(null as varchar2(4000)),
cast(null as varchar2(4000)),
cast(null as varchar2(30)),
cast(null as varchar2(4000)),
cast(null as varchar2(30)),
cast(null as varchar2(80)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
ee.exp_type,
cast(null as varchar2(30)),
cast(null as varchar2(120)),
cast(null as varchar2(30)),
cast(null as varchar2(240)),
cast(null as varchar2(240)),
cast(null as varchar2(120)),
to_number(null),
to_number(null),
cast(null as varchar2(1)),
cast(null as varchar2(30)),
cast(null as varchar2(20)),
to_number(null),
cast(null as varchar2(240)),
to_clob(xxen_api.dis_formula_sql(ee.exp_id,'&eul')),
to_clob(null)
from
join_qs_per_ouk jq,
&eul.eul5_key_cons ekc,
&eul.eul5_expressions ee
where
jq.key_id=to_char(ekc.key_id) and
to_number(jq.key_id)=ee.jp_key_id
union all
select
'FROM_FRAGMENT',
cast(null as varchar2(4000)),
eo.obj_id,
to_number(null),
cast(null as varchar2(4000)),
to_number(null),
to_number(null),
to_number(null),
to_number(null),
cast(null as varchar2(4000)),
cast(null as varchar2(30)),
cast(null as varchar2(4000)),
cast(null as varchar2(4000)),
cast(null as varchar2(4000)),
cast(null as varchar2(30)),
cast(null as varchar2(4000)),
cast(null as varchar2(30)),
cast(null as varchar2(80)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
cast(null as varchar2(30)),
eo.obj_type,
eo.sobj_ext_table||nvl2(eo.obj_ext_db_link,'@'||eo.obj_ext_db_link,null),
eo.obj_ext_owner,
eo.obj_name,
cast(null as varchar2(240)),
cast(null as varchar2(120)),
to_number(null),
to_number(null),
cast(null as varchar2(1)),
cast(null as varchar2(30)),
cast(null as varchar2(20)),
to_number(null),
cast(null as varchar2(240)),
case when eo.obj_type in ('COBJ','CUO') then xxen_util.dis_folder_sql2(eo.obj_id,'&eul')
else to_clob(lower(case when eo.obj_ext_owner is not null and eo.obj_ext_owner<>'APPS' then eo.obj_ext_owner||'.' end||eo.sobj_ext_table||nvl2(eo.obj_ext_db_link,'@'||eo.obj_ext_db_link,null))||' o'||eo.obj_id) end,
to_clob(null)
from
&eul.eul5_objs eo,
all_obj_ids ao
where
eo.obj_id=ao.obj_id
order by
1,
2 nulls last,
3 nulls last,
4 nulls last,
5 nulls last,
29 nulls last,
6 nulls last,
8 nulls last,
7 nulls last,
10 nulls last