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
gl.name ledger,
gl.ledger_id,
gb.period_name,
gcck.concatenated_segments,
gcck.code_combination_id,
gcck.chart_of_accounts_id,
&balance_columns
xxen_util.description(gb.actual_flag,'BATCH_TYPE',101) balance_type_name,
gb.actual_flag,
(select gbv.budget_name from gl_budget_versions gbv where gb.budget_version_id=gbv.budget_version_id) budget_name,
(select get.encumbrance_type from gl_encumbrance_types get where gb.encumbrance_type_id=get.encumbrance_type_id) encumbrance_type,
gb.currency_code,
&segment_columns
case when xxen_api.user_preference('XXEN_FSG_DD_TO_NEW_WORKBOOK')='Y' then '=dd' else '=dds' end
||'("GJ","'||gl.ledger_id||','||gb.period_name||','||:amount_type||','||gb.currency_code||','||gb.actual_flag||','||(select gbv.budget_name from gl_budget_versions gbv where gb.budget_version_id=gbv.budget_version_id)||','||(select get.encumbrance_type from gl_encumbrance_types get where gb.encumbrance_type_id=get.encumbrance_type_id)||',,,'||gcck.code_combination_id||'")' drill_to_journal
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
gb.template_id is null and
(nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0)<>0 or nvl(gb.period_net_dr,0)<>0 or nvl(gb.period_net_cr,0)<>0)
order by
gcck.concatenated_segments