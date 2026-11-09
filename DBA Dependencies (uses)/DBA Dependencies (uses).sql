/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Dependencies (uses)
-- Description: Hierarchical report showing all database objects that the specified objects, e.g. views or packages, use or depend on (top to bottom).
-- Select several object names to list the hierarchy of each, one after the other.
-- Show Table Statistics adds the optimizer statistics and the indexes of every table in the hierarchy, to review the access paths of a view or package.
-- Excel Example Output: https://www.enginatics.com/example/dba-dependencies-uses/
-- Library Link: https://www.enginatics.com/reports/dba-dependencies-uses/
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
connect_by_root dd.owner root_owner,
connect_by_root dd.name root_name,
connect_by_root dd.type root_type,
lpad(' ',2*(level))||level level_,
lower(lpad(' ',2*(level))||dd.referenced_owner||'.'||dd.referenced_name) object,
dd.referenced_owner owner,
dd.referenced_name object_name,
dd.referenced_type object_type,
lower(connect_by_root dd.owner||'.'||connect_by_root dd.name||sys_connect_by_path(dd.referenced_owner||'.'||dd.referenced_name,' > ')) path
from
dba_dependencies dd
where
dd.owner not in ('SYS','SYSTEM','PUBLIC') and
dd.referenced_owner not in ('SYS','SYSTEM','PUBLIC') and
dd.referenced_type<>'NON-EXISTENT'
connect by nocycle
prior dd.referenced_owner=dd.owner and
prior dd.referenced_name=dd.name and
prior dd.referenced_type=dd.type
start with
2=2
) x
order by
x.root_owner,
x.root_name,
x.root_type,
x.root_branch,
x.row_num
