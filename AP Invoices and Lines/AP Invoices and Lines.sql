/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Invoices and Lines
-- Description: Detail Invoice Aging report with line item details and amounts

Parameter explanation:
- Invoice on Hold (LOV: Yes/No)
  Default Value = Null (Hold Status not considered as per current behaviour)
  Yes - Only Invoices that currently have an unreleased hold will be retrieved
  No - Only Invoices that do not currently have an unreleased hold will be retrieved

- Hold Name (LOV: AP Hold Names)
  Default Value Null
  If specified - only Invoices that currently have an unreleased hold of the specified name will be retrieved

Hold column explanation:
- Holds  - a list of the current unreleased holds against the invoice
- Hold Dates - the Hold Date
- Holds Held By - the name of user who applied the holds
- Hold PO References - Identifies the matching POs for PO Matching Holds in the format: PO Number(Release number)(Line Number)(Shipment Number)
- Hold Receipt References  - Identifies the matching Receipts for Receipt Matching Holds in the format: Receipt Number(Line Number)
-- Excel Examle Output: https://www.enginatics.com/example/ap-invoices-and-lines/
-- Library Link: https://www.enginatics.com/reports/ap-invoices-and-lines/
-- Run Report: https://demo.enginatics.com/

with ap_inv as
(
  select
  gl.name ledger,
  haouv.name operating_unit,
  aps.vendor_name supplier,
  aps.segment1 supplier_number,
  assa.vendor_site_code supplier_site,
  aia.invoice_num,
  xxen_util.ap_invoice_status(aia.invoice_id,aia.invoice_amount,aia.payment_status_flag,aia.invoice_type_lookup_code,aia.validation_request_id) invoice_status,
  xxen_util.client_time(aia.creation_date) invoice_creation_date,
  xxen_util.client_time(aia.invoice_received_date) invoice_received_date,
  aia.invoice_date,
  aia.gl_date invoice_gl_date,
  apsa.due_date,
  ceil(sysdate-apsa.due_date) days_due,
  xxen_util.meaning(aia.invoice_type_lookup_code,'INVOICE TYPE',200) invoice_type,
  aia.source invoice_source,
  aia.description invoice_description,
  nvl(
   (select 
    xxen_util.meaning('Y','YES_NO',0)
    from 
    fnd_document_entities fde,
    fnd_attached_documents fad
    where
    fad.entity_name = fde.data_object_code and
    fde.application_id = 200 and
    fde.table_name = 'AP_INVOICES' and
    fad.pk1_value = to_char(aia.invoice_id) and
    rownum <= 1
   ),
   xxen_util.meaning('N','YES_NO',0)
  ) has_attachment,
  aia.invoice_currency_code,
  aia.payment_currency_code,
  aia.invoice_amount,
  aia.total_tax_amount,
  aia.self_assessed_tax_amount,
  aia.amount_applicable_to_discount,
  aia.discount_amount_taken,
  aia.approved_amount,
  aia.pay_curr_invoice_amount,
  aia.amount_paid,
  gl.currency_code base_currency,
  decode(aia.invoice_currency_code,gl.currency_code,aia.invoice_amount,aia.base_amount) invoice_amount_base,
  aia.total_tax_amount*nvl(aia.exchange_rate,1) tax_amount_base,
  aia.amount_applicable_to_discount*nvl(aia.exchange_rate,1) amt_applicable_to_disc_base,
  aia.discount_amount_taken/aia.payment_cross_rate*nvl(aia.exchange_rate,1) discount_amount_taken_base,
  aia.approved_amount*nvl(aia.exchange_rate,1) approved_amount_base,
  aia.amount_paid/aia.payment_cross_rate*nvl(aia.exchange_rate,1) amount_paid_base,
  aia.doc_sequence_value,
  apsa.payment_priority,
  apsa.payment_num,
  (select 
   max(aca.check_date) 
   from 
   ap_invoice_payments_all aipa, 
   ap_checks_all aca
   where
   aipa.check_id = aca.check_id and
   aca.void_date is null and
   aca.stopped_date is null and
   aipa.invoice_id = apsa.invoice_id and
   aipa.payment_num = apsa.payment_num
  ) payment_date,
  apsa.gross_amount,
  apsa.amount_remaining/aia.payment_cross_rate*nvl(aia.exchange_rate,1) amount_remaining,
  &aging_bucket_cols1
  aia.payment_cross_rate,
  aia.payment_cross_rate_date,
  apsa.discount_date,
  apsa.future_pay_due_date,
  xxen_util.meaning(apsa.hold_flag,'YES_NO',0) hold_flag,
  nvl(xxen_util.meaning(apsa.payment_method_code,'PAYMENT METHOD',200),apsa.payment_method_code) payment_method,
  xxen_util.meaning(aia.payment_status_flag,'INVOICE PAYMENT STATUS',200) invoice_payment_status,
  xxen_util.meaning(apsa.payment_status_flag,'INVOICE PAYMENT STATUS',200) schedule_payment_status,
  apsa.second_discount_date,
  apsa.third_discount_date,
  apsa.discount_amount_available,
  apsa.second_disc_amt_available,
  apsa.third_disc_amt_available,
  apsa.discount_amount_remaining,
  apsa.inv_curr_gross_amount,
  cbv.bank_name,
  ieba.masked_iban iban,
  at.name invoice_terms,
  aia.terms_date,
  aia.cancelled_date invoice_cancelled_date,
  aia.cancelled_amount invoice_cancelled_amount,
  xxen_util.user_name(aia.cancelled_by) invoice_cancelled_by,
  aia.temp_cancelled_amount invoice_temp_cancelled_amount,
  xxen_util.meaning(aia.auto_tax_calc_flag,'AP_TAX_CALCULATION_METHOD',200) auto_tax_calculation_method,
  aia.pay_group_lookup_code invoice_pay_group,
  xxen_util.meaning(aia.exclusive_payment_flag,'YES_NO',0) invoice_exclusive_payment_flag,
  xxen_util.concatenated_segments(aia.accts_pay_code_combination_id) accts_pay_account,
  xxen_util.segments_description(aia.accts_pay_code_combination_id) accts_pay_account_descripton,
  --
  aila.line_number,
  xxen_util.meaning(aila.line_type_lookup_code,'INVOICE LINE TYPE',200) line_type,
  xxen_util.meaning(aila.line_source,'LINE SOURCE',200) line_source,
  decode(aila.discarded_flag,'Y','Y') line_discarded,
  replace(aila.description,'~','-') line_description,
  aila.amount line_amount,
  nvl(aila.base_amount,aila.amount) line_base_amount,
  aila.accounting_date line_accounting_date,
  aila.tax_regime_code,
  aila.tax,
  aila.tax_jurisdiction_code,
  aila.tax_rate_code,
  aila.tax_rate,
  aida.distribution_line_number dist_line_number,
  xxen_util.meaning(aida.line_type_lookup_code,'INVOICE DISTRIBUTION TYPE',200) distribution_type,
  aida.period_name,
  aida.accounting_date dist_accounting_date,
  aida.creation_date dist_creation_date,
  aida.last_update_date dist_last_update_date,
  aida.quantity_invoiced,
  aida.unit_price,
  aida.amount dist_amount,
  nvl(aida.base_amount,aida.amount) dist_base_amount,
  aida.invoice_price_variance dist_invoice_price_variance,
  aida.base_invoice_price_variance dist_base_inv_price_variance,
  aida.dist_code_combination_id,
  xxen_util.concatenated_segments(aida.dist_code_combination_id) expense_account,
  xxen_util.concatenated_segments(aida.price_var_code_combination_id) price_variance_account,
  xxen_util.segments_description(aida.dist_code_combination_id) expense_account_descripton,
  xxen_util.segments_description(aida.price_var_code_combination_id) price_variance_account_desc,
  xxen_util.meaning(aida.dist_match_type,'MATCH_STATUS',200) dist_match_type,
  decode(aida.match_status_flag,'A','Validated','T','Tested','S','Stopped','Never Validated') dist_match_status,
  (select pha.segment1 from po_headers_all pha, po_distributions_all pda where pha.po_header_id = pda.po_header_id and pda.po_distribution_id = nvl(aida.po_distribution_id,aila.po_distribution_id)) po_number,
  xxen_util.meaning(aida.assets_tracking_flag,'YES_NO',0) dist_asset_tracking_flag,
  aida.assets_addition_flag dist_assets_addition_flag,
  replace(aida.description,'~','-') dist_description,
  aida.expenditure_item_date pa_expenditure_item_date,
  aida.expenditure_type pa_expenditure_type,
  coalesce(haouv1.name,haouv3.name,haouv2.name) expenditure_organization,
  nvl(xxen_util.meaning(aida.pa_addition_flag,'PA_ADDITION_FLAG',275),aida.pa_addition_flag) pa_addition_flag,
  aida.project_accounting_context,
  ppa.segment1 project_number,
  ppa.name project_name,
  ppa.description project_description,
  ppa.project_type,
  ppa.project_status_code,
  ppa.start_date project_start_date,
  ppa.completion_date project_completion_date,
  pt.task_number,
  pt.task_name,
  pt.description task_description,
  pt.service_type_code,
  pt.start_date task_start_date,
  pt.completion_date task_completion_date,
  --
  arpa.recurring_pay_num    recurring_pmt_number,
  arpa.rec_pay_period_type  recurring_pmt_period_type,
  arpa.num_of_periods       recurring_number_of_periods,
  arpa.description          recurring_pmt_description,
  --
  aps.num_1099             supplier_taxpayer_id,
  aps.vat_registration_num supplier_tax_registration,
  aps.end_date_active      supplier_inactive_on,
  aps.customer_num,
  xxen_util.meaning(aps.one_time_flag,'YES_NO',0) one_time_supplier,
  aps.credit_status_lookup_code supplier_credit_status,
  aps.credit_limit,
  aps.withholding_status_lookup_code supplier_withholding_status,
  aps.withholding_start_date,
  aps.vat_code supplier_vat_code,
  assa.vendor_site_code_alt   supplier_site_alt,
  xxen_util.meaning(assa.purchasing_site_flag,'YES_NO',0)    purchasing_site,
  xxen_util.meaning(assa.rfq_only_site_flag,'YES_NO',0)      rfq_site,
  xxen_util.meaning(assa.pay_site_flag,'YES_NO',0)           pay_site,
  xxen_util.meaning(assa.tax_reporting_site_flag,'YES_NO',0) tax_reporting_site,
  xxen_util.meaning(assa.pcard_site_flag,'YES_NO',0)         p_card_site,
  xxen_util.meaning(assa.attention_ar_flag,'YES_NO',0)       attention_ar,
  assa.address_line1,
  assa.address_line2,
  assa.address_line3,
  assa.address_line4,
  assa.city,
  assa.state,
  assa.zip,
  assa.county,
  assa.province,
  assa.country,
  assa.area_code,
  assa.phone,
  assa.fax_area_code,
  assa.fax,
  assa.supplier_notif_method,
  assa.email_address,
  assa.remittance_email,
  --
  aia.invoice_id,
  aia.org_id,
  case apsa.invoice_id
  when lag(apsa.invoice_id,1,-1) over (order by apsa.invoice_id,nvl(apsa.payment_num,1),aila.line_number,aida.accounting_date,aida.distribution_line_number)
  then 'N'
  else 'Y'
  end first_invoice,
  case apsa.invoice_id || '.' || apsa.payment_num
  when lag(apsa.invoice_id || '.' || apsa.payment_num,1,'X') over (order by apsa.invoice_id,nvl(apsa.payment_num,1),aila.line_number,aida.accounting_date,aida.distribution_line_number)
  then 'N'
  else 'Y'
  end first_psched,
  case  aila.invoice_id || '.' || aila.line_number
  when lag(aila.invoice_id || '.' || aila.line_number,1,'X') over (order by aia.invoice_id,nvl(apsa.payment_num,1),aila.line_number,aida.accounting_date,aida.distribution_line_number)
  then 'N'
  else 'Y'
  end first_line
  from
  gl_ledgers gl,
  hr_all_organization_units_vl haouv,
  hr_all_organization_units_vl haouv1,
  hr_all_organization_units_vl haouv2,
  hr_all_organization_units_vl haouv3,
  ap_invoices_all aia,
  ap_payment_schedules_all apsa,
  iby_ext_bank_accounts ieba,
  ce_banks_v cbv,
  ap_suppliers aps,
  ap_supplier_sites_all assa,
  (select aila2.* from ap_invoice_lines_all aila2 where '&enable_aila'='Y') aila,
  (select aida2.*
   from ap_invoice_distributions_all aida2,
        gl_code_combinations gcc
    where '&enable_aida'='Y' and
      gcc.code_combination_id = aida2.dist_code_combination_id and
      2=2
  ) aida,
  ap_recurring_payments_all arpa,
  ap_terms at,
  pa_projects_all ppa,
  pa_tasks pt
  where
  1=1 and
  aia.set_of_books_id=gl.ledger_id and
  aia.org_id=haouv.organization_id(+) and
  aia.expenditure_organization_id=haouv1.organization_id(+) and
  aila.expenditure_organization_id=haouv2.organization_id(+) and
  aida.expenditure_organization_id=haouv3.organization_id(+) and
  aia.invoice_id=apsa.invoice_id and
  apsa.external_bank_account_id=ieba.ext_bank_account_id(+) and
  ieba.bank_id=cbv.bank_party_id(+) and
  aia.vendor_id=aps.vendor_id and
  aia.vendor_site_id=assa.vendor_site_id and
  decode(apsa.payment_num,1,apsa.invoice_id,null) = aila.invoice_id(+) and
  aila.invoice_id=aida.invoice_id(+)and
  aila.line_number=aida.invoice_line_number(+) and
  aida.project_id=ppa.project_id(+)and
  aida.task_id=pt.task_id(+)and
  aia.recurring_payment_id=arpa.recurring_payment_id(+) and
  aia.terms_id=at.term_id(+)
  and exists -- need this to apply dist level restrictions in case report is run at header or line level
  (select null
   from
    ap_invoice_distributions_all aida2,
    gl_code_combinations gcc
   where
    aida2.invoice_id                 = aia.invoice_id and
    aida2.invoice_line_number        = nvl(aila.line_number,aida2.invoice_line_number) and
    aida2.distribution_line_number   = nvl(aida.distribution_line_number,aida2.distribution_line_number) and
    gcc.code_combination_id          = aida2.dist_code_combination_id and
    2=2
  )
  order by
  haouv.name,
  aps.vendor_name,
  aps.segment1,
  aia.invoice_date,
  aia.gl_date,
  aia.invoice_num,
  apsa.payment_num,
  aila.line_number,
  aida.accounting_date,
  aida.distribution_line_number
),
ap_holds as
(
  select distinct
  x.invoice_id,
  listagg(x.hold_name,', ') within group (order by x.hold_name) over (partition by x.invoice_id) holds,
  case count(distinct fnd_date.date_to_displaydate(x.hold_date)) over (partition by x.invoice_id)
   when 1 then to_char(fnd_date.date_to_displaydate(x.hold_date))
   else listagg(to_char(fnd_date.date_to_displaydate(x.hold_date)),', ') within group (order by x.hold_name) over (partition by x.invoice_id)
   end hold_dates,
  case count(distinct x.held_by_user_name) over (partition by x.invoice_id)
   when 1 then x.held_by_user_name
   else listagg(x.held_by_user_name,', ') within group (order by x.hold_name) over (partition by x.invoice_id)
   end holds_held_by,
  x.po_ref hold_po_references,
  x.receipt_ref hold_receipt_references
  from
  (select distinct
    aha.invoice_id,
    alc.displayed_field hold_name,
    first_value(aha.hold_date) over (partition by aha.invoice_id,aha.hold_lookup_code order by aha.hold_date) hold_date,
    first_value(case when aha.held_by = 5
                then (select alc.displayed_field from ap_lookup_codes alc where alc.lookup_type = 'NLS TRANSLATION' and alc.lookup_code = 'SYSTEM')
                else (select fu.user_name from fnd_user fu where fu.user_id = aha.held_by)
                end
               ) over (partition by aha.invoice_id,aha.hold_lookup_code order by aha.hold_date) held_by_user_name,
    po.po_ref,
    rcv.receipt_ref
   from
    ap_holds_all aha,
    ap_lookup_codes alc,
    (select distinct
      x.invoice_id,
      listagg(x.po_ref,',') within group (order by x.po_ref) over (partition by x.invoice_id) po_ref
     from
      (select distinct
        aha.invoice_id,
        nvl(pha.clm_document_number,pha.segment1) || '(' || nvl(to_char(pra.release_num),' ') || ')(' || nvl(pla.line_num_display, to_char(pla.line_num)) || ')(' || plla.shipment_num || ')' po_ref
       from
        ap_holds_all aha,
        po_line_locations_all plla,
        po_lines_all pla,
        po_headers_all pha,
        po_releases_all pra
       where
        aha.release_lookup_code is null and
        nvl(aha.status_flag,'S') = 'S' and
        plla.line_location_id = aha.line_location_id and
        pla.po_line_id = plla.po_line_id and
        pha.po_header_id = plla.po_header_id and
        pra.po_release_id (+) = plla.po_release_id
      ) x
    ) po,
    (select distinct
      x.invoice_id,
      listagg(x.receipt_ref,',') within group (order by x.receipt_ref) over (partition by x.invoice_id) receipt_ref
     from
      (select distinct
        aha.invoice_id,
        rsh.receipt_num || '(' || rsl.line_num || ')' receipt_ref
       from
        ap_holds_all aha,
        rcv_transactions rt,
        rcv_shipment_lines rsl,
        rcv_shipment_headers rsh
       where
        aha.release_lookup_code is null and
        nvl(aha.status_flag,'S') = 'S' and
        rt.transaction_id = aha.rcv_transaction_id and
        rsl.shipment_line_id = rt.shipment_line_id and
        rsh.shipment_header_id = rt.shipment_header_id
      ) x
    ) rcv
   where
    aha.release_lookup_code is null and
    nvl(aha.status_flag,'S') = 'S' and
    alc.lookup_type = 'HOLD CODE' and
    alc.lookup_code = aha.hold_lookup_code and
    po.invoice_id (+) = aha.invoice_id and
    rcv.invoice_id (+) = aha.invoice_id
  ) x
)
--
-- Main Query Starts Here
--
select
ap_inv.ledger,
ap_inv.operating_unit,
ap_inv.supplier,
ap_inv.supplier_number,
ap_inv.supplier_site,
ap_inv.invoice_num,
ap_inv.doc_sequence_value document_number,
ap_inv.invoice_status,
ap_inv.invoice_creation_date,
ap_inv.invoice_received_date,
ap_inv.invoice_date,
ap_inv.invoice_gl_date,
ap_inv.due_date,
ap_inv.days_due,
ap_inv.invoice_type,
ap_inv.invoice_source,
ap_inv.invoice_description,
ap_inv.has_attachment,
ap_inv.invoice_currency_code,
ap_inv.payment_currency_code,
case ap_inv.first_invoice when 'Y' then ap_inv.invoice_amount end invoice_amount,
case ap_inv.first_invoice when 'Y' then ap_invoices_utility_pkg.get_item_total(ap_inv.invoice_id, ap_inv.org_id) end items_total,
case ap_inv.first_invoice when 'Y' then ap_invoices_utility_pkg.get_retained_total(ap_inv.invoice_id, ap_inv.org_id) end retainage_total,
case ap_inv.first_invoice when 'Y' then ap_invoices_utility_pkg.get_prepaid_amount(ap_inv.invoice_id) end  prepayments_applied_total,
case ap_inv.first_invoice when 'Y' then ap_invoices_utility_pkg.get_amount_withheld(ap_inv.invoice_id) end witholding_total,
case ap_inv.first_invoice when 'Y' then ap_inv.total_tax_amount end tax_total,
case ap_inv.first_invoice when 'Y' then ap_inv.self_assessed_tax_amount end self_assessed_tax_amount,
case ap_inv.first_invoice when 'Y' then ap_invoices_utility_pkg.get_freight_total(ap_inv.invoice_id, ap_inv.org_id) end freight_total,
case ap_inv.first_invoice when 'Y' then ap_invoices_utility_pkg.get_misc_total(ap_inv.invoice_id, ap_inv.org_id) end miscellaneous_total,
case ap_inv.first_invoice when 'Y'
then nvl(ap_invoices_utility_pkg.get_item_total(ap_inv.invoice_id, ap_inv.org_id),0)
    + nvl(ap_invoices_utility_pkg.get_retained_total(ap_inv.invoice_id, ap_inv.org_id),0)
    - nvl(abs(ap_invoices_utility_pkg.get_prepaid_amount(ap_inv.invoice_id)),0)
    - nvl(ap_invoices_utility_pkg.get_amount_withheld(ap_inv.invoice_id),0)
    + nvl(ap_inv.total_tax_amount,0)
    + nvl(ap_invoices_utility_pkg.get_freight_total(ap_inv.invoice_id, ap_inv.org_id),0)
    + nvl(ap_invoices_utility_pkg.get_misc_total(ap_inv.invoice_id, ap_inv.org_id),0)
