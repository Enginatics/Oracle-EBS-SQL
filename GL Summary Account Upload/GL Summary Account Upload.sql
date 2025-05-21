/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Summary Account Upload
-- Description: This upload can be used to import Summary Account Templates.
-- Excel Examle Output: https://www.enginatics.com/example/gl-summary-account-upload/
-- Library Link: https://www.enginatics.com/reports/gl-summary-account-upload/
-- Run Report: https://demo.enginatics.com/

select
to_char(null) action_,
to_char(null) status_,
to_char(null) message_,
null modified_columns_,
to_char(null) summary_row_id,
to_char(null) summary_bc_row_id,
to_number(null) template_id_,
to_char(null) request_id_,
to_char(null) request_log,
gst.template_name,
to_char(null) add_or_delete,
gst.description,
gst.start_actuals_period_name earliest_period,
gl.name ledger,
gst.segment1_type gl_segment1,
gst.segment2_type gl_segment2,
gst.segment3_type gl_segment3,
gst.segment4_type gl_segment4,
gst.segment5_type gl_segment5,
gst.segment6_type gl_segment6,
gst.segment7_type gl_segment7,
gst.segment8_type gl_segment8,
gst.segment9_type gl_segment9,
gst.segment10_type gl_segment10,
gst.segment11_type gl_segment11,
gst.segment12_type gl_segment12,
gst.segment13_type gl_segment13,
gst.segment14_type gl_segment14,
gst.segment15_type gl_segment15,
gst.segment16_type gl_segment16,
gst.segment17_type gl_segment17,
gst.segment18_type gl_segment18,
gst.segment19_type gl_segment19,
gst.segment20_type gl_segment20,
gst.segment21_type gl_segment21,
gst.segment22_type gl_segment22,
gst.segment23_type gl_segment23,
gst.segment24_type gl_segment24,
gst.segment25_type gl_segment25,
gst.segment26_type gl_segment26,
gst.segment27_type gl_segment27,
gst.segment28_type gl_segment28,
gst.segment29_type gl_segment29,
gst.segment30_type gl_segment30,
gst.concatenated_description,
flvv1.meaning funds_check_level,
flvv2.description debit_or_credit,
flvv3.description amount_type,
flvv4.meaning boundary,
gbrjv.budget_name funding_budget
from
gl_summary_templates gst,
gl_summary_bc_options gsbo,
fnd_lookup_values_vl flvv1,
fnd_lookup_values_vl flvv2,
fnd_lookup_values_vl flvv3,
fnd_lookup_values_vl flvv4,
gl_budgets_require_journals_v gbrjv,
gl_ledgers gl
where
1=1 and
gst.status='F' and
gl.ledger_id=gst.ledger_id and
gst.template_id=gsbo.template_id(+) and
gsbo.funding_budget_version_id=gbrjv.budget_version_id(+) and
gl.ledger_id=gbrjv.ledger_id(+) and
gsbo.funds_check_level_code=flvv1.lookup_code(+) and
flvv1.lookup_type(+)='FUNDS_CHECK_LEVEL' and
gsbo.dr_cr_code=flvv2.lookup_code(+) and
flvv2.lookup_type(+)='DR_CR' and
gsbo.amount_type=flvv3.lookup_code(+) and
flvv3.lookup_type(+)='PTD_YTD' and
gsbo.boundary_code=flvv4.lookup_code(+) and
flvv4.lookup_type(+)='BOUNDARY_TYPE'