/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Balance Detail
-- Description: Summary GL report including one line per accounting period for each account segment level, including product code, with amounts for opening balance, debits, credits, change amount, ending balance.
-- Excel Examle Output: https://www.enginatics.com/example/gl-balance-detail/
-- Library Link: https://www.enginatics.com/reports/gl-balance-detail/
-- Run Report: https://demo.enginatics.com/

select
x.period_name,
x.ledger,
&segment_columns2
x.start_balance,
x.debit,
x.credit,
nvl(x.debit,0)-nvl(x.credit,0) amount,
nvl(x.start_balance,0)+nvl(x.debit,0)-nvl(x.credit,0) end_balance,
&segment_columns3
x.effective_period_num
from
(
select distinct
gb.period_name,
gl.name ledger,
&account_type
&segment_columns
sum(nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0)) over (partition by gb.ledger_id, gb.period_name, &segment_columns 1) start_balance,
sum(nvl(gb.period_net_dr,0)) over (partition by gb.ledger_id, gb.period_name, &segment_columns 1) debit,
sum(nvl(gb.period_net_cr,0)) over (partition by gb.ledger_id, gb.period_name, &segment_columns 1) credit,
gcck.chart_of_accounts_id,
gp.period_year*10000+gp.period_num effective_period_num
from
gl_ledgers gl,
gl_periods gp,
gl_balances gb,
gl_code_combinations_kfv gcck
where
1=1 and
gb.actual_flag=(select flvv.lookup_code from fnd_lookup_values_vl flvv where flvv.description=:balance_type and flvv.lookup_type='BATCH_TYPE' and flvv.view_application_id=101 and flvv.security_group_id=0) and
gl.period_set_name=gp.period_set_name and
gl.accounted_period_type=gp.period_type and
gp.period_name=gb.period_name and
gl.ledger_id=gb.ledger_id and
gl.currency_code=gb.currency_code and
gb.code_combination_id=gcck.code_combination_id
) x
where
2=2
order by
x.ledger,
&segment_columns
x.effective_period_num