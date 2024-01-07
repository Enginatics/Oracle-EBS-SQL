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
             w