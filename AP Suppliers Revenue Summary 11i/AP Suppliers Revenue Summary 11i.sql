/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Suppliers Revenue Summary 11i
-- Description: AP suppliers (po vendors) revenue summary across different operating units
-- Excel Examle Output: https://www.enginatics.com/example/ap-suppliers-revenue-summary-11i/
-- Library Link: https://www.enginatics.com/reports/ap-suppliers-revenue-summary-11i/
-- Run Report: https://demo.enginatics.com/

with x as (
select
gp.min_start_date start_date
from
(
select
min(gp.start_date) over (partition by gp.period_year) min_start_date,
gp.start_date,
gp.end_date
from
gl_periods gp
where
(gp.period_set_name, gp.period_type) in (select gl.period_set_name, gl.accounted_period_type from gl_sets_of_books gl where  set_of_books_id = fnd_profile.value('GL_SET_OF_BKS_ID')) and
gp.adjustment_period_flag='N'
) gp
where
:as_of_date between gp.start_date and gp.end_date
)
select distinct
&lp_columns
aps.vendor_name supplier_name,
xxen_util.meaning(aps.vendor_type_lookup_code,'VENDOR TYPE',201) type,
aps.segment1 supplier_number,
aps.vat_registration_num tax_registration_number,
aps.end_date_active,
max(assa.vendor_site_code) keep (dense_rank last order by assa.vendor_site_id) over (partition by assa.vendor_site_id &partition_by) site_code,
max(assa.address_line1) keep (dense_rank last order by assa.vendor_site_id) over (partition by assa.vendor_site_id &partition_by) address_line1,
max(assa.address_line2) keep (dense_rank last order by assa.vendor_site_id) over (partition by assa.vendor_site_id &partition_by) address_line2,
max(assa.city) keep (dense_rank last order by assa.vendor_site_id) over (partition by assa.vendor_site_id &partition_by) city,
max(assa.zip) keep (dense_rank last order by assa.vendor_site_id) over (partition by assa.vendor_site_id &partition_by) zip,
max(ftv.territory_short_name) keep (dense_rank last order by assa.vendor_site_id) over (partition by assa.vendor_site_id &partition_by) country,
max(att.name) keep (dense_rank last order by assa.vendor_site_id) over (partition by assa.vendor_site_id &partition_by) payment_terms,
sum(case when aia.gl_date>=add_months(x.start_date,-24) and aia.gl_date<add_months(x.start_date,-12) then aia.invoice_amount end) over (partition by assa.vendor_site_id,nvl(aia.invoice_currency_code,gl.currency_code) &partition_by) amount_fy_&fy_2,
sum(case when aia.gl_date>=add_months(x.start_date,-12) and aia.gl_date<x.start_date then aia.invoice_amount end) over (partition by assa.vendor_site_id,nvl(aia.invoice_currency_code,gl.currency_code) &partition_by) amount_fy_&fy_1,
sum(case when aia.gl_date>=x.start_date and aia.gl_date<:as_of_date+1 then aia.invoice_amount end) over (partition by assa.vendor_site_id,nvl(aia.invoice_currency_code,gl.currency_code) &partition_by) amount_fy_&fy,
sum(case when aia.gl_date>=add_months(x.start_date,-24) then aia.invoice_amount end) over (partition by assa.vendor_site_id,nvl(aia.invoice_currency_code,gl.currency_code) &partition_by) amount_3_fys,
sum(case when aia.gl_date>=:as_of_date-365*10 then aia.invoice_amount end) over (partition by assa.vendor_site_id,nvl(aia.invoice_currency_code,gl.currency_code) &partition_by) amount_10_years,
sum(case when aia.gl_date>=:as_of_date-365*3 then aia.invoice_amount end) over (partition by assa.vendor_site_id,nvl(aia.invoice_currency_code,gl.currency_code) &partition_by) amount_3_years,
sum(case when aia.gl_date>=:as_of_date-365*2 then aia.invoice_amount end) over (partition by assa.vendor_site_id,nvl(aia.invoice_currency_code,gl.currency_code) &partition_by) amount_2_years,
sum(case when aia.gl_date>=:as_of_date-365 then aia.invoice_amount end) over (partition by assa.vendor_site_id,nvl(aia.invoice_currency_code,gl.currency_code) &partition_by) amount_1_year,
sum(aia.invoice_amount) over (partition by assa.vendor_site_id,nvl(aia.invoice_currency_code,gl.currency_code) &partition_by) amount_total,
nvl(aia.invoice_currency_code,gl.currency_code) currency,
(
select
 aba.iban_number
from
ap_bank_account_uses_all  abaua,
ap_bank_accounts_all      aba
where
      abaua.external_bank_account_id = aba.bank_account_id
and   abaua.vendor_id = aps.vendor_id
and   abaua.vendor_site_id is null
and   abaua.primary_flag = 'Y'
and   aba.iban_number is not null
) primary_iban_number
from
po_vendors aps,
po_vendor_sites_all assa,
fnd_territories_vl ftv,
ap_terms_tl att,
ap_invoices_all aia,
hr_operating_units hou,
gl_sets_of_books gl,
x
where
1=1 and
aps.vendor_id=assa.vendor_id and
assa.country=ftv.territory_code(+) and
assa.terms_id=att.term_id(+) and
att.language(+)=userenv('lang') and
assa.vendor_site_id=aia.vendor_site_id and
assa.org_id=hou.organization_id and
hou.set_of_books_id=gl.set_of_books_id