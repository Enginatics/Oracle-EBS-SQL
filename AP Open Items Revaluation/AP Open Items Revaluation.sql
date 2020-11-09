/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Open Items Revaluation
-- Description: Imported from BI Publisher
Description: Open Items Revaluation Report
Application: Payables
Source: Open Items Revaluation Report (XML)
Short Name: APOPITRN
DB package: AP_OPEN_ITEMS_REVAL_PKG
-- Excel Examle Output: https://www.enginatics.com/example/ap-open-items-revaluation/
-- Library Link: https://www.enginatics.com/reports/ap-open-items-revaluation/
-- Run Report: https://demo.enginatics.com/

select
 trx.ledger
,trx.balancing_segment
,trx.account_segment
,trx.account                    "Accounting Flexfield"
,trx.account_description  "Accouting Flexfield Desc."
&lp_report_format_cols
from
( 
select 
 (select sob.name from gl_ledgers sob where sob.ledger_id = :g_ledger_id) ledger, 
  balancing_segment   BALANCING_SEGMENT,
  account_segment     ACCOUNT_SEGMENT,
  opit.code_combination_id,
  account             ACCOUNT,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('account_description', 'SQLGL', 'GL#', :p_coa_id, NULL, opit.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') ACCOUNT_DESCRIPTION,
  party_id            PARTY_ID,
  party_site_id       PARTY_SITE_ID,
  vendor_id           VENDOR_ID,
  party_name          VENDOR_NAME,
  vendor_number       VENDOR_NUMBER,
  vendor_site_id      VENDOR_SITE_ID,
  vendor_site_code    VENDOR_SITE_CODE,
  txn_id              TXN_ID,
  txn_number           TXN_NUMBER,
  txn_type_lookup_code TXN_TYPE_LOOKUP_CODE,
  txn_date             TXN_DATE,
  txn_currency_code    TXN_CURRENCY_CODE,
  payment_currency_code PMT_CURRENCY_CODE,
  round(TXN_BASE_EXCHANGE_RATE, 5)         EXCHANGE_RATE,
  payment_cross_rate             PAYMENT_CROSS_RATE,
  decode(revaluation_rate,
         null, 'No Rate',
               round(revaluation_rate, 5)) REVALUATION_RATE,
  payment_status_flag   PAYMENT_STATUS_FLAG,
  entered_amount        ENTERED_AMOUNT,
  accounted_amount      ACCOUNTED_AMOUNT,
  open_entered_amount   OPEN_ENTERED_AMOUNT,
  open_accounted_amount OPEN_ACCOUNTED_AMOUNT,
  nvl(TO_CHAR(round(open_entered_amount * revaluation_rate, :g_base_precision)), '*') REVALUED_AMOUNT_DSP,
  nvl(round(open_entered_amount * revaluation_rate, :g_base_precision), 0) REVALUED_AMOUNT,
  case when revaluation_rate is null
            or open_accounted_amount > round(open_entered_amount * revaluation_rate, :g_base_precision)
      then open_accounted_amount
      else round(open_entered_amount * revaluation_rate, :g_base_precision)
  end                     OPEN_REVALUED_AMOUNT,
  AP_OPEN_ITEMS_REVAL_PKG.get_due_Date(txn_id, txn_type_lookup_code) DUE_dATE
from(
select  
  b.balancing_segment,
  b.account_segment,
  b.code_combination_id,
  b.account,
  b.party_id,
  b.party_site_id,
  b.party_name,
  b.vendor_id,
  b.vendor_number,
  b.vendor_site_id,
  b.vendor_site_code,
  b.txn_id,
  b.txn_number,
  b.txn_type_lookup_code,
  b.txn_date,
  b.txn_currency_code,
  b.payment_currency_code,
  b.TXN_BASE_EXCHANGE_RATE,
  b.payment_cross_rate,
  AP_OPEN_ITEMS_REVAL_PKG.get_revaluation_rate(b.txn_currency_code,
  b.payment_cross_rate_type) revaluation_rate,
  b.payment_status_flag,
  b.entered_amount,
  b.accounted_amount,
 nvl(round((pay_cur_inv_entered_amt - payment_entered_amount)/b.payment_cross_rate, 2), b.entered_amount) open_entered_amount,
  nvl(round(round((pay_cur_inv_entered_amt - payment_entered_amount)/b.payment_cross_rate, 2) * b.TXN_BASE_EXCHANGE_RATE, :g_base_precision), b.accounted_amount) open_accounted_amount
from
  (select /*+ leading (aoi aip) parallel(aoi)*/ distinct
      aoi.code_combination_id,
      aoi.party_id,
      aoi.party_site_id,
      aoi.vendor_id,
      aoi.vendor_number,
      aoi.vendor_site_id,
      aoi.txn_id invoice_id,
      aoi.txn_currency_code,
      aoi.payment_currency_code,
      aoi.TXN_BASE_EXCHANGE_RATE,
      aoi.payment_cross_rate,
      aoi.txn_type_lookup_code, --bug13613111
      round(aoi.entered_amount * aoi.payment_cross_rate, 2) pay_cur_inv_entered_amt,
      sum((nvl(aip.amount, 0) + nvl(aip.discount_taken, 0))) payment_entered_amount
    from 
      ap_open_items_reval_gt aoi,
      ap_invoice_payments_all aip,
      ap_checks_all ac
    where aip.invoice_id = aoi.txn_id
      and aip.set_of_books_id = :g_ledger_id
      and aip.org_id = :p_org_id
      and ac.check_id = aip.check_id
      and aip.accounting_date <= :g_revaluation_date
      and aoi.txn_type_lookup_code <> 'Payment'
      &lp_cleared_items_clause1
    group by 
      aoi.code_combination_id,
      aoi.party_id,
      aoi.party_site_id,
      aoi.vendor_id,
      aoi.vendor_number,
      aoi.vendor_site_id,
      aoi.txn_id ,
      aoi.txn_currency_code,
      aoi.payment_currency_code,
      aoi.TXN_BASE_EXCHANGE_RATE,
      aoi.payment_cross_rate,
      aoi.entered_amount,
      aoi.txn_type_lookup_code
  )a, 
  ap_open_items_reval_gt b
where b.txn_id = a.invoice_id(+)
  and b.txn_type_lookup_code = a.txn_type_lookup_code(+)
  and b.code_combination_id = a.code_combination_id(+)
  and nvl((a.pay_cur_inv_entered_amt - a.payment_entered_amount), b.entered_amount) <> 0
  and decode(nvl(sign(abs(a.pay_cur_inv_entered_amt - a.payment_entered_amount)-1), 1),-1, decode(nvl(b.payment_status_flag, 'N'),'Y', 0, 1), 1) <> 0 
  and :p_transfer_to_gl_only = 'N'
union
select /*+ parallal b */distinct
b.balancing_segment,
b.account_segment,
b.code_combination_id,
b.account,
b.party_id,
b.party_site_id,
b.party_name,
b.vendor_id,
b.vendor_number,
b.vendor_site_id,
b.vendor_site_code,
b.txn_id,
b.txn_number,
b.txn_type_lookup_code,
b.txn_date,
b.txn_currency_code,
b.payment_currency_code,
b.TXN_BASE_EXCHANGE_RATE,
b.payment_cross_rate,
AP_OPEN_ITEMS_REVAL_PKG.get_revaluation_rate(b.txn_currency_code,
b.payment_cross_rate_type) revaluation_rate,
b.payment_status_flag,
b.entered_amount,
b.accounted_amount,
b.entered_amount - sum(nvl(a.entered_amount, 0)) open_entered_amount,
b.accounted_amount - sum(nvl(a.accounted_amount, 0)) open_accounted_amount
from
( select /*+ parallel(aoi) leading(aoi)*/ distinct
    200 application_id,
    null ref_ae_header_id,
    null temp_line_num,
    xah.ae_header_id,
    xal.ae_line_num,
    aoi.code_combination_id,
    aoi.account,
    aoi.txn_id invoice_id,
    aoi.txn_base_exchange_rate,
    aoi.txn_type_lookup_code,
    txn_amount invoice_amount,
    txn_base_amount invoice_base_amount,
    nvl(xal.entered_dr, 0) - nvl(xal.entered_cr, 0) entered_amount,
    nvl(xal.accounted_dr, 0) - nvl(xal.accounted_cr, 0) accounted_amount
  from ap_open_items_reval_gt aoi,
       ap_checks_all ac,
       xla_transaction_entities xte,
       xla_ae_headers xah,
       xla_ae_lines xal
  where 1=1
   and ac.check_id IN (select bk.check_id
                         from ap_invoice_payments_all bk
                        where bk.invoice_id = aoi.txn_id)
   and nvl(xte.source_id_int_1, -99) = ac.check_id
   and nvl(xte.security_id_int_1, -99) = :p_org_id
   and xte.ledger_id = :g_ledger_id
   and xte.entity_code = 'AP_PAYMENTS'
   and xte.application_id = 200
   and xah.entity_id = xte.entity_id
   and xah.ledger_id = :g_ledger_id
   and xah.gl_transfer_status_code = 'Y'
   and xah.event_type_code <> 'MANUAL'
   and xah.application_id = 200
   and xah.accounting_date <= :g_revaluation_date
   and xah.upg_batch_id is not null
   and xal.ae_header_id = xah.ae_header_id
   and xal.code_combination_id = aoi.code_combination_id
   and xal.accounting_class_code= 'LIABILITY'
   and xal.application_id = 200
   and ((xal.source_table = 'AP_INVOICE_PAYMENTS'
         and exists (select 1
                       from ap_invoice_payments_all aip
                      where aip.invoice_id = aoi.txn_id
                        and aip.invoice_payment_id = xal.source_id)
        )
        or
        (xal.source_table = 'AP_INVOICES'
         and xal.source_id = aoi.txn_id
        )
        or
        (xal.source_table = 'AP_INVOICE_DISTRIBUTIONS'
   and exists (select 1
                       from ap_invoice_distributions_all aid
            where aid.invoice_id = aoi.txn_id
                        and aid.invoice_distribution_id = xal.source_id)
        )
       )
   and aoi.txn_type_lookup_code <> 'Payment'
   and :p_transfer_to_gl_only = 'Y'
   &lp_cleared_items_clause1
union
  select /*+ leading (aoi aip xte xah xal xdl) parallel(aoi)*/ distinct
    xdl.application_id,
    xdl.ref_ae_header_id,
    xdl.temp_line_num,
    xdl.ae_header_id,
    null ae_line_num,
    aoi.code_combination_id,
    aoi.account,
    aip.invoice_id,
    aoi.TXN_BASE_EXCHANGE_RATE,
    aoi.txn_type_lookup_code,
    txn_amount invoice_amount,
    txn_base_amount invoice_base_amount,
    nvl(xdl.unrounded_entered_dr, 0) - nvl(xdl.unrounded_entered_cr, 0) entered_amount,
    nvl(xdl.unrounded_accounted_dr, 0) - nvl(xdl.unrounded_accounted_cr, 0) accounted_amount
  from ap_open_items_reval_gt aoi,
       ap_invoice_payments_all aip,
       ap_checks_all ac,
       xla_transaction_entities xte,
       xla_ae_headers xah,
       xla_ae_lines xal,
       xla_distribution_links xdl
 where aip.invoice_id = aoi.txn_id
   and nvl(xte.source_id_int_1, -99) = aip.check_id
   and nvl(xte.security_id_int_1, -99) = :p_org_id
   and aip.set_of_books_id = :g_ledger_id
   and aip.org_id = :p_org_id
   and xte.ledger_id = :g_ledger_id
   and ac.check_id = aip.check_id
   and xah.entity_id = xte.entity_id
   and xah.ledger_id = :g_ledger_id
   and xah.gl_transfer_status_code = 'Y'
   and xah.event_type_code <> 'MANUAL'
   and xah.application_id = 200
   and xte.application_id = 200
   and xte.entity_code = 'AP_PAYMENTS'
   and xah.accounting_date <= :g_revaluation_date
   and xah.upg_batch_id is null
   and xal.ae_header_id = xah.ae_header_id
   and xdl.ae_header_id = xah.ae_header_id
   and xdl.ae_line_num = xal.ae_line_num
   and xal.code_combination_id = aoi.code_combination_id
   and xdl.applied_to_source_id_num_1 = aip.invoice_id
   and xal.accounting_class_code = 'LIABILITY'
   and xdl.applied_to_entity_code = 'AP_INVOICES'
   and xdl.application_id = 200
   and aoi.txn_type_lookup_code <> 'Payment'
   &lp_cleared_items_clause1
  )a,
   ap_open_items_reval_gt b
where b.txn_id = a.invoice_id(+)
  and b.txn_type_lookup_code = a.txn_type_lookup_code(+)
  and b.code_combination_id = a.code_combination_id(+)
  and :p_transfer_to_gl_only = 'Y'
group by b.balancing_segment,
  b.account_segment,
  b.code_combination_id,
  b.account,
  b.party_id,
  b.party_site_id,
  b.party_name,
  b.vendor_id,
  b.vendor_number,
  b.vendor_site_id,
  b.vendor_site_code,
  b.txn_id,
  b.txn_number,
  b.txn_type_lookup_code,
  b.txn_date,
  b.txn_currency_code,
  b.payment_currency_code,
  b.TXN_BASE_EXCHANGE_RATE,
  b.payment_cross_rate,
  b.payment_cross_rate_type,
  b.payment_status_flag,
  b.entered_amount,
  b.accounted_amount
having b.entered_amount <> sum(nvl(a.entered_amount, 0))
        or b.accounted_amount <> sum(nvl(a.accounted_amount, 0)) 
) opit
order by balancing_segment,
   account_segment,
   account,
   party_name,
   vendor_number,
   vendor_site_code,
   txn_number,
   txn_type_lookup_code,
   txn_date
) trx
&lp_group_by_cols