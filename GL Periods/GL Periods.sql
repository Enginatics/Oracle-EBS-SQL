/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Periods
-- Description: Geleral ledger calendars and accounting periods
-- Excel Examle Output: https://www.enginatics.com/example/gl-periods/
-- Library Link: https://www.enginatics.com/reports/gl-periods/
-- Run Report: https://demo.enginatics.com/

select
gp.period_set_name calendar,
gps.description calendar_description,
xxen_util.yes(gps.security_flag) enable_security,
gp.entered_period_name,
gpt.user_period_type type,
gp.period_year year,
gp.quarter_num quarter,
gp.period_num,
gp.start_date,
gp.end_date,
gp.period_name,
xxen_util.yes(gp.adjustment_period_flag) adjustment_period,
xxen_util.meaning((select 'Y' from gl_period_statuses gps where gp.period_type=gps.period_type and gp.period_name=gps.period_name and gps.closing_status in ('O','W','C','P') and rownum=1),'YES_NO',0) used,
gpt.number_per_fiscal_year periods_per_year,
decode(gpt.year_type_in_name,'C','Calendar','F','Fiscal') year_type,
xxen_util.user_name(gp.created_by) created_by,
xxen_util.client_time(gp.creation_date) creation_date,
xxen_util.user_name(gp.last_updated_by) last_updated_by,
xxen_util.client_time(gp.last_update_date) last_update_date,
gp.period_type
from
gl_period_sets gps,
gl_periods gp,
gl_period_types gpt
where
1=1 and
gps.period_set_name=gp.period_set_name and
gp.period_type=gpt.period_type
order by
gp.period_set_name,
gpt.user_period_type,
gp.period_year desc,
gp.period_num desc