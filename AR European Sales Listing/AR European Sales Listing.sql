/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR European Sales Listing
-- Description: Summary report listing sales by country and currency code, with transaction amount / currency and accounted amount/ currency
-- Excel Examle Output: https://www.enginatics.com/example/ar-european-sales-listing/
-- Library Link: https://www.enginatics.com/reports/ar-european-sales-listing/
-- Run Report: https://demo.enginatics.com/

select distinct
nvl2(ftv.alternate_territory_code,'Y',null) eu_flag,
ftv.territory_short_name country,
ftv.territory_code country_code,
hcsua.tax_reference,
rcta.invoice_currency_code currency_code,
sum(nvl(rctlgda.amount,0)) over (partition by ftv.territory_short_name, ftv.territory_code, hcsua.tax_reference, rcta.invoice_currency_code) amount,
sum(nvl(rctlgda.acctd_amount,0)) over (partition by ftv.territory_short_name, ftv.territory_code, hcsua.tax_reference, rcta.invoice_currency_code) acctd_amount
from
gl_sets_of_books gl,
hr_operating_units hou,
ra_customer_trx_all rcta,
ra_cust_trx_types_all rctta,
ra_customer_trx_lines_all rctla,
ra_cust_trx_line_gl_dist_all rctlgda,
hz_cust_site_uses_all hcsua,
hz_cust_acct_sites_all hcasa,
hz_party_sites hps,
hz_locations hl,
fnd_territories_vl ftv
where
decode(rctta.type,'CM',:remit_to_address,rcta.remit_to_address_id)=:remit_to_address and
1=1 and
gl.set_of_books_id=hou.set_of_books_id and
hou.organization_id=rctlgda.org_id and
gl.set_of_books_id=rcta.set_of_books_id and
rcta.complete_flag='Y' and
rcta.org_id=rctta.org_id and
rcta.cust_trx_type_id=rctta.cust_trx_type_id and
rcta.customer_trx_id=rctla.customer_trx_id and
rctla.line_type!='TAX' and
rctla.customer_trx_line_id=rctlgda.customer_trx_line_id and
rctlgda.account_class in ('FREIGHT','REV','SUSPENSE','UNEARN','UNBILL') and
rctlgda.latest_rec_flag is null and
rcta.bill_to_site_use_id=hcsua.site_use_id and
hcsua.cust_acct_site_id=hcasa.cust_acct_site_id and
hcasa.party_site_id=hps.party_site_id and
hps.location_id=hl.location_id and
hl.country=ftv.territory_code
order by
nvl2(ftv.alternate_territory_code,'Y',null),
ftv.territory_short_name,
hcsua.tax_reference,
rcta.invoice_currency_code