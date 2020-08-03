/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Column Templates
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-column-templates/
-- Library Link: https://www.enginatics.com/reports/blitz-report-column-templates/
-- Run Report: https://demo.enginatics.com/

select
xrv.report_name,
xrcs.selection_name template_name,
xxen_util.meaning(xrcs.public_flag,'YES_NO',0) public_flag,
(select count(*) from xxen_report_col_sel_columns xrcsc where xrcs.selection_id=xrcsc.selection_id) column_count,
xxen_util.user_name(xrcs.created_by) created_by,
xrcs.creation_date
&columns
from
xxen_reports_v xrv,
xxen_report_column_selections xrcs,
(select xrcsc.* from xxen_report_col_sel_columns xrcsc where '&show_columns'='Y') xrcsc
where
1=1 and
xrv.report_id=xrcs.report_id and
xrcs.selection_id=xrcsc.selection_id(+)
order by
xrv.report_name,
created_by,
xrcs.selection_name
&column_order_by