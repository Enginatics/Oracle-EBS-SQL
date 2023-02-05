/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Customers and Sites
-- Description: Master data report of customer master data including address, sites, site uses, payment terms, Salesperson, price list and other profile information.
-- Excel Examle Output: https://www.enginatics.com/example/ar-customers-and-sites/
-- Library Link: https://www.enginatics.com/reports/ar-customers-and-sites/
-- Run Report: https://demo.enginatics.com/

select
x.operating_unit,
x.party_type,
x.party_name,
x.party_number,
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
jrret1.resource_name primary_salesrep,
jrret1.resource_name site_primary_salesrep,
x.order_type,
x.site_order_type,
x.price_list,
x.site_price_list,
x.profile_class,
x.site_profile_class,
x.credit_classification,
x.site_credit_classification,
x.site_name,
x.site_number,
x.location,
x.address,
x.country,
x.identifying_address_flag,
x.site_use,
x.primary_flag,
x.ship_partial,
x.tax_reference,
avtab1.tax_rate,
avtab2.tax_rate site_tax_rate,
&column_trx_count
x.latest_trx_date,
x.pay_sched_last_update_date,
x.demand_class,
x.ship_sets,
x.party_status,
x.account_status,
x.site_status,
x.site_use_status,
x.warehouse,
x.site_warehouse,
x.fob,
x.site_fob,
x.freight_term,
x.site_freight_term,
x.carrier,
x.site_carrier,
rtt1.name payment_term,
rtt2.name site_payment_term,
x.send_statement,
x.site_send_statement,
x.statement_cycle,
x.site_statement_cycle,
x.send_credit_balance,
x.site_send_credit_balance,
x.send_dunning_letters,
x.site_send_dunning_letters,
x.dunning_letter,
x.site_dunning_letter,
x.collector_name,
x.site_collector_name,
x.credit_class_code,
x.site_credit_class_code,
x.receivables_account,
x.receivables_account_desc,
x.created_by,
x.creation_date,
x.last_updated_by,
x.last_update_date,
x.account_created_by,
x.account_creation_date,
x.account_last_updated_by,
x.account_last_update_date,
x.site_created_by,
x.site_creation_date,
x.site_last_updated_by,
x.site_last_update_date,
x.profile_created_by,
x.profile_creation_date,
x.profile_last_updated_by,
x.profile_last_update_date,
x.site_profile_created_by,
x.site_profile_creation_date,
x.site_profile_last_updated_by,
x.site_profile_last_update_date,
x.org_id,
x.profile_level,
x.cust_account_profile_id,
x.site_cust_account_profile_id,
x.cust_account_id,
x.site_use_id
from
(
select
hou.name operating_unit,
initcap(hp.party_type) party_type,
hp.party_name,
hp.party_number,
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
ottt1.name order_type,
ottt2.name site_order_type,
qlht1.name price_list,
qlht2.name site_price_list,
hcpc1.name profile_class,
hcpc2.name site_profile_class,
xxen_util.meaning(hcpc1.credit_classification,'AR_CMGT_CREDIT_CLASSIFICATION',222) credit_classification,
xxen_util.meaning(hcpc2.credit_classification,'AR_CMGT_CREDIT_CLASSIFICATION',222) site_credit_classification,
hps.party_site_name site_name,
hps.party_site_number site_number,
hcsua.location,
hz_format_pub.format_address (hps.location_id,null,null,' , ') address,
ftt.territory_short_name country,
xxen_util.meaning(decode(hps.identifying_address_flag,'Y','Y'),'YES_NO',0) identifying_address_flag,
xxen_util.meaning(hcsua.site_use_code,'SITE_USE_CODE',222) site_use,
xxen_util.meaning(hcsua.primary_flag,'YES_NO',0) primary_flag,
xxen_util.meaning(hcsua.ship_partial,'YES_NO',0) ship_partial,
hcsua.tax_reference,
coalesce(
(select max(rcta.trx_date) from ra_customer_trx_all rcta where rcta.bill_to_customer_id = hca.cust_account_id and rcta.bill_to_site_use_id = nvl(hcsua.site_use_id,rcta.bill_to_site_use_id) and :detail_level != 'Site'),
(select max(rcta.trx_date) from ra_customer_trx_all rcta where rcta.ship_to_customer_id = hca.cust_account_id and rcta.ship_to_site_use_id = nvl(hcsua.site_use_id,rcta.ship_to_site_use_id) and :detail_level != 'Site'),
(select max(rcta.trx_date) from ra_customer_trx_all rcta, hz_cust_site_uses_all hcsua2 where rcta.ship_to_customer_id = hca.cust_account_id and rcta.bill_to_site_use_id = hcsua2.site_use_id and hcsua2.cust_acct_site_id = hcasa.cust_acct_site_id and :detail_level = 'Site'),
(select max(rcta.trx_date) from ra_customer_trx_all rcta, hz_cust_site_uses_all hcsua2 where rcta.ship_to_customer_id = hca.cust_account_id and rcta.ship_to_site_use_id = hcsua2.site_use_id and hcsua2.cust_acct_site_id = hcasa.cust_acct_site_id and :detail_level = 'Site')
) latest_trx_date,
coalesce(
(select max(xxen_util.client_time(apsa.last_update_date)) from ar_payment_schedules_all apsa where apsa.customer_id = hca.cust_account_id and apsa.customer_site_use_id = nvl(hcsua.site_use_id,apsa.customer_site_use_id) and :detail_level != 'Site'),
(select max(xxen_util.client_time(apsa.last_update_date)) from ar_payment_schedules_all apsa, ra_customer_trx_all rcta where apsa.customer_trx_id = rcta.customer_trx_id and rcta.ship_to_customer_id = hca.cust_account_id and rcta.ship_to_site_use_id = nvl(hcsua.site_use_id,rcta.ship_to_site_use_id) and :detail_level != 'Site'),
(select max(xxen_util.client_time(apsa.last_update_date)) from ar_payment_schedules_all apsa, hz_cust_site_uses_all hcsua2 where apsa.customer_id = hca.cust_account_id and apsa.customer_site_use_id = hcsua2.site_use_id and hcsua2.cust_acct_site_id = hcasa.cust_acct_site_id and :detail_level = 'Site'),
(select max(xxen_util.client_time(apsa.last_update_date)) from ar_payment_schedules_all apsa, ra_customer_trx_all rcta, hz_cust_site_uses_all hcsua2 where apsa.customer_trx_id = rcta.customer_trx_id and rcta.ship_to_customer_id = hca.cust_account_id and rcta.ship_to_site_use_id = hcsua2.site_use_id and hcsua2.cust_acct_site_id = hcasa.cust_acct_site_id and :detail_level = 'Site')
) pay_sched_last_update_date,
xxen_util.meaning(hcsua.demand_class_code,'DEMAND_CLASS',3) demand_class,
xxen_util.meaning(hcsua.ship_sets_include_lines_flag,'YES_NO',0) ship_sets,
decode(hp.status,'A','Active','I','Inactive','D','Deleted') party_status,
decode(hca.status,'A','Active','I','Inactive','D','Deleted') account_status,
decode(hcasa.status,'A','Active','I','Inactive','D','Deleted') site_status,
decode(hcsua.status,'A','Active','I','Inactive','D','Deleted') site_use_status,
haouv1.name warehouse,
haouv2.name site_warehouse,
xxen_util.meaning(hca.fob_point,'FOB',222) fob,
xxen_util.meaning(hcsua.fob_point,'FOB',222) site_fob,
xxen_util.meaning(hca.freight_term,'FREIGHT_TERMS',660) freight_term,
xxen_util.meaning(hcsua.freight_term,'FREIGHT_TERMS',660) site_freight_term,
xxen_util.meaning(hca.ship_via,'SHIP_METHOD',3) carrier,
xxen_util.meaning(hcsua.ship_via,'SHIP_METHOD',3) site_carrier,
xxen_util.meaning(hcp1.send_statements,'YES_NO',0) send_statement,
xxen_util.meaning(hcp2.send_statements,'YES_NO',0) site_send_statement,
ascl1.name statement_cycle,
ascl2.name site_statement_cycle,
xxen_util.meaning(hcp1.credit_balance_statements,'YES_NO',0) send_credit_balance,
xxen_util.meaning(hcp2.credit_balance_statements,'YES_NO',0) site_send_credit_balance,
xxen_util.meaning(hcp1.dunning_letters,'YES_NO',0) send_dunning_letters,
xxen_util.meaning(hcp2.dunning_letters,'YES_NO',0) site_send_dunning_letters,
adls1.name dunning_letter,
adls2.name site_dunning_letter,
ac1.name collector_name,
ac2.name site_collector_name,
hcp1.credit_classification credit_class_code,
hcp2.credit_classification site_credit_class_code,
case when hcsua.gl_id_rec is not null then fnd_flex_xml_publisher_apis.process_kff_combination_1('recacct', 'SQLGL', 'GL#', gsob.chart_of_accounts_id, null, hcsua.gl_id_rec, 'ALL', 'Y', 'VALUE') else null end receivables_account,
case when hcsua.gl_id_rec is not null then fnd_flex_xml_publisher_apis.process_kff_combination_1('recacct', 'SQLGL', 'GL#', gsob.chart_of_accounts_id, null, hcsua.gl_id_rec, 'ALL', 'Y', 'DESCRIPTION') else null end receivables_account_desc,
xxen_util.user_name(hp.created_by) created_by,
xxen_util.client_time(hp.creation_date) creation_date,
xxen_util.user_name(hp.last_updated_by) last_updated_by,
xxen_util.client_time(hp.last_update_date) last_update_date,
xxen_util.user_name(hca.created_by) account_created_by,
xxen_util.client_time(hca.creation_date) account_creation_date,
xxen_util.user_name(hca.last_updated_by) account_last_updated_by,
xxen_util.client_time(hca.last_update_date) account_last_update_date,
xxen_util.user_name(hcasa.created_by) site_created_by,
xxen_util.client_time(hcasa.creation_date) site_creation_date,
xxen_util.user_name(hcasa.last_updated_by) site_last_updated_by,
xxen_util.client_time(hcasa.last_update_date) site_last_update_date,
xxen_util.user_name(hcp1.created_by) profile_created_by,
xxen_util.client_time(hcp1.creation_date) profile_creation_date,
xxen_util.user_name(hcp1.last_updated_by) profile_last_updated_by,
xxen_util.client_time(hcp1.last_update_date) profile_last_update_date,
xxen_util.user_name(hcp2.created_by) site_profile_created_by,
xxen_util.client_time(hcp2.creation_date) site_profile_creation_date,
xxen_util.user_name(hcp2.last_updated_by) site_profile_last_updated_by,
xxen_util.client_time(hcp2.last_update_date) site_profile_last_update_date,
nvl(hcsua.org_id,hcasa.org_id) org_id,
nvl2(hcp2.cust_account_profile_id,'site',nvl2(hcp1.cust_account_profile_id,'account',null)) profile_level,
hcp1.cust_account_profile_id,
hcp1.cust_account_profile_id site_cust_account_profile_id,
hca.cust_account_id,
hcsua.site_use_id,
--
hou.set_of_books_id,
hcasa.cust_acct_site_id,
hca.primary_salesrep_id primary_salesrep_id,
hcsua.primary_salesrep_id site_primary_salesrep_id,
nvl(hcp1.standard_terms,hca.payment_term_id) payment_term_id,
nvl(hcp2.standard_terms,hcsua.payment_term_id) site_payment_term_id,
hca.tax_code tax_code,
hcsua.tax_code site_tax_code
from
hr_operating_units hou,
gl_sets_of_books gsob,
hz_parties hp,
hz_cust_accounts hca,
(select hcasa.* from hz_cust_acct_sites_all hcasa where :detail_level in ('Site','Site Use')) hcasa,
hz_party_sites hps,
hz_locations hl,
fnd_territories_tl ftt,
(select hcsua.* from hz_cust_site_uses_all hcsua where :detail_level='Site Use') hcsua,
(select hcp.* from hz_customer_profiles hcp where hcp.site_use_id is null) hcp1,
(select hcp.* from hz_customer_profiles hcp where hcp.site_use_id is not null and :detail_level='Site Use') hcp2,
(select hcas.* from hz_code_assignments hcas where hcas.owner_table_name='HZ_PARTIES' and hcas.class_category='CUSTOMER_CATEGORY' and hcas.primary_flag='Y') hcas,
qp_list_headers_tl qlht1,
qp_list_headers_tl qlht2,
hz_cust_profile_classes hcpc1,
hz_cust_profile_classes hcpc2,
oe_transaction_types_tl ottt1,
oe_transaction_types_tl ottt2,
hr_all_organization_units_vl haouv1,
hr_all_organization_units_vl haouv2,
ar_dunning_letter_sets adls1,
ar_dunning_letter_sets adls2,
ar_statement_cycles ascl1,
ar_statement_cycles ascl2,
ar_collectors ac1,
ar_collectors ac2
where
1=1 and
(hcasa.org_id is null or hcasa.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual)) and
hp.party_id=hca.party_id and
hca.cust_account_id=hcasa.cust_account_id(+) and
hcasa.org_id=hou.organization_id(+) and
to_number(hou.set_of_books_id)=gsob.set_of_books_id(+) and
hcasa.party_site_id=hps.party_site_id(+) and
hps.location_id=hl.location_id(+) and
hl.country=ftt.territory_code(+) and
ftt.language(+)=userenv('lang') and
hcasa.cust_acct_site_id=hcsua.cust_acct_site_id(+) and
hca.cust_account_id=hcp1.cust_account_id(+) and
hcsua.site_use_id=hcp2.site_use_id(+) and
hp.party_id=hcas.owner_table_id(+) and
hca.price_list_id=qlht1.list_header_id(+) and
hcsua.price_list_id=qlht2.list_header_id(+) and
qlht1.language(+)=userenv('lang') and
qlht2.language(+)=userenv('lang') and
hcp1.profile_class_id=hcpc1.profile_class_id(+) and
hcp2.profile_class_id=hcpc2.profile_class_id(+) and
hca.order_type_id=ottt1.transaction_type_id(+) and
hcsua.order_type_id=ottt2.transaction_type_id(+) and
ottt1.language(+)=userenv('lang') and
ottt2.language(+)=userenv('lang') and
hca.warehouse_id=haouv1.organization_id(+) and
hcsua.warehouse_id=haouv2.organization_id(+) and
hcp1.dunning_letter_set_id=adls1.dunning_letter_set_id(+) and
hcp2.dunning_letter_set_id=adls2.dunning_letter_set_id(+) and
hcp1.statement_cycle_id=ascl1.statement_cycle_id(+) and
hcp2.statement_cycle_id=ascl2.statement_cycle_id(+) and
hcp1.collector_id=ac1.collector_id(+) and
hcp2.collector_id=ac2.collector_id(+)
) x,
jtf_rs_salesreps jrs1,
jtf_rs_salesreps jrs2,
(select jrret.* from jtf_rs_resource_extns_tl jrret where jrret.language=userenv('lang') and jrret.category in ('EMPLOYEE','OTHER','PARTY','PARTNER','SUPPLIER_CONTACT')) jrret1,
(select jrret.* from jtf_rs_resource_extns_tl jrret where jrret.language=userenv('lang') and jrret.category in ('EMPLOYEE','OTHER','PARTY','PARTNER','SUPPLIER_CONTACT')) jrret2,
(select x.* from (select max(avtab.vat_tax_id) over (partition by avtab.set_of_books_id, avtab.tax_code) max_vat_tax_id, avtab.* from ar_vat_tax_all_b avtab where sysdate between avtab.start_date and nvl(avtab.end_date,sysdate)) x where x.vat_tax_id=x.max_vat_tax_id) avtab1,
(select x.* from (select max(avtab.vat_tax_id) over (partition by avtab.set_of_books_id, avtab.tax_code) max_vat_tax_id, avtab.* from ar_vat_tax_all_b avtab where sysdate between avtab.start_date and nvl(avtab.end_date,sysdate)) x where x.vat_tax_id=x.max_vat_tax_id) avtab2,
ra_terms_tl rtt1,
ra_terms_tl rtt2
where
x.payment_term_id=rtt1.term_id(+) and
x.site_payment_term_id=rtt2.term_id(+) and
rtt1.language(+)=userenv('lang') and
rtt2.language(+)=userenv('lang') and
x.tax_code=avtab1.tax_code(+) and
x.site_tax_code=avtab2.tax_code(+) and
x.set_of_books_id=avtab1.set_of_books_id(+) and
x.set_of_books_id=avtab2.set_of_books_id(+) and
x.primary_salesrep_id=jrs1.salesrep_id(+) and
x.site_primary_salesrep_id=jrs2.salesrep_id(+) and
x.org_id=jrs1.org_id(+) and
x.org_id=jrs2.org_id(+) and
jrs1.resource_id=jrret1.resource_id(+) and
jrs2.resource_id=jrret2.resource_id(+)
order by
x.party_name,
x.operating_unit,
x.country,
x.address,
x.site_use