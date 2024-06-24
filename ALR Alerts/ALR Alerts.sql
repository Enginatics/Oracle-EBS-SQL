/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ALR Alerts
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/alr-alerts/
-- Library Link: https://www.enginatics.com/reports/alr-alerts/
-- Run Report: https://demo.enginatics.com/

select
fav.application_name application,
aa.alert_name,
aa.sql_statement_text,
aa.description,
xxen_util.meaning(decode(aa.enabled_flag,'Y','Y'),'YES_NO',0) enabled,
xxen_util.meaning(aa.alert_condition_type,'ALERT_CONDITION_TYPE',0) alert_condition_type,
case
when aa.frequency_type='C' and aa.days_between_checks=1 then 'Every Day'
when aa.frequency_type='C' and aa.days_between_checks=2 then 'Every Other Day'
when aa.frequency_type='B' and aa.days_between_checks=1 then 'Every Business Day' else
decode(aa.frequency_type,
'O','On Demand',
'M','On Day of the Month',
'W','On Day of the Week',
'C','Every N Calendar Days',
'B','Every N Business Days',
'B','Every N Business Days',
aa.frequency_type
) end frequency,
coalesce(to_char(aa.monthly_check_day_num),
xxen_util.meaning(aa.weekly_check_day,'BIS_WEEK_DAYS',3),
to_char(aa.days_between_checks)) days,
aa.check_start_time,
aa.check_end_time,
aa.seconds_between_checks,
fav2.application_name table_application,
aa.table_name,
xxen_util.meaning(aa.insert_flag,'YES_NO',0) after_insert,
xxen_util.meaning(aa.update_flag,'YES_NO',0) after_update,
aa.maintain_history_days keep_history_days,
aa.start_date_active,
aa.end_date_active,
aa.date_last_checked,
xxen_util.user_name(aa.created_by) created_by,
xxen_util.client_time(aa.creation_date) creation_date,
xxen_util.user_name(aa.last_updated_by) last_updated_by,
xxen_util.client_time(aa.last_update_date) last_update_date,
&action_columns
aa.application_id,
aa.alert_id
from
alr_alerts aa,
fnd_application_vl fav,
fnd_application_vl fav2,
(select aav.* from alr_actions_v aav where '&show_actions'='Y' and sysdate<=nvl(aav.end_date_active,sysdate) and aav.enabled_flag='Y') aav
where
1=1 and
aa.application_id=fav.application_id and
aa.table_application_id=fav2.application_id(+) and
aa.application_id=aav.application_id(+) and
aa.alert_id=aav.alert_id(+)
order by
aa.alert_name,
aav.name