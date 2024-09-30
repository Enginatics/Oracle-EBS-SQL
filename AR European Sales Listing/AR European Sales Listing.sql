/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR European Sales Listing
-- Description: Summary report listing sales by country and currency code, with transaction amount / currency and accounted amount/ currency
-- Excel Examle Output: https://www.enginatics.com/example/ar-european-sales-listing/
-- Library Link: https://www.enginatics.com/reports/ar-european-sales-listing/
-- Run Report: https://demo.enginatics.com/

select distinct
gl.name ledger,
gl.currency_code ledger_currency,
hou.name operating_unit,
(select
 hl.address1
 from
 hz_cust_acct_sites hcasa,
 hz_party_sites hps,
 hz_locations hl
 where
 hcasa.cust_acct_site_id=:remit_to_address and
 hcasa.cust_account_id=-1 and
 hcasa.party_site_id=hps.party_site_id and
 hps.location_id=hl.location_id
) branch,
(select
 ftv.territory_short_name
 from
 hz_cust_acct_sites_all hcasa,
 hz_party_sites hps,
 hz_locations hl,
 fnd_territories_vl ftv
 where
 hcasa.cust_acct_site_id=rcta.remit_to_address_id and
 hcasa.cust_account_id=-1 and
 hcasa.party_site_id=hps.party_site_id and
 hps.location_id=hl.location_id and
 hl.country=ftv.territory_code
) branch_country,
(select
 nvl(zptp.rep_registration_number,zr.registration_number)
 from
 xle_etb_profiles xep,
 zx_party_tax_profile zptp,
 zx_registrations zr
 where
 xep.legal_entity_id = arp_legal_entity_util.get_default_legal_context(hou.organization_id) and
 xep.main_establishment_flag = 'Y' and
 xep.party_id = zptp.party_id and
 zptp.party_type_code = 'LEGAL_ESTABLISHMENT' and
 zptp.party_tax_profile_id = zr.party_tax_profile_id and
 trunc(sysdate) between trunc(zr.effective_from) and trunc(nvl(zr.effective_to,sysdate)) and
 ( (zr.default_registration_flag = 'Y' and
    not exists
    (select
     1
     from
     zx_registrations zr1,
     zx_party_tax_profile zptp1,
     xle_etb_profiles xep1
     where
     xep1.legal_entity_id = arp_legal_entity_util.get_default_legal_context(hou.organization_id) and
     xep1.main_establishment_flag = 'Y' and
     xep1.party_id = zptp1.party_id and
     zptp1.party_type_code = 'LEGAL_ESTABLISHMENT' and
     zptp1.party_tax_profile_id = zr1.party_tax_profile_id and
     trunc(sysdate) between trunc(zr1.effective_from) and trunc(nvl(zr1.effective_to,sysdate)) and
     zr1.registration_id <> zr.registration_id and
     zr.default_registration_flag = 'Y'
    )
   ) or
   not exists
   (select
    1
    from
    zx_registrations zr1,
    zx_party_tax_profile zptp1,
    xle_etb_profiles xep1
    where
    xep1.legal_entity_id = arp_legal_entity_util.get_default_legal_context(hou.organization_id) and
    xep1.main_establishment_flag = 'Y' and
    xep1.party_id = zptp1.party_id and
    zptp1.party_type_code = 'LEGAL_ESTABLISHMENT' and
    zptp1.party_tax_profile_id = zr1.party_tax_profile_id and
    trunc(sysdate) between trunc(zr1.effective_from) and trunc(nvl(zr1.effective_to,sysdate)) and
    zr1.registration_id <> zr.registration_id
   )
 )
) trader_tax_registration_num,
dense_rank() over (order by nvl2(ftv.alternate_territory_code,'Y',null), ftv.territory_short_name, nvl(zptp.rep_registration_number,zr.registration_number), rcta.invoice_currency_code, decode(:p_rep_type,'D',rctla.customer_trx_line_id)) line_number,
nvl2(ftv.alternate_territory_code,'Y',null) eu_flag,
ftv.territory_short_name country,
ftv.territory_code country_code,
nvl(zptp.rep_registration_number,zr.registration_number) tax_registration_num,
rcta.invoice_currency_code currency_code,
sum(nvl(rctlgda.amount,0)) over (partition by ftv.territory_short_name, ftv.territory_code, nvl(zptp.rep_registration_number,zr.registration_number), rcta.invoice_currency_code, decode(:p_rep_type,'D',rctla.customer_trx_line_id)) amount,
sum(nvl(rctlgda.acctd_amount,0)) over (partition by ftv.territory_short_name, ftv.territory_code, nvl(zptp.rep_registration_number,zr.registration_number), rcta.invoice_currency_code, decode(:p_rep_type,'D',rctla.customer_trx_line_id)) acctd_amount
from
gl_ledgers gl,
hr_operating_units hou,
ra_customer_trx_all rcta,
ra_cust_trx_types_all rctta,
ra_customer_trx_lines_all rctla,
ra_cust_trx_line_gl_dist_all rctlgda,
hz_cust_site_uses_all hcsua,
hz_cust_acct_sites_all hcasa,
hz_party_sites hps,
hz_locations hl,
fnd_territories_vl ftv,
zx_party_tax_profile zptp,
(select
 zr.*
 from
  (select
   zr.party_tax_profile_id,
   zr.registration_number,
   count(zr.registration_number) over (partition by zr.party_tax_profile_id) reg_count
   from
   zx_registrations zr
   where
    sysdate between zr.effective_from and NVL(zr.effective_to,sysdate+1)
  ) zr
 where
 zr.reg_count = 1
) zr
where
1=1 and
rcta.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
gl.ledger_id=hou.set_of_books_id and
gl.ledger_id=rcta.set_of_books_id and
hou.organization_id=rcta.org_id and
rcta.complete_flag='Y' and
rcta.org_id=rctta.org_id and
rcta.cust_trx_type_id=rctta.cust_trx_type_id and
decode(rctta.type,'CM',:remit_to_address,rcta.remit_to_address_id)=:remit_to_address and
rcta.customer_trx_id=rctla.customer_trx_id and
rctla.line_type!='TAX' and
rctla.customer_trx_line_id=rctlgda.customer_trx_line_id and
rctlgda.account_class in ('FREIGHT','REV','SUSPENSE','UNEARN','UNBILL') and
rctlgda.latest_rec_flag is null and
case nvl(:site_use_code,'BILL_TO') when 'BILL_TO' then rcta.bill_to_site_use_id else nvl(rcta.ship_to_site_use_id,rcta.bill_to_site_use_id) end = hcsua.site_use_id and
hcsua.cust_acct_site_id=hcasa.cust_acct_site_id and
hcasa.party_site_id=hps.party_site_id and
hps.location_id=hl.location_id and
hl.country=ftv.territory_code and
--hl.country != nvl(:country,'?') and
hps.party_site_id=zptp.party_id  and
zptp.party_type_code = 'THIRD_PARTY_SITE' and
zptp.party_tax_profile_id = zr.party_tax_profile_id (+)
order by
line_number