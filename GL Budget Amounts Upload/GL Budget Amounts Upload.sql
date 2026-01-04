/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Budget Amounts Upload
-- Description: GL Budget Amounts Upload
===================
This can be used to upload GL Budget Amounts
-- Excel Examle Output: https://www.enginatics.com/example/gl-budget-amounts-upload/
-- Library Link: https://www.enginatics.com/reports/gl-budget-amounts-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
null row_id,
null request_id_,
null request_output,
to_number(null) group_id,
glv.name ledger_name,
gbe.name budget_organization,
gbve.budget_name,
xxen_util.meaning(gbv.require_budget_journals_flag ,'YES_NO',0) budget_requires_journal,
null journal_source_name,
null journal_category_name,
gbauv.currency_code,
gbpr.period_year fiscal_year,
null add_or_replace,
gcck.concatenated_segments account,
(select
gps.period_name
from
gl_period_statuses gps
where
gps.ledger_id=glv.ledger_id and
gps.period_year=gbpr.period_year and
gps.application_id=101 and
gps.period_num=1 and
gps.period_num between gbpr.start_period_num and gbpr.end_period_num
) period1_name,
case when gbv.require_budget_journals_flag='Y' then
(select
sum(nvl(gbp.entered_dr,0) - nvl(gbp.entered_cr,0))
from
gl_bc_packets gbp
where
gbp.budget_version_id=gbve.budget_version_id and
gbp.ledger_id=gbe.ledger_id and
gbp.period_num=1 and
gbp.period_year=gbpr.period_year and
gbp.actual_flag='B' and
gbp.status_code='A' and
gbp.code_combination_id=gcck.code_combination_id)
else
(
select
sum(nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0))
from
gl_balances gb
where
gb.budget_version_id=gbve.budget_version_id and
gb.ledger_id=gbe.ledger_id and
gb.period_num=1 and
gb.period_year=gbpr.period_year and
gb.actual_flag='B' and
gcck.code_combination_id=gb.code_combination_id
) 
end period1_amount,
(select
gps.period_name
from
gl_period_statuses gps
where
gps.ledger_id=glv.ledger_id and
gps.period_year=gbpr.period_year and
gps.application_id=101 and
gps.period_num=2 and
gps.period_num between gbpr.start_period_num and gbpr.end_period_num
) period2_name,
case when gbv.require_budget_journals_flag='Y' then
(select
sum(nvl(gbp.entered_dr,0) - nvl(gbp.entered_cr,0))
from
gl_bc_packets gbp
where
gbp.budget_version_id=gbve.budget_version_id and
gbp.ledger_id=gbe.ledger_id and
gbp.period_num=2 and
gbp.period_year=gbpr.period_year and
gbp.actual_flag='B' and
gbp.status_code='A' and
gbp.code_combination_id=gcck.code_combination_id)
else
(
select
sum(nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0))
from
gl_balances gb
where
gb.budget_version_id=gbve.budget_version_id and
gb.ledger_id=gbe.ledger_id and
gb.period_num=2 and
gb.period_year=gbpr.period_year and
gb.actual_flag='B' and
gcck.code_combination_id=gb.code_combination_id
) 
end period2_amount,
(select
gps.period_name
from
gl_period_statuses gps
where
gps.ledger_id=glv.ledger_id and
gps.period_year=gbpr.period_year and
gps.application_id=101 and
gps.period_num=3 and
gps.period_num between gbpr.start_period_num and gbpr.end_period_num
) period3_name,
case when gbv.require_budget_journals_flag='Y' then
(select
sum(nvl(gbp.entered_dr,0) - nvl(gbp.entered_cr,0))
from
gl_bc_packets gbp
where
gbp.budget_version_id=gbve.budget_version_id and
gbp.ledger_id=gbe.ledger_id and
gbp.period_num=3 and
gbp.period_year=gbpr.period_year and
gbp.actual_flag='B' and
gbp.status_code='A' and
gbp.code_combination_id=gcck.code_combination_id)
else
(
select
sum(nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0))
from
gl_balances gb
where
gb.budget_version_id=gbve.budget_version_id and
gb.ledger_id=gbe.ledger_id and
gb.period_num=3 and
gb.period_year=gbpr.period_year and
gb.actual_flag='B' and
gcck.code_combination_id=gb.code_combination_id
) 
end period3_amount,
(select
gps.period_name
from
gl_period_statuses gps
where
gps.ledger_id=glv.ledger_id and
gps.period_year=gbpr.period_year and
gps.application_id=101 and
gps.period_num=4 and
gps.period_num between gbpr.start_period_num and gbpr.end_period_num
) period4_name,
case when gbv.require_budget_journals_flag='Y' then
(select
sum(nvl(gbp.entered_dr,0) - nvl(gbp.entered_cr,0))
from
gl_bc_packets gbp
where
gbp.budget_version_id=gbve.budget_version_id and
gbp.ledger_id=gbe.ledger_id and
gbp.period_num=4 and
gbp.period_year=gbpr.period_year and
gbp.actual_flag='B' and
gbp.status_code='A' and
gbp.code_combination_id=gcck.code_combination_id)
else
(
select
sum(nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0))
from
gl_balances gb
where
gb.budget_version_id=gbve.budget_version_id and
gb.ledger_id=gbe.ledger_id and
gb.period_num=4 and
gb.period_year=gbpr.period_year and
gb.actual_flag='B' and
gcck.code_combination_id=gb.code_combination_id
) 
end period4_amount,
(select
gps.period_name
from
gl_period_statuses gps
where
gps.ledger_id=glv.ledger_id and
gps.period_year=gbpr.period_year and
gps.application_id=101 and
gps.period_num=5 and
gps.period_num between gbpr.start_period_num and gbpr.end_period_num
) period5_name,
case when gbv.require_budget_journals_flag='Y' then
(select
sum(nvl(gbp.entered_dr,0) - nvl(gbp.entered_cr,0))
from
gl_bc_packets gbp
where
gbp.budget_version_id=gbve.budget_version_id and
gbp.ledger_id=gbe.ledger_id and
gbp.period_num=5 and
gbp.period_year=gbpr.period_year and
gbp.actual_flag='B' and
gbp.status_code='A' and
gbp.code_combination_id=gcck.code_combination_id)
else
(
select
sum(nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0))
from
gl_balances gb
where
gb.budget_version_id=gbve.budget_version_id and
gb.ledger_id=gbe.ledger_id and
gb.period_num=5 and
gb.period_year=gbpr.period_year and
gb.actual_flag='B' and
gcck.code_combination_id=gb.code_combination_id
) 
end period5_amount,
(select
gps.period_name
from
gl_period_statuses gps
where
gps.ledger_id=glv.ledger_id and
gps.period_year=gbpr.period_year and
gps.application_id=101 and
gps.period_num=6 and
gps.period_num between gbpr.start_period_num and gbpr.end_period_num
) period6_name,
case when gbv.require_budget_journals_flag='Y' then
(select
sum(nvl(gbp.entered_dr,0) - nvl(gbp.entered_cr,0))
from
gl_bc_packets gbp
where
gbp.budget_version_id=gbve.budget_version_id and
gbp.ledger_id=gbe.ledger_id and
gbp.period_num=6 and
gbp.period_year=gbpr.period_year and
gbp.actual_flag='B' and
gbp.status_code='A' and
gbp.code_combination_id=gcck.code_combination_id)
else
(
select
sum(nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0))
from
gl_balances gb
where
gb.budget_version_id=gbve.budget_version_id and
gb.ledger_id=gbe.ledger_id and
gb.period_num=6 and
gb.period_year=gbpr.period_year and
gb.actual_flag='B' and
gcck.code_combination_id=gb.code_combination_id
) 
end period6_amount,
(select
gps.period_name
from
gl_period_statuses gps
where
gps.ledger_id=glv.ledger_id and
gps.period_year=gbpr.period_year and
gps.application_id=101 and
gps.period_num=7 and
gps.period_num between gbpr.start_period_num and gbpr.end_period_num
) period7_name,
case when gbv.require_budget_journals_flag='Y' then
(select
sum(nvl(gbp.entered_dr,0) - nvl(gbp.entered_cr,0))
from
gl_bc_packets gbp
where
gbp.budget_version_id=gbve.budget_version_id and
gbp.ledger_id=gbe.ledger_id and
gbp.period_num=7 and
gbp.period_year=gbpr.period_year and
gbp.actual_flag='B' and
gbp.status_code='A' and
gbp.code_combination_id=gcck.code_combination_id)
else
(
select
sum(nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0))
from
gl_balances gb
where
gb.budget_version_id=gbve.budget_version_id and
gb.ledger_id=gbe.ledger_id and
gb.period_num=7 and
gb.period_year=gbpr.period_year and
gb.actual_flag='B' and
gcck.code_combination_id=gb.code_combination_id
) 
end period7_amount,
(select
gps.period_name
from
gl_period_statuses gps
where
gps.ledger_id=glv.ledger_id and
gps.period_year=gbpr.period_year and
gps.application_id=101 and
gps.period_num=8 and
gps.period_num between gbpr.start_period_num and gbpr.end_period_num
) period8_name,
case when gbv.require_budget_journals_flag='Y' then
(select
sum(nvl(gbp.entered_dr,0) - nvl(gbp.entered_cr,0))
from
gl_bc_packets gbp
where
gbp.budget_version_id=gbve.budget_version_id and
gbp.ledger_id=gbe.ledger_id and
gbp.period_num=8 and
gbp.period_year=gbpr.period_year and
gbp.actual_flag='B' and
gbp.status_code='A' and
gbp.code_combination_id=gcck.code_combination_id)
else
(
select
sum(nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0))
from
gl_balances gb
where
gb.budget_version_id=gbve.budget_version_id and
gb.ledger_id=gbe.ledger_id and
gb.period_num=8 and
gb.period_year=gbpr.period_year and
gb.actual_flag='B' and
gcck.code_combination_id=gb.code_combination_id
) 
end period8_amount,
(select
gps.period_name
from
gl_period_statuses gps
where
gps.ledger_id=glv.ledger_id and
gps.period_year=gbpr.period_year and
gps.application_id=101 and
gps.period_num=9 and
gps.period_num between gbpr.start_period_num and gbpr.end_period_num
) period9_name,
case when gbv.require_budget_journals_flag='Y' then
(select
sum(nvl(gbp.entered_dr,0) - nvl(gbp.entered_cr,0))
from
gl_bc_packets gbp
where
gbp.budget_version_id=gbve.budget_version_id and
gbp.ledger_id=gbe.ledger_id and
gbp.period_num=9 and
gbp.period_year=gbpr.period_year and
gbp.actual_flag='B' and
gbp.status_code='A' and
gbp.code_combination_id=gcck.code_combination_id)
else
(
select
sum(nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0))
from
gl_balances gb
where
gb.budget_version_id=gbve.budget_version_id and
gb.ledger_id=gbe.ledger_id and
gb.period_num=9 and
gb.period_year=gbpr.period_year and
gb.actual_flag='B' and
gcck.code_combination_id=gb.code_combination_id
) 
end period9_amount,
(select
gps.period_name
from
gl_period_statuses gps
where
gps.ledger_id=glv.ledger_id and
gps.period_year=gbpr.period_year and
gps.application_id=101 and
gps.period_num=10 and
gps.period_num between gbpr.start_period_num and gbpr.end_period_num
) period10_name,
case when gbv.require_budget_journals_flag='Y' then
(select
sum(nvl(gbp.entered_dr,0) - nvl(gbp.entered_cr,0))
from
gl_bc_packets gbp
where
gbp.budget_version_id=gbve.budget_version_id and
gbp.ledger_id=gbe.ledger_id and
gbp.period_num=10 and
gbp.period_year=gbpr.period_year and
gbp.actual_flag='B' and
gbp.status_code='A' and
gbp.code_combination_id=gcck.code_combination_id)
else
(
select
sum(nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0))
from
gl_balances gb
where
gb.budget_version_id=gbve.budget_version_id and
gb.ledger_id=gbe.ledger_id and
gb.period_num=10 and
gb.period_year=gbpr.period_year and
gb.actual_flag='B' and
gcck.code_combination_id=gb.code_combination_id
) 
end period10_amount,
(select
gps.period_name
from
gl_period_statuses gps
where
gps.ledger_id=glv.ledger_id and
gps.period_year=gbpr.period_year and
gps.application_id=101 and
gps.period_num=11 and
gps.period_num between gbpr.start_period_num and gbpr.end_period_num
) period11_name,
case when gbv.require_budget_journals_flag='Y' then
(select
sum(nvl(gbp.entered_dr,0) - nvl(gbp.entered_cr,0))
from
gl_bc_packets gbp
where
gbp.budget_version_id=gbve.budget_version_id and
gbp.ledger_id=gbe.ledger_id and
gbp.period_num=11 and
gbp.period_year=gbpr.period_year and
gbp.actual_flag='B' and
gbp.status_code='A' and
gbp.code_combination_id=gcck.code_combination_id)
else
(
select
sum(nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0))
from
gl_balances gb
where
gb.budget_version_id=gbve.budget_version_id and
gb.ledger_id=gbe.ledger_id and
gb.period_num=11 and
gb.period_year=gbpr.period_year and
gb.actual_flag='B' and
gcck.code_combination_id=gb.code_combination_id
) 
end period11_amount,
(select
gps.period_name
from
gl_period_statuses gps
where
gps.ledger_id=glv.ledger_id and
gps.period_year=gbpr.period_year and
gps.application_id=101 and
gps.period_num=12 and
gps.period_num between gbpr.start_period_num and gbpr.end_period_num
) period12_name,
case when gbv.require_budget_journals_flag='Y' then
(select
sum(nvl(gbp.entered_dr,0) - nvl(gbp.entered_cr,0))
from
gl_bc_packets gbp
where
gbp.budget_version_id=gbve.budget_version_id and
gbp.ledger_id=gbe.ledger_id and
gbp.period_num=12 and
gbp.period_year=gbpr.period_year and
gbp.actual_flag='B' and
gbp.status_code='A' and
gbp.code_combination_id=gcck.code_combination_id)
else
(
select
sum(nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0))
from
gl_balances gb
where
gb.budget_version_id=gbve.budget_version_id and
gb.ledger_id=gbe.ledger_id and
gb.period_num=12 and
gb.period_year=gbpr.period_year and
gb.actual_flag='B' and
gcck.code_combination_id=gb.code_combination_id
) 
end period12_amount,
(select
gps.period_name
from
gl_period_statuses gps
where
gps.ledger_id=glv.ledger_id and
gps.period_year=gbpr.period_year and
gps.application_id=101 and
gps.period_num=13 and
gps.period_num between gbpr.start_period_num and gbpr.end_period_num
) period13_name,
case when gbv.require_budget_journals_flag='Y' then
(select
sum(nvl(gbp.entered_dr,0) - nvl(gbp.entered_cr,0))
from
gl_bc_packets gbp
where
gbp.budget_version_id=gbve.budget_version_id and
gbp.ledger_id=gbe.ledger_id and
gbp.period_num=13 and
gbp.period_year=gbpr.period_year and
gbp.actual_flag='B' and
gbp.status_code='A' and
gbp.code_combination_id=gcck.code_combination_id)
else
(
select
sum(nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0))
from
gl_balances gb
where
gb.budget_version_id=gbve.budget_version_id and
gb.ledger_id=gbe.ledger_id and
gb.period_num=13 and
gb.period_year=gbpr.period_year and
gb.actual_flag='B' and
gcck.code_combination_id=gb.code_combination_id
) 
end period13_amount,
(select
gps.period_name
from
gl_period_statuses gps
where
gps.ledger_id=glv.ledger_id and
gps.period_year=gbpr.period_year and
gps.application_id=101 and
gps.period_num=14 and
gps.period_num between gbpr.start_period_num and gbpr.end_period_num
) period14_name,
case when gbv.require_budget_journals_flag='Y' then
(select
sum(nvl(gbp.entered_dr,0) - nvl(gbp.entered_cr,0))
from
gl_bc_packets gbp
where
gbp.budget_version_id=gbve.budget_version_id and
gbp.ledger_id=gbe.ledger_id and
gbp.period_num=14 and
gbp.period_year=gbpr.period_year and
gbp.actual_flag='B' and
gbp.status_code='A' and
gbp.code_combination_id=gcck.code_combination_id)
else
(
select
sum(nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0))
from
gl_balances gb
where
gb.budget_version_id=gbve.budget_version_id and
gb.ledger_id=gbe.ledger_id and
gb.period_num=14 and
gb.period_year=gbpr.period_year and
gb.actual_flag='B' and
gcck.code_combination_id=gb.code_combination_id
) 
end period14_amount,
(select
gps.period_name
from
gl_period_statuses gps
where
gps.ledger_id=glv.ledger_id and
gps.period_year=gbpr.period_year and
gps.application_id=101 and
gps.period_num=15 and
gps.period_num between gbpr.start_period_num and gbpr.end_period_num
) period15_name,
case when gbv.require_budget_journals_flag='Y' then
(select
sum(nvl(gbp.entered_dr,0) - nvl(gbp.entered_cr,0))
from
gl_bc_packets gbp
where
gbp.budget_version_id=gbve.budget_version_id and
gbp.ledger_id=gbe.ledger_id and
gbp.period_num=15 and
gbp.period_year=gbpr.period_year and
gbp.actual_flag='B' and
gbp.status_code='A' and
gbp.code_combination_id=gcck.code_combination_id)
else
(
select
sum(nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0))
from
gl_balances gb
where
gb.budget_version_id=gbve.budget_version_id and
gb.ledger_id=gbe.ledger_id and
gb.period_num=15 and
gb.period_year=gbpr.period_year and
gb.actual_flag='B' and
gcck.code_combination_id=gb.code_combination_id
) 
end period15_amount,
(select
gps.period_name
from
gl_period_statuses gps
where
gps.ledger_id=glv.ledger_id and
gps.period_year=gbpr.period_year and
gps.application_id=101 and
gps.period_num=16 and
gps.period_num between gbpr.start_period_num and gbpr.end_period_num
) period16_name,
case when gbv.require_budget_journals_flag='Y' then
(select
sum(nvl(gbp.entered_dr,0) - nvl(gbp.entered_cr,0))
from
gl_bc_packets gbp
where
gbp.budget_version_id=gbve.budget_version_id and
gbp.ledger_id=gbe.ledger_id and
gbp.period_num=16 and
gbp.period_year=gbpr.period_year and
gbp.actual_flag='B' and
gbp.status_code='A' and
gbp.code_combination_id=gcck.code_combination_id)
else
(
select
sum(nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0))
from
gl_balances gb
where
gb.budget_version_id=gbve.budget_version_id and
gb.ledger_id=gbe.ledger_id and
gb.period_num=16 and
gb.period_year=gbpr.period_year and
gb.actual_flag='B' and
gcck.code_combination_id=gb.code_combination_id
) 
end period16_amount,
(select
gps.period_name
from
gl_period_statuses gps
where
gps.ledger_id=glv.ledger_id and
gps.period_year=gbpr.period_year and
gps.application_id=101 and
gps.period_num=17 and
gps.period_num between gbpr.start_period_num and gbpr.end_period_num
) period17_name,
case when gbv.require_budget_journals_flag='Y' then
(select
sum(nvl(gbp.entered_dr,0) - nvl(gbp.entered_cr,0))
from
gl_bc_packets gbp
where
gbp.budget_version_id=gbve.budget_version_id and
gbp.ledger_id=gbe.ledger_id and
gbp.period_num=17 and
gbp.period_year=gbpr.period_year and
gbp.actual_flag='B' and
gbp.status_code='A' and
gbp.code_combination_id=gcck.code_combination_id)
else
(
select
sum(nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0))
from
gl_balances gb
where
gb.budget_version_id=gbve.budget_version_id and
gb.ledger_id=gbe.ledger_id and
gb.period_num=17 and
gb.period_year=gbpr.period_year and
gb.actual_flag='B' and
gcck.code_combination_id=gb.code_combination_id
) 
end period17_amount,
(select
gps.period_name
from
gl_period_statuses gps
where
gps.ledger_id=glv.ledger_id and
gps.period_year=gbpr.period_year and
gps.application_id=101 and
gps.period_num=18 and
gps.period_num between gbpr.start_period_num and gbpr.end_period_num
) period18_name,
case when gbv.require_budget_journals_flag='Y' then
(select
sum(nvl(gbp.entered_dr,0) - nvl(gbp.entered_cr,0))
from
gl_bc_packets gbp
where
gbp.budget_version_id=gbve.budget_version_id and
gbp.ledger_id=gbe.ledger_id and
gbp.period_num=18 and
gbp.period_year=gbpr.period_year and
gbp.actual_flag='B' and
gbp.status_code='A' and
gbp.code_combination_id=gcck.code_combination_id)
else
(
select
sum(nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0))
from
gl_balances gb
where
gb.budget_version_id=gbve.budget_version_id and
gb.ledger_id=gbe.ledger_id and
gb.period_num=18 and
gb.period_year=gbpr.period_year and
gb.actual_flag='B' and
gcck.code_combination_id=gb.code_combination_id
) 
end period18_amount,
(select
gps.period_name
from
gl_period_statuses gps
where
gps.ledger_id=glv.ledger_id and
gps.period_year=gbpr.period_year and
gps.application_id=101 and
gps.period_num=19 and
gps.period_num between gbpr.start_period_num and gbpr.end_period_num
) period19_name,
case when gbv.require_budget_journals_flag='Y' then
(select
sum(nvl(gbp.entered_dr,0) - nvl(gbp.entered_cr,0))
from
gl_bc_packets gbp
where
gbp.budget_version_id=gbve.budget_version_id and
gbp.ledger_id=gbe.ledger_id and
gbp.period_num=19 and
gbp.period_year=gbpr.period_year and
gbp.actual_flag='B' and
gbp.status_code='A' and
gbp.code_combination_id=gcck.code_combination_id)
else
(
select
sum(nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0))
from
gl_balances gb
where
gb.budget_version_id=gbve.budget_version_id and
gb.ledger_id=gbe.ledger_id and
gb.period_num=19 and
gb.period_year=gbpr.period_year and
gb.actual_flag='B' and
gcck.code_combination_id=gb.code_combination_id
) 
end period19_amount,
(select
gps.period_name
from
gl_period_statuses gps
where
gps.ledger_id=glv.ledger_id and
gps.period_year=gbpr.period_year and
gps.application_id=101 and
gps.period_num=20 and
gps.period_num between gbpr.start_period_num and gbpr.end_period_num
) period20_name,
case when gbv.require_budget_journals_flag='Y' then
(select
sum(nvl(gbp.entered_dr,0) - nvl(gbp.entered_cr,0))
from
gl_bc_packets gbp
where
gbp.budget_version_id=gbve.budget_version_id and
gbp.ledger_id=gbe.ledger_id and
gbp.period_num=20 and
gbp.period_year=gbpr.period_year and
gbp.actual_flag='B' and
gbp.status_code='A' and
gbp.code_combination_id=gcck.code_combination_id)
else
(
select
sum(nvl(gb.period_net_dr,0) - nvl(gb.period_net_cr,0))
from
gl_balances gb
where
gb.budget_version_id=gbve.budget_version_id and
gb.ledger_id=gbe.ledger_id and
gb.period_num=20 and
gb.period_year=gbpr.period_year and
gb.actual_flag='B' and
gcck.code_combination_id=gb.code_combination_id
) 
end period20_amount
from
gl_budget_assignments_unique_v gbauv,
gl_budgets_v gbv,
gl_budget_entities gbe,
gl_entity_budgets geb,
gl_budget_versions gbve,
gl_ledgers_v glv,
gl_budget_period_ranges gbpr,
gl_code_combinations_kfv gcck
where
1=1 and
gbauv.entry_code='E' and
gbauv.code_combination_id=gcck.code_combination_id and
gbauv.ledger_id=glv.ledger_id and
glv.chart_of_accounts_id=gcck.chart_of_accounts_id and
gbe.budget_entity_id=gbauv.budget_entity_id and
gbv.budget_name=gbve.budget_name and
gbv.budget_name=gbve.budget_name and
glv.ledger_id=gbe.ledger_id and
geb.budget_version_id=gbve.budget_version_id and
gbe.budget_entity_id=geb.budget_entity_id and
gbpr.budget_version_id=gbv.budget_version_id and
gbpr.open_flag='O' and
gcck.enabled_flag='Y' and
gcck.summary_flag='N' and
gcck.detail_budgeting_allowed='Y' and
gcck.template_id is null and
sysdate between nvl(gcck.start_date_active,sysdate) and nvl(gcck.end_date_active,(sysdate+1))