/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Daily Rates
-- Description: Daily currency conversion rates
-- Excel Examle Output: https://www.enginatics.com/example/gl-daily-rates/
-- Library Link: https://www.enginatics.com/reports/gl-daily-rates/
-- Run Report: https://demo.enginatics.com/

select
gdct.user_conversion_type conversion_type, 
gdr.from_currency,
gdr.to_currency,
gdr.conversion_date,
gdr.conversion_rate,
xxen_util.user_name(gdr.created_by) created_by,
xxen_util.client_time(gdr.creation_date) creation_date,
xxen_util.user_name(gdr.last_updated_by) last_updated_by,
xxen_util.client_time(gdr.last_update_date) last_update_date
from
gl_daily_conversion_types gdct,
gl_daily_rates gdr
where
1=1 and
gdct.conversion_type=gdr.conversion_type
order by
gdct.user_conversion_type,
gdr.from_currency,
gdr.to_currency,
gdr.conversion_date desc