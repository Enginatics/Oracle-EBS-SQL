/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Undo Statistics
-- Description: Undo generation, longest running query and undo errors per 10-minute interval from gv$undostat, which keeps about four days of history.
-- All sizes are shown in MB, Undo Per Second in MB per second.
-- ORA-01555 snapshot too old occurs when a query needs undo that has already been overwritten. Compare the Longest Query Seconds with the Tuned Undo Retention Seconds: unexpired steal attempts and blocks show undo that was overwritten before its retention expired because the undo tablespace was too small.
-- Excel Example Output: https://www.enginatics.com/example/dba-undo-statistics/
-- Library Link: https://www.enginatics.com/reports/dba-undo-statistics/
-- Run Report: https://demo.enginatics.com/

select
gu.inst_id,
xxen_util.client_time(gu.begin_time) begin_time,
xxen_util.client_time(gu.end_time) end_time,
gu.undo_tablespace,
gu.undoblks*gu.block_size/1000000 undo_generated,
gu.undoblks*gu.block_size/1000000/xxen_util.zero_to_null((gu.end_time-gu.begin_time)*86400) undo_per_second,
gu.txncount transactions,
gu.maxconcurrency max_concurrent_transactions,
xxen_util.time(gu.maxquerylen) longest_query,
gu.maxquerylen longest_query_seconds,
gu.maxqueryid longest_query_sql_id,
xxen_util.time(gu.tuned_undoretention) tuned_undo_retention,
gu.tuned_undoretention tuned_undo_retention_seconds,
gu.undo_retention undo_retention_parameter,
gu.activeblks*gu.block_size/1000000 active_undo,
gu.unexpiredblks*gu.block_size/1000000 unexpired_undo,
gu.expiredblks*gu.block_size/1000000 expired_undo,
xxen_util.zero_to_null(gu.ssolderrcnt) ora_01555_errors,
xxen_util.zero_to_null(gu.nospaceerrcnt) out_of_space_errors,
xxen_util.zero_to_null(gu.unxpstealcnt) unexpired_steal_attempts,
xxen_util.zero_to_null(gu.unxpblkrelcnt) unexpired_blocks_released,
xxen_util.zero_to_null(gu.unxpblkreucnt) unexpired_blocks_reused,
xxen_util.zero_to_null(gu.expstealcnt) expired_steal_attempts
from
(
select
gu.*,
(select gt.name from gv$tablespace gt where gu.inst_id=gt.inst_id and gu.undotsn=gt.ts#) undo_tablespace,
(select dt.block_size from gv$tablespace gt, dba_tablespaces dt where gu.inst_id=gt.inst_id and gu.undotsn=gt.ts# and gt.name=dt.tablespace_name) block_size,
(select to_number(gp.value) from gv$parameter gp where gu.inst_id=gp.inst_id and gp.name='undo_retention') undo_retention
from
gv$undostat gu
where
1=1
) gu
order by
gu.begin_time desc,
gu.inst_id
