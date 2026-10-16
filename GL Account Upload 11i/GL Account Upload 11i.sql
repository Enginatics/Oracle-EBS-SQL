/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Account Upload 11i
-- Description: This upload allows creation of new GL code combinations and update of existing ones. For creation of new code combinations, the upload requires the setup to allow dynamic inserts for code combinations.
-- Excel Example Output: https://www.enginatics.com/example/gl-account-upload-11i/
-- Library Link: https://www.enginatics.com/reports/gl-account-upload-11i/
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
gcck.segment11 gl_segment11,
gcck.segment12 gl_segment12,
gcck.segment13 gl_segment13,
gcck.segment14 gl_segment14,
gcck.segment15 gl_segment15,
xxen_util.meaning(gcck.summary_flag,'YES_NO',0) summary,
xxen_util.meaning(gcck.enabled_flag,'YES_NO',0) enabled,
gcck.start_date_active,
gcck.end_date_active,
xxen_util.meaning(gcck.detail_budgeting_allowed,'YES_NO',0) detail_budgeting_allowed,
xxen_util.meaning(gcck.detail_posting_allowed,'YES_NO',0) detail_posting_allowed,
xxen_util.display_flexfield_context(101,'GL_CODE_COMBINATIONS',gcck.context) attribute_context,
xxen_util.display_flexfield_value(101,'GL_CODE_COMBINATIONS',gcck.context,'ATTRIBUTE1',gcck.rowid,gcck.attribute1) gl_account_attribute1,
xxen_util.display_flexfield_value(101,'GL_CODE_COMBINATIONS',gcck.context,'ATTRIBUTE2',gcck.rowid,gcck.attribute2) gl_account_attribute2,
xxen_util.display_flexfield_value(101,'GL_CODE_COMBINATIONS',gcck.context,'ATTRIBUTE3',gcck.rowid,gcck.attribute3) gl_account_attribute3,
xxen_util.display_flexfield_value(101,'GL_CODE_COMBINATIONS',gcck.context,'ATTRIBUTE4',gcck.rowid,gcck.attribute4) gl_account_attribute4,
xxen_util.display_flexfield_value(101,'GL_CODE_COMBINATIONS',gcck.context,'ATTRIBUTE5',gcck.rowid,gcck.attribute5) gl_account_attribute5,
xxen_util.display_flexfield_value(101,'GL_CODE_COMBINATIONS',gcck.context,'ATTRIBUTE6',gcck.rowid,gcck.attribute6) gl_account_attribute6,
xxen_util.display_flexfield_value(101,'GL_CODE_COMBINATIONS',gcck.context,'ATTRIBUTE7',gcck.rowid,gcck.attribute7) gl_account_attribute7,
xxen_util.display_flexfield_value(101,'GL_CODE_COMBINATIONS',gcck.context,'ATTRIBUTE8',gcck.rowid,gcck.attribute8) gl_account_attribute8,
xxen_util.display_flexfield_value(101,'GL_CODE_COMBINATIONS',gcck.context,'ATTRIBUTE9',gcck.rowid,gcck.attribute9) gl_account_attribute9,
xxen_util.display_flexfield_value(101,'GL_CODE_COMBINATIONS',gcck.context,'ATTRIBUTE10',gcck.rowid,gcck.attribute10) gl_account_attribute10,
gcck.code_combination_id
from
gl_code_combinations_kfv gcck,
fnd_flex_values_vl ffvv,
fnd_flex_value_sets ffvs,
fnd_id_flex_structures_tl fifs,
xxen_gl_ledgers_v gl
where
1=1 and
gl.chart_of_accounts_id=gcck.chart_of_accounts_id and
gcck.gl_account_type=ffvv.flex_value and
ffvv.flex_value_set_id=ffvs.flex_value_set_id and
ffvs.flex_value_set_name='GL_SRS_ACCOUNT_TYPE' and
fifs.id_flex_num=gcck.chart_of_accounts_id and
fifs.application_id=101 and
fifs.id_flex_code='GL#' and
fifs.language=userenv ('lang') and
nvl(gcck.summary_flag,'N')<>'Y'
