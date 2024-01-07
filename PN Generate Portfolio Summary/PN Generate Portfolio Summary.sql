/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PN Generate Portfolio Summary
-- Description: Application: Property Manager
Source: Generate Portfolio Summary Report
Short Name: PNGPSR_XML
DB package: XXEN_PN
-- Excel Examle Output: https://www.enginatics.com/example/pn-generate-portfolio-summary/
-- Library Link: https://www.enginatics.com/reports/pn-generate-portfolio-summary/
-- Run Report: https://demo.enginatics.com/

with
--
q_portfolio_summary as
(
select
 plrdg.intercompany_flag ico_flag,
 plrdg.as_of_period period,
 plrdg.liability,
 plrdg.cash,
 plrdg.interest_accrual,
 plrdg.rou_asset_fin,
 plrdg.rou_amort_fin,
 plrdg.rou_asset_opr,
 plrdg.rou_amort_opr,
 plrdg.lease_expenses,
 plrdg.currency_code,
 nvl(plrdg.period_start_date,to_date(plrdg.as_of_period,'Mon-YYYY')) period_start_date,
 plrdg.seq
from
 pn_lease_reports_data_gtt plrdg
),
--
q_amendment_detail as
(
select
 case when parg.amendment_type like '%(InterCompany)%' then 'Y' else 'N' end ico_flag,
 parg.lease_num,
 parg.lease_name,
 parg.amendment_date,
 parg.effective_date,
 parg.amendment_type,
 parg.amt_per_period amt_diff_per_period,
 parg.tot_period no_of_periods,
 parg.tot_amt tot_diff_amt,
 parg.currency_code,
 decode(pla.payment_term_proration_rule,365,'365 Days/Year',360,'360 Days/Year',999,'Days/Month',null) payment_term_proration_rule,
 pla.accounting_method accounting_method,
 xxen_util.meaning(pla.accounting_method,'PN_ACCT_METHOD_TYPE',0) representation,
 xxen_util.meaning('PROPERTY','PN_ECC_LEASE_CATEGORY',240) lease_category
from
 pn_amendment_report_gtt parg,
 pn_leases_all pla
where
    parg.lease_num=pla.lease_num
and nvl(pla.accounting_method,'BOTH') = decode(nvl(:p_representation,'BOTH'),'BOTH',nvl(pla.accounting_method,'BOTH'),:p_representation)
and exists
  (select
    'X'
   from
    pn_lease_details_all plda
   where
    plda.lease_id = pla.lease_id
    and trunc(xxen_pn.get_as_of_date_start(pla.lease_id)) <= trunc(plda.lease_termination_date)
    and trunc(xxen_pn.get_as_of_date(pla.lease_id)) >= trunc(plda.lease_commencement_date)
  )
union
select
 case when parg.amendment_type like '%(InterCompany)%' then 'Y' else 'N' end ico_flag,
 parg.lease_num,
 parg.lease_name,
 parg.amendment_date,
 parg.effective_date,
 parg.amendment_type,
 parg.amt_per_period amt_diff_per_period,
 parg.tot_period no_of_periods,
 parg.tot_amt tot_diff_amt,
 parg.currency_code,
 decode(pla.payment_term_proration_rule,365,'365 Days/Year',360,'360 Days/Year',999,'Days/Month',null) payment_term_proration_rule,
 pla.accounting_method accounting_method,
 xxen_util.meaning(pla.accounting_method,'PN_ACCT_METHOD_TYPE',0) representation,
 xxen_util.meaning('EQUIPMENT','PN_ECC_LEASE_CATEGORY',240) lease_category
from
 pn_amendment_report_gtt parg,
 pn_eqp_leases_all pla
where
    parg.lease_num=pla.lease_num
and nvl(pla.accounting_method,'BOTH') = decode(nvl(:p_representation,'BOTH'),'BOTH',nvl(pla.accounting_method,'BOTH'),:p_representation)
and exists
  (select
    'X'
   from
    pn_eqp_lease_details_all plda
   where
    plda.lease_id = pla.lease_id
    and trunc(xxen_pn.get_as_of_date_start(pla.lease_id)) <= trunc(plda.lease_termination_date)
    and trunc(xxen_pn.get_as_of_date(pla.lease_id)) >= trunc(plda.lease_commencement_date)
  )
)
--
--
-- =================================
-- Main Query Starts Here
-- =================================
--
select
 x.legal_entity,
 x.ledger,
 x.operating_unit,
 x.functional_currency,
 x.report_as_of_period,
 --
 x.record_type,
 xxen_util.meaning(x.ico_flag,'YES_NO',0) intercompany_flag,
 x.currency,
 -- portfolio_summary
 x.period,
 x.liability,
 x.cash,
 x.interest_accrual,
 x.fin_rou_asset,
 x.fin_rou_amort_expense,
 x.opr_rou_asset,
 x.opr_rou_amort_expense,
 x.lease_expense,
 -- Amendment Details
 x.lease_num,
 x.lease_name,
 x.lease_category,
 x.representation,
 trunc(x.amendment_date) amendment_date,
 trunc(x.effective_date) effective_date,
 x.amendment_type,
 x.amount_per_period,
 x.number_of_periods,
 x.total_change_amount,
 --
 x.report_status,
 nvl2(x.lease_name,x.lease_num || ' - ' || x.lease_name,null) lease_num_name_label,
 nvl2(lease_name,x.lease_name || ' (' || x.lease_num || ')',null) lease_name_num_label,
 decode(x.ico_flag,'Y','Intercompany','Non Intercompany') intercompany_label,
 x.period_start_date
