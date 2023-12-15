/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Open Balances Revaluation
-- Description: Report: AR Open Balances Revaluation Report
Application: Receivables
Source: AR Open Balances Revaluation Report
Short Name: AROBRR

-- Excel Examle Output: https://www.enginatics.com/example/ar-open-balances-revaluation/
-- Library Link: https://www.enginatics.com/reports/ar-open-balances-revaluation/
-- Run Report: https://demo.enginatics.com/

select
  trx.ledger                       "Ledger"
, trx.ou_name                      "Operating Unit"
, trx.c_balancing                  "Balancing Segment"
, trx.c_account                    "Account Segment"
, trx.c_flexdata                   "Accounting Flexfield"
, trx.c_flexdata_desc              "Accounting Flexfield Desc."
, trx.currency_code                "Currency"
, trx.customer_name                "Trading Partner"
, trx.account_number               "Customer Number"
, trx.invoice_number               "Invoice/Receipt Number"
, trx.transaction_type             "Transaction Type"
, trx.internal_invoice_no          "Internal Invoice Number"
, trx.invoice_date                 "Invoice/Receipt Date"
, trx.invoice_amt_entered          "Invoice/Receipt Amount"
, trx.inv_amt_due                  "Amount Due"
, trx.orig_invoice_rate            "Exchange Rate"
, trx.inv_amt_due_er               "Open Functional Amount"
, :p_user_exchange_rate_type       "Revaluation Rate Type"
, to_number(trx.exchange_rate)     "Revaluation Rate"
, trx.inv_amt_due_reval            "Open Revalued Amount"
, nvl(trx.inv_amt_due_reval,0)
   - nvl(trx.inv_amt_due_er,0)     "Profit/Loss"
