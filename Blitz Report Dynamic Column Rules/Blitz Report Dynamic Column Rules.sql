/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Dynamic Column Rules
-- Description: 
-- Excel Example Output: https://www.enginatics.com/example/blitz-report-dynamic-column-rules/
-- Library Link: https://www.enginatics.com/reports/blitz-report-dynamic-column-rules/
-- Run Report: https://demo.enginatics.com/

select
xrdcr.rule_name,
xxen_util.yes(xrdcr.enabled) enabled,
xrv.report_name,
xrv.category,
xrv.type_dsp report_type,
(select count(*) from xxen_report_dyn_col_rule_rpts xrdcrr2 where xrdcrr2.rule_id=xrdcr.rule_id) report_count,
xrdcr.rule_sql,
xxen_util.user_name(xrdcrr.created_by) assigned_by,
xxen_util.client_time(xrdcrr.creation_date) assigned_date,
xxen_util.user_name(xrdcr.created_by) rule_created_by,
xxen_util.client_time(xrdcr.creation_date) rule_creation_date,
xxen_util.user_name(xrdcr.last_updated_by) rule_last_updated_by,
xxen_util.client_time(xrdcr.last_update_date) rule_last_update_date,
xrdcr.rule_id,
xrv.report_id
from
xxen_report_dynamic_col_rules xrdcr,
xxen_report_dyn_col_rule_rpts xrdcrr,
xxen_reports_v xrv
where
1=1 and
xrdcr.rule_id=xrdcrr.rule_id(+) and
xrdcrr.report_id=xrv.report_id(+)
order by
xrdcr.rule_name,
xrv.report_name
