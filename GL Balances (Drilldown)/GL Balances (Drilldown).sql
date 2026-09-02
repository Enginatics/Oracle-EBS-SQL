/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Balances (Drilldown)
-- Description: ** This report is used by the GL Financial Statement and Drilldown report, to show Balance details per code combination. **

Shows GL balance amounts (Opening Balance, Debit, Credit, Net, Closing Balance) grouped by code combination, with drill-to-journal capability.
Supports all balance types: PTD, YTD, QTD, PJTD, FYS, FYE, CTD.
The Drill To Journal column allows further drilldown into journal details.
-- Excel Examle Output: https://www.enginatics.com/example/gl-balances-drilldown/
-- Library Link: https://www.enginatics.com/reports/gl-balances-drilldown/
-- Run Report: https://demo.enginatics.com/

select
x.ledger,
x.ledger_id,
gcck.concatenated_segments,
x.code_combination_id,
gcck.chart_of_accounts_id,
x.opening_balance,
x.period_dr,
x.period_cr,
x.net,
x.closing_balance,
x.balance_type_name,
x.actual_flag,
x.budget_name,
x.encumbrance_type,
x.currency_code,
&segment_columns
x.drill_to_journal
from
(
select
y.ledger,
y.ledger_id,
y.code_combination_id,
sum(y.opening_balance) opening_balance,
sum(y.period_dr) period_dr,
sum(y.period_cr) period_cr,
sum(y.net) net,
sum(y.closing_balance) closing_balance,
y.balance_type_name,
y.actual_flag,
y.budget_name,
y.encumbrance_type,
y.currency_code,
y.drill_to_journal
from
(
select
gl.name ledger,
gl.ledger_id,
gcck.code_combination_id,
&balance_columns
xxen_util.description(gb.actual_flag,'BATCH_TYPE',101) balance_type_name,
gb.actual_flag,
(select gbv.budget_name from gl_budget_versions gbv where gb.budget_version_id=gbv.budget_version_id) budget_name,
(select get.encumbrance_type from gl_encumbrance_types get where gb.encumbrance_type_id=get.encumbrance_type_id) encumbrance_type,
gb.currency_code,
case when xxen_api.user_preference('XXEN_FSG_DD_TO_NEW_WORKBOOK')='Y' then '=dd' else '=dds' end
||'("GJ","'||gl.ledger_id||','||:period_name||','||:amount_type||','||gb.currency_code||','||gb.actual_flag||','||(select gbv.budget_name from gl_budget_versions gbv where gb.budget_version_id=gbv.budget_version_id)||','||(select get.encumbrance_type from gl_encumbrance_types get where gb.encumbrance_type_id=get.encumbrance_type_id)||',,,'||gcck.code_combination_id||'")' drill_to_journal
from
gl_ledgers gl,
gl_balances gb,
gl_code_combinations_kfv gcck
where
1=1 and
&gl_flex_value_security
&balance_where
gb.ledger_id=gl.ledger_id and
gb.code_combination_id=gcck.code_combination_id and
gcck.chart_of_accounts_id=gl.chart_of_accounts_id and
gcck.summary_flag='N' and
gb.template_id is null
) y
where
y.opening_balance<>0 or y.period_dr<>0 or y.period_cr<>0 or y.net<>0 or y.closing_balance<>0
group by
y.ledger,
y.ledger_id,
y.code_combination_id,
y.balance_type_name,
y.actual_flag,
y.budget_name,
y.encumbrance_type,
y.currency_code,
y.drill_to_journal
) x,
gl_code_combinations_kfv gcck
where
x.code_combination_id=gcck.code_combination_id
order by
gcck.concatenated_segments