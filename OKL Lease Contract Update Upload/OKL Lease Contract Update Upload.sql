/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: OKL Lease Contract Update Upload
-- Description: Changes the bill to customer account and bill to site of Lease Management contracts through the Oracle public API oklcontractpub.updatecontractheader - the Bill To of the Lease Contract header.
-- One row per contract. Enter the Bill To Customer Account, the Bill To Site, or both; everything else on the row is context and is read only. A site that does not belong to the Bill To Customer Account on the row is rejected, so change both together when the account changes too.
-- A bill to change does not require a rebook: it was verified against Booked, Evergreen, Passed and Incomplete contracts. Rebook remains necessary for the financial terms this upload does not touch.
-- Run it under a Lease Management responsibility. Under an unrelated responsibility Oracle refuses the update with its own privilege message.
-- Excel Example Output: https://www.enginatics.com/example/okl-lease-contract-update-upload/
-- Library Link: https://www.enginatics.com/reports/okl-lease-contract-update-upload/
-- Run Report: https://demo.enginatics.com/

select
to_char(null) action_,
to_char(null) status_,
to_char(null) message_,
null modified_columns_,
haouv.name operating_unit,
okhab.contract_number,
osv.meaning contract_status,
xxen_util.meaning(okh.deal_type,'OKL_BOOK_CLASS',0) deal_type,
okhab.currency_code,
okhab.start_date contract_start_date,
okhab.end_date contract_end_date,
hca.account_number bill_to_customer_account,
hp.party_name bill_to_customer_name,
hcsua.location bill_to_site,
hl.address1||nvl2(hl.city,', '||hl.city,null)||nvl2(hl.postal_code,' '||hl.postal_code,null) bill_to_address,
to_char(okhab.id) chr_id,
null upload_row
from
okc_k_headers_all_b okhab,
okl_k_headers okh,
hr_all_organization_units_vl haouv,
okc_statuses_v osv,
hz_cust_accounts hca,
hz_parties hp,
hz_cust_site_uses_all hcsua,
hz_cust_acct_sites_all hcasa,
hz_party_sites hps,
hz_locations hl
where
1=1 and
okhab.scs_code='LEASE' and
okhab.authoring_org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat) and
okhab.id=okh.id and
okhab.authoring_org_id=haouv.organization_id and
okhab.sts_code=osv.code and
okhab.cust_acct_id=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
okhab.bill_to_site_use_id=hcsua.site_use_id(+) and
hcsua.cust_acct_site_id=hcasa.cust_acct_site_id(+) and
hcasa.party_site_id=hps.party_site_id(+) and
hps.location_id=hl.location_id(+)
