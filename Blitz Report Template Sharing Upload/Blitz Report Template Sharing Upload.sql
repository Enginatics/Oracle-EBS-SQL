/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Template Sharing Upload
-- Description: Upload to maintain Blitz Report template sharing - which users, responsibilities, or the whole site can see and use a report template (Excel layout).
-- The upload can be run in the following modes:
-- -Create with 'Create Empty File'=Yes:
-- Opens an empty Excel file to enter new template shares.
-- -Create with 'Create Empty File'=blank:
-- Query the templates you want to share, filtered by report name, category or sharing level.
-- -Create, Update:
-- Query existing template shares, which can be deleted or copied to a different sharing level.
-- Sharing levels:
-- -Site shares the template with the whole system (all responsibilities and users).
-- -Responsibility shares it with one responsibility - enter the responsibility name in Shared With and its owning application in Description.
-- -User shares it with one named user.
-- Note: Site sharing is mutually exclusive with specific shares. Sharing a template at Site level removes any existing Responsibility or User shares for that template, and adding a Responsibility or User share removes any existing Site share - mirroring the Blitz Report template setup form.
-- Excel Example Output: https://www.enginatics.com/example/blitz-report-template-sharing-upload/
-- Library Link: https://www.enginatics.com/reports/blitz-report-template-sharing-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
xrtv.report_name,
xrtv.template_name,
xrtv.owner,
xrtsv.sharing_level_desc sharing_level,
xrtsv.level_value shared_with,
fav.application_name description,
xxen_util.user_name(xrtsv.created_by) created_by,
xxen_util.client_time(xrtsv.creation_date) creation_date,
null delete_,
null upload_row
from
xxen_report_templates_v xrtv,
(select xrtsv.* from xxen_report_template_sharing_v xrtsv where 2=2) xrtsv,
fnd_application_vl fav
where
1=1 and
nvl(:p_create_empty_file,'x')<>'Y' and
xrtv.template_id=xrtsv.template_id(+) and
xrtsv.id2=fav.application_id(+)
