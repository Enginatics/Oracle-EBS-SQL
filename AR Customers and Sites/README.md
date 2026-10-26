---
layout: default
last_modified_at: 2026-10-26
title: 'AR Customers and Sites | Oracle EBS SQL Report'
description: 'Master data report of customer master data including address, sites, site uses, payment terms, Salesperson, price list and other profile information…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Receivables, Enginatics, R12 only, Customers, Sites, fnd_territories_vl, hz_role_responsibility, hz_cust_account_roles'
permalink: /AR%20Customers%20and%20Sites/
report_name: 'AR Customers and Sites'
report_web_name: ar-customers-and-sites
module: 'Receivables'
module_url: /modules/receivables/
---

# AR Customers and Sites – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-customers-and-sites/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites).
**Oracle EBS module:** [Receivables](/modules/receivables/ "Oracle EBS Receivables reports") · [all Receivables reports](/modules/receivables/)  

## Overview
Master data report of customer master data including address, sites, site uses, payment terms, Salesperson, price list and other profile information.

Payment terms are reported from each of their own sources: Account Profile Payment Term and Site Profile Payment Term from the customer profile at account and site level, and Site Use Payment Term from the site use Order Management terms.

When India Localization is installed, the following GST columns are also included: GST Registration No, GST PAN No.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Customer Name, Customer Name not like, Account Number, Country, Show identifying Addresses only, Show active only, Show Profile Amounts, Profile Amount Currency, Show Receipt Methods, Show Bank Accounts, Show Debit Authorities, Show Contacts, Show Tax Registrations, Show Fiscal Classifications, Show trx count within x days, Show Latest Trx Date, Level, Site Use, DFF Display, Creation Date From, Creation Date To, Last Update Date From, Last Update Date To

