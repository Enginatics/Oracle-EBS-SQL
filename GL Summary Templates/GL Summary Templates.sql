/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Summary Templates
-- Description: Master data report showing GL summary and concatenation templates based on ledger, company, department, account, sub-account, and product segments, and including information for the group, ledger set, ledger, ledger category, currency and chart of accounts.
-- Excel Examle Output: https://www.enginatics.com/example/gl-summary-templates/
-- Library Link: https://www.enginatics.com/reports/gl-summary-templates/
-- Run Report: https://demo.enginatics.com/

select
gl.name ledger,
gst.template_name,
gst.description,
&segment_columns
gst.concatenated_description,
gst.start_actuals_period_name earliest_period,
xxen_util.meaning(gst.status,'SUMMARY_STATUS',101) status,
xxen_util.user_name(gst.created_by) created_by,
gst.creation_date,
xxen_util.user_name(gst.last_updated_by) last_updated_by,
gst.last_update_date,
gst.template_id
from
gl_ledgers gl,
gl_summary_templates gst
where
1=1 and
gl.ledger_id=gst.ledger_id
order by
gl.name,
gst.template_name