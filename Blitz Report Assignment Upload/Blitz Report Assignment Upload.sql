/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Assignment Upload
-- Description: Upload to maintain Blitz Report assignments.
The upload support creating, deleting or copying assignment and can be run with the following modes:

-Create with 'Create Empty File'=Yes:
Opens an empty Excel file to enter new assignments.

-Create with 'Create Empty File'=blank:
You can query a list of reports that you want create assignments for by report name, category or report type.

-Create, Update:
Allows querying existing assignments, which can be deleted, or copied to a different assignment level.
A frequent use case for customers having custom responsibilities linked to custom applications would be to copy seeded application level Enginatics assignments to custom applications instead.
For this, you can query all Enginatics application level assignments, replace the application names with the corresponding custom applications, and upload the file again. Note that in this scenario, the Action column would show 'Update', but it would create new records, not update when uploading the file.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-assignment-upload/
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
xrav.assignment_level_desc assignment_level,
xrav.level_value assignment_value,
xrav.description,
xrav.block_name form_block,
xrzpvv.parameter_name,
xrzpvv.block_name,
xrzpvv.item_name,
initcap(xrzpvv.id_or_value_dsp) "Id or Value",
xrzpvv.parameter_value_dsp constant_value,
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