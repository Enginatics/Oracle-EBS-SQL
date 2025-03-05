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
 trx.org_id c_org_id,
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
 acct_site.org_id = loc_assign.org_id and
 loc.country = 'US' and
 trx.cust_trx_type_id = types.cust_trx_type_id and
 trx.org_id = types.org_id and
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
 trx.org_id c_org_id,
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
 acct_site.org_id = loc_assign.org_id and
 loc.country = 'US' and
 trx.cust_trx_type_id = types.cust_trx_type_id and
 trx.org_id = types.org_id and
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
 adj.org_id c_org_id,
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
 trx.org_id = adj.org_id and
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
 acct_site.org_id = loc_assign.org_id and
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
 trx.internal_organization_id c_org_id,
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
 trx.internal_organization_id c_org_id,
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
 adj.org_id = lines.internal_organization_id and
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
 trx.internal_organization_id c_org_id,
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
 trx.internal_organization_id c_org_id,
 trx.trx_currency_code c_currency,
 trx.precision c_precision,
 trx.minimum_accountable_unit c_minimum_accountable_unit,
 upper(loc.state) c_state,
 decode(:p_detail_level, 'Detail State', 'X', loc.county) c_county,
 decode(:p_detail_level, 'Detail State', 'X', loc.city) c_city,
 loc.postal_code c_ship_to_zip,
 decode(lower(:p_order_by), 'invoice date', adj.apply_date, null) c_order_by_1,
 rtrim(rpad(decode(lower(:p_order_by), 'invoice number', trx.trx_number, 'transaction type', '3', /* order adjustments 3rd */
 'customer number', cust_acct.account_number, 'customer name', party.party_name, null),30)) c_order_by_2,
 adj.apply_date c_order_by_3,
 trx.trx_number c_inv_number,
 trx.event_class_code c_inv_type,
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
 trx.trx_line_number c_line_number,
 trx.trx_line_description c_description,
 null c_line_amount,
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
 ar_adjustments_all adj
