/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Translations
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-translations/
-- Library Link: https://www.enginatics.com/reports/blitz-report-translations/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
max(case when length(xrt.report_name)<>lengthb(xrt.report_name) or length(xrt.description)<>lengthb(xrt.description) or length(xrt.required_parameters_message)<>lengthb(xrt.required_parameters_message) then 'Y' end) over (partition by xrt.report_id) has_multibyte,
xrt.source_lang,
max(decode(xrt.language,'US',xrt.report_name)) over (partition by xrt.report_id) report_name_us,
xrt.report_name,
xrt.description,
max(decode(xrt.language,'US',xrt.description)) over (partition by xrt.report_id) description_us,
xrt.required_parameters_message,
max(decode(xrt.language,'US',xrt.required_parameters_message)) over (partition by xrt.report_id) required_parameters_message_us,
xxen_util.user_name(xrt.created_by) created_by,
xxen_util.client_time(xrt.creation_date) creation_date,
xxen_util.user_name(xrt.last_updated_by) last_updated_by,
xxen_util.client_time(xrt.last_update_date) last_update_date
from
xxen_reports_tl xrt
) x
where
1=1
order by
x.report_name_us,
x.source_lang