## Oracle EBS Tables Used
[fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [hz_role_responsibility](https://www.enginatics.com/library/?pg=1&find=hz_role_responsibility&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [hz_cust_account_roles](https://www.enginatics.com/library/?pg=1&find=hz_cust_account_roles&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [hz_relationships](https://www.enginatics.com/library/?pg=1&find=hz_relationships&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [hz_org_contacts](https://www.enginatics.com/library/?pg=1&find=hz_org_contacts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [hz_contact_points](https://www.enginatics.com/library/?pg=1&find=hz_contact_points&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [iby_external_payers_all](https://www.enginatics.com/library/?pg=1&find=iby_external_payers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [iby_pmt_instr_uses_all](https://www.enginatics.com/library/?pg=1&find=iby_pmt_instr_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [iby_ext_bank_accounts](https://www.enginatics.com/library/?pg=1&find=iby_ext_bank_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [ce_bank_branches_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_branches_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [zx_registrations](https://www.enginatics.com/library/?pg=1&find=zx_registrations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [zx_party_tax_profile](https://www.enginatics.com/library/?pg=1&find=zx_party_tax_profile&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [hz_code_assignments](https://www.enginatics.com/library/?pg=1&find=hz_code_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [zx_fc_types_b](https://www.enginatics.com/library/?pg=1&find=zx_fc_types_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [zx_output_classifications_v](https://www.enginatics.com/library/?pg=1&find=zx_output_classifications_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [hr_locations](https://www.enginatics.com/library/?pg=1&find=hr_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [jtf_rs_salesreps](https://www.enginatics.com/library/?pg=1&find=jtf_rs_salesreps&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [jtf_rs_resource_extns_tl](https://www.enginatics.com/library/?pg=1&find=jtf_rs_resource_extns_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [qp_list_headers_tl](https://www.enginatics.com/library/?pg=1&find=qp_list_headers_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [ra_terms_vl](https://www.enginatics.com/library/?pg=1&find=ra_terms_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [ar_statement_cycles](https://www.enginatics.com/library/?pg=1&find=ar_statement_cycles&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [ar_dunning_letter_sets](https://www.enginatics.com/library/?pg=1&find=ar_dunning_letter_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [ar_collectors](https://www.enginatics.com/library/?pg=1&find=ar_collectors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [fnd_territories_tl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [hz_customer_profiles](https://www.enginatics.com/library/?pg=1&find=hz_customer_profiles&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [hz_cust_profile_classes](https://www.enginatics.com/library/?pg=1&find=hz_cust_profile_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [ra_territories_kfv](https://www.enginatics.com/library/?pg=1&find=ra_territories_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [hz_cust_profile_amts](https://www.enginatics.com/library/?pg=1&find=hz_cust_profile_amts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [ra_cust_receipt_methods](https://www.enginatics.com/library/?pg=1&find=ra_cust_receipt_methods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [ar_receipt_methods](https://www.enginatics.com/library/?pg=1&find=ar_receipt_methods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [iby_debit_authorizations](https://www.enginatics.com/library/?pg=1&find=iby_debit_authorizations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites)

## Related Reports
[AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [WSH Commercial Invoice](/WSH%20Commercial%20Invoice/ "WSH Commercial Invoice Oracle EBS SQL Report"), [AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Customers%20and%20Sites/AR%20Customers%20and%20Sites.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AR Customers and Sites 22-Jul-2023 155106.xlsx](https://www.enginatics.com/example/ar-customers-and-sites/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites) |
| Blitz Report™ XML Import | [AR_Customers_and_Sites.xml](https://www.enginatics.com/xml/ar-customers-and-sites/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites) |
| SQL Source | [AR Customers and Sites.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Customers%20and%20Sites/AR%20Customers%20and%20Sites.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ar-customers-and-sites/](https://www.enginatics.com/reports/ar-customers-and-sites/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites) |

## AR Customers and Sites - Case Study & Technical Analysis

### Executive Summary

The **AR Customers and Sites** report is a comprehensive master data audit tool for Oracle Receivables. It provides a detailed, flattened view of the complex customer hierarchy within the Oracle Trading Community Architecture (TCA). By consolidating information regarding parties, accounts, sites, business purposes, contacts, profiles, and banking details, this report empowers organizations to maintain high data quality, ensuring accurate billing, shipping, and tax compliance.

### Business Challenge

In Oracle E-Business Suite, customer data is normalized across numerous tables (TCA model), making it challenging to extract a simple, holistic view of a customer. Common challenges include:

*   **Data Fragmentation:** Key information like addresses, tax registration numbers, and payment terms are stored in separate, linked entities.
*   **Data Quality Issues:** Duplicate sites, incorrect addresses, or missing contacts can lead to operational failures such as returned shipments or rejected invoices.
*   **Audit & Compliance:** Verifying that all active customers have valid tax IDs and correct credit limits requires querying multiple screens or complex custom scripts.
*   **Maintenance:** Identifying inactive customers or sites for cleanup is difficult without a consolidated report.

### Solution

The **AR Customers and Sites** report solves these problems by offering a unified view of the customer master. Key features include:

*   **360-Degree View:** Combines Party, Account, Site, and Site Use details into a single, easy-to-analyze format.
*   **Detailed Attributes:** Includes critical fields such as Payment Terms, Price Lists, Salespersons, Tax Registrations, and Credit Limits.
*   **Flexible Scope:** Parameters allow users to toggle the inclusion of related data like Bank Accounts, Contacts, and Receipt Methods, keeping the report performance-optimized and relevant.
*   **Audit Capabilities:** "Creation Date" and "Last Update Date" filters help track recent changes or identify dormant records.

### Technical Architecture

The report navigates the complex Oracle TCA schema to retrieve and link data accurately.

#### Key Tables & Joins

*   **Party Layer:** `HZ_PARTIES` (Organization/Person details).
*   **Account Layer:** `HZ_CUST_ACCOUNTS` (Financial relationship).
*   **Site Layer:** `HZ_CUST_ACCT_SITES_ALL` linked to `HZ_PARTY_SITES` and `HZ_LOCATIONS` (Physical address).
*   **Usage Layer:** `HZ_CUST_SITE_USES_ALL` (Bill-To, Ship-To purposes).
*   **Profile Layer:** `HZ_CUSTOMER_PROFILES` & `HZ_CUST_PROFILE_AMTS` (Credit limits, terms).
*   **Banking Layer:** `IBY_EXTERNAL_PAYERS_ALL`, `IBY_PMT_INSTR_USES_ALL`, `IBY_EXT_BANK_ACCOUNTS` (Bank details).
*   **Tax Layer:** `ZX_REGISTRATIONS`, `ZX_PARTY_TAX_PROFILE` (Tax IDs and regimes).

#### Data Logic

The query logic ensures that:
1.  **Hierarchy Traversal:** It correctly traverses from Party -> Account -> Account Site -> Site Use.
2.  **Level-Based Reporting:** It can report at the Customer Account level or drill down to specific Site Uses.
3.  **Outer Joins:** It uses outer joins for related details (like Bank Accounts or Contacts) so that customers without these details are still listed.

### Parameters

The report provides extensive filtering and display options:

*   **Operating Unit:** Filters by the specific business unit.
*   **Customer Name / Account Number:** Targets specific customers.
*   **Show active only:** Filters out inactive accounts or sites.
*   **Show Profile Amounts:** Includes credit limits and currency settings.
*   **Show Bank Accounts:** Displays associated bank account numbers and branches.
*   **Show Contacts:** Lists contact names, phones, and emails.
*   **Show Tax Registrations:** Includes Tax Registration Numbers (TRN).
*   **Date Ranges:** Filters by Creation Date or Last Update Date for audit purposes.

### Performance

The report is designed to be efficient even with large customer bases.
*   **Selective Detail:** By default, heavy joins (like Bank Accounts or Contacts) might be optional (controlled by parameters) to speed up the base report.
*   **Indexing:** Relies on standard TCA indexes on `party_id`, `cust_account_id`, and `site_use_id`.

### FAQ

**Q: Why do I see the same customer name multiple times?**
A: The report typically outputs one row per "Site Use" (e.g., one row for the Bill-To address, another for the Ship-To address). If a customer has multiple sites, they will appear multiple times.

**Q: How can I find customers created in the last month?**
A: Use the "Creation Date From" parameter and set it to the first day of the last month.

**Q: Does this report show inactive sites?**
A: Yes, unless you set the "Show active only" parameter to 'Yes'. Inactive sites will usually have a status of 'I' or 'Inactive'.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-customers-and-sites)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
