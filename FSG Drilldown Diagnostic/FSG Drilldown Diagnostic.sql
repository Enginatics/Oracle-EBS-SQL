/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FSG Drilldown Diagnostic
-- Description: Troubleshooting report for FSG journal drilldown issues. Checks gl_balances, posted/unposted journals, period status, account properties, and flex value security for a given account and period. Use the GL segment parameters to filter to the specific account combination that is not drilling down.
-- Excel Examle Output: https://www.enginatics.com/example/fsg-drilldown-diagnostic/
-- Library Link: https://www.enginatics.com/reports/fsg-drilldown-diagnostic/
-- Run Report: https://demo.enginatics.com/

with gcck as (select &materialize_hint
gcck.*
from
gl_code_combinations_kfv gcck
where
gcck.chart_of_accounts_id in (select gl.chart_of_accounts_id from gl_ledgers gl where gl.name=:ledger) and
2=2
)
select
x.*
from
(
-- Check 1: All GL Balances rows for the account/period (unfiltered)
select
'1 - GL Balances' check_type,
'All gl_balances rows for this account/period/ledger' check_description,
gcck.code_combination_id||'' detail1_ccid,
gb.currency_code detail2_currency,
nvl(gb.translated_flag,'(null)') detail3_translated_flag,
nvl(gb.template_id||'','(null)') detail4_template_id,
to_char(gb.period_net_dr) detail5_period_net_dr,
to_char(gb.period_net_cr) detail6_period_net_cr,
to_char(nvl(gb.period_net_dr,0)-nvl(gb.period_net_cr,0)) detail7_period_net,
to_char(nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0)) detail8_begin_balance,
to_char(nvl(gb.begin_balance_dr,0)+nvl(gb.period_net_dr,0)-nvl(gb.begin_balance_cr,0)-nvl(gb.period_net_cr,0)) detail9_end_balance,
gcck.concatenated_segments detail10_account
from
gl_balances gb,
gcck,
gl_ledgers gl
where
gl.name=:ledger and
gb.ledger_id=gl.ledger_id and
gb.period_name=:period_name and
gb.actual_flag='A' and
gb.code_combination_id=gcck.code_combination_id
union all
-- Check 2: Balances matching FSG drilldown filter (translated_flag is null, template_id is null, non-zero amounts)
select
'2 - Drilldown Filter' check_type,
'Balances matching drilldown filter (translated_flag is null, template_id is null, summary_flag=N, non-zero)' check_description,
gcck.code_combination_id||'' detail1_ccid,
gb.currency_code detail2_currency,
'(null)' detail3_translated_flag,
'(null)' detail4_template_id,
to_char(gb.period_net_dr) detail5_period_net_dr,
to_char(gb.period_net_cr) detail6_period_net_cr,
to_char(nvl(gb.period_net_dr,0)-nvl(gb.period_net_cr,0)) detail7_period_net,
to_char(nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0)) detail8_begin_balance,
to_char(nvl(gb.begin_balance_dr,0)+nvl(gb.period_net_dr,0)-nvl(gb.begin_balance_cr,0)-nvl(gb.period_net_cr,0)) detail9_end_balance,
gcck.concatenated_segments detail10_account
from
gl_balances gb,
gcck,
gl_ledgers gl
where
gl.name=:ledger and
gb.ledger_id=gl.ledger_id and
gb.period_name=:period_name and
gb.actual_flag='A' and
gb.translated_flag is null and
gb.template_id is null and
gb.code_combination_id=gcck.code_combination_id and
gcck.summary_flag='N' and
(nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0)<>0 or nvl(gb.period_net_dr,0)<>0 or nvl(gb.period_net_cr,0)<>0)
union all
-- Check 3: Posted journal line count and totals
select
'3 - Posted Journals' check_type,
'Count and sum of posted journal lines (gjh.status=P) for this account/period' check_description,
to_char(count(*)) detail1_ccid,
null detail2_currency,
null detail3_translated_flag,
null detail4_template_id,
to_char(sum(nvl(gjl.accounted_dr,0))) detail5_period_net_dr,
to_char(sum(nvl(gjl.accounted_cr,0))) detail6_period_net_cr,
to_char(sum(nvl(gjl.accounted_dr,0))-sum(nvl(gjl.accounted_cr,0))) detail7_period_net,
null detail8_begin_balance,
null detail9_end_balance,
null detail10_account
from
gl_je_headers gjh,
gl_je_lines gjl,
gcck,
gl_ledgers gl
where
gl.name=:ledger and
gjh.ledger_id=gl.ledger_id and
gjh.period_name=:period_name and
gjh.status='P' and
gjh.actual_flag='A' and
gjh.je_header_id=gjl.je_header_id and
gjl.code_combination_id=gcck.code_combination_id
union all
-- Check 4: Unposted journal line count and totals
select
'4 - Unposted Journals' check_type,
'Count and sum of unposted journal lines (gjh.status=U) for this account/period' check_description,
to_char(count(*)) detail1_ccid,
null detail2_currency,
null detail3_translated_flag,
null detail4_template_id,
to_char(sum(nvl(gjl.accounted_dr,0))) detail5_period_net_dr,
to_char(sum(nvl(gjl.accounted_cr,0))) detail6_period_net_cr,
to_char(sum(nvl(gjl.accounted_dr,0))-sum(nvl(gjl.accounted_cr,0))) detail7_period_net,
null detail8_begin_balance,
null detail9_end_balance,
null detail10_account
from
gl_je_headers gjh,
gl_je_lines gjl,
gcck,
gl_ledgers gl
where
gl.name=:ledger and
gjh.ledger_id=gl.ledger_id and
gjh.period_name=:period_name and
gjh.status='U' and
gjh.actual_flag='A' and
gjh.je_header_id=gjl.je_header_id and
gjl.code_combination_id=gcck.code_combination_id
union all
-- Check 5: GL period status
select
'5 - Period Status' check_type,
'GL period status for the selected ledger and period' check_description,
gps.closing_status detail1_ccid,
decode(gps.closing_status,'O','Open','C','Closed','F','Future Entry','N','Never Opened','P','Permanently Closed',gps.closing_status) detail2_currency,
to_char(gp.start_date,'DD-MON-YYYY') detail3_translated_flag,
to_char(gp.end_date,'DD-MON-YYYY') detail4_template_id,
null detail5_period_net_dr,
null detail6_period_net_cr,
null detail7_period_net,
null detail8_begin_balance,
null detail9_end_balance,
null detail10_account
from
gl_period_statuses gps,
gl_periods gp,
gl_ledgers gl
where
gl.name=:ledger and
gps.ledger_id=gl.ledger_id and
gps.application_id=101 and
gps.period_name=:period_name and
gp.period_set_name=gl.period_set_name and
gp.period_name=gps.period_name and
gp.period_type=gl.accounted_period_type
union all
-- Check 6: Account properties (summary_flag, enabled_flag, detail_posting, detail_budgeting)
select
'6 - Account Properties' check_type,
'Value 1=CCID, Value 2=summary_flag (must be N), Value 3=enabled_flag, Value 4=detail_posting, Value 5=detail_budgeting, Value 6=start_date, Value 7=end_date' check_description,
gcc.code_combination_id||'' detail1_ccid,
gcc.summary_flag detail2_currency,
gcc.enabled_flag detail3_translated_flag,
gcc.detail_posting_allowed_flag detail4_template_id,
gcc.detail_budgeting_allowed_flag detail5_period_net_dr,
to_char(gcc.start_date_active,'DD-MON-YYYY') detail6_period_net_cr,
to_char(gcc.end_date_active,'DD-MON-YYYY') detail7_period_net,
null detail8_begin_balance,
null detail9_end_balance,
gcck.concatenated_segments detail10_account
from
gcck,
gl_code_combinations gcc
where
gcck.code_combination_id=gcc.code_combination_id
union all
-- Check 7: Flex value security check per code combination
select
'7 - Security Access' check_type,
'Value 1=CCID, Value 2=validate_access result (must be TRUE), Value 3=has_flex_value_security (Y/N)' check_description,
gcck.code_combination_id||'' detail1_ccid,
gl_security_pkg.validate_access(null,gcck.code_combination_id) detail2_currency,
xxen_util.has_flex_value_security detail3_translated_flag,
null detail4_template_id,
null detail5_period_net_dr,
null detail6_period_net_cr,
null detail7_period_net,
null detail8_begin_balance,
null detail9_end_balance,
gcck.concatenated_segments detail10_account
from
gcck
union all
-- Check 8: GL Balances for the previous period (comparison baseline)
select
'8 - Previous Period' check_type,
'GL Balances for previous period (comparison with working period)' check_description,
gcck.code_combination_id||'' detail1_ccid,
gb.currency_code detail2_currency,
nvl(gb.translated_flag,'(null)') detail3_translated_flag,
nvl(gb.template_id||'','(null)') detail4_template_id,
to_char(gb.period_net_dr) detail5_period_net_dr,
to_char(gb.period_net_cr) detail6_period_net_cr,
to_char(nvl(gb.period_net_dr,0)-nvl(gb.period_net_cr,0)) detail7_period_net,
to_char(nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0)) detail8_begin_balance,
to_char(nvl(gb.begin_balance_dr,0)+nvl(gb.period_net_dr,0)-nvl(gb.begin_balance_cr,0)-nvl(gb.period_net_cr,0)) detail9_end_balance,
gcck.concatenated_segments detail10_account
from
gl_balances gb,
gcck,
gl_ledgers gl
where
gl.name=:ledger and
gb.ledger_id=gl.ledger_id and
gb.period_name=(select gp2.period_name from gl_periods gp2, gl_periods gp1 where gp1.period_set_name=gp2.period_set_name and gp1.period_type=gp2.period_type and gp1.period_name=:period_name and gp1.period_set_name=gl.period_set_name and gp1.period_type=gl.accounted_period_type and gp2.period_year*100+gp2.period_num=(select max(gp3.period_year*100+gp3.period_num) from gl_periods gp3 where gp3.period_set_name=gp1.period_set_name and gp3.period_type=gp1.period_type and gp3.period_year*100+gp3.period_num<gp1.period_year*100+gp1.period_num)) and
gb.actual_flag='A' and
gb.code_combination_id=gcck.code_combination_id
) x
order by
x.check_type,
x.detail10_account nulls last