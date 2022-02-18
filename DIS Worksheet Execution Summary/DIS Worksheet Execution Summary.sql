/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
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
count(distinct x.use_key) over (&partition_by) folder_count,
count(distinct decode(x.folder_count,1,x.use_key)) over (&partition_by) "1 Folder Count",
count(distinct decode(x.folder_count,2,x.use_key)) over (&partition_by) "2 Folder Count",
count(distinct decode(x.folder_count,3,x.use_key)) over (&partition_by) "3 Folder Count",
count(distinct decode(x.folder_count,4,x.use_key)) over (&partition_by) "4 Folder Count",
count(distinct decode(x.folder_count,5,x.use_key)) over (&partition_by) "5 Folder Count",
count(distinct case when x.folder_count>5 then x.use_key end) over (&partition_by) ">5 Folder Count"
from
(
select
eqs.qs_id id,
eqs.qs_created_by,
eqs.qs_doc_owner workbook_owner,
eqs.qs_doc_name workbook,
eqs.qs_doc_details sheet,
trunc(eqs.qs_created_date,'month') month,
length(eqs.qs_object_use_key)-length(translate(eqs.qs_object_use_key,'x.','x'))+1 folder_count,
eqs.qs_object_use_key use_key
from
&eul.eul5_qpp_stats eqs
where
1=1
) x
&order_by