/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP DPIVA Export LSNA
-- Description: Mexican DIOT Tax Report (Declaracion Informativa de Operaciones con Terceros) for LSNA Operating Unit.

Converted from BI Publisher report XXAP_DPIVA_LSNA.

This report extracts AP invoice payment information for Mexican tax reporting including:
- Regular invoice payments with VAT (IVA 16%, 8%)
- Import tax invoices
- AR miscellaneous cash receipts (bank interest)

Parameters:
- Operating Unit: LSNA OU
- Period: GL Period for payment posting
- Ledger: Primary ledger
- Business Unit: Segment1 value

Dependencies:
Requires custom functions: XXAP_RFC_AMTPAID, XXAP_INVBYRFC_ITEM_PRICE, XXAP_INVOICE_ITEM_PRICE, XXAP_INVOICE_TAX_PAID, XXAP_INVOICERFC_TAX_PAID
-- Excel Examle Output: https://www.enginatics.com/example/ap-dpiva-export-lsna/
-- Library Link: https://www.enginatics.com/reports/ap-dpiva-export-lsna/
-- Run Report: https://demo.enginatics.com/

select
x.vendor_name "Nombre del Proveedor",
x.tipoprov "Tipo Provedor",
x.tipooperac "Tipo Operacion",
x.rfc "RFC",
x.numidfiscal "Num ID Fiscal",
x.invoice_type "Tipo de Factura",
to_number(x.item_amount) "Sub-Total",
(select
  round(decode(x.currency_code,
    'USD', xxap_invoicerfc_tax_paid(ail.invoice_id, ail.prepay_invoice_id, ail.org_id, 'LSRM_16%AP_VAT', decode(x.usehdrdff, 'N', x.rfc, null)) * x.exchange_rate,
    xxap_invoicerfc_tax_paid(ail.invoice_id, ail.prepay_invoice_id, ail.org_id, 'LSRM_16%AP_VAT', decode(x.usehdrdff, 'N', x.rfc, null))), 0)
from ap_invoice_lines_all ail, zx_lines zl
where ail.invoice_id=x.invoice_id
and ail.invoice_id=zl.trx_id(+)
and ail.line_number=zl.trx_line_number(+)
and ail.org_id=zl.internal_organization_id(+)
and nvl(ail.attribute13, ail.tax_classification_code)='LSRM_16%AP_VAT'
and nvl(ail.discarded_flag, 'N')='N'
and nvl(ail.cancelled_flag, 'N')='N'
and x.import_tax='NO'
and decode(x.usehdrdff, 'N', ail.attribute10, '0')=decode(x.usehdrdff, 'N', nvl(x.rfc, ail.attribute10), '0')
and rownum=1) "IVA 16",
(select
  round(decode(x.currency_code,
    'USD', xxap_invoicerfc_tax_paid(ail.invoice_id, ail.prepay_invoice_id, ail.org_id, 'LSRM_8%AP_VAT', decode(x.usehdrdff, 'N', x.rfc, null)) * x.exchange_rate,
    xxap_invoicerfc_tax_paid(ail.invoice_id, ail.prepay_invoice_id, ail.org_id, 'LSRM_8%AP_VAT', decode(x.usehdrdff, 'N', x.rfc, null))), 0)
from ap_invoice_lines_all ail, zx_lines zl
where ail.invoice_id=x.invoice_id
and ail.invoice_id=zl.trx_id(+)
and ail.line_number=zl.trx_line_number(+)
and ail.org_id=zl.internal_organization_id(+)
and nvl(ail.attribute13, ail.tax_classification_code)='LSRM_8%AP_VAT'
and nvl(ail.discarded_flag, 'N')='N'
and nvl(ail.cancelled_flag, 'N')='N'
and x.import_tax='NO'
and decode(x.usehdrdff, 'N', ail.attribute10, '0')=decode(x.usehdrdff, 'N', nvl(x.rfc, ail.attribute10), '0')
and rownum=1) "IVA 8",
to_number(x.item_amount) - nvl((select
  abs(round(decode(x.currency_code, 'USD', sum(ail.amount) * x.exchange_rate, sum(ail.amount)), 0))
from ap_invoice_lines_all ail
where ail.invoice_id=x.invoice_id
and ail.org_id=x.invoice_org
and ail.line_type_lookup_code='AWT'
and nvl(ail.discarded_flag, 'N')='N'
and nvl(ail.cancelled_flag, 'N')='N'
and x.import_tax='NO'
and decode(x.usehdrdff, 'N', ail.attribute10, '0')=decode(x.usehdrdff, 'N', x.rfc, '0')), 0) "Importe antes de ret",
(select
  abs(round(decode(x.currency_code, 'USD', sum(ail.amount) * x.exchange_rate, sum(ail.amount)), 0))
from ap_invoice_lines_all ail
where ail.invoice_id=x.invoice_id
and ail.org_id=x.invoice_org
and ail.line_type_lookup_code='AWT'
and nvl(ail.discarded_flag, 'N')='N'
and nvl(ail.cancelled_flag, 'N')='N'
and x.import_tax='NO'
and decode(x.usehdrdff, 'N', ail.attribute10, '0')=decode(x.usehdrdff, 'N', x.rfc, '0')) "IVA Retenido Monto",
(select
  abs(round(decode(x.currency_code, 'USD', sum(ail.amount) * x.exchange_rate, sum(ail.amount)), 0))
from ap_invoice_lines_all ail
where ail.invoice_id=x.invoice_id
and ail.org_id=x.invoice_org
and ail.line_type_lookup_code='AWT'
and nvl(ail.discarded_flag, 'N')='N'
and nvl(ail.cancelled_flag, 'N')='N'
and x.import_tax='NO'
and decode(x.usehdrdff, 'N', ail.attribute10, '0')=decode(x.usehdrdff, 'N', x.rfc, '0')
and exists (
  select 1 from gl_code_combinations gcc, fnd_lookup_values fl
  where gcc.segment4=fl.meaning
  and fl.lookup_type='EMR_WT_ACCTS_LSRM'
  and fl.language=userenv('LANG')
  and fl.enabled_flag='Y'
  and fl.description like 'IVA%'
  and gcc.code_combination_id=ail.default_dist_ccid)) "IVA Retenido",
