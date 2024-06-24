/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Default Templates
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-default-templates/
-- Library Link: https://www.enginatics.com/reports/blitz-report-default-templates/
-- Run Report: https://demo.enginatics.com/

select
xrv.report_name,
xrv.type_dsp type,
xrv.category,
xrt.template_name,
xxen_util.meaning(nvl2(xrdt.user_id,null,'Y'),'YES_NO',0) global_default,
xxen_util.user_name(xrdt.user_id) user_name,
xxen_util.user_name(xrdt.created_by) created_by,
xxen_util.client_time(xrdt.creation_date) creation_date,
xxen_util.user_name(xrdt.last_updated_by) last_updated_by,
xxen_util.client_time(xrdt.last_update_date) last_update_date
from
xxen_reports_v xrv,
xxen_report_default_templates xrdt,
xxen_report_templates xrt
where
1=1 and
xrv.report_id=xrdt.report_id and
xrdt.template_id=xrt.template_id(+)
order by
xrv.report_name,
nvl2(xrdt.user_id,null,'Y'),
user_name