/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Segments
-- Description: Database segments such as tables, indexes, lob segments by size and total database size summary
-- Excel Examle Output: https://www.enginatics.com/example/dba-segments/
-- Library Link: https://www.enginatics.com/reports/dba-segments/
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
sum(ds.bytes) over () total_bytes
from
dba_segments ds,
(select di.owner, di.index_name, di.table_owner, di.table_name from dba_indexes di where '&enable_table'='Y') di,
(
select
dl.segment_name,
nvl(di.table_owner,dl.owner) table_owner,
nvl(di.table_name,dl.table_name) table_name
from
dba_lobs dl,
dba_secondary_objects dso,
dba_indexes di
where
'&enable_table'='Y' and
dl.owner=dso.secondary_object_owner(+) and
dl.table_name=dso.secondary_object_name(+) and
dso.index_owner=di.owner(+) and
dso.index_name=di.index_name(+)
) dl
where
1=1 and
case when ds.segment_type in ('INDEX','INDEX PARTITION','INDEX SUBPARTITION') then ds.owner end=di.owner(+) and
case when ds.segment_type in ('INDEX','INDEX PARTITION','INDEX SUBPARTITION') then ds.segment_name end=di.index_name(+) and
case when ds.segment_type in ('LOBSEGMENT','LOB PARTITION','LOB SUBPARTITION') then ds.segment_name end=dl.segment_name(+)
) x
&where2
order by
x.bytes desc