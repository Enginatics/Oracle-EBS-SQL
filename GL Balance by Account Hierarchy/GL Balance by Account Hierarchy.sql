/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Balance by Account Hierarchy
-- Description: Summary GL report including one line per GL account. This report has multiple collapsible/expandable summary levels based on the GL account hierarchy, with starting balance, total amount per month, ending total and YTD balance.
Parameter 'Additional Segment' can be used to include additional segments e.g. cost center or balancing segment.
-- Excel Examle Output: https://www.enginatics.com/example/gl-balance-by-account-hierarchy/
-- Library Link: https://www.enginatics.com/reports/gl-balance-by-account-hierarchy/
-- Run Report: https://demo.enginatics.com/

select
y.ledger,
lpad(' ',2*(y.level__-1))||y.level__ level_,
&segment2_columns_first
&account_type2
lpad(' ',2*(y.level__-1))||y.flex_value "&segment1_name",
xxen_util.segment_description(y.flex_value,'&segment1',y.chart_of_accounts_id) "&segment1_name desc",
&segment2_columns
y.start_balance,
&period_columns
y.total,
nvl(y.start_balance,0)+nvl(y.total,0) ytd,
y.currency_code currency,
&start_balance_reval
&period_columns_reval
&total_reval
y.type,
y.path_,
y.flex_value
from
(
select distinct
w.ledger,
w.type,
w.level__,
w.path_,
&account_type
w.flex_value &segment2,
w.period_name,
sum(w.start_bal       ) over (partition by w.ledger, w.type, w.path_, &account_type w.flex_value &segment2) start_balance,
sum(w.start_bal*w.rate) over (partition by w.ledger, w.type, w.path_, &account_type w.flex_value &segment2) start_balance_reval,
sum(w.amount          ) over (partition by w.ledger, w.type, w.path_, &account_type w.flex_value &segment2) total,
sum(w.abs_amount      ) over (partition by w.ledger, w.type, w.path_, &account_type w.flex_value &segment2) abs_total,
sum(w.amount*w.rate   ) over (partition by w.ledger, w.type, w.path_, &account_type w.flex_value &segment2) total_reval,
sum(w.amount          ) over (partition by w.ledger, w.type, w.path_, &account_type w.flex_value &segment2, w.period_name) amount,
sum(w.amount*w.rate   ) over (partition by w.ledger, w.type, w.path_, &account_type w.flex_value &segment2, w.period_name) amount_reval,
w.currency_code,
w.flex_value_set_id,
w.chart_of_accounts_id
from
(
select
gl.name ledger,
v.type,
v.level__,
v.path_||nvl2(v.flex_value,null,'|'||gcc.&segment1) path_,
&account_type
nvl(v.flex_value,gcc.&segment1) flex_value &segment2,
gps.period_name,
decode(gps.start_period,'Y',nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0)) start_bal,
nvl(gb.period_net_dr,0)-nvl(gb.period_net_cr,0) amount,
abs(nvl(gb.period_net_dr,0))+abs(nvl(gb.period_net_cr,0)) abs_amount,
decode(gl.currency_code,:reval_currency,1,(select gdr.conversion_rate from gl_daily_conversion_types gdct, gl_daily_rates gdr where gl.currency_code=gdr.from_currency and gdr.to_currency=:reval_currency and gps.end_date=gdr.conversion_date and gdct.user_conversion_type=:reval_conversion_type and gdct.conversion_type=gdr.conversion_type)) rate,
gl.currency_code,
v.flex_value_set_id,
gl.chart_of_accounts_id
from
gl_ledgers gl,
gl_period_statuses gps0,
(select decode(gps.period_num,min(gps.period_num) over (partition by gps.ledger_id, gps.application_id, gps.period_year),'Y') start_period, gps.* from gl_period_statuses gps) gps,
gl_balances gb,
(
select
ffv.summary_flag parent_flag,
gcc.*
from
(
select
(select fifs.flex_value_set_id from fnd_id_flex_segments fifs where gcc.chart_of_accounts_id=fifs.id_flex_num and fifs.application_id=101 and fifs.id_flex_code='GL#' and fifs.application_column_name='&segment1') flex_value_set_id,
gcc.*
from
gl_code_combinations gcc
) gcc,
(select ffv.* from fnd_flex_values ffv where ffv.parent_flex_value_low is null) ffv
where
gcc.flex_value_set_id=ffv.flex_value_set_id(+) and
gcc.&segment1=ffv.flex_value(+)
) gcc,
(
select
'Parent' type,
rowgen.column_value level__,
regexp_substr(u.path,'[^|]+',1,rowgen.column_value) flex_value,
nvl(substr(u.path,1,instr(u.path,'|',1,rowgen.column_value)-1),u.path) path_,
u.*
from
(
select --generate all paths from top to the lowermost parents, which only contain childs
level level_,
substr(sys_connect_by_path(ffvnh.parent_flex_value,'|'),2) path,
ffvnh.child_flex_value_low,
ffvnh.child_flex_value_high,
ffvnh.flex_value_set_id
from
(select ffvnh.* from fnd_flex_value_norm_hierarchy ffvnh where ffvnh.flex_value_set_id in (&flex_value_set_ids)) ffvnh
where
connect_by_isleaf=1 and
ffvnh.range_attribute='C'
connect by nocycle
ffvnh.parent_flex_value between prior ffvnh.child_flex_value_low and prior ffvnh.child_flex_value_high and
ffvnh.flex_value_set_id=prior ffvnh.flex_value_set_id and
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
ffvnh.child_flex_value_high,
ffvnh.flex_value_set_id
from
(select ffvnh.* from fnd_flex_value_norm_hierarchy ffvnh where :show_account_level='Y' and ffvnh.flex_value_set_id in (&flex_value_set_ids)) ffvnh
where
connect_by_isleaf=1 and
ffvnh.range_attribute='C'
connect by nocycle
ffvnh.parent_flex_value between prior ffvnh.child_flex_value_low and prior ffvnh.child_flex_value_high and
ffvnh.flex_value_set_id=prior ffvnh.flex_value_set_id and
prior ffvnh.range_attribute='P'
start with
1=1
) v,
(
select distinct --best matching summary templates for all ledgers
x.ledger_id,
min(x.template_id) keep (dense_rank first order by x.score,x.template_id) over (partition by x.ledger_id) template_id
from
(
select
gl.ledger_id,
gst.template_id,
decode(fsav.account,'SEGMENT1',0,decode(gst.segment1_type,'T',0,'D',decode(fsav.balancing,'SEGMENT1',2,4),decode(fsav.balancing,'SEGMENT1',1,2)))+
decode(fsav.account,'SEGMENT2',0,decode(gst.segment2_type,'T',0,'D',decode(fsav.balancing,'SEGMENT2',2,4),decode(fsav.balancing,'SEGMENT2',1,2)))+
decode(fsav.account,'SEGMENT3',0,decode(gst.segment3_type,'T',0,'D',decode(fsav.balancing,'SEGMENT3',2,4),decode(fsav.balancing,'SEGMENT3',1,2)))+
decode(fsav.account,'SEGMENT4',0,decode(gst.segment4_type,'T',0,'D',decode(fsav.balancing,'SEGMENT4',2,4),decode(fsav.balancing,'SEGMENT4',1,2)))+
decode(fsav.account,'SEGMENT5',0,decode(gst.segment5_type,'T',0,'D',decode(fsav.balancing,'SEGMENT5',2,4),decode(fsav.balancing,'SEGMENT5',1,2)))+
decode(fsav.account,'SEGMENT6',0,decode(gst.segment6_type,'T',0,'D',decode(fsav.balancing,'SEGMENT6',2,4),decode(fsav.balancing,'SEGMENT6',1,2)))+
decode(fsav.account,'SEGMENT7',0,decode(gst.segment7_type,'T',0,'D',decode(fsav.balancing,'SEGMENT7',2,4),decode(fsav.balancing,'SEGMENT7',1,2)))+
decode(fsav.account,'SEGMENT8',0,decode(gst.segment8_type,'T',0,'D',decode(fsav.balancing,'SEGMENT8',2,4),decode(fsav.balancing,'SEGMENT8',1,2)))+
decode(fsav.account,'SEGMENT9',0,decode(gst.segment9_type,'T',0,'D',decode(fsav.balancing,'SEGMENT9',2,4),decode(fsav.balancing,'SEGMENT9',1,2)))+
decode(fsav.account,'SEGMENT10',0,decode(gst.segment10_type,'T',0,'D',decode(fsav.balancing,'SEGMENT10',2,4),decode(fsav.balancing,'SEGMENT10',1,2)))+
decode(fsav.account,'SEGMENT11',0,decode(gst.segment11_type,'T',0,'D',decode(fsav.balancing,'SEGMENT11',2,4),decode(fsav.balancing,'SEGMENT11',1,2)))
score,
decode(fsav.account,
'SEGMENT1',gst.segment1_type,
'SEGMENT2',gst.segment2_type,
'SEGMENT3',gst.segment3_type,
'SEGMENT4',gst.segment4_type,
'SEGMENT5',gst.segment5_type,
'SEGMENT6',gst.segment6_type,
'SEGMENT7',gst.segment7_type,
'SEGMENT8',gst.segment8_type,
'SEGMENT9',gst.segment9_type,
'SEGMENT10',gst.segment10_type,
'SEGMENT11',gst.segment11_type
) account_segment_type
from
gl_ledgers gl,
(
select
y.*
from
(
select
fsav.id_flex_num,
fsav.segment_attribute_type,
fsav.application_column_name
from
fnd_segment_attribute_values fsav
where
fsav.application_id=101 and
fsav.id_flex_code='GL#' and
fsav.segment_attribute_type in ('GL_ACCOUNT','GL_BALANCING') and
fsav.attribute_value='Y'
) x
pivot (
max(x.application_column_name)
for segment_attribute_type in ('GL_BALANCING' balancing, 'GL_ACCOUNT' account)
) y
) fsav,
gl_summary_templates gst
where
gl.chart_of_accounts_id=fsav.id_flex_num and
gl.ledger_id=gst.ledger_id
) x
where
x.account_segment_type='D'
) gstv
where
2=2 and
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
gb.code_combination_id=gcc.code_combination_id and
gcc.parent_flag='N' and
gcc.flex_value_set_id=v.flex_value_set_id and
gcc.&segment1 between v.child_flex_value_low and v.child_flex_value_high and
gl.ledger_id=gstv.ledger_id(+)
) w
) x
pivot (
max(x.amount), max(x.amount_reval) reval
for period_name in (
&pivot_columns
)
) y
where
3=3
order by
y.ledger,
&order_by_segment2
y.path_
&order_by_account_type
&segment2