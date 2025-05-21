/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Objects
-- Description: All database objects
-- Excel Examle Output: https://www.enginatics.com/example/dba-objects/
-- Library Link: https://www.enginatics.com/reports/dba-objects/
-- Run Report: https://demo.enginatics.com/

select
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
from
dba_objects do
where
1=1
order by
do.owner,
do.object_type,
do.object_name