/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Recurring Journal and Budget Formulas
-- Description: Lists Oracle General Ledger recurring journal and budget formula definitions - batches, journal entries, lines and each line's formula steps - with the account code combinations exploded into one column per Accounting Flexfield segment.
-- Each row is one formula step. The line account, which is the account the generated journal posts to, and the formula account, which is the account a step reads a balance from, are both shown segment by segment. Company, Department, Account, Sub-Account and the remaining segments of your chart of accounts therefore become individual columns that can be sorted and filtered in Excel.
-- Replaces the Oracle standard report 'Other - Recurring Formula Listing' (GLXRLRFL), which prints concatenated code combinations in a fixed page layout. Definition access set security on recurring batches is applied exactly as in the standard report.
-- Use the Ledger, Batch Name, Journal Entry Name and Category parameters to focus on a subset, for example intercompany or intracompany batches, and the per segment like, From and To parameters to restrict the accounts.
-- Excel Example Output: https://www.enginatics.com/example/gl-recurring-journal-and-budget-formulas/
-- Library Link: https://www.enginatics.com/reports/gl-recurring-journal-and-budget-formulas/
-- Run Report: https://demo.enginatics.com/

select
gl.name ledger,
grb.name batch_name,
grb.description batch_description,
xxen_util.description(grb.recurring_batch_type,'GL_RECURRING_BATCH_TYPE',101) batch_type,
xxen_util.description(decode(grb.budget_flag,'Y','B','A'),'BATCH_TYPE',101) batch_balance_type,
xxen_util.yes(grb.allocation_flag) "MassAllocation Batch",
grb.period_set_name calendar,
grb.accounted_period_type period_type,
grb.last_executed_period_name batch_last_executed_period,
grb.last_executed_date batch_last_executed_date,
grh.name journal_entry_name,
(select gjcv.user_je_category_name from gl_je_categories_vl gjcv where grh.je_category_name=gjcv.je_category_name) category,
grh.currency_code journal_currency,
(select gdct.user_conversion_type from gl_daily_conversion_types gdct where grh.currency_conversion_type=gdct.conversion_type) conversion_type,
xxen_util.yes(grh.enabled_flag) enabled,
grh.start_date_active,
grh.end_date_active,
grh.last_executed_period_name journal_last_executed_period,
grh.last_executed_date journal_last_executed_date,
grl.recurring_line_num line_number,
grl.description line_description,
grl.entered_dr,
grl.entered_cr,
grl.entered_currency_code line_currency,
gcck.concatenated_segments line_account,
&segment_columns
grlcr.rule_num formula_step,
xxen_util.description(grlcr.operator,'OPERATOR',101) operator,
grlcr.amount,
xxen_util.description(grlcr.amount_type,decode(grlcr.amount_type,'PATD','PATD_EOD','YATD','PATD_EOD','QATD','PATD_EOD','EOD','PATD_EOD','PTD_YTD'),101) amount_type,
xxen_util.meaning(grlcr.relative_period_code,'PERIOD CODE',101) relative_period,
xxen_util.description(grlcr.actual_flag,'BATCH_TYPE',101) balance_type,
xxen_util.meaning(grlcr.currency_type,'GL_CURRENCY_TYPE',101) currency_type,
grlcr.entered_currency formula_entered_currency,
grlcr.ledger_currency formula_ledger_currency,
&formula_segment_columns
(select gcck2.concatenated_segments from gl_code_combinations_kfv gcck2 where grlcr.assigned_code_combination=gcck2.code_combination_id) formula_assigned_account,
xxen_util.user_name(grb.last_updated_by) batch_last_updated_by,
xxen_util.client_time(grb.last_update_date) batch_last_update_date,
grb.recurring_batch_id,
grh.recurring_header_id
from
gl_recurring_batches grb,
gl_ledgers gl,
gl_recurring_headers grh,
gl_recurring_lines grl,
gl_recurring_line_calc_rules grlcr,
gl_code_combinations_kfv gcck
where
1=1 and
grb.ledger_id=gl.ledger_id(+) and
grb.recurring_batch_id=grh.recurring_batch_id and
grh.recurring_header_id=grl.recurring_header_id and
grl.recurring_header_id=grlcr.recurring_header_id(+) and
grl.recurring_line_num=grlcr.recurring_line_num(+) and
grl.code_combination_id=gcck.code_combination_id and
decode(grb.security_flag,'Y',decode(fnd_data_security.check_function(1.0,'GL_DAS_RECURRING_JOURNAL_V','GL_DAS_RECURRING_JOURNAL',to_char(grb.recurring_batch_id),null,null,null,null,fnd_global.user_name),'T','Y','N'),'Y')='Y'
order by
gl.name,
grb.name,
grh.name,
grl.recurring_line_num,
grlcr.rule_num
