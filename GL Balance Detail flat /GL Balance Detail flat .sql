/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Balance Detail (flat)
-- Description: GL balance data on detailed segment level. One record for each period and account combination.
-- Excel Examle Output: https://www.enginatics.com/example/gl-balance-detail-flat/
-- Library Link: https://www.enginatics.com/reports/gl-balance-detail-flat/
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
gcc.chart_of_accounts_id,
gp.period_year*10000+gp.period_num effective_period_num
from
gl_ledgers gl,
gl_periods gp,
gl_balances gb,
gl_code_combinations gcc
where
1=1 and
gb.actual_flag=xxen_util.lookup_code(:balance_type,'XLA_BALANCE_TYPE',602) and
gl.period_set_name=gp.period_set_name and
gl.accounted_period_type=gp.period_type and
gp.period_name=gb.period_name and
gl.ledger_id=gb.ledger_id and
gl.currency_code=gb.currency_code and
gb.code_combination_id=gcc.code_combination_id
) x
order by
x.ledger,
&segment_columns
x.effective_period_num