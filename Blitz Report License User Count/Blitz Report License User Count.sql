/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report License User Count
-- Description: Shows the number of active Blitz Report users at evey month start (looking back the past 60 days)
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-license-user-count/
-- Library Link: https://www.enginatics.com/reports/blitz-report-license-user-count/
-- Run Report: https://demo.enginatics.com/

select
x.month,
(select count(distinct xrr.created_by) from xxen_report_runs xrr where xrr.creation_date>=x.month-60 and xrr.creation_date<x.month) user_count
from
(select add_months(trunc(sysdate,'month'),-level+1) month from dual connect by level<=ceil(months_between(trunc(sysdate,'month'),(select min(xrr.creation_date) from xxen_report_runs xrr)))) x