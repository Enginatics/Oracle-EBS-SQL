/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA External Table Creation
-- Excel Examle Output: https://www.enginatics.com/example/dba-external-table-creation/
-- Library Link: https://www.enginatics.com/reports/dba-external-table-creation/
-- Run Report: https://demo.enginatics.com/

select
'drop table '||:external_table||';
create table '||:external_table||'
(
'||z.text1||
'
)
organization external
(
default directory '||:default_directory||'
access parameters (
records delimited by ''\r\n'' characterset we8mswin1252
skip 1
&write_log
nodiscardfile
fields terminated by '','' optionally enclosed by ''"''
missing field values are null
(
'||z.text2||
'
)
)
location ('''||:file_name||''')
);' text
from
(
select distinct
listagg(y.text1,chr(10)) within group (order by y.column_id) over () text1,
listagg(y.text2,chr(10)) within group (order by y.column_id) over () text2
from
(
select
x.column_id,
lower(x.column_name||' '||x.data_type)||decode(x.data_type,'VARCHAR2','('||x.data_length||')')||decode(max(x.column_id) over (),x.column_id,null,',') text1,
lower(x.column_name)||case when x.data_type='DATE' then ' date "DD-MON-RR HH24:MI:SS"' when x.data_type='VARCHAR2' then ' char('||x.data_length||')' when x.data_type in ('LONG','CLOB') then ' char(60000)' end||decode(max(x.column_id) over (),x.column_id,null,',') text2
from
table(xxen_util.sql_columns(:sql_statement)) x
) y
) z
where
1=1