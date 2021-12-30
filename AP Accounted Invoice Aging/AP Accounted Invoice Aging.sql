/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Accounted Invoice Aging
-- Description: Application: Payables
Report: Accounts Payable Accounted Invoice Aging Report

Description.
Report details Aging of outstanding amounts at a specified point in time for Accounted Invoices.

-- Excel Examle Output: https://www.enginatics.com/example/ap-accounted-invoice-aging/
-- Library Link: https://www.enginatics.com/reports/ap-accounted-invoice-aging/
-- Run Report: https://demo.enginatics.com/

with xtb as
  (select /*+ parallel(xtb) leading(xtb) NO_MERGE */
    xtb.definition_code,
    nvl(xtb.applied_to_entity_id,xtb.source_entity_id) entity_id,
    xtb.code_combination_id ,
    xtb.source_application_id,
    sum (nvl2(xtb.applied_to_entity_id,0,nvl(xtb.entered_unrounded_cr,0) - nvl(xtb.entered_unrounded_dr,0))) entered_unrounded_orig_amount,
    sum (nvl2(xtb.applied_to_entity_id,0,nvl(xtb.entered_rounded_cr,0)   - nvl(xtb.entered_rounded_dr,0)))   entered_rounded_orig_amount,
    sum (nvl2(xtb.applied_to_entity_id,0,nvl(xtb.acctd_unrounded_cr,0)   - nvl(xtb.acctd_unrounded_dr,0)))   acctd_unrounded_orig_amount,
    sum (nvl2(xtb.applied_to_entity_id,0,nvl(xtb.acctd_rounded_cr,0)     - nvl(xtb.acctd_rounded_dr,0)) )    acctd_rounded_orig_amount,
    sum (nvl(xtb.entered_unrounded_cr,0)) - sum(nvl(xtb.entered_unrounded_dr,0)) entered_unrounded_rem_amount,
    sum (nvl(xtb.entered_rounded_cr,0))   - sum(nvl(xtb.entered_rounded_dr,0))   entered_rounded_rem_amount,
    sum (nvl(xtb.acctd_unrounded_cr,0))   - sum(nvl(xtb.acctd_unrounded_dr,0))   acctd_unrounded_rem_amount,
    sum (nvl(xtb.acctd_rounded_cr,0))     - sum(nvl(xtb.acctd_rounded_dr,0))     acctd_rounded_rem_amount,
    case when sum (nvl2(xtb.applied_to_entity_id,0,nvl(xtb.entered_rounded_cr,0)   - nvl(xtb.entered_rounded_dr,0))) = 0
    then 1
    else sum (nvl2(xtb.applied_to_entity_id,0,nvl(xtb.acctd_rounded_cr,0)     - nvl(xtb.acctd_rounded_dr,0)) ) /
         sum (nvl2(xtb.applied_to_entity_id,0,nvl(xtb.entered_rounded_cr,0)   - nvl(xtb.entered_rounded_dr,0)))
    end conversion_rate,
    xtb.ledger_id,
    xtb.party_id,
    xtb.balancing_segment_value,
    xtb.natural_account_segment_value,
    xtb.cost_center_segment_value,
    xtb.intercompany_segment_value,
    xtb.management_segment_value
   from
    xla_trial_balances xtb
   where
    xtb.definition_code = :p_definition_code and
    xtb.source_application_id=200 and
    xtb.gl_date between :p_start_date and :p_as_of_date and
    nvl(xtb.party_id,-99) = nvl(:p_third_party_id,nvl(xtb.party_id,-99))
   group by
    xtb.definition_code,
    nvl(xtb.applied_to_entity_id,xtb.source_entity_id) ,
    xtb.code_combination_id ,
    xtb.source_application_id,
    xtb.ledger_id,
    xtb.party_id,
    xtb.balancing_segment_value,
    xtb.natural_account_segment_value,
    xtb.cost_center_segment_value,
    xtb.intercompany_segment_value,
    xtb.management_segment_value
   having
    sum(nvl(xtb.acctd_rounded_cr,0)) <> sum (nvl(xtb.acctd_rounded_dr,0))
  ),
