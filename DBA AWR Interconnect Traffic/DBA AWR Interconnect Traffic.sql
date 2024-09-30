/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA AWR Interconnect Traffic
-- Description: Displays information about the usage of an interconnect device by instance in a RAC configuration.

ipq - Parallel query communications
dlm - Database lock management
cache - Global cache communications

All other values are internal to Oracle and are not expected to have high usage.
-- Excel Examle Output: https://www.enginatics.com/example/dba-awr-interconnect-traffic/
-- Library Link: https://www.enginatics.com/reports/dba-awr-interconnect-traffic/
-- Run Report: https://demo.enginatics.com/

select
to_char(xxen_util.client_time(dhs.end_interval_time),'Day') day_of_week,
xxen_util.client_time(dhs.end_interval_time) end_interval_time,
dhs.instance_number,
dhics.name,
decode(dhics.name,'ipq','Parallel query communications','dlm','Database lock management','cache','Global cache communications') description,
(dhics.bytes_sent-lag(dhics.bytes_sent) over (partition by dhs.instance_number, dhics.name order by dhs.snap_id))/dhs.seconds/1000000 mb_sent_sec,
(dhics.bytes_received-lag(dhics.bytes_received) over (partition by dhs.instance_number, dhics.name order by dhs.snap_id))/dhs.seconds/1000000 mb_received_sec
from
(select (cast(dhs.end_interval_time as date)-cast(dhs.begin_interval_time as date))*86400 seconds, dhs.* from dba_hist_snapshot dhs) dhs,
dba_hist_ic_client_stats dhics
where
1=1 and
dhs.dbid=dhics.dbid and
dhs.instance_number=dhics.instance_number and
dhs.snap_id=dhics.snap_id
order by
dhs.instance_number,
dhics.name,
dhs.end_interval_time desc