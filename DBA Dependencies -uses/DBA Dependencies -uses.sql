/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Dependencies (uses)
-- Description: Hierarchical report showing all dependent database objects that a specified object, e.g. a view or package name uses or depends on (top to bottom)
-- Excel Examle Output: https://www.enginatics.com/example/dba-dependencies-uses/
-- Library Link: https://www.enginatics.com/reports/dba-dependencies-uses/
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
lower(lpad(' ',2*(level))||dd.referenced_owner||'.'||dd.referenced_name) object,
dd.referenced_owner owner,
dd.referenced_name object_name,
dd.referenced_type object_type,
lower(:owner||'.'||:object_name||sys_connect_by_path(dd.referenced_owner||'.'||dd.referenced_name,' > ')) path
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
dd.owner=:owner and
dd.name=:object_name and
dd.type=:object_type