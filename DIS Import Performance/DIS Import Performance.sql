/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Import Performance
-- Description: Simple query to review Discoverer worksheet to Blitz Report import performance, when running the mass migration script.
https://www.enginatics.com/user-guide/#Discoverer_Worksheet
-- Excel Examle Output: https://www.enginatics.com/example/dis-import-performance/
-- Library Link: https://www.enginatics.com/reports/dis-import-performance/
-- Run Report: https://demo.enginatics.com/

select
xrv.report_name,
xrv.category,
xxen_util.user_name(xrv.created_by) created_by,
xrv.creation_date,
xxen_util.time((xrv.creation_date-lag(xrv.creation_date) over (order by xrv.report_id))*86400) time
from
xxen_reports_v xrv
where
1=1
order by
xrv.report_id desc