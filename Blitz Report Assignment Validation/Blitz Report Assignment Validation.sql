/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Assignment Validation
-- Description: Lists every Blitz Report with the number of assignments it has at each assignment level, so you can validate that all reports are assigned.

Each level column counts the distinct included assignment targets at that level (Site, Application, Request Group, Responsibility, User, Form, Function, Report). The Excluded column counts exclusion assignments. The zero_to_null function leaves a blank cell where there is no assignment, so reports missing an assignment stand out at a glance - a row that is completely blank across the assignment columns is not assigned to anyone.

Use the Category, Not in Category and Type parameters to limit the scope. Set 'Not Assigned Only' to Yes to list only reports that have no include assignment at any level, or pick a level in 'Not Assigned at Level' to find reports missing an assignment at one specific level.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-assignment-validation/
-- Library Link: https://www.enginatics.com/reports/blitz-report-assignment-validation/
-- Run Report: https://demo.enginatics.com/

select
xrv.report_name,
xxen_util.application_name(substr(xrv.report_name,1,instr(xrv.report_name,' ')-1)) application,
xrv.type_dsp type,
xrv.category,
xxen_util.yes(xrv.disabled) disabled,
xxen_util.zero_to_null(xra.total_assignments) total_assignments,
xxen_util.zero_to_null(xra.site_assignments) site_assignments,
xxen_util.zero_to_null(xra.application_assignments) application_assignments,
xxen_util.zero_to_null(xra.request_group_assignments) request_group_assignments,
xxen_util.zero_to_null(xra.responsibility_assignments) responsibility_assignments,
xxen_util.zero_to_null(xra.user_assignments) user_assignments,
xxen_util.zero_to_null(xra.form_assignments) form_assignments,
xxen_util.zero_to_null(xra.function_assignments) function_assignments,
xxen_util.zero_to_null(xra.report_assignments) report_assignments,
xxen_util.zero_to_null(xra.excluded_assignments) excluded_assignments,
xxen_util.user_name(xrv.created_by) created_by,
xxen_util.client_time(xrv.creation_date) creation_date,
xxen_util.user_name(xrv.last_updated_by) last_updated_by,
xxen_util.client_time(xrv.last_update_date) last_update_date,
xrv.report_id
from
xxen_reports_v xrv,
(
select
xra.report_id,
count(distinct case when xra.include_exclude='I' then xra.assignment_level||':'||xra.id1||','||xra.id2 end) total_assignments,
count(distinct case when xra.include_exclude='I' and xra.assignment_level='Site' then xra.id1||','||xra.id2 end) site_assignments,
count(distinct case when xra.include_exclude='I' and xra.assignment_level='Application' then xra.id1||','||xra.id2 end) application_assignments,
count(distinct case when xra.include_exclude='I' and xra.assignment_level='Request Group' then xra.id1||','||xra.id2 end) request_group_assignments,
count(distinct case when xra.include_exclude='I' and xra.assignment_level='Responsibility' then xra.id1||','||xra.id2 end) responsibility_assignments,
count(distinct case when xra.include_exclude='I' and xra.assignment_level='User' then xra.id1||','||xra.id2 end) user_assignments,
count(distinct case when xra.include_exclude='I' and xra.assignment_level='Form' then xra.id1||','||xra.id2 end) form_assignments,
count(distinct case when xra.include_exclude='I' and xra.assignment_level='Function' then xra.id1||','||xra.id2 end) function_assignments,
count(distinct case when xra.include_exclude='I' and xra.assignment_level='Report' then xra.id1||','||xra.id2 end) report_assignments,
count(distinct case when xra.include_exclude='E' then xra.assignment_level||':'||xra.id1||','||xra.id2 end) excluded_assignments
from
xxen_report_assignments xra
group by
xra.report_id
) xra
where
1=1 and
2=2 and
3=3 and
xrv.report_id=xra.report_id(+)
order by
xra.total_assignments nulls first,
xrv.report_name