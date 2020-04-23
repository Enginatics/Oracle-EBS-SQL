/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Balance by Account Hierarchy
-- Excel Examle Output: https://www.enginatics.com/example/gl-balance-by-account-hierarchy/
-- Library Link: https://www.enginatics.com/reports/gl-balance-by-account-hierarchy/
-- Run Report: https://demo.enginatics.com/

select
z.ledger,
z.level_,
&account_type2
z.account,
z.description,
z.start_balance,
&period_columns
nvl(z.start_balance,0)+nvl(z.total,0) ytd,
z.type
from
(
select
x.ledger,
x.type,
lpad(' ',2*(x.level__-1))||x.level__ level_,
&account_type
lpad(' ',2*(x.level__-1))||x.flex_value account,
(select ffvv.description from fnd_flex_values_vl ffvv where x.flex_value=ffvv.flex_value and ffvv.flex_value_set_id=&flex_value_set_id) description,
nvl(x.period_name,'total') period_name,
max(x.start_balance) over (partition by x.level__, &account_type x.flex_value) start_balance,
x.amount,
x.path_
from
(
select
w.ledger,
w.type,
w.level__,
w.path_,
&account_type
w.flex_value,
w.period_name,
sum(w.start_balance) start_balance,
sum(w.amount) amount
from
(
select
gl.name ledger,
v.type,
v.level__,
v.path_||nvl2(v.flex_value,null,'|'||gcc.&account_segment) path_,
&account_type
nvl(v.flex_value,gcc.&account_segment) flex_value,
gps.period_name,
decode(gps.start_period,'Y',nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0)) start_balance,
nvl(gb.period_net_dr,0)-nvl(gb.period_net_cr,0) amount
from
gl_ledgers gl,
gl_period_statuses gps0,
(select decode(gps.period_num,min(gps.period_num) over (partition by gps.ledger_id, gps.application_id, gps.period_year),'Y') start_period, gps.* from gl_period_statuses gps) gps,
gl_balances gb,
gl_code_combinations gcc,
(
select
'Parent' type,
rowgen.column_value level__,
regexp_substr(u.path,'[^|]+',1,rowgen.column_value) flex_value,
nvl(substr(u.path,1,instr(u.path,'|',1,rowgen.column_value)-1),u.path) path_,
u.*
from
(
select
level level_,
substr(sys_connect_by_path(ffvnh.parent_flex_value,'|'),2) path,
ffvnh.child_flex_value_low,
ffvnh.child_flex_value_high
from
(select ffvnh.* from fnd_flex_value_norm_hierarchy ffvnh where ffvnh.flex_value_set_id=&flex_value_set_id) ffvnh
where
connect_by_isleaf=1 and
ffvnh.range_attribute='C'
connect by nocycle
ffvnh.parent_flex_value between prior ffvnh.child_flex_value_low and prior ffvnh.child_flex_value_high and
prior ffvnh.range_attribute='P'
start with
1=1
) u,
table(xxen_util.rowgen(u.level_)) rowgen
union all
select
'Child' type,
level+1 level__,
null flex_value,
substr(sys_connect_by_path(ffvnh.parent_flex_value,'|'),2) path_,
null level_,
null path,
ffvnh.child_flex_value_low,
ffvnh.child_flex_value_high
from
(select ffvnh.* from fnd_flex_value_norm_hierarchy ffvnh where :show_account_level='Y' and ffvnh.flex_value_set_id=&flex_value_set_id) ffvnh
where
connect_by_isleaf=1 and
ffvnh.range_attribute='C'
connect by nocycle
ffvnh.parent_flex_value between prior ffvnh.child_flex_value_low and prior ffvnh.child_flex_value_high and
prior ffvnh.range_attribute='P'
start with
1=1
) v
where
2=2 and
gl.name=:ledger and
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
gb.code_combination_id=gcc.code_combination_id and
gcc.&account_segment between v.child_flex_value_low and v.child_flex_value_high
) w
group by
grouping sets(
(w.ledger, w.type, w.level__, w.path_, &account_type w.flex_value),
(w.ledger, w.type, w.level__, w.path_, &account_type w.flex_value, w.period_name)
)
) x
) y
pivot (
sum(y.amount)
for period_name in (
&pivot_columns
)
) z
order by
z.path_
&order_by_account_type