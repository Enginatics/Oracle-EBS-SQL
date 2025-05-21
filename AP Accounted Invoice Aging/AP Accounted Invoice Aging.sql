/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Accounted Invoice Aging
-- Description: Application: Payables
Report: Accounts Payable Accounted Invoice Aging Report
Pre-requisite: XLA_TRIAL_BALANCES should be populated before running this report.

Description.
Report details Aging of outstanding amounts at a specified point in time for Accounted Invoices and relies mainly on the data in XLA_TRIAL_BALANCES table for the accounting information.
XLA_TRIAL_BALANCES data is inserted by the Open Account Balances Data Manager.
The Open Account Balances Data Manager maintains reportable information for all enabled open account balance listing definitions. This program is submitted automatically after a successful transfer to General Ledger for the same ledger or
manually by running the Open Account Balances Data Manager program. When changes are applied to a Open Account Balances Listing Definition, the Open Account Balances Data Manager program is automatically submitted for the changed definition.

For scheduling the report to run periodically, use the 'as of relative period close' offset parameter. This is the relative period offset to the current period, so when the current period changes, the period close as of date will also be automatically updated when the report is re-run.
-- Excel Examle Output: https://www.enginatics.com/example/ap-accounted-invoice-aging/
-- Library Link: https://www.enginatics.com/reports/ap-accounted-invoice-aging/
-- Run Report: https://demo.enginatics.com/

with xtb as
  (select /*+ parallel(xtb) leading(xtb) NO_MERGE */
    xtb.definition_code tb_code,
    xtdv.name tb_name,
    nvl(xtb.applied_to_entity_id,xtb.source_entity_id) entity_id,
    xtb.code_combination_id,
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
    xtb.management_segment_value,
    dte.as_of_date
   from
    xla_trial_balances xtb,
    xla_tb_definitions_vl xtdv,
    (select
      gl.ledger_id,
      :p_as_of_date as_of_date
     from
      gl_ledgers gl
     where
         :p_as_of_date is not null
     and ( (nvl(fnd_profile.value('XLA_USE_LEDGER_SECURITY'),'N')='N') or
           (nvl(fnd_profile.value('XLA_USE_LEDGER_SECURITY'),'N')='Y' and
            exists
             (select 1
              from
               gl_access_sets gas,
               gl_access_set_assignments asa
              where
               gas.access_set_id=asa.access_set_id and
               asa.ledger_id=gl.ledger_id and
               ( gas.access_set_id=nvl(fnd_profile.value('GL_ACCESS_SET_ID'),'-1') or
                 gas.access_set_id=nvl(fnd_profile.value('XLA_GL_SECONDARY_ACCESS_SET_ID'),'-1')
               )
             )
           )
         )
     union
     select
      x.ledger_id,
      x.end_date as_of_date
     from
      (select
       1-rank() over (partition by gl.name order by ((glp.period_year * 100000) + glp.period_num) desc) relative_period,
       gl.ledger_id,
       glp.end_date
       from
        gl_ledgers gl
       ,gl_periods glp
       ,gl_periods glpc
       where
           :p_as_of_date is null
       and :p_relative_period is not null
       and ( (nvl(fnd_profile.value('XLA_USE_LEDGER_SECURITY'),'N')='N') or
             (nvl(fnd_profile.value('XLA_USE_LEDGER_SECURITY'),'N')='Y' and
              exists
               (select 1
                from
                 gl_access_sets gas,
                 gl_access_set_assignments asa
                where
                 gas.access_set_id=asa.access_set_id and
                 asa.ledger_id=gl.ledger_id and
                 ( gas.access_set_id=nvl(fnd_profile.value('GL_ACCESS_SET_ID'),'-1') or
                   gas.access_set_id=nvl(fnd_profile.value('XLA_GL_SECONDARY_ACCESS_SET_ID'),'-1')
                 )
               )
             )
           )
       and gl.period_set_name=glp.period_set_name
       and gl.accounted_period_type=glp.period_type
       and glp.adjustment_period_flag='N'
       and gl.period_set_name=glpc.period_set_name
       and gl.accounted_period_type=glpc.period_type
       and glpc.adjustment_period_flag='N'
       and trunc(sysdate) between glpc.start_date and glpc.end_date
       and glp.start_date <= glpc.start_date
      ) x
     where
         x.relative_period = to_number(:p_relative_period)
    ) dte
   where
    xtb.ledger_id = dte.ledger_id and
    xtb.definition_code = xtdv.definition_code and
    xtb.source_application_id=200 and
    xtb.gl_date between to_date('01/01/1950','DD/MM/YYYY') and dte.as_of_date and
    xtdv.enabled_flag='Y'
   group by
    xtb.definition_code,
    xtdv.name,
    nvl(xtb.applied_to_entity_id,xtb.source_entity_id),
    xtb.code_combination_id ,
    xtb.source_application_id,
    xtb.ledger_id,
    xtb.party_id,
    xtb.balancing_segment_value,
    xtb.natural_account_segment_value,
    xtb.cost_center_segment_value,
    xtb.intercompany_segment_value,
    xtb.management_segment_value,
    dte.as_of_date
   having
    sum(nvl(xtb.acctd_rounded_cr,0)) <> sum (nvl(xtb.acctd_rounded_dr,0))
  ),
