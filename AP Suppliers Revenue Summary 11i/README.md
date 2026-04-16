---
layout: default
title: 'AP Suppliers Revenue Summary 11i | Oracle EBS SQL Report'
description: 'AP suppliers (po vendors) revenue summary across different operating units – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Suppliers, Revenue, Summary, 11i, gl_periods, gl_sets_of_books, ap_bank_account_uses_all'
permalink: /AP%20Suppliers%20Revenue%20Summary%2011i/
---

# AP Suppliers Revenue Summary 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-suppliers-revenue-summary-11i/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
AP suppliers (po vendors) revenue summary across different operating units

## Report Parameters
Ledger, Operating Unit, Supplier, Supplier Number, Country, As of Date, Summary Level

## Oracle EBS Tables Used
[gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books), [ap_bank_account_uses_all](https://www.enginatics.com/library/?pg=1&find=ap_bank_account_uses_all), [ap_bank_accounts_all](https://www.enginatics.com/library/?pg=1&find=ap_bank_accounts_all), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors), [po_vendor_sites_all](https://www.enginatics.com/library/?pg=1&find=po_vendor_sites_all), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl), [ap_terms_tl](https://www.enginatics.com/library/?pg=1&find=ap_terms_tl), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [x](https://www.enginatics.com/library/?pg=1&find=x)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report"), [AP Invoices and Lines 11i](/AP%20Invoices%20and%20Lines%2011i/ "AP Invoices and Lines 11i Oracle EBS SQL Report"), [AP Suppliers Revenue Summary](/AP%20Suppliers%20Revenue%20Summary/ "AP Suppliers Revenue Summary Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ap-suppliers-revenue-summary-11i/) |
| Blitz Report™ XML Import | [AP_Suppliers_Revenue_Summary_11i.xml](https://www.enginatics.com/xml/ap-suppliers-revenue-summary-11i/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ap-suppliers-revenue-summary-11i/](https://www.enginatics.com/reports/ap-suppliers-revenue-summary-11i/) |

## Case Study & Technical Analysis: AP Suppliers Revenue Summary

### 1. Executive Summary

#### Business Problem
Procurement and Finance teams often struggle to get a consolidated view of supplier spend across the organization. Standard Oracle reports focus on transactional details (Invoice Register) or open balances (Aging), but lack the analytical view needed for strategic decision-making. Key challenges include:
*   **Fragmented Data:** Spend data is scattered across multiple Operating Units and years.
*   **Negotiation Leverage:** Difficulty in quickly identifying total spend with a vendor to negotiate better terms.
*   **Vendor Rationalization:** Inability to identify low-volume or dormant suppliers for cleanup.
*   **Trend Analysis:** Hard to see if spend with a specific supplier is increasing or decreasing year-over-year.

#### Solution Overview
The **AP Suppliers Revenue Summary** is a high-level analytical report designed for Strategic Sourcing and Spend Analysis. It aggregates AP invoice data to provide a multi-year view of supplier revenue. By summarizing spend into fiscal year and rolling year buckets (e.g., Current FY, Last 3 Years), it allows users to instantly identify their top suppliers and analyze spending trends.

#### Key Benefits
*   **Strategic Insight:** Provides a clear picture of "Who are our top suppliers?" and "How much did we spend with them last year?".
*   **Trend Analysis:** Side-by-side comparison of spend across multiple fiscal years (FY, FY-1, FY-2).
*   **Consolidation:** Aggregates data across Operating Units (depending on parameters) for a global view of supplier relationships.
*   **Master Data Audit:** Includes key vendor details like Tax IDs, Payment Terms, and masked IBANs alongside spend data.
*   **Efficiency:** Replaces manual Excel consolidation of multiple "Invoice Register" exports.

### 2. Technical Analysis

#### Core Tables and Views
The report combines master data with transactional aggregates:
*   **`AP_INVOICES_ALL`**: The source of truth for spend data (Invoice Amounts).
*   **`AP_SUPPLIERS` / `AP_SUPPLIER_SITES_ALL`**: Vendor master data.
*   **`GL_PERIODS` / `GL_LEDGERS`**: Used to determine Fiscal Year boundaries relative to the "As of Date".
*   **`IBY_EXT_BANK_ACCOUNTS`**: Fetches bank account details (IBAN) for the supplier.
*   **`HR_OPERATING_UNITS`**: For multi-org context.

#### SQL Logic and Data Flow
The query uses advanced analytical functions to pivot time-based data into columns without complex subqueries.
*   **Common Table Expression (CTE):** The `with x as (...)` block calculates the start and end dates of the fiscal year containing the `:as_of_date`. This dynamic date logic drives the column buckets.
*   **Analytical Sums:** Uses `SUM(CASE WHEN ...)` with `OVER (PARTITION BY ...)` to calculate spend for specific time windows (e.g., `amount_fy_&fy`, `amount_3_years`) within a single pass of the data.
*   **Dense Rank:** Uses `keep (dense_rank last order by ...)` to fetch the most relevant site details (Address, City) for the aggregated row, ensuring that even if a supplier has multiple sites, the report displays a representative location (usually the most recently created or updated).
*   **IBAN Aggregation:** Subqueries for `iban_prio1`, `iban_prio2`, etc., fetch the top priority bank accounts for the supplier, providing a snapshot of payment details.

#### Integration Points
*   **General Ledger:** Relies on the GL Calendar to define Fiscal Years.
*   **Payments (IBY):** Fetches banking details.
*   **Payables:** Aggregates invoice history.

### 3. Functional Capabilities

#### Reporting Dimensions
*   **Time Horizons:**
    *   **Fiscal Years:** Current FY, Previous FY, 2 Years Ago.
    *   **Rolling Periods:** Last 12 Months, Last 24 Months, Last 36 Months, Last 10 Years.
*   **Grouping:**
    *   **Summary Level:** Can likely group by Supplier (Global) or Supplier Site (Local).
    *   **Geography:** Analyze spend by Country or City.

#### Key Parameters
*   **As of Date:** The reference date for calculating "Current Year" and backward-looking buckets.
*   **Operating Unit:** Filter for specific business units or leave blank for all (if access allows).
*   **Supplier Filters:** Focus on specific vendors or categories.

### 4. Implementation Considerations

#### Performance
*   **Data Volume:** Aggregating `AP_INVOICES_ALL` over 10 years can be resource-intensive. The query is optimized with analytical functions, but running it for "All Suppliers" during peak hours should be avoided.
*   **Currency:** The report groups by `invoice_currency_code`. If a supplier is paid in multiple currencies, they will appear in multiple rows (one per currency). Users may need to convert to a functional currency in Excel for a total global spend view.

#### Best Practices
*   **Sourcing Reviews:** Use this report prior to contract renewals to understand total business volume.
*   **Supplier Rationalization:** Filter for suppliers with `amount_total < X` to identify candidates for deactivation.
*   **Fraud Detection:** Look for suppliers with significant spend increases (`amount_fy` >> `amount_fy_1`) without a known business reason.


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
