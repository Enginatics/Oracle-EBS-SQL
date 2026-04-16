---
layout: default
title: 'AP Invoice Audit Listing | Oracle EBS SQL Report'
description: 'Imported Oracle standard ''Invoice Audit Listing'' report Application: Payables Source: Invoice Audit Listing Short Name: APXINLST'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Invoice, Audit, Listing, hr_all_organization_units_vl, ap_invoices_all, ap_suppliers'
permalink: /AP%20Invoice%20Audit%20Listing/
---

# AP Invoice Audit Listing – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-invoice-audit-listing/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported Oracle standard 'Invoice Audit Listing' report
Application: Payables
Source: Invoice Audit Listing
Short Name: APXINLST

## Report Parameters
Operating Unit, Minimum Invoice Amount, Begin Invoice Date, Invoice Type

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AP Suppliers](/AP%20Suppliers/ "AP Suppliers Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AP Invoice Audit Listing 03-Jan-2022 100708.xlsx](https://www.enginatics.com/example/ap-invoice-audit-listing/) |
| Blitz Report™ XML Import | [AP_Invoice_Audit_Listing.xml](https://www.enginatics.com/xml/ap-invoice-audit-listing/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ap-invoice-audit-listing/](https://www.enginatics.com/reports/ap-invoice-audit-listing/) |

## Case Study & Technical Analysis: AP Invoice Audit Listing

### 1. Executive Summary

#### Business Problem
Maintaining the integrity of the Accounts Payable process is crucial for preventing fraud, duplicate payments, and data entry errors. Organizations often struggle with:
- **Duplicate Invoices:** Risk of paying the same invoice twice due to data entry variations.
- **Incomplete Data:** Invoices entered without proper validation or missing critical fields.
- **Audit Compliance:** Difficulty in producing a clean, comprehensive list of invoices for external auditors.
- **Process Gaps:** Lack of visibility into invoices that bypass standard validation rules.

#### Solution Overview
The **AP Invoice Audit Listing** is a direct import of the standard Oracle "Invoice Audit Listing" report. It provides a detailed register of invoices entered within a specific period, highlighting potential issues and serving as a primary source for AP auditing.

#### Key Benefits
- **Fraud Prevention:** Helps identify irregularities in invoice entry, such as duplicate numbers or suspicious amounts.
- **Data Quality:** Highlights invoices with missing or inconsistent data.
- **Audit Trail:** Serves as a fundamental document for internal and external financial audits.
- **Operational Control:** Allows AP managers to review the volume and quality of invoice entry by the team.

---

### 2. Functional Analysis

#### Report Purpose
This report lists invoices entered in the system, providing a snapshot of the AP liability. It is often used to verify that all physical invoices received have been correctly entered into Oracle Payables.

#### Key Metrics & Data Points
- **Invoice Header:** Invoice Number, Date, Amount, Currency, Type (Standard, Credit Memo, etc.).
- **Supplier Details:** Supplier Name and Site.
- **Entry Details:** Who entered the invoice and when.
- **Status:** Validation status (Validated, Needs Revalidation, etc.).

#### Intended Audience
- **AP Managers:** To review daily or weekly invoice entry volume and accuracy.
- **Internal Auditors:** To sample invoices for compliance testing.
- **External Auditors:** To verify the completeness of the AP subledger.

---

### 3. Technical Analysis

#### Source Tables
The report is based on the standard Oracle report `APXINLST` and queries the core AP tables:
- `AP_INVOICES_ALL`: The primary source of invoice header data.
- `AP_SUPPLIERS`: Supplier master data.
- `HZ_PARTIES`: Party information linked to suppliers.
- `HR_ALL_ORGANIZATION_UNITS_VL`: Operating unit definitions.

#### Critical Logic
- **Standard Oracle Logic:** As an imported standard report, it follows the exact logic of the Oracle `APXINLST` concurrent program.
- **Filtering:** It filters primarily by `Operating Unit`, `Invoice Date`, and `Invoice Amount`.
- **Sorting:** The output is typically sorted by Supplier and then Invoice Number to facilitate manual checking.

#### Performance Considerations
- **Date Range:** The report is optimized for date-based queries. Running it for a very wide date range without other filters may impact performance.
- **Indexing:** Standard indexes on `AP_INVOICES_ALL` (like `INVOICE_DATE`, `VENDOR_ID`) support this report's query path.

---

### 4. Implementation Guide

#### Setup Instructions
1. **Deploy SQL:** Use the provided SQL to create the report in Blitz Report.
2. **Parameters:**
   - `Operating Unit`: Mandatory for multi-org environments.
   - `Begin Invoice Date`: To define the audit period.
   - `Minimum Invoice Amount`: Optional filter to focus on high-value transactions.
   - `Invoice Type`: To filter for specific types like 'Standard' or 'Credit Memo'.

#### Usage Scenarios
- **Weekly Audit:** Run every Friday to review the week's invoice entries.
- **High-Value Check:** Run with a minimum amount filter (e.g., > $10,000) to scrutinize large liabilities.
- **Duplicate Check:** Export to Excel and use conditional formatting to highlight potential duplicate invoice numbers or amounts.

---

### 5. Frequently Asked Questions (FAQ)

#### Q: Is this different from the "Invoice Register"?
**A:** Yes, the Invoice Register is typically more detailed, showing line items and distributions. The Audit Listing is often more focused on the header level for a quick scan of entered invoices.

#### Q: Can I see who approved the invoice?
**A:** This specific report focuses on *entry* and *audit* details. For approval history, the "AP Invoice Approval Status" report is more appropriate.

#### Q: Does it show cancelled invoices?
**A:** It depends on the parameters and the specific SQL implementation, but standard audit listings often include all invoices to ensure a complete sequence check.


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
