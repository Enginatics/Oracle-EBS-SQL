/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Customer Profiles
-- Description: Customer account and site level profile details such as profile class, payment terms, statement, dunning, collector and credit settings, including the profile amount limits per currency.
Application: Receivables
Source: Customer Profiles Report (XML)
Short Name: ARXCCP_XML
DB package: AR_ARXCCP_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/ar-customer-profiles/
-- Library Link: https://www.enginatics.com/reports/ar-customer-profiles/
-- Run Report: https://demo.enginatics.com/

select
hp.party_name customer_name,
hca.account_number,
haouv.name operating_unit,
hcsua.location site_location,
hps.party_site_number site_number,
hz_format_pub.format_address(hps.location_id,null,null,' , ') site_address,
ftv.territory_short_name site_country,
xxen_util.meaning(hcsua.site_use_code,'SITE_USE_CODE',222) site_use,
hcpc.name profile_class,
hcpc.description profile_class_description,
xxen_util.meaning(hcp.status,'CODE_STATUS',222) profile_status,
rtv.name payment_terms,
xxen_util.yes(hcp.override_terms) override_terms,
xxen_util.yes(hcp.discount_terms) discount_allowed,
hcp.discount_grace_days,
hcp.payment_grace_days receipt_grace_days,
ac.name collector,
xxen_util.meaning(hcp.credit_rating,'CREDIT_RATING',222) credit_rating,
xxen_util.meaning(hcp.risk_code,'RISK_CODE',222) risk_code,
xxen_util.yes(hcp.credit_hold) credit_hold,
xxen_util.yes(hcp.credit_checking) credit_check,
hcp.tolerance,
hcp.percent_collectable,
xxen_util.meaning(hcp.account_status,'ACCOUNT_STATUS',222) account_status,
xxen_util.yes(hcp.send_statements) send_statements,
ascl.name statement_cycle,
xxen_util.yes(hcp.credit_balance_statements) send_credit_balance_statements,
xxen_util.yes(hcp.interest_charges) charge_interest,
hcp.interest_period_days,
xxen_util.yes(hcp.charge_on_finance_charge_flag) compound_interest,
xxen_util.yes(hcp.dunning_letters) dunning_letters,
adls.name dunning_letter_set,
aah.hierarchy_name autocash_rule_set,
xxen_util.yes(hcp.auto_rec_incl_disputed_flag) include_disputed_items,
xxen_util.meaning(hcp.tax_printing_option,'TAX_PRINTING_OPTION',222) tax_printing,
rgr.name grouping_rule,
xxen_util.yes(hcp.cons_inv_flag) balance_forward_billing,
xxen_util.meaning(decode(hcp.cons_inv_flag,'Y',nvl(hcp.cons_inv_type,'SUMMARY'),hcp.cons_inv_type),'HZ_CONS_INV_TYPE',222) balance_forward_bill_type,
hcpa.currency_code,
hcpa.interest_rate,
hcpa.max_interest_charge,
hcpa.min_fc_balance_amount min_finance_charge_balance,
hcpa.min_fc_invoice_amount min_finance_charge_invoice,
hcpa.min_statement_amount,
hcpa.auto_rec_min_receipt_amount min_receipt_amount,
hcpa.min_dunning_amount,
hcpa.min_dunning_invoice_amount,
hcpa.overall_credit_limit credit_limit,
hcpa.trx_credit_limit order_credit_limit
from
hz_cust_accounts hca,
hz_parties hp,
hz_customer_profiles hcp,
hz_cust_profile_classes hcpc,
ar_collectors ac,
ra_terms_vl rtv,
ar_statement_cycles ascl,
ar_dunning_letter_sets adls,
ar_autocash_hierarchies aah,
ra_grouping_rules rgr,
hz_cust_site_uses_all hcsua,
hz_cust_acct_sites_all hcasa,
hz_party_sites hps,
hr_all_organization_units_vl haouv,
fnd_territories_vl ftv,
hz_locations hl,
hz_cust_profile_amts hcpa
where
1=1 and
hca.cust_account_id=hcp.cust_account_id and
hca.party_id=hp.party_id and
hcp.profile_class_id=hcpc.profile_class_id(+) and
hcp.collector_id=ac.collector_id and
hcp.standard_terms=rtv.term_id(+) and
hcp.statement_cycle_id=ascl.statement_cycle_id(+) and
hcp.dunning_letter_set_id=adls.dunning_letter_set_id(+) and
hcp.autocash_hierarchy_id=aah.autocash_hierarchy_id(+) and
hcp.grouping_rule_id=rgr.grouping_rule_id(+) and
hcp.site_use_id=hcsua.site_use_id(+) and
hcsua.cust_acct_site_id=hcasa.cust_acct_site_id(+) and
hcsua.org_id=haouv.organization_id(+) and
hcasa.party_site_id=hps.party_site_id(+) and
hps.location_id=hl.location_id(+) and
hl.country=ftv.territory_code(+) and
hcp.cust_account_profile_id=hcpa.cust_account_profile_id(+) and
(hcp.site_use_id is null or hcsua.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11))
order by
hp.party_name,
hca.account_number,
hcsua.location,
hcpa.currency_code