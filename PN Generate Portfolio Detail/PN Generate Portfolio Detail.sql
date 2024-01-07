/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PN Generate Portfolio Detail
-- Description: Application: Property Manager
Source: Generate Portfolio Detail Report
Short Name: PNGPDR_XML
DB package: XXEN_PN
-- Excel Examle Output: https://www.enginatics.com/example/pn-generate-portfolio-detail/
-- Library Link: https://www.enginatics.com/reports/pn-generate-portfolio-detail/
-- Run Report: https://demo.enginatics.com/

with
--
q_portfolio_detail as
(
select
 plrdg.intercompany_flag ico_flag,
 decode( plrdg.as_of_period, plrdg.lease_num, plrdg.as_of_period) lease_num,
 plrdg.lease_name lease_name,
 plrdg.lia_bal_start,
 plrdg.liability,
 plrdg.cash,
 plrdg.interest_accrual,
 plrdg.rou_bal_start_fin,
 plrdg.rou_asset_fin,
 plrdg.rou_amort_fin,
 plrdg.rou_bal_start_us_opr,
 plrdg.rou_asset_opr,
 plrdg.rou_amort_opr,
 plrdg.lease_expenses,
 plrdg.currency_code,
 plrdg.seq,
 plrdg.lia_bal_adj,
 plrdg.rou_adj_fin,
 plrdg.rou_adj_us_opr,
 decode(pla.payment_term_proration_rule,365,'365 Days/Year',360,'360 Days/Year',999,'Days/Month',null) payment_term_proration_rule,
 pla.accounting_method accounting_method,
 xxen_util.meaning(pla.accounting_method,'PN_ACCT_METHOD_TYPE',0) representation,
 xxen_util.meaning('PROPERTY','PN_ECC_LEASE_CATEGORY',240) lease_category
from
 pn_lease_reports_data_gtt plrdg,
 pn_leases_all pla
where
    plrdg.lease_num=pla.lease_num
and nvl(pla.accounting_method,'BOTH') = decode(nvl(:p_representation,'BOTH'),'BOTH',nvl(pla.accounting_method,'BOTH'),:p_representation)
and exists
  (select
    'X'
   from
    pn_lease_details_all plda
   where
    plda.lease_id = pla.lease_id
    and trunc(xxen_pn.get_as_of_date_start(pla.lease_id)) <= trunc(plda.lease_termination_date)
    and trunc(xxen_pn.get_as_of_date(pla.lease_id)) >= trunc(plda.lease_commencement_date) )
union
select
 plrdg.intercompany_flag ico_flag,
 decode( plrdg.as_of_period, plrdg.lease_num, plrdg.as_of_period) lease_num,
 plrdg.lease_name lease_name,
 plrdg.lia_bal_start,
 plrdg.liability,
 plrdg.cash,
 plrdg.interest_accrual,
 plrdg.rou_bal_start_fin,
 plrdg.rou_asset_fin,
 plrdg.rou_amort_fin,
 plrdg.rou_bal_start_us_opr,
 plrdg.rou_asset_opr,
 plrdg.rou_amort_opr,
 plrdg.lease_expenses,
 plrdg.currency_code,
 plrdg.seq,
 plrdg.lia_bal_adj,
 plrdg.rou_adj_fin,
 plrdg.rou_adj_us_opr,
 decode(pla.payment_term_proration_rule,365,'365 Days/Year',360,'360 Days/Year',999,'Days/Month',null) payment_term_proration_rule,
 pla.accounting_method accounting_method,
 xxen_util.meaning(pla.accounting_method,'PN_ACCT_METHOD_TYPE',0) representation,
 xxen_util.meaning('PROPERTY','PN_ECC_LEASE_CATEGORY',240) lease_category
from
 pn_lease_reports_data_gtt plrdg,
 pn_eqp_leases_all pla
where
    plrdg.lease_num=pla.lease_num
and nvl(pla.accounting_method,'BOTH') = decode(nvl(:p_representation,'BOTH'),'BOTH',nvl(pla.accounting_method,'BOTH'),:p_representation)
and exists
  (select
    'X'
   from
    pn_eqp_lease_details_all plda
   where
    plda.lease_id = pla.lease_id
    and trunc(xxen_pn.get_as_of_date_start(pla.lease_id)) <= trunc(plda.lease_termination_date)
    and trunc(xxen_pn.get_as_of_date(pla.lease_id)) >= trunc(plda.lease_commencement_date))
),
--
q_amendment_detail as
(
select
 case when parg.amendment_type like '%(InterCompany)%' then 'Y' else 'N' end ico_flag,
 parg.lease_num,
 parg.lease_name,
 parg.amendment_date amendment_date,
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
 parg.amendment_date amendment_date,
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
 x.report_as_of_period period,
 --
 x.record_type,
 xxen_util.meaning(x.ico_flag,'YES_NO',0) intercompany_flag,
 x.lease_num,
 x.lease_name,
 x.lease_category,
 x.representation,
 x.currency,
 -- portfolio_detail
 x.liability_start_balance,
 x.liability_close_balance,
 x.cash,
 x.interest_accrual,
 x.liability_adjustment,
 x.fin_rou_start_balance,
 x.fin_rou_closing_balance,
 x.fin_rou_amort_expense,
 x.fin_rou_adjustments,
 x.opr_rou_start_balance,
 x.opr_rou_close_balance,
 x.opr_rou_amort_expense,
 x.opr_rou_adjustments,
 x.lease_expense,
 -- Amendment Details
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
 decode(x.ico_flag,'Y','Intercompany','Non Intercompany') intercompany_label
from
(
select
 'Lease Balance' record_type,
 :p_legal_entity legal_entity,
 :p_ledger_name ledger,
 :p_org_name operating_unit,
 :p_functional_currency functional_currency,
 :p_as_of_period report_as_of_period,
 :p_end_date report_end_date,
 pn_lease_portfolio_reports.get_report_status(mo_global.get_current_org_id,:p_period_end_date) report_status,
 --
 qpd.lease_num,
 qpd.lease_name,
 qpd.lease_category,
 qpd.accounting_method,
 qpd.representation,
 qpd.currency_code         currency,
 -- portfolio_detail
 qpd.lia_bal_start         liability_start_balance,
 qpd.liability             liability_close_balance,
 qpd.cash                  cash,
 qpd.interest_accrual      interest_accrual,
 qpd.lia_bal_adj           liability_adjustment,
 qpd.rou_bal_start_fin     fin_rou_start_balance,
 qpd.rou_asset_fin         fin_rou_closing_balance,
 qpd.rou_amort_fin         fin_rou_amort_expense,
 qpd.rou_adj_fin           fin_rou_adjustments,
 qpd.rou_bal_start_us_opr  opr_rou_start_balance,
 qpd.rou_asset_opr         opr_rou_close_balance,
 qpd.rou_amort_opr         opr_rou_amort_expense,
 qpd.rou_adj_us_opr        opr_rou_adjustments,
 qpd.lease_expenses        lease_expense,
 -- Amendment Details
 to_date(null)             amendment_date,
 to_date(null)             effective_date,
 null                      amendment_type,
 to_number(null)           amount_per_period,
 to_number(null)           number_of_periods,
 to_number(null)           total_change_amount,
 qpd.ico_flag,
 1 rec_group,
 qpd.seq
from
 q_portfolio_detail qpd
where
 :p_incl_balances is not null
union
select
 'Lease Amendment' record_type,
 :p_legal_entity legal_entity,
 :p_ledger_name  ledger,
 :p_org_name operating_unit,
 :p_functional_currency functional_currency,
 :p_as_of_period report_as_of_period,
 :p_end_date report_end_date,
 pn_lease_portfolio_reports.get_report_status(mo_global.get_current_org_id,:p_period_end_date) report_status,
 --
 qad.lease_num,
 qad.lease_name,
 qad.lease_category,
 qad.accounting_method,
 qad.representation,
 qad.currency_code currency,
 -- portfolio_detail
 to_number(null)           liability_start_balance,
 to_number(null)           liability_close_balance,
 to_number(null)           cash,
 to_number(null)           interest_accrual,
 to_number(null)           liability_adjustment,
 to_number(null)           fin_rou_start_balance,
 to_number(null)           fin_rou_closing_balance,
 to_number(null)           fin_rou_amort_expense,
 to_number(null)           fin_rou_adjustments,
 to_number(null)           opr_rou_start_balance,
 to_number(null)           opr_rou_close_balance,
 to_number(null)           opr_rou_amort_expense,
 to_number(null)           opr_rou_adjustments,
 to_number(null)           lease_expense,
 -- Amendment Details
 qad.amendment_date,
 qad.effective_date,
 qad.amendment_type,
 qad.amt_diff_per_period   amount_per_period,
 qad.no_of_periods         number_of_periods,
 qad.tot_diff_amt          total_change_amount,
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
 decode(x.seq,4,2,1),
 x.lease_num,
 x.currency,
 x.seq