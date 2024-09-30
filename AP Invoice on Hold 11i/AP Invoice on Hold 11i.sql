/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Invoice on Hold 11i
-- Description: Based on Oracle standard Invoice on Hold report
Source: Invoice on Hold Report (XML)
Short Name: APXINROH_XML
-- Excel Examle Output: https://www.enginatics.com/example/ap-invoice-on-hold-11i/
-- Library Link: https://www.enginatics.com/reports/ap-invoice-on-hold-11i/
-- Run Report: https://demo.enginatics.com/

select /*+ push_pred(y) */
 x.ledger,
 x.operating_unit,
 x.c_hold_type hold_type,
 x.c_nls_hold_code hold_name,
 x.c_hold_code hold_code,
 x.c_nls_hold_desc "Hold Description",
 x.c_postable "Accounting Allowed",
 x.c_batch_name batch_name,
 x.c_vendor_name vendor,
 x.c_vendor_site vendor_site,
 x.c_invoice_num invoice_number,
 x.po_number,
 (select gps.period_name
  from   gl_period_statuses gps
  where  gps.set_of_books_id = x.set_of_books_id
  and    gps.application_id = 200
  and    gps.adjustment_period_flag = 'N'
  and    x.c_invoice_date between gps.start_date and gps.end_date
 ) invoice_date_period,
 x.c_invoice_date invoice_date,
 x.c_original_amount  held_original_amt_func_curr,
 x.c_amount_remaining held_remaining_amt_func_curr,
 x.c_description invoice_description,
 (select gps.period_name
  from   gl_period_statuses gps
  where  gps.set_of_books_id = x.set_of_books_id
  and    gps.application_id = 200
  and    gps.adjustment_period_flag = 'N'
  and    trunc(x.c_inv_creation_date) between gps.start_date and gps.end_date
 ) invoice_creation_period,
 trunc(x.c_inv_creation_date) invoice_creation_date,
 y.cost_center highest_value_cost_centre,
 trunc(x.payment_date) payment_date,
 x.invoice_pay_group,
 x.invalid_account,
 to_char(x.c_invoice_date,'YYYY-MM - Mon') invoice_date_label,
 to_char(x.c_inv_creation_date,'YYYY-MM - Mon') invoice_creation_date_label,
 case when row_number() over (partition by x.c_invoice_id,x.c_hold_type order by x.c_hold_code) = 1
 then 1
 else 0
 end invoice_count,
 case when row_number() over (partition by x.c_invoice_id,x.c_hold_type order by x.c_hold_code) = 1
 then x.c_original_amount
 else null
 end  inv_original_amt_func_curr,
 case when row_number() over (partition by x.c_invoice_id,x.c_hold_type order by x.c_hold_code) = 1
 then x.c_amount_remaining
 else null
 end inv_remaining_amt_func_curr
