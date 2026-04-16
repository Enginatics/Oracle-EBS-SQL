---
layout: default
title: 'AP Matched and Modified Receipts | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Description: Matched and Modified Receipts Report Application: Payables Source: Matched and Modified Receipts Report (XML) -…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Matched, Modified, Receipts, ap_invoices_all, ap_invoice_lines_all, po_vendors'
permalink: /AP%20Matched%20and%20Modified%20Receipts/
---

# AP Matched and Modified Receipts – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-matched-and-modified-receipts/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from BI Publisher
Description: Matched and Modified Receipts Report
Application: Payables
Source: Matched and Modified Receipts Report (XML) - Not Supported: Reserved For Future Use
Short Name: APXMTMRR_XML
DB package: AP_APXMTMRR_XMLP_PKG

## Report Parameters
Operating Unit, Supplier Name, Supplier Site, Receipt Modify Date From, Receipt Modify Date To, Invoice Status

## Oracle EBS Tables Used
[ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all), [ap_invoice_lines_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_lines_all), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors), [po_vendor_sites_all](https://www.enginatics.com/library/?pg=1&find=po_vendor_sites_all), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers), [rcv_shipment_lines](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_lines), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions), [ap_lookup_codes](https://www.enginatics.com/library/?pg=1&find=ap_lookup_codes), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[AP Invoice Upload 11i](/AP%20Invoice%20Upload%2011i/ "AP Invoice Upload 11i Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AP Matched and Modified Receipts 16-Jul-2024 081411.xlsx](https://www.enginatics.com/example/ap-matched-and-modified-receipts/) |
| Blitz Report™ XML Import | [AP_Matched_and_Modified_Receipts.xml](https://www.enginatics.com/xml/ap-matched-and-modified-receipts/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ap-matched-and-modified-receipts/](https://www.enginatics.com/reports/ap-matched-and-modified-receipts/) |

## Case Study & Technical Analysis: AP Matched and Modified Receipts

### 1. Executive Summary

#### Business Problem
In a high-volume Accounts Payable environment, the "Three-Way Match" (PO, Receipt, Invoice) is the gold standard for control. However, operational reality often complicates this: warehouse staff may adjust a receipt (e.g., correct a quantity error or process a return) *after* the AP team has already matched an invoice to that receipt. This sequence of events creates "Matched and Modified" exceptions, leading to:
*   **Invoice Holds:** Invoices suddenly reverting to "Quantity Variance" holds.
*   **Accrual Imbalances:** The General Ledger accrual account remaining open because the receipt and invoice no longer net to zero.
*   **Overpayment Risk:** Paying for goods that were subsequently returned or adjusted down.

#### Solution Overview
The **AP Matched and Modified Receipts** report is a specialized audit tool designed to detect these specific timing conflicts. It identifies receipts that have been matched to an AP invoice but were subsequently modified within a specified date range. This allows the AP and Purchasing departments to proactively identify discrepancies before they become month-end reconciliation nightmares.

#### Key Benefits
*   **Proactive Variance Detection:** Catch receipt changes that impact already-processed invoices.
*   **Hold Resolution:** Quickly identify the root cause of "Qty Rec" holds that appear on previously valid invoices.
*   **Vendor Compliance:** Monitor suppliers or internal processes that frequently require retroactive receipt adjustments.

### 2. Technical Analysis

#### Core Tables and Views
The report relies on the intersection of Payables and Receiving history:
*   **`AP_INVOICES_ALL` / `AP_INVOICE_LINES_ALL`**: Identifies the invoice and the specific line matched to a receipt (`MATCH_TYPE` = 'ITEM_TO_RECEIPT').
*   **`RCV_TRANSACTIONS`**: The source of truth for receipt history. It tracks the original receipt (`TRANSACTION_TYPE` = 'RECEIVE') and any subsequent corrections or returns (`CORRECT`, `RETURN TO VENDOR`).
*   **`RCV_SHIPMENT_HEADERS` / `RCV_SHIPMENT_LINES`**: Provides context about the shipment and receipt numbers.
*   **`PO_VENDORS`**: Supplier master data.

#### SQL Logic and Data Flow
The logic focuses on the temporal relationship between the Invoice Match and the Receipt Modification.
*   **Match Identification:** The query selects invoice lines where `RCV_TRANSACTION_ID` is populated, establishing the link to Receiving.
*   **Modification Filter:** It filters for `RCV_TRANSACTIONS` (or related history tables) where the `LAST_UPDATE_DATE` falls within the user-specified "Receipt Modify Date" range.
*   **Status Check:** It often includes logic to check the current status of the invoice (`AP_INVOICES_ALL.STATUS`) to prioritize those that are currently blocked or require re-validation.

#### Integration Points
*   **Inventory/Receiving:** This report is essentially a quality control check on the Receiving process.
*   **Payables:** It directly impacts the "Invoice Validation" workflow.

### 3. Functional Capabilities

#### Parameters & Filtering
*   **Receipt Modify Date From/To:** The primary filter. Users should run this for the current period to catch recent changes.
*   **Supplier Name:** Filter for specific vendors known for shipping errors or returns.
*   **Invoice Status:** Allows users to focus on 'Validated' invoices (which might need to be cancelled/adjusted) or 'Needs Revalidation' invoices (which are already on hold).

#### Performance & Optimization
*   **Date-Driven:** By filtering on modification dates, the report limits the dataset to active operational windows, ensuring fast execution even in databases with millions of historical receipts.

### 4. FAQ

**Q: What constitutes a "Modified" receipt?**
A: A modification includes any transaction that alters the net quantity received, such as a "Correction" (positive or negative) or a "Return to Vendor" transaction that occurs after the initial receipt.

**Q: Why does the report show invoices that are already paid?**
A: If a receipt is modified *after* payment (e.g., a late return), the invoice will still appear. This is critical, as it indicates a potential overpayment that requires a Debit Memo to recover funds.

**Q: Does this report fix the data?**
A: No, it is a reporting tool only. Correcting the issue usually involves issuing a Credit/Debit memo in AP or correcting the receipt in Inventory, depending on the physical reality of the goods.


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
