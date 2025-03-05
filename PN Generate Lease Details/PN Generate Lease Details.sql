/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PN Generate Lease Details
-- Description: Application: Property Manager
Source: Generate Lease Details Report
Short Name: PNGLDR_XML
DB package: XXEN_PN
-- Excel Examle Output: https://www.enginatics.com/example/pn-generate-lease-details/
-- Library Link: https://www.enginatics.com/reports/pn-generate-lease-details/
-- Run Report: https://demo.enginatics.com/

with
--
--q_lease -- Lease Header
--
q_lease as
(
select distinct
 pla.lease_id,
 pla.lease_num lease_num,
 pla.name lease_name,
 xxen_pn.get_lease_rate_value(pla.lease_id) rate_value,
 xxen_pn.get_lease_discount_rate(pla.lease_id,xxen_pn.get_as_of_date(pla.lease_id)) lease_discount_rate,
 xxen_pn.pngldr_report_status(pla.lease_id,xxen_pn.get_as_of_date(pla.lease_id)) report_status,
 xxen_util.meaning('PROPERTY','PN_ECC_LEASE_CATEGORY',240) lease_category
from
 pn_leases_all pla
where
    1=1
and pla.org_id = :p_org_id
and pla.status = 'F'
and pla.lease_status in ('ACT','TER')
and pla.lease_class_code = 'DIRECT'
and 'PROPERTY' = nvl(xxen_util.lookup_code(:p_lease_category,'PN_ECC_LEASE_CATEGORY',240),'PROPERTY')
union
select distinct
 pla.lease_id,
 pla.lease_num lease_num,
 pla.name lease_name,
 xxen_pn.get_lease_rate_value(pla.lease_id) rate_value,
 xxen_pn.get_lease_discount_rate(pla.lease_id,xxen_pn.get_as_of_date(pla.lease_id)) lease_discount_rate,
 xxen_pn.pngldr_report_status(pla.lease_id,xxen_pn.get_as_of_date(pla.lease_id)) report_status,
 xxen_util.meaning('EQUIPMENT','PN_ECC_LEASE_CATEGORY',240) lease_category
from
 pn_eqp_leases_all pla
where
    1=1
and pla.org_id = :p_org_id
and pla.status = 'F'
and pla.lease_status in ('ACT','TER')
and pla.lease_class_code = 'DIRECT'
and 'EQUIPMENT' = nvl(xxen_util.lookup_code(:p_lease_category,'PN_ECC_LEASE_CATEGORY',240),'EQUIPMENT')
),
--
--q_lease_detail -- Lease Details
--
q_lease_detail as
(
select --Q1
 pla.lease_id lease_id,
 pla.lease_num,
 pla.name lease_name,
 plda.lease_commencement_date lease_commencement_date,
 plda.lease_termination_date lease_termination_date,
 months_between(plda.lease_termination_date + 1, plda.lease_commencement_date) duration_in_months,
 decode(pla.payment_term_proration_rule,365,'365 Days/Year',360,'360 Days/Year',999,'Days/Month',null) payment_term_proration_rule,
 pla.accounting_method accounting_method,
 xxen_util.meaning(pla.accounting_method,'PN_ACCT_METHOD_TYPE',0) lease_representation,
 decode(xxen_pn.get_lease_data_source,'P','Production data','A','Archive') lease_source
from
 pn_leases_all pla,
 pn_lease_details_all plda
where
    pla.lease_id = plda.lease_id
and xxen_pn.get_lease_data_source = 'P'
and (nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(pla.lease_id))) >= trunc(xxen_pn.get_as_of_date(pla.lease_id)) or pn_system_pub.get_frozen_flag (:p_org_id) = 'N')
and trunc(xxen_pn.get_as_of_date(pla.lease_id)) >= trunc(plda.lease_commencement_date)
union
select --Q2
 pla.lease_id lease_id,
 pla.lease_num,
 pla.name lease_name,
 plda.lease_commencement_date lease_commencement_date,
 plda.lease_termination_date lease_termination_date,
 months_between(plda.lease_termination_date + 1, plda.lease_commencement_date) duration_in_months,
 decode(pla.payment_term_proration_rule,365,'365 Days/Year',360,'360 Days/Year',999,'Days/Month',null) payment_term_proration_rule,
 pla.accounting_method accounting_method,
 xxen_util.meaning(pla.accounting_method,'PN_ACCT_METHOD_TYPE',0) lease_representation,
 decode(xxen_pn.get_lease_data_source,'P','Production data','A','Archive') lease_source
from
 pn_leases_all pla,
 pn_lease_details_all plda
where
    pla.lease_id = plda.lease_id
and xxen_pn.get_lease_data_source = 'A'
and exists (select 1 from pn_pmt_item_pv_all pivh where pivh.lease_id=pla.lease_id and pivh.as_of_date = xxen_pn.get_as_of_date(pla.lease_id))
and exists
  (select 1 from pn_payment_terms_all pt where pt.lease_id=pla.lease_id and pt.rept_inception_flag = 'Y'
   union all
   select 1 from pn_options_all po where po.lease_id=pla.lease_id and po.rept_inception_flag='Y'
  )
and (   nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(pla.lease_id))) >= trunc(xxen_pn.get_as_of_date(pla.lease_id))
     or pn_system_pub.get_frozen_flag (:p_org_id) = 'N'
    )
and trunc(xxen_pn.get_as_of_date(pla.lease_id)) >= trunc(plda.lease_commencement_date)
union
select --Q3
 pla.lease_id lease_id,
 pla.lease_num,
 pla.name lease_name,
 plda.lease_commencement_date lease_commencement_date,
 plda.lease_termination_date lease_termination_date,
 months_between(plda.lease_termination_date + 1, plda.lease_commencement_date) duration_in_months,
 decode(pla.payment_term_proration_rule,365,'365 Days/Year',360,'360 Days/Year',999,'Days/Month',null) payment_term_proration_rule,
 pla.accounting_method accounting_method,
 xxen_util.meaning(pla.accounting_method,'PN_ACCT_METHOD_TYPE',0) lease_representation,
 decode(xxen_pn.get_lease_data_source,'P','Production data','A','Archive') lease_source
from
 pn_leases_hist pla,
 pn_lease_details_hist plda
where
    pla.lease_id = plda.lease_id
and xxen_pn.get_lease_data_source = 'A'
and not exists (select 1 from pn_pmt_item_pv_all pivh where pivh.lease_id=pla.lease_id and pivh.as_of_date = xxen_pn.get_as_of_date(pla.lease_id))
and trunc(pla.as_of_date) = trunc((select max(as_of_date) from pn_leases_hist plhh where plhh.lease_num=pla.lease_num and trunc(plhh.as_of_date) <= trunc(xxen_pn.get_as_of_date(pla.lease_id))))
and trunc(plda.as_of_date) = trunc((select max(as_of_date) from pn_leases_hist plhh where plhh.lease_num=pla.lease_num and trunc(plhh.as_of_date) <= trunc(xxen_pn.get_as_of_date(pla.lease_id))))
and exists
  (select 1 from  pn_payment_terms_all pt where pt.lease_id=pla.lease_id and pt.rept_inception_flag = 'Y'
   union all
   select 1 from pn_options_all po where po.lease_id=pla.lease_id and po.rept_inception_flag='Y'
  )
and (nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(pla.lease_id))) >= trunc(xxen_pn.get_as_of_date(pla.lease_id)) or pn_system_pub.get_frozen_flag (:p_org_id) = 'N' )
and trunc(xxen_pn.get_as_of_date(pla.lease_id)) >= trunc(plda.lease_commencement_date)
union
select --Q4
 pla.lease_id lease_id,
 pla.lease_num,
 pla.name lease_name,
 plda.lease_commencement_date lease_commencement_date,
 plda.lease_termination_date lease_termination_date,
 months_between(plda.lease_termination_date + 1, plda.lease_commencement_date) duration_in_months,
 decode(pla.payment_term_proration_rule,365,'365 Days/Year',360,'360 Days/Year',999,'Days/Month',null) payment_term_proration_rule,
 pla.accounting_method accounting_method,
 xxen_util.meaning(pla.accounting_method,'PN_ACCT_METHOD_TYPE',0) lease_representation,
 decode(xxen_pn.get_lease_data_source,'P','Production data','A','Archive') lease_source
from
 pn_leases_hist pla,
 pn_lease_details_hist plda
where
    pla.lease_id = plda.lease_id
and xxen_pn.get_lease_data_source = 'A'
and trunc(pla.as_of_date) = trunc((select max(as_of_date) from pn_leases_hist plhh where plhh.lease_num=pla.lease_num and trunc(plhh.as_of_date) <= trunc(xxen_pn.get_as_of_date(pla.lease_id))))
and trunc(plda.as_of_date) = trunc((select max(as_of_date) from pn_leases_hist plhh where plhh.lease_num=pla.lease_num and trunc(plhh.as_of_date) <= trunc(xxen_pn.get_as_of_date(pla.lease_id))))
and exists (select 1 from pn_leases_hist plh where plh.lease_num=pla.lease_num)
and not exists
  (select 1 from pn_payment_terms_all pt where pt.lease_id=pla.lease_id and pt.rept_inception_flag = 'Y'
   union all
   select 1 from pn_options_all po where po.lease_id=pla.lease_id and po.rept_inception_flag='Y'
  )
and (nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(pla.lease_id))) >= trunc(xxen_pn.get_as_of_date(pla.lease_id)) or pn_system_pub.get_frozen_flag (:p_org_id) = 'N')
and trunc(xxen_pn.get_as_of_date(pla.lease_id)) >= trunc(plda.lease_commencement_date)
union
select --Q5
 pla.lease_id lease_id,
 pla.lease_num,
 pla.name lease_name,
 plda.lease_commencement_date lease_commencement_date,
 plda.lease_termination_date lease_termination_date,
 months_between(plda.lease_termination_date + 1, plda.lease_commencement_date) duration_in_months,
 decode(pla.payment_term_proration_rule,365,'365 Days/Year',360,'360 Days/Year',999,'Days/Month',null) payment_term_proration_rule,
 pla.accounting_method accounting_method,
 xxen_util.meaning(pla.accounting_method,'PN_ACCT_METHOD_TYPE',0) lease_representation,
 decode(xxen_pn.get_lease_data_source,'P','Production data','A','Archive') lease_source
from
 pn_leases_all pla,
 pn_lease_details_all plda
where
    pla.lease_id = plda.lease_id
and xxen_pn.get_lease_data_source = 'A'
and not exists (select 1 from pn_leases_hist plh where plh.lease_num=pla.lease_num)
and not exists
  (select 1 from pn_payment_terms_all pt where pt.lease_id=pla.lease_id and pt.rept_inception_flag = 'Y'
   union all
   select 1 from pn_options_all po where po.lease_id=pla.lease_id and po.rept_inception_flag='Y'
  )
and (nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(pla.lease_id))) >= trunc(xxen_pn.get_as_of_date(pla.lease_id)) or pn_system_pub.get_frozen_flag (:p_org_id) = 'N')
and trunc(xxen_pn.get_as_of_date(pla.lease_id)) >= trunc(plda.lease_commencement_date)
union --Q6
select
 lease_id,
 lease_num,
 lease_name,
 lease_commencement_date lease_commencement_date,
 lease_termination_date lease_termination_date,
 months_between(lease_termination_date + 1, lease_commencement_date) duration_in_months,
 payment_term_proration_rule,
 accounting_method,
 lease_representation,
 lease_source
from
 (select
   pla.lease_id lease_id,
   pla.lease_num,
   pla.name lease_name,
   plda.lease_commencement_date lease_commencement_date,
   nvl(pn_transaction_util.get_change_date(pla.lease_id, trunc(xxen_pn.get_as_of_date(pla.lease_id)), 'TERMINATION'),plda.lease_termination_date) lease_termination_date,
   decode(pla.payment_term_proration_rule,365,'365 Days/Year',360,'360 Days/Year',999,'Days/Month',null) payment_term_proration_rule,
   xxen_util.meaning(pla.accounting_method,'PN_ACCT_METHOD_TYPE',0) lease_representation,
   pla.accounting_method accounting_method,
   'Production data' lease_source
  from
   pn_leases_all pla,
   pn_lease_details_all plda
  where
      pla.lease_id = plda.lease_id
  and nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(pla.lease_id))) < trunc(xxen_pn.get_as_of_date(pla.lease_id))
  and pn_system_pub.get_frozen_flag (:p_org_id) = 'Y'
  and trunc(xxen_pn.get_as_of_date(pla.lease_id)) >= trunc(plda.lease_commencement_date)
 )
union --Q7
select
 lease_id,
 lease_num,
 lease_name,
 lease_commencement_date lease_commencement_date,
 lease_termination_date lease_termination_date,
 months_between(lease_termination_date + 1, lease_commencement_date) duration_in_months,
 payment_term_proration_rule,
 accounting_method,
 lease_representation,
 lease_source
