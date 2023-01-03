/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Customer Credit Limits
-- Description: Master data report for customer setup audit of credit amount limits and GL accounts for customer credit management and dunning notices.
-- Excel Examle Output: https://www.enginatics.com/example/ar-customer-credit-limits/
-- Library Link: https://www.enginatics.com/reports/ar-customer-credit-limits/
-- Run Report: https://demo.enginatics.com/

select
x.operating_unit,
x.party_name,
x.currency_code,
&column_party
&column_account
&column_site_use
x.party_number
from
(
select
haouv.name operating_unit,
hp.party_name,
hp.party_number,
hca.account_number,
fc.currency_code,
hcsua.location,
hcsua.site_use_code,
hcasa.party_site_id,
(select hcp.cust_account_profile_id from hz_customer_profiles hcp where hp.party_id=hcp.party_id and hcp.cust_account_id=-1) party_level_id,
(select hcp.cust_account_profile_id from hz_customer_profiles hcp where hca.cust_account_id=hcp.cust_account_id and hcp.site_use_id is null) account_level_id,
(select hcp.cust_account_profile_id from hz_customer_profiles hcp where hcsua.site_use_id=hcp.site_use_id) site_use_level_id
from
hr_all_organization_units_vl haouv,
hz_parties hp,
(select hca.* from hz_cust_accounts hca where :display_level in ('Account','Site Use','All')) hca,
(select hcasa.* from hz_cust_acct_sites_all hcasa where :display_level in ('Site Use','All')) hcasa,
(select hcsua.* from hz_cust_site_uses_all hcsua where :display_level in ('Site Use','All')) hcsua,
fnd_currencies fc
where
1=1 and
hp.party_id=hca.party_id(+) and
hca.cust_account_id=hcasa.cust_account_id(+) and
hcasa.org_id=haouv.organization_id(+) and
hcasa.cust_acct_site_id=hcsua.cust_acct_site_id(+)
) x,
hz_cust_profile_amts hcpa0,
hz_cust_profile_amts hcpa1,
hz_cust_profile_amts hcpa2,
hz_party_sites hps,
hz_locations hl,
fnd_territories_tl ftt
where
(
hcpa0.auto_rec_min_receipt_amount is not null or
hcpa0.overall_credit_limit is not null or
hcpa0.trx_credit_limit is not null or
hcpa0.min_statement_amount is not null or
hcpa0.min_dunning_amount is not null or
hcpa0.min_dunning_invoice_amount is not null or
hcpa1.auto_rec_min_receipt_amount is not null or
hcpa1.overall_credit_limit is not null or
hcpa1.trx_credit_limit is not null or
hcpa1.min_statement_amount is not null or
hcpa1.min_dunning_amount is not null or
hcpa1.min_dunning_invoice_amount is not null or
hcpa2.auto_rec_min_receipt_amount is not null or
hcpa2.overall_credit_limit is not null or
hcpa2.trx_credit_limit is not null or
hcpa2.min_statement_amount is not null or
hcpa2.min_dunning_amount is not null or
hcpa2.min_dunning_invoice_amount is not null
) and
x.party_level_id=hcpa0.cust_account_profile_id(+) and
x.account_level_id=hcpa1.cust_account_profile_id(+) and
x.site_use_level_id=hcpa2.cust_account_profile_id(+) and
x.currency_code=hcpa0.currency_code(+) and
x.currency_code=hcpa1.currency_code(+) and
x.currency_code=hcpa2.currency_code(+) and
x.party_site_id=hps.party_site_id(+) and
hps.location_id=hl.location_id(+) and
hl.country=ftt.territory_code(+) and
ftt.language(+)=userenv('lang')
order by
x.party_name,
hl.country,
hps.party_site_number,
x.operating_unit,
x.currency_code