(select
  abs(round(decode(x.currency_code, 'USD', sum(ail.amount) * x.exchange_rate, sum(ail.amount)), 0))
from ap_invoice_lines_all ail
where ail.invoice_id=x.invoice_id
and ail.org_id=x.invoice_org
and ail.line_type_lookup_code='AWT'
and nvl(ail.discarded_flag, 'N')='N'
and nvl(ail.cancelled_flag, 'N')='N'
and nvl(ail.attribute5, 'Y')='Y'
and x.import_tax='NO'
and decode(x.usehdrdff, 'N', ail.attribute10, '0')=decode(x.usehdrdff, 'N', x.rfc, '0')
and exists (
  select 1 from gl_code_combinations gcc, fnd_lookup_values fl
  where gcc.segment4=fl.meaning
  and fl.lookup_type='EMR_WT_ACCTS_LSRM'
  and fl.language=userenv('LANG')
  and fl.enabled_flag='Y'
  and fl.description like 'ISR%'
  and gcc.code_combination_id=ail.default_dist_ccid)) "ISR Retenido",
(select
  round(abs(decode(x.currency_code, 'USD', sum(nvl(ail.attribute14, zl.taxable_amt)) * x.exchange_rate, sum(nvl(ail.attribute14, zl.taxable_amt)))), 0)
from ap_invoice_lines_all ail, zx_lines zl
where ail.invoice_id=x.invoice_id
and ail.org_id=x.invoice_org
and ail.invoice_id=zl.trx_id(+)
and ail.line_number=zl.trx_line_number(+)
and ail.org_id=zl.internal_organization_id(+)
and zl.entity_code(+)='AP_INVOICES'
and nvl(ail.attribute13, ail.tax_classification_code)='LSRM_0%AP_VAT'
and nvl(ail.discarded_flag, 'N')='N'
and nvl(ail.cancelled_flag, 'N')='N'
and x.import_tax='NO'
and decode(x.usehdrdff, 'N', ail.attribute10, '0')=decode(x.usehdrdff, 'N', x.rfc, '0')) "0% IVA",
case when x.import_tax='YES' then
  (select
    round(decode(x.currency_code, 'USD', xxap_invoice_tax_paid(ail.invoice_id, ail.prepay_invoice_id, ail.org_id, 'LSRM_IMPORT_TAX') * x.exchange_rate,
      xxap_invoice_tax_paid(ail.invoice_id, ail.prepay_invoice_id, ail.org_id, 'LSRM_IMPORT_TAX')), 0)
  from ap_invoice_lines_all ail, zx_lines zl
  where ail.invoice_id=x.invoice_id
  and ail.org_id=x.invoice_org
  and ail.line_type_lookup_code='TAX'
  and nvl(ail.discarded_flag, 'N')='N'
  and nvl(ail.cancelled_flag, 'N')='N'
  and ail.invoice_id=zl.trx_id
  and ail.summary_tax_line_id=zl.summary_tax_line_id
  and exists (select 1 from ap_invoice_lines_all ail2
    where ail2.invoice_id=ail.invoice_id
    and ail2.line_number=zl.trx_line_number
    and nvl(ail2.attribute13, ail.tax_rate_code)='LSRM_IMPORT_TAX')
  and rownum=1)
