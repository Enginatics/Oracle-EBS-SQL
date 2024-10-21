/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Code Combinations
-- Description: Parameter 'Show Misclassified Accounts' can be used to identify code combinations, which have a different account type than their flexfield value setup.
There is an Oracle note explaining the implications of correcting these:
R12: Troubleshooting Misclassified Accounts in General Ledger (Doc ID 872162.1)
<a href="https://support.oracle.com/rs?type=doc&amp;id=872162.1" rel="nofollow" target="_blank">https://support.oracle.com/rs?type=doc&amp;id=872162.1</a>

-- Excel Examle Output: https://www.enginatics.com/example/gl-code-combinations/
-- Library Link: https://www.enginatics.com/reports/gl-code-combinations/
-- Run Report: https://demo.enginatics.com/

select
gcck.chart_of_accounts,
xxen_util.meaning(decode(gcck.enabled_flag,'Y','Y'),'YES_NO',0) enabled,
xxen_util.meaning(decode(gcck.preserve_flag,'Y','Y'),'YES_NO',0) preserved,
gcck.concatenated_segments,
nvl(xxen_util.meaning(gcck.gl_account_type,'ACCOUNT_TYPE',0),gcck.gl_account_type) account_type,
(select gst.template_name from gl_summary_templates gst where gcck.template_id=gst.template_id) summary_template,
&balance_columns
gcck.start_date_active date_from,
gcck.end_date_active date_to,
xxen_util.meaning(decode(gcck.detail_posting_allowed,'Y','Y'),'YES_NO',0) posting_allowed,
xxen_util.meaning(decode(gcck.detail_budgeting_allowed,'Y','Y'),'YES_NO',0) budgeting_allowed,
(select gcck2.concatenated_segments from gl_code_combinations_kfv gcck2 where gcck.alternate_code_combination_id=gcck2.code_combination_id) alternate_account,
xxen_util.meaning(decode(gcck.reconciliation_flag,'Y','Y'),'YES_NO',0) reconcile,
xxen_util.meaning(decode(gcck.igi_balanced_budget_flag,'Y','Y'),'YES_NO',0) enforce_balanced_budget,
&segment_columns
&dff_columns
xxen_util.meaning(gcck.flex_val_account_type,'ACCOUNT_TYPE',0) flex_value_account_type,
xxen_util.user_name(gcck.last_updated_by) last_updated_by,
xxen_util.client_time(gcck.last_update_date) last_update_date
from
(
select
gcck.*,
substr((select ffv.compiled_value_attributes from fnd_flex_values ffv where gcck.flex_value_set_id=ffv.flex_value_set_id and gcck.account_segment_value=ffv.flex_value and ffv.parent_flex_value_low is null),5,1) flex_val_account_type
from
(
select
decode(gcck.account_segment,
'SEGMENT1',gcck.segment1,
'SEGMENT2',gcck.segment2,
'SEGMENT3',gcck.segment3,
'SEGMENT4',gcck.segment4,
'SEGMENT5',gcck.segment5,
'SEGMENT6',gcck.segment6,
'SEGMENT7',gcck.segment7,
'SEGMENT8',gcck.segment8,
'SEGMENT9',gcck.segment9,
'SEGMENT10',gcck.segment10,
'SEGMENT11',gcck.segment11,
'SEGMENT12',gcck.segment12,
'SEGMENT13',gcck.segment13
) account_segment_value,
fifs.flex_value_set_id,
gcck.*
from
(
select
fifsv.id_flex_structure_name chart_of_accounts,
(
select
fsav.application_column_name
from
fnd_segment_attribute_values fsav
where
gcck.chart_of_accounts_id=fsav.id_flex_num and
fsav.application_id=101 and
fsav.id_flex_code='GL#' and
fsav.segment_attribute_type='GL_ACCOUNT' and
fsav.attribute_value='Y'
) account_segment,
gcck.*
from
gl_code_combinations_kfv gcck,
fnd_id_flex_structures_vl fifsv
where
1=1 and
gcck.chart_of_accounts_id=fifsv.id_flex_num and
fifsv.id_flex_code='GL#' and
fifsv.application_id=101
) gcck,
fnd_id_flex_segments fifs
where
gcck.chart_of_accounts_id=fifs.id_flex_num(+) and
gcck.account_segment=fifs.application_column_name(+) and
fifs.application_id(+)=101 and
fifs.id_flex_code(+)='GL#'
) gcck
) gcck,
(
select distinct
gb.code_combination_id,
gl.name ledger,
gb.currency_code,
max(gb.end_balance) keep (dense_rank last order by gp.period_year, gp.period_num) over (partition by gb.code_combination_id, gl.ledger_id, gb.currency_code) end_balance,
max(gb.period_name) keep (dense_rank last order by gp.period_year, gp.period_num) over (partition by gb.code_combination_id, gl.ledger_id, gb.currency_code) period_name,
max(gp.end_date) keep (dense_rank last order by gp.period_year, gp.period_num) over (partition by gb.code_combination_id, gl.ledger_id, gb.currency_code) end_date,
gb.ledger_id
from
(select nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0)+nvl(gb.period_net_dr,0)-nvl(gb.period_net_cr,0) end_balance, gb.* from gl_balances gb) gb,
gl_ledgers gl,
gl_periods gp
where
2=2 and
'&show_balances'='Y' and
gb.ledger_id=gl.ledger_id and
gl.period_set_name=gp.period_set_name and
gb.period_name=gp.period_name and
gb.actual_flag='A' and
nvl(gb.translated_flag,'x')!='R'
) gb,
(
select distinct
gjl.ledger_id,
gjl.code_combination_id,
gjh.currency_code,
max(gjl.effective_date) over (partition by gjl.ledger_id, gjl.code_combination_id, gjh.currency_code) last_posted_date
from
gl_je_headers gjh,
gl_je_lines gjl
where
gjh.je_header_id=gjl.je_header_id and
gjl.status='P'
) gjl
where
3=3 and
gcck.code_combination_id=gb.code_combination_id(+) and
gb.ledger_id=gjl.ledger_id(+) and
gb.code_combination_id=gjl.code_combination_id(+) and
gb.currency_code=gjl.currency_code(+)
order by
gcck.chart_of_accounts,
summary_template,
gcck.concatenated_segments
&order_by