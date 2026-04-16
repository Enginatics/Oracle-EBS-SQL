/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Object Access Privileges
-- Description: Database object privileges for a specific user, including privileges inherited through role grants. Useful for DB access security audits to understand exactly what objects a user can access and how the access was granted (directly or through which role chain).
-- Excel Examle Output: https://www.enginatics.com/example/dba-object-access-privileges/
-- Library Link: https://www.enginatics.com/reports/dba-object-access-privileges/
-- Run Report: https://demo.enginatics.com/

select
x.grantee,
x.privilege_type,
x.privilege,
x.privilege_source,
x.object_owner,
x.object_type,
x.object_name,
x.grantor,
x.grantable,
x.hierarchy
from
(
select
:grantee grantee,
'Object' privilege_type,
dtp.privilege,
case when dtp.grantee=:grantee then 'Direct' else dtp.grantee end privilege_source,
dtp.owner object_owner,
dtp.type object_type,
dtp.table_name object_name,
dtp.grantor,
dtp.grantable,
dtp.hierarchy
from
(
select :grantee grantee_ from dual
union all
select
drp.granted_role
from
dba_role_privs drp
start with
drp.grantee=:grantee
connect by
drp.grantee=prior drp.granted_role
) rh,
dba_tab_privs dtp
where
rh.grantee_=dtp.grantee and
1=1
union all
select
:grantee grantee,
'System' privilege_type,
dsp.privilege,
case when dsp.grantee=:grantee then 'Direct' else dsp.grantee end privilege_source,
null object_owner,
null object_type,
null object_name,
null grantor,
dsp.admin_option grantable,
null hierarchy
from
(
select :grantee grantee_ from dual
union all
select
drp.granted_role
from
dba_role_privs drp
start with
drp.grantee=:grantee
connect by
drp.grantee=prior drp.granted_role
) rh,
dba_sys_privs dsp
where
rh.grantee_=dsp.grantee
union all
select
:grantee grantee,
'Role' privilege_type,
drp.granted_role privilege,
case when drp.grantee=:grantee then 'Direct' else drp.grantee end privilege_source,
null object_owner,
null object_type,
null object_name,
null grantor,
drp.admin_option grantable,
null hierarchy
from
(
select :grantee grantee_ from dual
union all
select
drp2.granted_role
from
dba_role_privs drp2
start with
drp2.grantee=:grantee
connect by
drp2.grantee=prior drp2.granted_role
) rh,
dba_role_privs drp
where
rh.grantee_=drp.grantee
) x
where
2=2
order by
x.privilege_type,
x.privilege_source,
x.object_owner,
x.object_type,
x.object_name,
x.privilege