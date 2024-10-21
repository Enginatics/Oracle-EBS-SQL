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
to_char(null) summary_row_id,
to_char(null) summary_bc_row_id,
to_number(null) template_id_,
to_char(null) request_id_,
to_char(null) request_log,
to_char(null) template_name,
to_char(null) description,
to_char(null) earliest_period,
--to_char(null) account_category_code, 'P'
to_char(null) ledger,
--to_char(null) status, 'A'
--to_number(null) max_code_combination_id, -1
to_char(null) gl_segment1,
to_char(null) gl_segment2,
to_char(null) gl_segment3,
to_char(null) gl_segment4,
to_char(null) gl_segment5,
to_char(null) gl_segment6,
to_char(null) gl_segment7,
to_char(null) gl_segment8,
to_char(null) gl_segment9,
to_char(null) gl_segment10,
to_char(null) gl_segment11,
to_char(null) gl_segment12,
to_char(null) gl_segment13,
to_char(null) gl_segment14,
to_char(null) gl_segment15,
to_char(null) gl_segment16,
to_char(null) gl_segment17,
to_char(null) gl_segment18,
to_char(null) gl_segment19,
to_char(null) gl_segment20,
to_char(null) gl_segment21,
to_char(null) gl_segment22,
to_char(null) gl_segment23,
to_char(null) gl_segment24,
to_char(null) gl_segment25,
to_char(null) gl_segment26,
to_char(null) gl_segment27,
to_char(null) gl_segment28,
to_char(null) gl_segment29,
to_char(null) gl_segment30,
to_char(null) concatenated_description,
to_char(null) funds_check_level,
to_char(null) debit_or_credit,
to_char(null) amount_type,
to_char(null) boundary,
to_char(null) funding_budget
from dual
where
1=1
&not_use_first_block
&report_table_select 
&report_table_name 
&report_table_where_clause 
&success_records
&processed_run