/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Dependencies (used by)
-- Description: Hierarchical report showing all database objects that use the specified objects, e.g. all views or packages referencing or depending on a table (bottom to top).
-- Select several object names to list the hierarchy of each, one after the other.
-- Show Table Statistics adds the optimizer statistics and the indexes of every table in the hierarchy.
-- Excel Example Output: https://www.enginatics.com/example/dba-dependencies-used-by/
-- Library Link: https://www.enginatics.com/reports/dba-dependencies-used-by/
-- Run Report: https://demo.enginatics.com/

select
x.level_,
x.object,
x.owner,
x.object_name,
x.object_type,
x.path
&table_statistics
from
(
select
0 root_branch,
rownum row_num,
do.owner root_owner,
do.object_name root_name,
do.object_type root_type,
'0' level_,
lower(do.owner||'.'||do.object_name) object,
do.owner,
do.object_name,
do.object_type,
lower(do.owner||'.'||do.object_name) path
from
dba_objects do
where
1=1
union all
select /*+ connect_by_filtering*/
1 root_branch,
rownum row_num,
connect_by_root dd.referenced_owner root_owner,
connect_by_root dd.referenced_name root_name,
connect_by_root dd.referenced_type root_type,
lpad(' ',2*(level))||level level_,
lower(lpad(' ',2*(level))||dd.owner||'.'||dd.name) object,
dd.owner owner,
dd.name object_name,
dd.type object_type,
substr(lower(xxen_util.reverse(sys_connect_by_path(dd.owner||'.'||dd.name,' > '),' > ')||' > '||connect_by_root dd.referenced_owner||'.'||connect_by_root dd.referenced_name),4) path
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
2=2
) x
order by
x.root_owner,
x.root_name,
x.root_type,
x.root_branch,
x.row_num
