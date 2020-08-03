/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Category Assignments
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-category-assignments/
-- Library Link: https://www.enginatics.com/reports/blitz-report-category-assignments/
-- Run Report: https://demo.enginatics.com/

select
xrv.report_name,
xrcv.category,
xxen_util.user_name(xrca.created_by) created_by,
xrca.creation_date
from
xxen_reports_v xrv,
xxen_report_category_assigns xrca,
xxen_report_categories_v xrcv
where
xrv.report_id=xrca.report_id and
xrca.category_id=xrcv.category_id
order by
xrv.report_name,
xrcv.category