end invoice_total,
case ap_inv.first_invoice when 'Y' then ap_inv.amount_applicable_to_discount end amount_applicable_to_discount,
case ap_inv.first_invoice when 'Y' then ap_inv.discount_amount_taken end discount_amount_taken,
case ap_inv.first_invoice when 'Y' then ap_inv.approved_amount end approved_amount,
case ap_inv.first_invoice when 'Y' then ap_inv.pay_curr_invoice_amount end payment_curr_invoice_amount,
case ap_inv.first_invoice when 'Y' then ap_inv.amount_paid end amount_paid,
--
ap_inv.base_currency,
case ap_inv.first_invoice when 'Y' then ap_inv.invoice_amount_base end invoice_amount_base,
case ap_inv.first_invoice when 'Y' then ap_inv.tax_amount_base end tax_amount_base,
case ap_inv.first_invoice when 'Y' then ap_inv.amt_applicable_to_disc_base end amt_applicable_to_disc_base,
case ap_inv.first_invoice when 'Y' then ap_inv.discount_amount_taken_base end discount_amount_taken_base,
case ap_inv.first_invoice when 'Y' then ap_inv.approved_amount_base end approved_amount_base,
case ap_inv.first_invoice when 'Y' then ap_inv.amount_paid_base end amount_paid_base,
--
ap_inv.payment_num,
ap_inv.payment_date,
case ap_inv.first_psched when 'Y' then ap_inv.gross_amount end payment_num_gross_amount,
case ap_inv.first_psched when 'Y' then ap_inv.amount_remaining end payment_num_amount_remaining,
&aging_bucket_cols2
--
ap_inv.payment_cross_rate,
ap_inv.payment_cross_rate_date,
ap_inv.discount_date,
ap_inv.future_pay_due_date,
ap_inv.hold_flag,
ap_inv.payment_method,
ap_inv.payment_priority,
ap_inv.invoice_payment_status,
ap_inv.schedule_payment_status,
ap_inv.second_discount_date,
ap_inv.third_discount_date,
case ap_inv.first_psched when 'Y' then ap_inv.discount_amount_available end discount_amount_available,
case ap_inv.first_psched when 'Y' then ap_inv.second_disc_amt_available end second_disc_amt_available,
case ap_inv.first_psched when 'Y' then ap_inv.third_disc_amt_available end third_disc_amt_available,
case ap_inv.first_psched when 'Y' then ap_inv.discount_amount_remaining end discount_amount_remaining,
case ap_inv.first_psched when 'Y' then ap_inv.inv_curr_gross_amount end inv_curr_gross_amount,
ap_inv.bank_name,
ap_inv.iban,
ap_inv.invoice_terms,
ap_inv.terms_date,
ap_inv.invoice_cancelled_date,
ap_inv.invoice_cancelled_by,
case ap_inv.first_invoice when 'Y' then ap_inv.invoice_cancelled_amount end invoice_cancelled_amount,
case ap_inv.first_invoice when 'Y' then ap_inv.invoice_temp_cancelled_amount end invoice_temp_cancelled_amount,
ap_inv.auto_tax_calculation_method,
ap_inv.invoice_pay_group,
ap_inv.invoice_exclusive_payment_flag,
ap_inv.accts_pay_account,
ap_inv.accts_pay_account_descripton,
--
&invoice_detail_columns
--
ap_holds.holds,
ap_holds.hold_dates,
ap_holds.holds_held_by,
ap_holds.hold_po_references,
ap_holds.hold_receipt_references,
--
ap_inv.recurring_pmt_number,
ap_inv.recurring_pmt_period_type,
ap_inv.recurring_number_of_periods,
ap_inv.recurring_pmt_description,
--
ap_inv.supplier_taxpayer_id,
ap_inv.supplier_tax_registration,
ap_inv.supplier_inactive_on,
ap_inv.customer_num,
ap_inv.one_time_supplier,
ap_inv.supplier_credit_status,
ap_inv.credit_limit,
ap_inv.supplier_withholding_status,
ap_inv.withholding_start_date,
ap_inv.supplier_vat_code,
ap_inv.supplier_site_alt,
ap_inv.purchasing_site,
ap_inv.rfq_site,
ap_inv.pay_site,
ap_inv.tax_reporting_site,
ap_inv.p_card_site,
ap_inv.attention_ar,
ap_inv.address_line1,
ap_inv.address_line2,
ap_inv.address_line3,
ap_inv.address_line4,
ap_inv.city,
ap_inv.state,
ap_inv.zip,
ap_inv.county,
ap_inv.province,
ap_inv.country,
ap_inv.area_code,
ap_inv.phone,
ap_inv.fax_area_code,
ap_inv.fax,
ap_inv.supplier_notif_method,
ap_inv.email_address,
ap_inv.remittance_email,
--
&gcc_dist_segment_columns
--
ap_inv.invoice_id
from
ap_inv,
ap_holds,
gl_code_combinations_kfv gcck
where
ap_holds.invoice_id (+) = ap_inv.invoice_id and
gcck.code_combination_id (+) = ap_inv.dist_code_combination_id