from
 (select
   pla.lease_id lease_id,
   pla.lease_num,
   pla.name lease_name,
   nvl(pn_transaction_util.get_change_date(pla.lease_id, trunc(xxen_pn.get_as_of_date(pla.lease_id)), 'COMMENCEMENT'),plda.lease_commencement_date) lease_commencement_date,
   nvl(pn_transaction_util.get_change_date(pla.lease_id, trunc(xxen_pn.get_as_of_date(pla.lease_id)), 'TERMINATION'),plda.lease_termination_date) lease_termination_date,
   decode(pla.payment_term_proration_rule,365,'365 Days/Year',360,'360 Days/Year',999,'Days/Month',null) payment_term_proration_rule,
   xxen_util.meaning(pla.accounting_method,'PN_ACCT_METHOD_TYPE',0) lease_representation,
   pla.accounting_method accounting_method,
   'Production data' lease_source
  from
   pn_eqp_leases_all pla,
   pn_eqp_lease_details_all plda
  where
      pla.lease_id = plda.lease_id
  and trunc(xxen_pn.get_as_of_date(pla.lease_id)) >= trunc(plda.lease_commencement_date)
 )
),
--
-- q_lease_report -- Lease Reporting
--
q_lease_report as
(
select
 nvl(period,'Future Periods (Not Defined in GL)') period,
 period_start_date,
 currency,
 liability,
 cash,
 interest_accrual,
 rou_asset_fin,
 rou_amort_fin,
 rou_asset_opr,
 rou_amort_opr,
 lease_expenses,
 lease_id
from
 (select
   period_name period,
   period_start_date,
   currency_code currency,
   sum(nvl(lia_bal_end,0)) liability,
   sum(nvl(actual_pmt_amt,0)) cash,
   sum(nvl(lia_intrst_amt,0)) interest_accrual,
   sum(nvl(rou_bal_end_fin,0)) rou_asset_fin,
   sum(nvl(rou_amrtztn_amt_fin,0)) rou_amort_fin,
   decode(xxen_pn.get_lease_accounting_method(smry.lease_id),'FINANCE',to_number(null),sum(nvl(rou_bal_end_us_opr,0)) ) rou_asset_opr,
   decode(xxen_pn.get_lease_accounting_method(smry.lease_id),'FINANCE',to_number(null),sum(nvl(rou_amrtztn_amt_us_opr,0)) ) rou_amort_opr,
   decode(xxen_pn.get_lease_accounting_method(smry.lease_id),'FINANCE',to_number(null),sum(nvl(exp_amt,0)) ) lease_expenses,
   lease_id
  from
   (select
     piaa.option_id,
     piaa.payment_term_id,
     piaa.org_id,
     piaa.lease_id,
     piaa.as_of_date,
     piaa.period_date,
     decode((select calc_frequency from pn_system_setup_options where org_id =:p_org_id),
            null, to_char(to_date(to_char(trunc(period_date),'YYYY-MM-DD'),'YYYY-MM-DD'),'Mon-YYYY'),
            'PERIODICAL',to_char(to_date(to_char(trunc(period_date),'YYYY-MM-DD'),'YYYY-MM-DD' ),'Mon-YYYY'),
            (select
              glp.period_name
             from
              gl_periods glp,
              gl_sets_of_books glsob,
              pn_system_setup_options imp
             where
              glsob.period_set_name = glp.period_set_name
              and glp.period_type = glsob.accounted_period_type
              and glp.adjustment_period_flag <> 'Y'
              and glsob.set_of_books_id = imp.set_of_books_id
              and trunc(piaa.period_date) between trunc(glp.start_date) and trunc(glp.end_date)
              and imp.org_id =:p_org_id
            )
           ) period_name,
     decode((select calc_frequency from pn_system_setup_options where org_id =:p_org_id),
            null,trunc(last_day(period_date)),
            'PERIODICAL',trunc(last_day(period_date)),
            (select
              trunc(glp.start_date)
             from
              gl_periods glp,
              gl_sets_of_books glsob,
              pn_system_setup_options imp
             where
              glsob.period_set_name = glp.period_set_name
              and glp.period_type = glsob.accounted_period_type
              and glp.adjustment_period_flag <> 'Y'
              and glsob.set_of_books_id = imp.set_of_books_id
              and trunc(piaa.period_date) between trunc(glp.start_date) and trunc(glp.end_date)
              and imp.org_id =:p_org_id
             )
            ) period_start_date,
     piaa.lia_bal_end,
     piaa.currency_code,
     nvl((select sum(decode(nvl(pipa.actual_amount_rou,0),0,nvl(pipa.actual_amount_liability,0),nvl(pipa.actual_amount_rou,0)) )
          from pn_pmt_item_pv_all pipa
          where
              trunc(pipa.as_of_date) = trunc(xxen_pn.get_as_of_date(piaa.lease_id))
          and pipa.lease_id = piaa.lease_id
          and trunc(piaa.period_date) between add_months( (last_day(pipa.due_date) + 1),-1) and last_day(pipa.due_date )
          and (   (piaa.payment_term_id is not null and pipa.payment_term_id = piaa.payment_term_id)
               or (piaa.option_id is not null and pipa.option_id = piaa.option_id)
              )
         ),0) actual_pmt_amt,
     piaa.lia_intrst_amt,
     piaa.rou_bal_end_fin,
     piaa.rou_amrtztn_amt_fin,
     piaa.rou_bal_end_us_opr,
     piaa.rou_amrtztn_amt_us_opr,
     decode(pn_transaction_util.get_liab_only_flag(piaa.payment_term_id,piaa.option_id),'Y',piaa.lia_intrst_amt,piaa.exp_amt) exp_amt
    from
     pn_pmt_item_amrtzn_all piaa
    where
        trunc(piaa.as_of_date) = trunc(xxen_pn.get_as_of_date(piaa.lease_id))
    and (   nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(piaa.lease_id)) ) >= trunc (xxen_pn.get_as_of_date(piaa.lease_id))
         or pn_system_pub.get_frozen_flag(:p_org_id) = 'N'
        )
    union
    select
     piah.option_id,
     piah.payment_term_id,
     piah.org_id,
     piah.lease_id,
     piah.as_of_date,
     piah.period_date,
     decode((select calc_frequency from pn_system_setup_options where org_id =:p_org_id),
            null,to_char(to_date(to_char(trunc(piah.period_date),'YYYY-MM-DD'),'YYYY-MM-DD'),'Mon-YYYY'),
            'PERIODICAL',to_char(to_date(to_char(trunc(piah.period_date),'YYYY-MM-DD'),'YYYY-MM-DD' ),'Mon-YYYY'),
            (select
              glp.period_name
             from
              gl_periods glp,
              gl_sets_of_books glsob,
              pn_system_setup_options imp
             where
                 glsob.period_set_name = glp.period_set_name
             and glp.period_type = glsob.accounted_period_type
             and glp.adjustment_period_flag <> 'Y'
             and glsob.set_of_books_id = imp.set_of_books_id
             and trunc(piah.period_date) between trunc(glp.start_date) and trunc(glp.end_date)
             and imp.org_id =:p_org_id
            )
           ) period_name,
     decode((select calc_frequency from pn_system_setup_options where org_id =:p_org_id),
            null,trunc(last_day(piah.period_date)),
            'PERIODICAL',trunc(last_day(piah.period_date)),
            (select
              trunc(glp.start_date)
             from
              gl_periods glp,
              gl_sets_of_books glsob,
              pn_system_setup_options imp
             where
                 glsob.period_set_name = glp.period_set_name
             and glp.period_type = glsob.accounted_period_type
             and glp.adjustment_period_flag <> 'Y'
             and glsob.set_of_books_id = imp.set_of_books_id
             and trunc(piah.period_date) between trunc(glp.start_date) and trunc(glp.end_date)
             and imp.org_id =:p_org_id
            )
           ) period_start_date,
     piah.lia_bal_end,
     piah.currency_code,
     nvl((select sum(decode(nvl(pipa.actual_amount_rou,0),0,nvl(pipa.actual_amount_liability,0),nvl(pipa.actual_amount_rou,0)) )
          from pn_pmt_item_pv_hist pipa
          where
              trunc(pipa.as_of_date) = trunc(xxen_pn.get_as_of_date(piah.lease_id))
          and pipa.lease_id =piah.lease_id
          and trunc(piah.period_date) between add_months( (last_day(pipa.due_date) + 1),-1) and last_day(pipa.due_date )
          and (   (piah.payment_term_id is not null and pipa.payment_term_id = piah.payment_term_id)
               or (piah.option_id is not null and pipa.option_id = piah.option_id)
              )
         ),0) actual_pmt_amt,
     piah.lia_intrst_amt,
     piah.rou_bal_end_fin,
     piah.rou_amrtztn_amt_fin,
     piah.rou_bal_end_us_opr,
     piah.rou_amrtztn_amt_us_opr,
     decode(pn_transaction_util.get_liab_only_flag(piah.payment_term_id,piah.option_id),'Y',piah.lia_intrst_amt,piah.exp_amt) exp_amt
    from
     pn_pmt_item_amrtzn_hist piah
    where
        trunc(piah.as_of_date) = trunc(xxen_pn.get_as_of_date(piah.lease_id))
    and (   nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(piah.lease_id)) ) >= trunc (xxen_pn.get_as_of_date(piah.lease_id))
         or pn_system_pub.get_frozen_flag(:p_org_id) = 'N'
        )
    union
    select
     hist.option_id,
     hist.payment_term_id,
     hist.org_id,
     hist.lease_id,
     trunc(xxen_pn.get_as_of_date(hist.lease_id)),
     hist.period_date,
     decode((select calc_frequency from  pn_system_setup_options where org_id =:p_org_id ),
            null,to_char(to_date(to_char(trunc(hist.period_date),'YYYY-MM-DD'),'YYYY-MM-DD'),'Mon-YYYY'),
            'PERIODICAL',to_char(to_date(to_char(trunc(hist.period_date),'YYYY-MM-DD'),'YYYY-MM-DD' ),'Mon-YYYY'),
            (select
              glp.period_name
             from
              gl_periods glp,
              gl_sets_of_books glsob,
              pn_system_setup_options imp
             where
                 glsob.period_set_name = glp.period_set_name
             and glp.period_type = glsob.accounted_period_type
             and glp.adjustment_period_flag <> 'Y'
             and glsob.set_of_books_id = imp.set_of_books_id
             and trunc(hist.period_date) between trunc(glp.start_date) and trunc(glp.end_date)
             and imp.org_id =:p_org_id
            )
           ) period_name,
     decode((select calc_frequency from pn_system_setup_options where org_id =:p_org_id ),
            null,trunc(last_day(hist.period_date)),
            'PERIODICAL',trunc(last_day(hist.period_date)),
            (select
              trunc(glp.start_date)
             from
              gl_periods glp,
              gl_sets_of_books glsob,
              pn_system_setup_options imp
             where
                 glsob.period_set_name = glp.period_set_name
             and glp.period_type = glsob.accounted_period_type
             and glp.adjustment_period_flag <> 'Y'
             and glsob.set_of_books_id = imp.set_of_books_id
             and trunc(hist.period_date) between trunc(glp.start_date) and trunc(glp.end_date)
             and imp.org_id =:p_org_id
            )
           ) period_start_date,
     hist.lia_bal_end,
     hist.currency_code,
     nvl((select sum(decode(nvl(pipa.actual_amount_rou,0),0,nvl(pipa.actual_amount_liability,0),nvl(pipa.actual_amount_rou,0)) )
          from pn_pmt_item_pv_hist pipa
          where
              trunc(pipa.as_of_date) = trunc(hist.as_of_date)
          and pipa.lease_id = hist.lease_id
          and trunc(hist.period_date) between add_months( (last_day(pipa.due_date) + 1),-1) and last_day(pipa.due_date )
          and (   (hist.payment_term_id is not null and pipa.payment_term_id = hist.payment_term_id)
               or (hist.option_id is not null and pipa.option_id = hist.option_id)
              )
         ),0) actual_pmt_amt,
     hist.lia_intrst_amt,
     hist.rou_bal_end_fin,
     hist.rou_amrtztn_amt_fin,
     hist.rou_bal_end_us_opr,
     hist.rou_amrtztn_amt_us_opr,
     decode(pn_transaction_util.get_liab_only_flag(hist.payment_term_id,hist.option_id),'Y',hist.lia_intrst_amt,hist.exp_amt) exp_amt
    from
     (select
       amrthist.*,
       dense_rank() over( partition by lease_id order by as_of_date desc ) rnk
      from
       pn_pmt_item_amrtzn_hist amrthist
     ) hist
    where
        rnk = 1
    and not exists (select 1 from pn_pmt_item_amrtzn_hist where lease_id =hist.lease_id and trunc(as_of_date) = trunc(xxen_pn.get_as_of_date(hist.lease_id)) )
    and not exists (select 1 from pn_pmt_item_amrtzn_all where lease_id =hist.lease_id and trunc(as_of_date) = trunc(xxen_pn.get_as_of_date(hist.lease_id)) )
    and (   nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(hist.lease_id)) ) >= trunc (xxen_pn.get_as_of_date(hist.lease_id))
         or (pn_system_pub.get_frozen_flag(:p_org_id) = 'N' and pn_transaction_util.get_transition_date(:p_org_id) is null)
        )
   ) smry
  where
      trunc(smry.period_date) <= decode(:p_to_date,null,trunc(smry.period_date),:p_to_date )
  and trunc(smry.period_date) >= decode(xxen_pn.get_as_of_date(smry.lease_id),null,trunc(smry.period_date),xxen_pn.get_as_of_date(smry.lease_id))
  and trunc(smry.as_of_date) = trunc(xxen_pn.get_as_of_date(smry.lease_id))
  and upper(xxen_pn.get_lease_accounting_method(smry.lease_id)) != 'EXCLUDED'
  and (   smry.option_id is null
       or (   smry.option_id is not null
           and (   exists (select 1
                           from pn_options_all poa
                           where
                               xxen_pn.get_lease_data_source = 'P'
                           and poa.option_id = smry.option_id
                           and poa.option_status_lookup_code in ( 'NOTEXERCISED', 'OPEN' )
                          )
                or exists (select 1
                           from pn_options_hist poh
                           where
                               xxen_pn.get_lease_data_source = 'A'
                           and poh.option_id = smry.option_id
                           and poh.option_status_lookup_code in ( 'NOTEXERCISED', 'OPEN' )
                           and not exists (select 1
                                           from  pn_payment_terms_all pt
                                           where pt.lease_id =smry.lease_id
                                           and   pt.rept_inception_flag = 'Y'
                                           union all
                                           select 1
                                           from  pn_options_all po
                                           where po.lease_id =smry.lease_id
                                           and po.rept_inception_flag = 'Y'
                                          )
                           and trunc(as_of_date) = trunc((select max(as_of_date) from pn_leases_hist plhh where plhh.lease_id = smry.lease_id and trunc(plhh.as_of_date) <= trunc(xxen_pn.get_as_of_date(smry.lease_id))))
                           and exists (select 1 from pn_leases_hist plh where plh.lease_id = smry.lease_id )
                          )
                or exists (select 1
                           from pn_options_all pohl
                           where
                               xxen_pn.get_lease_data_source = 'A'
                           and pohl.option_id = smry.option_id
                           and pohl.option_status_lookup_code in ( 'NOTEXERCISED', 'OPEN' )
                           and not exists (select 1
                                           from  pn_payment_terms_all pt
                                           where pt.lease_id =smry.lease_id
                                           and   pt.rept_inception_flag = 'Y'
                                           union all
                                           select 1
                                           from  pn_options_all po
                                           where po.lease_id =smry.lease_id
                                           and po.rept_inception_flag = 'Y'
                                          )
                           and not exists (select 1
                                           from  pn_leases_hist plh
                                           where plh.lease_id = smry.lease_id
                                          )
                          )
                or exists (select 1
                           from pn_options_all poal
                           where
                               xxen_pn.get_lease_data_source = 'A'
                           and poal.option_id = smry.option_id
                           and poal.option_status_lookup_code in ( 'NOTEXERCISED', 'OPEN' )
                           and exists (select 1
                                       from  pn_payment_terms_all pt
                                       where pt.lease_id =smry.lease_id
                                       and pt.rept_inception_flag = 'Y'
                                       union all
                                       select 1
                                       from  pn_options_all po
                                       where po.lease_id =smry.lease_id
                                       and po.rept_inception_flag = 'Y'
                                      )
                          )
               )
          )
      )
  and ( nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(smry.lease_id)) ) >= trunc(xxen_pn.get_as_of_date(smry.lease_id)) or pn_system_pub.get_frozen_flag(:p_org_id) = 'N' )
  group by
   period_name,
   period_start_date,
   currency_code,
   lease_id
  union
  select
   period_name period,
   period_start_date,
   currency_code,
   sum(nvl(lib_ifrs_amount,0)) liability,
   sum(nvl(cash_ifrs_amount,0)) cash,
   sum(nvl(interest_ifrs_amount,0)) interest_accrual,
   sum(nvl(rou_ifrs_amount,0)) rou_asset_fin,
   sum(nvl(amor_ifrs_amount,0)) rou_amort_fin,
   decode(xxen_pn.get_lease_accounting_method(a.lease_id),'FINANCE',to_number(null),sum(nvl(rou_gaap_amount,0)) ) rou_asset_opr,
   decode(xxen_pn.get_lease_accounting_method(a.lease_id),'FINANCE',to_number(null),sum(nvl(amor_gaap_amount,0)) ) rou_amort_opr,
   decode(xxen_pn.get_lease_accounting_method(a.lease_id),'FINANCE',to_number(null),sum(nvl(expense_gaap_amount,0)) ) lease_expenses,
   lease_id
  from
   (select
     t.lease_id,
     t.payment_term_id,
     t.option_id,
     t.stream_version,
     t.stream_date,
     decode((select calc_frequency from pn_system_setup_options where org_id =:p_org_id ),
            null,to_char(to_date(to_char(trunc(t.stream_date),'YYYY-MM-DD'),'YYYY-MM-DD'),'Mon-YYYY'),
            'PERIODICAL',to_char(to_date(to_char(trunc(t.stream_date),'YYYY-MM-DD'),'YYYY-MM-DD' ),'Mon-YYYY'),
            (select
              glp.period_name
             from
              gl_periods glp,
              gl_sets_of_books glsob,
              pn_system_setup_options imp
             where
                 glsob.period_set_name = glp.period_set_name
             and glp.period_type = glsob.accounted_period_type
             and glp.adjustment_period_flag <> 'Y'
             and glsob.set_of_books_id = imp.set_of_books_id
             and trunc(t.stream_date) between trunc(glp.start_date) and trunc(glp.end_date)
             and imp.org_id =:p_org_id
            )
           ) period_name,
     decode((select calc_frequency from pn_system_setup_options where org_id =:p_org_id),
            null,trunc(last_day(t.stream_date)),
            'PERIODICAL',trunc(last_day(t.stream_date)),
            (select
              trunc(glp.start_date)
             from
              gl_periods glp,
              gl_sets_of_books glsob,
              pn_system_setup_options imp
             where
                 glsob.period_set_name = glp.period_set_name
             and glp.period_type = glsob.accounted_period_type
             and glp.adjustment_period_flag <> 'Y'
             and glsob.set_of_books_id = imp.set_of_books_id
             and trunc(t.stream_date) between trunc(glp.start_date) and trunc(glp.end_date)
             and imp.org_id =:p_org_id
            )
           ) period_start_date,
     t.as_of_date,
     t.rou_ifrs_amount,
     t.rou_gaap_amount,
     t.cash_ifrs_amount,
     t.cash_gaap_amount,
     t.lib_ifrs_amount,
     t.lib_gaap_amount,
     t.interest_ifrs_amount,
     t.interest_gaap_amount,
     t.amor_ifrs_amount,
     t.amor_gaap_amount,
     decode(pn_transaction_util.get_liab_only_flag(t.payment_term_id,t.option_id),'Y',t.interest_ifrs_amount,t.expense_gaap_amount) expense_gaap_amount,
     max(to_number(t.stream_version)) over( partition by t.payment_term_id,t.option_id ) max_stream_version,
     t.currency_code
    from
     pn_pmt_item_amrtzn_stream_v t,
     pn_leases_all pl
    where
        pl.lease_id = t.lease_id
    and nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(pl.lease_id)) ) < trunc (xxen_pn.get_as_of_date(pl.lease_id))
    and t.as_of_date <= trunc(xxen_pn.get_as_of_date(pl.lease_id))
   ) a
  where
      a.as_of_date <= trunc(xxen_pn.get_as_of_date(a.lease_id))
  and a.stream_version = a.max_stream_version
  and nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(a.lease_id)) ) < trunc(xxen_pn.get_as_of_date(a.lease_id))
  and pn_system_pub.get_frozen_flag (:p_org_id) = 'Y'
  and trunc(a.stream_date) <= decode(:p_to_date,null,trunc(a.stream_date),:p_to_date )
  group by
   period_name,
   period_start_date,
   currency_code,
   lease_id
  union
  select
   period_name period,
   period_start_date,
   currency_code,
   sum(nvl(lib_ifrs_amount,0)) liability,
   sum(nvl(cash_ifrs_amount,0)) cash,
   sum(nvl(interest_ifrs_amount,0)) interest_accrual,
   sum(nvl(rou_ifrs_amount,0)) rou_asset_fin,
   sum(nvl(amor_ifrs_amount,0)) rou_amort_fin,
   decode(xxen_pn.get_lease_accounting_method(a.lease_id),'FINANCE',to_number(null),sum(nvl(rou_gaap_amount,0)) ) rou_asset_opr,
   decode(xxen_pn.get_lease_accounting_method(a.lease_id),'FINANCE',to_number(null),sum(nvl(amor_gaap_amount,0)) ) rou_amort_opr,
   decode(xxen_pn.get_lease_accounting_method(a.lease_id),'FINANCE',to_number(null),sum(nvl(expense_gaap_amount,0)) ) lease_expenses,
   lease_id
  from
   (select
     t.lease_id,
     t.payment_term_id,
     t.option_id,
     t.stream_version,
     t.stream_date,
     decode((select calc_frequency from pn_eqp_system_setup_options where org_id =:p_org_id),
            null,to_char(to_date(to_char(trunc(t.stream_date),'YYYY-MM-DD'),'YYYY-MM-DD'),'Mon-YYYY'),
            'PERIODICAL',to_char(to_date(to_char(trunc(t.stream_date),'YYYY-MM-DD'),'YYYY-MM-DD' ),'Mon-YYYY'),
            (select
              glp.period_name
             from
              gl_periods glp,
              gl_sets_of_books glsob,
              pn_eqp_system_setup_options imp
             where
              glsob.period_set_name = glp.period_set_name
              and glp.period_type = glsob.accounted_period_type
              and glp.adjustment_period_flag <> 'Y'
              and glsob.set_of_books_id = imp.set_of_books_id
              and trunc(t.stream_date) between trunc(glp.start_date) and trunc(glp.end_date)
              and imp.org_id =:p_org_id
            )
           ) period_name,
     decode((select calc_frequency from pn_system_setup_options where org_id =:p_org_id),
            null,trunc(last_day(t.stream_date)),
            'PERIODICAL',trunc(last_day(t.stream_date)),
            (select
              trunc(glp.start_date)
             from
              gl_periods glp,
              gl_sets_of_books glsob,
              pn_eqp_system_setup_options imp
             where
              glsob.period_set_name = glp.period_set_name
              and glp.period_type = glsob.accounted_period_type
              and glp.adjustment_period_flag <> 'Y'
              and glsob.set_of_books_id = imp.set_of_books_id
              and trunc(t.stream_date) between trunc(glp.start_date) and trunc(glp.end_date)
              and imp.org_id =:p_org_id
             )
            ) period_start_date,
     t.as_of_date,
     t.rou_ifrs_amount,
     t.rou_gaap_amount,
     t.cash_ifrs_amount,
     t.cash_gaap_amount,
     t.lib_ifrs_amount,
     t.lib_gaap_amount,
     t.interest_ifrs_amount,
     t.interest_gaap_amount,
     t.amor_ifrs_amount,
     t.amor_gaap_amount,
     decode(pn_transaction_util.get_liab_only_flag(t.payment_term_id,t.option_id),'Y',t.interest_ifrs_amount,t.expense_gaap_amount) expense_gaap_amount,
     max(to_number(t.stream_version)) over( partition by t.payment_term_id,t.option_id ) max_stream_version,
     t.currency_code
    from
     pn_pmt_item_amrtzn_stream_v t,
     pn_eqp_leases_all pel
    where
        pel.lease_id = t.lease_id
    and t.as_of_date <= trunc(xxen_pn.get_as_of_date(pel.lease_id))
   ) a
  where
      a.as_of_date <= trunc(xxen_pn.get_as_of_date(a.lease_id))
  and a.stream_version = a.max_stream_version
  and trunc(a.stream_date) <= decode(:p_to_date,null,trunc(a.stream_date),:p_to_date )
  group by
   period_name,
   period_start_date,
   currency_code,
   lease_id
 )
),
--
--q_payment_terms -- Lease Payment Terms
--
q_payment_terms as
(
select
 lease_id,
 payment_term_id,
 currency_code payment_currency,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_PURPOSE_TYPE' and lookup_code = payment_purpose_code) payment_purpose,
 actual_amount,
 start_date,
 end_date,
 decode(xxen_pn.get_pay_term_proration_rule(pta.lease_id),
   '365 Days/Year', ceil(months_between(last_day(end_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + round((decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/365*12-1) + decode(to_char(end_date,'DD'),to_char(last_day(end_date),'DD'),0,to_number(to_char(end_date,'DD'))/365*12-1)),1),
   '360 Days/Year', ceil(months_between(last_day(end_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/360*12-1) + decode(to_char(end_date,'DD'),to_char(last_day(end_date),'DD'),0,to_number(to_char(end_date,'DD'))/360*12-1),
   'Days/Month', ceil(months_between(last_day(end_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/to_number(to_char(last_day(start_date),'DD'))-1) + decode(to_char(end_date,'DD'),to_char(last_day(end_date),'DD'),0, to_number(to_char(end_date,'DD'))/to_number(to_char(last_day(end_date),'DD'))-1)
   ) duration,
 decode(liability_flag, 'Y', 'Yes', 'No') liability_flag,
 decode(rou_asset_flag, 'Y', 'Yes', 'No') rou_asset_flag,
 decode(rept_inception_flag, 'Y', 'Yes', 'No') rept_inception_flag,
 schedule_day,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_FREQUENCY_TYPE' and lookup_code = frequency_code) payment_frequency,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_TERM_TYPE' and lookup_code = payment_term_type_code) payment_type,
 xxen_pn.get_lease_rate_value(pta.lease_id) term_rate_value,
 xxen_pn.get_lease_accounting_method(pta.lease_id) term_accounting_method,
 xxen_pn.get_pay_term_initial_rate(pta.lease_id,pta.payment_term_id,xxen_pn.get_as_of_date(pta.lease_id)) term_initial_rate,
 xxen_pn.get_pay_term_discount_rate(pta.lease_id,pta.payment_term_id,xxen_pn.get_as_of_date(pta.lease_id)) term_discount_rate,
 ' ' asset_number
from
 pn_payment_terms_all pta
where
    xxen_pn.get_lease_data_source = 'P'
and (   nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(pta.lease_id))) >= trunc(xxen_pn.get_as_of_date(pta.lease_id))
     or pn_system_pub.get_frozen_flag (:p_org_id) = 'N'
    )
and (   (    (pta.index_period_id is not null or pta.var_rent_inv_id is not null or pta.period_billrec_id is not null or pta.opex_agr_id is not null)
         and pta.status = 'APPROVED'
        )
     or (pta.index_period_id is null and pta.var_rent_inv_id is null and pta.period_billrec_id is null and pta.opex_agr_id is null)
     or (pta.opex_agr_id is not null and pta.status is null
        )
    )
union
select
 lease_id,
 payment_term_id,
 currency_code payment_currency,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_PURPOSE_TYPE' and lookup_code = payment_purpose_code) payment_purpose,
 actual_amount,
 start_date,
 end_date,
 decode(xxen_pn.get_pay_term_proration_rule(ppth.lease_id),
   '365 Days/Year', ceil(months_between(last_day(end_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + round((decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/365*12-1) + decode(to_char(end_date,'DD'),to_char(last_day(end_date),'DD'),0,to_number(to_char(end_date,'DD'))/365*12-1)),1),
   '360 Days/Year', ceil(months_between(last_day(end_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/360*12-1) + decode(to_char(end_date,'DD'),to_char(last_day(end_date),'DD'),0,to_number(to_char(end_date,'DD'))/360*12-1),
   'Days/Month', ceil(months_between(last_day(end_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/to_number(to_char(last_day(start_date),'DD'))-1) + decode(to_char(end_date,'DD'),to_char(last_day(end_date),'DD'),0, to_number(to_char(end_date,'DD'))/to_number(to_char(last_day(end_date),'DD'))-1)
   ) duration,
 decode(liability_flag, 'Y', 'Yes', 'No') liability_flag,
 decode(rou_asset_flag, 'Y', 'Yes', 'No') rou_asset_flag,
 decode(rept_inception_flag, 'Y', 'Yes', 'No') rept_inception_flag,
 schedule_day,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_FREQUENCY_TYPE' and lookup_code = frequency_code) payment_frequency,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_TERM_TYPE' and lookup_code = payment_term_type_code) payment_type,
 xxen_pn.get_lease_rate_value(ppth.lease_id) term_rate_value,
 xxen_pn.get_lease_accounting_method(ppth.lease_id) term_accounting_method,
 xxen_pn.get_pay_term_initial_rate(ppth.lease_id,ppth.payment_term_id,xxen_pn.get_as_of_date(ppth.lease_id)) term_initial_rate,
 xxen_pn.get_pay_term_discount_rate(ppth.lease_id,ppth.payment_term_id,xxen_pn.get_as_of_date(ppth.lease_id)) term_discount_rate,
 ' ' asset_number
from
 pn_payment_terms_hist ppth
where
    xxen_pn.get_lease_data_source = 'A'
and (   (    (index_period_id is not null or var_rent_inv_id is not null or period_billrec_id is not null or opex_agr_id is not null)
         and status = 'APPROVED'
        )
     or (index_period_id is null and var_rent_inv_id is null and period_billrec_id is null and opex_agr_id is null)
     or (opex_agr_id is not null and status is null)
    )
and trunc(as_of_date) = trunc((select max(as_of_date) from pn_leases_hist plhh where plhh.lease_id=ppth.lease_id and trunc(plhh.as_of_date) <= trunc(xxen_pn.get_as_of_date(ppth.lease_id))))
and exists (select 1 from pn_leases_hist plh where plh.lease_id=ppth.lease_id)
and not exists (select 1 from pn_payment_terms_all pt where pt.lease_id=ppth.lease_id and pt.rept_inception_flag = 'Y'
                union all
                select 1 from pn_options_all po where po.lease_id=ppth.lease_id and po.rept_inception_flag='Y'
               )
and (   nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(ppth.lease_id))) >= trunc(xxen_pn.get_as_of_date(ppth.lease_id))
     or pn_system_pub.get_frozen_flag (:p_org_id) = 'N'
    )
union
select
 lease_id,
 payment_term_id,
 currency_code payment_currency,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_PURPOSE_TYPE' and lookup_code = payment_purpose_code) payment_purpose,
 actual_amount,
 start_date,
 end_date,
 decode(xxen_pn.get_pay_term_proration_rule(ppta.lease_id),
   '365 Days/Year', ceil(months_between(last_day(end_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + round((decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/365*12-1) + decode(to_char(end_date,'DD'),to_char(last_day(end_date),'DD'),0,to_number(to_char(end_date,'DD'))/365*12-1)),1),
   '360 Days/Year', ceil(months_between(last_day(end_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/360*12-1) + decode(to_char(end_date,'DD'),to_char(last_day(end_date),'DD'),0,to_number(to_char(end_date,'DD'))/360*12-1),
   'Days/Month', ceil(months_between(last_day(end_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/to_number(to_char(last_day(start_date),'DD'))-1) + decode(to_char(end_date,'DD'),to_char(last_day(end_date),'DD'),0, to_number(to_char(end_date,'DD'))/to_number(to_char(last_day(end_date),'DD'))-1)
   ) duration,
 decode(liability_flag, 'Y', 'Yes', 'No') liability_flag,
 decode(rou_asset_flag, 'Y', 'Yes', 'No') rou_asset_flag,
 decode(rept_inception_flag, 'Y', 'Yes', 'No') rept_inception_flag,
 schedule_day,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_FREQUENCY_TYPE' and lookup_code = frequency_code) payment_frequency,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_TERM_TYPE' and lookup_code = payment_term_type_code) payment_type,
 xxen_pn.get_lease_rate_value(ppta.lease_id) term_rate_value,
 xxen_pn.get_lease_accounting_method(ppta.lease_id) term_accounting_method,
 xxen_pn.get_pay_term_initial_rate(ppta.lease_id,ppta.payment_term_id,xxen_pn.get_as_of_date(ppta.lease_id)) term_initial_rate,
 xxen_pn.get_pay_term_discount_rate(ppta.lease_id,ppta.payment_term_id,xxen_pn.get_as_of_date(ppta.lease_id)) term_discount_rate,
 ' ' asset_number
from
 pn_payment_terms_all ppta
where
    xxen_pn.get_lease_data_source = 'A'
and (   (    (index_period_id is not null or var_rent_inv_id is not null or period_billrec_id is not null or opex_agr_id is not null)
         and status = 'APPROVED'
        )
     or (index_period_id is null and var_rent_inv_id is null and period_billrec_id is null and opex_agr_id is null)
     or (opex_agr_id is not null and status is null)
    )
and not exists (select 1 from pn_leases_hist plh where plh.lease_id=ppta.lease_id)
and not exists (select 1 from pn_payment_terms_all pt where pt.lease_id=ppta.lease_id and pt.rept_inception_flag = 'Y'
                union all
                select 1 from pn_options_all po where po.lease_id=ppta.lease_id and po.rept_inception_flag='Y'
               )
and (   nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(ppta.lease_id))) >= trunc(xxen_pn.get_as_of_date(ppta.lease_id))
     or pn_system_pub.get_frozen_flag (:p_org_id) = 'N'
    )
union
select
 lease_id,
 payment_term_id,
 currency_code payment_currency,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_PURPOSE_TYPE' and lookup_code = payment_purpose_code) payment_purpose,
 actual_amount,
 start_date,
 end_date,
 decode(xxen_pn.get_pay_term_proration_rule(pta.lease_id),
   '365 Days/Year', ceil(months_between(last_day(end_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + round((decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/365*12-1) + decode(to_char(end_date,'DD'),to_char(last_day(end_date),'DD'),0,to_number(to_char(end_date,'DD'))/365*12-1)),1),
   '360 Days/Year', ceil(months_between(last_day(end_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/360*12-1) + decode(to_char(end_date,'DD'),to_char(last_day(end_date),'DD'),0,to_number(to_char(end_date,'DD'))/360*12-1),
   'Days/Month', ceil(months_between(last_day(end_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/to_number(to_char(last_day(start_date),'DD'))-1) + decode(to_char(end_date,'DD'),to_char(last_day(end_date),'DD'),0, to_number(to_char(end_date,'DD'))/to_number(to_char(last_day(end_date),'DD'))-1)
   ) duration,
 decode(liability_flag, 'Y', 'Yes', 'No') liability_flag,
 decode(rou_asset_flag, 'Y', 'Yes', 'No') rou_asset_flag,
 decode(rept_inception_flag, 'Y', 'Yes', 'No') rept_inception_flag,
 schedule_day,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_FREQUENCY_TYPE' and lookup_code = frequency_code) payment_frequency,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_TERM_TYPE' and lookup_code = payment_term_type_code) payment_type,
 xxen_pn.get_lease_rate_value(pta.lease_id) term_rate_value,
 xxen_pn.get_lease_accounting_method(pta.lease_id) term_accounting_method,
 xxen_pn.get_pay_term_initial_rate(pta.lease_id,pta.payment_term_id,xxen_pn.get_as_of_date(pta.lease_id)) term_initial_rate,
 xxen_pn.get_pay_term_discount_rate(pta.lease_id,pta.payment_term_id,xxen_pn.get_as_of_date(pta.lease_id)) term_discount_rate,
 ' ' asset_number
from
 pn_payment_terms_all pta
where
    xxen_pn.get_lease_data_source = 'A'
and (   (    (pta.index_period_id is not null or pta.var_rent_inv_id is not null or pta.period_billrec_id is not null or pta.opex_agr_id is not null)
         and pta.status = 'APPROVED'
        )
     or (pta.index_period_id is null and pta.var_rent_inv_id is null and pta.period_billrec_id is null and pta.opex_agr_id is null)
     or (pta.opex_agr_id is not null and pta.status is null)
   )
and exists (select 1 from pn_pmt_item_pv_all pivh where pivh.lease_id=pta.lease_id and pivh.as_of_date = xxen_pn.get_as_of_date(pta.lease_id))
and exists (select 1 from pn_payment_terms_all pt where pt.lease_id=pta.lease_id and pt.rept_inception_flag = 'Y'
            union all
            select 1 from pn_options_all po where po.lease_id=pta.lease_id and po.rept_inception_flag='Y'
           )
and (   nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(pta.lease_id))) >= trunc(xxen_pn.get_as_of_date(pta.lease_id))
     or pn_system_pub.get_frozen_flag (:p_org_id) = 'N'
    )
union
select
 lease_id,
 payment_term_id,
 currency_code payment_currency,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_PURPOSE_TYPE' and lookup_code = payment_purpose_code) payment_purpose,
 actual_amount,
 start_date,
 end_date,
 decode(xxen_pn.get_pay_term_proration_rule(pta.lease_id),
   '365 Days/Year', ceil(months_between(last_day(end_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + round((decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/365*12-1) + decode(to_char(end_date,'DD'),to_char(last_day(end_date),'DD'),0,to_number(to_char(end_date,'DD'))/365*12-1)),1),
   '360 Days/Year', ceil(months_between(last_day(end_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/360*12-1) + decode(to_char(end_date,'DD'),to_char(last_day(end_date),'DD'),0,to_number(to_char(end_date,'DD'))/360*12-1),
   'Days/Month', ceil(months_between(last_day(end_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/to_number(to_char(last_day(start_date),'DD'))-1) + decode(to_char(end_date,'DD'),to_char(last_day(end_date),'DD'),0, to_number(to_char(end_date,'DD'))/to_number(to_char(last_day(end_date),'DD'))-1)
   ) duration,
 decode(liability_flag, 'Y', 'Yes', 'No') liability_flag,
 decode(rou_asset_flag, 'Y', 'Yes', 'No') rou_asset_flag,
 decode(rept_inception_flag, 'Y', 'Yes', 'No') rept_inception_flag,
 schedule_day,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_FREQUENCY_TYPE' and lookup_code = frequency_code) payment_frequency,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_TERM_TYPE' and lookup_code = payment_term_type_code) payment_type,
 xxen_pn.get_lease_rate_value(pta.lease_id) term_rate_value,
 xxen_pn.get_lease_accounting_method(pta.lease_id) term_accounting_method,
 xxen_pn.get_pay_term_initial_rate(pta.lease_id,pta.payment_term_id,xxen_pn.get_as_of_date(pta.lease_id)) term_initial_rate,
 xxen_pn.get_pay_term_discount_rate(pta.lease_id,pta.payment_term_id,xxen_pn.get_as_of_date(pta.lease_id)) term_discount_rate,
 ' ' asset_number
from
 pn_payment_terms_hist pta
where
    xxen_pn.get_lease_data_source = 'A'
and (   (    (pta.index_period_id is not null or pta.var_rent_inv_id is not null or pta.period_billrec_id is not null or pta.opex_agr_id is not null)
         and pta.status = 'APPROVED'
        )
     or (pta.index_period_id is null and pta.var_rent_inv_id is null and pta.period_billrec_id is null and pta.opex_agr_id is null)
     or (pta.opex_agr_id is not null and pta.status is null)
    )
and not exists (select 1 from pn_pmt_item_pv_all pivh where pivh.lease_id=pta.lease_id and pivh.as_of_date = xxen_pn.get_as_of_date(pta.lease_id))
and trunc(as_of_date) = trunc((select max(as_of_date) from pn_leases_hist plhh where plhh.lease_id=pta.lease_id and trunc(plhh.as_of_date) <= trunc(xxen_pn.get_as_of_date(pta.lease_id))))
and exists (select 1 from pn_payment_terms_all pt where pt.lease_id=pta.lease_id and pt.rept_inception_flag = 'Y'
            union all
            select 1 from pn_options_all po where po.lease_id=pta.lease_id and po.rept_inception_flag='Y'
           )
and (   nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(pta.lease_id))) >= trunc(xxen_pn.get_as_of_date(pta.lease_id))
     or pn_system_pub.get_frozen_flag (:p_org_id) = 'N'
    )
union
select
 pta.lease_id,
 pta.payment_term_id,
 currency_code payment_currency,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_PURPOSE_TYPE' and lookup_code = pta.payment_purpose_code) payment_purpose,
 pta.actual_amount,
 pta.start_date start_date,
 nvl(xlc.payment_end_date,pta.end_date) end_date,
 decode(xxen_pn.get_pay_term_proration_rule(pta.lease_id),
   '365 Days/Year', ceil(months_between(last_day(end_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + round((decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/365*12-1) + decode(to_char(end_date,'DD'),to_char(last_day(end_date),'DD'),0,to_number(to_char(end_date,'DD'))/365*12-1)),1),
   '360 Days/Year', ceil(months_between(last_day(end_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/360*12-1) + decode(to_char(end_date,'DD'),to_char(last_day(end_date),'DD'),0,to_number(to_char(end_date,'DD'))/360*12-1),
   'Days/Month', ceil(months_between(last_day(end_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/to_number(to_char(last_day(start_date),'DD'))-1) + decode(to_char(end_date,'DD'),to_char(last_day(end_date),'DD'),0, to_number(to_char(end_date,'DD'))/to_number(to_char(last_day(end_date),'DD'))-1)
   ) duration,
 decode(nvl(xlc.liability_flag,pta.liability_flag), 'Y', 'Yes', 'No') liability_flag,
 decode(nvl(xlc.rou_asset_flag,pta.rou_asset_flag), 'Y', 'Yes', 'No') rou_asset_flag,
 decode(nvl(xlc.rept_inception_flag,pta.rept_inception_flag), 'Y', 'Yes', 'No') rept_inception_flag,
 pta.schedule_day,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_FREQUENCY_TYPE' and lookup_code = pta.frequency_code) payment_frequency,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_TERM_TYPE' and lookup_code = pta.payment_term_type_code) payment_type,
 xxen_pn.get_lease_rate_value(pta.lease_id) term_rate_value,
 xxen_pn.get_lease_accounting_method(pta.lease_id) term_accounting_method,
 xxen_pn.get_pay_term_initial_rate(pta.lease_id,pta.payment_term_id,xxen_pn.get_as_of_date(pta.lease_id)) term_initial_rate,
 xxen_pn.get_pay_term_discount_rate(pta.lease_id,pta.payment_term_id,xxen_pn.get_as_of_date(pta.lease_id)) term_discount_rate,
 ' ' asset_number
from
 pn_payment_terms_all pta,
 (select
   plc.payment_term_id,
   plc.option_id,
   plc.lease_id,
   plc.option_end_date,
   plc.payment_end_date,
   plc.liability_flag,
   plc.rou_asset_flag,
   plc.rept_inception_flag,
   decode(pn_streams_util.get_daily_flag(pla.org_id),'N',last_day(trunc(plc.creation_date) ),pn_streams_util.last_day_period (plc.creation_date,pla.org_id) ) as_of_date,
   plc.creation_date,
   max(plc.creation_date) over( partition by plc.payment_term_id,plc.option_id,plc.lease_id order by 1 ) max_creation_date
  from
   pn_lease_chg_details plc,
   pn_leases_all pla
  where
      pla.lease_id = plc.lease_id
  and trunc(xxen_pn.get_as_of_date(pla.lease_id)) >= decode(pn_streams_util.get_daily_flag(pla.org_id),'N',last_day(trunc(plc.creation_date) ),pn_streams_util.last_day_period (plc.creation_date,pla.org_id) )
 ) xlc,
 pn_leases_all pl
where
    pta.lease_id =pl.lease_id
and nvl(xlc.creation_date,sysdate) = nvl(xlc.max_creation_date,sysdate)
and pta.payment_term_id = xlc.payment_term_id(+)
and nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(pl.lease_id)))< trunc(xxen_pn.get_as_of_date(pl.lease_id))
and pn_system_pub.get_frozen_flag (:p_org_id) = 'Y'
and trunc(xxen_pn.get_as_of_date(pl.lease_id)) >= nvl(trunc(xlc.as_of_date),trunc(xxen_pn.get_as_of_date(pl.lease_id)))
union
select
 pta.lease_id,
 pta.payment_term_id,
 currency_code payment_currency,
 (select meaning from fnd_lookups where lookup_type = 'PN_EQP_PAYMT_PURPOSE_TYPE' and lookup_code = pta.payment_purpose_code) payment_purpose,
 pta.actual_amount,
 pta.start_date start_date,
 nvl(xlc.payment_end_date,pta.end_date) end_date,
 decode(xxen_pn.get_pay_term_proration_rule(pta.lease_id),
   '365 Days/Year', ceil(months_between(last_day(end_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + round((decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/365*12-1) + decode(to_char(end_date,'DD'),to_char(last_day(end_date),'DD'),0,to_number(to_char(end_date,'DD'))/365*12-1)),1),
   '360 Days/Year', ceil(months_between(last_day(end_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/360*12-1) + decode(to_char(end_date,'DD'),to_char(last_day(end_date),'DD'),0,to_number(to_char(end_date,'DD'))/360*12-1),
   'Days/Month', ceil(months_between(last_day(end_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/to_number(to_char(last_day(start_date),'DD'))-1) + decode(to_char(end_date,'DD'),to_char(last_day(end_date),'DD'),0, to_number(to_char(end_date,'DD'))/to_number(to_char(last_day(end_date),'DD'))-1)
   ) duration,
 decode(nvl(xlc.liability_flag,pta.liability_flag), 'Y', 'Yes', 'No') liability_flag,
 decode(nvl(xlc.rou_asset_flag,pta.rou_asset_flag), 'Y', 'Yes', 'No') rou_asset_flag,
 decode(nvl(xlc.rept_inception_flag,pta.rept_inception_flag), 'Y', 'Yes', 'No') rept_inception_flag,
 pta.schedule_day,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_FREQUENCY_TYPE' and lookup_code = pta.frequency_code) payment_frequency,
 (select meaning from fnd_lookups where lookup_type = 'PN_EQP_PAYMT_TERM_TYPE' and lookup_code = pta.payment_term_type_code) payment_type,
 xxen_pn.get_lease_rate_value(pta.lease_id) term_rate_value,
 xxen_pn.get_lease_accounting_method(pta.lease_id) term_accounting_method,
 xxen_pn.get_pay_term_initial_rate(pta.lease_id,pta.payment_term_id,xxen_pn.get_as_of_date(pta.lease_id)) term_initial_rate,
 xxen_pn.get_pay_term_discount_rate(pta.lease_id,pta.payment_term_id,xxen_pn.get_as_of_date(pta.lease_id)) term_discount_rate,
 peaa.asset_number asset_number
from
 pn_eqp_payment_terms_all pta,
 (select
   plc.payment_term_id,
   plc.option_id,
   plc.lease_id,
   plc.option_end_date,
   plc.payment_end_date,
   plc.liability_flag,
   plc.rou_asset_flag,
   plc.rept_inception_flag,
   decode(pn_streams_util.get_daily_flag(pla.org_id,'EQUIPMENT'),'N',last_day(trunc(plc.creation_date) ),pn_streams_util .last_day_period(plc.creation_date,pla.org_id) ) as_of_date,
   plc.creation_date,
   max(plc.creation_date) over( partition by plc.payment_term_id,plc.option_id,plc.lease_id order by 1 ) max_creation_date
  from
   pn_eqp_lease_chg_details plc,
   pn_eqp_leases_all pla
  where
      pla.lease_id = plc.lease_id
  and trunc(xxen_pn.get_as_of_date(pla.lease_id)) >= decode(pn_streams_util.get_daily_flag(pla.org_id,'EQUIPMENT'),'N',last_day(trunc(plc.creation_date) ),pn_streams_util .last_day_period(plc.creation_date,pla.org_id) )
 ) xlc,
 pn_eqp_leases_all pel,
 pn_eqp_assets_all peaa
where
    pta.lease_id =pel.lease_id
and pta.payment_term_id = xlc.payment_term_id(+)
and nvl(xlc.creation_date,sysdate) = nvl(xlc.max_creation_date,sysdate)
and pta.location_id=peaa.asset_id(+)
and trunc(xxen_pn.get_as_of_date(pel.lease_id)) >= nvl(trunc(xlc.as_of_date),trunc(xxen_pn.get_as_of_date(pel.lease_id)))
),
--
--q_payment_items_pv -- Lease Payment Term Items
--
q_payment_items_pv as
(
select
 lease_id,
 payment_term_id,
 due_date due_date,
 due_date term_due_date,
 pmt_days,
 actual_amount_rou,
 actual_amount_liability,
 discount_rate,
 pv_rou,
 pv_liability
from
 (select
   lease_id,
   payment_term_id,
   due_date,
   pmt_days,
   actual_amount_rou,
   actual_amount_liability,
   discount_rate,
   pv_rou,
   pv_liability
  from
   pn_pmt_item_pv_all
  where
      trunc(as_of_date) = trunc(xxen_pn.get_as_of_date(lease_id))
  and (nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(lease_id))) >= trunc(xxen_pn.get_as_of_date(lease_id)) or pn_system_pub.get_frozen_flag (:p_org_id) = 'N')
  union all
  select
   lease_id,
   payment_term_id,
   due_date,
   pmt_days,
   actual_amount_rou,
   actual_amount_liability,
   discount_rate,
   pv_rou,
   pv_liability
  from
   pn_pmt_item_pv_hist
  where
      trunc(as_of_date) = trunc(xxen_pn.get_as_of_date(lease_id))
  and (nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(lease_id))) >= trunc(xxen_pn.get_as_of_date(lease_id)) or pn_system_pub.get_frozen_flag (:p_org_id) = 'N')
  union all
  select
   lease_id,
   payment_term_id,
   due_date,
   pmt_days,
   actual_amount_rou,
   actual_amount_liability,
   discount_rate,
   pv_rou,
   pv_liability
  from
   (select
     pvhist.*,
     dense_rank() over (partition by lease_id,payment_term_id order by as_of_date desc) rnk
    from
     pn_pmt_item_pv_hist pvhist
   ) hist
  where
      rnk = 1
  and (   nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(hist.lease_id))) >= trunc(xxen_pn.get_as_of_date(hist.lease_id))
       or (pn_system_pub.get_frozen_flag (:p_org_id) = 'N' and pn_transaction_util.get_transition_date(:p_org_id) is null)
      )
  and not exists (select 1 from pn_pmt_item_pv_hist where lease_id = hist.lease_id and trunc(as_of_date) = trunc(xxen_pn.get_as_of_date(hist.lease_id)))
  and not exists (select 1 from pn_pmt_item_pv_all where lease_id = hist.lease_id and trunc(as_of_date) = trunc(xxen_pn.get_as_of_date(hist.lease_id)))
  union all
  select
   t.lease_id,
   t.payment_term_id,
   t.due_date,
   t.pmt_days,
   t.actual_amount_rou,
   t.actual_amount_liability,
   t.discount_rate,
   t.pv_rou,
   t.pv_liability
  from
   (select
     pips.due_date,
     pips.pmt_days,
     pips.actual_amount_rou,
     pips.actual_amount_liability,
     pips.discount_rate,
     pips.pv_rou,
     pips.pv_liability,
     pips.stream_version,
     pips.as_of_date,
     pips.payment_term_id,
     pips.lease_id,
     max(to_number(pips.stream_version)) over(partition by pips.lease_id,pips.payment_term_id) max_stream_version
    from
     pn_pmt_item_pv_stream_all pips,
     pn_leases_all pl
    where
        pips.lease_id=pl.lease_id
    and trunc(pips.as_of_date) <= trunc(xxen_pn.get_as_of_date(pl.lease_id))
    and nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(pl.lease_id))) < trunc(xxen_pn.get_as_of_date(pl.lease_id))
   ) t
  where
      trunc(t.as_of_date) <= trunc(xxen_pn.get_as_of_date(t.lease_id))
  and nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(t.lease_id))) < trunc(xxen_pn.get_as_of_date(t.lease_id))
  and pn_system_pub.get_frozen_flag (:p_org_id) = 'Y'
  and t.stream_version = t.max_stream_version
  union all
  select
   t.lease_id,
   t.payment_term_id,
   t.due_date,
   t.pmt_days,
   t.actual_amount_rou,
   t.actual_amount_liability,
   t.discount_rate,
   t.pv_rou,
   t.pv_liability
  from
   (select
     pips.due_date,
     pips.pmt_days,
     pips.actual_amount_rou,
     pips.actual_amount_liability,
     pips.discount_rate,
     pips.pv_rou,
     pips.pv_liability,
     pips.stream_version,
     pips.as_of_date,
     pips.payment_term_id,
     pips.lease_id,
     max(to_number(pips.stream_version)) over(partition by pips.lease_id,pips.payment_term_id) max_stream_version
    from
     pn_pmt_item_pv_stream_all pips,
     pn_eqp_leases_all pel
    where
        pips.lease_id=pel.lease_id
    and trunc(pips.as_of_date) <= trunc(xxen_pn.get_as_of_date(pel.lease_id))
   ) t
  where
      trunc(t.as_of_date) <= trunc(xxen_pn.get_as_of_date(t.lease_id))
  and t.stream_version = t.max_stream_version
 )
),
--
--q_payment_items_amort -- Lease Payment Term Items Amortization
--
q_payment_items_amort as
(
select
 lease_id,
 payment_term_id,
 period_date term_period,
 period_date period_date,
 sum(nvl(rou_bal_start_us_opr,0)) rou_bal_start_us_opr,
 sum(nvl(rou_amrtztn_amt_us_opr,0)) rou_amrtztn_amt_us_opr,
 sum(nvl(rou_bal_end_us_opr,0)) rou_bal_end_us_opr,
 sum(nvl(lia_bal_start,0)) lia_bal_start,
 sum(nvl(actual_pmt_amt,0)) lease_payment,
 sum(nvl(lia_intrst_amt,0)) interest_expense,
 sum(nvl(lia_bal_end,0)) lia_bal_end,
 sum(nvl(exp_amt,0)) lease_expense,
 sum(nvl(rou_bal_start_fin,0)) rou_bal_start_fin,
 sum(nvl(rou_bal_end_fin,0)) rou_bal_end_fin,
 sum(nvl(rou_amrtztn_amt_fin,0)) rou_amrtztn_amt_fin,
 max(nvl(discount_rate,0)) irr_rate,
 sum(nvl(rou_adj_ifrs,0)) rou_adj_fin,
 sum(nvl(lia_adj_ifrs,0)) lia_adj_fin,
 sum(nvl(gain_loss_ifrs,0)) gain_loss_fin,
 sum(nvl(rou_adj_gaap,0)) rou_adj_us_opr,
 sum(nvl(lia_adj_gaap,0)) lia_adj_us_opr,
 sum(nvl(gain_loss_gaap,0)) gain_loss_us_opr
from
 (select
   lease_id,
   payment_term_id,
   period_date,
   rou_bal_start_us_opr,
   rou_amrtztn_amt_us_opr,
   rou_bal_end_us_opr,
   lia_bal_start,
   actual_pmt_amt,
   lia_intrst_amt,
   lia_bal_end,
   decode(pn_transaction_util.get_liab_only_flag(payment_term_id,option_id),'Y',lia_intrst_amt,exp_amt) exp_amt,
   rou_bal_start_fin,
   rou_bal_end_fin,
   rou_amrtztn_amt_fin,
   discount_rate,
   null rou_adj_ifrs,
   null lia_adj_ifrs,
   null gain_loss_ifrs,
   null rou_adj_gaap,
   null lia_adj_gaap,
   null gain_loss_gaap
  from
   pn_pmt_item_amrtzn_all
  where
      trunc(as_of_date) = trunc(xxen_pn.get_as_of_date(lease_id) )
  and ( nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(lease_id) ) ) >= trunc(xxen_pn.get_as_of_date(lease_id) ) or pn_system_pub.get_frozen_flag(:p_org_id) = 'N' )
  union
  select
   lease_id,
   payment_term_id,
   period_date,
   rou_bal_start_us_opr,
   rou_amrtztn_amt_us_opr,
   rou_bal_end_us_opr,
   lia_bal_start,
   actual_pmt_amt,
   lia_intrst_amt,
   lia_bal_end,
   decode(pn_transaction_util.get_liab_only_flag(payment_term_id,option_id),'Y',lia_intrst_amt,exp_amt) exp_amt,
   rou_bal_start_fin,
   rou_bal_end_fin,
   rou_amrtztn_amt_fin,
   discount_rate,
   null rou_adj_ifrs,
   null lia_adj_ifrs,
   null gain_loss_ifrs,
   null rou_adj_gaap,
   null lia_adj_gaap,
   null gain_loss_gaap
  from
   pn_pmt_item_amrtzn_hist
  where
      trunc(as_of_date) = trunc(xxen_pn.get_as_of_date(lease_id) )
  and ( nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(lease_id) ) ) >= trunc(xxen_pn.get_as_of_date(lease_id) ) or pn_system_pub.get_frozen_flag(:p_org_id) = 'N' )
  union
  select
   lease_id,
   payment_term_id,
   period_date,
   rou_bal_start_us_opr,
   rou_amrtztn_amt_us_opr,
   rou_bal_end_us_opr,
   lia_bal_start,
   actual_pmt_amt,
   lia_intrst_amt,
   lia_bal_end,
   decode(pn_transaction_util.get_liab_only_flag(hist.payment_term_id,hist.option_id),'Y',lia_intrst_amt,exp_amt) exp_amt,
   rou_bal_start_fin,
   rou_bal_end_fin,
   rou_amrtztn_amt_fin,
   discount_rate,
   null rou_adj_ifrs,
   null lia_adj_ifrs,
   null gain_loss_ifrs,
   null rou_adj_gaap,
   null lia_adj_gaap,
   null gain_loss_gaap
  from
   (select
     amrthist.*,
     dense_rank() over( partition by lease_id,payment_term_id order by as_of_date desc ) rnk
    from
     pn_pmt_item_amrtzn_hist amrthist
   ) hist
  where
      rnk = 1
  and (   nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(hist.lease_id) ) ) >= trunc(xxen_pn.get_as_of_date(hist.lease_id) )
       or (pn_system_pub.get_frozen_flag(:p_org_id) = 'N' and pn_transaction_util.get_transition_date(:p_org_id) is null)
      )
  and not exists (select 1 from pn_pmt_item_amrtzn_hist where lease_id = hist.lease_id and trunc(as_of_date) = trunc(xxen_pn.get_as_of_date(hist.lease_id) ) )
  and not exists (select 1 from pn_pmt_item_amrtzn_all where lease_id = hist.lease_id and trunc(as_of_date) = trunc(xxen_pn.get_as_of_date(hist.lease_id) ) )
  union
  select
   lease_id,
   payment_term_id,
   stream_date period_date,
   rou_gaap_beg_amount rou_bal_start_us_opr,
   amor_gaap_amount rou_amrtztn_amt_us_opr,
   rou_gaap_amount rou_bal_end_us_opr,
   lib_ifrs_beg_amount lia_bal_start,
   cash_ifrs_amount actual_pmt_amt,
   interest_ifrs_amount lia_intrst_amt,
   lib_ifrs_amount lia_bal_end,
   expense_gaap_amount exp_amt,
   rou_ifrs_beg_amount rou_bal_start_fin,
   rou_ifrs_amount rou_bal_end_fin,
   amor_ifrs_amount rou_amrtztn_amt_fin,
   discount_rate,
   null rou_adj_ifrs,
   null lia_adj_ifrs,
   null gain_loss_ifrs,
   null rou_adj_gaap,
   null lia_adj_gaap,
   null gain_loss_gaap
  from
   (select
     t.lease_id,
     t.payment_term_id,
     t.option_id,
     t.stream_version,
     t.stream_date,
     t.as_of_date,
     t.rou_ifrs_amount,
     t.rou_gaap_amount,
     t.rou_ifrs_beg_amount,
     t.rou_gaap_beg_amount,
     t.lib_ifrs_beg_amount,
     t.cash_ifrs_amount,
     t.lib_ifrs_amount,
     t.interest_ifrs_amount,
     t.amor_ifrs_amount,
     t.amor_gaap_amount,
     decode(pn_transaction_util.get_liab_only_flag(t.payment_term_id,t.option_id),'Y' ,t.interest_ifrs_amount,t.expense_gaap_amount) expense_gaap_amount,
     max(to_number(t.stream_version)) over( partition by t.payment_term_id ) max_stream_version,
     t.discount_rate
    from
     pn_pmt_item_amrtzn_stream_v t,
     pn_leases_all pl
    where
        t.lease_id = pl.lease_id
    and nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(pl.lease_id) ) ) < trunc (xxen_pn.get_as_of_date(pl.lease_id) )
    and t.as_of_date <= trunc(xxen_pn.get_as_of_date(pl.lease_id) )
   ) a
  where
      a.as_of_date <= trunc(xxen_pn.get_as_of_date(a.lease_id) )
  and a.stream_version = a.max_stream_version
  and nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(a.lease_id) ) ) < trunc(xxen_pn.get_as_of_date(a.lease_id) )
  and pn_system_pub.get_frozen_flag (:p_org_id) = 'Y'
  union
  select
   lease_id,
   payment_term_id,
   stream_date period_date,
   rou_gaap_beg_amount rou_bal_start_us_opr,
   amor_gaap_amount rou_amrtztn_amt_us_opr,
   rou_gaap_amount rou_bal_end_us_opr,
   lib_ifrs_beg_amount lia_bal_start,
   cash_ifrs_amount actual_pmt_amt,
   interest_ifrs_amount lia_intrst_amt,
   lib_ifrs_amount lia_bal_end,
   expense_gaap_amount exp_amt,
   rou_ifrs_beg_amount rou_bal_start_fin,
   rou_ifrs_amount rou_bal_end_fin,
   amor_ifrs_amount rou_amrtztn_amt_fin,
   discount_rate,
   null rou_adj_ifrs,
   null lia_adj_ifrs,
   null gain_loss_ifrs,
   null rou_adj_gaap,
   null lia_adj_gaap,
   null gain_loss_gaap
  from
   (select
     t.lease_id,
     t.payment_term_id,
     t.option_id,
     t.stream_version,
     t.stream_date,
     t.as_of_date,
     t.rou_ifrs_amount,
     t.rou_gaap_amount,
     t.rou_ifrs_beg_amount,
     t.rou_gaap_beg_amount,
     t.lib_ifrs_beg_amount,
     t.cash_ifrs_amount,
     t.lib_ifrs_amount,
     t.interest_ifrs_amount,
     t.amor_ifrs_amount,
     t.amor_gaap_amount,
     decode(pn_transaction_util.get_liab_only_flag(t.payment_term_id,t.option_id),'Y' ,t.interest_ifrs_amount,t.expense_gaap_amount) expense_gaap_amount,
     max(to_number(t.stream_version)) over( partition by t.payment_term_id ) max_stream_version,
     t.discount_rate
    from
     pn_pmt_item_amrtzn_stream_v t,
     pn_eqp_leases_all pel
    where
        t.lease_id = pel.lease_id
    and t.as_of_date <= trunc(xxen_pn.get_as_of_date(pel.lease_id) )
   ) a
  where
      a.as_of_date <= trunc(xxen_pn.get_as_of_date(a.lease_id) )
  and a.stream_version = a.max_stream_version
  union
  select
   lease_id,
   payment_term_id,
   as_of_date period_date,
   null rou_bal_start_us_opr,
   null rou_amrtztn_amt_us_opr,
   null rou_bal_end_us_opr,
   null lia_bal_start,
   null actual_pmt_amt,
   null lia_intrst_amt,
   null lia_bal_end,
   null exp_amt,
   null rou_bal_start_fin,
   null rou_bal_end_fin,
   null rou_amrtztn_amt_fin,
   null discount_rate,
   rou_adj_ifrs,
   lia_adj_ifrs,
   gain_loss_ifrs,
   rou_adj_gaap,
   decode(lia_adj_us_opr, null, lia_adj_ifrs, lia_adj_us_opr) lia_adj_gaap,
   gain_loss_gaap
  from
   (select
     lease_id,
     payment_term_id,
     as_of_date,
     sum(decode(regime_code,'IFRS16',decode(stream_type_code,'ROU',nvl(entered_amount,0),'RESERVE',nvl(entered_amount,0)) ) ) rou_adj_ifrs,
     sum(decode(regime_code,'IFRS16',decode(stream_type_code,'LIABILITY',nvl(entered_amount,0)) ) ) lia_adj_ifrs,
     sum(decode(regime_code,'IFRS16',decode(stream_type_code,'GAIN',nvl(entered_amount,0),'LOSS',nvl(entered_amount,0)) ) ) gain_loss_ifrs,
     sum(decode(regime_code,'ASC842',decode(stream_type_code,'ROU',nvl(entered_amount,0),'RESERVE',nvl(entered_amount,0)) ) ) rou_adj_gaap,
     sum(decode(regime_code,'ASC842',decode(stream_type_code,'LIABILITY', entered_amount) ) ) lia_adj_us_opr,
     sum(decode(regime_code,'ASC842',decode(stream_type_code,'GAIN',nvl(entered_amount,0),'LOSS',nvl(entered_amount,0)) ) ) gain_loss_gaap
    from
     (select
       pnactth.lease_id,
       pnactth.regime_code,
       pnacttl.payment_term_id,
       pnacttl.option_id,
       pnactth.transaction_date,
       case
       when pnactth.transaction_date<=pnactth.creation_date
       then decode(pn_streams_util.get_daily_flag(pnactth.org_id),
                   'N' ,last_day(trunc(nvl(pnleachall.change_commencement_date, pnactth.creation_date)) ),
                        pn_streams_util.last_day_period(nvl(pnleachall.change_commencement_date, pnactth.creation_date),pnactth.org_id)
                  )
       else decode(pn_streams_util.get_daily_flag(pnactth.org_id),
                   'N' ,last_day(trunc(nvl(pnleachall.change_commencement_date, pnactth.transaction_date)) ),
                        pn_streams_util.last_day_period(nvl(pnleachall.change_commencement_date,pnactth.transaction_date),pnactth.org_id)
                  )
       end as as_of_date,
       pnacttl.entered_amount,
       pnacttl.stream_type_code
      from
       pn_acct_trx_headers_all pnactth,
       pn_acct_trx_lines_all pnacttl,
       pn_lease_changes_all_v pnleachall
      where
          pnacttl.transaction_id = pnactth.acct_transaction_id
      and pnleachall.lease_id = pnactth.lease_id
      and pnleachall.lease_change_id = pnactth.lease_change_id
      and pnactth.transaction_type in ( 'REVISION', 'TERMINATION' )
      and pnacttl.stream_type_code in ( 'ROU', 'LIABILITY', 'GAIN', 'LOSS', 'RESERVE' )
      and (   (pnacttl.stream_type_code in ( 'GAIN','LOSS', 'RESERVE'))
           or (exists (select
                        1
                       from
                        pn_acct_trx_headers_all pnactth1,
                        pn_acct_trx_lines_all pnacttl1
                       where
                           pnactth1.lease_id = pnactth.lease_id
                       and pnacttl1.transaction_id = pnactth1.acct_transaction_id
                       and pnacttl1.payment_term_id = pnacttl.payment_term_id
                       and pnactth1.acct_transaction_id <> pnactth.acct_transaction_id
                       and pnactth1.regime_code = pnactth.regime_code
                       and pnactth1.transaction_type <> 'ACCRUAL'
                      )
              )
          )
      and not exists  (select
                        'x'
                       from
                        pn_lease_chg_details_all_v plcd,
                        pn_streams_all psa,
                        pn_stream_lines_all psal
                       where
                           plcd.lease_change_id = psa.lease_change_id
                       and plcd.payment_term_id = psa.payment_term_id
                       and psal.stream_header_id = psa.stream_header_id
                       and psal.transaction_line_id = pnacttl.transaction_line_id
                       and plcd.lease_change_event in ( 'ADD_TERM','RI','VRI','OPEX')
                      )
      union
      select
       pnactth.lease_id,
       pnactth.regime_code,
       pnacttl.payment_term_id,
       pnacttl.option_id,
       pnactth.transaction_date,
       decode(pn_streams_util.get_daily_flag(pnactth.org_id),
              'N',last_day(trunc(pnactth.creation_date) ),
                  pn_streams_util.last_day_period(pnactth.creation_date,pnactth.org_id)
             ) as_of_date,
       pnacttl.entered_amount,
       pnacttl.stream_type_code
      from
       pn_acct_trx_headers_all pnactth,
       pn_acct_trx_lines_all pnacttl
      where
          pnacttl.transaction_id = pnactth.acct_transaction_id
      and pnactth.transaction_type in ( 'REVISION', 'TERMINATION' )
      and pnacttl.stream_type_code in ( 'ROU', 'LIABILITY', 'GAIN', 'LOSS' )
      and exists (select
                   'x'
                  from
                   pn_lease_chg_details_all_v plcd
                  where
                      pnactth.lease_change_id=plcd.lease_change_id
                  and plcd.lease_change_event in ('ADD_TERM')
                  and pnacttl.description like 'Remeasurement %'
                  and nvl(pnacttl.reverse_flag,'N')<>'Y'
                 )
     ) a
    group by
     lease_id,
     payment_term_id,
     as_of_date
   ) b
 )
group by
 lease_id,
 payment_term_id,
 period_date
),
--
--q_options -- Lease Options
--
q_options as
(
select
 lease_id,
 option_id,
 currency_code option_currency,
 (select meaning from fnd_lookups where lookup_type = 'PN_LEASE_OPTION_TYPE' and lookup_code = option_type_code) option_type,
 actual_amount option_actual_amount,
 start_date option_start_date,
 expiration_date option_end_date,
 decode(xxen_pn.get_pay_term_proration_rule(lease_id),
        '365 Days/Year', ceil(months_between(last_day(expiration_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/365*12-1) + decode(to_char(expiration_date,'DD'),to_char(last_day(expiration_date),'DD'),0,to_number(to_char(expiration_date,'DD'))/365*12-1),
        '360 Days/Year', ceil(months_between(last_day(expiration_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/360*12-1) + decode(to_char(expiration_date,'DD'),to_char(last_day(expiration_date),'DD'),0,to_number(to_char(expiration_date,'DD'))/360*12-1),
        'Days/Month', ceil(months_between(last_day(expiration_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/to_number(to_char(last_day(start_date),'DD'))-1) + decode(to_char(expiration_date,'DD'),to_char(last_day(expiration_date),'DD'),0, to_number(to_char(expiration_date,'DD'))/to_number(to_char(last_day(expiration_date),'DD'))-1)
       ) option_duration,
 decode(liability_flag, 'Y', 'Yes', 'No') option_liability_flag,
 decode(rou_asset_flag, 'Y', 'Yes', 'No') option_rou_asset_flag,
 decode(rept_inception_flag, 'Y', 'Yes', 'No') option_rept_inception_flag,
 schedule_day option_schedule_day,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_FREQUENCY_TYPE' and lookup_code = frequency_code) option_frequency,
 xxen_pn.get_lease_rate_value(lease_id) option_rate_value,
 xxen_pn.get_lease_accounting_method(lease_id) opt_accounting_method,
 xxen_pn.get_option_initial_rate(lease_id,option_id,xxen_pn.get_as_of_date(lease_id)) option_initial_rate,
 xxen_pn.get_option_discount_rate(lease_id,option_id,xxen_pn.get_as_of_date(lease_id)) option_discount_rate,
 ' ' asset_number
from
 pn_options_all
where
    option_status_lookup_code in ('NOTEXERCISED', 'OPEN')
and xxen_pn.get_lease_data_source = 'P'
and (   nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(lease_id))) >= trunc(xxen_pn.get_as_of_date(lease_id))
     or pn_system_pub.get_frozen_flag (:p_org_id) = 'N'
    )
union
select
 lease_id,
 option_id,
 currency_code option_currency,
 (select meaning from fnd_lookups where lookup_type = 'PN_LEASE_OPTION_TYPE' and lookup_code = option_type_code) option_type,
 actual_amount option_actual_amount,
 start_date option_start_date,
 expiration_date option_end_date,
 decode(xxen_pn.get_pay_term_proration_rule(lease_id),
        '365 Days/Year', ceil(months_between(last_day(expiration_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/365*12-1) + decode(to_char(expiration_date,'DD'),to_char(last_day(expiration_date),'DD'),0,to_number(to_char(expiration_date,'DD'))/365*12-1),
        '360 Days/Year', ceil(months_between(last_day(expiration_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/360*12-1) + decode(to_char(expiration_date,'DD'),to_char(last_day(expiration_date),'DD'),0,to_number(to_char(expiration_date,'DD'))/360*12-1),
        'Days/Month', ceil(months_between(last_day(expiration_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/to_number(to_char(last_day(start_date),'DD'))-1) + decode(to_char(expiration_date,'DD'),to_char(last_day(expiration_date),'DD'),0, to_number(to_char(expiration_date,'DD'))/to_number(to_char(last_day(expiration_date),'DD'))-1)
       ) option_duration,
 decode(liability_flag, 'Y', 'Yes', 'No') option_liability_flag,
 decode(rou_asset_flag, 'Y', 'Yes', 'No') option_rou_asset_flag,
 decode(rept_inception_flag, 'Y', 'Yes', 'No') option_rept_inception_flag,
 schedule_day option_schedule_day,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_FREQUENCY_TYPE' and lookup_code = frequency_code) option_frequency,
 xxen_pn.get_lease_rate_value(lease_id) option_rate_value,
 xxen_pn.get_lease_accounting_method(lease_id) opt_accounting_method,
 xxen_pn.get_option_initial_rate(lease_id,option_id,xxen_pn.get_as_of_date(lease_id)) option_initial_rate,
 xxen_pn.get_option_discount_rate(lease_id,option_id,xxen_pn.get_as_of_date(lease_id)) option_discount_rate,
 ' ' asset_number
from
 pn_options_hist
where
    option_status_lookup_code in ('NOTEXERCISED', 'OPEN')
and trunc(as_of_date) = trunc((select max(as_of_date) from pn_leases_hist plhh where plhh.lease_id=pn_options_hist.lease_id and trunc(plhh.as_of_date) <= trunc(xxen_pn.get_as_of_date(plhh.lease_id))))
and exists (select 1 from pn_leases_hist plh where plh.lease_id=pn_options_hist.lease_id)
and xxen_pn.get_lease_data_source = 'A'
and not exists (select 1 from pn_payment_terms_all pt where pt.lease_id=pn_options_hist.lease_id and pt.rept_inception_flag = 'Y'
                union all
                select 1 from pn_options_all po where po.lease_id=pn_options_hist.lease_id and po.rept_inception_flag='Y')
and (   nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(lease_id))) >= trunc(xxen_pn.get_as_of_date(lease_id))
     or pn_system_pub.get_frozen_flag (:p_org_id) = 'N'
    )
union
select
 lease_id,
 option_id,
 currency_code option_currency,
 (select meaning from fnd_lookups where lookup_type = 'PN_LEASE_OPTION_TYPE' and lookup_code = option_type_code) option_type,
 actual_amount option_actual_amount,
 start_date option_start_date,
 expiration_date option_end_date,
 decode(xxen_pn.get_pay_term_proration_rule(lease_id),
        '365 Days/Year', ceil(months_between(last_day(expiration_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/365*12-1) + decode(to_char(expiration_date,'DD'),to_char(last_day(expiration_date),'DD'),0,to_number(to_char(expiration_date,'DD'))/365*12-1),
        '360 Days/Year', ceil(months_between(last_day(expiration_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/360*12-1) + decode(to_char(expiration_date,'DD'),to_char(last_day(expiration_date),'DD'),0,to_number(to_char(expiration_date,'DD'))/360*12-1),
        'Days/Month', ceil(months_between(last_day(expiration_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/to_number(to_char(last_day(start_date),'DD'))-1) + decode(to_char(expiration_date,'DD'),to_char(last_day(expiration_date),'DD'),0, to_number(to_char(expiration_date,'DD'))/to_number(to_char(last_day(expiration_date),'DD'))-1)
       ) option_duration,
 decode(liability_flag, 'Y', 'Yes', 'No') option_liability_flag,
 decode(rou_asset_flag, 'Y', 'Yes', 'No') option_rou_asset_flag,
 decode(rept_inception_flag, 'Y', 'Yes', 'No') option_rept_inception_flag,
 schedule_day option_schedule_day,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_FREQUENCY_TYPE' and lookup_code = frequency_code) option_frequency,
 xxen_pn.get_lease_rate_value(lease_id) option_rate_value,
 xxen_pn.get_lease_accounting_method(lease_id) opt_accounting_method,
 xxen_pn.get_option_initial_rate(lease_id,option_id,xxen_pn.get_as_of_date(lease_id)) option_initial_rate,
 xxen_pn.get_option_discount_rate(lease_id,option_id,xxen_pn.get_as_of_date(lease_id)) option_discount_rate,
 ' ' asset_number
from
 pn_options_all
where
    option_status_lookup_code in ('NOTEXERCISED', 'OPEN')
and not exists (select 1 from pn_leases_hist plh where plh.lease_id=pn_options_all.lease_id)
and xxen_pn.get_lease_data_source = 'A'
and not exists (select 1 from pn_payment_terms_all pt where pt.lease_id=pn_options_all.lease_id and pt.rept_inception_flag = 'Y'
                union all
                select 1 from pn_options_all po where po.lease_id=pn_options_all.lease_id and po.rept_inception_flag='Y'
               )
and (   nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(lease_id))) >= trunc(xxen_pn.get_as_of_date(lease_id))
     or pn_system_pub.get_frozen_flag (:p_org_id) = 'N'
    )
union
select
 lease_id,
 option_id,
 currency_code option_currency,
 (select meaning from fnd_lookups where lookup_type = 'PN_LEASE_OPTION_TYPE' and lookup_code = option_type_code) option_type,
 actual_amount option_actual_amount,
 start_date option_start_date,
 expiration_date option_end_date,
 decode(xxen_pn.get_pay_term_proration_rule(lease_id),
        '365 Days/Year', ceil(months_between(last_day(expiration_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/365*12-1) + decode(to_char(expiration_date,'DD'),to_char(last_day(expiration_date),'DD'),0,to_number(to_char(expiration_date,'DD'))/365*12-1),
        '360 Days/Year', ceil(months_between(last_day(expiration_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/360*12-1) + decode(to_char(expiration_date,'DD'),to_char(last_day(expiration_date),'DD'),0,to_number(to_char(expiration_date,'DD'))/360*12-1),
        'Days/Month', ceil(months_between(last_day(expiration_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/to_number(to_char(last_day(start_date),'DD'))-1) + decode(to_char(expiration_date,'DD'),to_char(last_day(expiration_date),'DD'),0, to_number(to_char(expiration_date,'DD'))/to_number(to_char(last_day(expiration_date),'DD'))-1)
       ) option_duration,
 decode(liability_flag, 'Y', 'Yes', 'No') option_liability_flag,
 decode(rou_asset_flag, 'Y', 'Yes', 'No') option_rou_asset_flag,
 decode(rept_inception_flag, 'Y', 'Yes', 'No') option_rept_inception_flag,
 schedule_day option_schedule_day,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_FREQUENCY_TYPE' and lookup_code = frequency_code) option_frequency,
 xxen_pn.get_lease_rate_value(lease_id) option_rate_value,
 xxen_pn.get_lease_accounting_method(lease_id) opt_accounting_method,
 xxen_pn.get_option_initial_rate(lease_id,option_id,xxen_pn.get_as_of_date(lease_id)) option_initial_rate,
 xxen_pn.get_option_discount_rate(lease_id,option_id,xxen_pn.get_as_of_date(lease_id)) option_discount_rate,
 ' ' asset_number
from
 pn_options_all
where
    option_status_lookup_code in ('NOTEXERCISED', 'OPEN')
and xxen_pn.get_lease_data_source = 'A'
and exists (select 1 from pn_pmt_item_pv_all pivh where pivh.lease_id=pn_options_all.lease_id and pivh.as_of_date = xxen_pn.get_as_of_date(pivh.lease_id))
and exists (select 1 from pn_payment_terms_all pt where pt.lease_id=pn_options_all.lease_id and pt.rept_inception_flag = 'Y'
            union all
            select 1 from pn_options_all po where po.lease_id=pn_options_all.lease_id and po.rept_inception_flag='Y'
           )
and (   nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(lease_id))) >= trunc(xxen_pn.get_as_of_date(lease_id))
     or pn_system_pub.get_frozen_flag (:p_org_id) = 'N'
    )
union
select
 lease_id,
 option_id,
 currency_code option_currency,
 (select meaning from fnd_lookups where lookup_type = 'PN_LEASE_OPTION_TYPE' and lookup_code = option_type_code) option_type,
 actual_amount option_actual_amount,
 start_date option_start_date,
 expiration_date option_end_date,
 decode(xxen_pn.get_pay_term_proration_rule(lease_id),
        '365 Days/Year', ceil(months_between(last_day(expiration_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/365*12-1) + decode(to_char(expiration_date,'DD'),to_char(last_day(expiration_date),'DD'),0,to_number(to_char(expiration_date,'DD'))/365*12-1),
        '360 Days/Year', ceil(months_between(last_day(expiration_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/360*12-1) + decode(to_char(expiration_date,'DD'),to_char(last_day(expiration_date),'DD'),0,to_number(to_char(expiration_date,'DD'))/360*12-1),
        'Days/Month', ceil(months_between(last_day(expiration_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/to_number(to_char(last_day(start_date),'DD'))-1) + decode(to_char(expiration_date,'DD'),to_char(last_day(expiration_date),'DD'),0, to_number(to_char(expiration_date,'DD'))/to_number(to_char(last_day(expiration_date),'DD'))-1)
       ) option_duration,
 decode(liability_flag, 'Y', 'Yes', 'No') option_liability_flag,
 decode(rou_asset_flag, 'Y', 'Yes', 'No') option_rou_asset_flag,
 decode(rept_inception_flag, 'Y', 'Yes', 'No') option_rept_inception_flag,
 schedule_day option_schedule_day,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_FREQUENCY_TYPE' and lookup_code = frequency_code) option_frequency,
 xxen_pn.get_lease_rate_value(lease_id) option_rate_value,
 xxen_pn.get_lease_accounting_method(lease_id) opt_accounting_method,
 xxen_pn.get_option_initial_rate(lease_id,option_id,xxen_pn.get_as_of_date(lease_id)) option_initial_rate,
 xxen_pn.get_option_discount_rate(lease_id,option_id,xxen_pn.get_as_of_date(lease_id)) option_discount_rate,
 ' ' asset_number
from
 pn_options_hist
where
    option_status_lookup_code in ('NOTEXERCISED', 'OPEN')
and xxen_pn.get_lease_data_source = 'A'
and trunc(as_of_date) = trunc((select max(as_of_date) from pn_leases_hist plhh where plhh.lease_id=pn_options_hist.lease_id and trunc(plhh.as_of_date) <= trunc(xxen_pn.get_as_of_date(plhh.lease_id))))
and not exists (select 1 from pn_pmt_item_pv_all pivh where pivh.lease_id=pn_options_hist.lease_id and pivh.as_of_date = xxen_pn.get_as_of_date(pivh.lease_id))
and exists (select 1 from pn_payment_terms_all pt where pt.lease_id=pn_options_hist.lease_id and pt.rept_inception_flag = 'Y'
            union all
            select 1 from pn_options_all po where po.lease_id=pn_options_hist.lease_id and po.rept_inception_flag='Y'
           )
and (   nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(lease_id))) >= trunc(xxen_pn.get_as_of_date(lease_id))
     or pn_system_pub.get_frozen_flag (:p_org_id) = 'N'
    )
union
select
 pta.lease_id,
 pta.option_id,
 currency_code option_currency,
 (select meaning from fnd_lookups where lookup_type = 'PN_LEASE_OPTION_TYPE' and lookup_code = pta.option_type_code) option_type,
 pta.actual_amount option_actual_amount,
 pta.start_date option_start_date,
 nvl(xlc.option_end_date,pta.expiration_date) option_end_date,
 decode(xxen_pn.get_pay_term_proration_rule(pta.lease_id),
        '365 Days/Year', ceil(months_between(last_day(expiration_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/365*12-1) + decode(to_char(expiration_date,'DD'),to_char(last_day(expiration_date),'DD'),0,to_number(to_char(expiration_date,'DD'))/365*12-1),
        '360 Days/Year', ceil(months_between(last_day(expiration_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/360*12-1) + decode(to_char(expiration_date,'DD'),to_char(last_day(expiration_date),'DD'),0,to_number(to_char(expiration_date,'DD'))/360*12-1),
        'Days/Month', ceil(months_between(last_day(expiration_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/to_number(to_char(last_day(start_date),'DD'))-1) + decode(to_char(expiration_date,'DD'),to_char(last_day(expiration_date),'DD'),0, to_number(to_char(expiration_date,'DD'))/to_number(to_char(last_day(expiration_date),'DD'))-1)
       ) option_duration,
 decode(nvl(xlc.liability_flag,pta.liability_flag), 'Y', 'Yes', 'No') option_liability_flag,
 decode(nvl(xlc.rou_asset_flag,pta.rou_asset_flag), 'Y', 'Yes', 'No') option_rou_asset_flag,
 decode(nvl(xlc.rept_inception_flag,pta.rept_inception_flag), 'Y', 'Yes', 'No') option_rept_inception_flag,
 pta.schedule_day option_schedule_day,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_FREQUENCY_TYPE' and lookup_code = frequency_code) option_frequency,
 xxen_pn.get_lease_rate_value(pta.lease_id) option_rate_value,
 xxen_pn.get_lease_accounting_method(pta.lease_id) opt_accounting_method,
 xxen_pn.get_option_initial_rate(pta.lease_id,pta.option_id,xxen_pn.get_as_of_date(pta.lease_id)) option_initial_rate,
 xxen_pn.get_option_discount_rate(pta.lease_id,pta.option_id,xxen_pn.get_as_of_date(pta.lease_id)) option_discount_rate,
 ' ' asset_number
from
 pn_options_all pta,
 (select
   plc.lease_id,
   plc.payment_term_id,
   plc.option_id,
   plc.option_end_date,
   plc.payment_end_date,
   plc.liability_flag,
   plc.rou_asset_flag,
   plc.rept_inception_flag,
   decode(pn_streams_util.get_daily_flag(pla.org_id),'N',last_day(trunc(plc.creation_date) ),pn_streams_util.last_day_period (plc.creation_date,pla.org_id) ) as_of_date,
   plc.creation_date,
   max(plc.creation_date) over( partition by plc.payment_term_id,plc.option_id,plc.lease_id order by 1 ) max_creation_date
  from
   pn_lease_chg_details plc,
   pn_leases_all pla
  where
      pla.lease_id = plc.lease_id
  and trunc(xxen_pn.get_as_of_date(pla.lease_id)) >= decode(pn_streams_util.get_daily_flag(pla.org_id),'N',last_day(trunc(plc.creation_date) ),pn_streams_util.last_day_period (plc.creation_date,pla.org_id) )
 ) xlc
where
    pta.option_id = xlc.option_id(+)
and nvl(xlc.creation_date,sysdate) = nvl(xlc.max_creation_date,sysdate)
and nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(xlc.lease_id)))< trunc(xxen_pn.get_as_of_date(xlc.lease_id))
and pn_system_pub.get_frozen_flag (:p_org_id) = 'Y'
and trunc(xxen_pn.get_as_of_date(xlc.lease_id)) >= nvl(trunc(xlc.as_of_date),trunc(xxen_pn.get_as_of_date(xlc.lease_id)))
union
select
 pta.lease_id,
 pta.option_id,
 currency_code option_currency,
 (select meaning from fnd_lookups where lookup_type = 'PN_EQP_LEASE_OPTION_TYPE' and lookup_code = pta.option_type_code) option_type,
 pta.actual_amount option_actual_amount,
 pta.start_date option_start_date,
 nvl(xlc.option_end_date,pta.expiration_date) option_end_date,
 decode(xxen_pn.get_pay_term_proration_rule(pta.lease_id),
        '365 Days/Year', ceil(months_between(last_day(expiration_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/365*12-1) + decode(to_char(expiration_date,'DD'),to_char(last_day(expiration_date),'DD'),0,to_number(to_char(expiration_date,'DD'))/365*12-1),
        '360 Days/Year', ceil(months_between(last_day(expiration_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/360*12-1) + decode(to_char(expiration_date,'DD'),to_char(last_day(expiration_date),'DD'),0,to_number(to_char(expiration_date,'DD'))/360*12-1),
        'Days/Month', ceil(months_between(last_day(expiration_date),to_date(to_char(start_date,'YYYY/MM'),'YYYY/MM'))) + decode(to_char(start_date,'DD'),'01',0,(last_day(start_date)+1-start_date)/to_number(to_char(last_day(start_date),'DD'))-1) + decode(to_char(expiration_date,'DD'),to_char(last_day(expiration_date),'DD'),0, to_number(to_char(expiration_date,'DD'))/to_number(to_char(last_day(expiration_date),'DD'))-1)
       ) option_duration,
 decode(nvl(xlc.liability_flag,pta.liability_flag), 'Y', 'Yes', 'No') option_liability_flag,
 decode(nvl(xlc.rou_asset_flag,pta.rou_asset_flag), 'Y', 'Yes', 'No') option_rou_asset_flag,
 decode(nvl(xlc.rept_inception_flag,pta.rept_inception_flag), 'Y', 'Yes', 'No') option_rept_inception_flag,
 pta.schedule_day option_schedule_day,
 (select meaning from fnd_lookups where lookup_type = 'PN_PAYMENT_FREQUENCY_TYPE' and lookup_code = frequency_code) option_frequency,
 xxen_pn.get_lease_rate_value(pta.lease_id) option_rate_value,
 xxen_pn.get_lease_accounting_method(pta.lease_id) opt_accounting_method,
 xxen_pn.get_option_initial_rate(pta.lease_id,pta.option_id,xxen_pn.get_as_of_date(pta.lease_id)) option_initial_rate,
 xxen_pn.get_option_discount_rate(pta.lease_id,pta.option_id,xxen_pn.get_as_of_date(pta.lease_id)) option_discount_rate,
 peaa.asset_number asset_number
from
 pn_eqp_options_all pta,
 (select
   plc.lease_id,
   plc.payment_term_id,
   plc.option_id,
   plc.option_end_date,
   plc.payment_end_date,
   plc.liability_flag,
   plc.rou_asset_flag,
   plc.rept_inception_flag,
   decode(pn_streams_util.get_daily_flag(pla.org_id,'EQUIPMENT'),'N',last_day(trunc(plc.creation_date) ),pn_streams_util .last_day_period(plc.creation_date,pla.org_id) ) as_of_date,
   plc.creation_date,
   max(plc.creation_date) over( partition by plc.payment_term_id,plc.option_id,plc.lease_id order by 1 ) max_creation_date
  from
   pn_eqp_lease_chg_details plc,
   pn_eqp_leases_all pla
  where
      pla.lease_id = plc.lease_id
  and trunc(xxen_pn.get_as_of_date(pla.lease_id)) >= decode(pn_streams_util.get_daily_flag(pla.org_id,'EQUIPMENT'),'N',last_day(trunc(plc.creation_date) ),pn_streams_util .last_day_period(plc.creation_date,pla.org_id) )
 ) xlc,
 pn_eqp_assets_all peaa
where
    pta.option_id = xlc.option_id(+)
and nvl(xlc.creation_date,sysdate) = nvl(xlc.max_creation_date,sysdate)
and pta.asset_id=peaa.asset_id(+)
and trunc(xxen_pn.get_as_of_date(xlc.lease_id)) >= nvl(trunc(xlc.as_of_date),trunc(xxen_pn.get_as_of_date(xlc.lease_id)))
),
--
--q_option_items_pv -- Lease Option Payment Items PV
--
q_option_items_pv as
(
select
 lease_id,
 option_id,
 due_date option_due_date,
 pmt_days option_pmt_days,
 actual_amount_rou option_actual_amount_rou,
 actual_amount_liability option_actual_amount_liability,
 discount_rate option_discount_rate,
 pv_rou option_pv_rou,
 pv_liability option_pv_liability
from
 (select
   lease_id,
   option_id,
   due_date,
   pmt_days,
   actual_amount_rou,
   actual_amount_liability,
   discount_rate,
   pv_rou,
   pv_liability
  from
   pn_pmt_item_pv_all
  where
      trunc(as_of_date) = trunc(xxen_pn.get_as_of_date(lease_id))
  and (   nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(lease_id))) >= trunc(xxen_pn.get_as_of_date(lease_id))
       or pn_system_pub.get_frozen_flag (:p_org_id) = 'N'
      )
  union all
  select
   lease_id,
   option_id,
   due_date,
   pmt_days,
   actual_amount_rou,
   actual_amount_liability,
   discount_rate,
   pv_rou,
   pv_liability
  from
   pn_pmt_item_pv_hist
  where
      trunc(as_of_date) = trunc(xxen_pn.get_as_of_date(lease_id))
  and (   nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(lease_id))) >= trunc(xxen_pn.get_as_of_date(lease_id))
       or pn_system_pub.get_frozen_flag (:p_org_id) = 'N'
      )
  union all
  select
   lease_id,
   option_id,
   due_date,
   pmt_days,
   actual_amount_rou,
   actual_amount_liability,
   discount_rate,
   pv_rou,
   pv_liability
  from
   (select
     pvhist.*,
     dense_rank() over (partition by lease_id,option_id order by as_of_date desc) rnk
    from
     pn_pmt_item_pv_hist pvhist
   ) hist
  where
      rnk = 1
  and (   nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(hist.lease_id))) >= trunc(xxen_pn.get_as_of_date(hist.lease_id))
       or pn_system_pub.get_frozen_flag (:p_org_id) = 'N'
      )
  and not exists (select 1 from pn_pmt_item_pv_hist where lease_id = hist.lease_id and trunc(as_of_date) = trunc(xxen_pn.get_as_of_date(hist.lease_id)))
  and not exists (select 1 from pn_pmt_item_pv_all where lease_id = hist.lease_id and trunc(as_of_date) = trunc(xxen_pn.get_as_of_date(hist.lease_id)))
  union all
  select
   t.lease_id,
   t.option_id,
   t.due_date,
   t.pmt_days,
   t.actual_amount_rou,
   t.actual_amount_liability,
   t.discount_rate,
   t.pv_rou,
   t.pv_liability
  from
   (select
     pips.due_date,
     pips.pmt_days,
     pips.actual_amount_rou,
     pips.actual_amount_liability,
     pips.discount_rate,
     pips.pv_rou,
     pips.pv_liability,
     pips.stream_version,
     pips.as_of_date,
     pips.option_id,
     pips.lease_id,
     max(to_number(pips.stream_version)) over(partition by pips.lease_id,pips.option_id) max_stream_version
    from
     pn_pmt_item_pv_stream_all pips,
     pn_leases_all pl
    where
        pips.lease_id=pl.lease_id
    and trunc(pips.as_of_date) <= trunc(xxen_pn.get_as_of_date(pl.lease_id))
    and nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(pl.lease_id))) < trunc(xxen_pn.get_as_of_date(pl.lease_id))
   ) t
  where
      trunc(t.as_of_date) <= trunc(xxen_pn.get_as_of_date(t.lease_id))
  and nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(t.lease_id))) < trunc(xxen_pn.get_as_of_date(t.lease_id))
  and pn_system_pub.get_frozen_flag (:p_org_id) = 'Y'
  and t.stream_version = t.max_stream_version
  union all
  select
   t.lease_id,
   t.option_id,
   t.due_date,
   t.pmt_days,
   t.actual_amount_rou,
   t.actual_amount_liability,
   t.discount_rate,
   t.pv_rou,
   t.pv_liability
  from
   (select
     pips.due_date,
     pips.pmt_days,
     pips.actual_amount_rou,
     pips.actual_amount_liability,
     pips.discount_rate,
     pips.pv_rou,
     pips.pv_liability,
     pips.stream_version,
     pips.as_of_date,
     pips.option_id,
     pips.lease_id,
     max(to_number(pips.stream_version)) over(partition by pips.lease_id,pips.option_id) max_stream_version
    from
     pn_pmt_item_pv_stream_all pips,
     pn_eqp_leases_all pel
    where
        pips.lease_id=pel.lease_id
    and trunc(pips.as_of_date) <= trunc(xxen_pn.get_as_of_date(pel.lease_id))
   ) t
  where
      trunc(t.as_of_date) <= trunc(xxen_pn.get_as_of_date(t.lease_id))
  and t.stream_version = t.max_stream_version
 )
),
--
--q_options_amort -- Lease Options Amortization
--
q_options_amort as
(
select
 lease_id,
 option_id,
 period_date opt_period_date,
 sum(nvl(rou_bal_start_us_opr,0)) opt_rou_bal_start_us_opr,
 sum(nvl(rou_amrtztn_amt_us_opr,0)) opt_rou_amrtztn_amt_us_opr,
 sum(nvl(rou_bal_end_us_opr,0)) opt_rou_bal_end_us_opr,
 sum(nvl(lia_bal_start,0)) opt_lia_bal_start,
 sum(nvl(actual_pmt_amt,0)) opt_lease_payment,
 sum(nvl(lia_intrst_amt,0)) opt_interest_expense,
 sum(nvl(lia_bal_end,0)) opt_lia_bal_end,
 sum(nvl(exp_amt,0)) opt_lease_expense,
 sum(nvl(rou_bal_start_fin,0)) opt_rou_bal_start_fin,
 sum(nvl(rou_bal_end_fin,0)) opt_rou_bal_end_fin,
 sum(nvl(rou_amrtztn_amt_fin,0)) opt_rou_amrtztn_amt_fin,
 max(nvl(discount_rate,0)) opt_irr_rate,
 sum(nvl(rou_adj_fin,0)) opt_rou_adj_fin,
 sum(nvl(lia_adj_fin,0)) opt_lia_adj_fin,
 sum(nvl(gain_loss_fin,0)) opt_gain_loss_fin,
 sum(nvl(rou_adj_us_opr,0)) opt_rou_adj_us_opr,
 sum(nvl(lia_adj_us_opr,0)) opt_lia_adj_us_opr,
 sum(nvl(gain_loss_us_opr,0)) opt_gain_loss_us_opr
from
 (select
   lease_id,
   option_id,
   period_date,
   rou_bal_start_us_opr,
   rou_amrtztn_amt_us_opr,
   rou_bal_end_us_opr,
   lia_bal_start,
   actual_pmt_amt,
   lia_intrst_amt,
   lia_bal_end,
   decode(pn_transaction_util.get_liab_only_flag(payment_term_id,option_id),'Y',lia_intrst_amt,exp_amt) exp_amt,
   rou_bal_start_fin,
   rou_bal_end_fin,
   rou_amrtztn_amt_fin,
   discount_rate,
   null rou_adj_fin,
   null lia_adj_fin,
   null gain_loss_fin,
   null rou_adj_us_opr,
   null lia_adj_us_opr,
   null gain_loss_us_opr
  from
   pn_pmt_item_amrtzn_all
  where
      trunc(as_of_date) = trunc(xxen_pn.get_as_of_date(lease_id) )
  and (   nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(lease_id) ) ) >= trunc(xxen_pn.get_as_of_date(lease_id))
       or pn_system_pub.get_frozen_flag(:p_org_id) = 'N'
      )
  union
  select
   lease_id,
   option_id,
   period_date,
   rou_bal_start_us_opr,
   rou_amrtztn_amt_us_opr,
   rou_bal_end_us_opr,
   lia_bal_start,
   actual_pmt_amt,
   lia_intrst_amt,
   lia_bal_end,
   decode(pn_transaction_util.get_liab_only_flag(payment_term_id,option_id),'Y',lia_intrst_amt,exp_amt) exp_amt,
   rou_bal_start_fin,
   rou_bal_end_fin,
   rou_amrtztn_amt_fin,
   discount_rate,
   null rou_adj_fin,
   null lia_adj_fin,
   null gain_loss_fin,
   null rou_adj_us_opr,
   null lia_adj_us_opr,
   null gain_loss_us_opr
  from
   pn_pmt_item_amrtzn_hist
  where
      trunc(as_of_date) = trunc(xxen_pn.get_as_of_date(lease_id) )
  and (   nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(lease_id) ) ) >= trunc(xxen_pn.get_as_of_date(lease_id))
       or pn_system_pub.get_frozen_flag(:p_org_id) = 'N'
      )
  union
  select
   lease_id,
   option_id,
   period_date,
   rou_bal_start_us_opr,
   rou_amrtztn_amt_us_opr,
   rou_bal_end_us_opr,
   lia_bal_start,
   actual_pmt_amt,
   lia_intrst_amt,
   lia_bal_end,
   decode(pn_transaction_util.get_liab_only_flag(hist.payment_term_id,hist.option_id),'Y',lia_intrst_amt,exp_amt) exp_amt,
   rou_bal_start_fin,
   rou_bal_end_fin,
   rou_amrtztn_amt_fin,
   discount_rate,
   null rou_adj_fin,
   null lia_adj_fin,
   null gain_loss_fin,
   null rou_adj_us_opr,
   null lia_adj_us_opr,
   null gain_loss_us_opr
  from
   (select
     amrthist.*,
     dense_rank() over( partition by lease_id,option_id order by as_of_date desc ) rnk
    from
     pn_pmt_item_amrtzn_hist amrthist
   ) hist
  where
      rnk = 1
  and (   nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(hist.lease_id) ) ) >= trunc(xxen_pn.get_as_of_date(hist.lease_id))
       or pn_system_pub.get_frozen_flag(:p_org_id) = 'N'
      )
  and not exists (select 1 from pn_pmt_item_amrtzn_hist where lease_id =hist.lease_id and trunc(as_of_date) = trunc(xxen_pn.get_as_of_date(hist.lease_id) ) )
  and not exists (select 1 from pn_pmt_item_amrtzn_all where lease_id =hist.lease_id and trunc(as_of_date) = trunc(xxen_pn.get_as_of_date(hist.lease_id) ) )
  union
  select
   lease_id,
   option_id,
   stream_date period_date,
   rou_gaap_beg_amount rou_bal_start_us_opr,
   amor_gaap_amount rou_amrtztn_amt_us_opr,
   rou_gaap_amount rou_bal_end_us_opr,
   lib_ifrs_beg_amount lia_bal_start,
   cash_ifrs_amount actual_pmt_amt,
   interest_ifrs_amount lia_intrst_amt,
   lib_ifrs_amount lia_bal_end,
   expense_gaap_amount exp_amt,
   rou_ifrs_beg_amount rou_bal_start_fin,
   rou_ifrs_amount rou_bal_end_fin,
   amor_ifrs_amount rou_amrtztn_amt_fin,
   discount_rate,
   null rou_adj_fin,
   null lia_adj_fin,
   null gain_loss_fin,
   null rou_adj_us_opr,
   null lia_adj_us_opr,
   null gain_loss_us_opr
  from
   (select
     t.lease_id,
     t.payment_term_id,
     t.option_id,
     t.stream_version,
     t.stream_date,
     t.as_of_date,
     t.rou_ifrs_amount,
     t.rou_gaap_amount,
     t.rou_ifrs_beg_amount,
     t.rou_gaap_beg_amount,
     t.lib_ifrs_beg_amount,
     t.cash_ifrs_amount,
     t.lib_ifrs_amount,
     t.interest_ifrs_amount,
     t.amor_ifrs_amount,
     t.amor_gaap_amount,
     decode(pn_transaction_util.get_liab_only_flag(t.payment_term_id,t.option_id),'Y' ,t.interest_ifrs_amount,t.expense_gaap_amount) expense_gaap_amount,
     max(to_number(t.stream_version)) over( partition by t.lease_id,t.option_id ) max_stream_version,
     t.discount_rate
    from
     pn_pmt_item_amrtzn_stream_v t,
     pn_leases_all pl
    where
        t.lease_id = pl.lease_id
    and nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(pl.lease_id) ) ) < trunc (xxen_pn.get_as_of_date(pl.lease_id))
    and t.as_of_date <= trunc(xxen_pn.get_as_of_date(pl.lease_id) )
   ) a
  where
      a.as_of_date <= trunc(xxen_pn.get_as_of_date(a.lease_id) )
  and a.stream_version = a.max_stream_version
  and nvl(pn_transaction_util.get_transition_date(:p_org_id),trunc(xxen_pn.get_as_of_date(a.lease_id) ) ) < trunc(xxen_pn.get_as_of_date(a.lease_id))
  and pn_system_pub.get_frozen_flag (:p_org_id) = 'Y'
  union
  select
   lease_id,
   option_id,
   stream_date period_date,
   rou_gaap_beg_amount rou_bal_start_us_opr,
   amor_gaap_amount rou_amrtztn_amt_us_opr,
   rou_gaap_amount rou_bal_end_us_opr,
   lib_ifrs_beg_amount lia_bal_start,
   cash_ifrs_amount actual_pmt_amt,
   interest_ifrs_amount lia_intrst_amt,
   lib_ifrs_amount lia_bal_end,
   expense_gaap_amount exp_amt,
   rou_ifrs_beg_amount rou_bal_start_fin,
   rou_ifrs_amount rou_bal_end_fin,
   amor_ifrs_amount rou_amrtztn_amt_fin,
   discount_rate,
   null rou_adj_fin,
   null lia_adj_fin,
   null gain_loss_fin,
   null rou_adj_us_opr,
   null lia_adj_us_opr,
   null gain_loss_us_opr
  from
   (select
     t.lease_id,
     t.payment_term_id,
     t.option_id,
     t.stream_version,
     t.stream_date,
     t.as_of_date,
     t.rou_ifrs_amount,
     t.rou_gaap_amount,
     t.rou_ifrs_beg_amount,
     t.rou_gaap_beg_amount,
     t.lib_ifrs_beg_amount,
     t.cash_ifrs_amount,
     t.lib_ifrs_amount,
     t.interest_ifrs_amount,
     t.amor_ifrs_amount,
     t.amor_gaap_amount,
     decode(pn_transaction_util.get_liab_only_flag(t.payment_term_id,t.option_id),'Y' ,t.interest_ifrs_amount,t.expense_gaap_amount) expense_gaap_amount,
     max(to_number(t.stream_version)) over( partition by t.lease_id,t.option_id ) max_stream_version,
     t.discount_rate
    from
     pn_pmt_item_amrtzn_stream_v t,
     pn_eqp_leases_all pel
    where
        t.lease_id = pel.lease_id
    and t.as_of_date <= trunc(xxen_pn.get_as_of_date(pel.lease_id) )
   ) a
  where
      a.as_of_date <= trunc(xxen_pn.get_as_of_date(a.lease_id) )
  and a.stream_version = a.max_stream_version
  union
  select
   lease_id,
   option_id,
   as_of_date period_date,
   null rou_bal_start_us_opr,
   null rou_amrtztn_amt_us_opr,
   null rou_bal_end_us_opr,
   null lia_bal_start,
   null actual_pmt_amt,
   null lia_intrst_amt,
   null lia_bal_end,
   null exp_amt,
   null rou_bal_start_fin,
   null rou_bal_end_fin,
   null rou_amrtztn_amt_fin,
   null discount_rate,
   rou_adj_fin,
   lia_adj_fin,
   gain_loss_fin,
   rou_adj_us_opr,
   decode(lia_adj_gaap, null, lia_adj_fin, lia_adj_gaap) lia_adj_us_opr,
   gain_loss_us_opr
  from
   (select
     lease_id,
     option_id,
     as_of_date,
     sum(decode(regime_code,'IFRS16',decode(stream_type_code,'ROU',nvl(entered_amount,0)) ) ) rou_adj_fin,
     sum(decode(regime_code,'IFRS16',decode(stream_type_code,'LIABILITY',nvl(entered_amount,0)) ) ) lia_adj_fin,
     sum(decode(regime_code,'IFRS16',decode(stream_type_code,'GAIN',nvl(entered_amount,0),'LOSS',nvl(entered_amount,0)) ) ) gain_loss_fin,
     sum(decode(regime_code,'ASC842',decode(stream_type_code,'ROU',nvl(entered_amount,0)) ) ) rou_adj_us_opr,
     sum(decode(regime_code,'ASC842',decode(stream_type_code,'LIABILITY', entered_amount) ) ) lia_adj_gaap,
     sum(decode(regime_code,'ASC842',decode(stream_type_code,'GAIN',nvl(entered_amount,0),'LOSS',nvl(entered_amount,0)) ) ) gain_loss_us_opr
    from
     (select
       pnactth.lease_id,
       pnactth.regime_code,
       pnacttl.payment_term_id,
       pnacttl.option_id,
       pnactth.transaction_date,
       decode(pn_streams_util.get_daily_flag(pnactth.org_id),'N',last_day(trunc(pnactth.transaction_date) ) ,pn_streams_util.last_day_period(pnactth.transaction_date,pnactth.org_id) ) as_of_date,
       pnacttl.entered_amount,
       pnacttl.stream_type_code
      from
       pn_acct_trx_headers_all pnactth,
       pn_acct_trx_lines_all pnacttl
      where
          pnacttl.transaction_id = pnactth.acct_transaction_id
      and pnactth.transaction_type in ( 'REVISION', 'TERMINATION' )
      and pnacttl.stream_type_code in ( 'ROU', 'LIABILITY', 'GAIN', 'LOSS' )
      and exists (select
                   1
                  from
                   pn_acct_trx_headers_all pnactth1,
                   pn_acct_trx_lines_all pnacttl1
                  where
                      pnactth1.lease_id =pnactth.lease_id
                  and pnactth1.lease_id = pnactth.lease_id
                  and pnacttl1.transaction_id = pnactth1.acct_transaction_id
                  and pnacttl1.option_id = pnacttl.option_id
                  and pnacttl1.option_id =pnacttl.option_id
                  and pnactth1.acct_transaction_id <> pnactth.acct_transaction_id
                  and pnactth1.regime_code = pnactth.regime_code
                  and pnactth1.transaction_type <> 'ACCRUAL'
                 )
       and not exists (select
          'x'
         from
          pn_lease_chg_details_all_v plcd,
          pn_streams_all psa,
          pn_stream_lines_all psal
         where
          plcd.lease_change_id = psa.lease_change_id
       and plcd.option_id = psa.option_id
       and psal.stream_header_id = psa.stream_header_id
       and psal.transaction_line_id = pnacttl.transaction_line_id
       and plcd.lease_change_event in ( 'ADD_OPTION','RI','VRI','OPEX') )
      ) a
    group by
     lease_id,
     option_id,
     as_of_date
   ) b
)
group by
 lease_id,
 option_id,
 period_date
)
--
-- =================================
-- Main Query Starts Here
-- =================================
--
select /*+ push_pred */
 x.record_type,
 x.legal_entity,
 x.ledger,
 x.operating_unit,
 x.functional_currency,
 x.report_as_of_period,
 x.report_to_date,
 x.report_status,
 x.lease_num,
 x.lease_name,
 x.lease_category,
 -- lease details
 trunc(x.lease_commencement_date) lease_commencement_date,
 trunc(x.lease_termination_date)  lease_termination_date,
 x.duration_in_months,
 x.days_convention,
 x.interest_rate * 100    interest_rate_pct,
 x.representation,
 x.source,
 -- lease report
 x.period                 period,
 case when x.period is not null and x.period_start_date is null
 then trunc(x.lease_termination_date)
 else x.period_start_date
 end                      period_start_date,
 x.liability              period_liability,
 x.cash                   period_cash,
 x.interest_accrual       period_interest_accrual,
 x.rou_asset_fin          period_fin_rou_asset,
 x.rou_amort_expense_fin  period_fin_rou_amort_expense,
 x.rou_asset_opr          period_opr_rou_asset,
 x.rou_amort_expense_opr  period_opr_rou_amort_expense,
 x.lease_expense_opr      period_opr_lease_expense,
 x.currency               period_currency,
 -- payment term/option
 x.trm_or_opt,
 x.trm_opt_purpose,
 x.trm_opt_type,
 x.trm_opt_actual_amount,
 trunc(x.trm_opt_start_date) trm_opt_start_date,
 trunc(x.trm_opt_end_date) trm_opt_end_date,
 x.trm_opt_duration_months,
 x.trm_opt_liability,
 x.trm_opt_rou,
 x.trm_opt_report_from_inception,
 x.trm_opt_schedule_day,
 x.trm_opt_frequency,
 x.trm_opt_currency,
 x.trm_opt_asset_number,
 x.trm_opt_previous_interest_rate * 100 trm_opt_prev_interest_rate_pct,
 x.trm_opt_interest_rate * 100 trm_opt_interest_rate_pct,
 case
 when x.record_type = 'Payment Term / Option'
 then case
      when x.trm_or_opt = 'Payment Term' then sum(x.pay_item_liability_pv) over (partition by x.payment_term_id)
      when x.trm_or_opt = 'Option'       then sum(x.pay_item_liability_pv) over (partition by x.option_id)
      else null
      end
 else null
 end trm_opt_lease_liab_begin_bal,
 case
 when x.record_type = 'Payment Term / Option'
 then case
      when x.trm_or_opt = 'Payment Term' then sum(x.pay_item_rou_pv) over (partition by x.payment_term_id)
      when x.trm_or_opt = 'Option'       then sum(x.pay_item_rou_pv) over (partition by x.option_id)
      else null
      end
 else null
 end trm_opt_rou_asset_begin_bal,
 -- present value (pv)
 x.pay_as_of_date "Payment/As Of Date",
 --
 x.pay_item_days payment_days,
 x.pay_item_rate payment_rate,
 x.pay_item_rou_payment payment_rou,
 x.pay_item_rou_pv payment_rou_pv,
 x.pay_item_liability_payment payment_liability,
 x.pay_item_liability_pv payment_liability_pv,
 -- amortization
 x.amort_fin_rou_begin_balance,
 x.amort_fin_rou_amortization,
 x.amort_fin_rou_adjustmt_reserve,
 x.amort_fin_gain_loss,
 x.amort_fin_rou_end_balance,
 x.amort_opr_rou_begin_balance,
 x.amort_opr_rou_amortization,
 x.amort_opr_rou_adjustmt_reserve,
 x.amort_opr_gain_loss,
 x.amort_opr_rou_end_balance,
 x.amort_liability_begin_balance,
 x.amort_payment,
 x.amort_irr_rate,
 x.amort_interest_expense,
 x.amort_fin_liability_adjustment,
 x.amort_opr_liability_adjustment,
 x.amort_liability_end_balance,
 x.amort_lease_expense,
 --
 x.accounting_method,
 x.lease_id,
 x.payment_term_id,
 x.option_id
from
(
--Q1 Lease Detail
select
 1                               record_seq,
 'Lease'                         record_type,
 :p_legal_entity                 legal_entity,
 :p_ledger_name                  ledger,
 :p_org_name                     operating_unit,
 :p_functional_currency          functional_currency,
 :p_as_of_period                 report_as_of_period,
 :p_to_date                      report_to_date,
 ql.report_status,
 ql.lease_num,
 ql.lease_name,
 ql.lease_category,
 -- lease details
 qld.lease_commencement_date,
 qld.lease_termination_date,
 qld.duration_in_months,
 qld.payment_term_proration_rule days_convention,
 qld.accounting_method,
 ql.lease_discount_rate          interest_rate,
 qld.lease_representation        representation,
 qld.lease_source                source,
 -- lease report
 null                            period,
 to_date(null)                   period_start_date,
 to_number(null)                 liability,
 to_number(null)                 cash,
 to_number(null)                 interest_accrual,
 to_number(null)                 rou_asset_fin,
 to_number(null)                 rou_amort_expense_fin,
 to_number(null)                 rou_asset_opr,
 to_number(null)                 rou_amort_expense_opr,
 to_number(null)                 lease_expense_opr,
 null                            currency,
 -- payment term/option
 null                            trm_or_opt,
 null                            trm_opt_purpose,
 null                            trm_opt_type,
 to_number(null)                 trm_opt_actual_amount,
 to_date(null)                   trm_opt_start_date,
 to_date(null)                   trm_opt_end_date,
 to_number(null)                 trm_opt_duration_months,
 null                            trm_opt_liability,
 null                            trm_opt_rou,
 null                            trm_opt_report_from_inception,
 to_number(null)                 trm_opt_schedule_day,
 to_number(null)                 trm_opt_frequency,
 null                            trm_opt_currency,
 null                            trm_opt_asset_number,
 to_number(null)                 trm_opt_previous_interest_rate,
 to_number(null)                 trm_opt_interest_rate,
 -- present value (pv)
 to_date(null)                   pay_as_of_date,
 to_number(null)                 pay_item_days,
 to_number(null)                 pay_item_rate,
 to_number(null)                 pay_item_rou_payment,
 to_number(null)                 pay_item_rou_pv,
 to_number(null)                 pay_item_liability_payment,
 to_number(null)                 pay_item_liability_pv,
 -- amortization
 to_number(null)                 amort_fin_rou_begin_balance,
 to_number(null)                 amort_fin_rou_amortization,
 to_number(null)                 amort_fin_rou_adjustmt_reserve,
 to_number(null)                 amort_fin_gain_loss,
 to_number(null)                 amort_fin_rou_end_balance,
 to_number(null)                 amort_opr_rou_begin_balance,
 to_number(null)                 amort_opr_rou_amortization,
 to_number(null)                 amort_opr_rou_adjustmt_reserve,
 to_number(null)                 amort_opr_gain_loss,
 to_number(null)                 amort_opr_rou_end_balance,
 to_number(null)                 amort_liability_begin_balance,
 to_number(null)                 amort_payment,
 to_number(null)                 amort_irr_rate,
 to_number(null)                 amort_interest_expense,
 to_number(null)                 amort_fin_liability_adjustment,
 to_number(null)                 amort_opr_liability_adjustment,
 to_number(null)                 amort_liability_end_balance,
 to_number(null)                 amort_lease_expense,
 --
 qld.lease_id                    lease_id,
 to_number(null)                 payment_term_id,
 to_number(null)                 option_id
from
 q_lease         ql,
 q_lease_detail  qld
where
    ql.lease_id  = qld.lease_id
union all
-- Q2 Lease Report
select
 2                               record_seq,
 'Period Summary'                record_type,
 :p_legal_entity,
 :p_ledger_name,
 :p_org_name,
 :p_functional_currency,
 :p_as_of_period,
 :p_to_date,
 ql.report_status,
 ql.lease_num,
 ql.lease_name,
 ql.lease_category,
 -- lease details
 qld.lease_commencement_date,
 qld.lease_termination_date,
 qld.duration_in_months,
 qld.payment_term_proration_rule,
 qld.accounting_method,
 ql.lease_discount_rate,
 qld.lease_representation,
 qld.lease_source,
 -- lease report
 qlr.period,
 qlr.period_start_date,
 qlr.liability,
 qlr.cash,
 qlr.interest_accrual,
 qlr.rou_asset_fin               fin_rou_asset,
 qlr.rou_amort_fin               fin_rou_amort_expense,
 qlr.rou_asset_opr               opr_rou_asset,
 qlr.rou_amort_opr               opr_rou_amort_expense,
 qlr.lease_expenses              opr_lease_expense,
 qlr.currency,
 -- payment term / option
 null                            trm_or_opt,
 null                            trm_opt_purpose,
 null                            trm_opt_type,
 to_number(null)                 trm_opt_actual_amount,
 to_date(null)                   trm_opt_start_date,
 to_date(null)                   trm_opt_end_date,
 to_number(null)                 trm_opt_duration_months,
 null                            trm_opt_liability,
 null                            trm_opt_rou,
 null                            trm_opt_report_from_inception,
 to_number(null)                 trm_opt_schedule_day,
 to_number(null)                 trm_opt_frequency,
 null                            trm_opt_currency,
 null                            trm_opt_asset_number,
 to_number(null)                 trm_opt_previous_interest_rate,
 to_number(null)                 trm_opt_interest_rate,
 -- present value (pv)
 qlr.period_start_date           pay_as_of_date,
 to_number(null)                 pay_item_days,
 to_number(null)                 pay_item_rate,
 to_number(null)                 pay_item_rou_payment,
 to_number(null)                 pay_item_rou_pv,
 to_number(null)                 pay_item_liability_payment,
 to_number(null)                 pay_item_liability_pv,
 -- amortization
 to_number(null)                 amort_fin_rou_begin_balance,
 to_number(null)                 amort_fin_rou_amortization,
 to_number(null)                 amort_fin_rou_adjustmt_reserve,
 to_number(null)                 amort_fin_gain_loss,
 to_number(null)                 amort_fin_rou_end_balance,
 to_number(null)                 amort_opr_rou_begin_balance,
 to_number(null)                 amort_opr_rou_amortization,
 to_number(null)                 amort_opr_rou_adjustmt_reserve,
 to_number(null)                 amort_opr_gain_loss,
 to_number(null)                 amort_opr_rou_end_balance,
 to_number(null)                 amort_liability_begin_balance,
 to_number(null)                 amort_payment,
 to_number(null)                 amort_irr_rate,
 to_number(null)                 amort_interest_expense,
 to_number(null)                 amort_fin_liability_adjustment,
 to_number(null)                 amort_opr_liability_adjustment,
 to_number(null)                 amort_liability_end_balance,
 to_number(null)                 amort_lease_expense,
 --
 qld.lease_id                    lease_id,
 to_number(null)                 payment_term_id,
 to_number(null)                 option_id
from
 q_lease         ql,
 q_lease_detail  qld,
 q_lease_report  qlr
where
    ql.lease_id = qld.lease_id
and ql.lease_id = qlr.lease_id
and :p_incl_lease_report is not null
union all
-- Q3 Payment Terms
select
 3                               record_seq,
 'Payment Term / Option'         record_type,
 :p_legal_entity,
 :p_ledger_name,
 :p_org_name operating_unit,
 :p_functional_currency,
 :p_as_of_period,
 :p_to_date,
 ql.report_status,
 ql.lease_num,
 ql.lease_name,
 ql.lease_category,
 -- lease detail
 qld.lease_commencement_date,
 qld.lease_termination_date,
 qld.duration_in_months,
 qld.payment_term_proration_rule,
 qld.accounting_method,
 ql.lease_discount_rate,
 qld.lease_representation,
 qld.lease_source,
 -- lease report
 null                            period,
 to_date(null)                   period_start_date,
 to_number(null)                 liability,
 to_number(null)                 cash,
 to_number(null)                 interest_accrual,
 to_number(null)                 rou_asset_fin,
 to_number(null)                 rou_amort_expense_fin,
 to_number(null)                 rou_asset_opr,
 to_number(null)                 rou_amort_expense_opr,
 to_number(null)                 lease_expense_opr,
 null                            currency,
 -- payment term / option
 'Payment Term'                  trm_or_opt,
 qpt.payment_purpose             trm_opt_purpose,
 qpt.payment_type                trm_opt_type,
 qpt.actual_amount               trm_opt_actual_amount,
 qpt.start_date                  trm_opt_start_date,
 qpt.end_date                    trm_opt_end_date,
 qpt.duration                    trm_opt_duration_months,
 qpt.liability_flag              trm_opt_liability,
 qpt.rou_asset_flag              trm_opt_rou,
 qpt.rept_inception_flag         trm_opt_report_from_inception,
 qpt.schedule_day                trm_opt_schedule_day,
 qpt.payment_frequency           trm_opt_frequency,
 qpt.payment_currency            trm_opt_currency,
 qpt.asset_number                trm_opt_asset_number,
 case
 when qpt.term_initial_rate = -99999 and qpt.rept_inception_flag = 'Yes'
 then (select distinct first_value(qpip2.discount_rate) ignore nulls over (order by qpip2.due_date) from q_payment_items_pv qpip2 where qpip2.lease_id = qpt.lease_id and qpip2.payment_term_id = qpt.payment_term_id)
 else case qpt.term_initial_rate when -99999 then qpt.term_discount_rate else qpt.term_initial_rate end
 end                             trm_opt_previous_interest_rate,
 qpt.term_discount_rate          trm_opt_interest_rate,
 -- present value (pv)
 to_date(null)                   pay_as_of_date,
 to_number(null)                 pay_item_days,
 to_number(null)                 pay_item_rate,
 to_number(null)                 pay_item_rou_payment,
 to_number(null)                 pay_item_rou_pv,
 to_number(null)                 pay_item_liability_payment,
 to_number(null)                 pay_item_liability_pv,
 -- amortization
 to_number(null)                 amort_fin_rou_begin_balance,
 to_number(null)                 amort_fin_rou_amortization,
 to_number(null)                 amort_fin_rou_adjustmt_reserve,
 to_number(null)                 amort_fin_gain_loss,
 to_number(null)                 amort_fin_rou_end_balance,
 to_number(null)                 amort_opr_rou_begin_balance,
 to_number(null)                 amort_opr_rou_amortization,
 to_number(null)                 amort_opr_rou_adjustmt_reserve,
 to_number(null)                 amort_opr_gain_loss,
 to_number(null)                 amort_opr_rou_end_balance,
 to_number(null)                 amort_liability_begin_balance,
 to_number(null)                 amort_payment,
 to_number(null)                 amort_irr_rate,
 to_number(null)                 amort_interest_expense,
 to_number(null)                 amort_fin_liability_adjustment,
 to_number(null)                 amort_opr_liability_adjustment,
 to_number(null)                 amort_liability_end_balance,
 to_number(null)                 amort_lease_expense,
 --
 qld.lease_id                    lease_id,
 qpt.payment_term_id             payment_term_id,
 to_number(null)                 option_id
from
 q_lease         ql,
 q_lease_detail  qld,
 q_payment_terms qpt
where
    ql.lease_id = qld.lease_id
and ql.lease_id = qpt.lease_id
union all
-- Q4 Payment Term Items PV
select
 4                               record_seq,
 'Payment Schedule'              record_type,
 :p_legal_entity,
 :p_ledger_name,
 :p_org_name,
 :p_functional_currency,
 :p_as_of_period,
 :p_to_date,
 ql.report_status,
 ql.lease_num,
 ql.lease_name,
 ql.lease_category,
 -- lease detail
 qld.lease_commencement_date,
 qld.lease_termination_date,
 qld.duration_in_months,
 qld.payment_term_proration_rule,
 qld.accounting_method,
 ql.lease_discount_rate,
 qld.lease_representation,
 qld.lease_source,
 -- lease report
 null                            period,
 to_date(null)                   period_start_date,
 to_number(null)                 liability,
 to_number(null)                 cash,
 to_number(null)                 interest_accrual,
 to_number(null)                 rou_asset_fin,
 to_number(null)                 rou_amort_expense_fin,
 to_number(null)                 rou_asset_opr,
 to_number(null)                 rou_amort_expense_opr,
 to_number(null)                 lease_expense_opr,
 null                            currency,
 -- payment term / option
 'Payment Term'                  trm_or_opt,
 qpt.payment_purpose             trm_opt_purpose,
 qpt.payment_type                trm_opt_type,
 to_number(null)                 trm_opt_actual_amount,
 qpt.start_date                  trm_opt_start_date,
 qpt.end_date                    trm_opt_end_date,
 qpt.duration                    trm_opt_duration_months,
 qpt.liability_flag              trm_opt_liability,
 qpt.rou_asset_flag              trm_opt_rou,
 qpt.rept_inception_flag         trm_opt_report_from_inception,
 qpt.schedule_day                trm_opt_schedule_day,
 qpt.payment_frequency           trm_opt_frequency,
 qpt.payment_currency            trm_opt_currency,
 qpt.asset_number                trm_opt_asset_number,
 case
 when qpt.term_initial_rate = -99999 and qpt.rept_inception_flag = 'Yes'
 then (select distinct first_value(qpip2.discount_rate) ignore nulls over (order by qpip2.due_date) from q_payment_items_pv qpip2 where qpip2.lease_id = qpt.lease_id and qpip2.payment_term_id = qpt.payment_term_id)
 else case qpt.term_initial_rate when -99999 then qpt.term_discount_rate else qpt.term_initial_rate end
 end                             trm_opt_previous_interest_rate,
 qpt.term_discount_rate          trm_opt_interest_rate,
 -- present value (pv)
 qpip.due_date                   pay_as_of_date,
 qpip.pmt_days                   pay_item_days,
 qpip.discount_rate              pay_item_rate,
 nvl(qpip.actual_amount_rou,0)   pay_item_rou_payment,
 nvl(qpip.pv_rou,0)              pay_item_rou_pv,
 nvl(qpip.actual_amount_liability,0) pay_item_liability_payment,
 nvl(qpip.pv_liability,0)        pay_item_liability_pv,
 -- amortization
 to_number(null)                 amort_fin_rou_begin_balance,
 to_number(null)                 amort_fin_rou_amortization,
 to_number(null)                 amort_fin_rou_adjustmt_reserve,
 to_number(null)                 amort_fin_gain_loss,
 to_number(null)                 amort_fin_rou_end_balance,
 to_number(null)                 amort_opr_rou_begin_balance,
 to_number(null)                 amort_opr_rou_amortization,
 to_number(null)                 amort_opr_rou_adjustmt_reserve,
 to_number(null)                 amort_opr_gain_loss,
 to_number(null)                 amort_opr_rou_end_balance,
 to_number(null)                 amort_liability_begin_balance,
 to_number(null)                 amort_payment,
 to_number(null)                 amort_irr_rate,
 to_number(null)                 amort_interest_expense,
 to_number(null)                 amort_fin_liability_adjustment,
 to_number(null)                 amort_opr_liability_adjustment,
 to_number(null)                 amort_liability_end_balance,
 to_number(null)                 amort_lease_expense,
 --
 qld.lease_id                    lease_id,
 qpt.payment_term_id             payment_term_id,
 to_number(null)                 option_id
from
 q_lease             ql,
 q_lease_detail      qld,
 q_payment_terms     qpt,
 q_payment_items_pv  qpip
where
    ql.lease_id         = qld.lease_id
and ql.lease_id         = qpt.lease_id
and qpt.lease_id        = qpip.lease_id
and qpt.payment_term_id = qpip.payment_term_id
and :p_incl_pay_items   is not null
union all
-- Q5 Payment Term Item Amortization
select
 5                               record_seq,
 'Amortization Schedule'         record_type,
 :p_legal_entity,
 :p_ledger_name,
 :p_org_name,
 :p_functional_currency,
 :p_as_of_period,
 :p_to_date,
 ql.report_status,
 ql.lease_num,
 ql.lease_name,
 ql.lease_category,
 -- lease detail
 qld.lease_commencement_date,
 qld.lease_termination_date,
 qld.duration_in_months,
 qld.payment_term_proration_rule,
 qld.accounting_method,
 ql.lease_discount_rate,
 qld.lease_representation,
 qld.lease_source,
 -- lease report
 null                            period,
 to_date(null)                   period_start_date,
 to_number(null)                 liability,
 to_number(null)                 cash,
 to_number(null)                 interest_accrual,
 to_number(null)                 rou_asset_fin,
 to_number(null)                 rou_amort_expense_fin,
 to_number(null)                 rou_asset_opr,
 to_number(null)                 rou_amort_expense_opr,
 to_number(null)                 lease_expense_opr,
 null                            currency,
 -- payment term / option
 'Payment Term'                  trm_or_opt,
 qpt.payment_purpose             trm_opt_purpose,
 qpt.payment_type                trm_opt_type,
 to_number(null)                 trm_opt_actual_amount,
 qpt.start_date                  trm_opt_start_date,
 qpt.end_date                    trm_opt_end_date,
 qpt.duration                    trm_opt_duration_months,
 qpt.liability_flag              trm_opt_liability,
 qpt.rou_asset_flag              trm_opt_rou,
 qpt.rept_inception_flag         trm_opt_report_from_inception,
 qpt.schedule_day                trm_opt_schedule_day,
 qpt.payment_frequency           trm_opt_frequency,
 qpt.payment_currency            trm_opt_currency,
 qpt.asset_number                trm_opt_asset_number,
 case
 when qpt.term_initial_rate = -99999 and qpt.rept_inception_flag = 'Yes'
 then (select distinct first_value(qpip2.discount_rate) ignore nulls over (order by qpip2.due_date) from q_payment_items_pv qpip2 where qpip2.lease_id = qpt.lease_id and qpip2.payment_term_id = qpt.payment_term_id)
 else case qpt.term_initial_rate when -99999 then qpt.term_discount_rate else qpt.term_initial_rate end
 end                             trm_opt_previous_interest_rate,
 qpt.term_discount_rate          trm_opt_interest_rate,
 -- present value (pv)
 qpia.period_date                pay_as_of_date,
 to_number(null)                 pay_item_days,
 to_number(null)                 pay_item_rate,
 to_number(null)                 pay_item_rou_payment,
 to_number(null)                 pay_item_rou_pv,
 to_number(null)                 pay_item_liability_payment,
 to_number(null)                 pay_item_liability_pv,
 -- amortization
 qpia.rou_bal_start_fin          amort_fin_rou_begin_balance,
 qpia.rou_amrtztn_amt_fin        amort_fin_rou_amortization,
 qpia.rou_adj_fin                amort_fin_rou_adjustmt_reserve,
 qpia.gain_loss_fin              amort_fin_gain_loss,
 qpia.rou_bal_end_fin            amort_fin_rou_end_balance,
 qpia.rou_bal_start_us_opr       amort_opr_rou_begin_balance,
 qpia.rou_amrtztn_amt_us_opr     amort_opr_rou_amortization,
 qpia.rou_adj_us_opr             amort_opr_rou_adjustmt_reserve,
 qpia.gain_loss_us_opr           amort_opr_gain_loss,
 qpia.rou_bal_end_us_opr         amort_opr_rou_end_balance,
 qpia.lia_bal_start              amort_liability_begin_balance,
 qpia.lease_payment              amort_payment,
 qpia.irr_rate                   amort_irr_rate,
 qpia.interest_expense           amort_interest_expense,
 qpia.lia_adj_fin                amort_fin_liability_adjustment,
 qpia.lia_adj_us_opr             amort_opr_liability_adjustment,
 qpia.lia_bal_end                amort_liability_end_balance,
 case when nvl(qld.accounting_method,'null') != 'FINANCE' then qpia.lease_expense end amort_lease_expense,
 --
 qld.lease_id                    lease_id,
 qpt.payment_term_id             payment_term_id,
 to_number(null)                 option_id
from
 q_lease               ql,
 q_lease_detail        qld,
 q_payment_terms       qpt,
 q_payment_items_amort qpia
where
    ql.lease_id         = qld.lease_id
and ql.lease_id         = qpt.lease_id
and qpt.lease_id        = qpia.lease_id
and qpt.payment_term_id = qpia.payment_term_id
and :p_incl_amort       is not null
union all
-- Q6 Options
select
 6                               record_seq,
 'Payment Term / Option'         record_type,
 :p_legal_entity,
 :p_ledger_name,
 :p_org_name,
 :p_functional_currency,
 :p_as_of_period,
 :p_to_date,
 ql.report_status,
 ql.lease_num,
 ql.lease_name,
 ql.lease_category,
 -- lease detail
 qld.lease_commencement_date,
 qld.lease_termination_date,
 qld.duration_in_months,
 qld.payment_term_proration_rule,
 qld.accounting_method,
 ql.lease_discount_rate,
 qld.lease_representation,
 qld.lease_source,
 -- lease report
 null                            period,
 to_date(null)                   period_start_date,
 to_number(null)                 liability,
 to_number(null)                 cash,
 to_number(null)                 interest_accrual,
 to_number(null)                 rou_asset_fin,
 to_number(null)                 rou_amort_expense_fin,
 to_number(null)                 rou_asset_opr,
 to_number(null)                 rou_amort_expense_opr,
 to_number(null)                 lease_expense_opr,
 null                            currency,
 -- payment term / option
 'Option'                        trm_or_opt,
 null                            trm_opt_purpose,
 qo.option_type                  trm_opt_type,
 qo.option_actual_amount         trm_opt_actual_amount,
 qo.option_start_date            trm_opt_start_date,
 qo.option_end_date              trm_opt_end_date,
 qo.option_duration              trm_opt_duration_months,
 qo.option_liability_flag        trm_opt_liability,
 qo.option_rou_asset_flag        trm_opt_rou,
 qo.option_rept_inception_flag   trm_opt_report_from_inception,
 qo.option_schedule_day          trm_opt_schedule_day,
 qo.option_frequency             trm_opt_frequency,
 qo.option_currency              trm_opt_currency,
 qo.asset_number                 trm_opt_asset_number,
 case
 when qo.option_initial_rate = -99999 and qo.option_rept_inception_flag = 'Yes'
 then (select distinct first_value(qoip2.option_discount_rate) ignore nulls over (order by qoip2.option_due_date) from q_option_items_pv qoip2 where qoip2.lease_id = qo.lease_id and qoip2.option_id = qo.option_id)
 else case qo.option_initial_rate when -99999 then qo.option_discount_rate else qo.option_initial_rate end
 end                             trm_opt_previous_interest_rate,
 qo.option_discount_rate         trm_opt_interest_rate,
 -- present value (pv)
 to_date(null)                   pay_as_of_date,
 to_number(null)                 pay_item_days,
 to_number(null)                 pay_item_rate,
 to_number(null)                 pay_item_rou_payment,
 to_number(null)                 pay_item_rou_pv,
 to_number(null)                 pay_item_liability_payment,
 to_number(null)                 pay_item_liability_pv,
 -- amortization
 to_number(null)                 amort_fin_rou_begin_balance,
 to_number(null)                 amort_fin_rou_amortization,
 to_number(null)                 amort_fin_rou_adjustmt_reserve,
 to_number(null)                 amort_fin_gain_loss,
 to_number(null)                 amort_fin_rou_end_balance,
 to_number(null)                 amort_opr_rou_begin_balance,
 to_number(null)                 amort_opr_rou_amortization,
 to_number(null)                 amort_opr_rou_adjustmt_reserve,
 to_number(null)                 amort_opr_gain_loss,
 to_number(null)                 amort_opr_rou_end_balance,
 to_number(null)                 amort_liability_begin_balance,
 to_number(null)                 amort_payment,
 to_number(null)                 amort_irr_rate,
 to_number(null)                 amort_interest_expense,
 to_number(null)                 amort_fin_liability_adjustment,
 to_number(null)                 amort_opr_liability_adjustment,
 to_number(null)                 amort_liability_end_balance,
 to_number(null)                 amort_lease_expense,
 --
 qld.lease_id                    lease_id,
 to_number(null)                 payment_term_id,
 qo.option_id                    option_id
from
 q_lease         ql,
 q_lease_detail  qld,
 q_options       qo
where
    ql.lease_id     = qld.lease_id
and ql.lease_id     = qo.lease_id
union all
-- Q7 Options PV
select
 7                               record_seq,
 'Payment Schedule'              record_type,
 :p_legal_entity,
 :p_ledger_name,
 :p_org_name,
 :p_functional_currency,
 :p_as_of_period,
 :p_to_date,
 ql.report_status,
 ql.lease_num,
 ql.lease_name,
 ql.lease_category,
 -- lease detail
 qld.lease_commencement_date,
 qld.lease_termination_date,
 qld.duration_in_months,
 qld.payment_term_proration_rule,
 qld.accounting_method,
 ql.lease_discount_rate,
 qld.lease_representation,
 qld.lease_source source,
 -- lease report
 null                            period,
 to_date(null)                   period_start_date,
 to_number(null)                 liability,
 to_number(null)                 cash,
 to_number(null)                 interest_accrual,
 to_number(null)                 rou_asset_fin,
 to_number(null)                 rou_amort_expense_fin,
 to_number(null)                 rou_asset_opr,
 to_number(null)                 rou_amort_expense_opr,
 to_number(null)                 lease_expense_opr,
 null                            currency,
 -- payment term / option
 'Option'                        trm_or_opt,
 null                            trm_opt_purpose,
 qo.option_type                  trm_opt_type,
 to_number(null)                 trm_opt_actual_amount,
 qo.option_start_date            trm_opt_start_date,
 qo.option_end_date              trm_opt_end_date,
 qo.option_duration              trm_opt_duration_months,
 qo.option_liability_flag        trm_opt_liability,
 qo.option_rou_asset_flag        trm_opt_rou,
 qo.option_rept_inception_flag   trm_opt_report_from_inception,
 qo.option_schedule_day          trm_opt_schedule_day,
 qo.option_frequency             trm_opt_frequency,
 qo.option_currency              trm_opt_currency,
 qo.asset_number                 trm_opt_asset_number,
 case
 when qo.option_initial_rate = -99999 and qo.option_rept_inception_flag = 'Yes'
 then (select distinct first_value(qoip2.option_discount_rate) ignore nulls over (order by qoip2.option_due_date) from q_option_items_pv qoip2 where qoip2.lease_id = qo.lease_id and qoip2.option_id = qo.option_id)
 else case qo.option_initial_rate when -99999 then qo.option_discount_rate else qo.option_initial_rate end
 end                             trm_opt_previous_interest_rate,
 qo.option_discount_rate         trm_opt_interest_rate,
 -- present value (pv)
 qoip.option_due_date            pay_as_of_date,
 qoip.option_pmt_days            pay_item_days,
 qoip.option_discount_rate       pay_item_rate,
 nvl(qoip.option_actual_amount_rou,0) pay_item_rou_payment,
 nvl(qoip.option_pv_rou,0)       pay_item_rou_pv,
 nvl(qoip.option_actual_amount_liability,0) pay_item_liability_payment,
 nvl(qoip.option_pv_liability,0) pay_item_liability_pv,
 -- amortization
 to_number(null)                 amort_fin_rou_begin_balance,
 to_number(null)                 amort_fin_rou_amortization,
 to_number(null)                 amort_fin_rou_adjustmt_reserve,
 to_number(null)                 amort_fin_gain_loss,
 to_number(null)                 amort_fin_rou_end_balance,
 to_number(null)                 amort_opr_rou_begin_balance,
 to_number(null)                 amort_opr_rou_amortization,
 to_number(null)                 amort_opr_rou_adjustmt_reserve,
 to_number(null)                 amort_opr_gain_loss,
 to_number(null)                 amort_opr_rou_end_balance,
 to_number(null)                 amort_liability_begin_balance,
 to_number(null)                 amort_payment,
 to_number(null)                 amort_irr_rate,
 to_number(null)                 amort_interest_expense,
 to_number(null)                 amort_fin_liability_adjustment,
 to_number(null)                 amort_opr_liability_adjustment,
 to_number(null)                 amort_liability_end_balance,
 to_number(null)                 amort_lease_expense,
 --
 qld.lease_id                    lease_id,
 to_number(null)                 payment_term_id,
 qo.option_id                    option_id
from
 q_lease           ql,
 q_lease_detail    qld,
 q_options         qo,
 q_option_items_pv qoip
where
    ql.lease_id       = qld.lease_id
and ql.lease_id       = qo.lease_id
and qo.lease_id       = qoip.lease_id
and qo.option_id      = qoip.option_id
and :p_incl_pay_items is not null
union all
-- Q8 Options Amortization
select
 8                               record_seq,
 'Amortization Schedule'         record_type,
 :p_legal_entity,
 :p_ledger_name,
 :p_org_name,
 :p_functional_currency,
 :p_as_of_period,
 :p_to_date,
 ql.report_status,
 ql.lease_num,
 ql.lease_name,
 ql.lease_category,
 -- lease detail
 qld.lease_commencement_date,
 qld.lease_termination_date,
 qld.duration_in_months,
 qld.payment_term_proration_rule,
 qld.accounting_method,
 ql.lease_discount_rate,
 qld.lease_representation,
 qld.lease_source,
 -- lease report
 null                            period,
 to_date(null)                   period_start_date,
 to_number(null)                 liability,
 to_number(null)                 cash,
 to_number(null)                 interest_accrual,
 to_number(null)                 rou_asset_fin,
 to_number(null)                 rou_amort_expense_fin,
 to_number(null)                 rou_asset_opr,
 to_number(null)                 rou_amort_expense_opr,
 to_number(null)                 lease_expense_opr,
 null                            currency,
 -- payment term / option
 'Option'                        trm_or_opt,
 null                            trm_opt_purpose,
 qo.option_type                  trm_opt_type,
 to_number(null)                 trm_opt_actual_amount,
 qo.option_start_date            trm_opt_start_date,
 qo.option_end_date              trm_opt_end_date,
 qo.option_duration              trm_opt_duration_months,
 qo.option_liability_flag        trm_opt_liability,
 qo.option_rou_asset_flag        trm_opt_rou,
 qo.option_rept_inception_flag   trm_opt_report_from_inception,
 qo.option_schedule_day          trm_opt_schedule_day,
 qo.option_frequency             trm_opt_frequency,
 qo.option_currency              trm_opt_currency,
 qo.asset_number                 trm_opt_asset_number,
 case
 when qo.option_initial_rate = -99999 and qo.option_rept_inception_flag = 'Yes'
 then (select distinct first_value(qoip2.option_discount_rate) ignore nulls over (order by qoip2.option_due_date) from q_option_items_pv qoip2 where qoip2.lease_id = qo.lease_id and qoip2.option_id = qo.option_id)
 else case qo.option_initial_rate when -99999 then qo.option_discount_rate else qo.option_initial_rate end
 end                             trm_opt_previous_interest_rate,
 qo.option_discount_rate         trm_opt_interest_rate,
 -- present value (pv)
 qoa.opt_period_date             pay_as_of_date,
 to_number(null)                 pay_item_days,
 to_number(null)                 pay_item_rate,
 to_number(null)                 pay_item_rou_payment,
 to_number(null)                 pay_item_rou_pv,
 to_number(null)                 pay_item_liability_payment,
 to_number(null)                 pay_item_liability_pv,
 -- amortization
 qoa.opt_rou_bal_start_fin           amort_fin_rou_begin_balance,
 qoa.opt_rou_amrtztn_amt_fin         amort_fin_rou_amortization,
 qoa.opt_rou_adj_fin                 amort_fin_rou_adjustmt_reserve,
 qoa.opt_gain_loss_fin               amort_fin_gain_loss,
 qoa.opt_rou_bal_end_fin             amort_fin_rou_end_balance,
 qoa.opt_rou_bal_start_us_opr        amort_opr_rou_begin_balance,
 qoa.opt_rou_amrtztn_amt_us_opr      amort_opr_rou_amortization,
 qoa.opt_rou_adj_us_opr              amort_opr_rou_adjustmt_reserve,
 qoa.opt_gain_loss_us_opr            amort_opr_gain_loss,
 qoa.opt_rou_bal_end_us_opr          amort_opr_rou_end_balance,
 qoa.opt_lia_bal_start               amort_liability_begin_balance,
 qoa.opt_lease_payment               amort_payment,
 qoa.opt_irr_rate                    amort_irr_rate,
 qoa.opt_interest_expense            amort_interest_expense,
 qoa.opt_lia_adj_fin                 amort_fin_liability_adjustment,
 qoa.opt_lia_adj_us_opr              amort_opr_liability_adjustment,
 qoa.opt_rou_bal_end_us_opr          amort_liability_end_balance,
 case when nvl(qld.accounting_method,'null') != 'FINANCE' then qoa.opt_lease_expense end amort_lease_expense,
 --
 qld.lease_id                    lease_id,
 to_number(null)                 payment_term_id,
 qo.option_id                    option_id
from
 q_lease         ql,
 q_lease_detail  qld,
 q_options       qo,
 q_options_amort qoa
where
    ql.lease_id     = qld.lease_id
and ql.lease_id     = qo.lease_id
and qo.lease_id     = qoa.lease_id
and qo.option_id    = qoa.option_id
and :p_incl_amort   is not null
) x
order by
 x.lease_num,
 nvl2(x.option_id,3,nvl2(x.payment_term_id,2,1)), -- lease, then payment terms, then options
 x.trm_opt_liability desc,
 x.trm_opt_rou desc,
 x.payment_term_id,
 x.option_id,
 x.record_seq,
 x.period_start_date,
 x.pay_as_of_date,
 x.currency