where
 trx.application_id = 222 and
 trx.tax_reporting_flag = 'Y' and
 nvl(trx. ship_to_cust_acct_site_use_id, trx. bill_to_cust_acct_site_use_id) = su.site_use_id and
 su.cust_acct_site_id = acct_site.cust_acct_site_id and
 acct_site.party_site_id = party_site.party_site_id and
 loc.location_id = party_site.location_id and
 loc.country = 'US' and
 cust_acct.cust_account_id = trx.bill_third_pty_acct_id and
 party.party_id = cust_acct.party_id and
 adj.customer_trx_id = trx.trx_id and
 adj.org_id = trx.internal_organization_id and
 adj.type = 'TAX' and
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
 adj.chargeback_customer_trx_id is null and
 adj.approved_by is not null and
 --
 &lp_adj_trx_date_where
 &lp_adj_gl_date
 &lp_state_where_low
 &lp_state_where_high
 &lp_inv_number
 &lp_zx_curr_low
 &lp_zx_curr_high
 &lp_where_gl_acct_adj
 &lp_gl_posted_status_adj
 &lp_show_trx_wo_tax
 &lp_where_org_trx_zx
 7=7
)
/*
--
-- ## Main Query starts here ##
--
*/
select
t3.c_currency currency,
t3.c_state state,
t3.c_county county,
t3.c_city city,
-- G_INVOICE
t3.c_inv_number invoice_number,
xxen_util.meaning(t3.c_inv_type,'ZX_TRL_TAXABLE_TRX_TYPE',0) invoice_type,
-- G_TRANSACTIONS
t3.c_adj_number adjustment_number,
t3.c_inv_date inv_or_adj_date,
t3.c_cust_name customer_name,
t3.c_cust_number customer_number,
t3.operating_unit,
xxen_util.meaning(t3.c_inv_exempt_reason,'ZX_EXEMPTION_REASON_CODE',0) invoice_exempt_reason,
case when t3.trx_rownum = 1
then t3.c_sum_item_line_amt
else null
end invoice_lines_amount,
case when t3.trx_rownum = 1
then t3.c_sum_tax_line_amt
else null
end invoice_tax_amount,
t3.c_footnote footnote,
-- G_ITEM_LINES
t3.c_line_number line_number,
t3.c_description line_description,
case when t3.line_rownum = 1
then t3.c_line_amount_calc
else null
end line_amount,
-- G_TAX_LINES
t3.c_tax_line_number tax_line_number,
t3.c_tax_rate tax_rate,
t3.c_vat_code tax_code,
t3.c_exempt_number exempt_number,
xxen_util.meaning(t3.c_exempt_reason,'ZX_EXEMPTION_REASON_CODE',0) exempt_reason,
t3.c_tax_amount_calc tax_line_amount,
--
-- Invoice Line Invoice Only Amounts
case when t3.line_rownum = 1
then case when t3.c_type_flag = 'INVOICE' then nvl(t3.c_line_amount_calc,0) else 0 end
else null
end invoice_trx_line_amount,
case when t3.line_rownum = 1
then case when t3.c_type_flag = 'INVOICE' then nvl(t3.c_inv_line_exempt_amt,0) else 0 end
else null
end invoice_trx_exempt_amount,
case when t3.line_rownum = 1
then case when t3.c_type_flag = 'INVOICE' then nvl(t3.c_line_amount_calc,0) - nvl(t3.c_inv_line_exempt_amt,0) else 0 end
else null
end invoice_trx_taxable_amount,
case when t3.line_rownum = 1
then case when t3.c_type_flag = 'INVOICE' then nvl(t3.c_inv_line_tax_amt,0) else 0 end
else null
end invoice_trx_tax_amount,
--
-- Invoice Line Credit Memo Only Amounts
case when t3.line_rownum = 1
then case when t3.c_type_flag = 'CREDIT MEMO' then nvl(t3.c_line_amount_calc,0) else 0 end
else null
end credit_trx_line_amount,
case when t3.line_rownum = 1
then case when t3.c_type_flag = 'CREDIT MEMO' then nvl(t3.c_inv_line_exempt_amt,0) else 0 end
else null
end credit_trx_exempt_amount,
case when t3.line_rownum = 1
then case when t3.c_type_flag = 'CREDIT MEMO' then nvl(t3.c_line_amount_calc,0) - nvl(t3.c_inv_line_exempt_amt,0) else 0 end
else null
end credit_trx_taxable_amount,
case when t3.line_rownum = 1
then case when t3.c_type_flag = 'CREDIT MEMO' then nvl(t3.c_inv_line_tax_amt,0) else 0 end
else null
end credit_trx_tax_amount,
--
-- Invoice Line Adjustment Only Amounts
case when t3.line_rownum = 1
then case when t3.c_type_flag = 'ADJUSTMENT' then nvl(t3.c_line_amount_calc,0) else 0 end
else null
end adjustment_line_amount,
case when t3.line_rownum = 1
then nvl(t3.c_inv_line_exempt_amt,0) - case when t3.c_type_flag in ('INVOICE','CREDIT MEMO') then nvl(t3.c_inv_line_exempt_amt,0) else 0 end
else null
end adjustment_exempt_amount,
case when t3.line_rownum = 1
then (case when t3.c_type_flag = 'ADJUSTMENT' then nvl(t3.c_line_amount_calc,0) else 0 end) -
     (nvl(t3.c_inv_line_exempt_amt,0) - case when t3.c_type_flag in ('INVOICE','CREDIT MEMO') then nvl(t3.c_inv_line_exempt_amt,0) else 0 end)
