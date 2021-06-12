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
 :c_company_name_header company_name
,x.c_hold_type
,x.c_nls_hold_code hold_name
,x.c_hold_code
&c_detail_nls_hold_desc
,x.c_batch_name batch_name
,x.c_vendor_name trading_partner
,x.c_vendor_site site
,x.c_invoice_num invoice_number
,(select distinct poh.segment1
   from  po_headers poh,
           po_line_locations poll,
           ap_holds ah
   where  ah.release_lookup_code   is null
   and       ah.line_location_id = poll.line_location_id
   and       poll.po_header_id = poh.po_header_id
   and    ah.invoice_id = x.c_invoice_id
   and    rownum <= 1
 )  "PO Number"
,x.c_month_name invoice_month
,x.c_invoice_date invoice_date
,x.c_original_amount "Original Amount (Func Curr)"
,x.c_amount_remaining "Amount Remaining (Func Curr)"
,nvl( (select distinct listagg(description,', ') within group (order by description) description
       from
        (
           select distinct
             aid.invoice_id
           , ah.hold_lookup_code
           , ap_utilities_pkg.get_charge_account(aid.dist_code_combination_id,gls.chart_of_accounts_id,'APXINROH') description
           from
             ap_invoice_distributions aid
             , gl_sets_of_books         gls
             , ap_holds                 ah
             where
                 :p_invalid_dist_acc     ='Y'
             and ah.hold_lookup_code     = 'DIST ACCT INVALID'
             and ah.release_lookup_code is null
             and aid.invoice_id          = ah.invoice_id
             and gls.set_of_books_id     = aid.set_of_books_id
           and (
                 exists (select 'x'
                  from gl_code_combinations c
                  where aid.dist_code_combination_id = c.code_combination_id (+)
                  and (c.code_combination_id is null
                         or c.detail_posting_allowed_flag = 'N'
                         or trunc(c.start_date_active) > aid.accounting_date
                         or trunc(c.end_date_active) < aid.accounting_date
                         or c.template_id is not null
                         or c.enabled_flag <> 'Y'
                         or c.summary_flag <>'N'
                         ))
                or
                  (aid.dist_code_combination_id = -1)
               )
        ) d
       where
           d.invoice_id        = x.c_invoice_id
       and d.hold_lookup_code  = x.c_hold_code
      )
    , x.c_description
    ) description
