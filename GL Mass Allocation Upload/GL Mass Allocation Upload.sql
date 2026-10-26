/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Mass Allocation Upload
-- Description: Creates, updates and deletes GL MassAllocation and MassBudget batches, formulas and formula lines - the Excel equivalent of the Define MassAllocations and Define MassBudgets forms.
-- Each row is one formula line, with the batch and formula columns repeated on every line. The batch and formula values are taken from the first row of each batch and formula. Leave the formula columns blank to create or update a batch only.
-- A formula has the lines A, B, C, Target (T) and Offset (O); a MassBudget formula needs A, B, C and T. Lines A, B and C take either an Amount or an account, the Target and Offset lines an account. Enter the Ledger, Ledger Type, Account and Segment Types as in the account flexfield of the form: the account segments and their types C (Constant), L (Looping) or S (Summing) are separated by the segment delimiter of the chart of accounts.
-- The lines are validated as in the form. Each batch is saved as a whole: when one of its rows fails, none of its rows are saved. A saved change sets the batch to Not Validated and submits the Validate MassAllocations program, as the form does when it is closed.
-- Set Delete Batch to Yes to delete a batch, Delete Formula to delete a formula with its lines, and Delete Line to delete the Offset line of a MassBudget formula. Batches are maintained in the chart of accounts of the GL access set of the responsibility.
-- Excel Example Output: https://www.enginatics.com/example/gl-mass-allocation-upload/
-- Library Link: https://www.enginatics.com/reports/gl-mass-allocation-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
gabv.name batch,
xxen_util.meaning(gabv.actual_flag,'GL_DSS_BALANCE_TYPE',101) balance_type,
gabv.description batch_description,
gabv.show_validation_status batch_status,
gaf.name formula,
gjc.user_je_category_name category,
gaf.description formula_description,
xxen_util.meaning(gaf.validation_status,'VALIDATION_STATUS',101) formula_status,
xxen_util.meaning(gaf.conversion_method_code,'GL_CONVERSION_METHOD',101) entered_currency_allocation,
gafl.transaction_currency currency,
gdct.user_conversion_type conversion_type,
xxen_util.yes(gaf.full_allocation_flag) full_cost_pool_allocation,
decode(gafl.line_number,1,'A',2,'B',3,'C',4,'T',5,'O') line,
gafl.amount,
xxen_gl_upload.alloc_line_ledger(gafl.ledger_id,gafl.ledger_currency,gafl.line_number) ledger,
gafl.ledger_action_code ledger_type,
xxen_gl_upload.alloc_line_account(gafl.allocation_formula_id,gafl.line_number) account,
gafl.segment_types_key segment_types,
gafl.ledger_currency,
xxen_util.meaning(gafl.currency_type,'GL_CURRENCY_TYPE',101) currency_type,
gafl.entered_currency,
coalesce(xxen_util.meaning(gafl.amount_type,'PTD_YTD',101),xxen_util.meaning(gafl.amount_type,'PATD_EOD',101)) amount_type,
xxen_util.meaning(gafl.relative_period,'PERIOD CODE',101) relative_period,
xxen_util.meaning(gafl.actual_flag,'GL_DSS_BALANCE_TYPE',101) line_balance_type,
decode(gafl.actual_flag,'B',gbv.budget_name,'E',get.encumbrance_type) budget_or_encumbrance_type,
null delete_batch,
null delete_formula,
null delete_line,
gabv.allocation_batch_id,
gaf.allocation_formula_id,
gafl.line_number,
null upload_row
from
gl_alloc_batches_v gabv,
gl_alloc_formulas gaf,
gl_je_categories gjc,
gl_daily_conversion_types gdct,
gl_alloc_formula_lines gafl,
gl_budget_versions gbv,
gl_encumbrance_types get
where
1=1 and
gabv.chart_of_accounts_id=(select gas.chart_of_accounts_id from gl_access_sets gas where gas.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID')) and
gabv.view_privilege='Y' and
gabv.allocation_batch_id=gaf.allocation_batch_id(+) and
gaf.je_category_name=gjc.je_category_name(+) and
gaf.currency_conversion_type=gdct.conversion_type(+) and
gaf.allocation_formula_id=gafl.allocation_formula_id(+) and
gafl.budget_version_id=gbv.budget_version_id(+) and
gafl.encumbrance_type_id=get.encumbrance_type_id(+)