ap_inv as
(select
  xtb.as_of_date as_of_date,
  xtb.tb_code,
  xtb.tb_name,
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
  ftv2.territory_short_name   third_party_site_country,
  asu.segment1                vendor_number,
  asu.vendor_name             vendor_name,
  assa.vendor_site_code       vendor_site,
  ftv1.territory_short_name   vendor_site_country,
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
  xxen_util.meaning(aia.pay_group_lookup_code,'PAY GROUP',201) pay_group,
  (select ipmv.payment_method_name from iby_payment_methods_vl ipmv where ipmv.payment_method_code = aia.payment_method_code) payment_method,
  aia.dispute_reason          dispute_reason,
  apsa.iby_hold_reason        payment_hold_reason,
  aia.invoice_currency_code   invoice_currency, 
  aia.invoice_amount          invoice_amount,
  nvl(aia.base_amount,aia.invoice_amount) invoice_base_amount,
  case when aia.invoice_currency_code != gl.currency_code then aia.exchange_rate end invoice_exchange_rate,
  case when aia.invoice_currency_code != gl.currency_code then (select gdct.user_conversion_type from gl_daily_conversion_types gdct where gdct.conversion_type = aia.exchange_rate_type) end invoice_exchange_rate_type,
  case when aia.invoice_currency_code != gl.currency_code then aia.exchange_date end invoice_exchange_rate_date,
  aia.invoice_id,
  apsa.payment_num,
  apsa.due_date,
  ceil(xtb.as_of_date-apsa.due_date) days_due,
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
  end ps_amount_remaining,
  decode(gl.currency_code,:p_reval_currency,1,(select gdr.conversion_rate from gl_daily_conversion_types gdct, gl_daily_rates gdr where gl.currency_code=gdr.from_currency and gdr.to_currency=:p_reval_currency and :p_reval_conv_date=gdr.conversion_date and gdct.user_conversion_type=:p_reval_conv_type and gdct.conversion_type=gdr.conversion_type)) reval_conv_rate,
  --
  cbbv.bank_name               remit_to_bank_name,
  cbbv.bank_number             remit_to_bank_number,
  cbbv.bank_branch_name        remit_to_branch_name,
  cbbv.branch_number           remit_to_branch_number,
  cbbv.country                 remit_to_branch_country,
  ieba.masked_bank_account_num remit_to_account_num
 from
  xtb xtb,
  xla_transaction_entities xte,
  xla_entity_types_vl xetv,
  ap_invoices_all aia,
  ap_payment_schedules_all apsa,
  ap_suppliers asu,
  ap_supplier_sites_all assa,
  fnd_territories_vl ftv1,
  hz_parties hp,
  hz_party_sites hps,
  hz_locations hl,
  fnd_territories_vl ftv2,
  gl_ledgers gl,
  fnd_currencies_vl fcv,
  hr_all_organization_units_vl haouv,
  iby_ext_bank_accounts ieba,
  ce_bank_branches_v cbbv
 where
  xtb.entity_id=xte.entity_id and
  xtb.source_application_id=xte.application_id and
  xte.entity_code='AP_INVOICES' and
  xetv.entity_code=xte.entity_code and
  xetv.application_id=xte.application_id and
  aia.invoice_id=nvl(xte.source_id_int_1,-99) and
  apsa.invoice_id=nvl(xte.source_id_int_1,-99) and
  aia.vendor_id=asu.vendor_id(+) and
  aia.vendor_site_id=assa.vendor_site_id(+) and
  assa.country=ftv1.territory_code(+) and
  aia.party_id=hp.party_id and
  aia.party_site_id=hps.party_site_id(+) and
  (   (asu.employee_id is null and hps.party_site_id is not null)
   or ( asu.employee_id is not null)
  ) and
  hps.location_id=hl.location_id(+) and
  hl.country=ftv2.territory_code(+) and
  xtb.ledger_id=gl.ledger_id and
  gl.currency_code=fcv.currency_code and
  haouv.organization_id=aia.org_id and
  aia.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
  apsa.external_bank_account_id = ieba.ext_bank_account_id(+) and
  ieba.branch_id = cbbv.branch_party_id(+) and
  ieba.bank_id = cbbv.bank_party_id(+)
)
--
-- Main Query Starts Here
--
select
 ap_inv.ledger_name,
 ap_inv.tb_name trial_balance_name,
 ap_inv.ledger_currency,
 gcck.concatenated_segments account,
 ap_inv.third_party_name,
 ap_inv.third_party_number,
 ap_inv.third_party_site_name,
 ap_inv.third_party_site_country,
 ap_inv.vendor_number,
 ap_inv.vendor_name,
 ap_inv.vendor_site,
 ap_inv.vendor_site_country,
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
 ap_inv.pay_group,
 ap_inv.payment_method,
 ap_inv.dispute_reason,
 ap_inv.payment_hold_reason,
 ap_inv.invoice_currency,
 ap_inv.invoice_exchange_rate,
 ap_inv.invoice_exchange_rate_type,
 ap_inv.invoice_exchange_rate_date,
 case when ap_inv.payment_num = first_value(ap_inv.payment_num) over (partition by ap_inv.invoice_id order by ap_inv.payment_num) then ap_inv.invoice_amount end invoice_amount,
 case when ap_inv.payment_num = first_value(ap_inv.payment_num) over (partition by ap_inv.invoice_id order by ap_inv.payment_num) then ap_inv.invoice_base_amount end invoice_base_amount,
 case when ap_inv.payment_num = first_value(ap_inv.payment_num) over (partition by ap_inv.invoice_id order by ap_inv.payment_num) then ap_inv.acctd_rounded_orig_amount end transaction_original_amount,
 case when ap_inv.payment_num = first_value(ap_inv.payment_num) over (partition by ap_inv.invoice_id order by ap_inv.payment_num) then ap_inv.acctd_rounded_rem_amount end transaction_remaining_amount,
 ap_inv.payment_num,
 ap_inv.as_of_date,
 ap_inv.due_date,
 ap_inv.days_due,
 &aging_bucket_cols
 &reval_columns
 ap_inv.balancing_segment_value balancing_segment,
 gl_flexfields_pkg.get_description(gcck.chart_of_accounts_id,'GL_BALANCING',ap_inv.balancing_segment_value) balancing_segment_desc,
 ap_inv.natural_account_segment_value account_segment,
 gl_flexfields_pkg.get_description(gcck.chart_of_accounts_id,'GL_ACCOUNT',ap_inv.natural_account_segment_value) account_segment_desc,
 ap_inv.cost_center_segment_value cost_center_segment,
 gl_flexfields_pkg.get_description(gcck.chart_of_accounts_id,'FA_COST_CTR',ap_inv.cost_center_segment_value) cost_center_segment_desc,
 --
 ap_inv.remit_to_bank_name,
 ap_inv.remit_to_bank_number,
 ap_inv.remit_to_branch_name,
 ap_inv.remit_to_branch_number,
 ap_inv.remit_to_branch_country,
 ap_inv.remit_to_account_num,
 --
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
 ap_inv.tb_name,
 gcck.concatenated_segments,
 ap_inv.third_party_name,
 ap_inv.third_party_number,
 ap_inv.invoice_gl_date,
 ap_inv.invoice_id,
 ap_inv.payment_num