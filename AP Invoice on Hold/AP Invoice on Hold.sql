/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Invoice on Hold
-- Description: Imported Oracle standard invoice on hold report
Source: Invoice on Hold Report (XML)
Short Name: APXINROH_XML
DB package: AP_APXINROH_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/ap-invoice-on-hold/
-- Library Link: https://www.enginatics.com/reports/ap-invoice-on-hold/
-- Run Report: https://demo.enginatics.com/

select
 :c_company_name_header "Company Name"
,x.C_HOLD_TYPE "Hold Type"
,x.C_NLS_HOLD_CODE "Hold Name"
,x.C_HOLD_CODE "Hold Code"
&C_DETAIL_NLS_HOLD_DESC
,x.C_BATCH_NAME "Batch Name"
,x.C_VENDOR_NAME "Trading Partner"
,x.C_VENDOR_SITE "Site"
,x.C_INVOICE_NUM "Invoice Number"
,(SELECT distinct poh.segment1
   FROM  po_headers poh,
	       po_line_locations poll,
	       ap_holds ah
   WHERE  ah.release_lookup_code   IS NULL
   AND   	ah.line_location_id = poll.line_location_id
   AND   	poll.po_header_id = poh.po_header_id
   AND    ah.invoice_id = x.C_INVOICE_ID
   AND    rownum <= 1
 )  "PO Number"
,x.C_MONTH_NAME "Invoice Month"
,x.C_INVOICE_DATE "Invoice Date"
,x.C_ORIGINAL_AMOUNT "Original Amount (Func Curr)"
,x.C_AMOUNT_REMAINING "Amount Remaining (Func Curr)"
,NVL( (select distinct listagg(description,', ') within group (order by description) description
       from
        (
           select distinct
             aid.invoice_id
           , ah.hold_lookup_code
           , AP_UTILITIES_PKG.get_charge_account(aid.DIST_CODE_COMBINATION_ID,gls.chart_of_accounts_id,'APXINROH') description
           from
             ap_invoice_distributions aid
    	     , gl_sets_of_books         gls
    	     , ap_holds                 ah
    	     where
    	         :P_INVALID_DIST_ACC     ='Y'
    	     and ah.hold_lookup_code     = 'DIST ACCT INVALID'
    	     and ah.release_lookup_code IS NULL
    	     and aid.invoice_id          = ah.invoice_id
    	     and gls.set_of_books_id     = aid.set_of_books_id
           and (
                 EXISTS (select 'x'
                  from gl_code_combinations C
                  where aid.dist_code_combination_id = C.code_combination_id (+)
                  and (C.code_combination_id is null
                         or C.detail_posting_allowed_flag = 'N'
                         or trunc(C.start_date_active) > aid.accounting_date
                         or trunc(C.end_date_active) < aid.accounting_date
                         or C.template_id is not null
                         or C.enabled_flag <> 'Y'
                         or C.summary_flag <>'N'
                         ))
                OR
                  (aid.dist_code_combination_id = -1)
               )
        ) d
       where
           d.invoice_id        = x.C_INVOICE_ID
       and d.hold_lookup_code  = x.C_HOLD_CODE
      )
    , x.C_DESCRIPTION
    ) "Description"
