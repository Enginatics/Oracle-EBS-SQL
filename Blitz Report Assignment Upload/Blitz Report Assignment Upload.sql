/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Assignment Upload
-- Description: Upload to create, update, copy and delete Blitz Report assignments, which make reports available at site, application, request group, responsibility, user, form or function level.
-- Upload modes:
-- - Create with Create Empty File = Yes opens an empty sheet to enter new assignments.
-- - Create with Create Empty File blank lists the reports selected by Report Name starts with, Report Category or Report Type, one row per report, to enter new assignments for them.
-- - Create, Update downloads the existing assignments.
-- An assignment is identified by report, assignment level and assignment value, and by Description at Request Group, Responsibility and Form level, where it names the application. A row matching an existing assignment updates its Include/Exclude, Disabled, Form Block, Users and parameter defaulting; any other row creates a new assignment. Changing the level or value of a downloaded row therefore copies the assignment, for example to copy the seeded Enginatics application level assignments to custom applications. Delete = Yes deletes the assignment, or only the parameter defaulting of the row's Parameter Name.
-- Users limits an Include assignment at Application, Request Group, Responsibility, Form or Function level to the listed users, entered as comma separated user names.
-- At Form level, Form Block limits the assignment to one block of the form, and Parameter Name with either Block Name and Item Name or a Constant Value defaults a report parameter from a form field or a constant when the report is opened from the form. Id or Value tells whether the form field holds the parameter's id or its displayed value.
-- Assignments of uploads can only be maintained with Blitz Report Access System.
-- Excel Example Output: https://www.enginatics.com/example/blitz-report-assignment-upload/
-- Library Link: https://www.enginatics.com/reports/blitz-report-assignment-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
xrv.report_name,
xrv.type_dsp type,
xrv.category,
xxen_util.meaning(nvl(xrav.include_exclude,'I'),'INCLUDE_EXCLUDE',0) include_exclude,
xrav.assignment_level,
xrav.level_value assignment_value,
xrav.description,
(select listagg(fu.user_name,', ') within group (order by fu.user_name) from xxen_report_assignment_users xrau, fnd_user fu where xrav.assignment_id=xrau.assignment_id and xrau.user_id=fu.user_id) users,
xrav.block_name form_block,
xrzpvv.parameter_name,
xrzpvv.block_name,
xrzpvv.item_name,
initcap(xrzpvv.id_or_value_dsp) "Id or Value",
xrzpvv.parameter_value_dsp constant_value,
xxen_util.yes(xrav.disabled) disabled,
xxen_util.user_name(xrav.created_by) created_by,
xxen_util.client_time(xrav.creation_date) creation_date,
xxen_util.user_name(xrav.last_updated_by) last_updated_by,
xxen_util.client_time(xrav.last_update_date) last_update_date,
null delete_,
null upload_row
from
xxen_reports_v xrv,
(select xrav.* from xxen_report_assignments_v xrav where :p_upload_mode<>'C') xrav,
xxen_report_zoom_param_vals_v xrzpvv
where
1=1 and
nvl(:p_create_empty_file,'x')<>'Y' and
xrv.report_id=xrav.report_id(+) and
xrav.assignment_id=xrzpvv.assignment_id(+)
