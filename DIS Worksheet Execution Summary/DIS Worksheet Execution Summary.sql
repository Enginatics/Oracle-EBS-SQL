/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Worksheet Execution Summary
-- Description: Discoverer worksheet access statistic summary from table eul5_qpp_stats to show the number of active Discoverer users, number of different workbooks and worksheets executed and the number of different folder (combinations) that these are based on.
-- Excel Examle Output: https://www.enginatics.com/example/dis-worksheet-execution-summary/
-- Library Link: https://www.enginatics.com/reports/dis-worksheet-execution-summary/
-- Run Report: https://demo.enginatics.com/

select distinct
&month_column
count(*) over (&partition_by) execution_count,
count(distinct x.qs_created_by) over (&partition_by) user_count,
count(distinct x.workbook_owner||x.workbook) over (&partition_by) workbook_count,
count(distinct x.workbook_owner||x.workbook||x.sheet) over (&partition_by) sheet_count,
count(distinct x.folders) over (&partition_by) folder_count,
count(distinct decode(x.folder_count,1,x.folders)) over (&partition_by) "1 Folder Count",
count(distinct decode(x.folder_count,2,x.folders)) over (&partition_by) "2 Folder Count",
count(distinct decode(x.folder_count,3,x.folders)) over (&partition_by) "3 Folder Count",
count(distinct decode(x.folder_count,4,x.folders)) over (&partition_by) "4 Folder Count",
count(distinct decode(x.folder_count,5,x.folders)) over (&partition_by) "5 Folder Count",
count(distinct case when x.folder_count>5 then x.folders end) over (&partition_by) ">5 Folder Count"
from
(
select distinct
eqs.qs_id id,
eqs.qs_created_by,
eqs.qs_doc_owner workbook_owner,
eqs.qs_doc_name workbook,
eqs.qs_doc_details sheet,
trunc(eqs.qs_created_date,'month') month,
eqs.qs_created_date start_date,
eqs.qs_num_rows row_count,
listagg(eo.obj_name,', ') within group (order by eo.obj_name) over (partition by eqs.qs_id) folders,
length(eqs.qs_object_use_key)-length(translate(eqs.qs_object_use_key,'x.','x'))+1 folder_count,
xxen_util.meaning(case when eqs.qs_object_use_key like '%.%' then 'Y' end,'YES_NO',0) multiple_flag,
eqs.qs_object_use_key use_key
from
(
select
trim(regexp_substr(eqs.qs_object_use_key,'[^\.]+',1,rowgen.column_value)) obj_id,
greatest(nvl(eqs.qs_act_cpu_time,0),nvl(eqs.qs_act_elap_time,0)) seconds,
eqs.*
from
&eul.eul5_qpp_stats eqs,
table(xxen_util.rowgen(regexp_count(eqs.qs_object_use_key,'\.')+1)) rowgen
where
1=1
) eqs,
&eul.eul5_objs eo
where
2=2 and
translate(eqs.obj_id,'x0123456789','x') is null and
eqs.obj_id=eo.obj_id(+)
) x
&order_by