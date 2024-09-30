/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Invoices and Lines 11i
-- Description: Detail Invoice Aging report with line item details and amounts

-- Excel Examle Output: https://www.enginatics.com/example/ap-invoices-and-lines-11i/
-- Library Link: https://www.enginatics.com/reports/ap-invoices-and-lines-11i/
-- Run Report: https://demo.enginatics.com/

select
inv.ledger,
inv.ledger_currency,
inv.operating_unit,
inv.supplier,
inv.supplier_number,
inv.supplier_site,
inv.invoice_num,
inv.invoice_source,
inv.invoice_type,
inv.invoice_status,
inv.invoice_date,
inv.invoice_date_period,
inv.invoice_creation_date,
inv.invoice_creation_period,
inv.invoice_creation_delay,
inv.invoice_gl_date,
inv.invoice_description,
inv.invoice_terms,
inv.invoice_terms_date,
inv.invoice_pay_group,
inv.invoice_exclusive_payment,
-- invoice amounts
inv.invoice_currency_code,
decode(inv.first_invoice,'Y',inv.invoice_amount) invoice_amount,
decode(inv.first_invoice,'Y',inv.approved_amount) approved_amount,
decode(inv.first_invoice,'Y',inv.amount_applicable_to_discount) amount_applicable_to_discount,
decode(inv.first_invoice,'Y',inv.tax_amount) tax_amount,
inv.payment_currency_code,
decode(inv.first_invoice,'Y',inv.pay_curr_invoice_amount) pay_curr_invoice_amount,
decode(inv.first_invoice,'Y',inv.invoice_amount_paid) invoice_amount_paid,
decode(inv.first_invoice,'Y',inv.discount_amount_taken) discount_amount_taken,
-- accounted amounts
decode(inv.first_invoice,'Y',inv.invoice_amount_acctd) invoice_amount_acctd,
decode(inv.first_invoice,'Y',inv.approved_amount_acctd) approved_amount_acctd,
decode(inv.first_invoice,'Y',inv.amount_applic_to_disc_acctd) amount_applic_to_disc_acctd,
decode(inv.first_invoice,'Y',inv.tax_amount_acctd) tax_amount_acctd,
decode(inv.first_invoice,'Y',inv.amount_paid_acctd) amount_paid_acctd,
decode(inv.first_invoice,'Y',inv.discount_amount_taken_acctd) discount_amount_taken_acctd,
inv.exchange_rate_type,
inv.exchange_date,
inv.exchange_rate,
inv.payment_cross_rate_type,
inv.payment_cross_rate_date,
inv.payment_cross_rate,
--
inv.invoice_created_by,
inv.invoice_on_hold,
inv.invoice_has_attachment,
inv.liability_account,
inv.liability_account_descripton,
inv.invoice_cancelled_date,
inv.invoice_cancelled_amount,
inv.invoice_cancelled_by,
decode(inv.first_invoice,'Y',inv.invoice_temp_cancelled_amount) invoice_temp_cancelled_amount,
inv.recurring_pay_num,
inv.recurring_period_type,
inv.recurring_number_of_periods,
inv.recurring_pmt_description,
-- payment_schedules
inv.payment_num,
inv.due_date,
inv.days_due,
inv.future_pay_due_date,
inv.inv_payment_status,
inv.sched_payment_status,
inv.hold_flag,
decode(inv.first_psched,'Y',inv.inv_curr_gross_amount) inv_curr_gross_amount,
decode(inv.first_psched,'Y',inv.gross_amount) gross_amount,
decode(inv.first_psched,'Y',inv.amount_remaining) amount_remaining,
&aging_bucket_cols2
inv.payment_method,
inv.payment_priority,
inv.bank_name,
inv.iban,
inv.actual_payment_date,
inv.discount_date,
inv.second_discount_date,
inv.third_discount_date,
decode(inv.first_psched,'Y',inv.discount_amount_available) discount_amount_available,
decode(inv.first_psched,'Y',inv.second_disc_amt_available) second_disc_amt_available,
decode(inv.first_psched,'Y',inv.third_disc_amt_available) third_disc_amt_available,
decode(inv.first_psched,'Y',inv.discount_amount_remaining) discount_amount_remaining,
-- kpis
inv.validated_without_holds,
inv.late_po_flag,
inv.late_po_number,
inv.late_po_cost_centre,
inv.late_po_creation_date,
inv.late_po_created_by,
inv.invoice_count,
inv.distribution_count,
--
--
&invoice_detail_columns
--
-- supplier/site details
inv.supplier_inactive_on,
inv.taxpayer_id,
inv.tax_registration_number,
inv.vat_code,
inv.supplier_customer_num,
inv.one_time_supplier,
inv.credit_status_lookup_code,
inv.credit_limit,
inv.withholding_status_lookup_code,
inv.withholding_start_date,
inv.purchasing_site,
inv.rfq_site,
inv.pay_site,
inv.tax_reporting_site,
inv.p_card_site,
inv.attention_ar,
inv.address_line1,
inv.address_line2,
inv.address_line3,
inv.address_line4,
inv.city,
inv.state,
inv.zip,
inv.county,
inv.province,
inv.country,
inv.area_code,
inv.phone,
inv.fax_area_code,
inv.fax,
inv.supplier_notif_method,
inv.email_address,
inv.remittance_email,
--
&dff_columns2
--
inv.invoice_id
from
(
select
gl.name ledger,
gl.currency_code ledger_currency,
haouv.name operating_unit,
aps.vendor_name supplier,
aps.segment1 supplier_number,
assa.vendor_site_code supplier_site,
aia.invoice_num,
aia.source invoice_source,
xxen_util.meaning(aia.invoice_type_lookup_code,'INVOICE TYPE',200) invoice_type,
xxen_util.ap_invoice_status(aia.invoice_id,aia.invoice_amount,aia.payment_status_flag,aia.invoice_type_lookup_code,aia.validation_request_id) invoice_status,
aia.invoice_date,
(select gps.period_name
 from   gl_period_statuses gps
 where  gps.set_of_books_id = aia.set_of_books_id
 and    gps.application_id = 200
 and    gps.adjustment_period_flag = 'N'
 and    aia.invoice_date between gps.start_date and gps.end_date
) invoice_date_period,
xxen_util.client_time(aia.creation_date) invoice_creation_date,
(select gps.period_name
 from   gl_period_statuses gps
 where  gps.set_of_books_id = aia.set_of_books_id
 and    gps.application_id = 200
 and    gps.adjustment_period_flag = 'N'
 and    aia.creation_date between gps.start_date and gps.end_date
) invoice_creation_period,
(trunc(aia.creation_date)-trunc(aia.invoice_date)) invoice_creation_delay,
aia.gl_date invoice_gl_date,
aia.description invoice_description,
at.name invoice_terms,
aia.terms_date invoice_terms_date,
aia.pay_group_lookup_code invoice_pay_group,
xxen_util.meaning(aia.exclusive_payment_flag,'YES_NO',0) invoice_exclusive_payment,
-- invoice amounts
aia.invoice_currency_code,
aia.invoice_amount,
aia.approved_amount,
aia.amount_applicable_to_discount,
aia.tax_amount,
aia.payment_currency_code,
aia.pay_curr_invoice_amount,
aia.amount_paid invoice_amount_paid,
aia.discount_amount_taken,
-- accounted amounts
decode(aia.invoice_currency_code,gl.currency_code,aia.invoice_amount,aia.base_amount) invoice_amount_acctd,
nvl(aia.approved_amount,0)*aia.exchange_rate approved_amount_acctd,
nvl(aia.amount_applicable_to_discount,0)*nvl(aia.exchange_rate,1) amount_applic_to_disc_acctd,
nvl(aia.tax_amount,0)*nvl(aia.exchange_rate,1) tax_amount_acctd,
nvl(aia.amount_paid,0)/decode(nvl(aia.payment_cross_rate,1),0,1,aia.payment_cross_rate)*nvl(aia.exchange_rate,1) amount_paid_acctd,
nvl(aia.discount_amount_taken,0)/decode(nvl(aia.payment_cross_rate,1),0,1,aia.payment_cross_rate)*nvl(aia.exchange_rate,1) discount_amount_taken_acctd,
(select gdct.user_conversion_type from gl_daily_conversion_types gdct where gdct.conversion_type = aia.exchange_rate_type) exchange_rate_type,
aia.exchange_date,
aia.exchange_rate,
(select gdct.user_conversion_type from gl_daily_conversion_types gdct where gdct.conversion_type = aia.payment_cross_rate_type) payment_cross_rate_type,
aia.payment_cross_rate_date,
aia.payment_cross_rate,
--
xxen_util.user_name(aia.created_by) invoice_created_by,

case when
apsa.hold_flag = 'Y' or
(assa.hold_all_payments_flag = 'Y' and aia.payment_status_flag != 'Y' and aia.cancelled_date is null) or
exists
(select
 null
 from
 ap_holds_all aha
 where
 aha.invoice_id = aia.invoice_id and
 aha.release_lookup_code is null
)
then xxen_util.meaning('Y','YES_NO',0)
end invoice_on_hold,
nvl((select
     xxen_util.meaning('Y','YES_NO',0)
     from
     fnd_attached_documents fad,
     fnd_documents_vl fdv
     where
     fad.document_id = fdv.document_id and
     fad.entity_name = 'AP_INVOICES' and
     fad.pk1_value = aia.invoice_id and
     rownum <= 1
    ),
    xxen_util.meaning('N','YES_NO',0)
) invoice_has_attachment,
xxen_util.concatenated_segments(aia.accts_pay_code_combination_id) liability_account,
xxen_util.segments_description(aia.accts_pay_code_combination_id) liability_account_descripton,
aia.cancelled_date invoice_cancelled_date,
aia.cancelled_amount invoice_cancelled_amount,
xxen_util.user_name(aia.cancelled_by) invoice_cancelled_by,
aia.temp_cancelled_amount invoice_temp_cancelled_amount,
arpa.recurring_pay_num,
arpa.rec_pay_period_type recurring_period_type,
arpa.num_of_periods recurring_number_of_periods,
arpa.description recurring_pmt_description,
-- payment_schedules
apsa.payment_num,
apsa.due_date,
ceil(sysdate-apsa.due_date) days_due,
apsa.future_pay_due_date,
xxen_util.meaning(aia.payment_status_flag,'INVOICE PAYMENT STATUS',200) inv_payment_status,
xxen_util.meaning(apsa.payment_status_flag,'INVOICE PAYMENT STATUS',200) sched_payment_status,
apsa.hold_flag,
apsa.inv_curr_gross_amount,
apsa.gross_amount,
apsa.amount_remaining/aia.payment_cross_rate*nvl(aia.exchange_rate,1) amount_remaining,
&aging_bucket_cols1
nvl(xxen_util.meaning(apsa.payment_method_lookup_code,'PAYMENT METHOD',200),apsa.payment_method_lookup_code) payment_method,
apsa.payment_priority,
abb.bank_name,
aba.iban_number iban,
(select
 max(aca.check_date)
 from
 ap_invoice_payments_all aipa,
 ap_checks_all aca
 where
 apsa.invoice_id=aipa.invoice_id and
 apsa.payment_num=aipa.payment_num and
 aipa.check_id=aca.check_id and
 aca.void_date is null and
 aca.stopped_date is null
) actual_payment_date,
apsa.discount_date,
apsa.second_discount_date,
apsa.third_discount_date,
apsa.discount_amount_available,
apsa.second_disc_amt_available,
apsa.third_disc_amt_available,
apsa.discount_amount_remaining,
-- kpis
(select
 xxen_util.meaning(
  min(
   case when
   aha2.creation_date is not null and
   aha2.hold_date <= nvl(aaea2.creation_date,sysdate)
   then 'N'
   else 'Y'
   end
  ),'YES_NO',0)
 from
 ap_invoices_all aia2,
 ap_invoice_distributions_all aida2,
 ap_accounting_events_all aaea2,
 ap_holds_all aha2
 where
 aia2.invoice_id = aia.invoice_id and
 aia2.invoice_id = aida2.invoice_id (+) and
 aida2.accounting_event_id = aaea2.accounting_event_id (+) and
 aia2.invoice_id = aha2.invoice_id (+) and
 aha2.held_by (+) = 5 -- held by system
) validated_without_holds,
--
nvl2(pocc.po_number,xxen_util.meaning('Y','YES_NO',0),null) late_po_flag,
pocc.po_number late_po_number,
pocc.po_cost_center late_po_cost_centre,
pocc.po_creation_date late_po_creation_date,
pocc.po_created_by late_po_created_by,
--
case when 1 = row_number() over (partition by aia.invoice_id order by apsa.payment_num,aida.distribution_line_number)
then 1
else null
end invoice_count,
case when 1 = row_number() over (partition by aia.invoice_id order by apsa.payment_num,aida.distribution_line_number)
then (select count(*) from ap_invoice_distributions_all aida where aida.invoice_id = aia.invoice_id and aida.line_type_lookup_code not in ('TAX','AWT'))
else null
end distribution_count,
--
aida.distribution_line_number dist_line_number,
xxen_util.meaning(aida.line_type_lookup_code,'INVOICE DISTRIBUTION TYPE',200) dist_line_type,
aida.quantity_invoiced,
aida.unit_price,
aida.amount dist_amount,
nvl(aida.base_amount,aida.amount) dist_acctd_amount,
aida.period_name dist_period,
aida.accounting_date dist_accounting_date,
xxen_util.concatenated_segments(aida.dist_code_combination_id) dist_expense_account,
replace(aida.description,'~','-') dist_description,
aida.assets_addition_flag dist_assets_addition,
aida.invoice_price_variance dist_invoice_price_variance,
aida.base_invoice_price_variance dist_base_inv_price_variance,
xxen_util.concatenated_segments(aida.price_var_code_combination_id) dist_price_variance_account,
-- po match
xxen_util.meaning(aida.dist_match_type,'MATCH_STATUS',200) dist_match_type,
aida.match_status_flag dist_match_status,
pha.segment1 po_number,
xxen_util.user_name(pha.created_by) po_created_by,
trunc(pha.creation_date) po_creation_date,
case when (pha.creation_date - aia.creation_date) > 0 then xxen_util.meaning('Y','YES_NO',0) else null end po_created_after_invoice,
nvl2(pda.code_combination_id,xxen_util.concatenated_segments(pda.code_combination_id),null) po_dist_account,
nvl2(pda.code_combination_id,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg','SQLGL','GL#',gl.chart_of_accounts_id,null,pda.code_combination_id,'FA_COST_CTR','Y','VALUE'),null) po_dist_cost_centre,
--
-- project
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
aida.expenditure_item_date pa_expenditure_item_date,
aida.expenditure_type pa_expenditure_type,
coalesce(haouv1.name,haouv3.name) pa_expenditure_organization,
aida.pa_addition_flag,
aida.project_accounting_context,
--
aida.creation_date dist_creation_date,
aida.last_update_date dist_last_update_date,
--
-- supplier/site details
aps.end_date_active supplier_inactive_on,
aps.num_1099 taxpayer_id,
aps.vat_registration_num tax_registration_number,
aps.vat_code,
aps.customer_num supplier_customer_num,
xxen_util.meaning(aps.one_time_flag,'YES_NO',0) one_time_supplier,
aps.credit_status_lookup_code,
aps.credit_limit,
aps.withholding_status_lookup_code,
aps.withholding_start_date,
xxen_util.meaning(assa.purchasing_site_flag,'YES_NO',0) purchasing_site,
xxen_util.meaning(assa.rfq_only_site_flag,'YES_NO',0) rfq_site,
xxen_util.meaning(assa.pay_site_flag,'YES_NO',0) pay_site,
xxen_util.meaning(assa.tax_reporting_site_flag,'YES_NO',0) tax_reporting_site,
xxen_util.meaning(assa.pcard_site_flag,'YES_NO',0) p_card_site,
xxen_util.meaning(assa.attention_ar_flag,'YES_NO',0) attention_ar,
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
&dff_columns1
--
aia.invoice_id,
decode(row_number() over (partition by apsa.invoice_id order by nvl(apsa.payment_num,1), aida.accounting_date,aida.distribution_line_number),1,'Y') first_invoice,
decode(row_number() over (partition by apsa.invoice_id,apsa.payment_num order by aida.accounting_date,aida.distribution_line_number),1,'Y') first_psched
from
gl_sets_of_books gl,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv1,
hr_all_organization_units_vl haouv3,
ap_invoices_all aia,
ap_payment_schedules_all apsa,
ap_bank_accounts_all  aba,
ap_bank_branches abb,
po_vendors aps,
po_vendor_sites_all assa,
(select distinct
  y.invoice_id,
  first_value(y.cctr) over (partition by y.invoice_id order by y.cctr_amount desc, y.po_header_id desc, y.cctr rows between unbounded preceding and unbounded following) po_cost_center,
  first_value(y.po_number) over (partition by y.invoice_id order by y.cctr_amount desc, y.po_header_id desc, y.cctr rows between unbounded preceding and unbounded following) po_number,
  first_value(y.po_creation_date) over (partition by y.invoice_id order by y.cctr_amount desc, y.po_header_id desc, y.cctr rows between unbounded preceding and unbounded following) po_creation_date,
  first_value(y.po_created_by) over (partition by y.invoice_id order by y.cctr_amount desc, y.po_header_id desc, y.cctr rows between unbounded preceding and unbounded following) po_created_by
 from
  (select
     aida.invoice_id,
     pha.po_header_id,
     pha.segment1 po_number,
     xxen_util.user_name(pha.creation_date) po_creation_date,
     xxen_util.user_name(pha.created_by) po_created_by,
     fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'FA_COST_CTR','Y','VALUE') cctr,
     sum(aida.amount) over (partition by aida.invoice_id,pha.po_header_id,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'FA_COST_CTR','Y','VALUE')) cctr_amount
   from
     ap_invoice_distributions_all aida,
     po_distributions_all pda,
     po_headers_all pha,
     gl_code_combinations gcc
   where
     aida.line_type_lookup_code != 'TAX' and
     aida.po_distribution_id = pda.po_distribution_id and
     pda.po_header_id = pha.po_header_id and
     pda.code_combination_id = gcc.code_combination_id and
     aida.creation_date < pha.creation_date
  ) y
) pocc,
(select aida.* from ap_invoice_distributions_all aida where '&show_aida'='Y') aida,
gl_code_combinations gcc,
po_distributions_all pda,
po_headers_all pha,
ap_recurring_payments_all arpa,
ap_terms at,
pa_projects_all ppa,
pa_tasks pt
where
1=1 and
( (nvl('&show_aida','N') = 'Y' and
   2=2
  ) or
  (nvl('&show_aida','N') != 'Y' and
   exists --need this to apply dist level restrictions in case report is run at header or line level
   (select null
    from
     ap_invoice_distributions_all aida,
     gl_code_combinations gcc
    where
     aida.invoice_id               = aia.invoice_id and
     aida.dist_code_combination_id = gcc.code_combination_id and
     2=2
   )
  )
) and
aia.set_of_books_id=gl.set_of_books_id and
aia.org_id=haouv.organization_id(+) and
aia.expenditure_organization_id=haouv1.organization_id(+) and
aida.expenditure_organization_id=haouv3.organization_id(+) and
aia.invoice_id=apsa.invoice_id and
apsa.external_bank_account_id = aba.bank_account_id (+) and
aba.account_type (+) = 'SUPPLIER' and
aba.bank_branch_id = abb.bank_branch_id (+) and
aia.vendor_id=aps.vendor_id and
aia.vendor_site_id=assa.vendor_site_id and
aia.invoice_id = pocc.invoice_id (+) and
aia.invoice_id=aida.invoice_id (+) and
aida.dist_code_combination_id = gcc.code_combination_id (+) and
aida.po_distribution_id = pda.po_distribution_id (+) and
pda.po_header_id = pha.po_header_id (+) and
aida.project_id=ppa.project_id(+) and
aida.task_id=pt.task_id(+) and
aia.recurring_payment_id=arpa.recurring_payment_id(+) and
aia.terms_id=at.term_id(+)
) inv
order by
inv.operating_unit,
inv.supplier,
inv.supplier_number,
inv.invoice_date,
inv.invoice_gl_date,
inv.invoice_num,
inv.payment_num,
inv.dist_accounting_date,
inv.dist_line_number