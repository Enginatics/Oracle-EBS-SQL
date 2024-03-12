/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Open Items Revaluation
-- Description: Imported from BI Publisher
Description: Open Items Revaluation Report
Application: Receivables
Source: Open Items Revaluation Report (XML)
Short Name: ARXINREV_XML
DB package: AR_ARXINREV_XMLP_PKG

-- Excel Examle Output: https://www.enginatics.com/example/ar-open-items-revaluation/
-- Library Link: https://www.enginatics.com/reports/ar-open-items-revaluation/
-- Run Report: https://demo.enginatics.com/

select
  trx.c_ledger         "Ledger"
, trx.c_balancing      "Balancing Segment"
, trx.c_account        "Account Segment"
, trx.c_flexdata       "Accounting Flexfield"
, trx.c_desc_all       "Accounting Flexfield Desc."
&lp_report_format_cols
from
( select
     ps.c_ccid
  ,  ps.c_balancing
  ,  ps.c_account
  ,  ps.c_flexdata
  ,  ps.c_cust_name
  ,  ps.c_cust_number
  ,  ps.c_cust_city
  ,  ps.c_trx_id
  ,  ps.c_pay_id
  ,  ps.c_trx_number
  ,  ps.c_inv_type
  ,  ps.c_inv_date
  ,  ps.c_due_date
  ,  ps.c_curr
  ,  ps.c_pay_amount
  ,  ps.c_exchange_rate
  ,  ps.c_type
  ,  ps.c_revaluate_yes_no
  ,  ps.c_inv_gl_posted_date
  ,  ps.c_previous_cust_trx_id
  ,  ps.c_trx_length
  ,  ps.c_ledger
  ,  ps.c_operating_unit
  ,  ps.c_desc_all
  --
  ,  ps.c_eop_rate
  ,  ps.c_receiptsformula
  ,  ps.c_adjustformula
  ,  ps.c_cmformula
  ,  ps.c_cm1formula
  --
  , (nvl(ps.c_pay_amount,0) - nvl(ps.c_receiptsformula,0)  + nvl(ps.c_adjustformula,0) - nvl(ps.c_cmformula,0) + nvl(ps.c_cm1formula,0)) c_open_orig
  , case when ps.p_minimum_accountable_unit is null
    then round(((nvl(ps.c_pay_amount,0) - nvl(ps.c_receiptsformula,0)  + nvl(ps.c_adjustformula,0) - nvl(ps.c_cmformula,0) + nvl(ps.c_cm1formula,0)) * ps.c_exchange_rate),ps.p_precision)
    else round(((nvl(ps.c_pay_amount,0) - nvl(ps.c_receiptsformula,0)  + nvl(ps.c_adjustformula,0) - nvl(ps.c_cmformula,0) + nvl(ps.c_cm1formula,0)) * ps.c_exchange_rate) / ps.p_minimum_accountable_unit) * ps.p_minimum_accountable_unit
    end calc_open_func
  --
  , case when ps.p_minimum_accountable_unit is null
    then round(((nvl(ps.c_pay_amount,0) - nvl(ps.c_receiptsformula,0)  + nvl(ps.c_adjustformula,0) - nvl(ps.c_cmformula,0) + nvl(ps.c_cm1formula,0)) * ps.c_eop_rate),ps.p_precision)
    else round(((nvl(ps.c_pay_amount,0) - nvl(ps.c_receiptsformula,0)  + nvl(ps.c_adjustformula,0) - nvl(ps.c_cmformula,0) + nvl(ps.c_cm1formula,0)) * ps.c_eop_rate) / ps.p_minimum_accountable_unit) * ps.p_minimum_accountable_unit
    end calc_eop_amount
  --
--  , case
--    when ps.c_eop_rate is null
--    then to_number(null)
--    when ps.c_eop_rate < ps.c_exchange_rate
--    then (nvl(ps.c_pay_amount,0) - nvl(ps.c_receiptsformula,0)  + nvl(ps.c_adjustformula,0) - nvl(ps.c_cmformula,0) + nvl(ps.c_cm1formula,0)) * ps.c_eop_rate
--    else (nvl(ps.c_pay_amount,0) - nvl(ps.c_receiptsformula,0)  + nvl(ps.c_adjustformula,0) - nvl(ps.c_cmformula,0) + nvl(ps.c_cm1formula,0)) * ps.c_exchange_rate
--    end calc_open_rev
  , case when ps.c_eop_rate is null
    then
      to_number(null)
    else
      case when ps.p_minimum_accountable_unit is null
      then round((((nvl(ps.c_pay_amount,0) - nvl(ps.c_receiptsformula,0)  + nvl(ps.c_adjustformula,0) - nvl(ps.c_cmformula,0) + nvl(ps.c_cm1formula,0)) * ps.c_eop_rate) - ((nvl(ps.c_pay_amount,0) - nvl(ps.c_receiptsformula,0)  + nvl(ps.c_adjustformula,0) - nvl(ps.c_cmformula,0) + nvl(ps.c_cm1formula,0)) * ps.c_exchange_rate)),ps.p_precision)
      else round((((nvl(ps.c_pay_amount,0) - nvl(ps.c_receiptsformula,0)  + nvl(ps.c_adjustformula,0) - nvl(ps.c_cmformula,0) + nvl(ps.c_cm1formula,0)) * ps.c_eop_rate) - ((nvl(ps.c_pay_amount,0) - nvl(ps.c_receiptsformula,0)  + nvl(ps.c_adjustformula,0) - nvl(ps.c_cmformula,0) + nvl(ps.c_cm1formula,0)) * ps.c_exchange_rate)) / ps.p_minimum_accountable_unit) * ps.p_minimum_accountable_unit
      end
    end calc_open_rev
  from
   (select
       dist.code_combination_id c_ccid
    ,  fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', cc.chart_of_accounts_id, NULL, cc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') c_balancing
    ,  fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_acc_seg', 'SQLGL', 'GL#', cc.chart_of_accounts_id, NULL, cc.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE') c_account
    ,  fnd_flex_xml_publisher_apis.process_kff_combination_1('p_flexdata', 'SQLGL', 'GL#', cc.chart_of_accounts_id, NULL, cc.code_combination_id, 'ALL', 'Y', 'VALUE') c_flexdata
    ,  substrb(party.party_name,1,50) c_cust_name
    ,  cust.account_number c_cust_number
    ,  loc.city c_cust_city
    ,  trx.customer_trx_id c_trx_id
    ,  pay.payment_schedule_id c_pay_id
    ,  ltrim(rtrim(trx.trx_number)) c_trx_number
    ,  typ.name c_inv_type
    ,  trx.trx_date c_inv_date
    ,  pay.due_date c_due_date
    ,  pay.invoice_currency_code c_curr
    ,  pay.amount_due_original c_pay_amount
    ,  nvl(trx.exchange_rate,1.00) c_exchange_rate
    ,  typ.type c_type
    ,  typ.global_attribute1 c_revaluate_yes_no
    ,  dist.gl_posted_date c_inv_gl_posted_date
    ,  nvl(previous_customer_trx_id,0) c_previous_cust_trx_id
    ,  length(ltrim(rtrim(nvl(to_char(doc_sequence_value),trx.trx_number)))) c_trx_length
    ,  sob.name c_ledger
    ,  fc.precision p_precision
    ,  fc.minimum_accountable_unit p_minimum_accountable_unit
    ,  haouv.name c_operating_unit
    ,  fnd_flex_xml_publisher_apis.process_kff_combination_1('c_desc_all', 'SQLGL', 'GL#', cc.chart_of_accounts_id, NULL, cc.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') c_desc_all
    --
    ,  case
       when pay.invoice_currency_code = sob.currency_code
       then 1
       when typ.type = 'DEP'
       then nvl (trx.exchange_rate,1)
       when :p_rate_type_lookup = 'PERIOD'
       then (select  /*+ push_pred */ decode(tr.eop_rate, 0,0, 1/tr.eop_rate)
             from gl_translation_rates tr
             where tr.set_of_books_id  = sob.set_of_books_id
             and tr.to_currency_code   = pay.invoice_currency_code
             and upper(tr.period_name) = upper(:p_revaluation_period)
             and tr.actual_flag        = 'A'
            )
       else case
            when gl_currency_api.get_rate_sql(pay.invoice_currency_code,sob.currency_code,:p_rate_date,:p_daily_rate_type) < 0
            then null
            else gl_currency_api.get_rate_sql(pay.invoice_currency_code,sob.currency_code,:p_rate_date,:p_daily_rate_type)
            end
       end c_eop_rate
    --
    ,  case when :p_cleared = 'N'
       then
         (select /*+ push_pred */
          sum(nvl(app2.amount_applied,0) + nvl(app2.earned_discount_taken,0) + nvl(app2.unearned_discount_taken,0)) receipt_amt
          from
          ar_receivable_applications app2
          where
              app2.applied_payment_schedule_id = pay.payment_schedule_id
          and app2.status = 'APP'
          and app2.gl_date <= gps.end_date
          and app2.application_type='CASH'
          and not exists
            (select 'reversed'
             from   ar_cash_receipt_history crh
             where  app2.cash_receipt_id = crh.cash_receipt_id
             and    crh.status = 'REVERSED'
             and    crh.gl_date <= gps.end_date
            )
         )
       else
         (select /*+ push_pred */
          sum(nvl(app2.amount_applied,0) + nvl(app2.earned_discount_taken,0) + nvl(app2.unearned_discount_taken,0)) receipt_amt
          from
          ar_receivable_applications app2
          where
              app2.applied_payment_schedule_id = pay.payment_schedule_id
          and app2.status = 'APP'
          and app2.gl_date <= gps.end_date
          and app2.application_type='CASH'
          and exists
            (select 'cleared cleared receipt'
             from   ar_cash_receipt_history crh
             where  app2.cash_receipt_id = crh.cash_receipt_id
             and    crh.status = 'CLEARED'
             and    crh.gl_date <= gps.end_date
             and    nvl(crh.reversal_gl_date,gps.end_date+1) > gps.end_date
            )
         )
       end c_receiptsformula
    --
    ,  (select /*+ push_pred */
        sum(adj2.amount) adjustment_amt
        from
        ar_adjustments adj2
        where
            adj2.payment_schedule_id = pay.payment_schedule_id
        and adj2.gl_date <= gps.end_date
        and adj2.status = 'A'
       ) c_adjustformula
    --
    ,  (select /*+ push_pred */
        sum(nvl(app2.amount_applied,0)) cm_amt
        from
        ar_receivable_applications app2
        where
            app2.applied_payment_schedule_id = pay.payment_schedule_id
        and app2.gl_date <= gps.end_date
        and app2.status ='APP'
        and app2.application_type = 'CM'
       ) c_cmformula
    --
    ,  (select /*+ push_pred */
        sum(nvl(app2.amount_applied,0)) cm_amt
        from
        ar_receivable_applications app2
        where
            app2.payment_schedule_id = pay.payment_schedule_id
        and app2.gl_date <= gps.end_date
        and (app2.status ='APP' or (app2.status='ACTIVITY' and app2.applied_payment_schedule_id = -8))
        and app2.application_type = 'CM'
       ) c_cm1formula
    from
      ra_cust_trx_types      typ
    , hz_cust_accounts       cust
    , hz_parties             party
    , hz_locations           loc
    , hz_cust_acct_sites     acct_site
    , hz_party_sites         party_site
    , hz_cust_site_uses      site
    , gl_code_combinations   cc
    , gl_sets_of_books       sob
    , fnd_currencies         fc
    , hr_all_organization_units_vl haouv
    , ra_customer_trx        trx
    , ar_xla_ctlgd_lines_v   dist
    , ar_payment_schedules   pay
    , (select /*+ push_pred */
       gps.set_of_books_id,gps.end_date
       from
       gl_period_statuses gps
       where
           gps.application_id = 222
       and gps.period_name = :p_revaluation_period
      ) gps
    where
        1=1
    and pay.gl_date                  <= gps.end_date
    and cust.cust_account_id       = pay.customer_id
    and cust.party_id              = party.party_id
    and trx.customer_trx_id        = pay.customer_trx_id
    and pay.customer_site_use_id   = site.site_use_id(+)
    and site.cust_acct_site_id     = acct_site.cust_acct_site_id(+)
    and acct_site.party_site_id    = party_site.party_site_id(+)
    and party_site.location_id     = loc.location_id(+)
    and dist.customer_trx_id       = trx.customer_trx_id
    and dist.account_class         = 'REC'
    and dist.latest_rec_flag       = 'Y'
    and dist.account_set_flag      = 'N'
    and trx.complete_flag          = 'Y'
    and trx.set_of_books_id        = sob.set_of_books_id
    and sob.currency_code          = fc.currency_code
    and trx.org_id                 = haouv.organization_id
    and typ.cust_trx_type_id       = pay.cust_trx_type_id
    and typ.org_id = pay.org_id
    and dist.code_combination_id   = cc.code_combination_id
    and dist.set_of_books_id       = sob.set_of_books_id
    and ar_arxinrev_xmlp_pkg.c_daily_rate_lookup_error_p
                                   = 'N'
    and gps.set_of_books_id        = sob.set_of_books_id
    and case when :p_rate_type_lookup = 'DAILY' and (:p_daily_rate_type is null or :p_rate_date is null)
        then 'Y' else 'N'
        end                        = 'N'
   ) ps
  order by
     c_ledger
  ,  c_balancing
  ,  c_account
  ,  c_flexdata
  ,  c_ccid
  ,  c_cust_name
  ,  c_cust_number
  ,  c_cust_number
  ,  c_trx_length
  ,  c_trx_number
  ,  c_inv_gl_posted_date
  ,  c_revaluate_yes_no
  ,  c_inv_type
  ,  c_inv_date
  ,  c_due_date
  ,  c_trx_id
  ,  c_exchange_rate
  ,  c_type
  ,  c_pay_id
  ,  c_curr
  ,  c_pay_amount
) trx
where
    trx.c_open_orig != 0
and (trx.c_type != 'CM' or (trx.c_type = 'CM' and trx.c_previous_cust_trx_id = 0))
&lp_group_by_cols