from
(
select
 'Period Balance'         record_type,
 :p_legal_entity          legal_entity,
 :p_ledger_name           ledger,
 :p_org_name              operating_unit,
 :p_functional_currency   functional_currency,
 :p_as_of_period          report_as_of_period,
 :p_end_date              report_end_date,
 pn_lease_portfolio_reports.get_report_status(mo_global.get_current_org_id,:p_period_end_date) report_status,
 --
 qps.currency_code currency,
 -- portfolio_summary
 qps.period,
 qps.period_start_date,
 qps.liability,
 qps.cash,
 qps.interest_accrual,
 qps.rou_asset_fin        fin_rou_asset,
 qps.rou_amort_fin        fin_rou_amort_expense,
 qps.rou_asset_opr        opr_rou_asset,
 qps.rou_amort_opr        opr_rou_amort_expense,
 qps.lease_expenses       lease_expense,
 -- Amendment Details
 null                     lease_num,
 null                     lease_name,
 null                     lease_category,
 null                     representation,
 null                     accounting_method,
 to_date(null)            amendment_date,
 to_date(null)            effective_date,
 null                     amendment_type,
 to_number(null)          amount_per_period,
 to_number(null)          number_of_periods,
 to_number(null)          total_change_amount,
 --
 qps.ico_flag,
 1 rec_group,
 qps.seq
from
 q_portfolio_summary qps
where
 :p_incl_balances is not null
union
select
 'Lease Amendment'        record_type,
 :p_legal_entity          legal_entity,
 :p_ledger_name           ledger,
 :p_org_name              operating_unit,
 :p_functional_currency   functional_currency,
 :p_as_of_period          report_as_of_period,
 :p_end_date              report_end_date,
 pn_lease_portfolio_reports.get_report_status(mo_global.get_current_org_id,:p_period_end_date) report_status,
 --
 qad.currency_code        currency,
 -- portfolio_summary
 null                     period,
 to_date(null)            period_start_date,
 to_number(null)          liability,
 to_number(null)          cash,
 to_number(null)          interest_accrual,
 to_number(null)          fin_rou_asset,
 to_number(null)          fin_rou_amort_expense,
 to_number(null)          opr_rou_asset,
 to_number(null)          opr_rou_amort_expense,
 to_number(null)          lease_expense,
 -- Amendment Details
 qad.lease_num,
 qad.lease_name,
 qad.lease_category,
 qad.representation,
 qad.accounting_method,
 qad.amendment_date,
 qad.effective_date,
 qad.amendment_type,
 qad.amt_diff_per_period  amount_per_period,
 qad.no_of_periods        number_of_periods,
 qad.tot_diff_amt         total_change_amount,
 --
 qad.ico_flag,
 2 rec_group,
 to_number(null) seq
from
 q_amendment_detail qad
where
 :p_incl_amendments is not null
) x
order by
 x.ico_flag,
 x.rec_group,
 x.lease_num,
 x.period_start_date,
 x.currency,
 x.seq