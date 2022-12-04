/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Balance (pivot)
-- Description: Summary GL report including one line per account segment level, including product code, with opening balance, total transaction amount per month for each period selected, and closing balance (trial balance).
-- Excel Examle Output: https://www.enginatics.com/example/gl-balance-pivot/
-- Library Link: https://www.enginatics.com/reports/gl-balance-pivot/
-- Run Report: https://demo.enginatics.com/

select
y.ledger,
&account_type2
&segment_columns2
y.start_balance,
&period_columns
y.total,
nvl(y.start_balance,0)+nvl(y.total,0) ytd,
y.currency_code currency,
&start_balance_reval
&period_columns_reval
&total_reval
&concatenated_segments
y.chart_of_accounts_id
from
(
select distinct
w.ledger,
&account_type
&segment_columns
&concatenated_segments
w.period_name,
sum(w.start_bal       ) over (partition by w.ledger, &account_type &segment_columns w.chart_of_accounts_id) start_balance,
sum(w.start_bal*w.rate) over (partition by w.ledger, &account_type &segment_columns w.chart_of_accounts_id) start_balance_reval,
sum(w.amount          ) over (partition by w.ledger, &account_type &segment_columns w.chart_of_accounts_id) total,
sum(w.abs_amount      ) over (partition by w.ledger, &account_type &segment_columns w.chart_of_accounts_id) abs_total,
sum(w.amount*w.rate   ) over (partition by w.ledger, &account_type &segment_columns w.chart_of_accounts_id) total_reval,
sum(w.amount          ) over (partition by w.ledger, &account_type &segment_columns w.chart_of_accounts_id, w.period_name) amount,
sum(w.amount*w.rate   ) over (partition by w.ledger, &account_type &segment_columns w.chart_of_accounts_id, w.period_name) amount_reval,
w.currency_code,
w.chart_of_accounts_id
from
(
select
gl.name ledger,
&account_type
&segment_columns
&concatenated_segments1
gps.period_name,
decode(gps.start_period,'Y',nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0)) start_bal,
nvl(gb.period_net_dr,0)-nvl(gb.period_net_cr,0) amount,
abs(nvl(gb.period_net_dr,0))+abs(nvl(gb.period_net_cr,0)) abs_amount,
decode(gl.currency_code,:reval_currency,1,(select gdr.conversion_rate from gl_daily_conversion_types gdct, gl_daily_rates gdr where gl.currency_code=gdr.from_currency and gdr.to_currency=:reval_currency and gps.end_date=gdr.conversion_date and gdct.user_conversion_type=:reval_conversion_type and gdct.conversion_type=gdr.conversion_type)) rate,
gl.currency_code,
gl.chart_of_accounts_id
from
gl_ledgers gl,
gl_period_statuses gps0,
(select decode(gps.period_num,min(gps.period_num) over (partition by gps.ledger_id, gps.application_id, gps.period_year),'Y') start_period, gps.* from gl_period_statuses gps) gps,
gl_balances gb,
gl_code_combinations_kfv gcck
where
1=1 and
gps0.period_name=:period_name and
gb.actual_flag=(select flvv.lookup_code from fnd_lookup_values_vl flvv where flvv.description=:balance_type and flvv.lookup_type='BATCH_TYPE' and flvv.view_application_id=101 and flvv.security_group_id=0) and
gl.ledger_id=gps0.ledger_id and
gps0.application_id=101 and
gps0.application_id=gps.application_id and
gps0.ledger_id=gps.ledger_id and
gps0.period_year=gps.period_year and
gps0.period_num>=gps.period_num and
gps.ledger_id=gb.ledger_id and
gps.period_name=gb.period_name and
gl.currency_code=gb.currency_code and
gb.code_combination_id=gcck.code_combination_id
) w
) x
pivot (
max(x.amount), max(x.amount_reval) reval
for period_name in (
&pivot_columns
)
) y
where
2=2
order by
y.ledger,
&order_by_account_type
&order_by
1