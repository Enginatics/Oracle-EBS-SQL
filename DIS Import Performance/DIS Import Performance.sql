/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Import Performance
-- Description: Query to review Discoverer to Blitz Report import performance, after running the 'Blitz Report Discoverer Import' concurrent program or mass migration script.
<a href="https://www.enginatics.com/user-guide/#Discoverer_Worksheet" rel="nofollow" target="_blank">https://www.enginatics.com/user-guide/#Discoverer_Worksheet</a>
-- Excel Examle Output: https://www.enginatics.com/example/dis-import-performance/
-- Library Link: https://www.enginatics.com/reports/dis-import-performance/
-- Run Report: https://demo.enginatics.com/

select
x.*,
xxen_util.time(x.seconds) time
from
(
select
xrv.report_name,
regexp_substr(xrv.description,'Object IDs: (.+)',1,1,null,1) object_use_key,
xrv.category,
xxen_util.user_name(xrv.created_by) created_by,
xxen_util.client_time(xrv.creation_date) creation_date,
(xrv.creation_date-lag(xrv.creation_date) over (order by xrv.report_id))*86400 seconds
from
xxen_reports_v xrv
where
1=1
order by
xrv.report_id desc
) x