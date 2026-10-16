/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA SYSAUX Occupants
-- Description: Space used in the SYSAUX tablespace by component.
-- All sizes are shown in MB.
-- The largest occupants are usually the AWR (SM/AWR) and the optimizer statistics history (SM/OPTSTAT). The SM/OPTSTAT row shows the statistics history retention in days and the oldest statistics still available. A lower retention, set with dbmsstats.alterstatshistoryretention, reduces the SYSAUX space used.
-- Excel Example Output: https://www.enginatics.com/example/dba-sysaux-occupants/
-- Library Link: https://www.enginatics.com/reports/dba-sysaux-occupants/
-- Run Report: https://demo.enginatics.com/

select
vso.occupant_name,
vso.occupant_desc description,
vso.schema_name,
vso.space_usage_kbytes*1024/1000000 space_used,
ratio_to_report(vso.space_usage_kbytes) over ()*100 percentage,
case when vso.occupant_name='SM/OPTSTAT' then dbms_stats.get_stats_history_retention end retention_days,
case when vso.occupant_name='SM/OPTSTAT' then xxen_util.client_time(cast(dbms_stats.get_stats_history_availability as date)) end oldest_available,
vso.move_procedure,
vso.move_procedure_desc move_procedure_description
from
v$sysaux_occupants vso
order by
vso.space_usage_kbytes desc
