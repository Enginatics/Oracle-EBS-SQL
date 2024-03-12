/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
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
u.balance_currency,
u.start_balance,
u.debit,
u.credit,
u.amount,
u.end_balance,
u.ledger_currency,
u.ledger_start_balance,
u.ledger_debit,
u.ledger_credit,
u.ledger_amount,
u.ledger_end_balance,
--
u.ledger_amount_act actual,
u.ledger_amount_bud budget,
u.ledger_amount_bud_v_act budget_v_actual,
-u.ledger_amount_bud_v_act actual_v_budget,
u.ledger_amount_enc encumbrance,
u.ledger_amount_enc_v_act encumb_v_actual,
-u.ledger_amount_enc_v_act actual_v_encumb,
--
&reval_columns
&segment_columns3
&hierarchy_levels4
u.effective_period_num,
(select flvv.description from fnd_lookup_values_vl flvv where u.actual_flag=flvv.lookup_code and flvv.lookup_type='BATCH_TYPE' and flvv.view_application_id=101 and flvv.security_group_id=0) balance_type,
(select gbv.budget_name from gl_budget_versions gbv where gbv.budget_version_id=u.budget_version_id) budget_name,
(select get.encumbrance_type from gl_encumbrance_types get where get.encumbrance_type_id = u.encumbrance_type_id) encumbrance_type,
case u.actual_flag
when 'A' then '(A) '||xxen_util.description(u.actual_flag,'BATCH_TYPE',101)
when 'B' then '(B) '||(select gbv.budget_name from gl_budget_versions gbv where u.budget_version_id=gbv.budget_version_id)
when 'E' then '(E) '||(select get.encumbrance_type from gl_encumbrance_types get where u.encumbrance_type_id=get.encumbrance_type_id)
end balance_type_label,
u.period_name_label,
u.period_start
from
(
select distinct
z.period_start,
z.period_name,
z.period_name_label,
z.ledger,
&account_type
&hierarchy_levels3
&segment_columns
z.balance_currency,
sum(z.start_balance) over (partition by z.ledger, z.period_name, z.ledger_currency, z.balance_currency, &segment_columns z.actual_flag, z.budget_version_id, z.encumbrance_type_id) start_balance,
sum(z.debit) over (partition by z.ledger, z.period_name, z.ledger_currency, z.balance_currency, &segment_columns z.actual_flag, z.budget_version_id, z.encumbrance_type_id) debit,
sum(z.credit) over (partition by z.ledger, z.period_name, z.ledger_currency, z.balance_currency, &segment_columns z.actual_flag, z.budget_version_id, z.encumbrance_type_id) credit,
sum(z.amount) over (partition by z.ledger, z.period_name, z.ledger_currency, z.balance_currency, &segment_columns z.actual_flag, z.budget_version_id, z.encumbrance_type_id) amount,
sum(z.end_balance) over (partition by z.ledger, z.period_name, z.ledger_currency, z.balance_currency, &segment_columns z.actual_flag, z.budget_version_id, z.encumbrance_type_id) end_balance,
--
z.ledger_currency,
sum(z.start_balance_func) over (partition by z.ledger, z.period_name, z.ledger_currency, z.balance_currency, &segment_columns z.actual_flag, z.budget_version_id, z.encumbrance_type_id) ledger_start_balance,
sum(z.debit_func) over (partition by z.ledger, z.period_name, z.ledger_currency, z.balance_currency, &segment_columns z.actual_flag, z.budget_version_id, z.encumbrance_type_id) ledger_debit,
sum(z.credit_func) over (partition by z.ledger, z.period_name, z.ledger_currency, z.balance_currency, &segment_columns z.actual_flag, z.budget_version_id, z.encumbrance_type_id) ledger_credit,
sum(z.amount_func) over (partition by z.ledger, z.period_name, z.ledger_currency, z.balance_currency, &segment_columns z.actual_flag, z.budget_version_id, z.encumbrance_type_id) ledger_amount,
sum(z.end_balance_func) over (partition by z.ledger, z.period_name, z.ledger_currency, z.balance_currency, &segment_columns z.actual_flag, z.budget_version_id, z.encumbrance_type_id) ledger_end_balance,
--
sum(decode(z.actual_flag,'A',z.amount_func,0)) over (partition by z.ledger, z.period_name, z.ledger_currency, z.balance_currency, &segment_columns z.actual_flag, z.budget_version_id, z.encumbrance_type_id) ledger_amount_act,
sum(decode(z.actual_flag,'B',z.amount_func,0)) over (partition by z.ledger, z.period_name, z.ledger_currency, z.balance_currency, &segment_columns z.actual_flag, z.budget_version_id, z.encumbrance_type_id) ledger_amount_bud,
sum(decode(z.actual_flag,'E',z.amount_func,0)) over (partition by z.ledger, z.period_name, z.ledger_currency, z.balance_currency, &segment_columns z.actual_flag, z.budget_version_id, z.encumbrance_type_id) ledger_amount_enc,
sum(decode(z.actual_flag,'B',z.amount_func,'A',-z.amount_func,0)) over (partition by z.ledger, z.period_name, z.ledger_currency, z.balance_currency, &segment_columns z.actual_flag, z.budget_version_id, z.encumbrance_type_id) ledger_amount_bud_v_act,
sum(decode(z.actual_flag,'E',z.amount_func,'A',-z.amount_func,0)) over (partition by z.ledger, z.period_name, z.ledger_currency, z.balance_currency, &segment_columns z.actual_flag, z.budget_version_id, z.encumbrance_type_id) ledger_amount_enc_v_act,
--
:reval_currency reval_currency,
z.rate reval_rate,
sum(z.start_balance_func*z.rate) over (partition by z.ledger, z.period_name, z.ledger_currency, z.balance_currency, &segment_columns z.actual_flag, z.budget_version_id, z.encumbrance_type_id) reval_start_balance,
sum(z.debit_func*z.rate) over (partition by z.ledger, z.period_name, z.ledger_currency, z.balance_currency, &segment_columns z.actual_flag, z.budget_version_id, z.encumbrance_type_id) reval_debit,
sum(z.credit_func*z.rate) over (partition by z.ledger, z.period_name, z.ledger_currency, z.balance_currency, &segment_columns z.actual_flag, z.budget_version_id, z.encumbrance_type_id) reval_credit,
sum(z.amount_func*z.rate) over (partition by z.ledger, z.period_name, z.ledger_currency, z.balance_currency, &segment_columns z.actual_flag, z.budget_version_id, z.encumbrance_type_id) reval_amount,
sum(z.end_balance_func*z.rate) over (partition by z.ledger, z.period_name, z.ledger_currency, z.balance_currency, &segment_columns z.actual_flag, z.budget_version_id, z.encumbrance_type_id) reval_end_balance,
gcck.chart_of_accounts_id,
z.effective_period_num,
z.actual_flag,
z.budget_version_id,
z.encumbrance_type_id
from
(
select
y.column_value,
decode(y.column_value,2,x.period_start - 1,x.period_start) period_start,
decode(y.column_value,2,'Open Bal.',x.period_name) period_name,
decode(y.column_value,2,'00 '||xxen_report.column_translation('START_BALANCE'),to_char(x.period_year)||'-'||lpad(x.period_num,2,'0')||' ('||x.period_name||')') period_name_label,
x.ledger,
x.ledger_currency,
x.balance_currency,
decode(y.column_value,2,null,x.start_balance) start_balance,
decode(y.column_value,2,null,x.debit) debit,
decode(y.column_value,2,null,x.credit) credit,
decode(y.column_value,2,x.start_balance,x.amount) amount,
decode(y.column_value,2,null,x.end_balance) end_balance,
--
decode(y.column_value,2,null,x.start_balance_func) start_balance_func,
decode(y.column_value,2,null,x.debit_func) debit_func,
decode(y.column_value,2,null,x.credit_func) credit_func,
decode(y.column_value,2,x.start_balance_func,x.amount_func) amount_func,
decode(y.column_value,2,null,x.end_balance_func) end_balance_func,
--
x.rate,
decode(y.column_value,2,0,x.effective_period_num) effective_period_num,
x.start_effective_period_num,
x.code_combination_id,
x.actual_flag,
x.budget_version_id,
x.encumbrance_type_id
from
(
select
gb.period_name,
gl.name ledger,
--nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0) start_balance,
case when :p_currency_type = 'E' and gb.currency_code = gl.currency_code and gb.actual_flag = 'A'
then nvl(gb.begin_balance_dr_beq,0)-nvl(gb.begin_balance_cr_beq,0)
else nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0)
end start_balance,
--gb.period_net_dr debit,
case when :p_currency_type = 'E' and gb.currency_code = gl.currency_code and gb.actual_flag = 'A'
then gb.period_net_dr_beq
else gb.period_net_dr
end debit,
--gb.period_net_cr credit,
case when :p_currency_type = 'E' and gb.currency_code = gl.currency_code and gb.actual_flag = 'A'
then gb.period_net_cr_beq
else gb.period_net_cr
end credit,
--nvl(gb.period_net_dr,0)-nvl(gb.period_net_cr,0) amount,
case when :p_currency_type = 'E' and gb.currency_code = gl.currency_code and gb.actual_flag = 'A'
then nvl(gb.period_net_dr_beq,0)-nvl(gb.period_net_cr_beq,0)
else nvl(gb.period_net_dr,0)-nvl(gb.period_net_cr,0)
end amount,
--nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0)+nvl(gb.period_net_dr,0)-nvl(gb.period_net_cr,0) end_balance,
case when :p_currency_type = 'E' and gb.currency_code = gl.currency_code and gb.actual_flag = 'A'
then nvl(gb.begin_balance_dr_beq,0)-nvl(gb.begin_balance_cr_beq,0)+nvl(gb.period_net_dr_beq,0)-nvl(gb.period_net_cr_beq,0)
else nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0)+nvl(gb.period_net_dr,0)-nvl(gb.period_net_cr,0)
end end_balance,
--
-- functional amounts
--
case
when gb.currency_code = 'STAT' then to_number(null)
when gb.currency_code = gl.currency_code
then case when :p_currency_type = 'T' or gb.actual_flag != 'A'
     then nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0)
     else nvl(gb.begin_balance_dr_beq,0)-nvl(gb.begin_balance_cr_beq,0)
     end
