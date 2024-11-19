/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Registry SQL Patch
-- Description: DBA_REGISTRY_SQLPATCH contains information about the SQL patches that have been installed in the database.
A SQL patch is a patch that contains SQL scripts which need to be run after OPatch completes. DBA_REGISTRY_SQLPATCH is updated by the datapatch utility. Each row contains information about an installation attempt (apply or roll back) for a given patch.
-- Excel Examle Output: https://www.enginatics.com/example/dba-registry-sql-patch/
-- Library Link: https://www.enginatics.com/reports/dba-registry-sql-patch/
-- Run Report: https://demo.enginatics.com/

select
drs.patch_id,
drs.description,
drs.action,
cast(drs.action_time as date) action_date
from
dba_registry_sqlpatch drs
where
1=1
order by
drs.action_time desc