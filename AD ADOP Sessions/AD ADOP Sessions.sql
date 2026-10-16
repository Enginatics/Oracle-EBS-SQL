/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: AD ADOP Sessions
-- Description: Online patching (adop) sessions of Oracle EBS 12.2 with one row per node and phase, showing the status, start and end time and duration of each phase.
-- Phases that do not apply to a session, for example all phases but apply in a hotpatch session, are not shown. The Patches column lists the patches applied in the session's apply phase.
-- Excel Example Output: https://www.enginatics.com/example/ad-adop-sessions/
-- Library Link: https://www.enginatics.com/reports/ad-adop-sessions/
-- Run Report: https://demo.enginatics.com/

select
x.adop_session_id session_id,
x.node_name,
x.node_type,
decode(x.status,'C','Completed','F','Failed','R','Running',x.status) session_status,
x.edition_name,
x.phase,
decode(x.phase_status,'Y','Completed','N','Not Started','R','Running','F','Failed',x.phase_status) phase_status,
xxen_util.client_time(x.start_date) start_date,
xxen_util.client_time(x.end_date) end_date,
xxen_util.time((x.end_date-x.start_date)*86400) duration,
(x.end_date-x.start_date)*1440 minutes,
case when x.phase='Apply' then (select listagg(aasp.bug_number,', ') within group (order by aasp.bug_number) from ad_adop_session_patches aasp where x.adop_session_id=aasp.adop_session_id and x.node_name=aasp.node_name) end patches
from
(
select
aas.*,
decode(rowgen.column_value,1,'Prepare',2,'Apply',3,'Finalize',4,'Cutover',5,'Cleanup',6,'Abort') phase,
decode(rowgen.column_value,1,aas.prepare_status,2,aas.apply_status,3,aas.finalize_status,4,aas.cutover_status,5,aas.cleanup_status,6,aas.abort_status) phase_status,
decode(rowgen.column_value,1,aas.prepare_start_date,2,aas.apply_start_date,3,aas.finalize_start_date,4,aas.cutover_start_date,5,aas.cleanup_start_date,6,aas.abort_start_date) start_date,
decode(rowgen.column_value,1,aas.prepare_end_date,2,aas.apply_end_date,3,aas.finalize_end_date,4,aas.cutover_end_date,5,aas.cleanup_end_date,6,aas.abort_end_date) end_date,
rowgen.column_value phase_number
from
ad_adop_sessions aas,
table(xxen_util.rowgen(6)) rowgen
where
1=1
) x
where
x.phase_status<>'X'
order by
x.adop_session_id desc,
x.node_name,
x.phase_number
