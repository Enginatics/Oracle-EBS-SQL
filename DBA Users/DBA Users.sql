/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Users
-- Description: Database user accounts with their status, lock and expiry dates, profile, tablespaces and quotas.
-- Default Password flags accounts that still have an Oracle-supplied default password (dbauserswithdefpwd). EBS Applications lists the Oracle EBS applications installed in the schema.
-- Excel Example Output: https://www.enginatics.com/example/dba-users/
-- Library Link: https://www.enginatics.com/reports/dba-users/
-- Run Report: https://demo.enginatics.com/

select
du.username,
du.account_status,
du.lock_date,
du.expiry_date,
du.created,
du.profile,
xxen_util.yes(nvl2(duwd.username,'Y',null)) default_password,
fou.ebs_applications,
du.default_tablespace,
du.temporary_tablespace,
dtq.tablespace_quotas,
du.authentication_type,
xxen_util.yes(du.editions_enabled) editions_enabled,
du.user_id
from
dba_users du,
(select /*+ no_merge*/ duwd.username from dba_users_with_defpwd duwd) duwd,
(
select /*+ no_merge*/
fou.oracle_username,
listagg(fav.application_short_name,', ') within group (order by fav.application_short_name) ebs_applications
from
fnd_oracle_userid fou,
fnd_product_installations fpi,
fnd_application_vl fav
where
fou.oracle_id=fpi.oracle_id and
fpi.application_id=fav.application_id
group by
fou.oracle_username
) fou,
(
select /*+ no_merge*/
dtq.username,
listagg(dtq.tablespace_name||' '||decode(dtq.max_bytes,-1,'unlimited',dtq.max_bytes/1000000||' MB'),', ') within group (order by dtq.tablespace_name) tablespace_quotas
from
dba_ts_quotas dtq
group by
dtq.username
) dtq
where
1=1 and
du.username=duwd.username(+) and
du.username=fou.oracle_username(+) and
du.username=dtq.username(+)
order by
du.username
