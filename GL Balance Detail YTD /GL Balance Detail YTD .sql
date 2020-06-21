/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Balance Detail (YTD)
-- Description: GL balance data on detailed segment level, year to date amount totals.
Similar to GL Balance Detail (pivot), but better performance without showing period amounts.
-- Excel Examle Output: https://www.enginatics.com/example/gl-balance-detail-ytd/
-- Library Link: https://www.enginatics.com/reports/gl-balance-detail-ytd/
-- Run Report: https://demo.enginatics.com/

select
z.*,
nvl(z.start_balance,0)+nvl(z.total,0) ytd
from
(
select /*+ no_merge(x)*/
x.ledger,
&segment_columns2
max(x.start_balance) over (partition by &segment_columns 1) start_balance,
x.amount total
from
(
select
gl.name ledger,
&account_type
&segment_columns
gl.chart_of_accounts_id,
sum(decode(gps.start_period,'Y',nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0))) start_balance,
sum(nvl(gb.period_net_dr,0)-nvl(gb.period_net_cr,0)) amount
from
gl_ledgers gl,
gl_period_statuses gps0,
(select decode(gps.period_num,min(gps.period_num) over (partition by gps.ledger_id, gps.application_id, gps.period_year),'Y') start_period, gps.* from gl_period_statuses gps) gps,
gl_balances gb,
gl_code_combinations gcc
where
1=1 and
gps0.period_name=:period_name and
gb.actual_flag=xxen_util.lookup_code(:balance_type,'XLA_BALANCE_TYPE',602) and
gl.ledger_id=gps0.ledger_id and
gps0.application_id=101 and
gps0.application_id=gps.application_id and
gps0.ledger_id=gps.ledger_id and
gps0.period_year=gps.period_year and
gps0.period_num>=gps.period_num and
gps.ledger_id=gb.ledger_id and
gps.period_name=gb.period_name and
gl.currency_code=gb.currency_code and
gb.code_combination_id=gcc.code_combination_id
group by
gl.name, &account_type &segment_columns gl.chart_of_accounts_id
) x
) z
order by
&order_by 1