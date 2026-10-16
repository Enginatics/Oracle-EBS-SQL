/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Gather Statistics History
-- Description: History of Oracle EBS statistics gathering (FNDSTATS) per schema, table, index or column, with start time, end time and duration.
-- Gather Schema Statistics and Gather Table Statistics record their runs here. With the default history mode Last Run, each object keeps only its latest gathering.
-- Excel Example Output: https://www.enginatics.com/example/fnd-gather-statistics-history/
-- Library Link: https://www.enginatics.com/reports/fnd-gather-statistics-history/
-- Run Report: https://demo.enginatics.com/

select
fsh.schema_name,
fsh.object_type,
fsh.object_name,
fsh.partition,
fsh.column_table_name,
xxen_util.client_time(fsh.last_gather_start_time) start_time,
xxen_util.client_time(fsh.last_gather_end_time) end_time,
xxen_util.time((fsh.last_gather_end_time-fsh.last_gather_start_time)*86400) duration,
(fsh.last_gather_end_time-fsh.last_gather_start_time)*86400 seconds,
fsh.est_percent estimate_percent,
fsh.parallel,
fsh.request_id,
(select fcpv.user_concurrent_program_name from fnd_concurrent_requests fcr, fnd_concurrent_programs_vl fcpv where fsh.request_id=fcr.request_id and fcr.program_application_id=fcpv.application_id and fcr.concurrent_program_id=fcpv.concurrent_program_id) concurrent_program
from
fnd_stats_hist fsh
where
1=1
order by
fsh.last_gather_start_time desc nulls last,
fsh.schema_name,
fsh.object_name