from
(
select -- invoices on hold
  gsob.set_of_books_id,
  gsob.chart_of_accounts_id,
  gsob.name ledger,
  haou.name operating_unit,
  v.vendor_name c_vendor_name,
  v.vendor_id c_vendor_id,
  vs.vendor_site_code c_vendor_site,
  decode(h.hold_lookup_code, null,:c_nls_na, h.hold_lookup_code)  c_hold_code,
  decode(h.hold_lookup_code, null,:c_nls_na, alc.displayed_field) c_nls_hold_code,
  decode(h.hold_lookup_code, null,:c_nls_na, alc.description)     c_nls_hold_desc,
  decode(ahc.postable_flag,'Y',:c_nls_yes,:c_nls_no)              c_postable,
  inv1.invoice_date c_invoice_date,
  b.batch_name c_batch_name,
  inv1.invoice_id c_invoice_id,
  inv1.invoice_num c_invoice_num,
  ( select distinct
    poh.segment1
    from
    po_line_locations poll,
    po_headers poh
    where
    poll.line_location_id = h.line_location_id and
    poll.po_header_id = poh.po_header_id
  )  po_number,
  decode(inv1.invoice_currency_code, gsob.currency_code, inv1.invoice_amount, inv1.base_amount) c_original_amount,
  decode(inv1.invoice_currency_code,
                 gsob.currency_code, inv1.invoice_amount,
                inv1.base_amount) -
    decode(inv1.payment_currency_code,
                 gsob.currency_code,
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
  'Invoice Hold' c_hold_type,
  inv1.creation_date c_inv_creation_date,
  inv1.pay_group_lookup_code invoice_pay_group,
  (select
   max(aca.check_date)
   from
   ap_invoice_payments_all aipa,
   ap_checks_all aca
   where
   aipa.check_id = aca.check_id and
   aca.void_date is null and
   aca.stopped_date is null and
   aipa.invoice_id = inv1.invoice_id
  ) payment_date,
  case
  when h.hold_lookup_code= 'DIST ACCT INVALID'
  then
   ( select
     distinct listagg(gcck.concatenated_segments,', ') within group (order by gcck.concatenated_segments)
     from
     ap_invoice_distributions aid,
     gl_code_combinations gcc,
     gl_code_combinations_kfv gcck
     where
     aid.invoice_id = h.invoice_id and
     aid.line_type_lookup_code = 'ITEM' and
     aid.dist_code_combination_id = gcc.code_combination_id (+) and
     aid.dist_code_combination_id = gcck.code_combination_id (+) and
     ( gcc.code_combination_id is null or
       gcc.detail_posting_allowed_flag = 'N' or
       trunc(gcc.start_date_active) > aid.accounting_date or
       trunc(gcc.end_date_active) < aid.accounting_date or
       gcc.template_id is not null or
       gcc.enabled_flag <> 'Y' or
       gcc.summary_flag <>'N'
     )
   )
  else
  null
  end invalid_account
from
  gl_sets_of_books gsob,
  hr_all_organization_units haou,
  po_vendors v,
  po_vendor_sites vs,
  ap_invoices inv1,
  ap_batches_all b,
  ap_payment_schedules s,
  ap_holds h,
  ap_hold_codes ahc,
  ap_lookup_codes alc,
  fnd_currencies_vl f
where
      2=2
  and v.vendor_id = inv1.vendor_id
  and gsob.set_of_books_id = inv1.set_of_books_id
  and haou.organization_id = inv1.org_id
  and vs.vendor_id (+) = inv1.vendor_id
  and vs.vendor_site_id (+) = inv1.vendor_site_id
  and h.invoice_id = inv1.invoice_id
  and b.batch_id(+) = inv1.batch_id
  and s.invoice_id(+) = inv1.invoice_id
  and h.release_lookup_code is null
  and f.currency_code = gsob.currency_code
  and alc.lookup_type = 'HOLD CODE'
  and alc.lookup_code = h.hold_lookup_code
  and ahc.hold_lookup_code = h.hold_lookup_code
union
select -- payments on hold
  gsob.chart_of_accounts_id,
  gsob.set_of_books_id,
  gsob.name ledger,
  haou.name operating_unit,
  v.vendor_name c_vendor_name,
  v.vendor_id c_vendor_id,
  vs.vendor_site_code c_vendor_site,
  :c_nls_na        c_hold_code,
  'Scheduled Payment Hold' c_nls_hold_code,
  :c_nls_na        c_nls_hold_desc,
  :c_nls_na        c_postable,
  inv1.invoice_date c_invoice_date,
  b.batch_name c_batch_name,
  inv1.invoice_id c_nr_invoice_id,
  inv1.invoice_num c_invoice_num,
  null po_number,
  decode(inv1.invoice_currency_code, gsob.currency_code, inv1.invoice_amount, inv1.base_amount) c_original_amount,
  decode(inv1.invoice_currency_code, gsob.currency_code, inv1.invoice_amount,inv1.base_amount) -
    decode(inv1.payment_currency_code,
                 gsob.currency_code,
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
  'Scheduled Payment Hold' c_description,
  'Scheduled Payment Hold' c_hold_type,
  inv1.creation_date c_inv_creation_date,
  inv1.pay_group_lookup_code invoice_pay_group,
  (select
   max(aca.check_date)
   from
   ap_invoice_payments_all aipa,
   ap_checks_all aca
   where
   aipa.check_id = aca.check_id and
   aca.void_date is null and
   aca.stopped_date is null and
   aipa.invoice_id = inv1.invoice_id
  ) payment_date,
  null invalid_account
from
  gl_sets_of_books gsob,
  hr_all_organization_units haou,
  po_vendors v,
  po_vendor_sites vs,
  ap_invoices inv1,
  ap_batches_all b,
  ap_payment_schedules s,
  fnd_currencies_vl f
where
      2=2
  and v.vendor_id = inv1.vendor_id
  and gsob.set_of_books_id = inv1.set_of_books_id
  and haou.organization_id = inv1.org_id
  and vs.vendor_id (+) = inv1.vendor_id
  and vs.vendor_site_id (+) = inv1.vendor_site_id
  and b.batch_id(+) = inv1.batch_id
  and s.invoice_id = inv1.invoice_id
  and s.hold_flag = 'Y'
  and f.currency_code = gsob.currency_code
union
select -- vendor sites on hold
  gsob.set_of_books_id,
  gsob.chart_of_accounts_id,
  gsob.name ledger,
  haou.name operating_unit,
  v.vendor_name c_vendor_name,
  v.vendor_id c_vendor_id,
  vs.vendor_site_code c_vendor_site,
  :c_nls_na        c_hold_code,
  'Supplier Site Hold' c_nls_hold_code,
  :c_nls_na        c_nls_hold_desc,
  :c_nls_na        c_postable,
  inv1.invoice_date c_invoice_date,
  b.batch_name c_batch_name,
  inv1.invoice_id c_invoice_id,
  inv1.invoice_num c_invoice_num,
  null po_number,
  decode(inv1.invoice_currency_code, gsob.currency_code, inv1.invoice_amount, inv1.base_amount) c_original_amount,
  decode(inv1.invoice_currency_code,gsob.currency_code, inv1.invoice_amount,inv1.base_amount) -
    decode(inv1.payment_currency_code,
                 gsob.currency_code,
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
  'Supplier Site Hold' c_hold_type,
  inv1.creation_date c_inv_creation_date,
  inv1.pay_group_lookup_code invoice_pay_group,
  (select
   max(aca.check_date)
   from
   ap_invoice_payments_all aipa,
   ap_checks_all aca
   where
   aipa.check_id = aca.check_id and
   aca.void_date is null and
   aca.stopped_date is null and
   aipa.invoice_id = inv1.invoice_id
  ) payment_date,
  null invalid_account
from
  gl_sets_of_books gsob,
  hr_all_organization_units haou,
  po_vendors v,
  po_vendor_sites vs,
  ap_invoices inv1,
  ap_batches_all b,
  ap_payment_schedules s,
  fnd_currencies_vl f
where
      2=2
  and gsob.set_of_books_id = inv1.set_of_books_id
  and haou.organization_id = inv1.org_id
  and v.vendor_id (+) = inv1.vendor_id
  and vs.vendor_id (+) = inv1.vendor_id
  and vs.vendor_site_id (+) = inv1.vendor_site_id
  and b.batch_id(+) = inv1.batch_id
  and s.invoice_id(+) = inv1.invoice_id
  and vs.hold_all_payments_flag = 'Y'
  and f.currency_code = gsob.currency_code
  and inv1.cancelled_date is null
  and inv1.payment_status_flag != 'Y'
) x,
(select distinct
  y.invoice_id,
  first_value(y.cctr) over (partition by y.invoice_id order by y.amount desc, y.cctr rows between unbounded preceding and unbounded following) cost_center
 from
  (select
     aid.invoice_id,
     fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'FA_COST_CTR','Y','VALUE') cctr,
     sum(amount) amount
   from
     ap_invoice_distributions aid,
     po_distributions pd,
     gl_code_combinations gcc
   where
     aid.line_type_lookup_code != 'TAX' and
     aid.po_distribution_id = pd.po_distribution_id (+) and
     nvl(pd.code_combination_id,aid.dist_code_combination_id) = gcc.code_combination_id
   group by
     aid.invoice_id,
     fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'FA_COST_CTR','Y','VALUE')
  ) y
) y
where
 1=1 and
 x.c_invoice_id = y.invoice_id (+)
order by
 decode(:p_order_by, 'Hold Name',c_nls_hold_code,x.c_vendor_name)
,x.c_vendor_name
,x.c_vendor_site
,x.c_invoice_date
,x.c_invoice_num
,x.c_nls_hold_code