/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Balance Drilldown
-- Description: Shows GL balance details by code combination. Uses gl_balances for standard queries, gl_je_lines when filtering by journal source/category or using JED balance types.
-- Excel Examle Output: https://www.enginatics.com/example/gl-balance-drilldown/
-- Library Link: https://www.enginatics.com/reports/gl-balance-drilldown/
-- Run Report: https://demo.enginatics.com/

select
x.ledger,
x.ledger_id,
x.concatenated_segments code_combination,
x.code_combination_id,
&segment_columns
sum(x.begin_balance)*nvl(:multiplier,1) opening_balance,
sum(x.period_dr)*nvl(:multiplier,1) period_dr,
sum(x.period_cr)*nvl(:multiplier,1) period_cr,
sum(x.period_net)*nvl(:multiplier,1) period_net,
sum(x.end_balance)*nvl(:multiplier,1) closing_balance,
case when nvl(fnd_profile.value('XXEN_FSG_DRILLDOWN_TO_SAME_WORKBOOK'),'Y')='N' then '=dd' else '=dds' end||'("GJ","'||x.ledger_id||','||:period_name||','||:balance_type||','||:currency_code||','||:actual_flag||','||nvl(:budget_name,'')||','||nvl(:encumbrance_type,'')||','||nvl(:journal_source,'')||','||nvl(:journal_category,'')||','||x.code_combination_id||'")' drill_to_journal
from
(
-- GL_BALANCES path (standard)
select
gl.name ledger,
gl.ledger_id,
gcck.concatenated_segments,
gcck.code_combination_id,
&segment_columns_inner
&balance_columns
from
gl_ledgers gl,
gl_code_combinations_kfv gcck,
gl_balances gb
where
nvl(:journal_source,'%')='%' and
nvl(:journal_category,'%')='%' and
instr(:balance_type,'JED')=0 and
gl.ledger_id=:ledger_id and
gcck.chart_of_accounts_id=gl.chart_of_accounts_id and
gcck.summary_flag='N' and
gb.code_combination_id=gcck.code_combination_id and
gb.ledger_id=gl.ledger_id and
gb.template_id is null and
gb.actual_flag=:actual_flag and
((:balance_type='YTD' and gb.period_name in (:period_name,xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id)))) or
 (:balance_type='FYS' and gb.period_name=xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id))) or
 (:balance_type='FYE' and gb.period_name=xxen_fsg.last_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id))) or
 (:balance_type not in ('YTD','FYS','FYE') and gb.period_name=:period_name)) and
((:translated_flag in ('T','S') and gb.translated_flag is null and gb.currency_code=case when :translated_flag='T' and :currency_code<>'STAT' then gl.currency_code when :translated_flag='S' then 'STAT' else :currency_code end) or
 (:translated_flag not in ('T','S') and nvl(gb.translated_flag,decode(gb.currency_code,gl.currency_code,'R','X'))='R' and gb.currency_code=:currency_code)) and
(:budget_name is null or :actual_flag<>'B' or gb.budget_version_id in (select gbv.budget_version_id from gl_budget_versions gbv where gbv.budget_name=:budget_name)) and
(:encumbrance_type is null or :actual_flag<>'E' or gb.encumbrance_type_id in (select get.encumbrance_type_id from gl_encumbrance_types get where get.encumbrance_type=:encumbrance_type)) and
(xxen_util.has_flex_value_security<>'Y' or gl_security_pkg.validate_access(null,gcck.code_combination_id)='TRUE') and
(:restrict_ccids is null or gcck.code_combination_id in (select xrti.id1 from xxen_report_temp_ids xrti))
union all
-- GL_JE_LINES path (journal source/category filter or JED balance type)
select
gl.name ledger,
gl.ledger_id,
gcck.concatenated_segments,
gcck.code_combination_id,
&segment_columns_inner2
0 begin_balance,
nvl(gjl.accounted_dr,0) period_dr,
nvl(gjl.accounted_cr,0) period_cr,
nvl(gjl.accounted_dr,0)-nvl(gjl.accounted_cr,0) period_net,
nvl(gjl.accounted_dr,0)-nvl(gjl.accounted_cr,0) end_balance
from
gl_ledgers gl,
gl_je_headers gjh,
gl_je_lines gjl,
gl_code_combinations_kfv gcck
where
(nvl(:journal_source,'%')<>'%' or nvl(:journal_category,'%')<>'%' or instr(:balance_type,'JED')>0) and
gl.ledger_id=:ledger_id and
gjh.ledger_id=gl.ledger_id and
gjl.ledger_id=gl.ledger_id and
gjh.je_header_id=gjl.je_header_id and
gjl.code_combination_id=gcck.code_combination_id and
gcck.chart_of_accounts_id=gl.chart_of_accounts_id and
gcck.summary_flag='N' and
gjh.actual_flag=:actual_flag and
gjh.status=case when :balance_type='JEDU' then 'U' else 'P' end and
gjh.currency_code=:currency_code and
((instr(:balance_type,'JED')>0 and gjl.effective_date between (select gp.start_date from gl_periods gp, gl_ledgers gl3 where gl3.ledger_id=:ledger_id and gp.period_set_name=gl3.period_set_name and gp.period_type=gl3.accounted_period_type and gp.period_name=:period_name) and (select gp.end_date from gl_periods gp, gl_ledgers gl3 where gl3.ledger_id=:ledger_id and gp.period_set_name=gl3.period_set_name and gp.period_type=gl3.accounted_period_type and gp.period_name=:period_name)) or
 (:balance_type='FYS' and gjh.period_name=xxen_fsg.first_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id))) or
 (:balance_type='FYE' and gjh.period_name=xxen_fsg.last_period_name(:period_name,(select gl2.name from gl_ledgers gl2 where gl2.ledger_id=:ledger_id))) or
 (:balance_type not in ('FYS','FYE') and instr(:balance_type,'JED')=0 and gjh.period_name=:period_name)) and
(nvl(:journal_source,'%')='%' or gjh.je_source in (select gjsv.je_source_name from gl_je_sources_vl gjsv where gjsv.user_je_source_name=:journal_source)) and
(nvl(:journal_category,'%')='%' or gjh.je_category in (select gjcv.je_category_name from gl_je_categories_vl gjcv where gjcv.user_je_category_name=:journal_category)) and
(:budget_name is null or :actual_flag<>'B' or gjh.budget_version_id in (select gbv.budget_version_id from gl_budget_versions gbv where gbv.budget_name=:budget_name)) and
(:encumbrance_type is null or :actual_flag<>'E' or gjh.encumbrance_type_id in (select get.encumbrance_type_id from gl_encumbrance_types get where get.encumbrance_type=:encumbrance_type)) and
(xxen_util.has_flex_value_security<>'Y' or gl_security_pkg.validate_access(null,gcck.code_combination_id)='TRUE') and
(:restrict_ccids is null or gcck.code_combination_id in (select xrti.id1 from xxen_report_temp_ids xrti))
) x
where
x.begin_balance<>0 or x.period_dr<>0 or x.period_cr<>0 or x.end_balance<>0
group by
x.ledger,
x.ledger_id,
x.concatenated_segments,
x.code_combination_id
&segment_group_by
order by
x.concatenated_segments