when gb.translated_flag = 'R' then nvl(gb.begin_balance_dr_beq,0)-nvl(gb.begin_balance_cr_beq,0)
end start_balance_func,
--
case
when gb.currency_code = 'STAT' then to_number(null)
when gb.currency_code = gl.currency_code
then case when :p_currency_type = 'T' or gb.actual_flag != 'A'
     then gb.period_net_dr
     else gb.period_net_dr_beq
     end
when gb.translated_flag = 'R' then gb.period_net_dr_beq
end debit_func,
--
case
when gb.currency_code = 'STAT' then to_number(null)
when gb.currency_code = gl.currency_code
then case when :p_currency_type = 'T' or gb.actual_flag != 'A'
     then gb.period_net_cr
     else gb.period_net_cr_beq
     end
when gb.translated_flag = 'R' then gb.period_net_cr_beq
end credit_func,
--
case
when gb.currency_code = 'STAT' then to_number(null)
when gb.currency_code = gl.currency_code
then case when :p_currency_type = 'T' or gb.actual_flag != 'A'
     then nvl(gb.period_net_dr,0)-nvl(gb.period_net_cr,0)
     else nvl(gb.period_net_dr_beq,0)-nvl(gb.period_net_cr_beq,0)
     end
when gb.translated_flag = 'R' then nvl(gb.period_net_dr_beq,0)-nvl(gb.period_net_cr_beq,0)
end amount_func,
--
case
when gb.currency_code = 'STAT' then to_number(null)
when gb.currency_code = gl.currency_code
then case when :p_currency_type = 'T' or gb.actual_flag != 'A'
     then nvl(gb.period_net_dr,0)-nvl(gb.period_net_cr,0)
     else nvl(gb.begin_balance_dr_beq,0)-nvl(gb.begin_balance_cr_beq,0)+nvl(gb.period_net_dr_beq,0)-nvl(gb.period_net_cr_beq,0)
     end
