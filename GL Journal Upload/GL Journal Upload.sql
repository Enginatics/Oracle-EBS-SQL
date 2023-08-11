/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Journal Upload
-- Description: GL Journal Upload

Templates are provided for the following Journal Types
- Functional Actuals
- Foreign Actuals
- Budget Journals
- Encumbrance Journals
-- Excel Examle Output: https://www.enginatics.com/example/gl-journal-upload/
-- Library Link: https://www.enginatics.com/reports/gl-journal-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
null row_id,
'Vision Operations (USA)' ledger_name,
'Operations' organization,
'CORPORATE 2000' budget,
'Spreadsheet' source,
'Adjustment' category,
'Dummy' journal_description,
'Dummy' journal_reference,
'GBP' currency,
to_char( sysdate,'DD-Mon-YYYY') accounting_date,
'Jan-99' period,
to_char(null) account_alias,
to_char(null) concatenated_segments,
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
0 debit,
0 credit,
'User' conversion_type,
to_char( sysdate,'DD-Mon-YYYY') conversion_date,
1 conversion_rate,
'Dummy' line_description,
'A' actual_flag,
'INV' encumbrance_type,
null attach_upload_file,
null status,
null date_created,
to_number(null) created_by,
to_number(null) user_id,
null summary_flag,
null post_to_suspense_flag
from 
dual 
where
1=1 and
1=0 and
:p_actual_flag=:p_actual_flag and
nvl(:p_foreign_currency_flag,'No')=nvl(:p_foreign_currency_flag,'No') and
:p_create_summary_jnl=:p_create_summary_jnl and
:p_post_to_suspense_flag=:p_post_to_suspense_flag
&not_use_first_block
&report_table_select &report_table_name &report_table_where_clause &success_records
&processed_run