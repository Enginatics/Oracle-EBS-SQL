/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Customers and Sites
-- Description: Customer master data including address, profile information, sites and site uses
-- Excel Examle Output: https://www.enginatics.com/example/ar-customers-and-sites
-- Library Link: https://www.enginatics.com/reports/ar-customers-and-sites
-- Run Report: https://demo.enginatics.com/


select
x.ou,
x.party_type,
x.party_name,
x.url,
x.duns_number,
x.sic_code,
x.category,
x.account_number,
x.reference,
x.site_reference,
x.site_use_reference,
x.account_type,
x.classification,
x.sales_channel,
hcpc.name profile_class,
xxen_util.meaning(x.credit_classification,'AR_CMGT_CREDIT_CLASSIFICATION',222) credit_classification,
x.site_name,
x.site_number,
x.location,
x.address,
x.country,
x.identifying_address_flag,
x.site_use,
x.primary_flag,
jrret.resource_name primary_salesrep,
ottt.name order_type,
qlht.name price_list,
x.ship_partial,
xxen_util.meaning(x.fob_point,'FOB',222) fob,
x.tax_reference,
&column_trx_count
x.profile_level,
rtt.name payment_term,
xxen_util.meaning(x.send_statement,'YES_NO',0) send_statement,
ascl.name statement_cycle,
xxen_util.meaning(x.send_credit_balance,'YES_NO',0) send_credit_balance,
xxen_util.meaning(x.send_dunning_letters,'YES_NO',0) send_dunning_letters,
adls.name dunning_letter,
ac.name collector_name,
x.tax_code,
avtab.tax_rate,
xxen_util.meaning(x.freight_term,'FREIGHT_TERMS',660) freight_term,
xxen_util.meaning(x.ship_via,'SHIP_METHOD',3) carrier,
x.ship_sets,
x.demand_class,
haou2.name warehouse,
x.party_status,
x.account_status,
x.site_status,
x.site_use_status,
xxen_util.user_name(x.created_by) created_by,
xxen_util.client_time(x.creation_date) creation_date,
xxen_util.user_name(x.last_updated_by) last_updated_by,
xxen_util.client_time(x.last_update_date) last_update_date
from
(
select
hou.name ou,
initcap(hp.party_type) party_type,
hp.party_name,
hp.url,
hp.duns_number,
decode(hp.party_type,'ORGANIZATION',hp.sic_code) sic_code,
xxen_util.meaning(hcas.class_code,'CUSTOMER_CATEGORY',222) category,
hca.account_number,
hca.orig_system_reference reference,
hcasa.orig_system_reference site_reference,
hcsua.orig_system_reference site_use_reference,
decode(hca.customer_type,'R','External','I','Internal') account_type,
xxen_util.meaning(hca.customer_class_code,'CUSTOMER CLASS',222) classification,
xxen_util.meaning(hca.sales_channel_code,'SALES_CHANNEL',660) sales_channel,
hps.party_site_name site_name,
hps.party_site_number site_number,
hcsua.location,
hz_format_pub.format_address (hps.location_id,null,null,' , ') address,
ftt.territory_short_name country,
xxen_util.meaning(hps.identifying_address_flag,'YES_NO',0) identifying_address_flag,
xxen_util.meaning(hcsua.site_use_code,'SITE_USE_CODE',222) site_use,
xxen_util.meaning(hcsua.primary_flag,'YES_NO',0) primary_flag,
xxen_util.meaning(hcsua.ship_partial,'YES_NO',0) ship_partial,
hcsua.tax_reference,
nvl(hcsua.tax_code,hca.tax_code) tax_code,
xxen_util.meaning(hcsua.demand_class_code,'DEMAND_CLASS',3) demand_class,
xxen_util.meaning(hcsua.ship_sets_include_lines_flag,'YES_NO',0) ship_sets,
decode(hp.status,'A','Active','I','Inactive','D','Deleted') party_status,
decode(hca.status,'A','Active','I','Inactive','D','Deleted') account_status,
decode(hcasa.status,'A','Active','I','Inactive','D','Deleted') site_status,
decode(hcsua.status,'A','Active','I','Inactive','D','Deleted') site_use_status,
nvl(hcsua.fob_point,hca.fob_point) fob_point,
nvl(hcsua.freight_term,hca.freight_term) freight_term,
nvl(hcsua.ship_via,hca.ship_via) ship_via,
nvl(hcsua.order_type_id,hca.order_type_id) order_type_id,
nvl(hcsua.price_list_id,hca.price_list_id) price_list_id,
nvl(hcsua.primary_salesrep_id,hca.primary_salesrep_id) primary_salesrep_id,
nvl(hcsua.org_id,hcasa.org_id) org_id,
nvl2(hcp2.cust_account_profile_id,'site',nvl2(hcp1.cust_account_profile_id,'account',null)) profile_level,
nvl(hcp2.profile_class_id,hcp1.profile_class_id) profile_class_id,
nvl(hcp2.send_statements,hcp1.send_statements) send_statement,
nvl(hcp2.credit_balance_statements,hcp1.credit_balance_statements) send_credit_balance,
nvl(hcp2.statement_cycle_id,hcp1.statement_cycle_id) statement_cycle_id,
nvl(hcp2.dunning_letters,hcp1.dunning_letters) send_dunning_letters,
nvl(hcp2.dunning_letter_set_id,hcp1.dunning_letter_set_id) dunning_letter_set_id,
nvl(hcp2.standard_terms,nvl(hcsua.payment_term_id,nvl(hcp1.standard_terms,hca.payment_term_id))) payment_term_id,
nvl(hcp2.collector_id,hcp1.collector_id) collector_id,
nvl(hcp2.credit_classification,hcp1.credit_classification) credit_classification,
nvl(hcp2.cust_account_profile_id,hcp1.cust_account_profile_id) cust_account_profile_id,
nvl(hcsua.warehouse_id,hca.warehouse_id) warehouse_id,
hou.set_of_books_id,
hca.cust_account_id,
hcsua.site_use_id,
hp.created_by,
hp.creation_date,
hp.last_updated_by,
hp.last_update_date
from
hr_operating_units hou,
hz_parties hp,
hz_cust_accounts hca,
(select hcasa.* from hz_cust_acct_sites_all hcasa where :detail_level in ('Site','Site Use')) hcasa,
hz_party_sites hps,
hz_locations hl,
fnd_territories_tl ftt,
(select hcsua.* from hz_cust_site_uses_all hcsua where :detail_level in ('Site Use')) hcsua,
(select hcp.* from hz_customer_profiles hcp where hcp.site_use_id is null) hcp1,
(select hcp.* from hz_customer_profiles hcp where hcp.site_use_id is not null and :detail_level='Site Use') hcp2,
(select hcas.* from hz_code_assignments hcas where hcas.owner_table_name='HZ_PARTIES' and hcas.class_category='CUSTOMER_CATEGORY' and hcas.primary_flag='Y') hcas
where
1=1 and
hp.party_id=hca.party_id and
hca.cust_account_id=hcasa.cust_account_id(+) and
hcasa.org_id=hou.organization_id(+) and
hcasa.party_site_id=hps.party_site_id(+) and
hps.location_id=hl.location_id(+) and
hl.country=ftt.territory_code(+) and
ftt.language(+)=userenv('lang') and
hcasa.cust_acct_site_id=hcsua.cust_acct_site_id(+) and
hca.cust_account_id=hcp1.cust_account_id(+) and
hcsua.site_use_id=hcp2.site_use_id(+) and
hp.party_id=hcas.owner_table_id(+)
) x,
qp_list_headers_tl qlht,
jtf_rs_salesreps jrs,
(select jrret.* from jtf_rs_resource_extns_tl jrret where jrret.language=userenv('lang') and jrret.category in ('EMPLOYEE','OTHER','PARTY','PARTNER','SUPPLIER_CONTACT')) jrret,
hz_cust_profile_classes hcpc,
oe_transaction_types_tl ottt,
hr_all_organization_units haou2,
(select x.* from (select max(avtab.vat_tax_id) over (partition by avtab.set_of_books_id, avtab.tax_code) max_vat_tax_id, avtab.* from ar_vat_tax_all_b avtab where sysdate between avtab.start_date and nvl(avtab.end_date,sysdate)) x where x.vat_tax_id=x.max_vat_tax_id) avtab,
ra_terms_tl rtt,
ar_dunning_letter_sets adls,
ar_statement_cycles ascl,
ar_collectors ac
where
x.price_list_id=qlht.list_header_id(+) and
qlht.language(+)=userenv('lang') and
x.primary_salesrep_id=jrs.salesrep_id(+) and
x.org_id=jrs.org_id(+) and
jrs.resource_id=jrret.resource_id(+) and
x.profile_class_id=hcpc.profile_class_id(+) and
x.order_type_id=ottt.transaction_type_id(+) and
ottt.language(+)=userenv('lang') and
x.warehouse_id=haou2.organization_id(+) and
x.tax_code=avtab.tax_code(+) and
x.set_of_books_id=avtab.set_of_books_id(+) and
x.payment_term_id=rtt.term_id(+) and
rtt.language(+)=userenv('lang') and
x.dunning_letter_set_id=adls.dunning_letter_set_id(+) and
x.statement_cycle_id=ascl.statement_cycle_id(+) and
x.collector_id=ac.collector_id(+)
order by
x.party_name,
x.ou,
x.country,
x.address,
x.site_use