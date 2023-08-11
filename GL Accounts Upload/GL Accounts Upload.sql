/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Accounts Upload
-- Description: GL Accounts Upload
================

This upload is to support creating new GL code combinations and update existing one's.
-- Excel Examle Output: https://www.enginatics.com/example/gl-accounts-upload/
-- Library Link: https://www.enginatics.com/reports/gl-accounts-upload/
-- Run Report: https://demo.enginatics.com/

select
to_char(null) action_,
to_char(null) status_,
to_char(null) message_,
to_char(null) ledger,
gcck.concatenated_segments,
ffvv.description account_type,
gcck.summary_flag summary,
--fifs.id_flex_structure_name chart_of_accounts_name,
gcck.enabled_flag enabled,
gcck.start_date_active,
gcck.end_date_active,
gcck.detail_budgeting_allowed,
gcck.detail_posting_allowed,
gcck.code_combination_id,
--gccka.concatenated_segments alternate_account,
--gcck.igi_balanced_budget_flag balanced_budget,
gcck.segment1 gl_segment1,
gcck.segment2 gl_segment2,
gcck.segment3 gl_segment3,
gcck.segment4 gl_segment4,
gcck.segment5 gl_segment5,
gcck.segment6 gl_segment6,
gcck.segment7 gl_segment7,
gcck.segment8 gl_segment8,
gcck.segment9 gl_segment9,
gcck.segment10 gl_segment10
from
gl_code_combinations_kfv gcck,
gl_code_combinations_kfv gccka,
fnd_flex_values_vl ffvv,
fnd_flex_value_sets ffvs,
fnd_id_flex_structures_tl fifs,
gl_ledgers gl
where
1=1 and
gcck.code_combination_id=17021 and
gl.chart_of_accounts_id=gcck.chart_of_accounts_id and
gcck.gl_account_type=ffvv.flex_value and
ffvv.flex_value_set_id=ffvs.flex_value_set_id and
ffvs.flex_value_set_name='GL_SRS_ACCOUNT_TYPE' and
gcck.alternate_code_combination_id=gccka.code_combination_id(+) and
fifs.id_flex_num =gcck.chart_of_accounts_id and
fifs.application_id = 101 and
fifs.id_flex_code = 'GL#' and
fifs.language = userenv ('LANG')
&not_use_first_block
&report_table_select &report_table_name &report_table_where_clause &success_records
&processed_run