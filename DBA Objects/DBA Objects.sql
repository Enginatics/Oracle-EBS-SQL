/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Objects
-- Description: All database objects.
-- Show DDL returns each object's DDL or source code. DDL longer than 32,000 characters is split over several rows, numbered in column DDL Part, as an Excel cell holds at most 32,767 characters.
-- Excel Example Output: https://www.enginatics.com/example/dba-objects/
-- Library Link: https://www.enginatics.com/reports/dba-objects/
-- Run Report: https://demo.enginatics.com/

select
x.owner,
x.object_name,
x.subobject_name,
x.object_type,
x.status,
x.created,
x.timestamp,
x.last_ddl_time,
x.temporary,
x.generated,
x.secondary,
x.namespace,
x.edition_name,
x.sharing,
x.editionable,
x.oracle_maintained,
x.object_id,
x.data_object_id
&ddl_column
from
(
select /*+ no_merge*/
do.owner,
do.object_name,
do.subobject_name,
do.object_type,
do.status,
do.created,
to_date(substr(do.timestamp,1,16),'YYYY-MM-DD HH24:MI:SS') timestamp,
do.last_ddl_time,
do.temporary,
do.generated,
do.secondary,
do.namespace,
do.edition_name,
do.sharing,
do.editionable,
do.oracle_maintained,
do.object_id,
do.data_object_id
&ddl_value
from
dba_objects do
where
1=1
) x
&ddl_rows
order by
x.owner,
x.object_type,
x.object_name
&ddl_order
