/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Dependencies (used by)
-- Description: Hierarchical report showing all database objects using the specified object, e.g. a certain table and the report shows all the views or packages that are refrencing or depending on the specified table (bottom to top)
-- Excel Examle Output: https://www.enginatics.com/example/dba-dependencies-used-by/
-- Library Link: https://www.enginatics.com/reports/dba-dependencies-used-by/
-- Run Report: https://demo.enginatics.com/

select
'0' level_,
lower(do.owner||'.'||do.object_name) object,
do.owner,
do.object_name,
do.object_type,
lower(do.owner||'.'||do.object_name) path
from
dba_objects do
where
do.owner=:owner and
do.object_name=:object_name and
do.object_type=:object_type and
1=1
union all
select
lpad(' ',2*(level))||level level_,
lower(lpad(' ',2*(level))||dd.owner||'.'||dd.name) object,
dd.owner owner,
dd.name object_name,
dd.type object_type,
substr(lower(xxen_util.reverse(sys_connect_by_path(dd.owner||'.'||dd.name,' > '),' > ')||' > '||:owner||'.'||:object_name),4) path
from
dba_dependencies dd
where
dd.owner not in ('SYS','SYSTEM','PUBLIC') and
dd.referenced_owner not in ('SYS','SYSTEM','PUBLIC') and
dd.referenced_type<>'NON-EXISTENT'
connect by nocycle
prior dd.owner=dd.referenced_owner and
prior dd.name=dd.referenced_name and
prior dd.type=dd.referenced_type
start with
dd.referenced_owner=:owner and
dd.referenced_name=:object_name and
dd.referenced_type=:object_type