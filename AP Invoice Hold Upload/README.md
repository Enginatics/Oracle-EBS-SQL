---
layout: default
last_modified_at: 2026-10-19
title: 'AP Invoice Hold Upload | Oracle EBS SQL Report'
description: 'Releases and places AP invoice holds in bulk - the Excel equivalent of the Invoice Workbench Holds tab. Download the open holds with the download…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Invoice, Hold, ap_lookup_codes, ap_holds_all, ap_invoices_all'
permalink: /AP%20Invoice%20Hold%20Upload/
report_name: 'AP Invoice Hold Upload'
report_web_name: ap-invoice-hold-upload
---

# AP Invoice Hold Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-invoice-hold-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload).

## Overview
Releases and places AP invoice holds in bulk - the Excel equivalent of the Invoice Workbench Holds tab.

Download the open holds with the download parameters, pick a Release Name (and optionally overwrite the defaulted Release Reason) on the rows to release, and upload. Each hold row is released through the same Oracle logic as the form, including the invoice holds workflow abort, the hold business event and the E-Business Tax synchronization. To place a new manual hold, add a row with the invoice reference and a Hold Name, leaving the Release Name blank.

Holds are identified by Operating Unit, Invoice Number, Supplier and Hold Name, so rows can also be pasted from an external list instead of downloaded. When an invoice has several open holds of the same name (for example matching holds on different purchase order shipments), the PO Number, PO Line, PO Shipment or Invoice Line columns identify the exact hold.

By default only user releasable holds are downloaded - system holds such as Line Variance or Distribution Variance cannot be released manually and are removed by correcting the invoice and revalidating. Set User Releasable Only to No to review them.

Releasing all holds of an invoice does not submit Invoice Validation - the invoice status is derived by Oracle and updates automatically, exactly as after releasing holds in the form.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Operating Unit, Supplier, Invoice Number, Invoice Date From, Invoice Date To, Hold Name, Hold Date From, Hold Date To, Held By, PO Number, User Releasable Only

