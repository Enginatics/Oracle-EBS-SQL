/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP 1099 Payments
-- Description: 1099 Payments report showing payments made to 1099 reportable suppliers.
This is the Blitz Report equivalent of the Oracle standard 1099 Payments Report (APXTRRVT).

The report lists suppliers from the 1099 tape data (vendors processed for 1099 reporting) along with their payment totals within the specified date range.

Key features:
- Uses ap_1099_tape_data to filter vendors processed for 1099 reporting
- Validates against Tax Reporting Entity and balancing segments
- Calculates payment amounts using Oracle AP_UTILITIES_PKG.Net_Invoice_Amount
- Determines tax reporting site (site with tax_reporting_site_flag=Y or first alphabetical site)
- Handles void checks by excluding payments voided within the date range
- Supports Summary (totals by supplier/type) and Detail (individual checks/invoices) modes
- MISC4 (Backup Withholding) amounts tracked separately as Withheld Amount
- Distribution Total shows gross amounts before withholding adjustments
- Payment Amount shows net reportable amounts (with MISC4 as negative)
- Query Driver parameter controls balancing segment matching (INV=invoice distribution, PAY=bank cash account)
- Employee vendors use national_identifier from per_all_people_f for tax ID
- Tax ID cleanup removes dashes, spaces, and treats 000000000 as blank
-- Excel Examle Output: https://www.enginatics.com/example/ap-1099-payments/
-- Library Link: https://www.enginatics.com/reports/ap-1099-payments/
-- Run Report: https://demo.enginatics.com/

select
x.supplier_name,
x.supplier_number,
x.tax_reporting_site,
x.tax_id,
x.income_tax_type,
xxen_util.meaning(x.income_tax_type,'1099 MISC',200) income_tax_type_meaning,
x.income_tax_region,
&detail_columns
round(sum(x.distribution_amount),2) distribution_total,
round(sum(x.withheld_amount),2) withheld_amount,
round(sum(x.payment_amount),2) payment_amount
from
(
select
aps.vendor_name supplier_name,
aps.segment1 supplier_number,
assa.vendor_site_code tax_reporting_site,
decode(
  replace(replace(nvl(papf.national_identifier,nvl(aps.individual_1099,aps.num_1099)),'-',''),' ',''),
  '000000000','',
  nvl(papf.national_identifier,nvl(aps.individual_1099,aps.num_1099))
) tax_id,
aida.type_1099 income_tax_type,
aida.income_tax_region,
aia.invoice_num,
aia.invoice_date,
aia.invoice_amount,
aca.check_number,
aca.check_date,
-- distribution amount (prorated, before MISC4 sign adjustment)
decode(aia.cancelled_amount,null,aida.amount,
  decode(greatest(aida.accounting_date,:p_to_date+1),aida.accounting_date,0,
    decode(least(aida.accounting_date,:p_from_date-1),aida.accounting_date,0,aida.amount)))
/
decode(ap_utilities_pkg.net_invoice_amount(aia.invoice_id),0,1,ap_utilities_pkg.net_invoice_amount(aia.invoice_id))
*
decode(aipa.amount,0,decode((select count(*) from ap_invoice_payments_all aipa2 where aipa2.invoice_id=aia.invoice_id),null,1,0),aipa.amount)
distribution_amount,
-- withheld amount (MISC4 only, as positive value)
case when aida.type_1099='MISC4' then
  decode(aia.cancelled_amount,null,aida.amount,
    decode(greatest(aida.accounting_date,:p_to_date+1),aida.accounting_date,0,
      decode(least(aida.accounting_date,:p_from_date-1),aida.accounting_date,0,aida.amount)))
  /
  decode(ap_utilities_pkg.net_invoice_amount(aia.invoice_id),0,1,ap_utilities_pkg.net_invoice_amount(aia.invoice_id))
  *
  decode(aipa.amount,0,decode((select count(*) from ap_invoice_payments_all aipa2 where aipa2.invoice_id=aia.invoice_id),null,1,0),aipa.amount)
end withheld_amount,
-- payment amount (with MISC4 sign flip for net reporting)
decode(aida.type_1099,'MISC4',-1,1) *
decode(aia.cancelled_amount,null,aida.amount,
  decode(greatest(aida.accounting_date,:p_to_date+1),aida.accounting_date,0,
    decode(least(aida.accounting_date,:p_from_date-1),aida.accounting_date,0,aida.amount)))
/
decode(ap_utilities_pkg.net_invoice_amount(aia.invoice_id),0,1,ap_utilities_pkg.net_invoice_amount(aia.invoice_id))
*
decode(aipa.amount,0,decode((select count(*) from ap_invoice_payments_all aipa2 where aipa2.invoice_id=aia.invoice_id),null,1,0),aipa.amount)
payment_amount
from
ap_reporting_entities_all area,
ap_reporting_entity_lines_all arela,
hr_operating_units hou,
gl_ledgers gl,
gl_code_combinations gcc,
ap_suppliers aps,
(select x.* from (select assa.*, row_number() over (partition by assa.vendor_id, assa.org_id order by case when assa.tax_reporting_site_flag='Y' then 1 else 2 end, assa.vendor_site_code) row_number from ap_supplier_sites_all assa) x where x.row_number=1) assa,
per_all_people_f papf,
ap_invoices_all aia,
ap_invoice_distributions_all aida,
ap_invoice_payments_all aipa,
ap_checks_all aca,
ce_bank_acct_uses_all cbaua,
ce_bank_accounts cba
where
1=1 and
aps.vendor_id=assa.vendor_id(+) and
area.org_id=assa.org_id(+) and
area.tax_entity_id=arela.tax_entity_id and
area.org_id=hou.organization_id and
hou.set_of_books_id=gl.ledger_id and
gcc.chart_of_accounts_id=gl.chart_of_accounts_id and
gcc.&balancing_segment=arela.balancing_segment_value and
decode(:p_query_driver,'INV',aida.dist_code_combination_id,cba.asset_code_combination_id)=gcc.code_combination_id and
aps.vendor_id=aia.vendor_id and
aps.vendor_id in (select a1td.vendor_id from ap_1099_tape_data a1td) and
nvl(aps.employee_id,-99)=papf.person_id(+) and
(sysdate between papf.effective_start_date and papf.effective_end_date or papf.person_id is null) and
aia.invoice_id=aida.invoice_id and
aida.type_1099 is not null and
aia.invoice_id=aipa.invoice_id and
aipa.check_id=aca.check_id and
aca.ce_bank_acct_use_id=cbaua.bank_acct_use_id and
cbaua.bank_account_id=cba.bank_account_id and
aca.org_id=area.org_id and
(aca.void_date is null or aca.void_date not between :p_from_date and :p_to_date) and
aipa.accounting_date>=:p_from_date and
aipa.accounting_date<:p_to_date+1 and
(:p_federal_reportable='N' or aps.federal_reportable_flag='Y')
) x
group by
x.supplier_name,
x.supplier_number,
x.tax_reporting_site,
x.tax_id,
x.income_tax_type,
x.income_tax_region
&group_by_columns
order by
x.supplier_name,
x.income_tax_type