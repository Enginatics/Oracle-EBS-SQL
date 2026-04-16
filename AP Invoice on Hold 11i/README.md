---
layout: default
title: 'AP Invoice on Hold 11i | Oracle EBS SQL Report'
description: 'Based on Oracle standard Invoice on Hold report Source: Invoice on Hold Report (XML) Short Name: APXINROHXML'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Invoice, Hold, 11i, gl_period_statuses, po_line_locations, po_headers'
permalink: /AP%20Invoice%20on%20Hold%2011i/
---

# AP Invoice on Hold 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-invoice-on-hold-11i/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Based on Oracle standard Invoice on Hold report
Source: Invoice on Hold Report (XML)
Short Name: APXINROH_XML

## Report Parameters
Operating Unit, Hold Name, Vendor, Order By, Entered Date From, Entered Date To, Due Date From, Due Date To, Discount Date From, Discount Date To

## Oracle EBS Tables Used
[gl_period_statuses](https://www.enginatics.com/library/?pg=1&find=gl_period_statuses), [po_line_locations](https://www.enginatics.com/library/?pg=1&find=po_line_locations), [po_headers](https://www.enginatics.com/library/?pg=1&find=po_headers), [ap_invoice_payments_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_payments_all), [ap_checks_all](https://www.enginatics.com/library/?pg=1&find=ap_checks_all), [ap_invoice_distributions](https://www.enginatics.com/library/?pg=1&find=ap_invoice_distributions), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors), [po_vendor_sites](https://www.enginatics.com/library/?pg=1&find=po_vendor_sites), [ap_invoices](https://www.enginatics.com/library/?pg=1&find=ap_invoices), [ap_batches_all](https://www.enginatics.com/library/?pg=1&find=ap_batches_all), [ap_payment_schedules](https://www.enginatics.com/library/?pg=1&find=ap_payment_schedules), [ap_holds](https://www.enginatics.com/library/?pg=1&find=ap_holds), [ap_hold_codes](https://www.enginatics.com/library/?pg=1&find=ap_hold_codes), [ap_lookup_codes](https://www.enginatics.com/library/?pg=1&find=ap_lookup_codes), [fnd_currencies_vl](https://www.enginatics.com/library/?pg=1&find=fnd_currencies_vl), [po_distributions](https://www.enginatics.com/library/?pg=1&find=po_distributions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[GL Budget Amounts Upload](/GL%20Budget%20Amounts%20Upload/ "GL Budget Amounts Upload Oracle EBS SQL Report"), [GL Periods](/GL%20Periods/ "GL Periods Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [GL Balance by Account Hierarchy](/GL%20Balance%20by%20Account%20Hierarchy/ "GL Balance by Account Hierarchy Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AP Invoice on Hold 11i - Pivot Summary By Hold Name, Vendor 26-Aug-2024 091538.xlsx](https://www.enginatics.com/example/ap-invoice-on-hold-11i/) |
| Blitz Report™ XML Import | [AP_Invoice_on_Hold_11i.xml](https://www.enginatics.com/xml/ap-invoice-on-hold-11i/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ap-invoice-on-hold-11i/](https://www.enginatics.com/reports/ap-invoice-on-hold-11i/) |

## Case Study & Technical Analysis: AP Invoice on Hold

### Executive Summary
The **AP Invoice on Hold** report provides a comprehensive and real-time view of all supplier invoices currently placed on hold within the Oracle Payables module. This report is a critical tool for Accounts Payable (AP) Managers and Financial Controllers to identify process bottlenecks, prevent payment delays, and maintain healthy supplier relationships. By aggregating hold data into a single operational view, it enables rapid resolution of disputes and processing errors.

### Business Challenge
In many organizations, invoices get stuck in the payment process due to various reasons such as price variances, quantity discrepancies, or missing documentation.
*   **Lack of Visibility:** Standard Oracle forms require checking invoices one by one or running static PDF reports that are hard to analyze.
*   **Operational Inefficiency:** AP clerks often spend hours manually compiling lists of problem invoices to distribute to purchasing or receiving departments for resolution.
*   **Financial Risk:** Unresolved holds lead to late payment penalties, lost early payment discounts, and potential credit holds placed by suppliers, disrupting the supply chain.

### The Solution
This report solves these challenges by providing a direct **Operational View** of all active holds.
*   **Proactive Management:** Users can instantly see which invoices are stopped and why (e.g., "Qty Rec vs Inv", "Max Qty Rec").
*   **Targeted Resolution:** The report allows filtering by "Hold Name" or "Trading Partner," enabling teams to tackle high-priority issues or specific systemic problems first.
*   **Enhanced Detail:** Unlike standard summaries, this report links the hold directly to invoice details, allowing for immediate investigation without navigating through multiple Oracle screens.

### Technical Architecture (High Level)
The report extracts data primarily from the Oracle Payables (AP) module, linking invoice headers to their specific hold details.

*   **Primary Tables:**
    *   `AP_INVOICES_ALL`: Contains the invoice header information (Invoice Number, Date, Amount).
    *   `AP_HOLDS_ALL`: Stores the specific hold details linked to the invoice.
    *   `AP_SUPPLIERS` / `AP_SUPPLIER_SITES_ALL`: Provides vendor master data.
    *   `PO_HEADERS_ALL`: (Optional join) Links to the Purchase Order if the invoice is matched.
*   **Logical Relationships:**
    *   The core join is between `AP_INVOICES_ALL` and `AP_HOLDS_ALL` on `INVOICE_ID`.
    *   Supplier information is retrieved by joining `VENDOR_ID` and `VENDOR_SITE_ID`.
    *   Lookup codes (`AP_LOOKUP_CODES`) are used to translate system codes into user-friendly descriptions.

### Parameters & Filtering
The report includes robust parameters to help users slice the data effectively:
*   **Operating Unit:** Segregates data by business entity for multi-org environments.
*   **Hold Name:** Allows users to filter for specific types of holds (e.g., filter only for "Price Variance" to route to the Purchasing team).
*   **Trading Partner:** Enables viewing all holds for a specific critical supplier.
*   **Date Ranges (Entered, Due, Discount):** Critical for prioritizing invoices that are approaching their due date or discount expiration.

### Performance & Optimization
*   **Direct Extraction:** The report uses direct SQL extraction, bypassing the overhead of XML parsing often found in standard Oracle BI Publisher reports.
*   **Indexing:** The query is optimized to utilize standard Oracle indexes on `INVOICE_DATE`, `VENDOR_ID`, and `ORG_ID`, ensuring fast execution even with large volumes of historical data.
*   **Selective Joins:** Joins to heavy tables like `PO_HEADERS_ALL` are typically handled efficiently to avoid Cartesian products or performance drags.

### FAQ
**Q: Does this report show holds that have already been released?**
A: Typically, "Invoice on Hold" reports focus on *active* holds that require attention. However, depending on the specific parameter selection (e.g., if a "Release Date" filter is available or ignored), it may show historical holds. The primary business use case is for active issues.

**Q: Can I see who placed the hold?**
A: Yes, the underlying `AP_HOLDS_ALL` table contains `HELD_BY` information (User ID). This report can be configured to display the username of the person or system process that applied the hold.

**Q: Why do I see multiple lines for the same invoice?**
A: An invoice can have multiple holds applied to it simultaneously (e.g., a Price Hold and a Qty Hold). This report will typically list each hold as a separate line item to ensure all reasons are visible and addressed.


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