## Oracle EBS Tables Used
[ap_lookup_codes](https://www.enginatics.com/library/?pg=1&find=ap_lookup_codes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload), [ap_holds_all](https://www.enginatics.com/library/?pg=1&find=ap_holds_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload), [ap_hold_codes](https://www.enginatics.com/library/?pg=1&find=ap_hold_codes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload)

## Related Reports
[AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [AP Invoice on Hold](/AP%20Invoice%20on%20Hold/ "AP Invoice on Hold Oracle EBS SQL Report"), [PO Procure to Pay Tracker](/PO%20Procure%20to%20Pay%20Tracker/ "PO Procure to Pay Tracker Oracle EBS SQL Report"), [AP Accounted Invoice Aging](/AP%20Accounted%20Invoice%20Aging/ "AP Accounted Invoice Aging Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report"), [AP Invoices and Lines 11i](/AP%20Invoices%20and%20Lines%2011i/ "AP Invoices and Lines 11i Oracle EBS SQL Report"), [CAC Invoice Price Variance](/CAC%20Invoice%20Price%20Variance/ "CAC Invoice Price Variance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Invoice%20Hold%20Upload/AP%20Invoice%20Hold%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ap-invoice-hold-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload) |
| Blitz Report™ XML Import | [AP_Invoice_Hold_Upload.xml](https://www.enginatics.com/xml/ap-invoice-hold-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload) |
| SQL Source | [AP Invoice Hold Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Invoice%20Hold%20Upload/AP%20Invoice%20Hold%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ap-invoice-hold-upload/](https://www.enginatics.com/reports/ap-invoice-hold-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload) |

## Case Study & Technical Analysis: AP Invoice Hold Upload

### Executive Summary
The AP Invoice Hold Upload is a bulk maintenance tool for Oracle Payables invoice holds, the Excel equivalent of the Holds tab in the Invoice Workbench. It is written for accounts payable supervisors and invoice processing teams who must release large numbers of holds after a supplier or matching issue is cleared, or place manual holds on a list of invoices. The download shows the open holds that match the selection parameters, and the user marks the rows to release or adds rows to place new holds, then uploads the file. The report is an R12-only upload in the Payables area of Oracle EBS.

### Business Challenge
*   **Hold backlog:** Invoices held for matching, receipt or manual reasons can accumulate across many suppliers, and releasing them one at a time in the Workbench is slow.
*   **Identifying the right hold:** An invoice can carry several holds of the same name, for example matching holds on different purchase order shipments, so a bulk action must target the exact hold.
*   **Controlled release:** Holds must be released with a recorded release name and reason, and system holds must not be released by hand when they can only be cleared by correcting the invoice.

### The Solution
*   **Open hold extraction:** The report returns open holds, meaning rows in `AP_HOLDS_ALL` with no release lookup code, with the invoice, supplier, site, hold name, reason and hold details.
*   **Precise hold identification:** The PO number, PO line, PO shipment and invoice line columns identify the exact hold when several share a name.
*   **Release and placement in one file:** A Release Name column marks holds for release, and a new row with a Hold Name and no Release Name places a manual hold.

### Technical Architecture (High Level)
#### Primary Tables
*   `AP_HOLDS_ALL`: one row per hold placed on an invoice line, including the release lookup code that identifies open holds.
*   `AP_INVOICES_ALL`: the invoice header, including invoice number, date, amount and currency.
*   `AP_SUPPLIERS`: the supplier name and number.
*   `AP_SUPPLIER_SITES_ALL`: the supplier site for each invoice.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit of the invoice.
*   `AP_HOLD_CODES`: the hold code definitions, including their status and releasability.
*   `AP_LOOKUP_CODES`: the translated hold name and the system user label.
*   `PO_LINE_LOCATIONS_ALL`, `PO_LINES_ALL` and `PO_HEADERS_ALL`: the purchase order references behind matching holds.

#### Logical Relationships
1. `AP_HOLDS_ALL` joins to `AP_INVOICES_ALL` on the invoice identifier, which provides the invoice header for each hold.
2. Invoices join to `AP_SUPPLIERS` and `AP_SUPPLIER_SITES_ALL` through the vendor and vendor site identifiers, using outer joins.
3. Invoices join to `HR_ALL_ORGANIZATION_UNITS_VL` on the organisation identifier to give the operating unit name.
4. Holds join to `AP_HOLD_CODES` and to `AP_LOOKUP_CODES` through the hold lookup code, to give the hold name.
5. Holds join to `PO_LINE_LOCATIONS_ALL`, then to `PO_LINES_ALL` and `PO_HEADERS_ALL`, to give the PO number, line and shipment.
6. Access is restricted to operating units listed in `MO_GLOB_ORG_ACCESS_TMP`.

### Parameters & Filtering
*   **Upload Mode:** Determines whether the file is used to create or update holds.
*   **Operating Unit, Supplier and Invoice Number:** Narrow the download to the invoices of one operating unit, supplier or invoice.
*   **Invoice Date From and Invoice Date To:** Bound the invoice dates of the holds returned.
*   **Hold Date From and Hold Date To:** Bound the date on which each hold was placed.
*   **PO Number:** Limits holds to invoices matched to one purchase order.
*   **User Releasable Only:** When set to Yes, the default, excludes system holds from the download. Setting it to No allows the user to review system holds.

### Performance & Optimization
*   **Open-hold driver:** The first predicate restricts `AP_HOLDS_ALL` to rows with no release lookup code, so the query starts from the open holds rather than from all invoices.
*   **Outer joins for purchase order references:** Purchase order tables are joined with outer joins, so holds that are not matched to a purchase order are still returned.

### FAQ
**Q: How do I release several AP invoice holds at once in Oracle EBS?**
A: Download the holds with AP Invoice Hold Upload, enter a Release Name on the rows to release, and upload the file.

**Q: Why does the download not show all holds on an invoice?**
A: By default only user releasable holds are returned. Set User Releasable Only to No to include system holds such as line variance.

**Q: Does releasing holds through the upload revalidate the invoice?**
A: The description states that releasing holds does not submit Invoice Validation. The invoice status is derived by Oracle and updates automatically, as it does after releasing holds in the form.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-hold-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
