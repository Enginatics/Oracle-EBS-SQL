# AR Customers and Sites - Case Study & Technical Analysis

## Executive Summary

The **AR Customers and Sites** report is a comprehensive master data audit tool for Oracle Receivables. It provides a detailed, flattened view of the complex customer hierarchy within the Oracle Trading Community Architecture (TCA). By consolidating information regarding parties, accounts, sites, business purposes, contacts, profiles, and banking details, this report empowers organizations to maintain high data quality, ensuring accurate billing, shipping, and tax compliance.

## Business Challenge

In Oracle E-Business Suite, customer data is normalized across numerous tables (TCA model), making it challenging to extract a simple, holistic view of a customer. Common challenges include:

*   **Data Fragmentation:** Key information like addresses, tax registration numbers, and payment terms are stored in separate, linked entities.
*   **Data Quality Issues:** Duplicate sites, incorrect addresses, or missing contacts can lead to operational failures such as returned shipments or rejected invoices.
*   **Audit & Compliance:** Verifying that all active customers have valid tax IDs and correct credit limits requires querying multiple screens or complex custom scripts.
*   **Maintenance:** Identifying inactive customers or sites for cleanup is difficult without a consolidated report.

## Solution

The **AR Customers and Sites** report solves these problems by offering a unified view of the customer master. Key features include:

*   **360-Degree View:** Combines Party, Account, Site, and Site Use details into a single, easy-to-analyze format.
*   **Detailed Attributes:** Includes critical fields such as Payment Terms, Price Lists, Salespersons, Tax Registrations, and Credit Limits.
*   **Flexible Scope:** Parameters allow users to toggle the inclusion of related data like Bank Accounts, Contacts, and Receipt Methods, keeping the report performance-optimized and relevant.
*   **Audit Capabilities:** "Creation Date" and "Last Update Date" filters help track recent changes or identify dormant records.

## Technical Architecture

The report navigates the complex Oracle TCA schema to retrieve and link data accurately.

### Key Tables & Joins

*   **Party Layer:** `HZ_PARTIES` (Organization/Person details).
*   **Account Layer:** `HZ_CUST_ACCOUNTS` (Financial relationship).
*   **Site Layer:** `HZ_CUST_ACCT_SITES_ALL` linked to `HZ_PARTY_SITES` and `HZ_LOCATIONS` (Physical address).
*   **Usage Layer:** `HZ_CUST_SITE_USES_ALL` (Bill-To, Ship-To purposes).
*   **Profile Layer:** `HZ_CUSTOMER_PROFILES` & `HZ_CUST_PROFILE_AMTS` (Credit limits, terms).
*   **Banking Layer:** `IBY_EXTERNAL_PAYERS_ALL`, `IBY_PMT_INSTR_USES_ALL`, `IBY_EXT_BANK_ACCOUNTS` (Bank details).
*   **Tax Layer:** `ZX_REGISTRATIONS`, `ZX_PARTY_TAX_PROFILE` (Tax IDs and regimes).

### Data Logic

The query logic ensures that:
1.  **Hierarchy Traversal:** It correctly traverses from Party -> Account -> Account Site -> Site Use.
2.  **Level-Based Reporting:** It can report at the Customer Account level or drill down to specific Site Uses.
3.  **Outer Joins:** It uses outer joins for related details (like Bank Accounts or Contacts) so that customers without these details are still listed.

## Parameters

The report provides extensive filtering and display options:

*   **Operating Unit:** Filters by the specific business unit.
*   **Customer Name / Account Number:** Targets specific customers.
*   **Show active only:** Filters out inactive accounts or sites.
*   **Show Profile Amounts:** Includes credit limits and currency settings.
*   **Show Bank Accounts:** Displays associated bank account numbers and branches.
*   **Show Contacts:** Lists contact names, phones, and emails.
*   **Show Tax Registrations:** Includes Tax Registration Numbers (TRN).
*   **Date Ranges:** Filters by Creation Date or Last Update Date for audit purposes.

## Performance

The report is designed to be efficient even with large customer bases.
*   **Selective Detail:** By default, heavy joins (like Bank Accounts or Contacts) might be optional (controlled by parameters) to speed up the base report.
*   **Indexing:** Relies on standard TCA indexes on `party_id`, `cust_account_id`, and `site_use_id`.

## FAQ

**Q: Why do I see the same customer name multiple times?**
A: The report typically outputs one row per "Site Use" (e.g., one row for the Bill-To address, another for the Ship-To address). If a customer has multiple sites, they will appear multiple times.

**Q: How can I find customers created in the last month?**
A: Use the "Creation Date From" parameter and set it to the first day of the last month.

**Q: Does this report show inactive sites?**
A: Yes, unless you set the "Show active only" parameter to 'Yes'. Inactive sites will usually have a status of 'I' or 'Inactive'.
