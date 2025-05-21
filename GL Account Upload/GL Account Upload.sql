/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Account Upload
-- Description: This upload allows creation of new GL code combinations and update of existing ones. For creation of new code combinations, the upload requires the setup to allow dynamic inserts for code combinations.
-- Excel Examle Output: https://www.enginatics.com/example/gl-account-upload/
-- Library Link: https://www.enginatics.com/reports/gl-account-upload/
-- Run Report: https://demo.enginatics.com/

select
to_char(null) action_,
to_char(null) status_,
to_char(null) message_,
null modified_columns_,
gl.name ledger,
gcck.concatenated_segments,
gl_flexfields_pkg.get_concat_description(gl.chart_of_accounts_id,gcck.code_combination_id) description,
ffvv.description account_type,
gcck.segment1 gl_segment1,
gcck.segment2 gl_segment2,
gcck.segment3 gl_segment3,
gcck.segment4 gl_segment4,
gcck.segment5 gl_segment5,
gcck.segment6 gl_segment6,
gcck.segment7 gl_segment7,
gcck.segment8 gl_segment8,
gcck.segment9 gl_segment9,
gcck.segment10 gl_segment10,
xxen_util.meaning(gcck.summary_flag,'YES_NO',0) summary,
xxen_util.meaning(gcck.enabled_flag,'YES_NO',0) enabled,
gcck.start_date_active,
gcck.end_date_active,
xxen_util.meaning(gcck.detail_budgeting_allowed,'YES_NO',0) detail_budgeting_allowed,
xxen_util.meaning(gcck.detail_posting_allowed,'YES_NO',0) detail_posting_allowed,
gcck.code_combination_id
from
gl_code_combinations_kfv gcck,
gl_code_combinations_kfv gccka,
fnd_flex_values_vl ffvv,
fnd_flex_value_sets ffvs,
fnd_id_flex_structures_tl fifs,
gl_ledgers gl
where
1=1 and
gl.chart_of_accounts_id=gcck.chart_of_accounts_id and
gcck.gl_account_type=ffvv.flex_value and
ffvv.flex_value_set_id=ffvs.flex_value_set_id and
ffvs.flex_value_set_name='GL_SRS_ACCOUNT_TYPE' and
gcck.alternate_code_combination_id=gccka.code_combination_id(+) and
fifs.id_flex_num=gcck.chart_of_accounts_id and
fifs.application_id=101 and
fifs.id_flex_code='GL#' and
fifs.language=userenv ('lang') and
trunc(sysdate) between nvl(gcck.start_date_active,trunc(sysdate)) and nvl(gcck.end_date_active,trunc(sysdate))
&not_use_first_block
&report_table_select &report_table_name &report_table_where_clause &success_records
&processed_run