ap_inv as
(select
  :p_as_of_date as_of_date,
  xtb.definition_code,
  xtb.ledger_id,
  gl.name ledger_name,
  gl.short_name ledger_short_name,
  gl.currency_code ledger_currency,
  haouv.name operating_unit,
  xtb.source_application_id,
  xtb.entity_id source_entity_id,
  xte.entity_code source_entity_code,
  xte.security_id_int_1 org_id,
  xte.transaction_number source_transaction_number,
  xetv.name source_trx_type,
  xtb.code_combination_id,
  xtb.entered_unrounded_orig_amount,
  xtb.entered_rounded_orig_amount,
  xtb.acctd_unrounded_orig_amount,
  xtb.acctd_rounded_orig_amount,
  xtb.entered_unrounded_rem_amount,
  xtb.entered_rounded_rem_amount,
  xtb.acctd_unrounded_rem_amount,
  xtb.acctd_rounded_rem_amount,
  xtb.balancing_segment_value,
  xtb.natural_account_segment_value,
  xtb.cost_center_segment_value,
  xtb.intercompany_segment_value,
  xtb.management_segment_value,
  xtb.entity_id applied_to_entity_id,
  xtb.party_id third_party_number,
  --
  hp.party_name               third_party_name,
  hps.party_site_name         third_party_site_name,
  asu.segment1                vendor_number,
  asu.vendor_name             vendor_name,
  assa.vendor_site_code       vendor_site,
  aia.invoice_num             invoice_number,
  aia.doc_sequence_value      invoice_document_number,
  aia.invoice_date            invoice_date,
  aia.gl_date                 invoice_gl_date,
  aia.cancelled_date          invoice_cancelled_date,
  aia.source                  invoice_source,
  xxen_util.meaning(aia.invoice_type_lookup_code,'INVOICE TYPE',200)
                              invoice_type,
  aia.description             invoice_description,
  xxen_util.ap_invoice_status(aia.invoice_id,aia.invoice_amount,aia.payment_status_flag,aia.invoice_type_lookup_code,aia.validation_request_id)
                              invoice_status,
  xxen_util.meaning(aia.payment_status_flag,'INVOICE PAYMENT STATUS',200)
                              invoice_payment_status,
  aia.invoice_currency_code   invoice_currency,
  aia.invoice_amount          invoice_amount,
  nvl(aia.base_amount,aia.invoice_amount) invoice_base_amount,
  aia.invoice_id,
  apsa.payment_num,
  apsa.due_date,
  ceil(:p_as_of_date-apsa.due_date) days_due,
  case
  when xtb.acctd_rounded_rem_amount = 0 then 0
  when count(apsa.payment_num) over (partition by aia.invoice_id) = 1 then xtb.acctd_rounded_rem_amount
  -- multiple payment schedules, but invoice is cancelled or over paid, then allocate to the first payment schedule only
  when aia.invoice_amount = 0 or sign(xtb.acctd_rounded_rem_amount) != sign(aia.invoice_amount)
  then case when apsa.payment_num = first_value(apsa.payment_num) over (partition by aia.invoice_id order by apsa.payment_num)
       then xtb.acctd_rounded_rem_amount else 0
       end
  -- multiple paymement schedules. Consume amount remaining from latest payment schedule to first
  when nvl(sum(abs(round(apsa.gross_amount*xtb.conversion_rate,fcv.precision))) over (partition by aia.invoice_id order by apsa.payment_num desc rows between unbounded preceding and 1 preceding),
           abs(xtb.acctd_rounded_rem_amount)) <= abs(xtb.acctd_rounded_rem_amount)
  then case
       when apsa.payment_num = first_value(apsa.payment_num) over (partition by aia.invoice_id order by apsa.payment_num) -- 1st payment schedule - consume all remaining amount
       then sign(xtb.acctd_rounded_rem_amount) * (nvl(abs(xtb.acctd_rounded_rem_amount) - sum(abs(round(apsa.gross_amount*xtb.conversion_rate,fcv.precision))) over (partition by aia.invoice_id order by apsa.payment_num desc rows between unbounded preceding and 1 preceding),abs(xtb.acctd_rounded_rem_amount)))
       when nvl(abs(xtb.acctd_rounded_rem_amount) - sum(abs(round(apsa.gross_amount*xtb.conversion_rate,fcv.precision))) over (partition by aia.invoice_id order by apsa.payment_num desc rows between unbounded preceding and 1 preceding)
               ,abs(xtb.acctd_rounded_rem_amount)) >= abs(round(apsa.gross_amount*xtb.conversion_rate,fcv.precision))
       then sign(xtb.acctd_rounded_rem_amount) * abs(round(apsa.gross_amount*xtb.conversion_rate,fcv.precision))
       else sign(xtb.acctd_rounded_rem_amount) * (nvl(abs(xtb.acctd_rounded_rem_amount) - sum(abs(round(apsa.gross_amount*xtb.conversion_rate,fcv.precision))) over (partition by aia.invoice_id order by apsa.payment_num desc rows between unbounded preceding and 1 preceding),abs(xtb.acctd_rounded_rem_amount)))
       end
  else 0 -- all remaining amount already consumed
  end ps_amount_remaining
 from
  xtb xtb,
  xla_transaction_entities xte,
  xla_entity_types_vl xetv,
  ap_invoices_all aia,
  ap_payment_schedules_all apsa,
  ap_suppliers asu,
  ap_supplier_sites_all assa,
  hz_parties hp,
  hz_party_sites hps,
  gl_ledgers gl,
  fnd_currencies_vl fcv,
  hr_all_organization_units_vl haouv
 where
  xtb.source_application_id=200 and
  xtb.entity_id=xte.entity_id and
  xtb.source_application_id=xte.application_id and
  --xtb.ledger_id=xte.ledger_id and  removed join to make report work for reporting/secondary ledger,Bug 7331692
  xte.entity_code='AP_INVOICES' and
  xetv.entity_code=xte.entity_code and
  xetv.application_id=xte.application_id and
  aia.invoice_id=nvl(xte.source_id_int_1,-99) and
  apsa.invoice_id=nvl(xte.source_id_int_1,-99) and
  aia.vendor_id=asu.vendor_id(+) and
  aia.vendor_site_id=assa.vendor_site_id(+) and
  aia.party_id=hp.party_id and
  aia.party_site_id=hps.party_site_id(+) and
  (   (asu.employee_id is null and hps.party_site_id is not null)
   or ( asu.employee_id is not null)
  ) and
  xtb.ledger_id=gl.ledger_id and
  gl.currency_code=fcv.currency_code and
  haouv.organization_id = aia.org_id
)
--
-- Main Query Starts Here
--
select
 ap_inv.ledger_name,
 ap_inv.ledger_currency,
 gcck.concatenated_segments account,
 ap_inv.third_party_name,
 ap_inv.third_party_number,
 ap_inv.third_party_site_name,
 ap_inv.vendor_number,
 ap_inv.vendor_name,
 ap_inv.vendor_site,
 ap_inv.operating_unit,
 ap_inv.source_trx_type transaction_type,
 ap_inv.source_transaction_number transaction_number,
 ap_inv.invoice_document_number,
 ap_inv.invoice_date,
 ap_inv.invoice_gl_date,
 ap_inv.invoice_cancelled_date,
 ap_inv.invoice_source,
 ap_inv.invoice_type,
 ap_inv.invoice_description,
 ap_inv.invoice_status,
 ap_inv.invoice_payment_status,
 ap_inv.invoice_currency,
 case when ap_inv.payment_num = first_value(ap_inv.payment_num) over (partition by ap_inv.invoice_id order by ap_inv.payment_num) then ap_inv.invoice_amount end invoice_amount,
 case when ap_inv.payment_num = first_value(ap_inv.payment_num) over (partition by ap_inv.invoice_id order by ap_inv.payment_num) then ap_inv.invoice_base_amount end invoice_base_amount,
 case when ap_inv.payment_num = first_value(ap_inv.payment_num) over (partition by ap_inv.invoice_id order by ap_inv.payment_num) then ap_inv.acctd_rounded_orig_amount end transaction_original_amount,
 case when ap_inv.payment_num = first_value(ap_inv.payment_num) over (partition by ap_inv.invoice_id order by ap_inv.payment_num) then ap_inv.acctd_rounded_rem_amount end transaction_remaining_amount,
 ap_inv.payment_num,
 ap_inv.as_of_date,
 ap_inv.due_date,
 ap_inv.days_due,
 &aging_bucket_cols
 &gcc_segment_columns
 ap_inv.invoice_id
from
 ap_inv ap_inv,
 gl_code_combinations_kfv gcck
where
 1=1 and
 gcck.code_combination_id (+) = ap_inv.code_combination_id and
 nvl(ap_inv.ps_amount_remaining,0) != 0
order by
 ap_inv.ledger_name,
 gcck.concatenated_segments,
 ap_inv.third_party_name,
 ap_inv.third_party_number,
 ap_inv.invoice_gl_date,
 ap_inv.invoice_id,
 ap_inv.payment_num