/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PN Generate Lease Analysis
-- Description: Application: Property Manager
Source: Generate Lease Analysis Report
Short Name: PNLAR_XML
DB package: XXEN_PN
-- Excel Examle Output: https://www.enginatics.com/example/pn-generate-lease-analysis/
-- Library Link: https://www.enginatics.com/reports/pn-generate-lease-analysis/
-- Run Report: https://demo.enginatics.com/

with
q_lease_detail as
(
select --Q1
 pla.org_id,
 pla.lease_id lease_id,
 pla.lease_num,
 pla.name lease_name,
 plda.lease_commencement_date lease_commencement_date,
 plda.lease_termination_date lease_termination_date,
 months_between(plda.lease_termination_date + 1, plda.lease_commencement_date) duration_in_months,
 ((pn_streams_util.get_interest_rate(pla.discount_rate_index_id, trunc(xxen_pn.get_as_of_date(pla.lease_id))) * 100) + nvl(pla.adder_rate, 0)) discount_rate,
 ppta.currency_code currency,
 xxen_util.meaning('PROPERTY','PN_ECC_LEASE_CATEGORY',240) lease_category,
 decode(pla.payment_term_proration_rule,365,'365 Days/Year',360,'360 Days/Year',999,'Days/Month',null) payment_term_proration_rule,
 pla.accounting_method accounting_method,
 xxen_util.meaning(pla.accounting_method,'PN_ACCT_METHOD_TYPE',0) representation,
 xxen_pn.get_as_of_date(pla.lease_id) as_of_date
from
 pn_leases_all pla,
 pn_lease_details_all plda,
 pn_payment_terms_all ppta
where
    pla.lease_id = plda.lease_id
and pla.lease_id = ppta.lease_id
and nvl(pla.accounting_method,'BOTH') = decode(nvl(:p_representation,'BOTH'),'BOTH',nvl(pla.accounting_method,'BOTH'),:p_representation)
and pla.org_id = :p_org_id
and pla.lease_status = 'ACT'
and pla.status = 'F'
and pla.lease_class_code = 'DIRECT'
union
select --Q2
 pla.org_id,
 pla.lease_id lease_id,
 pla.lease_num,
 pla.name lease_name,
 plda.lease_commencement_date lease_commencement_date,
 plda.lease_termination_date lease_termination_date,
 months_between(plda.lease_termination_date + 1, plda.lease_commencement_date) duration_in_months,
 ((pn_streams_util.get_interest_rate(pla.discount_rate_index_id, trunc(xxen_pn.get_as_of_date(pla.lease_id))) * 100) + nvl(pla.adder_rate, 0)) discount_rate,
 nvl(poa.currency_code, pn_lease_pvt.get_functional_currency(pla.org_id)) currency_code,
 xxen_util.meaning('PROPERTY','PN_ECC_LEASE_CATEGORY',240) lease_category,
 decode(pla.payment_term_proration_rule,365,'365 Days/Year',360,'360 Days/Year',999,'Days/Month',null) payment_term_proration_rule,
 pla.accounting_method accounting_method,
 xxen_util.meaning(pla.accounting_method,'PN_ACCT_METHOD_TYPE',0) representation,
 xxen_pn.get_as_of_date(pla.lease_id) as_of_date
from
 pn_leases_all pla,
 pn_lease_details_all plda,
 pn_options_all poa
where
    pla.lease_id = plda.lease_id
and pla.lease_id = poa.lease_id
and nvl(pla.accounting_method,'BOTH') = decode(nvl(:p_representation,'BOTH'),'BOTH',nvl(pla.accounting_method,'BOTH'),:p_representation)
and pla.org_id = :p_org_id
and pla.lease_status = 'ACT'
and pla.status = 'F'
and pla.lease_class_code = 'DIRECT'
union
select --Q3
 pla.org_id,
 pla.lease_id lease_id,
 pla.lease_num,
 pla.name lease_name,
 plda.lease_commencement_date lease_commencement_date,
 plda.lease_termination_date lease_termination_date,
 months_between(plda.lease_termination_date + 1, plda.lease_commencement_date) duration_in_months,
 ((pn_streams_util.get_interest_rate(pla.discount_rate_index_id, trunc(xxen_pn.get_as_of_date(pla.lease_id))) * 100) + nvl(pla.adder_rate, 0)) discount_rate,
 ppta.currency_code currency,
 xxen_util.meaning('EQUIPMENT','PN_ECC_LEASE_CATEGORY',240) lease_category,
 decode(pla.payment_term_proration_rule,365,'365 Days/Year',360,'360 Days/Year',999,'Days/Month',null) payment_term_proration_rule,
 pla.accounting_method accounting_method,
 xxen_util.meaning(pla.accounting_method,'PN_ACCT_METHOD_TYPE',0) representation,
 xxen_pn.get_as_of_date(pla.lease_id) as_of_date
from
 pn_eqp_leases_all pla,
 pn_eqp_lease_details_all plda,
 pn_eqp_payment_terms_all ppta
where
    pla.lease_id = plda.lease_id
and pla.lease_id = ppta.lease_id
and nvl(pla.accounting_method,'BOTH') = decode(nvl(:p_representation,'BOTH'),'BOTH',nvl(pla.accounting_method,'BOTH'),:p_representation)
and pla.org_id = :p_org_id
and pla.lease_status = 'ACT'
and pla.status = 'F'
and pla.lease_class_code = 'DIRECT'
union
select --Q4
 pla.org_id,
 pla.lease_id lease_id,
 pla.lease_num,
 pla.name lease_name,
 plda.lease_commencement_date lease_commencement_date,
 plda.lease_termination_date lease_termination_date,
 months_between(plda.lease_termination_date + 1, plda.lease_commencement_date) duration_in_months,
 ((pn_streams_util.get_interest_rate(pla.discount_rate_index_id, trunc(xxen_pn.get_as_of_date(pla.lease_id))) * 100) + nvl(pla.adder_rate, 0)) discount_rate,
 poa.currency_code,
 xxen_util.meaning('EQUIPMENT','PN_ECC_LEASE_CATEGORY',240) lease_category,
 decode(pla.payment_term_proration_rule,365,'365 Days/Year',360,'360 Days/Year',999,'Days/Month',null) payment_term_proration_rule,
 pla.accounting_method accounting_method,
 xxen_util.meaning(pla.accounting_method,'PN_ACCT_METHOD_TYPE',0) representation,
 xxen_pn.get_as_of_date(pla.lease_id) as_of_date
from
 pn_eqp_leases_all pla,
 pn_eqp_lease_details_all plda,
 pn_eqp_options_all poa
where
     pla.lease_id = plda.lease_id
and pla.lease_id = poa.lease_id
and nvl(pla.accounting_method,'BOTH') = decode(nvl(:p_representation,'BOTH'),'BOTH',nvl(pla.accounting_method,'BOTH'),:p_representation)
and pla.org_id = :p_org_id
and pla.lease_status = 'ACT'
and pla.status = 'F'
and pla.lease_class_code = 'DIRECT'
)
--
-- Main Query Starts Here
--
select
 :p_legal_entity legal_entity,
 :p_ledger_name ledger,
 :p_org_name operating_unit,
 :p_functional_currency functional_currency,
 :p_as_of_period as_of_period,
 qld.as_of_date as_of_date,
 qld.lease_num,
 qld.lease_name,
 qld.lease_category,
 qld.lease_commencement_date commencement_date,
 qld.lease_termination_date termination_date,
 qld.duration_in_months,
 qld.payment_term_proration_rule days_convention,
 qld.discount_rate discount_rate_pct,
 qld.representation representation,
 qld.currency currency,
 --
 pn_transaction_util.get_lease_liability
 (p_lease_id => qld.lease_id,
  p_org_id => qld.org_id,
  p_currency => qld.currency,
  p_as_of_date => trunc(qld.as_of_date),
  p_termination_date => trunc(qld.lease_termination_date),
  p_month => 12,
  p_mode => 'U'
 ) undisc_liability_le_1yr,
 pn_transaction_util.get_lease_liability
 (p_lease_id => qld.lease_id,
  p_org_id => qld.org_id,
  p_currency => qld.currency,
  p_as_of_date => trunc(qld.as_of_date),
  p_termination_date => trunc(qld.lease_termination_date),
  p_month => 60,
  p_mode => 'U'
 ) undisc_liability_le_5yr,
 pn_transaction_util.get_liability_more
 (p_lease_id => qld.lease_id,
  p_org_id => qld.org_id,
  p_currency => qld.currency,
  p_as_of_date => trunc(qld.as_of_date),
  p_termination_date => trunc(qld.lease_termination_date),
  p_month => 60,
  p_mode => 'U'
 ) undisc_liability_gt_5yr,
 pn_transaction_util.get_lease_liability
 (p_lease_id => qld.lease_id,
  p_org_id => qld.org_id,
  p_currency => qld.currency,
  p_as_of_date => trunc(qld.as_of_date),
  p_termination_date => trunc(qld.lease_termination_date),
  p_month => 12,
  p_mode => 'D'
 ) disc_liability_le_1yr,
 pn_transaction_util.get_lease_liability
 (p_lease_id => qld.lease_id,
  p_org_id => qld.org_id,
  p_currency => qld.currency,
  p_as_of_date => trunc(qld.as_of_date),
  p_termination_date => trunc(qld.lease_termination_date),
  p_month => 60,
  p_mode => 'D'
 ) disc_liability_le_5yr,
 pn_transaction_util.get_liability_more
 (p_lease_id => qld.lease_id,
  p_org_id => qld.org_id,
  p_currency => qld.currency,
  p_as_of_date => trunc(qld.as_of_date),
  p_termination_date => trunc(qld.lease_termination_date),
  p_month => 60,
  p_mode => 'D'
 ) disc_liability_gt_5yr,
 qld.accounting_method,
 :p_source source,
 qld.lease_num || ' - ' || qld.lease_name lease_num_name_label, 
 qld.lease_name || ' (' || qld.lease_num || ')' lease_name_num_label
from
 q_lease_detail qld
where
 1=1 and
 :p_org_name = :p_org_name and
 qld.lease_category = nvl(:p_lease_category,qld.lease_category)
order by
 qld.lease_num