end "Import",
(select
  round(abs(decode(x.currency_code, 'USD', sum(nvl(ail.attribute14, zl.taxable_amt)) * x.exchange_rate, sum(nvl(ail.attribute14, zl.taxable_amt)))), 0)
from ap_invoice_lines_all ail, zx_lines zl
where ail.invoice_id=x.invoice_id
and ail.org_id=x.invoice_org
and ail.invoice_id=zl.trx_id(+)
and ail.line_number=zl.trx_line_number(+)
and ail.org_id=zl.internal_organization_id(+)
and nvl(ail.attribute13, ail.tax_classification_code)='LSRM_EXEMPT_VAT'
and nvl(ail.discarded_flag, 'N')='N'
and nvl(ail.cancelled_flag, 'N')='N'
and x.import_tax='NO'
and decode(x.usehdrdff, 'N', ail.attribute10, '0')=decode(x.usehdrdff, 'N', x.rfc, '0')) "Exempt",
to_number(x.item_amount) + nvl((select
  round(decode(x.currency_code,
    'USD', xxap_invoicerfc_tax_paid(ail.invoice_id, ail.prepay_invoice_id, ail.org_id, 'LSRM_16%AP_VAT', decode(x.usehdrdff, 'N', x.rfc, null)) * x.exchange_rate,
    xxap_invoicerfc_tax_paid(ail.invoice_id, ail.prepay_invoice_id, ail.org_id, 'LSRM_16%AP_VAT', decode(x.usehdrdff, 'N', x.rfc, null))), 0)
from ap_invoice_lines_all ail, zx_lines zl
where ail.invoice_id=x.invoice_id
and ail.invoice_id=zl.trx_id(+)
and ail.line_number=zl.trx_line_number(+)
and ail.org_id=zl.internal_organization_id(+)
and nvl(ail.attribute13, ail.tax_classification_code)='LSRM_16%AP_VAT'
and nvl(ail.discarded_flag, 'N')='N'
and nvl(ail.cancelled_flag, 'N')='N'
and x.import_tax='NO'
and decode(x.usehdrdff, 'N', ail.attribute10, '0')=decode(x.usehdrdff, 'N', nvl(x.rfc, ail.attribute10), '0')
and rownum=1), 0) + nvl((select
  round(decode(x.currency_code,
    'USD', xxap_invoicerfc_tax_paid(ail.invoice_id, ail.prepay_invoice_id, ail.org_id, 'LSRM_8%AP_VAT', decode(x.usehdrdff, 'N', x.rfc, null)) * x.exchange_rate,
    xxap_invoicerfc_tax_paid(ail.invoice_id, ail.prepay_invoice_id, ail.org_id, 'LSRM_8%AP_VAT', decode(x.usehdrdff, 'N', x.rfc, null))), 0)
from ap_invoice_lines_all ail, zx_lines zl
where ail.invoice_id=x.invoice_id
and ail.invoice_id=zl.trx_id(+)
and ail.line_number=zl.trx_line_number(+)
and ail.org_id=zl.internal_organization_id(+)
and nvl(ail.attribute13, ail.tax_classification_code)='LSRM_8%AP_VAT'
and nvl(ail.discarded_flag, 'N')='N'
and nvl(ail.cancelled_flag, 'N')='N'
and x.import_tax='NO'
and decode(x.usehdrdff, 'N', ail.attribute10, '0')=decode(x.usehdrdff, 'N', nvl(x.rfc, ail.attribute10), '0')
and rownum=1), 0) "Total Neto"
from (
select distinct
'04' tipoprov,
nvl(pvs.attribute12, '85') tipooperac,
upper(decode(nvl(aia.attribute10, 'Y'), 'N', ail.attribute10,
  (select nvl(trim(zpt.rep_registration_number), 'XAXX010101000')
   from zx_party_tax_profile zpt
   where zpt.party_id=pv.party_id
   and zpt.party_type_code='THIRD_PARTY'))) rfc,
aia.invoice_num numidfiscal,
aia.invoice_id,
aia.party_id,
pvs.party_site_id,
upper(decode(nvl(aia.attribute10, 'Y'), 'N', ail.attribute7, pv.vendor_name)) vendor_name,
upper(decode(nvl(aia.attribute10, 'Y'), 'N', ail.attribute8, pvs.country)) country,
upper(decode(nvl(aia.attribute10, 'Y'), 'N', ail.attribute9,
  (select territory_short_name from fnd_territories_vl where territory_code=pvs.country))) nationality,
aia.org_id invoice_org,
aia.invoice_type_lookup_code invoice_type,
decode(nvl(aia.attribute10, 'Y'), 'N',
  ltrim(to_char(round(decode(aia.invoice_currency_code, 'USD',
    xxap_rfc_amtpaid(aia.invoice_id, ail.org_id, ail.attribute10) * ip.exchange_rate,
    xxap_rfc_amtpaid(aia.invoice_id, ail.org_id, ail.attribute10)), 0), '99999999999990')),
  ltrim(to_char(round(decode(aia.invoice_currency_code, 'USD',
    aia.amount_paid * ip.exchange_rate, aia.amount_paid), 0), '99999999999990'))) amount_paid,
decode(nvl(aia.attribute10, 'Y'), 'N',
  ltrim(to_char(round(decode(aia.invoice_currency_code, 'USD',
    xxap_invbyrfc_item_price(aia.invoice_id, ail.org_id, null, ail.attribute10) * ip.exchange_rate,
    xxap_invbyrfc_item_price(aia.invoice_id, ail.org_id, null, ail.attribute10)), 0), '99999999999990')),
  ltrim(to_char(round(decode(aia.invoice_currency_code, 'USD',
    10 * ip.exchange_rate,
    10 item_amount,
--    xxap_invoice_item_price(aia.invoice_id, ail.prepay_invoice_id, ail.org_id) * ip.exchange_rate,
--    xxap_invoice_item_price(aia.invoice_id, ail.prepay_invoice_id, ail.org_id)), 0), '99999999999990'))) item_amount,
'NO' import_tax,
aia.invoice_currency_code currency_code,
ip.exchange_rate,
nvl(aia.attribute10, 'Y') usehdrdff
from ap_invoices_all aia,
ap_invoice_lines_all ail,
ap_invoice_distributions_all aid,
xla_transaction_entities ent,
xla_events xe,
xla_ae_headers aeh,
xla_ae_lines ael,
xla_distribution_links dl,
gl_import_references gir,
gl_je_lines jel,
gl_je_headers jeh,
gl_je_batches glb,
gl_code_combinations glc,
ap_suppliers pv,
ap_supplier_sites_all pvs,
ap_invoice_payments_all ip,
ap_checks_all ac
where ail.invoice_id=aia.invoice_id
and aia.org_id=ail.org_id
and aia.invoice_type_lookup_code!='PREPAYMENT'
and nvl(aia.attribute13, 'Y')='Y'
and nvl(ail.attribute5, 'Y')='Y'
and aid.invoice_id=aia.invoice_id
and aid.invoice_id=ail.invoice_id
and aid.invoice_line_number=ail.line_number
and dl.source_distribution_id_num_1=aid.invoice_distribution_id
and dl.applied_to_source_id_num_1=ail.invoice_id
and dl.source_distribution_type='AP_INV_DIST'
and ent.source_id_int_1=aia.invoice_id
and ent.legal_entity_id=aia.legal_entity_id
and ent.security_id_int_1=aia.org_id
and ent.entity_code='AP_INVOICES'
and ent.application_id=xe.application_id
and ent.entity_id=xe.entity_id
and aeh.application_id=ent.application_id
and aeh.entity_id=ent.entity_id
and aeh.ledger_id=ent.ledger_id
and aeh.accounting_entry_status_code='F'
and aeh.gl_transfer_status_code='Y'
and ael.ae_header_id=aeh.ae_header_id
and ael.application_id=aeh.application_id
and aeh.ae_header_id=dl.ae_header_id
and ael.ae_line_num=dl.ae_line_num
and xe.event_id=dl.event_id
and gir.gl_sl_link_id=ael.gl_sl_link_id
and gir.gl_sl_link_table=ael.gl_sl_link_table
and gir.reference_7=ael.ae_header_id
and jel.je_header_id=gir.je_header_id
and jel.je_line_num=gir.je_line_num
and jel.code_combination_id=glc.code_combination_id
and aia.vendor_id=pv.vendor_id
and aia.vendor_site_id=pvs.vendor_site_id
and pvs.vendor_id=pv.vendor_id
and jeh.status='P'
and jeh.actual_flag='A'
and jeh.je_header_id=jel.je_header_id
and jeh.period_name=jel.period_name
and glb.je_batch_id=jeh.je_batch_id
and glb.je_batch_id=gir.je_batch_id
and pvs.org_id=aid.org_id
and pvs.org_id=aia.org_id
and ip.invoice_id=ail.invoice_id
and ip.check_id=ac.check_id
and nvl(ip.reversal_flag, 'N')='N'
and nvl(ip.posted_flag, 'N')='Y'
and ip.period_name=:p_period_name
and jeh.ledger_id=:p_ledger_id
and glc.segment1=:p_business_unit
and aia.org_id=:p_org_id
and ail.line_type_lookup_code='ITEM'
and nvl(ail.discarded_flag, 'N')='N'
and nvl(ail.cancelled_flag, 'N')='N'
and nvl(ail.attribute13, '1')!='LSRM_IMPORT_TAX'
and nvl(aid.reversal_flag, 'N')='N'
and nvl(aid.cancellation_flag, 'N')='N'
and exists (select 1 from ap_invoice_lines_all aill
  where aill.invoice_id=ail.invoice_id
  and aill.line_type_lookup_code in ('TAX', 'AWT')
  and aill.tax_rate_code!='LSRM_IMPORT_TAX')
union
select distinct
'05' tipoprov,
nvl(pvs.attribute12, '85') tipooperac,
nvl(ail.attribute10, 'XEX010101000') rfc,
aia.invoice_num numidfiscal,
aia.invoice_id,
0 party_id,
0 party_site_id,
upper(ail.attribute7) vendor_name,
ail.attribute8 country,
ail.attribute9 nationality,
aia.org_id invoice_org,
aia.invoice_type_lookup_code invoice_type,
ltrim(to_char(round(decode(aia.invoice_currency_code, 'USD',
  xxap_invoice_tax_paid(ail.invoice_id, ail.prepay_invoice_id, ail.org_id,
    nvl(ail.attribute13, ail.tax_classification_code)) * ip.exchange_rate,
  xxap_invoice_tax_paid(ail.invoice_id, ail.prepay_invoice_id, ail.org_id,
    nvl(ail.attribute13, ail.tax_classification_code))), 0), '99999999999990')) amount_paid,
ltrim(to_char(round(decode(aia.invoice_currency_code, 'USD',
  (select to_char(sum(zl.taxable_amt))
   from ap_invoice_lines_all ail2, zx_lines zl
   where zl.trx_id=ail.invoice_id
   and ail2.invoice_id=zl.trx_id
   and ail2.line_number=zl.trx_line_number
   and ail2.org_id=zl.internal_organization_id
   and zl.entity_code='AP_INVOICES'
   and nvl(ail2.attribute13, ail2.tax_classification_code)=nvl(ail.attribute13, ail.tax_classification_code)) * ip.exchange_rate,
  (select to_char(sum(zl.taxable_amt))
   from ap_invoice_lines_all ail2, zx_lines zl
   where zl.trx_id=ail.invoice_id
   and ail2.invoice_id=zl.trx_id
   and ail2.line_number=zl.trx_line_number
   and ail2.org_id=zl.internal_organization_id
   and zl.entity_code='AP_INVOICES'
   and nvl(ail2.attribute13, ail2.tax_classification_code)=nvl(ail.attribute13, ail.tax_classification_code))), 0), '99999999999990')) item_amount,
'YES' import_tax,
aia.invoice_currency_code currency_code,
ip.exchange_rate,
'N' usehdrdff
from ap_invoices_all aia,
ap_invoice_lines_all ail,
ap_invoice_distributions_all aid,
xla_transaction_entities ent,
xla_events xe,
xla_ae_headers aeh,
xla_ae_lines ael,
xla_distribution_links dl,
gl_import_references gir,
gl_je_lines jel,
gl_je_headers jeh,
gl_je_batches glb,
gl_code_combinations glc,
ap_suppliers pv,
ap_supplier_sites_all pvs,
ap_invoice_payments_all ip,
ap_checks_all ac
where ail.invoice_id=aia.invoice_id
and aia.org_id=ail.org_id
and aia.invoice_type_lookup_code!='PREPAYMENT'
and aid.invoice_id=aia.invoice_id
and aid.invoice_id=ail.invoice_id
and aid.invoice_line_number=ail.line_number
and ent.source_id_int_1=aia.invoice_id
and ent.legal_entity_id=aia.legal_entity_id
and ent.security_id_int_1=aia.org_id
and ent.entity_code='AP_INVOICES'
and ent.application_id=xe.application_id
and ent.entity_id=xe.entity_id
and aeh.application_id=ent.application_id
and aeh.entity_id=ent.entity_id
and aeh.ledger_id=ent.ledger_id
and aeh.accounting_entry_status_code='F'
and aeh.gl_transfer_status_code='Y'
and ael.ae_header_id=aeh.ae_header_id
and ael.application_id=aeh.application_id
and aeh.ae_header_id=dl.ae_header_id
and ael.ae_line_num=dl.ae_line_num
and xe.event_id=dl.event_id
and aid.invoice_distribution_id=dl.source_distribution_id_num_1
and gir.gl_sl_link_id=ael.gl_sl_link_id
and gir.gl_sl_link_table=ael.gl_sl_link_table
and gir.reference_7=ael.ae_header_id
and jel.je_header_id=gir.je_header_id
and jel.je_line_num=gir.je_line_num
and jel.code_combination_id=glc.code_combination_id
and aia.vendor_id=pv.vendor_id
and aia.vendor_site_id=pvs.vendor_site_id
and pvs.vendor_id=pv.vendor_id
and jeh.status='P'
and jeh.actual_flag='A'
and jeh.je_header_id=jel.je_header_id
and jeh.period_name=jel.period_name
and glb.je_batch_id=jeh.je_batch_id
and glb.je_batch_id=gir.je_batch_id
and pvs.org_id=aid.org_id
and pvs.org_id=aia.org_id
and ail.invoice_id=ip.invoice_id
and ip.check_id=ac.check_id
and nvl(ip.reversal_flag, 'N')='N'
and ip.period_name=:p_period_name
and jeh.ledger_id=:p_ledger_id
and glc.segment1=:p_business_unit
and aia.org_id=:p_org_id
and nvl(ail.discarded_flag, 'N')='N'
and nvl(ail.cancelled_flag, 'N')='N'
and nvl(aid.reversal_flag, 'N')='N'
and nvl(aid.cancellation_flag, 'N')='N'
and ip.posted_flag='Y'
and ail.line_type_lookup_code='ITEM'
and nvl(ail.attribute13, ail.tax_classification_code)='LSRM_IMPORT_TAX'
union
select distinct
'04' tipoprov,
'85' tipooperac,
nvl(acr.attribute10, xfr.registration_number) rfc,
acr.receipt_number numidfiscal,
acr.cash_receipt_id invoice_id,
0 party_id,
0 party_site_id,
nvl(acr.attribute7, ob.bank_name) vendor_name,
nvl(acr.attribute8, ob.country) country,
nvl(acr.attribute9,
  (select territory_short_name from fnd_territories_vl where territory_code=ob.country)) nationality,
acr.org_id invoice_org,
art.name invoice_type,
ltrim(to_char(round(abs(mcd.amount), 0), '99999999999990')) amount_paid,
ltrim(to_char(round(ard.amount_cr - abs(mcd.amount), 0))) item_amount,
'NO' import_tax,
acr.currency_code,
acr.exchange_rate,
'N' usehdrdff
from ar_cash_receipts_all acr,
ar_cash_receipt_history_all acrh,
ar_distributions_all ard,
ar_misc_cash_distributions_all mcd,
ar_receivables_trx_all art,
xla_ae_headers xah,
xla_ae_lines xal,
xla_distribution_links xdl,
gl_import_references glimp,
gl_je_batches glb,
gl_je_headers glh,
gl_je_lines gll,
gl_code_combinations gcc,
fnd_lookup_values_vl lv,
xle_fp_registrations_v xfr,
(select cba.bank_id, bb.bank_name, cba.bank_account_name, cba.bank_account_num,
  cba.multi_currency_allowed_flag, cba.zero_amount_allowed, cba.account_classification,
  bb.bank_branch_type, bb.bank_branch_name, bb.bank_branch_number, bb.eft_swift_code,
  bau.bank_acct_use_id, ou.name, gcf.concatenated_segments, bb.country, bb.bank_number
from ce_bank_accounts cba,
ce_bank_acct_uses_all bau,
cefv_bank_branches bb,
hr_operating_units ou,
gl_code_combinations_kfv gcf
where cba.bank_account_id=bau.bank_account_id
and cba.bank_branch_id=bb.bank_branch_id
and ou.organization_id=bau.org_id
and cba.asset_code_combination_id=gcf.code_combination_id
and ou.name='LSRM OU'
and (cba.end_date is null or cba.end_date > trunc(sysdate))) ob
where acr.cash_receipt_id=acrh.cash_receipt_id
and acr.org_id=acrh.org_id
and acrh.cash_receipt_history_id=ard.source_id
and acrh.org_id=ard.org_id
and acr.cash_receipt_id=mcd.cash_receipt_id
and xfr.legal_entity_id=acr.legal_entity_id
and ard.source_table='CRH'
and acr.type='MISC'
and xal.application_id=xah.application_id
and xah.ae_header_id=xal.ae_header_id
and xah.ae_header_id=xdl.ae_header_id
and xal.ae_line_num=xdl.ae_line_num
and xdl.application_id=xah.application_id
and xdl.source_distribution_type='AR_DISTRIBUTIONS_ALL'
and xdl.source_distribution_id_num_1=ard.line_id
and glimp.je_header_id=glh.je_header_id
and glimp.je_line_num=gll.je_line_num
and glimp.je_batch_id=glb.je_batch_id
and glh.je_header_id=gll.je_header_id
and glh.je_batch_id=glb.je_batch_id
and glimp.gl_sl_link_table=xal.gl_sl_link_table
and glimp.gl_sl_link_id=xal.gl_sl_link_id
and glimp.reference_5=xah.entity_id
and glimp.reference_6=xah.event_id
and glimp.reference_7=xah.ae_header_id
and glh.je_source='Receivables'
and acr.status='APP'
and mcd.code_combination_id=gcc.code_combination_id
and gcc.segment4=lv.meaning
and lv.lookup_type='EMR_RECEIPT_ACCTS_LSRM'
and lv.enabled_flag='Y'
and lv.end_date_active is null
and art.name=lv.description
and acr.receivables_trx_id=art.receivables_trx_id
and ob.bank_acct_use_id=acr.remit_bank_acct_use_id
and gll.period_name=:p_period_name
and gll.ledger_id=:p_ledger_id
and gcc.segment1=:p_business_unit
and acr.org_id=:p_org_id
) x
order by x.tipoprov, x.rfc, x.invoice_id