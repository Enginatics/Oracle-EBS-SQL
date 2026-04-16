---
layout: default
title: 'AR Customers and Sites | Oracle EBS SQL Report'
description: 'Master data report of customer master data including address, sites, site uses, payment terms, Salesperson, price list and other profile information.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Customers, Sites, fnd_territories_vl, hz_role_responsibility, hz_cust_account_roles'
permalink: /AR%20Customers%20and%20Sites/
---

# AR Customers and Sites – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-customers-and-sites/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Master data report of customer master data including address, sites, site uses, payment terms, Salesperson, price list and other profile information.

## Report Parameters
Operating Unit, Customer Name, Customer Name not like, Account Number, Country, Show identifying Addresses only, Show active only, Show Profile Amounts, Profile Amount Currency, Show Receipt Methods, Show Bank Accounts, Show Debit Authorities, Show Contacts, Show Tax Registrations, Show trx count within x days, Show Latest Trx Date, Level, Site Use, Show DFF Attributes, Creation Date From, Creation Date To, Last Update Date From, Last Update Date To

## Oracle EBS Tables Used
[fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl), [hz_role_responsibility](https://www.enginatics.com/library/?pg=1&find=hz_role_responsibility), [hz_cust_account_roles](https://www.enginatics.com/library/?pg=1&find=hz_cust_account_roles), [hz_relationships](https://www.enginatics.com/library/?pg=1&find=hz_relationships), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hz_org_contacts](https://www.enginatics.com/library/?pg=1&find=hz_org_contacts), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations), [hz_contact_points](https://www.enginatics.com/library/?pg=1&find=hz_contact_points), [iby_external_payers_all](https://www.enginatics.com/library/?pg=1&find=iby_external_payers_all), [iby_pmt_instr_uses_all](https://www.enginatics.com/library/?pg=1&find=iby_pmt_instr_uses_all), [iby_ext_bank_accounts](https://www.enginatics.com/library/?pg=1&find=iby_ext_bank_accounts), [ce_bank_branches_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_branches_v), [zx_registrations](https://www.enginatics.com/library/?pg=1&find=zx_registrations), [zx_party_tax_profile](https://www.enginatics.com/library/?pg=1&find=zx_party_tax_profile), [zx_output_classifications_v](https://www.enginatics.com/library/?pg=1&find=zx_output_classifications_v), [hr_locations](https://www.enginatics.com/library/?pg=1&find=hr_locations)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AR Customers and Sites 22-Jul-2023 155106.xlsx](https://www.enginatics.com/example/ar-customers-and-sites/) |
| Blitz Report™ XML Import | [AR_Customers_and_Sites.xml](https://www.enginatics.com/xml/ar-customers-and-sites/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-customers-and-sites/](https://www.enginatics.com/reports/ar-customers-and-sites/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
