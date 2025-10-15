/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
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

Submit for Approval
---------------------------
Imported Journals requiring approval can be submitted for approval after import if they are eligble.

Submit Journal Post
---------------------------
Imported Journals can be submitted for immediate posting after import if they are eligible.
In order to submit journals for posting, the current responsibility must have access to post journals.
-- Excel Examle Output: https://www.enginatics.com/example/gl-journal-upload/
-- Library Link: https://www.enginatics.com/reports/gl-journal-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
chartorowid(null) row_id,
to_number(null) group_id,
'Vision Operations (USA)' ledger_name,
'Operations' organization,
'CORPORATE 2000' budget,
'Spreadsheet' source,
'Adjustment' category,
'Yes' check_if_journal_balanced,
'Dummy' batch_name,
'Dummy' approval_status,
'Dummy' batch_description,
'Dummy' journal_name,
'Dummy' journal_description,
'Dummy' journal_reference,
'GBP' currency,
sysdate accounting_date,
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
'Yes'  reverse_journal,
'Jan-99' reversal_period,
'User' conversion_type,
sysdate conversion_date,
1 conversion_rate,
'Dummy' line_description,
'A' actual_flag,
'INV' encumbrance_type,
null attach_upload_file,
null status,
sysdate date_created,
to_number(null) created_by,
to_number(null) user_id,
null summary_flag,
null post_to_suspense_flag,
null submit_approval,
null submit_posting,
null line_dff_context,
null gl_je_line_attribute1,
null gl_je_line_attribute2,
null gl_je_line_attribute3,
null gl_je_line_attribute4,
null gl_je_line_attribute5,
null gl_je_line_attribute6,
null gl_je_line_attribute7,
null gl_je_line_attribute8,
null gl_je_line_attribute9,
null gl_je_line_attribute10,
null attachment_category_,
null attachment_title_,
null attachment_description_,
null attachment_type_,
null attachment_content_,
null attachment_file_id_,
0 upload_row
from
dual
where
1=1 and
1=0 and
:p_actual_flag=:p_actual_flag and
nvl(:p_foreign_currency_flag,'No')=nvl(:p_foreign_currency_flag,'No') and
:p_create_summary_jnl=:p_create_summary_jnl and
:p_post_to_suspense_flag=:p_post_to_suspense_flag