/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Table Columns
-- Description: Report with all table column names based on dba_tab_columns, as finding tables by column names is a frequent task during SQL development
-- Excel Examle Output: https://www.enginatics.com/example/dba-table-columns/
-- Library Link: https://www.enginatics.com/reports/dba-table-columns/
-- Run Report: https://demo.enginatics.com/

select
dtc.owner,
dtc.table_name,
dtc.column_name,
dtc.data_type||case when dtc.data_type like '%CHAR%' then ' ('||dtc.data_length||')' end data_type,
decode(dtc.nullable,'N',xxen_util.meaning(dtc.nullable,'YES_NO',0)) nullable,
dtc.column_id
from
dba_tab_columns dtc
where
1=1
order by
dtc.owner,
dtc.table_name,
dtc.column_id