else null
end adjustment_taxable_amount,
case when t3.line_rownum = 1
then case when t3.c_type_flag = 'ADJUSTMENT' then nvl(t3.c_inv_line_tax_amt,0) else 0 end
else null
end adjustment_tax_amount,
--
-- Invoice Line Total Amounts
case when t3.line_rownum = 1
then nvl(t3.c_line_amount_calc,0)
else null
end net_line_amount,
case when t3.line_rownum = 1
then nvl(t3.c_inv_line_exempt_amt,0)
else null
end net_exempt_amount,
case when t3.line_rownum = 1
then nvl(t3.c_line_amount_calc,0) - nvl(t3.c_inv_line_exempt_amt,0)
else null
end net_taxable_amount,
case when t3.line_rownum = 1
then nvl(t3.c_inv_line_tax_amt,0)
else null
end net_tax_amount,
--
-- tax authority amounts
t3.c_city_tax_amt city_authority_tax_amount,
t3.c_county_tax_amt county_authority_tax_amount,
t3.c_state_tax_amt state_authority_tax_amount,
t3.c_other_tax_amt other_authority_tax_amount,
--
&lp_debug_columns
--
'.' last_col
from
(
select
t2.*,
-- Invoice Footnote
max(t2.c_trx_comment_flag) over (partition by t2.c_inv_cust_trx_id,t2.c_cust_trx_id,t2.c_adjustment_id) c_footnote,
-- Line Exempt Amount
case when t2.line_rownum = 1
then
  case
  when nvl(t2.c_cnt_tax_lines_for_inv_line,0) <= 1
  then
    sum(t2.c_exempt_amount) over (partition by t2.c_inv_cust_trx_id,t2.c_cust_trx_id,t2.c_adjustment_id,t2.c_trx_line_id)  -- c_inv_line_tot_exempt_amt
  when nvl(t2.c_cnt_tax_lines_for_inv_line,0) > 1
  and  nvl(sum(t2.c_exempt_flag) over (partition by t2.c_inv_cust_trx_id,t2.c_cust_trx_id,t2.c_adjustment_id,t2.c_trx_line_id),0) > 1 -- c_cnt_ext_tax_lines_for_inv_l
  then
    -- :c_inv_line_tot_exempt_amt / :c_cnt_ext_tax_lines_for_inv_l
    xxen_zx.aol_round
    (sum(t2.c_exempt_amount) over (partition by t2.c_inv_cust_trx_id,t2.c_cust_trx_id,t2.c_adjustment_id,t2.c_trx_line_id) /
     sum(t2.c_exempt_flag) over (partition by t2.c_inv_cust_trx_id,t2.c_cust_trx_id,t2.c_adjustment_id,t2.c_trx_line_id),
     t2.c_precision,t2.c_minimum_accountable_unit
    )
  else
    sum(t2.c_exempt_amount) over (partition by t2.c_inv_cust_trx_id,t2.c_cust_trx_id,t2.c_adjustment_id,t2.c_trx_line_id) -- :c_inv_line_tot_exempt_amt
  end
else
  null
end c_inv_line_exempt_amt,
case when t2.line_rownum = 1
then
  sum(t2.c_tax_amount_calc) over (partition by t2.c_inv_cust_trx_id,t2.c_cust_trx_id,t2.c_adjustment_id,t2.c_trx_line_id)
else
  null
end c_inv_line_tax_amt,
nvl(sum(t2.c_exempt_flag) over (partition by t2.c_inv_cust_trx_id,t2.c_cust_trx_id,t2.c_adjustment_id,t2.c_trx_line_id),0) c_cnt_ext_tax_lines_for_inv_l,
sum(t2.c_exempt_amount) over (partition by t2.c_inv_cust_trx_id,t2.c_cust_trx_id,t2.c_adjustment_id,t2.c_trx_line_id) c_inv_line_tot_exempt_amt
from
(
select
t1.*,
--
-- G_TRANSACTIONS_4 Columns
--
case when t1.trx_rownum = 1
then
  xxen_zx.c_sum_item_line_amount
   (p_cust_trx_id              => t1.c_cust_trx_id
   ,p_adj_id                   => t1.c_adjustment_id
   ,p_type_flag                => t1.c_type_flag
   ,p_adj_line_amount          => t1.c_adj_line_amount
   ,p_adj_tax_amount           => t1.c_adj_tax_amount
   ,p_precision                => t1.c_precision
   ,p_minimum_accountable_unit => t1.c_minimum_accountable_unit
  )
else
 null
end c_sum_item_line_amt,
--
case when t1.trx_rownum = 1
then
  xxen_zx.c_sum_tax_line_amount
   (p_cust_trx_id              => t1.c_cust_trx_id
   ,p_adj_id                   => t1.c_adjustment_id
   ,p_type_flag                => t1.c_type_flag
   ,p_adj_line_amount          => t1.c_adj_line_amount
   ,p_adj_tax_amount           => t1.c_adj_tax_amount
   ,p_precision                => t1.c_precision
   ,p_minimum_accountable_unit => t1.c_minimum_accountable_unit
  )
else null
end c_sum_tax_line_amt,
--
case when t1.trx_rownum = 1
then
  xxen_zx.c_trx_comment_flag
  (p_type_flag           => t1.c_type_flag
  ,p_adj_type            => t1.c_adj_type
  ,p_warn_gltax_range    => min(t1.c_gltax_inrange_flag) over (partition by t1.c_inv_cust_trx_id,t1.c_cust_trx_id,t1.c_adjustment_id)
  ,p_adj_line_amount     => t1.c_adj_line_amount
  ,p_adj_freight_amount  => t1.c_adj_freight_amount
  ,p_sum_tax_line_amount =>
     xxen_zx.c_sum_tax_line_amount
     (p_cust_trx_id              => t1.c_cust_trx_id
     ,p_adj_id                   => t1.c_adjustment_id
     ,p_type_flag                => t1.c_type_flag
     ,p_adj_line_amount          => t1.c_adj_line_amount
     ,p_adj_tax_amount           => t1.c_adj_tax_amount
     ,p_precision                => t1.c_precision
     ,p_minimum_accountable_unit => t1.c_minimum_accountable_unit
     )
  )
else
  null
end c_trx_comment_flag,
max(t1.c_exempt_reason) over (partition by t1.c_inv_cust_trx_id,t1.c_cust_trx_id,t1.c_adjustment_id) c_inv_exempt_reason,
--
-- G_ITEM_LINES columns
--
case when t1.line_rownum = 1
then
  xxen_zx.c_line_amount_calc
  (p_type_flag                => t1.c_type_flag
  ,p_line_amount              => t1.c_line_amount
  ,p_adj_line_amount          => t1.c_adj_line_amount
  ,p_adj_freight_amount       => t1.c_adj_freight_amount
  ,p_inv_line_lines_count     => t1.c_inv_line_lines_count
  ,p_inv_line_amount_abs      => t1.c_inv_line_amount_abs
  ,p_precision                => t1.c_precision
  ,p_minimum_accountable_unit => t1.c_minimum_accountable_unit
  )
else
  null
end c_line_amount_calc,
--
-- G_TAX_LINES columns
--
xxen_zx.c_tax_amount_calc
(p_type_flag                => t1.c_type_flag
,p_tax_amount               => t1.c_tax_amount
,p_adj_tax_amount           => t1.c_adj_tax_amount
,p_inv_line_lines_count     => t1.c_inv_line_lines_count
,p_inv_tax_lines_count      => t1.c_inv_tax_lines_count
,p_inv_tax_amount_abs       => t1.c_inv_tax_amount_abs
,p_precision                => t1.c_precision
,p_minimum_accountable_unit => t1.c_minimum_accountable_unit
) c_tax_amount_calc,
--
xxen_zx.c_exempt_amount
(p_exempt_reason               => t1.c_exempt_reason
,p_exempt_number               => t1.c_exempt_number
,p_exempt_percent              => t1.c_exempt_percent
,p_vat_code                    => t1.c_vat_code
,p_tax_rate                    => t1.c_tax_rate
,p_historical_flag             => t1.c_historical_flag
,p_line_amount_calc            =>
   xxen_zx.c_line_amount_calc
   (p_type_flag                => t1.c_type_flag
   ,p_line_amount              => t1.c_line_amount
   ,p_adj_line_amount          => t1.c_adj_line_amount
   ,p_adj_freight_amount       => t1.c_adj_freight_amount
   ,p_inv_line_lines_count     => t1.c_inv_line_lines_count
   ,p_inv_line_amount_abs      => t1.c_inv_line_amount_abs
   ,p_precision                => t1.c_precision
   ,p_minimum_accountable_unit => t1.c_minimum_accountable_unit
   )
,p_vendor_exempt_amts          => t1.c_vendor_exempt_amts
,p_vendor_non_taxable_amts     => t1.c_vendor_non_taxable_amts
,p_tax_auth_name               => t1.cp_tax_auth_name
,p_cnt_tax_lines_for_inv_line  => t1.c_cnt_tax_lines_for_inv_line
,p_precision                   => t1.c_precision
,p_minimum_accountable_unit    => t1.c_minimum_accountable_unit
) c_exempt_amount,
--
decode(
 xxen_zx.c_exempt_amount
 (p_exempt_reason               => t1.c_exempt_reason
 ,p_exempt_number               => t1.c_exempt_number
 ,p_exempt_percent              => t1.c_exempt_percent
 ,p_vat_code                    => t1.c_vat_code
 ,p_tax_rate                    => t1.c_tax_rate
 ,p_historical_flag             => t1.c_historical_flag
 ,p_line_amount_calc            =>
    xxen_zx.c_line_amount_calc
    (p_type_flag                => t1.c_type_flag
    ,p_line_amount              => t1.c_line_amount
    ,p_adj_line_amount          => t1.c_adj_line_amount
    ,p_adj_freight_amount       => t1.c_adj_freight_amount
    ,p_inv_line_lines_count     => t1.c_inv_line_lines_count
    ,p_inv_line_amount_abs      => t1.c_inv_line_amount_abs
    ,p_precision                => t1.c_precision
    ,p_minimum_accountable_unit => t1.c_minimum_accountable_unit
    )
 ,p_vendor_exempt_amts          => t1.c_vendor_exempt_amts
 ,p_vendor_non_taxable_amts     => t1.c_vendor_non_taxable_amts
 ,p_tax_auth_name               => t1.cp_tax_auth_name
 ,p_cnt_tax_lines_for_inv_line  => t1.c_cnt_tax_lines_for_inv_line
 ,p_precision                   => t1.c_precision
 ,p_minimum_accountable_unit    => t1.c_minimum_accountable_unit
 ),0,0,1
) c_exempt_flag,
--
case when t1.c_tax_cust_trx_line_id is not null
then
xxen_zx.c_city_count_state_oth_tax_amt
(p_cust_trx_id                => t1.c_cust_trx_id
,p_adj_id                     => t1.c_adjustment_id
,p_tax_cust_trx_line_id       => t1.c_tax_cust_trx_line_id
,p_city_county_state_other    => 'CITY'
,p_tax_amount                 => t1.c_tax_amount
,p_adj_tax_amount             => t1.c_adj_tax_amount
,p_type_flag                  => t1.c_type_flag
,p_vat_code                   => t1.c_vat_code
,p_tax_except_rate_id         => t1.c_tax_except_rate_id
,p_sales_tax_id               => t1.c_sales_tax_id
,p_tax_authority_id           => t1.c_tax_authority_id
,p_tax_authority_zip_code     => t1.c_tax_authority_zip_code
,p_tax                        => t1.c_tax
,p_inv_date                   => t1.c_inv_date
,p_adjusted_doc_date          => t1.c_adjusted_doc_date
,p_global_attribute_category  => t1.c_global_attribute_category
,p_vendor_location_qualifier  => t1.c_vendor_location_qualifier
,p_vendor_state_amt           => t1.c_vendor_state_amt
,p_vendor_county_amt          => t1.c_vendor_county_amt
,p_vendor_city_amt            => t1.c_vendor_city_amt
,p_vendor_state_rate          => t1.c_vendor_state_rate
,p_vendor_county_rate         => t1.c_vendor_county_rate
,p_vendor_city_rate           => t1.c_vendor_city_rate
,p_historical_flag            => t1.c_historical_flag
,p_precision                  => t1.c_precision
,p_minimum_accountable_unit   => t1.c_minimum_accountable_unit
)
else
0
end c_city_tax_amt,
--
case when t1.c_tax_cust_trx_line_id is not null
then
xxen_zx.c_city_count_state_oth_tax_amt
(p_cust_trx_id                => t1.c_cust_trx_id
,p_adj_id                     => t1.c_adjustment_id
,p_tax_cust_trx_line_id       => t1.c_tax_cust_trx_line_id
,p_city_county_state_other    => 'COUNTY'
,p_tax_amount                 => t1.c_tax_amount
,p_adj_tax_amount             => t1.c_adj_tax_amount
,p_type_flag                  => t1.c_type_flag
,p_vat_code                   => t1.c_vat_code
,p_tax_except_rate_id         => t1.c_tax_except_rate_id
,p_sales_tax_id               => t1.c_sales_tax_id
,p_tax_authority_id           => t1.c_tax_authority_id
,p_tax_authority_zip_code     => t1.c_tax_authority_zip_code
,p_tax                        => t1.c_tax
,p_inv_date                   => t1.c_inv_date
,p_adjusted_doc_date          => t1.c_adjusted_doc_date
,p_global_attribute_category  => t1.c_global_attribute_category
,p_vendor_location_qualifier  => t1.c_vendor_location_qualifier
,p_vendor_state_amt           => t1.c_vendor_state_amt
,p_vendor_county_amt          => t1.c_vendor_county_amt
,p_vendor_city_amt            => t1.c_vendor_city_amt
,p_vendor_state_rate          => t1.c_vendor_state_rate
,p_vendor_county_rate         => t1.c_vendor_county_rate
,p_vendor_city_rate           => t1.c_vendor_city_rate
,p_historical_flag            => t1.c_historical_flag
,p_precision                  => t1.c_precision
,p_minimum_accountable_unit   => t1.c_minimum_accountable_unit
)
else
0
end c_county_tax_amt,
--
case when t1.c_tax_cust_trx_line_id is not null
then
xxen_zx.c_city_count_state_oth_tax_amt
(p_cust_trx_id                => t1.c_cust_trx_id
,p_adj_id                     => t1.c_adjustment_id
,p_tax_cust_trx_line_id       => t1.c_tax_cust_trx_line_id
,p_city_county_state_other    => 'STATE'
,p_tax_amount                 => t1.c_tax_amount
,p_adj_tax_amount             => t1.c_adj_tax_amount
,p_type_flag                  => t1.c_type_flag
,p_vat_code                   => t1.c_vat_code
,p_tax_except_rate_id         => t1.c_tax_except_rate_id
,p_sales_tax_id               => t1.c_sales_tax_id
,p_tax_authority_id           => t1.c_tax_authority_id
,p_tax_authority_zip_code     => t1.c_tax_authority_zip_code
,p_tax                        => t1.c_tax
,p_inv_date                   => t1.c_inv_date
,p_adjusted_doc_date          => t1.c_adjusted_doc_date
,p_global_attribute_category  => t1.c_global_attribute_category
,p_vendor_location_qualifier  => t1.c_vendor_location_qualifier
,p_vendor_state_amt           => t1.c_vendor_state_amt
,p_vendor_county_amt          => t1.c_vendor_county_amt
,p_vendor_city_amt            => t1.c_vendor_city_amt
,p_vendor_state_rate          => t1.c_vendor_state_rate
,p_vendor_county_rate         => t1.c_vendor_county_rate
,p_vendor_city_rate           => t1.c_vendor_city_rate
,p_historical_flag            => t1.c_historical_flag
,p_precision                  => t1.c_precision
,p_minimum_accountable_unit   => t1.c_minimum_accountable_unit
)
else
0
end c_state_tax_amt,
--
case when t1.c_tax_cust_trx_line_id is not null
then
xxen_zx.c_city_count_state_oth_tax_amt
(p_cust_trx_id                => t1.c_cust_trx_id
,p_adj_id                     => t1.c_adjustment_id
,p_tax_cust_trx_line_id       => t1.c_tax_cust_trx_line_id
,p_city_county_state_other    => 'OTHER'
,p_tax_amount                 => t1.c_tax_amount
,p_adj_tax_amount             => t1.c_adj_tax_amount
,p_type_flag                  => t1.c_type_flag
,p_vat_code                   => t1.c_vat_code
,p_tax_except_rate_id         => t1.c_tax_except_rate_id
,p_sales_tax_id               => t1.c_sales_tax_id
,p_tax_authority_id           => t1.c_tax_authority_id
,p_tax_authority_zip_code     => t1.c_tax_authority_zip_code
,p_tax                        => t1.c_tax
,p_inv_date                   => t1.c_inv_date
,p_adjusted_doc_date          => t1.c_adjusted_doc_date
,p_global_attribute_category  => t1.c_global_attribute_category
,p_vendor_location_qualifier  => t1.c_vendor_location_qualifier
,p_vendor_state_amt           => t1.c_vendor_state_amt
,p_vendor_county_amt          => t1.c_vendor_county_amt
,p_vendor_city_amt            => t1.c_vendor_city_amt
,p_vendor_state_rate          => t1.c_vendor_state_rate
,p_vendor_county_rate         => t1.c_vendor_county_rate
,p_vendor_city_rate           => t1.c_vendor_city_rate
,p_historical_flag            => t1.c_historical_flag
,p_precision                  => t1.c_precision
,p_minimum_accountable_unit   => t1.c_minimum_accountable_unit
)
else
0
end c_other_tax_amt
from
(select
 qtl.*,
 -- transaction level
 xxen_zx.c_inv_line_amount_abs(qtl.c_cust_trx_id,qtl.c_adjustment_id,qtl.c_type_flag) c_inv_line_amount_abs,
 xxen_zx.c_inv_freight_amount_abs(qtl.c_cust_trx_id,qtl.c_adjustment_id,qtl.c_type_flag) c_inv_freight_amount_abs,
 xxen_zx.c_inv_tax_amount_abs(qtl.c_cust_trx_id,qtl.c_adjustment_id,qtl.c_type_flag) c_inv_tax_amount_abs,
 xxen_zx.c_inv_line_lines_count(qtl.c_cust_trx_id,qtl.c_adjustment_id,qtl.c_type_flag) c_inv_line_lines_count,
 xxen_zx.c_inv_tax_lines_count(qtl.c_cust_trx_id,qtl.c_adjustment_id,qtl.c_type_flag) c_inv_tax_lines_count,
 xxen_zx.c_inv_freight_lines_count(qtl.c_cust_trx_id,qtl.c_adjustment_id,qtl.c_type_flag) c_inv_freight_lines_count,
 -- line level
 sum(nvl2(qtl.c_tax_cust_trx_line_id,1,0)) over (partition by qtl.c_inv_cust_trx_id,qtl.c_cust_trx_id,qtl.c_adjustment_id,qtl.c_trx_line_id) c_cnt_tax_lines_for_inv_line,
 --tax level
 xxen_zx.cp_tax_auth_name(qtl.c_historical_flag,qtl.c_sales_tax_id,qtl.c_tax_authority_id,qtl.c_tax) cp_tax_auth_name,
 -- row seq indicators
 row_number() over (partition by qtl.c_currency,qtl.c_state order by qtl.c_county,qtl.c_city,qtl.c_order_by_1,qtl.c_order_by_2,qtl.c_order_by_3,qtl.c_inv_number,qtl.c_cust_trx_id,qtl.c_adjustment_id,qtl.c_line_number,qtl.c_tax_line_number) state_rownum,
 row_number() over (partition by qtl.c_currency,qtl.c_state,qtl.c_county order by qtl.c_city,qtl.c_order_by_1,qtl.c_order_by_2,qtl.c_order_by_3,qtl.c_inv_number,qtl.c_cust_trx_id,qtl.c_adjustment_id,qtl.c_line_number,qtl.c_tax_line_number) county_rownum,
 row_number() over (partition by qtl.c_currency,qtl.c_state,qtl.c_county,qtl.c_city order by qtl.c_order_by_1,qtl.c_order_by_2,qtl.c_order_by_3,qtl.c_inv_number,qtl.c_cust_trx_id,qtl.c_adjustment_id,qtl.c_line_number,qtl.c_tax_line_number) city_rownum,
 row_number() over (partition by qtl.c_inv_cust_trx_id order by qtl.c_cust_trx_id,qtl.c_adjustment_id,qtl.c_line_number,qtl.c_tax_line_number) inv_rownum,
 row_number() over (partition by qtl.c_inv_cust_trx_id,qtl.c_cust_trx_id,qtl.c_adjustment_id order by qtl.c_line_number,qtl.c_tax_line_number) trx_rownum,
 row_number() over (partition by qtl.c_inv_cust_trx_id,qtl.c_cust_trx_id,qtl.c_adjustment_id,qtl.c_trx_line_id order by qtl.c_tax_line_number) line_rownum,
 haouv.name operating_unit
 from
 q_trx_lines qtl,
 hr_all_organization_units_vl haouv
 where
 qtl.c_org_id = haouv.organization_id (+)
) t1
) t2
) t3
where
nvl(:p_trx_date_low,sysdate) = nvl(:p_trx_date_low,sysdate) and
nvl(:p_trx_date_high,sysdate) = nvl(:p_trx_date_high,sysdate) and
nvl(:p_gl_date_low,sysdate) = nvl(:p_gl_date_low,sysdate) and
nvl(:p_gl_date_high,sysdate) = nvl(:p_gl_date_high,sysdate) and
nvl(:p_show_cms_adjs_outside_date,'Y') = nvl(:p_show_cms_adjs_outside_date,'Y')
order by
t3.c_currency,
t3.c_state,
t3.c_county,
t3.c_city,
t3.c_order_by_1,
t3.c_order_by_2,
t3.c_order_by_3,
t3.c_inv_number,
t3.c_inv_cust_trx_id,
t3.c_inv_type_code_order,
t3.c_inv_date,
t3.c_cust_trx_id,
t3.c_adjustment_id,
t3.c_line_number,
t3.c_trx_line_id,
t3.c_tax_line_number