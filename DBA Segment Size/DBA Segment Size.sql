/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Segment Size
-- Description: Database segments such as tables, indexes, lob segments by size and total database size summary
-- Excel Examle Output: https://www.enginatics.com/example/dba-segment-size
-- Library Link: https://www.enginatics.com/reports/dba-segment-size
-- Run Report: https://demo.enginatics.com/


select
&column2
100*x.bytes/x.total_bytes percentage,
x.bytes/1000000 mb,
x.total_bytes/1000000 total_mb
&column3
from
(
select distinct
&column1
sum(ds.bytes) over (partition by &partition_by) bytes,
sum(ds.bytes) over () total_bytes,
dt.num_rows,
dt.last_analyzed
from
dba_segments ds,
(select dt.* from dba_tables dt where '&enable_table'='Y') dt
where
1=1 and
case when ds.segment_type in ('TABLE','TABLE PARTITION') then ds.owner end=dt.owner(+) and
case when ds.segment_type in ('TABLE','TABLE PARTITION') then ds.segment_name end=dt.table_name(+)
) x
order by
x.bytes desc