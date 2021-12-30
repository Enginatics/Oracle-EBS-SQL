/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Assignments
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-assignments/
-- Library Link: https://www.enginatics.com/reports/blitz-report-assignments/
-- Run Report: https://demo.enginatics.com/

select distinct
xrav.report_name,
xrv.category,
xxen_util.meaning(xrv.enabled,'YES_NO',0) enabled,
xxen_util.meaning(xrav.include_exclude,'INCLUDE_EXCLUDE',0) include_exclude,
xrav.assignment_level_desc level_name,
xrav.level_value value,
xrav.description,
xxen_util.user_name(xrav.created_by) created_by,
xxen_util.client_time(xrav.creation_date) creation_date,
xxen_util.user_name(xrav.last_updated_by) last_updated_by,
xxen_util.client_time(xrav.last_update_date) last_update_date,
xrav.report_id,
xrav.id1
from
xxen_reports_v xrv,
xxen_report_assignments_v xrav
where
1=1 and
xrv.report_id=xrav.report_id
order by
xrav.report_name,
xrav.assignment_level_desc,
xrav.level_value