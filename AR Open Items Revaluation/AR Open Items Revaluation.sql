/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
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
  trx.ledger
, trx.c_balancing      "Balancing Segment"
, trx.c_account        "Account Segment"
, trx.c_flexdata       "Accounting Flexfield"
, trx.c_desc_all       "Accounting Flexfield Desc."
&lp_report_format_cols
from
  ( select
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
    ,  sob.name ledger
    ,  fnd_flex_xml_publisher_apis.process_kff_combination_1('c_desc_all', 'SQLGL', 'GL#', cc.chart_of_accounts_id, NULL, cc.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') c_desc_all
    ,  ar_arxinrev_xmlp_pkg.cp_tmp_p cp_tmp
    ,  ar_arxinrev_xmlp_pkg.c_eop_rateformula(pay.invoice_currency_code, typ.type, nvl ( trx.exchange_rate , 1.00 )) c_eop_rate
    ,  ar_arxinrev_xmlp_pkg.c_open_origformula
         ( pay.amount_due_original
         , ar_arxinrev_xmlp_pkg.c_receiptsformula(pay.payment_schedule_id)
         , ar_arxinrev_xmlp_pkg.c_adjustformula(pay.payment_schedule_id)
         , ar_arxinrev_xmlp_pkg.c_cmformula(pay.payment_schedule_id)
         , ar_arxinrev_xmlp_pkg.c_cm1formula(pay.payment_schedule_id)
         ) c_open_orig
    ,  ar_arxinrev_xmlp_pkg.calc_open_funcformula
         ( ar_arxinrev_xmlp_pkg.c_open_funcformula
             ( ar_arxinrev_xmlp_pkg.c_open_origformula
                 ( pay.amount_due_original
                 , ar_arxinrev_xmlp_pkg.c_receiptsformula(pay.payment_schedule_id)
                 , ar_arxinrev_xmlp_pkg.c_adjustformula(pay.payment_schedule_id)
                 , ar_arxinrev_xmlp_pkg.c_cmformula(pay.payment_schedule_id)
                 , ar_arxinrev_xmlp_pkg.c_cm1formula(pay.payment_schedule_id)
                 )
             , nvl ( trx.exchange_rate , 1.00 )
             )
         ) calc_open_func
    ,  ar_arxinrev_xmlp_pkg.calc_eop_amountformula
         ( ar_arxinrev_xmlp_pkg.c_eop_amountformula
             ( ar_arxinrev_xmlp_pkg.c_eop_rateformula(pay.invoice_currency_code, typ.type, nvl ( trx.exchange_rate , 1.00 ))
             , ar_arxinrev_xmlp_pkg.c_open_origformula
                 ( pay.amount_due_original
                 , ar_arxinrev_xmlp_pkg.c_receiptsformula(pay.payment_schedule_id)
                 , ar_arxinrev_xmlp_pkg.c_adjustformula(pay.payment_schedule_id)
                 , ar_arxinrev_xmlp_pkg.c_cmformula(pay.payment_schedule_id)
                 , ar_arxinrev_xmlp_pkg.c_cm1formula(pay.payment_schedule_id)
                 )
             )
         ) calc_eop_amount
    ,  ar_arxinrev_xmlp_pkg.calc_open_revformula
         ( ar_arxinrev_xmlp_pkg.c_open_revformula
             ( ar_arxinrev_xmlp_pkg.c_eop_rateformula(pay.invoice_currency_code, typ.type, nvl ( trx.exchange_rate , 1.00 ))
             , nvl( trx.exchange_rate , 1.00 )
             , ar_arxinrev_xmlp_pkg.c_open_origformula
                 ( pay.amount_due_original
                 , ar_arxinrev_xmlp_pkg.c_receiptsformula(pay.payment_schedule_id)
                 , ar_arxinrev_xmlp_pkg.c_adjustformula(pay.payment_schedule_id)
                 , ar_arxinrev_xmlp_pkg.c_cmformula(pay.payment_schedule_id)
                 , ar_arxinrev_xmlp_pkg.c_cm1formula(pay.payment_schedule_id)
                 )
             , ar_arxinrev_xmlp_pkg.c_open_funcformula
                 ( ar_arxinrev_xmlp_pkg.c_open_origformula
                     ( pay.amount_due_original
                     , ar_arxinrev_xmlp_pkg.c_receiptsformula(pay.payment_schedule_id)
                     , ar_arxinrev_xmlp_pkg.c_adjustformula(pay.payment_schedule_id)
                     , ar_arxinrev_xmlp_pkg.c_cmformula(pay.payment_schedule_id)
                     , ar_arxinrev_xmlp_pkg.c_cm1formula(pay.payment_schedule_id)
                     )
                 , nvl( trx.exchange_rate , 1.00)
                 )
             )
         ) calc_open_rev
    from
      ra_cust_trx_types      typ
    , hz_cust_accounts       cust
    , hz_parties             party
    , hz_locations           loc
    , hz_cust_acct_sites     acct_site
    , hz_party_sites         party_site
    , hz_cust_site_uses      site
    , gl_code_combinations   cc
    , gl_sets_of_books      sob
    , ra_customer_trx        trx
    , ar_xla_ctlgd_lines_v   dist
    , ar_payment_schedules   pay
    where
     &lp_dates
     &lp_posted
          cust.cust_account_id       = pay.customer_id
    and cust.party_id              = party.party_id
    and trx.customer_trx_id        = pay.customer_trx_id
    and pay.customer_site_use_id   = site.site_use_id(+)
     &lp_cleared_new_custom
    and site.cust_acct_site_id     = acct_site.cust_acct_site_id(+)
    and acct_site.party_site_id    = party_site.party_site_id(+)
    and party_site.location_id     = loc.location_id(+)
    and dist.customer_trx_id       = trx.customer_trx_id
    and dist.account_class         = 'REC'
    and dist.latest_rec_flag       = 'Y'
    and dist.account_set_flag      = 'N'
    and trx.complete_flag          = 'Y'
    and trx.set_of_books_id        = :p_set_of_books_id
    and typ.cust_trx_type_id       = pay.cust_trx_type_id
    and dist.code_combination_id   = cc.code_combination_id
    and dist.set_of_books_id       = sob.set_of_books_id
    and ar_arxinrev_xmlp_pkg.c_daily_rate_lookup_error_p
                                   = 'N'
    and pay.org_id in (select hou.organization_id from hr_operating_units hou where hou.name = :p_operating_unit)
    &lp_bal_segment_low
    &lp_bal_segment_high
    order by
      2,
      3,
      4,
      1,
      5,
      6,
      7,
      21,
      10,
      19,
      18,
      11,
      12,
      13,
      8,
      16,
      17,
      9,
      14,
      15
) trx
&lp_group_by_cols