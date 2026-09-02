/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Category Assignment Upload
-- Description: Upload to maintain Blitz Report category assignments - the categories that reports and uploads are grouped under.

Run modes:

- Create with 'Create Empty File' = Yes: opens an empty Excel file to enter new report and category rows.

- Create with 'Create Empty File' = blank: queries a list of reports (by name, category or type) as blank rows to assign categories to.

- Create, Update: queries existing category assignments, which can be removed by setting the Delete column to Yes.

Enter any Category name. If the category does not exist yet, it is created automatically in all installed languages and the report is assigned to it. Set Delete = Yes to remove a report from a category; the category itself is kept even if it becomes empty.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-category-assignment-upload/
-- Library Link: https://www.enginatics.com/reports/blitz-report-category-assignment-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
xrv.report_name,
xrv.type_dsp type,
xrcav.category,
xxen_util.user_name(xrcav.created_by) created_by,
xxen_util.client_time(xrcav.creation_date) creation_date,
null delete_,
null upload_row
from
xxen_reports_v xrv,
(select xrcav.* from xxen_report_category_assigns_v xrcav where :p_upload_mode<>'C') xrcav
where
1=1 and
nvl(xrv.type,'x')<>'S' and
nvl(:p_create_empty_file,'x')<>'Y' and
xrv.report_id=xrcav.report_id(+)