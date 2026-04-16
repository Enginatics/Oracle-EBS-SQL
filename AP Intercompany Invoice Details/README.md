---
layout: default
title: 'AP Intercompany Invoice Details | Oracle EBS SQL Report'
description: 'AP Intercompany Invoice Details – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Intercompany, Invoice, Details, mtl_units_of_measure, ap_invoices_all, ap_invoice_lines_all'
permalink: /AP%20Intercompany%20Invoice%20Details/
---

# AP Intercompany Invoice Details – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-intercompany-invoice-details/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
AP Intercompany Invoice Details


## Report Parameters
Ledger, Operating Unit, Supplier, Invoice Number, Invoice Type, Invoice Date From, Invoice Date To, Accounting Date From, Accounting Date To, Exclude Cancelled

## Oracle EBS Tables Used
[mtl_units_of_measure](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all), [ap_invoice_lines_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_lines_all), [ap_invoice_distributions_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_distributions_all), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [mtl_system_items_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b_kfv), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ap-intercompany-invoice-details/) |
| Blitz Report™ XML Import | [AP_Intercompany_Invoice_Details.xml](https://www.enginatics.com/xml/ap-intercompany-invoice-details/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ap-intercompany-invoice-details/](https://www.enginatics.com/reports/ap-intercompany-invoice-details/) |

## Case Study & Technical Analysis: AP Intercompany Invoice Details

### 1. Executive Summary

#### Business Problem
Intercompany transactions are a common source of complexity in multi-entity organizations. Financial controllers and shared service centers often face challenges with:
- **Reconciliation Discrepancies:** Mismatches between intercompany receivables and payables.
- **Transfer Pricing Compliance:** Ensuring intercompany invoices reflect the correct transfer prices and markups.
- **Tax Reporting:** Accurately identifying and reporting intercompany VAT/GST.
- **Consolidation Efficiency:** Delays in month-end close due to the manual effort required to eliminate intercompany balances.

#### Solution Overview
The **AP Intercompany Invoice Details** report provides a granular view of intercompany AP invoices, linking them to the corresponding internal supplier and operating unit. It serves as a critical tool for reconciling intercompany balances and verifying transaction details.

#### Key Benefits
- **Faster Reconciliation:** Quickly identify and resolve discrepancies between billing and receiving entities.
- **Audit Trail:** Detailed record of all intercompany AP transactions for audit and tax purposes.
- **Improved Accuracy:** Validates that intercompany invoices are coded to the correct intercompany accounts.
- **Global Visibility:** Supports multi-org and multi-ledger reporting for a holistic view of intercompany exposure.

---

### 2. Functional Analysis

#### Report Purpose
This report extracts detailed information about AP invoices identified as intercompany transactions. It is designed to support the "Payables" side of the intercompany reconciliation process.

#### Key Metrics & Data Points
- **Invoice Header:** Invoice Number, Date, Type, Currency, Amount.
- **Trading Partners:** Buying Operating Unit (OU) vs. Selling Supplier (representing the internal entity).
- **Line Details:** Item description, quantity, unit price, and line amount.
- **Accounting:** Distribution accounts, specifically focusing on intercompany segments.
- **Tax:** Tax codes and amounts applied to the transaction.

#### Intended Audience
- **Intercompany Accountants:** To reconcile AP balances with AR counterparts.
- **Corporate Controllers:** To oversee the elimination of intercompany profit/loss.
- **Tax Managers:** To verify transfer pricing and tax application on internal trades.
- **Shared Service Centers:** To process and validate high volumes of internal invoices.

---

### 3. Technical Analysis

#### Source Tables
The report leverages standard AP tables joined with HR and GL definitions:
- `AP_INVOICES_ALL`: Invoice headers.
- `AP_INVOICE_LINES_ALL`: Invoice lines (items, tax, freight).
- `AP_INVOICE_DISTRIBUTIONS_ALL`: Accounting distributions.
- `AP_SUPPLIERS` & `AP_SUPPLIER_SITES_ALL`: Supplier details (identifying internal suppliers).
- `HR_OPERATING_UNITS`: Organization context.
- `GL_CODE_COMBINATIONS_KFV`: Accounting flexfield segments.

#### Critical Logic
- **Intercompany Identification:** The report typically filters or highlights invoices based on the Supplier Type (e.g., 'INTERCOMPANY') or specific account ranges in the GL distribution.
- **Multi-Org Access:** Uses `MO_GLOBAL` or standard VPD policies to ensure the user sees data across all authorized operating units.
- **Currency Conversion:** May include logic to show amounts in both transaction and functional currencies for reconciliation.

#### Performance Considerations
- **Distribution Volume:** `AP_INVOICE_DISTRIBUTIONS_ALL` can be very large. The report should be filtered by date range (`Accounting Date` or `Invoice Date`) to maintain performance.
- **Joins:** Efficient joins to `GL_CODE_COMBINATIONS` are essential for reporting on account segments.

---

### 4. Implementation Guide

#### Setup Instructions
1. **Deploy SQL:** Import the SQL query into Blitz Report or your preferred tool.
2. **Define Intercompany Logic:** Ensure your suppliers are correctly classified as 'INTERCOMPANY' or that you have a specific account segment for intercompany tracking to effectively use the report filters.
3. **Parameters:**
   - `Ledger/Operating Unit`: Select the scope of the report.
   - `Date Range`: Align with your financial period close cycle.
   - `Supplier`: Filter for specific intercompany trading partners.

#### Usage Scenarios
- **Pre-Close Review:** Run 3 days before month-end to identify unmatched intercompany invoices.
- **Reconciliation Meeting:** Use the output to facilitate discussions between the AP team and the billing entity's AR team.
- **Tax Audit:** Generate a fiscal year dump of all intercompany expenses for transfer pricing documentation.

---

### 5. Frequently Asked Questions (FAQ)

#### Q: How does the report know which invoices are "Intercompany"?
**A:** It typically relies on the Supplier Type setup in AP or specific GL account segments. Ensure your master data is accurate.

#### Q: Can I see the corresponding AR invoice number?
**A:** Standard AP reports don't link directly to the external AR invoice unless it was captured in a specific reference field (e.g., `INVOICE_NUM` usually matches the AR invoice number).

#### Q: Does this include AGIS (Advanced Global Intercompany System) transactions?
**A:** This report focuses on AP Invoices. AGIS transactions that generate AP invoices will be included, but manual AGIS journals might not be, depending on the source.


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
