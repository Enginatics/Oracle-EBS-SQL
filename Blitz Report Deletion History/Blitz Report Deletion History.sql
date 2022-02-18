/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Deletion History
-- Description: Shows deleted Blitz Reports and can be used to recover accidentally deleted reports.
The history of deleted reports can be purged completely by running concurrent 'Blitz Report Monitor' with parameter 'Purge delete reports SQL history' set to Yes
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-deletion-history/
-- Library Link: https://www.enginatics.com/reports/blitz-report-deletion-history/
-- Run Report: https://demo.enginatics.com/

select
xrh.report_name,
xrh.version,
xxen_util.user_name(xrh.min_created_by) created_by,
xxen_util.client_time(xrh.min_creation_date) creation_date,
xxen_util.user_name(xrh.created_by) last_updated_by,
xxen_util.client_time(xrh.creation_date) last_update_date,
xrh.sql_text,
xrh.guid
from
(
select
count(*) over (partition by xrh.report_id) version,
max(xrh.creation_date) over (partition by xrh.report_id) max_creation_date,
min(xrh.creation_date) over (partition by xrh.report_id) min_creation_date,
min(xrh.created_by) keep (dense_rank first order by xrh.creation_date) over (partition by xrh.report_id) min_created_by,
xrh.*
from
xxen_reports_h xrh
) xrh
where
xrh.creation_date=xrh.max_creation_date and
not exists (select null from xxen_reports xr where xrh.report_id=xr.report_id)
order by
xrh.creation_date desc