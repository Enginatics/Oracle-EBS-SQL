/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Balance
-- Description: Summary GL report including one line per accounting period for each account segment level, including product code, with amounts for opening balance, debits, credits, change amount, ending balance.
-- Excel Examle Output: https://www.enginatics.com/example/gl-balance/
-- Library Link: https://www.enginatics.com/reports/gl-balance/
-- Run Report: https://demo.enginatics.com/

select
u.period_name,
u.ledger,
&segment_columns2
u.start_balance,
u.debit,
u.credit,
u.amount,
u.end_balance,
u.currency_code,
&reval_columns
&segment_columns3
&hierarchy_levels4
u.effective_period_num,
(select flvv.description from fnd_lookup_values_vl flvv where u.actual_flag=flvv.lookup_code and flvv.lookup_type='BATCH_TYPE' and flvv.view_application_id=101 and flvv.security_group_id=0) balance_type
from
(
select distinct
z.period_name,
z.ledger,
&account_type
&hierarchy_levels3
&segment_columns
sum(z.start_balance) over (partition by z.ledger, z.period_name, z.currency_code, &segment_columns z.actual_flag) start_balance,
sum(z.debit) over (partition by z.ledger, z.period_name, z.currency_code, &segment_columns z.actual_flag) debit,
sum(z.credit) over (partition by z.ledger, z.period_name, z.currency_code, &segment_columns z.actual_flag) credit,
sum(z.amount) over (partition by z.ledger, z.period_name, z.currency_code, &segment_columns z.actual_flag) amount,
sum(z.end_balance) over (partition by z.ledger, z.period_name, z.currency_code, &segment_columns z.actual_flag) end_balance,
z.currency_code,
sum(z.start_balance*z.rate) over (partition by z.ledger, z.period_name, z.currency_code, &segment_columns z.actual_flag) start_balance_reval,
sum(z.debit*z.rate) over (partition by z.ledger, z.period_name, z.currency_code, &segment_columns z.actual_flag) debit_reval,
sum(z.credit*z.rate) over (partition by z.ledger, z.period_name, z.currency_code, &segment_columns z.actual_flag) credit_reval,
sum(z.amount*z.rate) over (partition by z.ledger, z.period_name, z.currency_code, &segment_columns z.actual_flag) amount_reval,
sum(z.end_balance*z.rate) over (partition by z.ledger, z.period_name, z.currency_code, &segment_columns z.actual_flag) end_balance_reval,
gcck.chart_of_accounts_id,
z.effective_period_num,
z.actual_flag
from
(
select
y.column_value,
decode(y.column_value,2,'00 '||xxen_report.column_translation('START_BALANCE'),case when :show_start_balance is not null or x.period_count>1 then lpad(x.period_num,2,'0')||' ' end||x.period_name) period_name,
x.ledger,
decode(y.column_value,2,null,x.start_balance) start_balance,
decode(y.column_value,2,null,x.debit) debit,
decode(y.column_value,2,null,x.credit) credit,
decode(y.column_value,2,x.start_balance,x.amount) amount,
decode(y.column_value,2,null,x.end_balance) end_balance,
x.rate,
x.currency_code,
decode(y.column_value,2,0,x.effective_period_num) effective_period_num,
x.start_effective_period_num,
x.code_combination_id,
x.actual_flag
from
(
select
gb.period_name,
gl.name ledger,
nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0) start_balance,
gb.period_net_dr debit,
gb.period_net_cr credit,
nvl(gb.period_net_dr,0)-nvl(gb.period_net_cr,0) amount,
nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0)+nvl(gb.period_net_dr,0)-nvl(gb.period_net_cr,0) end_balance,
decode(gl.currency_code,:reval_currency,1,(select gdr.conversion_rate from gl_daily_conversion_types gdct, gl_daily_rates gdr where gl.currency_code=gdr.from_currency and gdr.to_currency=:reval_currency and gp.end_date=gdr.conversion_date and gdct.user_conversion_type=:reval_conversion_type and gdct.conversion_type=gdr.conversion_type)) rate,
gl.currency_code,
count(distinct gp.period_num) over () period_count,
gp.period_num,
gp.period_year*10000+gp.period_num effective_period_num,
min(gp.period_year*10000+gp.period_num) over () start_effective_period_num,
gb.code_combination_id,
gb.actual_flag
from
gl_ledgers gl,
gl_periods gp,
gl_balances gb
where
1=1 and
gl.period_set_name=gp.period_set_name and
gl.accounted_period_type=gp.period_type and
gp.period_name=gb.period_name and
gl.ledger_id=gb.ledger_id and
gl.currency_code=gb.currency_code
) x,
table(xxen_util.rowgen(case when :show_start_balance is not null and x.effective_period_num=x.start_effective_period_num then 2 else 1 end)) y
where
2=2
) z,
(
select
&hierarchy_levels2
gcck.*
from
(
select
(select fifs.flex_value_set_id from fnd_id_flex_segments fifs where gcck.chart_of_accounts_id=fifs.id_flex_num and fifs.application_id=101 and fifs.id_flex_code='GL#' and fifs.application_column_name='&hierarchy_segment_column') flex_value_set_id,
gcck.*
from
gl_code_combinations_kfv gcck
where
4=4
) gcck,
(
select
&hierarchy_levels
x.flex_value_set_id,
x.child_flex_value_low,
x.child_flex_value_high
from
(
select
substr(sys_connect_by_path(ffvnh.parent_flex_value,'|'),2) path,
ffvnh.child_flex_value_low,
ffvnh.child_flex_value_high,
ffvnh.flex_value_set_id
from
(select ffvnh.* from fnd_flex_value_norm_hierarchy ffvnh where ffvnh.flex_value_set_id=:flex_value_set_id) ffvnh
where
connect_by_isleaf=1 and
ffvnh.range_attribute='C'
connect by nocycle
ffvnh.parent_flex_value between prior ffvnh.child_flex_value_low and prior ffvnh.child_flex_value_high and
ffvnh.flex_value_set_id=prior ffvnh.flex_value_set_id and
prior ffvnh.range_attribute='P'
start with
ffvnh.parent_flex_value=:parent_flex_value
) x
) h
where
3=3 and
gcck.flex_value_set_id=h.flex_value_set_id(+)
) gcck
where
z.code_combination_id=gcck.code_combination_id
) u
order by
u.ledger,
&segment_columns
u.effective_period_num,
balance_type