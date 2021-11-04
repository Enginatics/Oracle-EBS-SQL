/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Table Modifications
-- Description: If table monitoring is activated, dba_tab_modifications shows the number of rows modified since the last time a table was analyzed.
-- Excel Examle Output: https://www.enginatics.com/example/dba-table-modifications/
-- Library Link: https://www.enginatics.com/reports/dba-table-modifications/
-- Run Report: https://demo.enginatics.com/

select
dtm.table_owner owner,
dtm.table_name,
xxen_util.client_time(dtm.timestamp) last_dml_date,
xxen_util.client_time(dt.last_analyzed) last_analyzed,
dt.num_rows,
dtm.inserts/(sysdate-dt.last_analyzed) inserts_day,
dtm.updates/(sysdate-dt.last_analyzed) updates_day,
dtm.deletes/(sysdate-dt.last_analyzed) deletes_day,
dtm.total_changes/(sysdate-dt.last_analyzed) total_changes_day,
dtm.total_changes/xxen_util.zero_to_null(dt.num_rows)/(sysdate-dt.last_analyzed)*100 percent_day,
dtm.inserts,
dtm.updates,
dtm.deletes,
dtm.total_changes,
dtm.total_changes/xxen_util.zero_to_null(dt.num_rows)*100 percent
from
(select dtm.inserts+dtm.deletes+dtm.updates total_changes, dtm.* from dba_tab_modifications dtm) dtm,
dba_tables dt
where
1=1 and
dtm.table_owner=dt.owner(+) and
dtm.table_name=dt.table_name(+) and
dtm.partition_name is null and
dtm.subpartition_name is null
order by
total_changes_day desc nulls last,
dtm.table_owner,
dtm.table_name