from
(
select -- invoices on hold
  decode(:p_order_by, 'Hold Name','Do not sort by vendor name', decode(:sort_by_alternate, 'Y', upper(hp.organization_name_phonetic), upper(hp.party_name))) c_sort_vendor_name,
  decode(:p_order_by, 'Vendor Name','Do not sort by Hold Name', upper(decode(h.hold_lookup_code, null,:c_nls_na, alc.displayed_field))) c_sort_nls_hold_code1,
  hp.party_name c_vendor_name,
  inv1.vendor_id c_vendor_id,
  vs.vendor_site_code c_vendor_site,
  decode(h.hold_lookup_code, null,:c_nls_na, h.hold_lookup_code)  c_hold_code,
  decode(h.hold_lookup_code, null,:c_nls_na, alc.displayed_field) c_nls_hold_code,
  decode(h.hold_lookup_code, null,:c_nls_na, alc.description)     c_nls_hold_desc,
  decode(ahc.postable_flag,'Y',:c_nls_yes,:c_nls_no)              c_postable,
  to_char(inv1.invoice_date,'YYYYMM') c_sort_month,
  to_char(inv1.invoice_date,'fmMonth YYYY') c_month_name,
  inv1.invoice_date c_invoice_date,
  b.batch_name c_batch_name,
  inv1.invoice_id c_invoice_id,
  inv1.invoice_num c_invoice_num,
  decode(inv1.invoice_currency_code, :c_base_currency_code, inv1.invoice_amount, inv1.base_amount) c_original_amount,
  decode(inv1.invoice_currency_code,
                 :c_base_currency_code, inv1.invoice_amount,
                inv1.base_amount) -
    decode(inv1.payment_currency_code,
                 :c_base_currency_code,
                      nvl(inv1.amount_paid,0) + nvl(discount_amount_taken,0),
                 decode(f.minimum_accountable_unit,
                       null, round(((decode(inv1.payment_cross_rate_type,
                                                 'EMU FIXED', 1/inv1.payment_cross_rate,
                                                 inv1.exchange_rate)) *
                                                  nvl(inv1.amount_paid,0)),
                                                 f.precision),
                       round(((decode(inv1.payment_cross_rate_type,
                                       'EMU FIXED', 1/inv1.payment_cross_rate,
                                       inv1.exchange_rate)) * nvl(inv1.amount_paid,0)) /
                                       f.minimum_accountable_unit) *
                                       f.minimum_accountable_unit)   +
                decode(f.minimum_accountable_unit,
                     null, round(((decode(inv1.payment_cross_rate_type,
                                               'EMU FIXED', 1/inv1.payment_cross_rate,
                                              inv1.exchange_rate)) *
                                              nvl(inv1.discount_amount_taken,0)),
                                              f.precision),
                    round(((decode(inv1.payment_cross_rate_type,
                                    'EMU FIXED', 1/inv1.payment_cross_rate,
                                    inv1.exchange_rate)) *
                                    nvl(inv1.discount_amount_taken,0)) /
                                    f.minimum_accountable_unit) *
                                    f.minimum_accountable_unit))
                 c_amount_remaining,
  inv1.description c_description,
  'Invoice Hold' c_hold_type
from
  hz_parties hp,
  ap_supplier_sites vs,
  ap_invoices inv1,
  ap_batches b,
  ap_payment_schedules s,
  ap_holds h,
  ap_hold_codes ahc,
  ap_lookup_codes alc,
  fnd_currencies_vl f
where
      hp.party_id = inv1.party_id
  and vs.vendor_id (+) = inv1.vendor_id
  and vs.vendor_site_id (+) = inv1.vendor_site_id
  and h.invoice_id = inv1.invoice_id
  and b.batch_id(+) = inv1.batch_id
  and s.invoice_id(+) = inv1.invoice_id
  and h.hold_lookup_code = nvl(:p_hold_code,h.hold_lookup_code)
  and h.release_lookup_code is null
  and f.currency_code = :c_base_currency_code &c_vendor_clause
  and trunc(inv1.creation_date) >= decode(:p_start_creation_date, null,trunc(inv1.creation_date), :p_start_creation_date)
  and trunc(inv1.creation_date) <= decode(:p_end_creation_date, null,trunc(inv1.creation_date), :p_end_creation_date)
  and   (
         (nvl(s.due_date, sysdate) >= decode(:p_start_due_date, null,
             nvl(s.due_date, sysdate), :p_start_due_date)
         and nvl(s.due_date, sysdate) <= decode(:p_end_due_date, null,
             nvl(s.due_date, sysdate), :p_end_due_date) )
         and
         ( (nvl(s.discount_date, sysdate) >=
                   decode(:p_start_discount_date, null,
         nvl(s.discount_date, sysdate), :p_start_discount_date)
            and nvl(s.discount_date, sysdate) <=
                    decode(:p_end_discount_date, null,
         nvl(s.discount_date, sysdate), :p_end_discount_date) )
            or
                (nvl(s.second_discount_date, sysdate) >=
                     decode(:p_start_discount_date, null,
            nvl(s.second_discount_date, sysdate),:p_start_discount_date)
            and nvl(s.second_discount_date, sysdate) <=
                     decode(:p_end_discount_date, null,
             nvl(s.second_discount_date, sysdate), :p_end_discount_date) )
            or
               (nvl(s.third_discount_date, sysdate) >=
                     decode(:p_start_discount_date, null,
            nvl(s.third_discount_date, sysdate), :p_start_discount_date)
            and nvl(s.third_discount_date, sysdate) <=
                    decode(:p_end_discount_date, null,
            nvl(s.third_discount_date, sysdate), :p_end_discount_date) )
         )
        )
  and alc.lookup_type = 'HOLD CODE'
  and alc.lookup_code = h.hold_lookup_code
  and ahc.hold_lookup_code = h.hold_lookup_code
group by
  decode(:p_order_by, 'Hold Name','Do not sort by vendor name', decode(:sort_by_alternate, 'Y', upper(hp.organization_name_phonetic), upper(hp.party_name))),
  decode(:p_order_by, 'Vendor Name','Do not sort by Hold Name', upper(decode(h.hold_lookup_code, null,:c_nls_na, alc.displayed_field))),
  h.hold_lookup_code,
  alc.displayed_field,
  alc.description,
  ahc.postable_flag,
  hp.party_name,
  inv1.vendor_id,
  vs.vendor_site_code,
  inv1.invoice_date,
  inv1.invoice_id,
  b.batch_name,
  inv1.invoice_num,
  decode(inv1.invoice_currency_code, :c_base_currency_code, inv1.invoice_amount, inv1.base_amount),
  decode(inv1.invoice_currency_code,
                 :c_base_currency_code, inv1.invoice_amount,
                inv1.base_amount) -
    decode(inv1.payment_currency_code,
                 :c_base_currency_code,
                      nvl(inv1.amount_paid,0) + nvl(discount_amount_taken,0),
                 decode(f.minimum_accountable_unit,
                       null, round(((decode(inv1.payment_cross_rate_type,
                                                 'EMU FIXED', 1/inv1.payment_cross_rate,
                                                 inv1.exchange_rate)) *
                                                  nvl(inv1.amount_paid,0)),
                                                 f.precision),
                       round(((decode(inv1.payment_cross_rate_type,
                                       'EMU FIXED', 1/inv1.payment_cross_rate,
                                       inv1.exchange_rate)) * nvl(inv1.amount_paid,0)) /
                                       f.minimum_accountable_unit) *
                                       f.minimum_accountable_unit)   +
                decode(f.minimum_accountable_unit,
                     null, round(((decode(inv1.payment_cross_rate_type,
                                               'EMU FIXED', 1/inv1.payment_cross_rate,
                                              inv1.exchange_rate)) *
                                              nvl(inv1.discount_amount_taken,0)),
                                              f.precision),
                    round(((decode(inv1.payment_cross_rate_type,
                                    'EMU FIXED', 1/inv1.payment_cross_rate,
                                    inv1.exchange_rate)) *
                                    nvl(inv1.discount_amount_taken,0)) /
                                    f.minimum_accountable_unit) *
                                    f.minimum_accountable_unit)),
  inv1.description
union
select -- payments on hold
  decode(:p_order_by, 'Hold Name','Do not sort by vendor name', decode(:sort_by_alternate, 'Y', upper(hp.organization_name_phonetic), upper(hp.party_name))) c_sort_vendor_name,
  decode(:p_order_by, 'Vendor Name','Do not sort by Hold Name', :c_nls_na) c_sort_nls_hold_code1,
  hp.party_name c_vendor_name,
  inv1.vendor_id c_vendor_id,
  vs.vendor_site_code c_vendor_site,
  :c_nls_na        c_hold_code,
  :c_nls_na        c_nls_hold_code,
  :c_nls_na        c_nls_hold_desc,
  :c_nls_na        c_postable,
  to_char(inv1.invoice_date,'YYYYMM') c_sort_month,
  to_char(inv1.invoice_date,'fmMonth YYYY') c_month_name,
  inv1.invoice_date c_invoice_date,
  b.batch_name c_batch_name,
  inv1.invoice_id c_nr_invoice_id,
  inv1.invoice_num c_invoice_num,
  decode(inv1.invoice_currency_code, :c_base_currency_code, inv1.invoice_amount, inv1.base_amount) c_original_amount,
  decode(inv1.invoice_currency_code, :c_base_currency_code, inv1.invoice_amount,inv1.base_amount) -
    decode(inv1.payment_currency_code,
                 :c_base_currency_code,
                      nvl(inv1.amount_paid,0) + nvl(discount_amount_taken,0),
                 decode(f.minimum_accountable_unit,
                       null, round(((decode(inv1.payment_cross_rate_type,
                                                 'EMU FIXED', 1/inv1.payment_cross_rate,
                                                 inv1.exchange_rate)) *
                                                  nvl(inv1.amount_paid,0)),
                                                 f.precision),
                       round(((decode(inv1.payment_cross_rate_type,
                                       'EMU FIXED', 1/inv1.payment_cross_rate,
                                       inv1.exchange_rate)) * nvl(inv1.amount_paid,0)) /
                                       f.minimum_accountable_unit) *
                                       f.minimum_accountable_unit)   +
                decode(f.minimum_accountable_unit,
                     null, round(((decode(inv1.payment_cross_rate_type,
                                               'EMU FIXED', 1/inv1.payment_cross_rate,
                                              inv1.exchange_rate)) *
                                              nvl(inv1.discount_amount_taken,0)),
                                              f.precision),
                    round(((decode(inv1.payment_cross_rate_type,
                                    'EMU FIXED', 1/inv1.payment_cross_rate,
                                    inv1.exchange_rate)) *
                                    nvl(inv1.discount_amount_taken,0)) /
                                    f.minimum_accountable_unit) *
                                    f.minimum_accountable_unit)) c_amount_remaining,
  max(s.iby_hold_reason) c_description,
  'Scheduled Payment Hold' c_hold_type
from
  hz_parties hp,
  ap_supplier_sites vs,
  ap_invoices inv1,
  ap_batches b,
  ap_payment_schedules s,
  fnd_currencies_vl f
where
      hp.party_id = inv1.party_id
  and vs.vendor_id (+) = inv1.vendor_id
  and vs.vendor_site_id (+) = inv1.vendor_site_id
  and b.batch_id(+) = inv1.batch_id
  and s.invoice_id = inv1.invoice_id
  and s.hold_flag = 'Y'
  and f.currency_code = :c_base_currency_code &c_vendor_clause
  and trunc(inv1.creation_date) >= decode(:p_start_creation_date, null,trunc(inv1.creation_date), :p_start_creation_date)
  and trunc(inv1.creation_date) <= decode(:p_end_creation_date, null,trunc(inv1.creation_date), :p_end_creation_date)
  and   (
         (nvl(s.due_date, sysdate) >= decode(:p_start_due_date, null,
             nvl(s.due_date, sysdate), :p_start_due_date)
         and nvl(s.due_date, sysdate) <= decode(:p_end_due_date, null,
             nvl(s.due_date, sysdate), :p_end_due_date) )
         and
         ( (nvl(s.discount_date, sysdate) >=
                   decode(:p_start_discount_date, null,
         nvl(s.discount_date, sysdate), :p_start_discount_date)
            and nvl(s.discount_date, sysdate) <=
                    decode(:p_end_discount_date, null,
         nvl(s.discount_date, sysdate), :p_end_discount_date) )
            or
                (nvl(s.second_discount_date, sysdate) >=
                     decode(:p_start_discount_date, null,
            nvl(s.second_discount_date, sysdate),:p_start_discount_date)
            and nvl(s.second_discount_date, sysdate) <=
                     decode(:p_end_discount_date, null,
             nvl(s.second_discount_date, sysdate), :p_end_discount_date) )
            or
               (nvl(s.third_discount_date, sysdate) >=
                     decode(:p_start_discount_date, null,
            nvl(s.third_discount_date, sysdate), :p_start_discount_date)
            and nvl(s.third_discount_date, sysdate) <=
                    decode(:p_end_discount_date, null,
            nvl(s.third_discount_date, sysdate), :p_end_discount_date) )
         )
        )
group by
  decode(:p_order_by, 'Hold Name','Do not sort by vendor name', decode(:sort_by_alternate, 'Y', upper(hp.organization_name_phonetic), upper(hp.party_name))),
  decode(:p_order_by, 'Vendor Name','Do not sort by Hold Name', :c_nls_na),
  hp.party_name,
  inv1.vendor_id,
  vs.vendor_site_code,
  vs.vendor_site_code,
  inv1.invoice_date,
  inv1.invoice_id,
  b.batch_name,
  inv1.invoice_num,
  decode(inv1.invoice_currency_code, :c_base_currency_code, inv1.invoice_amount, inv1.base_amount),
  decode(inv1.invoice_currency_code, :c_base_currency_code, inv1.invoice_amount,inv1.base_amount) -
    decode(inv1.payment_currency_code,
                 :c_base_currency_code,
                      nvl(inv1.amount_paid,0) + nvl(discount_amount_taken,0),
                 decode(f.minimum_accountable_unit,
                       null, round(((decode(inv1.payment_cross_rate_type,
                                                 'EMU FIXED', 1/inv1.payment_cross_rate,
                                                 inv1.exchange_rate)) *
                                                  nvl(inv1.amount_paid,0)),
                                                 f.precision),
                       round(((decode(inv1.payment_cross_rate_type,
                                       'EMU FIXED', 1/inv1.payment_cross_rate,
                                       inv1.exchange_rate)) * nvl(inv1.amount_paid,0)) /
                                       f.minimum_accountable_unit) *
                                       f.minimum_accountable_unit)   +
                decode(f.minimum_accountable_unit,
                     null, round(((decode(inv1.payment_cross_rate_type,
                                               'EMU FIXED', 1/inv1.payment_cross_rate,
                                              inv1.exchange_rate)) *
                                              nvl(inv1.discount_amount_taken,0)),
                                              f.precision),
                    round(((decode(inv1.payment_cross_rate_type,
                                    'EMU FIXED', 1/inv1.payment_cross_rate,
                                    inv1.exchange_rate)) *
                                    nvl(inv1.discount_amount_taken,0)) /
                                    f.minimum_accountable_unit) *
                                    f.minimum_accountable_unit))
union
select -- vendor sites on hold
  decode(:p_order_by, 'Hold Name','Do not sort by vendor name', decode(:sort_by_alternate, 'Y', upper(hp.organization_name_phonetic), upper(hp.party_name))) c_sort_vendor_name,
  decode(:p_order_by, 'Vendor Name','Do not sort by Hold Name', :c_nls_na) c_sort_nls_hold_code1,
  hp.party_name c_vendor_name,
  v.vendor_id c_vendor_id,
  vs.vendor_site_code c_vendor_site,
  :c_nls_na        c_hold_code,
  :c_nls_na        c_nls_hold_code,
  :c_nls_na        c_nls_hold_desc,
  :c_nls_na        c_postable,
  to_char(inv1.invoice_date,'YYYYMM') c_sort_month,
  to_char(inv1.invoice_date,'fmMonth YYYY') c_month_name,
  inv1.invoice_date c_invoice_date,
  b.batch_name c_batch_name,
  inv1.invoice_id c_invoice_id,
  inv1.invoice_num c_invoice_num,
  decode(inv1.invoice_currency_code, :c_base_currency_code, inv1.invoice_amount, inv1.base_amount) c_original_amount,
  decode(inv1.invoice_currency_code,:c_base_currency_code, inv1.invoice_amount,inv1.base_amount) -
    decode(inv1.payment_currency_code,
                 :c_base_currency_code,
                      nvl(inv1.amount_paid,0) + nvl(discount_amount_taken,0),
                 decode(f.minimum_accountable_unit,
                       null, round(((decode(inv1.payment_cross_rate_type,
                                                 'EMU FIXED', 1/inv1.payment_cross_rate,
                                                 inv1.exchange_rate)) *
                                                  nvl(inv1.amount_paid,0)),
                                                 f.precision),
                       round(((decode(inv1.payment_cross_rate_type,
                                       'EMU FIXED', 1/inv1.payment_cross_rate,
                                       inv1.exchange_rate)) * nvl(inv1.amount_paid,0)) /
                                       f.minimum_accountable_unit) *
                                       f.minimum_accountable_unit)   +
                decode(f.minimum_accountable_unit,
                     null, round(((decode(inv1.payment_cross_rate_type,
                                               'EMU FIXED', 1/inv1.payment_cross_rate,
                                              inv1.exchange_rate)) *
                                              nvl(inv1.discount_amount_taken,0)),
                                              f.precision),
                    round(((decode(inv1.payment_cross_rate_type,
                                    'EMU FIXED', 1/inv1.payment_cross_rate,
                                    inv1.exchange_rate)) *
                                    nvl(inv1.discount_amount_taken,0)) /
                                    f.minimum_accountable_unit) *
                                    f.minimum_accountable_unit)) c_amount_remaining,
  inv1.description c_description,
  'Supplier Site Hold' c_hold_type
from
  hz_parties hp,
  ap_suppliers v,
  ap_supplier_sites vs,
  ap_invoices inv1,
  ap_batches b,
  ap_payment_schedules s,
  fnd_currencies_vl f
where
  hp.party_id = inv1.party_id
  and v.vendor_id (+) = inv1.vendor_id
  and vs.vendor_id (+) = inv1.vendor_id
  and vs.vendor_site_id (+) = inv1.vendor_site_id
  and b.batch_id(+) = inv1.batch_id
  and s.invoice_id(+) = inv1.invoice_id
  and vs.hold_all_payments_flag = 'Y'
  and f.currency_code = :c_base_currency_code
  and inv1.cancelled_date is null
  and inv1.payment_status_flag != 'Y' &c_vendor_clause
  and trunc(inv1.creation_date) >= decode(:p_start_creation_date, null,trunc(inv1.creation_date), :p_start_creation_date)
  and trunc(inv1.creation_date) <= decode(:p_end_creation_date, null,trunc(inv1.creation_date), :p_end_creation_date)
  and   (
         (nvl(s.due_date, sysdate) >= decode(:p_start_due_date, null,
             nvl(s.due_date, sysdate), :p_start_due_date)
         and nvl(s.due_date, sysdate) <= decode(:p_end_due_date, null,
             nvl(s.due_date, sysdate), :p_end_due_date) )
         and
         ( (nvl(s.discount_date, sysdate) >=
                   decode(:p_start_discount_date, null,
         nvl(s.discount_date, sysdate), :p_start_discount_date)
            and nvl(s.discount_date, sysdate) <=
                    decode(:p_end_discount_date, null,
         nvl(s.discount_date, sysdate), :p_end_discount_date) )
            or
                (nvl(s.second_discount_date, sysdate) >=
                     decode(:p_start_discount_date, null,
            nvl(s.second_discount_date, sysdate),:p_start_discount_date)
            and nvl(s.second_discount_date, sysdate) <=
                     decode(:p_end_discount_date, null,
             nvl(s.second_discount_date, sysdate), :p_end_discount_date) )
            or
               (nvl(s.third_discount_date, sysdate) >=
                     decode(:p_start_discount_date, null,
            nvl(s.third_discount_date, sysdate), :p_start_discount_date)
            and nvl(s.third_discount_date, sysdate) <=
                    decode(:p_end_discount_date, null,
            nvl(s.third_discount_date, sysdate), :p_end_discount_date) )
         )
        )
group by
  decode(:p_order_by, 'Hold Name','Do not sort by vendor name', decode(:sort_by_alternate, 'Y', upper(hp.organization_name_phonetic), upper(hp.party_name))),
  decode(:p_order_by, 'Vendor Name','Do not sort by Hold Name', :c_nls_na),
  hp.party_name,
  v.vendor_id,
  vs.vendor_site_code,
  b.batch_name,
  inv1.invoice_date,
  inv1.invoice_id,
  inv1.invoice_num,
  decode(inv1.invoice_currency_code, :c_base_currency_code, inv1.invoice_amount, inv1.base_amount),
  decode(inv1.invoice_currency_code,:c_base_currency_code, inv1.invoice_amount,inv1.base_amount) -
    decode(inv1.payment_currency_code,
                 :c_base_currency_code,
                      nvl(inv1.amount_paid,0) + nvl(discount_amount_taken,0),
                 decode(f.minimum_accountable_unit,
                       null, round(((decode(inv1.payment_cross_rate_type,
                                                 'EMU FIXED', 1/inv1.payment_cross_rate,
                                                 inv1.exchange_rate)) *
                                                  nvl(inv1.amount_paid,0)),
                                                 f.precision),
                       round(((decode(inv1.payment_cross_rate_type,
                                       'EMU FIXED', 1/inv1.payment_cross_rate,
                                       inv1.exchange_rate)) * nvl(inv1.amount_paid,0)) /
                                       f.minimum_accountable_unit) *
                                       f.minimum_accountable_unit)   +
                decode(f.minimum_accountable_unit,
                     null, round(((decode(inv1.payment_cross_rate_type,
                                               'EMU FIXED', 1/inv1.payment_cross_rate,
                                              inv1.exchange_rate)) *
                                              nvl(inv1.discount_amount_taken,0)),
                                              f.precision),
                    round(((decode(inv1.payment_cross_rate_type,
                                    'EMU FIXED', 1/inv1.payment_cross_rate,
                                    inv1.exchange_rate)) *
                                    nvl(inv1.discount_amount_taken,0)) /
                                    f.minimum_accountable_unit) *
                                    f.minimum_accountable_unit)),
  inv1.description
) x
order by
 x.c_sort_nls_hold_code1
,x.c_sort_vendor_name
,x.c_vendor_name
,x.c_vendor_site
,x.c_invoice_date
,x.c_invoice_num
,x.c_nls_hold_code