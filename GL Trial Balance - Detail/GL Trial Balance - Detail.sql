/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Trial Balance - Detail
-- Description: Imported from Concurrent Program
Description: Detail Trial Balance (XML)
Application: General Ledger
Source: Trial Balance - Detail (XML)
Short Name: GLTRBALD
DB package:
-- Excel Examle Output: https://www.enginatics.com/example/gl-trial-balance-detail/
-- Library Link: https://www.enginatics.com/reports/gl-trial-balance-detail/
-- Run Report: https://demo.enginatics.com/

select
u.ledger_name,
u.currency_code,
&lp_pivot_segment_name pivot_segment,
&pivot_and_account_segment
u.concatenated_segments account,
u.begin_balance_dr,
u.begin_balance_cr,
u.begin_balance,
u.period_dr,
u.period_cr,
u.period_net,
u.end_balance_dr,
u.end_balance_cr,
u.end_balance,
&segment_columns2
xxen_util.meaning(u.gl_account_type,'ACCOUNT_TYPE',0) account_type
from
(
select
max(glr.target_ledger_name) ledger_name,
gb.currency_code,
max(gcck.gl_account_type) gl_account_type,
max(gcck.concatenated_segments) concatenated_segments,
&segment_columns
decode(:p_type,'PTD', sum(decode(:p_currency_type,'T', nvl(begin_balance_dr,0),'S', nvl(begin_balance_dr,0),'E',decode(gb.translated_flag,'R', nvl(begin_balance_dr,0), nvl(begin_balance_dr_beq,0)),'C', nvl(begin_balance_dr_beq,0))),'PJTD', decode(:p_currency_type,'T', 0,'S', 0,'E', 0,'C',0),'YTD', decode(:p_currency_type,'T', sum(decode(gb.period_name,:p_first_period_name,(nvl(begin_balance_dr,0)),0)),'S', sum(decode(gb.period_name,:p_first_period_name,(nvl(begin_balance_dr,0)),0)),'E', sum(decode(gb.translated_flag,'R', decode(gb.period_name,:p_first_period_name, nvl(begin_balance_dr,0),0), decode(gb.period_name,:p_first_period_name, nvl(begin_balance_dr_beq,0),0))),'C', sum(decode(gb.period_name,:p_first_period_name,nvl(begin_balance_dr_beq,0),0)))) begin_balance_dr,
decode(:p_type,'PTD', sum(decode(:p_currency_type,'T', nvl(begin_balance_cr,0),'S', nvl(begin_balance_cr,0),'E',decode(gb.translated_flag,'R', nvl(begin_balance_cr,0), nvl(begin_balance_cr_beq,0)),'C', nvl(begin_balance_cr_beq,0))),'PJTD', decode(:p_currency_type,'T', 0,'S', 0,'E', 0,'C',0),'YTD', decode(:p_currency_type,'T', sum(decode(gb.period_name,:p_first_period_name,(nvl(begin_balance_cr,0)),0)),'S', sum(decode(gb.period_name,:p_first_period_name,(nvl(begin_balance_cr,0)),0)),'E', sum(decode(gb.translated_flag,'R', decode(gb.period_name,:p_first_period_name, nvl(begin_balance_cr,0),0), decode(gb.period_name,:p_first_period_name, nvl(begin_balance_cr_beq,0),0))),'C', sum(decode(gb.period_name,:p_first_period_name,nvl(begin_balance_cr_beq,0),0)))) begin_balance_cr,
decode(:p_type,'PTD', sum(decode(:p_currency_type,'T', nvl(begin_balance_dr,0)-nvl(begin_balance_cr,0),'S',nvl(begin_balance_dr,0)-nvl(begin_balance_cr,0),'E',decode(gb.translated_flag,'R', nvl(begin_balance_dr,0)-nvl(begin_balance_cr,0), nvl(begin_balance_dr_beq,0)- nvl(begin_balance_cr_beq,0)),'C', nvl(begin_balance_dr_beq,0)- nvl(begin_balance_cr_beq,0))),'PJTD', decode(:p_currency_type,'T', 0,'S', 0,'E', 0,'C',0),'YTD', decode(:p_currency_type,'T',sum(decode(gb.period_name, :p_first_period_name,(nvl(begin_balance_dr,0) - nvl(begin_balance_cr,0)),0)),'S', sum(decode(gb.period_name, :p_first_period_name,(nvl(begin_balance_dr,0) - nvl(begin_balance_cr,0)),0)),'E', sum(decode(gb.translated_flag,'R', decode(gb.period_name, :p_first_period_name, nvl(begin_balance_dr,0) - nvl(begin_balance_cr,0),0), decode(gb.period_name, :p_first_period_name, nvl(begin_balance_dr_beq,0)- nvl(begin_balance_cr_beq,0),0))),'C', sum(decode(gb.period_name,:p_first_period_name,(nvl(begin_balance_dr_beq,0)- nvl(begin_balance_cr_beq,0)),0)))) begin_balance,
decode(:p_type,'PTD', sum(decode(:p_currency_type,'T', nvl(period_net_dr,0),'S', nvl(period_net_dr,0),'E', decode(gb.translated_flag,'R', nvl(period_net_dr,0),nvl(period_net_dr_beq,0)),'C', nvl(period_net_dr_beq,0))),'PJTD', sum(decode(:p_currency_type,'T', nvl(project_to_date_dr,0) + nvl(period_net_dr,0),'S', nvl(project_to_date_dr,0) + nvl(period_net_dr,0),'E', decode(gb.translated_flag,'R', nvl(project_to_date_dr,0) + nvl(period_net_dr,0), nvl(project_to_date_dr_beq,0) + nvl(period_net_dr_beq,0)),'C', nvl(project_to_date_dr_beq,0) + nvl(period_net_dr_beq,0))),'YTD', decode(:p_currency_type,'T',sum(decode(gb.period_name, :p_period_name, nvl(period_net_dr,0) + nvl(begin_balance_dr,0),0) - decode(gb.period_name, :p_first_period_name, nvl(begin_balance_dr,0),0)),'S', sum(decode(gb.period_name, :p_period_name, nvl(period_net_dr,0) + nvl(begin_balance_dr,0),0) -decode(gb.period_name, :p_first_period_name, nvl(begin_balance_dr,0),0)),'E', sum(decode(gb.translated_flag,'R', decode(gb.period_name, :p_period_name, nvl(period_net_dr,0)+ nvl(begin_balance_dr,0),0) -decode(gb.period_name, :p_first_period_name, nvl(begin_balance_dr,0),0), decode(gb.period_name, :p_period_name, nvl(period_net_dr_beq,0)+nvl(begin_balance_dr_beq,0),0) - decode(gb.period_name, :p_first_period_name,nvl(begin_balance_dr_beq,0),0))),'C', sum(decode(gb.period_name, :p_period_name, nvl(period_net_dr_beq,0) + nvl(begin_balance_dr_beq,0),0) - decode(gb.period_name, :p_first_period_name, nvl(begin_balance_dr_beq,0),0)))) period_dr,
decode(:p_type,'PTD', sum(decode(:p_currency_type,'T', nvl(period_net_cr,0),'S', nvl(period_net_cr,0),'E', decode(gb.translated_flag,'R', nvl(period_net_cr,0),nvl(period_net_cr_beq,0)),'C', nvl(period_net_cr_beq,0))),'PJTD', sum(decode(:p_currency_type,'T', nvl(project_to_date_cr,0) + nvl(period_net_cr,0),'S', nvl(project_to_date_cr,0) + nvl(period_net_cr,0),'E', decode(gb.translated_flag,'R', nvl(project_to_date_cr,0) + nvl(period_net_cr,0), nvl(project_to_date_cr_beq,0) + nvl(period_net_cr_beq,0)),'C', nvl(project_to_date_cr_beq,0) + nvl(period_net_cr_beq,0))),'YTD', decode(:p_currency_type,'T',sum(decode(gb.period_name, :p_period_name, nvl(period_net_cr,0) + nvl(begin_balance_cr,0),0) - decode(gb.period_name, :p_first_period_name, nvl(begin_balance_cr,0),0)),'S', sum(decode(gb.period_name, :p_period_name, nvl(period_net_cr,0) + nvl(begin_balance_cr,0),0) -decode(gb.period_name, :p_first_period_name, nvl(begin_balance_cr,0),0)),'E', sum(decode(gb.translated_flag,'R', decode(gb.period_name, :p_period_name, nvl(period_net_cr,0)+ nvl(begin_balance_cr,0),0) -decode(gb.period_name, :p_first_period_name, nvl(begin_balance_cr,0),0), decode(gb.period_name, :p_period_name, nvl(period_net_cr_beq,0)+nvl(begin_balance_cr_beq,0),0) - decode(gb.period_name, :p_first_period_name,nvl(begin_balance_cr_beq,0),0))),'C', sum(decode(gb.period_name, :p_period_name, nvl(period_net_cr_beq,0) + nvl(begin_balance_cr_beq,0),0) - decode(gb.period_name, :p_first_period_name, nvl(begin_balance_cr_beq,0),0)))) period_cr,
decode(:p_type,'PTD', sum(decode(:p_currency_type,'T', nvl(period_net_dr,0)-nvl(period_net_cr,0),'S', nvl(period_net_dr,0)- nvl(period_net_cr,0),'E', decode(gb.translated_flag,'R', nvl(period_net_dr,0)- nvl(period_net_cr,0), nvl(period_net_dr_beq,0)- nvl(period_net_cr_beq,0)),'C', nvl(period_net_dr_beq,0)- nvl(period_net_cr_beq,0))),'PJTD', sum(decode(:p_currency_type,'T', nvl(project_to_date_dr,0)+ nvl(period_net_dr,0) - nvl(project_to_date_cr,0)- nvl(period_net_cr,0),'S', nvl(project_to_date_dr,0)+ nvl(period_net_dr,0) - nvl(project_to_date_cr,0)- nvl(period_net_cr,0),'E', decode(gb.translated_flag,'R', nvl(project_to_date_dr,0)+ nvl(period_net_dr,0) - nvl(project_to_date_cr,0)- nvl(period_net_cr,0), nvl(project_to_date_dr_beq,0)+ nvl(period_net_dr_beq,0) - nvl(project_to_date_cr_beq,0)- nvl(period_net_cr_beq,0)),'C', nvl(project_to_date_dr_beq,0)+ nvl(period_net_dr_beq,0)- nvl(project_to_date_cr_beq,0) - nvl(period_net_cr_beq,0))),'YTD', decode(:p_currency_type,'T', sum( decode(gb.period_name,:p_period_name, nvl(period_net_dr,0)- nvl(period_net_cr,0)+ nvl(begin_balance_dr,0)- nvl(begin_balance_cr,0),0) - decode(gb.period_name,:p_first_period_name, nvl(begin_balance_dr,0)- nvl(begin_balance_cr,0),0)),'S', sum(decode(gb.period_name,:p_period_name, nvl(period_net_dr,0)-nvl(period_net_cr,0)+nvl(begin_balance_dr,0)-nvl(begin_balance_cr,0),0) - decode(gb.period_name,:p_first_period_name, nvl(begin_balance_dr,0)- nvl(begin_balance_cr,0),0)),'E', sum(decode(gb.translated_flag,'R', decode(gb.period_name,:p_period_name, nvl(period_net_dr,0) - nvl(period_net_cr,0)+ nvl(begin_balance_dr,0)- nvl(begin_balance_cr,0),0) - decode(gb.period_name,:p_first_period_name, nvl(begin_balance_dr,0)- nvl(begin_balance_cr,0),0), decode(gb.period_name,:p_period_name, nvl(period_net_dr_beq,0)- nvl(period_net_cr_beq,0) + nvl(begin_balance_dr_beq,0) - nvl(begin_balance_cr_beq,0),0) - decode(gb.period_name,:p_first_period_name, nvl(begin_balance_dr_beq,0)- nvl(begin_balance_cr_beq,0 ),0))),'C', sum( decode(gb.period_name,:p_period_name, nvl(period_net_dr_beq,0)- nvl(period_net_cr_beq,0)+ nvl(begin_balance_dr_beq,0) - nvl(begin_balance_cr_beq,0),0)- decode(gb.period_name,:p_first_period_name, nvl(begin_balance_dr_beq,0)-nvl(begin_balance_cr_beq,0),0)))) period_net,
decode(:p_type,'PTD', sum(decode(:p_currency_type,'T', nvl(begin_balance_dr,0)+ nvl(period_net_dr,0),'S', nvl(begin_balance_dr,0) + nvl(period_net_dr,0),'E',decode(gb.translated_flag,'R', nvl(begin_balance_dr,0)+ nvl(period_net_dr,0),nvl(begin_balance_dr_beq,0) + nvl(period_net_dr_beq,0)),'C', nvl(begin_balance_dr_beq,0) + nvl(period_net_dr_beq,0))),'PJTD', sum(decode(:p_currency_type,'T', nvl(project_to_date_dr,0) + nvl(period_net_dr,0),'S', nvl(project_to_date_dr,0) + nvl(period_net_dr,0),'E', decode(gb.translated_flag,'R', nvl(project_to_date_dr,0)+ nvl(period_net_dr,0) ,nvl(project_to_date_dr_beq,0) + nvl(period_net_dr_beq,0)),'C', nvl(project_to_date_dr_beq,0) + nvl(period_net_dr_beq,0))),'YTD', decode(:p_currency_type,'T',sum(decode(gb.period_name, :p_period_name, nvl(period_net_dr,0)+nvl(begin_balance_dr,0),0)),'S', sum(decode(gb.period_name, :p_period_name, nvl(period_net_dr,0)+ nvl(begin_balance_dr,0),0)),'E', sum(decode(gb.translated_flag,'R', decode(gb.period_name, :p_period_name, nvl(period_net_dr,0)+ nvl(begin_balance_dr,0),0),decode(gb.period_name, :p_period_name, nvl(period_net_dr_beq,0)+ nvl(begin_balance_dr_beq,0),0))),'C', sum(decode(gb.period_name, :p_period_name, nvl(period_net_dr_beq,0) + nvl(begin_balance_dr_beq,0),0)))) end_balance_dr,
decode(:p_type,'PTD', sum(decode(:p_currency_type,'T', nvl(begin_balance_cr,0)+ nvl(period_net_cr,0),'S', nvl(begin_balance_cr,0) + nvl(period_net_cr,0),'E',decode(gb.translated_flag,'R', nvl(begin_balance_cr,0)+ nvl(period_net_cr,0),nvl(begin_balance_cr_beq,0) + nvl(period_net_cr_beq,0)),'C', nvl(begin_balance_cr_beq,0) + nvl(period_net_cr_beq,0))),'PJTD', sum(decode(:p_currency_type,'T', nvl(project_to_date_cr,0) + nvl(period_net_cr,0),'S', nvl(project_to_date_cr,0) + nvl(period_net_cr,0),'E', decode(gb.translated_flag,'R', nvl(project_to_date_cr,0)+ nvl(period_net_cr,0) ,nvl(project_to_date_cr_beq,0) + nvl(period_net_cr_beq,0)),'C', nvl(project_to_date_cr_beq,0) + nvl(period_net_cr_beq,0))),'YTD', decode(:p_currency_type,'T',sum(decode(gb.period_name, :p_period_name, nvl(period_net_cr,0)+nvl(begin_balance_cr,0),0)),'S', sum(decode(gb.period_name, :p_period_name, nvl(period_net_cr,0)+ nvl(begin_balance_cr,0),0)),'E', sum(decode(gb.translated_flag,'R', decode(gb.period_name, :p_period_name, nvl(period_net_cr,0)+ nvl(begin_balance_cr,0),0),decode(gb.period_name, :p_period_name, nvl(period_net_cr_beq,0)+ nvl(begin_balance_cr_beq,0),0))),'C', sum(decode(gb.period_name, :p_period_name, nvl(period_net_cr_beq,0) + nvl(begin_balance_cr_beq,0),0)))) end_balance_cr,
decode(:p_type,'PTD', sum(decode(:p_currency_type,'T', nvl(begin_balance_dr,0)+ nvl(period_net_dr,0)- nvl(begin_balance_cr,0) - nvl(period_net_cr,0),'S', nvl(begin_balance_dr,0)+ nvl(period_net_dr,0) - nvl(begin_balance_cr,0) - nvl(period_net_cr,0),'E', decode(gb.translated_flag,'R', nvl(begin_balance_dr,0) + nvl(period_net_dr,0)- nvl(begin_balance_cr,0) - nvl(period_net_cr,0),nvl(begin_balance_dr_beq,0) + nvl(period_net_dr_beq,0)- nvl(begin_balance_cr_beq,0) - nvl(period_net_cr_beq,0) ),'C', nvl(begin_balance_dr_beq,0)+ nvl(period_net_dr_beq,0)- nvl(begin_balance_cr_beq,0) - nvl(period_net_cr_beq,0))),'PJTD', sum(decode(:p_currency_type,'T', nvl(project_to_date_dr,0)+ nvl(period_net_dr,0) - nvl(project_to_date_cr,0) - nvl(period_net_cr,0),'S', nvl(project_to_date_dr,0) + nvl(period_net_dr,0) - nvl(project_to_date_cr,0) - nvl(period_net_cr,0),'E', decode(gb.translated_flag,'R', nvl(project_to_date_dr,0) + nvl(period_net_dr,0)- nvl(project_to_date_cr,0) - nvl(period_net_cr,0), nvl(project_to_date_dr_beq,0) + nvl(period_net_dr_beq,0) - nvl(project_to_date_cr_beq,0) - nvl(period_net_cr_beq,0) ),'C', nvl(project_to_date_dr_beq,0) + nvl(period_net_dr_beq,0) - nvl(project_to_date_cr_beq,0) - nvl(period_net_cr_beq,0)) ),'YTD', decode(:p_currency_type,'T', sum(decode(gb.period_name, :p_period_name, nvl(period_net_dr,0 ) - nvl(period_net_cr,0) + nvl(begin_balance_dr,0) - nvl(begin_balance_cr,0),0)),'S', sum(decode(gb.period_name, :p_period_name, nvl(period_net_dr,0)- nvl(period_net_cr,0) + nvl(begin_balance_dr,0)- nvl(begin_balance_cr,0),0)),'E', sum(decode(gb.translated_flag,'R', decode(gb.period_name, :p_period_name, nvl(period_net_dr,0)- nvl(period_net_cr,0)+ nvl(begin_balance_dr,0) - nvl(begin_balance_cr, 0 ), 0 ), decode(gb.period_name, :p_period_name, nvl(period_net_dr_beq, 0 ) - nvl(period_net_cr_beq,0)+ nvl(begin_balance_dr_beq,0)- nvl(begin_balance_cr_beq,0),0) ) ),'C', sum(decode(gb.period_name,:p_period_name, nvl(period_net_dr_beq,0) - nvl(period_net_cr_beq,0) + nvl(begin_balance_dr_beq,0) - nvl(begin_balance_cr_beq,0),0)))) end_balance,
max(gcck.chart_of_accounts_id) chart_of_accounts_id,
gcck.code_combination_id
from
gl_ledgers gl,
gl_ledger_set_assignments glsa,
gl_ledger_relationships glr,
gl_balances gb,
gl_code_combinations_kfv gcck
where
1=1 and
gl.ledger_id=:p_ledger_id and
gl.ledger_id=glsa.ledger_set_id(+) and
glr.target_currency_code=:p_ledger_currency and
gl.ledger_id=glr.source_ledger_id and
glr.source_ledger_id=glr.target_ledger_id and
nvl(glsa.ledger_id,gl.ledger_id)=gb.ledger_id and
gb.code_combination_id=gcck.code_combination_id and
nvl(:p_entered_currency,'?')=nvl(:p_entered_currency,'?') and
gb.period_name in (:p_period_name, decode(:p_type,'PTD', :p_period_name,'PJTD', :p_period_name,'YTD', :p_first_period_name)) and
gb.actual_flag='A' and
gcck.chart_of_accounts_id=:p_chart_of_accounts_id and
gcck.summary_flag='N' and
gcck.template_id is null
group by
gb.ledger_id,
gb.currency_code,
gcck.code_combination_id
) u
where
nvl(u.begin_balance,0)!=0 or nvl(u.period_net,0)!=0 or nvl(u.end_balance,0)!=0
order by
u.ledger_name,
u.currency_code,
pivot_segment_value,
account_segment,
&segment_columns3
u.concatenated_segments