, nvl2(trx.exchange_rate,null,'Yes') "Missing Revaluation Rates"
from
  ( select
      gl.name                       ledger
    , hou.name                      ou_name
    , fnd_flex_xml_publisher_apis.process_kff_combination_1('flex_select_all', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE')  c_balancing
    , fnd_flex_xml_publisher_apis.process_kff_combination_1('flex_select_all', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE')  c_account
    , fnd_flex_xml_publisher_apis.process_kff_combination_1('flex_select_all', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'VALUE')  c_flexdata
    , fnd_flex_xml_publisher_apis.process_kff_combination_1('flex_select_all', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') c_flexdata_desc
    , rcta.invoice_currency_code    currency_code
    , nvl(rcta.exchange_rate,1)     orig_invoice_rate
    , hp.party_name                 customer_name
    , hca.account_number            account_number
    , rcta.trx_number               invoice_number
    , ''                            lookup_code
    , rcta.trx_date                 invoice_date
    , rcta.doc_sequence_value       internal_invoice_no
    , rctt.type                     transaction_type
    , rcta.customer_trx_id          cust_trx_id
    , case '&lp_exchange_rate_type'
      when 'User'
      then :p_exchange_rate
      else case when gl_currency_api.get_rate_sql(rcta.invoice_currency_code,gl.currency_code,:p_as_of_date,'&lp_exchange_rate_type') in (-1,-2)
           then to_number(null)
           else gl_currency_api.get_rate_sql(rcta.invoice_currency_code,gl.currency_code,:p_as_of_date,'&lp_exchange_rate_type')
           end
      end                           exchange_rate
    , sum(aps.amount_due_original)  invoice_amt_entered
    , 0                             invoice_amt_accounted
    , sum(aps.amount_due_original)
        - nvl( ( select sum(ara.amount_applied)
                 from   ar_receivable_applications ara
                 where  ara.status                  = 'APP'
                 and    ara.applied_customer_trx_id = rcta.customer_trx_id
                 and    ara.gl_date                <= :p_as_of_date
               )
             , 0)
        + nvl( ( select sum(ara.amount_applied)
                 from   ar_receivable_applications ara
                 where  ara.status                  = 'APP'
                 and    ara.application_type       != 'CASH'
                 and    rctt.type                   = 'CM'
                 and    ara.customer_trx_id         = rcta.customer_trx_id
                 and    ara.gl_date                <= :p_as_of_date
               )
             , 0)
        + nvl( ( select sum(ara.amount)
                 from ar_adjustments ara
                 where ara.customer_trx_id  = rcta.customer_trx_id
                 and   ara.gl_date         <= :p_as_of_date
               )
             , 0)                   inv_amt_due
    , nvl(aps.exchange_rate,1)
        * ( sum(aps.amount_due_original)
              - nvl( ( select sum(ara.amount_applied)
                       from   ar_receivable_applications ara
                       where  ara.status                  = 'APP'
                       and    ara.applied_customer_trx_id = rcta.customer_trx_id
                       and    ara.gl_date                 <= :p_as_of_date
                     )
                   , 0)
              + nvl( ( select sum(ara.amount_applied)
                       from   ar_receivable_applications ara
                       where  ara.status                  = 'APP'
                       and    ara.application_type       != 'CASH'
                       and    rctt.type                   = 'CM'
                       and    ara.customer_trx_id         = rcta.customer_trx_id
                       and    ara.gl_date                <= :p_as_of_date
                     )
                   , 0)
              + nvl( ( select sum(ara.amount)
                       from ar_adjustments ara
                       where ara.customer_trx_id = rcta.customer_trx_id
                       and   ara.gl_date <= :p_as_of_date
                     )
                   , 0)
          )                         inv_amt_due_er
    , ( sum(aps.amount_due_original)
          - nvl( ( select sum(ara.amount_applied)
                   from   ar_receivable_applications ara
                   where  ara.status                  = 'APP'
                   and    ara.applied_customer_trx_id = rcta.customer_trx_id
                   and    ara.gl_date                <= :p_as_of_date
                 )
               , 0)
          + nvl( ( select sum(ara.amount_applied)
                   from   ar_receivable_applications ara
                   where  ara.status            = 'APP'
                   and    ara.application_type != 'CASH'
                   and    rctt.type             = 'CM'
                   and    ara.customer_trx_id   = rcta.customer_trx_id
                   and    ara.gl_date          <= :p_as_of_date
                 )
               , 0)
          + nvl( ( select sum(ara.amount)
                   from ar_adjustments ara
                   where ara.customer_trx_id = rcta.customer_trx_id
                   and   ara.gl_date        <= :p_as_of_date)
               , 0)
      )
        * case '&lp_exchange_rate_type'
          when 'User'
          then :p_exchange_rate
          else case when gl_currency_api.get_rate_sql(rcta.invoice_currency_code,gl.currency_code,:p_as_of_date,'&lp_exchange_rate_type') in (-1,-2)
               then to_number(null)
               else gl_currency_api.get_rate_sql(rcta.invoice_currency_code,gl.currency_code,:p_as_of_date,'&lp_exchange_rate_type')
               end
          end                       inv_amt_due_reval
    from
      hr_operating_units           hou
    , gl_ledgers                   gl
    , ra_customer_trx              rcta
    , ar_payment_schedules         aps
    , ra_cust_trx_types            rctt
    , ra_cust_trx_line_gl_dist     rctlgd
    , gl_code_combinations         gcc
    , xla_distribution_links       xdl
    , xla_ae_lines                 xal
    , gl_import_references         gir
    , gl_je_headers                gjh
    , hz_cust_accounts             hca
    , hz_parties                   hp
    , ar_system_parameters         sp
    where
        hou.organization_id              = sp.org_id
    and hou.set_of_books_id              = sp.set_of_books_id
    and gl.ledger_id                     = sp.set_of_books_id
    and rcta.customer_trx_id             = aps.customer_trx_id
    and rcta.org_id                      = hou.organization_id
    and aps.org_id                       = rcta.org_id
    and rcta.cust_trx_type_id            = rctt.cust_trx_type_id
    and rcta.org_id                      = rctt.org_id
    and rctlgd.org_id                    = rctt.org_id
    and aps.customer_trx_id              = rctlgd.customer_trx_id
    and aps.gl_date                     <= :p_as_of_date
    and rctlgd.account_class             = 'REC'
    and rctlgd.latest_rec_flag           = 'Y'
    and xdl.source_distribution_id_num_1 = rctlgd.cust_trx_line_gl_dist_id
    and xdl.source_distribution_type     = 'RA_CUST_TRX_LINE_GL_DIST_ALL'
    and xdl.application_id               = 222
    and xal.ae_header_id                 = xdl.ae_header_id
    and xal.ae_line_num                  = xdl.ae_line_num
    and xal.application_id               = 222
    and xal.accounting_class_code        = 'RECEIVABLE'
    and gcc.code_combination_id          = xal.code_combination_id
    and gir.gl_sl_link_id                = xal.gl_sl_link_id
    and gir.gl_sl_link_table             = xal.gl_sl_link_table
    and gjh.je_header_id                 = gir.je_header_id
    and gjh.status                       = 'P'
    and gjh.ledger_id                    = sp.set_of_books_id
    --and sp.org_id                        = :P_ORG_ID
    and rcta.bill_to_customer_id         = hca.cust_account_id
    and hp.party_id                      = hca.party_id
    and rcta.trx_date                   <= :p_as_of_date
    and 1=1
    group by
      gl.name
    , gl.currency_code
    , hou.name
    , gcc.chart_of_accounts_id
    , gcc.code_combination_id
    , rcta.invoice_currency_code
    , nvl(rcta.exchange_rate,1)
    , hp.party_name
    , hca.account_number
    , rcta.trx_number
    , rcta.trx_date
    , rcta.doc_sequence_value
    , rcta.invoice_currency_code
    , rctt.type
    , hca.cust_account_id
    , rcta.customer_trx_id
    , nvl(APS.exchange_rate,1)
    having
      ( sum(aps.amount_due_original)
          - nvl( ( select sum(ara.amount_applied)
                   from   ar_receivable_applications ara
                   where  ara.status                  = 'APP'
                   and    ara.applied_customer_trx_id = rcta.customer_trx_id
                   and    ara.gl_date                <= :p_as_of_date
                 )
               , 0)
          + nvl( ( select sum(ara.amount_applied)
                   from   ar_receivable_applications ara
                   where  ara.status            = 'APP'
                   and    ara.application_type != 'CASH'
                   and    rctt.type             = 'CM'
                   and    ara.customer_trx_id   = rcta.customer_trx_id
                   and    ara.gl_date          <= :p_as_of_date
                 )
               , 0)
          + nvl( ( select sum(ara.amount)
                   from ar_adjustments ara
                   where ara.customer_trx_id = rcta.customer_trx_id
                   and   ara.gl_date        <= :p_as_of_date)
               , 0)
      ) != 0
    union
    select
      abc.ledger                    ledger
    , abc.op_name                   ou_name
    , abc.c_balancing               c_balancing
    , abc.c_account                 c_account
    , abc.c_flexdata                c_flexdata
    , abc.c_flexdata_desc           c_flexdata_desc
    , abc.currency_code             currency_code
    , abc.orig_invoice_rate         orig_invoice_rate
    , hp.party_name                 customer_name
    , hca.account_number            account_number
    , abc.invoice_number            invoice_number
    , abc.lookup_code               lookup_code
    , abc.receipt_date              invoice_date
    , abc.int_invoice_number        internal_invoice_no
    , abc.trans_type                transaction_type
    , abc.custid                    cust_trx_id
    , abc.exchange_rate             exchange_rate
    , abc.orig_amt                  invoice_amt_entered
    , 0                             invoice_amt_accounted
    , 0-abc.original_amount         inv_amt_due
    , 0-abc.historic_amount         inv_amt_due_er
    , 0-abc.closing_amount          inv_amt_due_reval
    from
      ( select
          gl.name                                       ledger
        , hou.name                                      op_name
        , fnd_flex_xml_publisher_apis.process_kff_combination_1('flex_select_all', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE')  c_balancing
        , fnd_flex_xml_publisher_apis.process_kff_combination_1('flex_select_all', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE')  c_account
        , fnd_flex_xml_publisher_apis.process_kff_combination_1('flex_select_all', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'VALUE')  c_flexdata
        , fnd_flex_xml_publisher_apis.process_kff_combination_1('flex_select_all', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') c_flexdata_desc
        , hca.cust_account_id                           custid
        , decode(ara.status,'ACC','*' || al.meaning)    trans_type
        , acr.receipt_number                            invoice_number
        , acr.doc_sequence_value                        int_invoice_number
        , acr.receipt_date
        , al.lookup_code
        , acr.amount                                    orig_amt
        , nvl(acr.exchange_rate,1)                      orig_invoice_rate
        , substr(acr.currency_code,1,3)                 currency_code
        , sum(nvl(ara.amount_applied,0))                original_amount
        , sum(nvl(acr.exchange_rate,1) * nvl(ara.amount_applied,0)) historic_amount
        , sum(nvl(ara.amount_applied,0))
            * case '&lp_exchange_rate_type'
              when 'User'
              then :p_exchange_rate
              else case when gl_currency_api.get_rate_sql(acr.currency_code,gl.currency_code,:p_as_of_date,'&lp_exchange_rate_type') in (-1,-2)
                   then to_number(null)
                   else gl_currency_api.get_rate_sql(acr.currency_code,gl.currency_code,:p_as_of_date,'&lp_exchange_rate_type')
                   end
              end                                       closing_amount
        , case '&lp_exchange_rate_type'
          when 'User'
          then :p_exchange_rate
          else case when gl_currency_api.get_rate_sql(acr.currency_code,gl.currency_code,:p_as_of_date,'&lp_exchange_rate_type') in (-1,-2)
               then to_number(null)
               else gl_currency_api.get_rate_sql(acr.currency_code,gl.currency_code,:p_as_of_date,'&lp_exchange_rate_type')
               end
          end                                           exchange_rate
        from
          hr_operating_units         hou
        , gl_ledgers                 gl
        , ar_receivable_applications ara
        , ar_lookups                 al
        , ar_cash_receipts           acr
        , ar_cash_receipt_history    acrh
        , hz_cust_accounts           hca
        , gl_code_combinations       gcc
        , ar_distributions           ads
        , xla_distribution_links     xdl
        , xla_ae_lines               xal
        , gl_import_references       gir
        , gl_je_headers              gjh
        , ar_system_parameters       sp
        where
            hou.organization_id              = sp.org_id
        and hou.set_of_books_id              = sp.set_of_books_id
        and gl.ledger_id                     = sp.set_of_books_id
        and acr.org_id                       = hou.organization_id
        and acr.org_id                       = ara.org_id
        and hca.cust_account_id              = acr.pay_from_customer
        and acr.cash_receipt_id              = ara.cash_receipt_id
        and acrh.cash_receipt_id             = ara.cash_receipt_id
        and ara.cash_receipt_history_id      = acrh.cash_receipt_history_id
        and al.lookup_type                   = 'PAYMENT_TYPE'
        and ara.status                       = al.lookup_code
        and ara.status                       = 'ACC'
        and not exists
            ( select 'X'
              from ar_cash_receipt_history crhin
              where crhin.cash_receipt_id = acr.cash_receipt_id
              and crhin.status = 'REVERSED'
            )
        and nvl(ara.confirmed_flag,'Y')      = 'Y'
        and nvl(acr.confirmed_flag,'Y')      = 'Y'
        and ads.source_id                    = acrh.cash_receipt_history_id
        and xdl.source_distribution_id_num_1 = ads.line_id
        and xdl.application_id               = 222
        and xal.ae_header_id                 = xdl.ae_header_id
        and xal.ae_line_num                  = xdl.ae_line_num
        and xal.application_id               = 222
        and xal.accounting_class_code        = 'ACC'
        and gcc.code_combination_id          = xal.code_combination_id
        and gir.gl_sl_link_id                = xal.gl_sl_link_id
        and gir.gl_sl_link_table             = xal.gl_sl_link_table
        and gjh.je_header_id                 = gir.je_header_id
        and gjh.ledger_id                    = sp.set_of_books_id
        --and sp.org_id                        = :P_ORG_ID
        and gjh.status                       = 'P'
        and ara.gl_date                     <= :p_as_of_date
        and 2=2
        group by
          gl.name
        , gl.currency_code
        , hou.name
        , gcc.chart_of_accounts_id
        , gcc.code_combination_id
        , hca.cust_account_id
        , decode(ara.status,'ACC','*' || al.meaning)
        , acr.receipt_number
        , acr.doc_sequence_value
        , acr.receipt_date
        , al.lookup_code
        , acr.amount
        , nvl(acr.exchange_rate,1)
        , substr(acr.currency_code,1,3)
        , acr.currency_code
        having
          sum(ara.amount_applied) <> 0
        union
        select
          gl.name                                        ledger
        , hou.name                                       op_name
        , fnd_flex_xml_publisher_apis.process_kff_combination_1('flex_select_all', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE')  c_balancing
        , fnd_flex_xml_publisher_apis.process_kff_combination_1('flex_select_all', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE')  c_account
        , fnd_flex_xml_publisher_apis.process_kff_combination_1('flex_select_all', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'VALUE')  c_flexdata
        , fnd_flex_xml_publisher_apis.process_kff_combination_1('flex_select_all', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') c_flexdata_desc
        , hca.cust_account_id                            custid
        , decode(ara.status,'UNAPP','*' || al.meaning)   trans_type
        , acr.receipt_number                             invoice_number
        , acr.doc_sequence_value                         int_invoice_number
        , acr.receipt_date
        , al.lookup_code
        , acr.amount orig_amt
        , nvl(acr.exchange_rate,1)                       orig_invoice_rate
        , substr(acr.currency_code,1,3)                  currency_code
        , sum(ara.amount_applied)                        original_amount
        , sum(nvl(acr.exchange_rate,1) * nvl(ara.amount_applied,0)) historic_amount
        , sum(ara.amount_applied)
            * case '&lp_exchange_rate_type'
              when 'User'
              then :p_exchange_rate
              else case when gl_currency_api.get_rate_sql(acr.currency_code,gl.currency_code,:p_as_of_date,'&lp_exchange_rate_type') in (-1,-2)
                   then to_number(null)
                   else gl_currency_api.get_rate_sql(acr.currency_code,gl.currency_code,:p_as_of_date,'&lp_exchange_rate_type')
                   end
              end                                       closing_amount
        , case '&lp_exchange_rate_type'
          when 'User'
          then :p_exchange_rate
          else case when gl_currency_api.get_rate_sql(acr.currency_code,gl.currency_code,:p_as_of_date,'&lp_exchange_rate_type') in (-1,-2)
               then to_number(null)
               else gl_currency_api.get_rate_sql(acr.currency_code,gl.currency_code,:p_as_of_date,'&lp_exchange_rate_type')
               end
          end                                           exchange_rate
        from
          hr_operating_units         hou
        , gl_ledgers                 gl
        , ar_receivable_applications ara
        , ar_lookups                 al
        , ar_cash_receipts           acr
        , ar_cash_receipt_history    acrh
        , hz_cust_accounts           hca
        , gl_code_combinations       gcc
        , ar_distributions           ads
        , xla_distribution_links     xdl
        , xla_ae_lines               xal
        , gl_import_references       gir
        , gl_je_headers              gjh
        , ar_system_parameters       sp
        where
            hou.organization_id              = sp.org_id
        and hou.set_of_books_id              = sp.set_of_books_id
        and gl.ledger_id                     = sp.set_of_books_id
        and acr.org_id                       = hou.organization_id
        and acr.org_id                       = ara.org_id
        and hca.cust_account_id              = acr.pay_from_customer
        and acr.cash_receipt_id              = ara.cash_receipt_id
        and acrh.cash_receipt_id             = ara.cash_receipt_id
        and ara.cash_receipt_history_id      = acrh.cash_receipt_history_id
        and al.lookup_type                   = 'PAYMENT_TYPE'
        and ara.status                       = al.lookup_code
        and ara.status                       = 'UNAPP'
        and nvl(ara.confirmed_flag,'Y')      = 'Y'
        and nvl(acr.confirmed_flag,'Y')      = 'Y'
        and ads.source_id                    = acrh.cash_receipt_history_id
        and xdl.source_distribution_id_num_1 = ads.line_id
        and xdl.application_id               = 222
        and xal.ae_header_id                 = xdl.ae_header_id
        and xal.ae_line_num                  = xdl.ae_line_num
        and xal.application_id               = 222
        and xal.accounting_class_code        = 'UNAPP'
        and ads.source_type                 <> 'BANK_CHARGES'
        and ads.source_table                 = 'CRH'
        and xdl.source_distribution_type     = 'AR_DISTRIBUTIONS_ALL'
        and gcc.code_combination_id          = xal.code_combination_id
        and gir.gl_sl_link_id                = xal.gl_sl_link_id
        and gir.gl_sl_link_table             = xal.gl_sl_link_table
        and gjh.je_header_id                 = gir.je_header_id
        and gjh.ledger_id                    = sp.set_of_books_id
        --and sp.org_id                        = :P_ORG_ID
        and gjh.status                       = 'P'
        and not exists
            ( select 'X'
              from ar_cash_receipt_history crhin
              where crhin.cash_receipt_id = acr.cash_receipt_id
              and crhin.status = 'REVERSED'
            )
        and ara.gl_date                    <=:p_as_of_date
        and 2=2
        group by
          gl.name
        , gl.currency_code
        , hou.name
        , gcc.chart_of_accounts_id
        , gcc.code_combination_id
        , hca.cust_account_id
        , decode(ara.status,'UNAPP','*' || al.meaning)
        , acr.receipt_number
        , acr.doc_sequence_value
        , acr.receipt_date
        , al.lookup_code
        , acr.amount
        , nvl(acr.exchange_rate,1)
        , substr(acr.currency_code,1,3)
        , acr.currency_code
        having
          sum(ara.amount_applied) <> 0
      ) abc
    , hz_cust_accounts hca
    , hz_parties hp
    where
        hca.party_id = hp.party_id
    and hca.cust_account_id = abc.custid
    and 3=3
  ) trx
order by
  trx.ledger
, trx.c_balancing
, trx.c_account
, trx.c_flexdata
, trx.currency_code
, trx.customer_name
, trx.invoice_number