when gb.translated_flag = 'R' then nvl(gb.begin_balance_dr_beq,0)-nvl(gb.begin_balance_cr_beq,0)+nvl(gb.period_net_dr_beq,0)-nvl(gb.period_net_cr_beq,0)
end end_balance_func,
--
decode(gl.currency_code,:reval_currency,1,(select gdr.conversion_rate from gl_daily_conversion_types gdct, gl_daily_rates gdr where gl.currency_code=gdr.from_currency and gdr.to_currency=:reval_currency and gp.end_date=gdr.conversion_date and gdct.user_conversion_type=:reval_conversion_type and gdct.conversion_type=gdr.conversion_type)) rate,
gl.currency_code ledger_currency,
gb.currency_code balance_currency,
count(distinct gp.period_num) over () period_count,
gp.period_num,
gp.period_year,
gp.period_year*10000+gp.period_num effective_period_num,
min(gp.period_year*10000+gp.period_num) over () start_effective_period_num,
gp.start_date period_start,
gb.code_combination_id,
gb.actual_flag,
gb.budget_version_id,
gb.encumbrance_type_id
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
gb.currency_code=decode(:p_currency_type,'T',gl.currency_code,'S','STAT',nvl(:p_entered_currency,decode(gb.currency_code,'STAT',null,gb.currency_code))) and
case nvl(gb.translated_flag,'?')
 when 'R' then 'R'
 when 'Y' then 'Y'
 when 'N' then 'Y'
 when '?'
 then case :p_currency_type
      when 'E' then case gb.currency_code when gl.currency_code then 'R' else 'X' end
      when 'S' then 'S'
      when 'T' then case gb.currency_code when 'STAT' then 'X' else 'Y' end
      end
 end = case :p_currency_type when 'E' then 'R' when 'S' then 'S' when 'T' then 'Y' end
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
4=4 and
&gl_flex_value_security
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
balance_type,
u.balance_currency