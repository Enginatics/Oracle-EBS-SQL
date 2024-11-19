/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ZX US Sales Tax
-- Description: Imported from Concurrent Program
Description: Sales Tax Report for use in U.S
Application: E-Business Tax
Source: U.S. Sales Tax Report
Short Name: ZXXSTR
-- Excel Examle Output: https://www.enginatics.com/example/zx-us-sales-tax/
-- Library Link: https://www.enginatics.com/reports/zx-us-sales-tax/
-- Run Report: https://demo.enginatics.com/

with
q_trx_lines as
(
-- Q1
select
 trx.invoice_currency_code c_currency,
 cy.precision c_precision,
 cy.minimum_accountable_unit c_minimum_accountable_unit,
 upper(loc.state) c_state,
 decode(:p_detail_level, 'Detail State', 'X', loc.county) c_county,
 decode(:p_detail_level, 'Detail State', 'X', loc.city) c_city,
 loc.postal_code c_ship_to_zip,
 decode(lower(:p_order_by), 'invoice date', trx.trx_date, null) c_order_by_1,
 rtrim(rpad(decode(lower(:p_order_by), 'invoice number', trx.trx_number, 'transaction type', decode( types.type, 'INV', '1', 'DM', '1', '2'), /* order credit memos 2nd */
 'customer number', cust_acct.account_number, 'customer name', party.party_name, null),30)) c_order_by_2,
 trx.trx_date c_order_by_3,
 /* these decodes can be removed when the report is changed to show trx_number and related trx number */
 /* in the meantime, the credit memo(applied or unapplied) is always shown as an adjustment */
 /* and the adjusted invoice is always shown under the inv_number field */
 decode( types.type, 'CM', nvl(zx_tax_str_pkg.get_credit_memo_trx_number(trx.previous_customer_trx_id), :p_onacct_lookup || ': ' || trx.trx_number), trx.trx_number) c_inv_number,
 decode(types.type,'INV','INVOICE','CM','CREDIT_MEMO','DM','DEBIT_MEMO') c_inv_type,
 types.type c_inv_type_code,
 decode( types.type, 'INV', 10, 'DM', 15, 'CM', 20, 30) c_inv_type_code_order,
 decode( types.type, 'CM', trx.trx_number, zx_tax_str_pkg.get_credit_memo_trx_number(trx.previous_customer_trx_id)) c_adj_number,
 to_number(null) c_adj_line_amount,
 to_number(null) c_adj_tax_amount,
 to_number(null) c_adj_freight_amount,
 null c_adj_type,
 /* the invoice date show for a credit memo, is the date of the invoice */
 /* unless the credit memo is on account. this is a bug, however for    */
 /* the purpose of bugfix on performance ( hilti 316742 ) this bug      */
 /* is kept to maintain backwards compatibility during testing.         */
 decode( types.type, 'CM', nvl(zx_tax_str_pkg.get_credit_memo_trx_date(trx.previous_customer_trx_id), trx.trx_date), trx.trx_date) c_inv_date,
 substrb(party.party_name,1,50) c_cust_name,
 cust_acct.account_number c_cust_number,
 su.location c_location,
 nvl(su.tax_code, cust_acct.tax_code) c_cust_tax_code,
 decode( types.type, 'INV', 'INVOICE', 'DM', 'INVOICE', 'CREDIT MEMO') c_type_flag,
 decode( types.type, 'CM', nvl(trx.previous_customer_trx_id,-1*trx.customer_trx_id), trx.customer_trx_id) c_inv_cust_trx_id,
 trx.customer_trx_id c_cust_trx_id,
 trx.batch_source_id c_batch_source_id,
 -1 c_adjustment_id,
 line.customer_trx_line_id c_trx_line_id,
 line.line_number c_line_number,
 line.description c_description,
 line.extended_amount c_line_amount,
 tax.line_number c_tax_line_number,
 tax.customer_trx_line_id c_tax_cust_trx_line_id,
 tax.tax_rate c_tax_rate,
 zx_rate.tax_rate_code c_vat_code,
 tax.tax_vendor_return_code c_tax_vendor_return_code,
 zx_tax.tax_type_code c_vat_code_type,
 zx_tax.tax c_tax,
 nvl(zx_exmp.exempt_certificate_number, tax.tax_exempt_number) c_exempt_number,
 nvl(zx_exmp.exempt_reason_code, tax.tax_exempt_reason_code) c_exempt_reason,
 zx_exmp.rate_modifier c_exempt_percent,
 nvl(tax.extended_amount,0) c_tax_amount,
 tax.item_exception_rate_id c_tax_except_rate_id,
 loc_assign.loc_id c_tax_authority_id,
 loc.postal_code c_tax_authority_zip_code,
 null c_adjusted_doc_date,
 tax.sales_tax_id c_sales_tax_id,
 case when
 :p_min_gl_flex is not null and
 :p_max_gl_flex is not null and
 gltax.concatenated_segments is not null and
 not(gltax.concatenated_segments between :p_min_gl_flex and :p_max_gl_flex)
 then 'N'
 else 'Y'
 end c_gltax_inrange_flag,
 'Y' c_historical_flag,
 tax.global_attribute_category c_global_attribute_category,
 tax.global_attribute1 c_vendor_location_qualifier,
 tax.global_attribute2 c_vendor_state_amt,
 tax.global_attribute3 c_vendor_state_rate,
 tax.global_attribute4 c_vendor_county_amt,
 tax.global_attribute5 c_vendor_county_rate,
 tax.global_attribute6 c_vendor_city_amt,
 tax.global_attribute7 c_vendor_city_rate,
 tax.global_attribute12 c_vendor_taxable_amts,
 tax.global_attribute13 c_vendor_non_taxable_amts,
 tax.global_attribute14 c_vendor_exempt_amts
from
 ra_customer_trx_all trx,
 zx_lines_det_factors zx_det,
 ra_cust_trx_line_gl_dist_all dist,
 ra_cust_trx_types_all types,
 hz_cust_site_uses_all su,
 hz_cust_acct_sites_all acct_site,
 hz_party_sites party_site,
 hz_locations loc,
 hz_loc_assignments_obs loc_assign,
 fnd_currencies cy,
 hz_cust_accounts cust_acct,
 hz_parties party,
 zx_rates_vl zx_rate,
 &lp_table_parent_deposit_type
 zx_exemptions zx_exmp,
 ra_customer_trx_lines_all line,
 ra_customer_trx_lines_all tax,
 ra_cust_trx_line_gl_dist_all taxdist,
 gl_code_combinations_kfv gltax,
 zx_taxes_b zx_tax -- new tabel zx_tax added
where
 nvl(zx_det.ship_to_cust_acct_site_use_id,zx_det.bill_to_cust_acct_site_use_id) = su.site_use_id and
 zx_det.trx_line_id = line.customer_trx_line_id and
 zx_det.internal_organization_id = line.org_id and
 zx_det.trx_id = trx.customer_trx_id and
 zx_det.trx_id = line.customer_trx_id and
 zx_det.application_id = 222 and
 zx_det.entity_code = 'TRANSACTIONS' and
----join conditions between zx_rate and zx_tax starts --------------
 zx_tax.content_owner_id = zx_rate.content_owner_id and
 zx_tax.tax_regime_code = zx_rate.tax_regime_code and
 zx_tax.tax = zx_rate.tax and
----join conditions between zx_rate and zx_tax end --------------
 su.cust_acct_site_id = acct_site.cust_acct_site_id and
 acct_site.party_site_id = party_site.party_site_id and
 loc.location_id = party_site.location_id and
 loc.location_id = loc_assign.location_id and
 nvl(acct_site.org_id,-99) = nvl(loc_assign.org_id,-99) and
 loc.country = 'US' and
 trx.cust_trx_type_id = types.cust_trx_type_id and
 nvl(trx.org_id,-99) = nvl(types.org_id,-99) and
 types.type in ( 'CM', 'INV', 'DM' ) and
 cy.currency_code = trx.invoice_currency_code and
 cust_acct.cust_account_id = zx_det.bill_third_pty_acct_id and
 party.party_id = cust_acct.party_id and
 dist.customer_trx_id = trx.customer_trx_id and
 dist.account_class = 'REC' and
 trx.customer_trx_id = line.customer_trx_id and
 line.customer_trx_line_id = tax.link_to_cust_trx_line_id(+) and
 nvl(line.historical_flag,'Y') = 'Y' and
 line.line_type = 'LINE' and
 tax.line_type(+) = 'TAX' and
 zx_rate.tax_rate_id(+) = nvl(tax.vat_tax_id,-1) and
 zx_exmp.tax_exemption_id(+) = nvl(tax.tax_exemption_id,-1) and
 dist.latest_rec_flag = 'Y' and
 trx.complete_flag = 'Y' and
 taxdist.customer_trx_line_id(+) = tax.customer_trx_line_id and
 nvl(zx_exmp.exemption_status_code,'X') = decode(:p_exemption_status, null, nvl(zx_exmp.exemption_status_code,'X'), :p_exemption_status) and
 nvl(taxdist.code_combination_id,-1) = gltax.code_combination_id(+) and
 --
 &lp_trx_date_where1
 &lp_where_deposit_clause
 &lp_dist_gl_date
 &lp_state_where_low
 &lp_state_where_high
 &lp_inv_number
 &lp_trx_curr_low
 &lp_trx_curr_high
 &lp_gltax_where_low
 &lp_gltax_where_high
 &lp_gl_posted_status_dist
 &lp_where_org_trx
 1=1
union
-- Q2
select
 trx.invoice_currency_code c_currency,
 cy.precision c_precision,
 cy.minimum_accountable_unit c_minimum_accountable_unit,
 upper(loc.state) c_state,
 decode(:p_detail_level, 'Detail State', 'X', loc.county) c_county,
 decode(:p_detail_level, 'Detail State', 'X', loc.city) c_city,
 loc.postal_code c_ship_to_zip,
 decode(lower(:p_order_by), 'invoice date', trx.trx_date, null) c_order_by_1,
 rtrim(rpad(decode(lower(:p_order_by), 'invoice number', trx.trx_number, 'transaction type', decode( types.type, 'INV', '1', 'DM', '1', '2'), /* order credit memos 2nd */
 'customer number', cust_acct.account_number, 'customer name', party.party_name, null),30)) c_order_by_2,
 trx.trx_date c_order_by_3,
 /* these decodes can be removed when the report is changed to show trx_number and related trx number */
 /* in the meantime, the credit memo(applied or unapplied) is always shown as an adjustment */
 /* and the adjusted invoice is always shown under the inv_number field */
 decode( types.type, 'CM', nvl(zx_tax_str_pkg.get_credit_memo_trx_number(trx.previous_customer_trx_id), :p_onacct_lookup || ': ' || trx.trx_number), trx.trx_number) c_inv_number,
 decode(types.type,'INV','INVOICE','CM','CREDIT_MEMO','DM','DEBIT_MEMO') c_inv_type,
 types.type c_inv_type_code,
 decode( types.type, 'INV', 10, 'DM', 15, 'CM', 20, 30) c_inv_type_code_order,
 decode( types.type, 'CM', trx.trx_number, zx_tax_str_pkg.get_credit_memo_trx_number(trx.previous_customer_trx_id)) c_adj_number,
 to_number(null) c_adj_line_amount,
 to_number(null) c_adj_tax_amount,
 to_number(null) c_adj_freight_amount,
 null c_adj_type,
 /* the invoice date show for a credit memo, is the date of the invoice */
 /* unless the credit memo is on account. this is a bug, however for    */
 /* the purpose of bugfix on performance ( hilti 316742 ) this bug      */
 /* is kept to maintain backwards compatibility during testing.         */
 decode( types.type, 'CM', nvl(zx_tax_str_pkg.get_credit_memo_trx_date(trx.previous_customer_trx_id), trx.trx_date), trx.trx_date) c_inv_date,
 substrb(party.party_name,1,50) c_cust_name,
 cust_acct.account_number c_cust_number,
 su.location c_location,
 nvl(su.tax_code, cust_acct.tax_code) c_cust_tax_code,
 decode( types.type, 'INV', 'INVOICE', 'DM', 'INVOICE', 'CREDIT MEMO') c_type_flag,
 decode( types.type, 'CM', nvl(trx.previous_customer_trx_id,-1*trx.customer_trx_id), trx.customer_trx_id) c_inv_cust_trx_id,
 trx.customer_trx_id c_cust_trx_id,
 trx.batch_source_id c_batch_source_id,
 -1 c_adjustment_id,
 line.customer_trx_line_id c_trx_line_id,
 line.line_number c_line_number,
 line.description c_description,
 line.extended_amount c_line_amount,
 tax.line_number c_tax_line_number,
 tax.customer_trx_line_id c_tax_cust_trx_line_id,
 tax.tax_rate c_tax_rate,
 zx_rate.tax_rate_code c_vat_code,
 tax.tax_vendor_return_code c_tax_vendor_return_code,
 zx_tax.tax_type_code c_vat_code_type,
 zx_tax.tax c_tax,
 nvl(zx_exmp.exempt_certificate_number, tax.tax_exempt_number) c_exempt_number,
 nvl(zx_exmp.exempt_reason_code, tax.tax_exempt_reason_code) c_exempt_reason,
 zx_exmp.rate_modifier c_exempt_percent,
 nvl(tax.extended_amount,0) c_tax_amount,
 tax.item_exception_rate_id c_tax_except_rate_id,
 loc_assign.loc_id c_tax_authority_id,
 loc.postal_code c_tax_authority_zip_code,
 null c_adjusted_doc_date,
 tax.sales_tax_id c_sales_tax_id,
 case when
 :p_min_gl_flex is not null and
 :p_max_gl_flex is not null and
 gltax.concatenated_segments is not null and
 not(gltax.concatenated_segments between :p_min_gl_flex and :p_max_gl_flex)
 then 'N'
 else 'Y'
 end c_gltax_inrange_flag,
 'Y' c_historical_flag,
 tax.global_attribute_category c_global_attribute_category,
 tax.global_attribute1 c_vendor_location_qualifier,
 tax.global_attribute2 c_vendor_state_amt,
 tax.global_attribute3 c_vendor_state_rate,
 tax.global_attribute4 c_vendor_county_amt,
 tax.global_attribute5 c_vendor_county_rate,
 tax.global_attribute6 c_vendor_city_amt,
 tax.global_attribute7 c_vendor_city_rate,
 tax.global_attribute12 c_vendor_taxable_amts,
 tax.global_attribute13 c_vendor_non_taxable_amts,
 tax.global_attribute14 c_vendor_exempt_amts
from
 ra_customer_trx_all trx,
 zx_lines_det_factors zx_det,
 ra_cust_trx_line_gl_dist_all dist,
 ra_cust_trx_types_all types,
 hz_cust_site_uses_all su,
 hz_cust_acct_sites_all acct_site,
 hz_party_sites party_site,
 hz_locations loc,
 hz_loc_assignments_obs loc_assign,
 fnd_currencies cy,
 hz_cust_accounts cust_acct,
 hz_parties party,
 zx_rates_vl zx_rate,
 &lp_table_parent_deposit_type
 zx_exemptions zx_exmp,
 ra_customer_trx_lines_all line,
 ra_customer_trx_lines_all tax,
 ra_cust_trx_line_gl_dist_all taxdist,
 gl_code_combinations_kfv gltax,
 zx_taxes_b zx_tax -- new tabel zx_tax added
where
 nvl( trx.ship_to_site_use_id,trx.bill_to_site_use_id)= su.site_use_id and
 zx_det.trx_line_id = line.customer_trx_line_id and
 zx_det.internal_organization_id = line.org_id and
 zx_det.trx_id = trx.customer_trx_id and
 zx_det.trx_id = line.customer_trx_id and
 zx_det.application_id = 222 and
 zx_det.entity_code = 'TRANSACTIONS' and
----join conditions between zx_rate and zx_tax starts --------------
 zx_tax.content_owner_id = zx_rate.content_owner_id and
 zx_tax.tax_regime_code = zx_rate.tax_regime_code and
 zx_tax.tax = zx_rate.tax and
----join conditions between zx_rate and zx_tax end --------------
 su.cust_acct_site_id = acct_site.cust_acct_site_id and
 acct_site.party_site_id = party_site.party_site_id and
 loc.location_id = party_site.location_id and
 loc.location_id = loc_assign.location_id and
 nvl(acct_site.org_id,-99) = nvl(loc_assign.org_id,-99) and
 loc.country = 'US' and
 trx.cust_trx_type_id = types.cust_trx_type_id and
 nvl(trx.org_id,-99) = nvl(types.org_id,-99) and
 types.type in ( 'CM', 'INV', 'DM' ) and
 cy.currency_code = trx.invoice_currency_code and
 cust_acct.cust_account_id = zx_det.bill_third_pty_acct_id and
 party.party_id = cust_acct.party_id and
 dist.customer_trx_id = trx.customer_trx_id and
 dist.account_class = 'REC' and
 trx.customer_trx_id = line.customer_trx_id and
 line.customer_trx_line_id = tax.link_to_cust_trx_line_id(+) and
 nvl(line.historical_flag,'Y') = 'Y' and
 line.line_type = 'LINE' and
 tax.line_type(+) = 'TAX' and
 zx_rate.tax_rate_id(+) = nvl(tax.vat_tax_id,-1) and
 zx_exmp.tax_exemption_id(+) = nvl(tax.tax_exemption_id,-1) and
 dist.latest_rec_flag = 'Y' and
 trx.complete_flag = 'Y' and
 taxdist.customer_trx_line_id(+) = tax.customer_trx_line_id and
 nvl(zx_exmp.exemption_status_code,'X') = decode(:p_exemption_status, null, nvl(zx_exmp.exemption_status_code,'X'), :p_exemption_status) and
 nvl(taxdist.code_combination_id,-1) = gltax.code_combination_id(+) and
 --
 &lp_trx_date_where1
 &lp_where_deposit_clause
 &lp_dist_gl_date
 &lp_state_where_low
 &lp_state_where_high
 &lp_inv_number
 &lp_trx_curr_low
 &lp_trx_curr_high
 &lp_gltax_where_low
 &lp_gltax_where_high
 &lp_gl_posted_status_dist
 &lp_where_org_trx
 2=2
union
-- Q3
select
 trx.invoice_currency_code c_currency,
 cy.precision c_precision,
 cy.minimum_accountable_unit c_minimum_accountable_unit,
 upper(loc.state) c_state,
 decode(:p_detail_level, 'Detail State', 'X', loc.county) c_county,
 decode(:p_detail_level, 'Detail State', 'X', loc.city) c_city,
 loc.postal_code c_ship_to_zip,
 decode(lower(:p_order_by), 'invoice date', adj.apply_date, null) c_order_by_1,
 rtrim(rpad(decode(lower(:p_order_by), 'invoice number', trx.trx_number, 'transaction type', '3', /* order adjustments 3rd */
 'customer number', cust_acct.account_number, 'customer name', party.party_name, null),30)) c_order_by_2,
 adj.apply_date c_order_by_3,
 trx.trx_number c_inv_number,
 :p_adjustment_display c_inv_type,
 'ADJ' c_inv_type_code,
 30 c_inv_type_code_order,
 adj.adjustment_number c_adj_number,
 adj.line_adjusted c_adj_line_amount,
 adj.tax_adjusted c_adj_tax_amount,
 adj.freight_adjusted c_adj_freight_amount,
 adj.type c_adj_type,
 adj.apply_date c_inv_date,
 substrb(party.party_name,1,50) c_cust_name,
 cust_acct.account_number c_cust_number,
 su.location c_location,
 nvl(su.tax_code, cust_acct.tax_code) c_cust_tax_code,
 'ADJUSTMENT' c_type_flag,
 trx.customer_trx_id c_inv_cust_trx_id,
 trx.customer_trx_id c_cust_trx_id,
 trx.batch_source_id c_batch_source_id,
 adj.adjustment_id c_adjustment_id,
 line.customer_trx_line_id c_trx_line_id,
 line.line_number c_line_number,
 line.description c_description,
 line.extended_amount c_line_amount,
 tax.line_number c_tax_line_number,
 tax.customer_trx_line_id c_tax_cust_trx_line_id,
 tax.tax_rate c_tax_rate,
 zx_rate.tax_rate_code c_vat_code,
 tax.tax_vendor_return_code c_tax_vendor_return_code,
 zx_tax.tax_type_code c_vat_code_type,
 zx_tax.tax c_tax,
 nvl(zx_exmp.exempt_certificate_number, tax.tax_exempt_number) c_exempt_number,
 nvl(zx_exmp.exempt_reason_code, tax.tax_exempt_reason_code) c_exempt_reason,
 zx_exmp.rate_modifier c_exempt_percent,
 nvl(tax.extended_amount,0) c_tax_amount,
 tax.item_exception_rate_id c_tax_except_rate_id,
 loc_assign.loc_id c_tax_authority_id,
 loc.postal_code c_tax_authority_zip_code,
 null c_adjusted_doc_date,
 tax.sales_tax_id c_sales_tax_id,
 'Y' c_gltax_inrange_flag,
 'Y' c_historical_flag,
 tax.global_attribute_category c_global_attribute_category,
 tax.global_attribute1 c_vendor_location_qualifier,
 tax.global_attribute2 c_vendor_state_amt,
 tax.global_attribute3 c_vendor_state_rate,
 tax.global_attribute4 c_vendor_county_amt,
 tax.global_attribute5 c_vendor_county_rate,
 tax.global_attribute6 c_vendor_city_amt,
 tax.global_attribute7 c_vendor_city_rate,
 tax.global_attribute12 c_vendor_taxable_amts,
 tax.global_attribute13 c_vendor_non_taxable_amts,
 tax.global_attribute14 c_vendor_exempt_amts
from
 ar_adjustments_all adj,
 ra_customer_trx_all trx,
 zx_lines_det_factors zx_det,
 hz_cust_site_uses_all su,
 hz_cust_acct_sites_all acct_site,
 hz_party_sites party_site,
 hz_locations loc,
 hz_cust_accounts cust_acct,
 hz_parties party,
 zx_rates_vl zx_rate,
 zx_exemptions zx_exmp,
 zx_taxes_b zx_tax, -- new tabel zx_tax added
 fnd_currencies cy,
 &lp_table_parent_deposit_type
 ra_customer_trx_lines_all line,
 ra_customer_trx_lines_all tax,
 hz_loc_assignments_obs loc_assign
where
 trx.customer_trx_id = adj.customer_trx_id and
 nvl(trx.org_id,-99) = nvl(adj.org_id,-99) and
 nvl(zx_det.ship_to_cust_acct_site_use_id, zx_det.bill_to_cust_acct_site_use_id) = su.site_use_id and
 zx_det.trx_line_id = line.customer_trx_line_id and
 zx_det.internal_organization_id = line.org_id and
 zx_det.trx_id = line.customer_trx_id and
 zx_det.trx_id = trx.customer_trx_id and
 zx_det.application_id = 222 and
 zx_det.entity_code = 'TRANSACTIONS' and
----join conditions between zx_rate and zx_tax starts --------------
 zx_tax.content_owner_id = zx_rate.content_owner_id and
 zx_tax.tax_regime_code = zx_rate.tax_regime_code and
 zx_tax.tax = zx_rate.tax and
----join conditions between zx_rate and zx_tax end --------------
 loc.country = 'US' and
 su.cust_acct_site_id = acct_site.cust_acct_site_id and
 acct_site.party_site_id = party_site.party_site_id and
 loc.location_id = party_site.location_id and
 loc.location_id = loc_assign.location_id and
 nvl(acct_site.org_id,-99) = nvl(loc_assign.org_id, -99) and
 cust_acct.cust_account_id = zx_det.bill_third_pty_acct_id and
 cust_acct.party_id = party.party_id and
 trx.customer_trx_id = line.customer_trx_id and
 line.customer_trx_line_id = tax.link_to_cust_trx_line_id(+) and
 cy.currency_code = trx.invoice_currency_code and
 line.historical_flag is null and
 line.line_type = 'LINE' and
 tax.line_type(+) = 'TAX' and
 zx_rate.tax_rate_id(+) = nvl(tax.vat_tax_id,-1) and
 zx_exmp.tax_exemption_id(+) = nvl(tax.tax_exemption_id,-1) and
 nvl(zx_exmp.exemption_status_code,'X') = decode(:p_exemption_status, null, nvl(zx_exmp.exemption_status_code,'X'), :p_exemption_status) and
 adj.chargeback_customer_trx_id is null and
 adj.approved_by is not null and
 --
 &lp_where_deposit_clause
 &lp_adj_trx_date_where
 &lp_adj_gl_date
 &lp_state_where_low
 &lp_state_where_high
 &lp_inv_number
 &lp_trx_curr_low
 &lp_trx_curr_high
 &lp_where_gl_acct_adj
 &lp_gl_posted_status_adj
 &lp_where_org_adj
 3=3
union
-- Q4
select
 trx.trx_currency_code c_currency,
 trx.precision c_precision,
 trx.minimum_accountable_unit c_minimum_accountable_unit,
 upper(loc.state) c_state,
 decode(:p_detail_level, 'Detail State', 'X', loc.county) c_county,
 decode(:p_detail_level, 'Detail State', 'X', loc.city) c_city,
 loc.postal_code c_ship_to_zip,
 decode(lower(:p_order_by), 'invoice date', lines.trx_date, null) c_order_by_1,
 rtrim(rpad(decode(lower(:p_order_by), 'invoice number', lines.trx_number, 'transaction type', decode( lines.event_class_code, 'INVOICE', '1', 'DEBIT MEMO', '1', '2'), /* order credit memos 2nd */
 'customer number', cust_acct.account_number, 'customer name', party.party_name, null),30)) c_order_by_2,
 lines.trx_date c_order_by_3,
 trx.trx_number c_inv_number,
 lines.event_class_code c_inv_type,
 lines.event_class_code c_inv_type_code,
 decode( lines.event_class_code, 'INVOICE', 10, 'DEBIT MEMO', 15, 'CREDIT MEMO', 20, 30) c_inv_type_code_order,
 trx.adjusted_doc_number c_adj_number,
 to_number(null) c_adj_line_amount,
 to_number(null) c_adj_tax_amount,
 to_number(null) c_adj_freight_amount,
 null c_adj_type,
 trx.trx_date c_inv_date,
 substrb(party.party_name,1,50) c_cust_name,
 cust_acct.account_number c_cust_number,
 su.location c_location,
 nvl(su.tax_code, cust_acct.tax_code) c_cust_tax_code,
 decode (trx.line_class, 'INVOICE', 'INVOICE', 'DEBIT_MEMO', 'INVOICE', 'CREDIT MEMO') c_type_flag,
 trx.trx_id c_inv_cust_trx_id,
 trx.trx_id c_cust_trx_id,
 trx.batch_source_id c_batch_source_id,
 -1 c_adjustment_id,
 trx.trx_line_id c_trx_line_id,
 lines.trx_line_number c_line_number,
 trx.trx_line_description c_description,
 lines.line_amt c_line_amount,
 lines.tax_line_number c_tax_line_number,
 lines.tax_line_id c_tax_cust_trx_line_id,
 lines.tax_rate c_tax_rate,
 lines.tax_rate_code c_vat_code,
 to_char(null) c_tax_vendor_return_code,
 lines.tax_type_code c_vat_code_type,
 lines.tax c_tax,
 lines.exempt_certificate_number c_exempt_number,
 nvl(lines.exempt_reason_code, zx_exmp.exempt_reason_code) c_exempt_reason,
 decode(lines.exempt_rate_modifier,null,to_number(null),lines.exempt_rate_modifier*100) c_exempt_percent,
 lines.tax_amt c_tax_amount,
 lines.tax_exception_id c_tax_except_rate_id,
 decode (line_class,'CREDIT_MEMO', nvl2(lines.tax_jurisdiction_id, lines.tax_jurisdiction_id,
 (select
   loc_assign.loc_id
  from
   hz_loc_assignments_obs loc_assign
  where
   loc_assign.location_id = loc.location_id and
   loc_assign.org_id = trx.internal_organization_id
  )
 ),lines.tax_jurisdiction_id
 ) c_tax_authority_id,
 loc.postal_code c_tax_authority_zip_code,
 decode(line_class,'CREDIT_MEMO',lines.adjusted_doc_date,null) c_adjusted_doc_date,
 decode (line_class,'CREDIT_MEMO', nvl2(lines.tax_jurisdiction_id, null,-1),null) c_sales_tax_id,
 null c_gltax_inrange_flag,
 'N' c_historical_flag,
 lines.global_attribute_category c_global_attribute_category,
 lines.global_attribute1 c_vendor_location_qualifier,
 lines.global_attribute2 c_vendor_state_amt,
 lines.global_attribute3 c_vendor_state_rate,
 lines.global_attribute4 c_vendor_county_amt,
 lines.global_attribute5 c_vendor_county_rate,
 lines.global_attribute6 c_vendor_city_amt,
 lines.global_attribute7 c_vendor_city_rate,
 lines.global_attribute12 c_vendor_taxable_amts,
 lines.global_attribute13 c_vendor_non_taxable_amts,
 lines.global_attribute14 c_vendor_exempt_amts
from
 zx_lines_det_factors trx,
 zx_lines lines,
 zx_exemptions zx_exmp,
 hz_cust_site_uses_all su,
 hz_cust_acct_sites_all acct_site,
 hz_party_sites party_site,
 hz_locations loc,
 hz_cust_accounts cust_acct,
 hz_parties party,
 ra_cust_trx_line_gl_dist_all dist
where
 lines.internal_organization_id = trx.internal_organization_id and
 trx.application_id = lines.application_id and
 trx.application_id = 222 and
 trx.entity_code = lines.entity_code and
 trx.event_class_code = lines.event_class_code and
 trx.trx_id = lines.trx_id and
 trx.trx_line_id = lines.trx_line_id and
 trx.tax_reporting_flag = 'Y' and
 trx.tax_event_type_code in ('VALIDATE_FOR_TAX', 'FREEZE_FOR_TAX') and
 lines.historical_flag <> 'Y' and
 nvl(trx. ship_to_cust_acct_site_use_id, trx. bill_to_cust_acct_site_use_id) = su.site_use_id and
 su.cust_acct_site_id = acct_site.cust_acct_site_id and
 acct_site.party_site_id = party_site.party_site_id and
 loc.location_id = party_site.location_id and
 loc.country = 'US' and
 cust_acct.cust_account_id = trx.bill_third_pty_acct_id and
 party.party_id = cust_acct.party_id and
 trx.line_class in ( 'CREDIT_MEMO', 'INVOICE', 'DEBIT_MEMO' ) and
 dist.customer_trx_id = lines.trx_id and
 zx_exmp.tax_exemption_id(+) = nvl(lines.tax_exemption_id,-1) and
 dist.org_id = trx.internal_organization_id and
 dist.account_class = 'REC' and
 dist.latest_rec_flag = 'Y' and
 --
 &lp_trx_date_where2
 &lp_dist_gl_date
 &lp_state_where_low
 &lp_state_where_high
 &lp_inv_number
 &lp_line_curr_low
 &lp_line_curr_high
 &lp_where_gl_acct_inv
 &lp_gl_posted_status_dist
 &lp_where_org_trx_zx
 4=4
union
-- Q5
select
 trx.trx_currency_code c_currency,
 trx.precision c_precision,
 trx.minimum_accountable_unit c_minimum_accountable_unit,
 upper(loc.state) c_state,
 decode(:p_detail_level, 'Detail State', 'X', loc.county) c_county,
 decode(:p_detail_level, 'Detail State', 'X', loc.city) c_city,
 loc.postal_code c_ship_to_zip,
 decode(lower(:p_order_by), 'invoice date', adj.apply_date, null) c_order_by_1,
 rtrim(rpad(decode(lower(:p_order_by), 'invoice number', lines.trx_number, 'transaction type', '3', /* order adjustments 3rd */
 'customer number', cust_acct.account_number, 'customer name', party.party_name, null),30)) c_order_by_2,
 adj.apply_date c_order_by_3,
 trx.trx_number c_inv_number,
 lines.event_class_code c_inv_type,
 'ADJ' c_inv_type_code,
 30 c_inv_type_code_order,
 adj.adjustment_number c_adj_number,
 adj.line_adjusted c_adj_line_amount,
 adj.tax_adjusted c_adj_tax_amount,
 adj.freight_adjusted c_adj_freight_amount,
 adj.type c_adj_type,
 adj.apply_date c_inv_date,
 substrb(party.party_name,1,50) c_cust_name,
 cust_acct.account_number c_cust_number,
 su.location c_location,
 nvl(su.tax_code, cust_acct.tax_code) c_cust_tax_code,
 'ADJUSTMENT' c_type_flag,
 trx.trx_id c_inv_cust_trx_id,
 trx.trx_id c_cust_trx_id,
 trx.batch_source_id c_batch_source_id,
 adj.adjustment_id c_adjustment_id,
 trx.trx_line_id c_trx_line_id,
 lines.trx_line_number c_line_number,
 trx.trx_line_description c_description,
 lines.line_amt c_line_amount,
 lines.tax_line_number c_tax_line_number,
 lines.tax_line_id c_tax_cust_trx_line_id,
 lines.tax_rate c_tax_rate,
 lines.tax_rate_code c_vat_code,
 to_char(null) c_tax_vendor_return_code,
 lines.tax_type_code c_vat_code_type,
 lines.tax c_tax,
 lines.exempt_certificate_number c_exempt_number,
 nvl(lines.exempt_reason_code, zx_exmp.exempt_reason_code) c_exempt_reason,
 decode(lines.exempt_rate_modifier,null,to_number(null),lines.exempt_rate_modifier*100) c_exempt_percent,
 lines.tax_amt c_tax_amount,
 lines.tax_exception_id c_tax_except_rate_id,
 lines.tax_jurisdiction_id c_tax_authority_id,
 null c_tax_authority_zip_code,
 null c_adjusted_doc_date,
 null c_sales_tax_id,
 null c_gltax_inrange_flag,
 'N' c_historical_flag,
 lines.global_attribute_category c_global_attribute_category,
 lines.global_attribute1 c_vendor_location_qualifier,
 lines.global_attribute2 c_vendor_state_amt,
 lines.global_attribute3 c_vendor_state_rate,
 lines.global_attribute4 c_vendor_county_amt,
 lines.global_attribute5 c_vendor_county_rate,
 lines.global_attribute6 c_vendor_city_amt,
 lines.global_attribute7 c_vendor_city_rate,
 lines.global_attribute12 c_vendor_taxable_amts,
 lines.global_attribute13 c_vendor_non_taxable_amts,
 lines.global_attribute14 c_vendor_exempt_amts
from
 zx_lines_det_factors trx,
 zx_lines lines,
 zx_exemptions zx_exmp,
 hz_cust_site_uses_all su,
 hz_cust_acct_sites_all acct_site,
 hz_party_sites party_site,
 hz_locations loc,
 hz_cust_accounts cust_acct,
 hz_parties party,
 ar_adjustments_all adj
where
 lines.internal_organization_id = trx.internal_organization_id and
 trx.application_id = lines.application_id and
 trx.application_id = 222 and
 trx.entity_code = lines.entity_code and
 trx.event_class_code = lines.event_class_code and
 trx.trx_id = lines.trx_id and
 trx.trx_line_id = lines.trx_line_id and
 trx.tax_reporting_flag = 'Y' and
 lines.historical_flag <> 'Y' and
 nvl(trx. ship_to_cust_acct_site_use_id, trx. bill_to_cust_acct_site_use_id) = su.site_use_id and
 su.cust_acct_site_id = acct_site.cust_acct_site_id and
 acct_site.party_site_id = party_site.party_site_id and
 loc.location_id = party_site.location_id and
 loc.country = 'US' and
 cust_acct.cust_account_id = trx.bill_third_pty_acct_id and
 party.party_id = cust_acct.party_id and
 adj.customer_trx_id = lines.trx_id and
 nvl(adj.org_id,-99) = nvl(lines.internal_organization_id,-99) and
 adj.type in ('TAX', 'LINE','INVOICE') and
 zx_exmp.tax_exemption_id(+) = nvl(lines.tax_exemption_id,-1) and
 adj.chargeback_customer_trx_id is null and
 adj.approved_by is not null and
 --
 &lp_adj_trx_date_where
 &lp_adj_gl_date
 &lp_state_where_low
 &lp_state_where_high
 &lp_inv_number
 &lp_line_curr_low
 &lp_line_curr_high
 &lp_where_gl_acct_adj
 &lp_gl_posted_status_adj
 &lp_where_org_adj
 5=5
union /* this query reports transaction with no tax lines  in zx lines */
-- Q6
select
  trx.trx_currency_code c_currency,
 trx.precision c_precision,
 trx.minimum_accountable_unit c_minimum_accountable_unit,
 upper(loc.state) c_state,
 decode(:p_detail_level, 'Detail State', 'X', loc.county) c_county,
 decode(:p_detail_level, 'Detail State', 'X', loc.city) c_city,
 loc.postal_code c_ship_to_zip,
 decode(lower(:p_order_by), 'invoice date', trx.trx_date, null) c_order_by_1,
 rtrim(rpad(decode(lower(:p_order_by), 'invoice number', trx.trx_number, 'transaction type', decode( trx.event_class_code, 'INVOICE', '1', 'DEBIT MEMO', '1', '2'), /* order credit memos 2nd */
 'customer number', cust_acct.account_number, 'customer name', party.party_name, null),30)) c_order_by_2,
 trx.trx_date c_order_by_3,
 trx.trx_number c_inv_number,
 trx.event_class_code c_inv_type,
 trx.event_class_code c_inv_type_code,
 decode( trx.event_class_code, 'INVOICE', 10, 'DEBIT MEMO', 15, 'CREDIT MEMO', 20, 30) c_inv_type_code_order,
 trx.adjusted_doc_number c_adj_number,
 to_number(null) c_adj_line_amount,
 to_number(null) c_adj_tax_amount,
 to_number(null) c_adj_freight_amount,
 null c_adj_type,
 trx.trx_date c_inv_date,
 substrb(party.party_name,1,50) c_cust_name,
 cust_acct.account_number c_cust_number,
 su.location c_location,
 nvl(su.tax_code, cust_acct.tax_code) c_cust_tax_code,
 decode (trx.line_class, 'INVOICE', 'INVOICE', 'DEBIT_MEMO', 'INVOICE', 'CREDIT MEMO') c_type_flag,
 trx.trx_id c_inv_cust_trx_id,
 trx.trx_id c_cust_trx_id,
 trx.batch_source_id c_batch_source_id,
 -1 c_adjustment_id,
 trx.trx_line_id c_trx_line_id,
 trx.trx_line_number c_line_number,
 trx.trx_line_description c_description,
 trx.line_amt c_line_amount,
 null c_tax_line_number,
 null c_tax_cust_trx_line_id,
 null c_tax_rate,
 null c_vat_code,
 to_char(null) c_tax_vendor_return_code,
 null c_vat_code_type,
 null c_tax,
 null c_exempt_number,
 null c_exempt_reason,
 null c_exempt_percent,
 null c_tax_amount,
 null c_tax_except_rate_id,
 null c_tax_authority_id,
 null c_tax_authority_zip_code,
 null c_adjusted_doc_date,
 null c_sales_tax_id,
 null c_gltax_inrange_flag,
 'N' c_historical_flag,
 null c_global_attribute_category,
 null c_vendor_location_qualifier,
 null c_vendor_state_amt,
 null c_vendor_state_rate,
 null c_vendor_county_amt,
 null c_vendor_county_rate,
 null c_vendor_city_amt,
 null c_vendor_city_rate,
 null c_vendor_taxable_amts,
 null c_vendor_non_taxable_amts,
 null c_vendor_exempt_amts
from
 zx_lines_det_factors trx,
 hz_cust_site_uses_all su,
 hz_cust_acct_sites_all acct_site,
 hz_party_sites party_site,
 hz_locations loc,
 hz_cust_accounts cust_acct,
 hz_parties party,
 ra_cust_trx_line_gl_dist_all dist
where
 trx.application_id = 222 and
 trx.tax_reporting_flag = 'Y' and
 trx.tax_event_type_code in ('VALIDATE_FOR_TAX', 'FREEZE_FOR_TAX') and
 nvl(trx. ship_to_cust_acct_site_use_id, trx. bill_to_cust_acct_site_use_id) = su.site_use_id and
 su.cust_acct_site_id = acct_site.cust_acct_site_id and
 acct_site.party_site_id = party_site.party_site_id and
 loc.location_id = party_site.location_id and
 loc.country = 'US' and
 cust_acct.cust_account_id = trx.bill_third_pty_acct_id and
 party.party_id = cust_acct.party_id and
 trx.line_class in ( 'CREDIT_MEMO', 'INVOICE', 'DEBIT_MEMO' ) and
 trx.trx_id = dist.customer_trx_id and
 dist.org_id = trx.internal_organization_id and
 dist.account_class = 'REC' and
 dist.latest_rec_flag = 'Y' and
 not exists
  (select
    1
   from
    zx_lines lines
   where
    lines.internal_organization_id = trx.internal_organization_id and
    trx.application_id = lines.application_id and
    trx.entity_code = lines.entity_code and
    trx.event_class_code = lines.event_class_code and
    trx.trx_id = lines.trx_id and
    trx.trx_line_id = lines.trx_line_id
  ) and
 --
 &lp_trx_date_where2
 &lp_dist_gl_date
 &lp_state_where_low
 &lp_state_where_high
 &lp_inv_number
 &lp_zx_curr_low
 &lp_zx_curr_high
 &lp_where_gl_acct_inv
 &lp_gl_posted_status_dist
 &lp_show_trx_wo_tax
 &lp_where_org_trx_zx
 6=6
union
-- Q7
select
 trx.trx_currency_code c_currency,
 trx.precision c_precision,
 trx.minimum_accountable_unit c_minimum_accountable_unit,
 upper(loc.state) c_state,
 decode(:p_detail_level, 'Detail State', 'X', loc.county) c_county,
 decode(:p_detail_level, 'Detail State', 'X', loc.city) c_city,
 loc.