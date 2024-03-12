/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Discoverer and Blitz Report Users
-- Description: Shows the user adoption for companies replacing Discoverer with Blitz Report in a phased approach.
The report shows the number of Discoverer worksheets and Blitz Report executed every month per user, to help identifying the users still using Discoverer instead of Blitz Report.
-- Excel Examle Output: https://www.enginatics.com/example/dis-discoverer-and-blitz-report-users/
-- Library Link: https://www.enginatics.com/reports/dis-discoverer-and-blitz-report-users/
-- Run Report: https://demo.enginatics.com/

select
last_day(nvl(eqs.month,xrr.month)) month_end,
xxen_util.user_name(nvl(xrr.created_by,eqs.created_by)) created_by,
(select fu.email_address from fnd_user fu where nvl(xrr.created_by,eqs.created_by)=fu.user_id) email_address,
eqs.count discoverer_count,
xrr.count blitz_count,
eqs.reports discoverer_reports_count,
xrr.reports blitz_reports_count,
sum(case when eqs.count is not null and xrr.count is null then 1 end) over (partition by nvl(eqs.month,xrr.month)) total_discoverer_only,
sum(case when xrr.count is not null and eqs.count is not null then 1 end) over (partition by nvl(eqs.month,xrr.month)) total_both,
sum(case when xrr.count is not null and eqs.count is null then 1 end) over (partition by nvl(eqs.month,xrr.month)) total_blitz_only,
count(*) over (partition by nvl(eqs.month,xrr.month)) total
from
(
select distinct
substr(eqs.qs_created_by,2) created_by,
trunc(eqs.qs_created_date,'month') month,
count(*) over (partition by eqs.qs_created_by, trunc(eqs.qs_created_date,'month')) count,
count(distinct eqs.qs_doc_name||': '||eqs.qs_doc_details||' ('||eqs.qs_doc_owner) over (partition by eqs.qs_created_by, trunc(eqs.qs_created_date,'month')) reports
from
&eul.eul5_qpp_stats eqs
where
1=1 and
eqs.qs_created_by like '#%'
) eqs
full join
(
select distinct
xrr.created_by,
trunc(xrr.creation_date,'month') month,
count(*) over (partition by xrr.created_by, trunc(xrr.creation_date,'month')) count,
count(distinct xrr.report_id) over (partition by xrr.created_by, trunc(xrr.creation_date,'month')) reports
from
xxen_report_runs xrr
where
2=2
) xrr
on
eqs.created_by=xrr.created_by and
eqs.month=xrr.month
order by
month_end desc,
nvl2(discoverer_count,1,2),
nvl2(blitz_count,2,1),
discoverer_count desc nulls last,
blitz_count desc nulls last,
created_by