from
(
SELECT -- Invoices on Hold
  decode(:P_ORDER_BY, 'Hold Name','Do not sort by vendor name', decode(:SORT_BY_ALTERNATE, 'Y', upper(hp.organization_name_phonetic), upper(hp.party_name))) C_SORT_VENDOR_NAME,
  decode(:P_ORDER_BY, 'Vendor Name','Do not sort by Hold Name', upper(decode(h.hold_lookup_code, null,:C_NLS_NA, alc.displayed_field))) C_SORT_NLS_HOLD_CODE1,
  hp.party_name C_VENDOR_NAME,
  inv1.vendor_id C_VENDOR_ID,
  VS.vendor_site_code C_VENDOR_SITE,
  decode(h.hold_lookup_code, null,:C_NLS_NA, h.hold_lookup_code)  C_HOLD_CODE,
  decode(h.hold_lookup_code, null,:C_NLS_NA, alc.displayed_field) C_NLS_HOLD_CODE,
  decode(h.hold_lookup_code, null,:C_NLS_NA, alc.description)     C_NLS_HOLD_DESC,
  decode(ahc.postable_flag,'Y',:c_nls_yes,:c_nls_no)              C_POSTABLE,
  to_char(inv1.invoice_date,'YYYYMM') C_SORT_MONTH,
  to_char(inv1.invoice_date,'fmMonth YYYY') C_MONTH_NAME,
  inv1.invoice_date C_INVOICE_DATE,
  B.batch_name C_BATCH_NAME,
  inv1.invoice_id C_INVOICE_ID,
  inv1.invoice_num C_INVOICE_NUM,
  DECODE(inv1.invoice_currency_code, :C_BASE_CURRENCY_CODE, inv1.invoice_amount, inv1.base_amount) C_ORIGINAL_AMOUNT,
  DECODE(inv1.invoice_currency_code,
                 :C_BASE_CURRENCY_CODE, inv1.invoice_amount,
                inv1.base_amount) -
    DECODE(inv1.payment_currency_code,
                 :C_BASE_CURRENCY_CODE,
                      nvl(inv1.amount_paid,0) + NVL(discount_amount_taken,0),
                 DECODE(F.minimum_accountable_unit,
                       NULL, ROUND(((DECODE(inv1.payment_cross_rate_type,
                                                 'EMU FIXED', 1/inv1.payment_cross_rate,
                                                 inv1.exchange_rate)) *
                                                  nvl(inv1.amount_paid,0)),
                                                 F.precision),
                       ROUND(((DECODE(inv1.payment_cross_rate_type,
                                       'EMU FIXED', 1/inv1.payment_cross_rate,
                                       inv1.exchange_rate)) * nvl(inv1.amount_paid,0)) /
                                       F.minimum_accountable_unit) *
                                       F.minimum_accountable_unit)   +
                DECODE(F.minimum_accountable_unit,
                     NULL, ROUND(((DECODE(inv1.payment_cross_rate_type,
                                               'EMU FIXED', 1/inv1.payment_cross_rate,
                                              inv1.exchange_rate)) *
                                              NVL(inv1.discount_amount_taken,0)),
                                              F.precision),
                    ROUND(((DECODE(inv1.payment_cross_rate_type,
                                    'EMU FIXED', 1/inv1.payment_cross_rate,
                                    inv1.exchange_rate)) *
                                    nvl(inv1.discount_amount_taken,0)) /
                                    F.minimum_accountable_unit) *
                                    F.minimum_accountable_unit))
                 C_AMOUNT_REMAINING,
  inv1.description C_DESCRIPTION,
  'Invoice Hold' C_HOLD_TYPE
FROM
  hz_parties hp,
  ap_supplier_sites VS,
  ap_invoices inv1,
  ap_batches B,
  ap_payment_schedules S,
  ap_holds h,
  ap_hold_codes ahc,
  ap_lookup_codes alc,
  fnd_currencies_vl F
WHERE
      hp.party_id = inv1.party_id
  AND VS.vendor_id (+) = inv1.vendor_id
  AND VS.vendor_site_id (+) = inv1.vendor_site_id
  AND h.invoice_id = inv1.invoice_id
  AND B.batch_id(+) = inv1.batch_id
  AND S.invoice_id(+) = inv1.invoice_id
  AND h.hold_lookup_code = nvl(:P_HOLD_CODE,h.hold_lookup_code)
  AND h.release_lookup_code IS NULL
  AND F.currency_code = :C_BASE_CURRENCY_CODE &c_vendor_clause
  AND trunc(inv1.creation_date) >= DECODE(:P_START_CREATION_DATE, null,trunc(inv1.creation_date), :P_START_CREATION_DATE)
  AND trunc(inv1.creation_date) <= DECODE(:P_END_CREATION_DATE, null,trunc(inv1.creation_date), :P_END_CREATION_DATE)
  AND   (
         (NVL(S.due_date, sysdate) >= DECODE(:P_START_DUE_DATE, null,
             NVL(S.due_date, sysdate), :P_START_DUE_DATE)
         AND NVL(S.due_date, sysdate) <= DECODE(:P_END_DUE_DATE, null,
             NVL(S.due_date, sysdate), :P_END_DUE_DATE) )
         AND
         ( (NVL(S.discount_date, sysdate) >=
                   DECODE(:P_START_DISCOUNT_DATE, null,
         NVL(S.discount_date, sysdate), :P_START_DISCOUNT_DATE)
            AND NVL(S.discount_date, sysdate) <=
                    DECODE(:P_END_DISCOUNT_DATE, null,
         NVL(S.discount_date, sysdate), :P_END_DISCOUNT_DATE) )
            OR
                (NVL(S.second_discount_date, sysdate) >=
                     DECODE(:P_START_DISCOUNT_DATE, null,
            NVL(S.second_discount_date, sysdate),:P_START_DISCOUNT_DATE)
            AND NVL(S.second_discount_date, sysdate) <=
                     DECODE(:P_END_DISCOUNT_DATE, null,
             NVL(S.second_discount_date, sysdate), :P_END_DISCOUNT_DATE) )
            OR
               (NVL(S.third_discount_date, sysdate) >=
                     DECODE(:P_START_DISCOUNT_DATE, null,
            NVL(S.third_discount_date, sysdate), :P_START_DISCOUNT_DATE)
            AND NVL(S.third_discount_date, sysdate) <=
                    DECODE(:P_END_DISCOUNT_DATE, null,
            NVL(S.third_discount_date, sysdate), :P_END_DISCOUNT_DATE) )
         )
        )
  AND alc.lookup_type = 'HOLD CODE'
  AND alc.lookup_code = h.hold_lookup_code
  AND ahc.hold_lookup_code = h.hold_lookup_code
GROUP BY
  decode(:P_ORDER_BY, 'Hold Name','Do not sort by vendor name', decode(:SORT_BY_ALTERNATE, 'Y', upper(hp.organization_name_phonetic), upper(hp.party_name))),
  decode(:P_ORDER_BY, 'Vendor Name','Do not sort by Hold Name', upper(decode(h.hold_lookup_code, null,:C_NLS_NA, alc.displayed_field))),
  h.hold_lookup_code,
  alc.displayed_field,
  alc.description,
  ahc.postable_flag,
  hp.party_name,
  inv1.vendor_id,
  VS.vendor_site_code,
  inv1.invoice_date,
  inv1.invoice_id,
  B.batch_name,
  inv1.invoice_num,
  DECODE(inv1.invoice_currency_code, :C_BASE_CURRENCY_CODE, inv1.invoice_amount, inv1.base_amount),
  DECODE(inv1.invoice_currency_code,
                 :C_BASE_CURRENCY_CODE, inv1.invoice_amount,
                inv1.base_amount) -
    DECODE(inv1.payment_currency_code,
                 :C_BASE_CURRENCY_CODE,
                      nvl(inv1.amount_paid,0) + NVL(discount_amount_taken,0),
                 DECODE(F.minimum_accountable_unit,
                       NULL, ROUND(((DECODE(inv1.payment_cross_rate_type,
                                                 'EMU FIXED', 1/inv1.payment_cross_rate,
                                                 inv1.exchange_rate)) *
                                                  nvl(inv1.amount_paid,0)),
                                                 F.precision),
                       ROUND(((DECODE(inv1.payment_cross_rate_type,
                                       'EMU FIXED', 1/inv1.payment_cross_rate,
                                       inv1.exchange_rate)) * nvl(inv1.amount_paid,0)) /
                                       F.minimum_accountable_unit) *
                                       F.minimum_accountable_unit)   +
                DECODE(F.minimum_accountable_unit,
                     NULL, ROUND(((DECODE(inv1.payment_cross_rate_type,
                                               'EMU FIXED', 1/inv1.payment_cross_rate,
                                              inv1.exchange_rate)) *
                                              NVL(inv1.discount_amount_taken,0)),
                                              F.precision),
                    ROUND(((DECODE(inv1.payment_cross_rate_type,
                                    'EMU FIXED', 1/inv1.payment_cross_rate,
                                    inv1.exchange_rate)) *
                                    nvl(inv1.discount_amount_taken,0)) /
                                    F.minimum_accountable_unit) *
                                    F.minimum_accountable_unit)),
  inv1.description
UNION
SELECT -- Payments on Hold
  decode(:P_ORDER_BY, 'Hold Name','Do not sort by vendor name', decode(:SORT_BY_ALTERNATE, 'Y', upper(hp.organization_name_phonetic), upper(hp.party_name))) C_SORT_VENDOR_NAME,
  decode(:P_ORDER_BY, 'Vendor Name','Do not sort by Hold Name', :C_NLS_NA) C_SORT_NLS_HOLD_CODE1,
  hp.party_name C_VENDOR_NAME,
  inv1.vendor_id C_VENDOR_ID,
  VS.vendor_site_code C_VENDOR_SITE,
  :C_NLS_NA        C_HOLD_CODE,
  :C_NLS_NA        C_NLS_HOLD_CODE,
  :C_NLS_NA        C_NLS_HOLD_DESC,
  :C_NLS_NA        C_POSTABLE,
  to_char(inv1.invoice_date,'YYYYMM') C_SORT_MONTH,
  to_char(inv1.invoice_date,'fmMonth YYYY') C_MONTH_NAME,
  inv1.invoice_date C_INVOICE_DATE,
  B.batch_name C_BATCH_NAME,
  inv1.invoice_id C_NR_INVOICE_ID,
  inv1.invoice_num C_INVOICE_NUM,
  DECODE(inv1.invoice_currency_code, :C_BASE_CURRENCY_CODE, inv1.invoice_amount, inv1.base_amount) C_ORIGINAL_AMOUNT,
  DECODE(inv1.invoice_currency_code, :C_BASE_CURRENCY_CODE, inv1.invoice_amount,inv1.base_amount) -
    DECODE(inv1.payment_currency_code,
                 :C_BASE_CURRENCY_CODE,
                      nvl(inv1.amount_paid,0) + NVL(discount_amount_taken,0),
                 DECODE(F.minimum_accountable_unit,
                       NULL, ROUND(((DECODE(inv1.payment_cross_rate_type,
                                                 'EMU FIXED', 1/inv1.payment_cross_rate,
                                                 inv1.exchange_rate)) *
                                                  nvl(inv1.amount_paid,0)),
                                                 F.precision),
                       ROUND(((DECODE(inv1.payment_cross_rate_type,
                                       'EMU FIXED', 1/inv1.payment_cross_rate,
                                       inv1.exchange_rate)) * nvl(inv1.amount_paid,0)) /
                                       F.minimum_accountable_unit) *
                                       F.minimum_accountable_unit)   +
                DECODE(F.minimum_accountable_unit,
                     NULL, ROUND(((DECODE(inv1.payment_cross_rate_type,
                                               'EMU FIXED', 1/inv1.payment_cross_rate,
                                              inv1.exchange_rate)) *
                                              NVL(inv1.discount_amount_taken,0)),
                                              F.precision),
                    ROUND(((DECODE(inv1.payment_cross_rate_type,
                                    'EMU FIXED', 1/inv1.payment_cross_rate,
                                    inv1.exchange_rate)) *
                                    nvl(inv1.discount_amount_taken,0)) /
                                    F.minimum_accountable_unit) *
                                    F.minimum_accountable_unit)) C_AMOUNT_REMAINING,
  MAX(s.iby_hold_reason) C_DESCRIPTION,
  'Scheduled Payment Hold' C_HOLD_TYPE
FROM
  hz_parties hp,
  ap_supplier_sites VS,
  ap_invoices inv1,
  ap_batches B,
  ap_payment_schedules S,
  fnd_currencies_vl F
WHERE
      hp.party_id = inv1.party_id
  AND VS.vendor_id (+) = inv1.vendor_id
  AND VS.vendor_site_id (+) = inv1.vendor_site_id
  AND B.batch_id(+) = inv1.batch_id
  AND S.invoice_id = inv1.invoice_id
  AND S.hold_flag = 'Y'
  AND F.currency_code = :C_BASE_CURRENCY_CODE &c_vendor_clause
  AND trunc(inv1.creation_date) >= DECODE(:P_START_CREATION_DATE, null,trunc(inv1.creation_date), :P_START_CREATION_DATE)
  AND trunc(inv1.creation_date) <= DECODE(:P_END_CREATION_DATE, null,trunc(inv1.creation_date), :P_END_CREATION_DATE)
  AND   (
         (NVL(S.due_date, sysdate) >= DECODE(:P_START_DUE_DATE, null,
             NVL(S.due_date, sysdate), :P_START_DUE_DATE)
         AND NVL(S.due_date, sysdate) <= DECODE(:P_END_DUE_DATE, null,
             NVL(S.due_date, sysdate), :P_END_DUE_DATE) )
         AND
         ( (NVL(S.discount_date, sysdate) >=
                   DECODE(:P_START_DISCOUNT_DATE, null,
         NVL(S.discount_date, sysdate), :P_START_DISCOUNT_DATE)
            AND NVL(S.discount_date, sysdate) <=
                    DECODE(:P_END_DISCOUNT_DATE, null,
         NVL(S.discount_date, sysdate), :P_END_DISCOUNT_DATE) )
            OR
                (NVL(S.second_discount_date, sysdate) >=
                     DECODE(:P_START_DISCOUNT_DATE, null,
            NVL(S.second_discount_date, sysdate),:P_START_DISCOUNT_DATE)
            AND NVL(S.second_discount_date, sysdate) <=
                     DECODE(:P_END_DISCOUNT_DATE, null,
             NVL(S.second_discount_date, sysdate), :P_END_DISCOUNT_DATE) )
            OR
               (NVL(S.third_discount_date, sysdate) >=
                     DECODE(:P_START_DISCOUNT_DATE, null,
            NVL(S.third_discount_date, sysdate), :P_START_DISCOUNT_DATE)
            AND NVL(S.third_discount_date, sysdate) <=
                    DECODE(:P_END_DISCOUNT_DATE, null,
            NVL(S.third_discount_date, sysdate), :P_END_DISCOUNT_DATE) )
         )
        )
GROUP BY
  decode(:P_ORDER_BY, 'Hold Name','Do not sort by vendor name', decode(:SORT_BY_ALTERNATE, 'Y', upper(hp.organization_name_phonetic), upper(hp.party_name))),
  decode(:P_ORDER_BY, 'Vendor Name','Do not sort by Hold Name', :C_NLS_NA),
  hp.party_name,
  inv1.vendor_id,
  VS.vendor_site_code,
  VS.vendor_site_code,
  inv1.invoice_date,
  inv1.invoice_id,
  B.batch_name,
  inv1.invoice_num,
  DECODE(inv1.invoice_currency_code, :C_BASE_CURRENCY_CODE, inv1.invoice_amount, inv1.base_amount),
  DECODE(inv1.invoice_currency_code, :C_BASE_CURRENCY_CODE, inv1.invoice_amount,inv1.base_amount) -
    DECODE(inv1.payment_currency_code,
                 :C_BASE_CURRENCY_CODE,
                      nvl(inv1.amount_paid,0) + NVL(discount_amount_taken,0),
                 DECODE(F.minimum_accountable_unit,
                       NULL, ROUND(((DECODE(inv1.payment_cross_rate_type,
                                                 'EMU FIXED', 1/inv1.payment_cross_rate,
                                                 inv1.exchange_rate)) *
                                                  nvl(inv1.amount_paid,0)),
                                                 F.precision),
                       ROUND(((DECODE(inv1.payment_cross_rate_type,
                                       'EMU FIXED', 1/inv1.payment_cross_rate,
                                       inv1.exchange_rate)) * nvl(inv1.amount_paid,0)) /
                                       F.minimum_accountable_unit) *
                                       F.minimum_accountable_unit)   +
                DECODE(F.minimum_accountable_unit,
                     NULL, ROUND(((DECODE(inv1.payment_cross_rate_type,
                                               'EMU FIXED', 1/inv1.payment_cross_rate,
                                              inv1.exchange_rate)) *
                                              NVL(inv1.discount_amount_taken,0)),
                                              F.precision),
                    ROUND(((DECODE(inv1.payment_cross_rate_type,
                                    'EMU FIXED', 1/inv1.payment_cross_rate,
                                    inv1.exchange_rate)) *
                                    nvl(inv1.discount_amount_taken,0)) /
                                    F.minimum_accountable_unit) *
                                    F.minimum_accountable_unit))
UNION
SELECT -- Vendor Sites on Hold
  decode(:P_ORDER_BY, 'Hold Name','Do not sort by vendor name', decode(:SORT_BY_ALTERNATE, 'Y', upper(hp.organization_name_phonetic), upper(hp.party_name))) C_SORT_VENDOR_NAME,
  decode(:P_ORDER_BY, 'Vendor Name','Do not sort by Hold Name', :C_NLS_NA) C_SORT_NLS_HOLD_CODE1,
  hp.party_name C_VENDOR_NAME,
  V.vendor_id C_VENDOR_ID,
  VS.vendor_site_code C_VENDOR_SITE,
  :C_NLS_NA        C_HOLD_CODE,
  :C_NLS_NA        C_NLS_HOLD_CODE,
  :C_NLS_NA        C_NLS_HOLD_DESC,
  :C_NLS_NA        C_POSTABLE,
  to_char(inv1.invoice_date,'YYYYMM') C_SORT_MONTH,
  to_char(inv1.invoice_date,'fmMonth YYYY') C_MONTH_NAME,
  inv1.invoice_date C_INVOICE_DATE,
  B.batch_name C_BATCH_NAME,
  inv1.invoice_id C_INVOICE_ID,
  inv1.invoice_num C_INVOICE_NUM,
  DECODE(inv1.invoice_currency_code, :C_BASE_CURRENCY_CODE, inv1.invoice_amount, inv1.base_amount) C_ORIGINAL_AMOUNT,
  DECODE(inv1.invoice_currency_code,:C_BASE_CURRENCY_CODE, inv1.invoice_amount,inv1.base_amount) -
    DECODE(inv1.payment_currency_code,
                 :C_BASE_CURRENCY_CODE,
                      nvl(inv1.amount_paid,0) + NVL(discount_amount_taken,0),
                 DECODE(F.minimum_accountable_unit,
                       NULL, ROUND(((DECODE(inv1.payment_cross_rate_type,
                                                 'EMU FIXED', 1/inv1.payment_cross_rate,
                                                 inv1.exchange_rate)) *
                                                  nvl(inv1.amount_paid,0)),
                                                 F.precision),
                       ROUND(((DECODE(inv1.payment_cross_rate_type,
                                       'EMU FIXED', 1/inv1.payment_cross_rate,
                                       inv1.exchange_rate)) * nvl(inv1.amount_paid,0)) /
                                       F.minimum_accountable_unit) *
                                       F.minimum_accountable_unit)   +
                DECODE(F.minimum_accountable_unit,
                     NULL, ROUND(((DECODE(inv1.payment_cross_rate_type,
                                               'EMU FIXED', 1/inv1.payment_cross_rate,
                                              inv1.exchange_rate)) *
                                              NVL(inv1.discount_amount_taken,0)),
                                              F.precision),
                    ROUND(((DECODE(inv1.payment_cross_rate_type,
                                    'EMU FIXED', 1/inv1.payment_cross_rate,
                                    inv1.exchange_rate)) *
                                    nvl(inv1.discount_amount_taken,0)) /
                                    F.minimum_accountable_unit) *
                                    F.minimum_accountable_unit)) C_AMOUNT_REMAINING,
  inv1.description C_DESCRIPTION,
  'Supplier Site Hold' C_HOLD_TYPE
FROM
  hz_parties hp,
  ap_suppliers V,
  ap_supplier_sites VS,
  ap_invoices inv1,
  ap_batches B,
  ap_payment_schedules S,
  fnd_currencies_vl F
WHERE
  hp.party_id = inv1.party_id
  AND V.vendor_id (+) = inv1.vendor_id
  AND VS.vendor_id (+) = inv1.vendor_id
  AND VS.vendor_site_id (+) = inv1.vendor_site_id
  AND B.batch_id(+) = inv1.batch_id
  AND S.invoice_id(+) = inv1.invoice_id
  AND VS.hold_all_payments_flag = 'Y'
  AND F.currency_code = :C_BASE_CURRENCY_CODE
  AND inv1.cancelled_date IS NULL
  AND inv1.payment_status_flag != 'Y' &c_vendor_clause
  AND trunc(inv1.creation_date) >= DECODE(:P_START_CREATION_DATE, null,trunc(inv1.creation_date), :P_START_CREATION_DATE)
  AND trunc(inv1.creation_date) <= DECODE(:P_END_CREATION_DATE, null,trunc(inv1.creation_date), :P_END_CREATION_DATE)
  AND   (
         (NVL(S.due_date, sysdate) >= DECODE(:P_START_DUE_DATE, null,
             NVL(S.due_date, sysdate), :P_START_DUE_DATE)
         AND NVL(S.due_date, sysdate) <= DECODE(:P_END_DUE_DATE, null,
             NVL(S.due_date, sysdate), :P_END_DUE_DATE) )
         AND
         ( (NVL(S.discount_date, sysdate) >=
                   DECODE(:P_START_DISCOUNT_DATE, null,
         NVL(S.discount_date, sysdate), :P_START_DISCOUNT_DATE)
            AND NVL(S.discount_date, sysdate) <=
                    DECODE(:P_END_DISCOUNT_DATE, null,
         NVL(S.discount_date, sysdate), :P_END_DISCOUNT_DATE) )
            OR
                (NVL(S.second_discount_date, sysdate) >=
                     DECODE(:P_START_DISCOUNT_DATE, null,
            NVL(S.second_discount_date, sysdate),:P_START_DISCOUNT_DATE)
            AND NVL(S.second_discount_date, sysdate) <=
                     DECODE(:P_END_DISCOUNT_DATE, null,
             NVL(S.second_discount_date, sysdate), :P_END_DISCOUNT_DATE) )
            OR
               (NVL(S.third_discount_date, sysdate) >=
                     DECODE(:P_START_DISCOUNT_DATE, null,
            NVL(S.third_discount_date, sysdate), :P_START_DISCOUNT_DATE)
            AND NVL(S.third_discount_date, sysdate) <=
                    DECODE(:P_END_DISCOUNT_DATE, null,
            NVL(S.third_discount_date, sysdate), :P_END_DISCOUNT_DATE) )
         )
        )
GROUP BY
  decode(:P_ORDER_BY, 'Hold Name','Do not sort by vendor name', decode(:SORT_BY_ALTERNATE, 'Y', upper(hp.organization_name_phonetic), upper(hp.party_name))),
  decode(:P_ORDER_BY, 'Vendor Name','Do not sort by Hold Name', :C_NLS_NA),
  hp.party_name,
  V.vendor_id,
  VS.vendor_site_code,
  B.batch_name,
  inv1.invoice_date,
  inv1.invoice_id,
  inv1.invoice_num,
  DECODE(inv1.invoice_currency_code, :C_BASE_CURRENCY_CODE, inv1.invoice_amount, inv1.base_amount),
  DECODE(inv1.invoice_currency_code,:C_BASE_CURRENCY_CODE, inv1.invoice_amount,inv1.base_amount) -
    DECODE(inv1.payment_currency_code,
                 :C_BASE_CURRENCY_CODE,
                      nvl(inv1.amount_paid,0) + NVL(discount_amount_taken,0),
                 DECODE(F.minimum_accountable_unit,
                       NULL, ROUND(((DECODE(inv1.payment_cross_rate_type,
                                                 'EMU FIXED', 1/inv1.payment_cross_rate,
                                                 inv1.exchange_rate)) *
                                                  nvl(inv1.amount_paid,0)),
                                                 F.precision),
                       ROUND(((DECODE(inv1.payment_cross_rate_type,
                                       'EMU FIXED', 1/inv1.payment_cross_rate,
                                       inv1.exchange_rate)) * nvl(inv1.amount_paid,0)) /
                                       F.minimum_accountable_unit) *
                                       F.minimum_accountable_unit)   +
                DECODE(F.minimum_accountable_unit,
                     NULL, ROUND(((DECODE(inv1.payment_cross_rate_type,
                                               'EMU FIXED', 1/inv1.payment_cross_rate,
                                              inv1.exchange_rate)) *
                                              NVL(inv1.discount_amount_taken,0)),
                                              F.precision),
                    ROUND(((DECODE(inv1.payment_cross_rate_type,
                                    'EMU FIXED', 1/inv1.payment_cross_rate,
                                    inv1.exchange_rate)) *
                                    nvl(inv1.discount_amount_taken,0)) /
                                    F.minimum_accountable_unit) *
                                    F.minimum_accountable_unit)),
  inv1.description
) x
ORDER BY
 x.C_SORT_NLS_HOLD_CODE1
,x.C_SORT_VENDOR_NAME
,x.C_VENDOR_NAME
,x.C_VENDOR_SITE
,x.C_INVOICE_DATE
,x.C_INVOICE_NUM
,x.C_NLS_HOLD_CODE