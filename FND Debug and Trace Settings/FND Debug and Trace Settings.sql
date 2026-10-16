/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Debug and Trace Settings
-- Description: Profile option values that switch on debug logging, SQL trace or a custom initialization SQL statement, at any level, and concurrent programs with SQL trace enabled.
-- Debug and trace settings left on in production slow down processing and fill the FNDLOGMESSAGES table and the database trace directory.
-- Profile options are selected by internal names containing DEBUG or TRACE, excluding file, directory and module settings, plus FND: Debug Log Enabled and Initialization SQL Statement - Custom. Values N, No, F, 0, Off and None are not shown.
-- Excel Example Output: https://www.enginatics.com/example/fnd-debug-and-trace-settings/
-- Library Link: https://www.enginatics.com/reports/fnd-debug-and-trace-settings/
-- Run Report: https://demo.enginatics.com/

select
x.setting_type,
x.name,
x.level_,
x.level_name,
x.value,
xxen_util.user_name(x.last_updated_by) last_updated_by,
xxen_util.client_time(x.last_update_date) last_update_date,
x.system_name
from
(
select
'Profile Option' setting_type,
fpov0.user_profile_option_name name,
decode(fpov.level_id,10001,'Site',10002,'Application',10003,'Responsibility',10004,'User',10005,'Server',10006,'Operating Unit',10007,'Server+Responsibility') level_,
decode(fpov.level_id,10002,fav.application_name,10003,frv.responsibility_name,10004,xxen_util.user_name(fpov.level_value),10005,fn.node_name,10006,haouv.name,10007,frv.responsibility_name) level_name,
xxen_util.display_profile_option_value(fpov0.application_id,fpov0.profile_option_id,fpov.profile_option_value) value,
fpov.last_updated_by,
fpov.last_update_date,
fpov0.profile_option_name system_name
from
fnd_profile_options_vl fpov0,
fnd_profile_option_values fpov,
fnd_application_vl fav,
fnd_responsibility_vl frv,
fnd_nodes fn,
hr_all_organization_units_vl haouv
where
(
regexp_like(fpov0.profile_option_name,'DEBUG|TRACE') and
not regexp_like(fpov0.profile_option_name,'DIR|FILE|PATH|URL|LOCATION|MODULE') or
fpov0.profile_option_name in ('AFLOG_ENABLED','FND_INIT_SQL')
) and
fpov0.application_id=fpov.application_id and
fpov0.profile_option_id=fpov.profile_option_id and
upper(fpov.profile_option_value) not in ('N','NO','F','0','OFF','NONE') and
decode(fpov.level_id,10002,fpov.level_value)=fav.application_id(+) and
case when fpov.level_id in (10003,10007) then fpov.level_value end=frv.responsibility_id(+) and
case when fpov.level_id in (10003,10007) then fpov.level_value_application_id end=frv.application_id(+) and
decode(fpov.level_id,10005,fpov.level_value)=fn.node_id(+) and
decode(fpov.level_id,10006,fpov.level_value)=haouv.organization_id(+)
union all
select
'Concurrent Program' setting_type,
fcpv.user_concurrent_program_name name,
'Program' level_,
fav.application_name level_name,
'SQL Trace' value,
fcpv.last_updated_by,
fcpv.last_update_date,
fcpv.concurrent_program_name system_name
from
fnd_concurrent_programs_vl fcpv,
fnd_application_vl fav
where
fcpv.enable_trace='Y' and
fcpv.application_id=fav.application_id
) x
where
1=1
order by
x.setting_type desc,
x.name,
x.level_,
x.level_name
