/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Account Analysis 11i
-- Description: Detail GL transaction report with one line per journal line including all segments, with amounts in both transaction currency and ledger currency.

-- Excel Examle Output: https://www.enginatics.com/example/gl-account-analysis-11i/
-- Library Link: https://www.enginatics.com/reports/gl-account-analysis-11i/
-- Run Report: https://demo.enginatics.com/

select
gl.name ledger,
gjh.period_name,
(select gjsv.user_je_source_name from gl_je_sources_vl gjsv where gjh.je_source=gjsv.je_source_name) source_name,
gjh.external_reference reference,
(select gjcv.user_je_category_name from gl_je_categories_vl gjcv where gjh.je_category=gjcv.je_category_name) category_name,
gjb.name batch_name,
xxen_util.meaning(gjb.status,'MJE_BATCH_STATUS',101) batch_status,
gjh.posted_date,
gjh.name journal_name,
gjh.description journal_description,
gjh.doc_sequence_value document_number,
xxen_util.meaning(gjh.tax_status_code,'TAX_STATUS',101) tax_status_code,
gjl.description line_description,
xxen_util.meaning(gjl.tax_line_flag,'YES_NO',0) tax_line,
xxen_util.meaning(gjl.taxable_line_flag,'YES_NO',0) taxable_line,
xxen_util.meaning(gjl.amount_includes_tax_flag,'YES_NO',0) amount_includes_tax,
xxen_util.meaning(gcc.account_type,'ACCOUNT_TYPE',0) account_type,
&segment_columns gjl.entered_dr jnl_line_entered_dr,
gjl.entered_cr jnl_line_entered_cr,
nvl(gjl.entered_dr,0)-nvl(gjl.entered_cr,0) jnl_line_entered_amount,
gjh.currency_code jnl_line_currency,
gjl.accounted_dr jnl_line_accounted_dr,
gjl.accounted_cr jnl_line_accounted_cr,
nvl(gjl.accounted_dr,0)-nvl(gjl.accounted_cr,0) accounted_amount,
gl.currency_code ledger_currency,
&revaluation_columns gjh.doc_sequence_value doc_sequence_value,
xxen_util.description(gjh.actual_flag,'BATCH_TYPE',101) balance_type,
(select gbv.budget_name from gl_budget_versions gbv where gjh.budget_version_id=gbv.budget_version_id) budget_name,
gjh.currency_conversion_date conversion_date,
gjh.currency_conversion_type conversion_type,
gjh.currency_conversion_rate conversion_rate,
xxen_util.user_name(gjh.created_by) journal_created_by,
gjh.creation_date journal_creation_date,
gjb.je_batch_id,
gjl.je_header_id,
gjl.je_line_num,
gjl.context dff_context
from
gl_sets_of_books gl,
gl_periods gp,
gl_je_batches gjb,
gl_je_headers gjh,
gl_je_lines gjl,
gl_code_combinations gcc,
(select gdr.* from gl_daily_rates gdr, gl_daily_conversion_types gdct where gdr.to_currency=:revaluation_currency and gdr.conversion_type=gdct.conversion_type and gdct.user_conversion_type=:revaluation_conversion_type) gdr
where
1=1 and
gl.period_set_name=gp.period_set_name and
gp.period_name=gjh.period_name and
gl.set_of_books_id=gjh.set_of_books_id and
gjh.je_batch_id=gjb.je_batch_id and
gp.period_name=gjl.period_name and
gjh.je_header_id=gjl.je_header_id and
gjl.code_combination_id=gcc.code_combination_id and
gjh.currency_conversion_date=gdr.conversion_date(+) and
case gjh.currency_code when:revaluation_currency then null else gjh.currency_code end=gdr.from_currency(+)
order by
gl.name,
gjh.posted_date,
source_name,
category_name,
gjb.name,
gjh.name,
gjl.je_line_num