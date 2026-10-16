/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Registry SQL Patch
-- Description: DBAREGISTRYSQLPATCH contains information about the SQL patches that have been installed in the database.
-- A SQL patch is a patch that contains SQL scripts which need to be run after OPatch completes. DBAREGISTRYSQLPATCH is updated by the datapatch utility. Each row contains information about an installation attempt (apply or roll back) for a given patch.
-- Excel Example Output: https://www.enginatics.com/example/dba-registry-sql-patch/
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
