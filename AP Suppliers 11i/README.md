---
layout: default
last_modified_at: 2026-10-19
title: 'AP Suppliers 11i | Oracle EBS SQL Report'
description: 'AP suppliers (po vendors) including supplier sites and contact information Duplicate Match restricts the output to suppliers sharing a match key with at…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Payables, Enginatics, Suppliers, 11i, hr_all_organization_units_vl, po_vendors, po_vendor_sites_all'
permalink: /AP%20Suppliers%2011i/
report_name: 'AP Suppliers 11i'
report_web_name: ap-suppliers-11i
module: 'Payables'
module_url: /modules/payables/
---

# AP Suppliers 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-suppliers-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-11i) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-11i).
**Oracle EBS module:** [Payables](/modules/payables/ "Oracle EBS Payables reports") · [all Payables reports](/modules/payables/)  

## Overview
AP suppliers (po vendors) including supplier sites and contact information

Duplicate Match restricts the output to suppliers sharing a match key with at least one other supplier and lists the shared keys. Names are compared in upper case without punctuation, spaces and legal form suffixes (Inc, Ltd, GmbH, SA and similar), the other keys without punctuation and spaces. Bank accounts are shown masked.

Spend Last 12 Months is the total of the supplier's invoices dated in the last twelve months, excluding cancelled invoices, in each operating unit's functional currency.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-11i) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Supplier, Supplier Number, Supplier Type, Country, Show Contacts, Duplicate Match, Name Data Quality Issues Only

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-11i), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-11i), [po_vendor_sites_all](https://www.enginatics.com/library/?pg=1&find=po_vendor_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-11i), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-11i), [po_vendor_contacts](https://www.enginatics.com/library/?pg=1&find=po_vendor_contacts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-11i), [ap_terms_tl](https://www.enginatics.com/library/?pg=1&find=ap_terms_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-11i)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-11i)

## Related Reports
[AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report"), [AP Suppliers](/AP%20Suppliers/ "AP Suppliers Oracle EBS SQL Report"), [PO Purchasing Document Upload](/PO%20Purchasing%20Document%20Upload/ "PO Purchasing Document Upload Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [AP Accounted Invoice Aging](/AP%20Accounted%20Invoice%20Aging/ "AP Accounted Invoice Aging Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Suppliers%2011i/AP%20Suppliers%2011i.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-11i) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ap-suppliers-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-11i) |
| Blitz Report™ XML Import | [AP_Suppliers_11i.xml](https://www.enginatics.com/xml/ap-suppliers-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-11i) |
| SQL Source | [AP Suppliers 11i.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Suppliers%2011i/AP%20Suppliers%2011i.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ap-suppliers-11i/](https://www.enginatics.com/reports/ap-suppliers-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-11i) |

## Case Study & Technical Analysis: AP Suppliers

### 1. Executive Summary

#### Business Problem
Supplier master data is the foundation of the Procure-to-Pay process. Inaccurate or duplicate supplier records can lead to duplicate payments, fraud risks, tax compliance issues (e.g., missing 1099 flags), and procurement inefficiencies. Organizations often struggle to maintain a clean vendor master due to:
*   **Decentralized Entry:** Multiple departments creating vendors with inconsistent standards.
*   **Lack of Visibility:** Difficulty in seeing the full picture of a supplier across multiple operating units and sites.
*   **Compliance Gaps:** Missing Taxpayer IDs, VAT registration numbers, or Withholding Tax configurations.
*   **Risk Management:** Inability to quickly identify active vendors with missing bank details or outdated payment terms.

#### Solution Overview
The **AP Suppliers** report provides a 360-degree view of the vendor master database. It consolidates data from multiple tables to present a unified view of Suppliers, Supplier Sites, Contacts, and Bank Accounts. This report is essential for Master Data Management (MDM) teams, Auditors, and AP Managers to validate, clean, and monitor the health of their supplier base.

#### Key Benefits
*   **Comprehensive Visibility:** Drills down from the Supplier Header to Sites, Contacts, and Bank Accounts in a single view.
*   **Risk Mitigation:** Highlights critical fields like Taxpayer IDs, Payment Terms, and Bank Account details for audit review.
*   **Compliance:** Identifies suppliers missing 1099 flags, VAT codes, or Withholding Tax groups.
*   **Operational Efficiency:** Helps identify and deactivate unused or duplicate supplier sites.
*   **Multi-Org Support:** Shows which Operating Units have access to specific supplier sites.

### 2. Technical Analysis

#### Core Tables and Views
The report queries the Trading Community Architecture (TCA) and AP tables:
*   **`AP_SUPPLIERS`**: Stores the header-level vendor information (Name, Tax ID, Parent Supplier).
*   **`AP_SUPPLIER_SITES_ALL`**: Stores address and site-specific attributes (Payment Terms, GL Accounts, Purchasing Flags).
*   **`HZ_PARTIES` / `HZ_PARTY_SITES`**: Underlying TCA tables for party information.
*   **`IBY_EXT_BANK_ACCOUNTS`**: Stores external bank account details (via `IBY` payment/funds capture tables).
*   **`PO_VENDOR_CONTACTS`**: Stores contact names, phones, and emails.
*   **`AP_AWT_GROUPS`**: Links to Withholding Tax configurations.

#### SQL Logic and Data Flow
The SQL is structured to handle the complex relationships between Suppliers, Sites, and Banks.
*   **Outer Joins:** Extensively used to ensure that a supplier is listed even if they don't have a site, contact, or bank account defined (depending on the "Show" parameters).
*   **Dynamic Columns:** The SQL uses lexical parameters (e.g., `&supplier_bank_account`, `&contacts_columns`) to conditionally include or exclude sensitive or voluminous data based on user selection.
*   **TCA Integration:** Joins to `HZ_PARTIES` to fetch the "Trading Partner" name and other TCA-level attributes.
*   **Payment Method Logic:** Uses `listagg` to concatenate multiple payment methods into a single comma-separated string for easier reading.
*   **Security:** Bank account information is typically retrieved from the secure `IBY` tables, and access is often controlled by Oracle's function security.

#### Integration Points
*   **TCA (Trading Community Architecture):** The central repository for parties and locations.
*   **Payments (IBY):** Centralized payment setup for banks and payment methods.
*   **General Ledger:** Default account coding (Liability, Prepayment).
*   **Tax (E-Business Tax):** Links to `ZX_PARTY_TAX_PROFILE` for tax registration details.

### 3. Functional Capabilities

#### Reporting Dimensions
*   **Supplier Profile:** Analyze by Supplier Type (Standard, Employee, Tax Authority), Country, or Category.
*   **Site Analysis:** Review active vs. inactive sites, Pay Sites vs. Purchasing Sites.
*   **Financial Controls:** Audit Payment Terms, Credit Limits, and Hold Flags.
*   **Contact Management:** Export contact lists for mass communication or cleanup.

#### Key Parameters
*   **Scope:** Operating Unit, Supplier Name (starts with).
*   **Status Filters:** Active Suppliers Only, Active Sites Only.
*   **Detail Level:** Show Contacts (Yes/No), Show Bank Accounts (Yes/No).
*   **Date Ranges:** Creation Date (to audit new vendors).

### 4. Implementation Considerations

#### Data Privacy
*   **Bank Accounts:** This report can expose sensitive bank account numbers. Ensure that access to the report is restricted to authorized personnel (e.g., AP Managers, MDM Team).
*   **PII:** Supplier contacts and Employee-type suppliers may contain Personally Identifiable Information.

#### Best Practices
*   **Regular Audits:** Schedule this report monthly to review new suppliers created in the period.
*   **Inactive Cleanup:** Use the "Last Update Date" and "Inactive Date" fields to identify and deactivate dormant suppliers.
*   **Duplicate Check:** Export to Excel and use fuzzy matching on "Supplier Name" and "Address" to find potential duplicates.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-11i)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-11i)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-11i)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-11i)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-11i)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-11i)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-suppliers-11i)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
