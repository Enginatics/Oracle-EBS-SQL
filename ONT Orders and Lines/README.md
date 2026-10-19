---
layout: default
last_modified_at: 2026-10-19
title: 'ONT Orders and Lines | Oracle EBS SQL Report'
description: 'Detail Sales Order or Quote header report with line item details including status, cost, project and shipping information. Show Sales Credits adds one row…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Order Management, Enginatics, ONT, Orders, Lines, dual, oe_order_sources, po_requisition_headers_all'
permalink: /ONT%20Orders%20and%20Lines/
report_name: 'ONT Orders and Lines'
report_web_name: ont-orders-and-lines
module: 'Order Management'
module_url: /modules/order-management/
---

# ONT Orders and Lines – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ont-orders-and-lines/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines).
**Oracle EBS module:** [Order Management](/modules/order-management/ "Oracle EBS Order Management reports") · [all Order Management reports](/modules/order-management/)  

## Overview
Detail Sales Order or Quote header report with line item details including status, cost, project and shipping information.

Show Sales Credits adds one row per sales credit of each line, taken from the line, or from the order header for lines without sales credits of their own. Credited Amount is the line extended price times the credit percent and is shown once per line and credit, so it can be summed by salesperson; the other amount columns stay on one row per line.

Show Order to Cash Details adds the booked date and open holds of each line, and for the line's latest invoice the due date, the amount still due, the date it was fully paid, the latest receipt applied, and when its final accounting was created and its journal posted in the general ledger. Amount Due Remaining is shown on one row per invoice, so it can be summed. To follow lines until they are paid, leave Open only empty, so that closed orders with unpaid invoices are included.

When India Localization is installed, the following GST columns are also included: GST Registration No, GST PAN No, GST TAN No, CGST Amount, SGST Amount, IGST Amount, CGST Rate, SGST Rate, IGST Rate, Custom Amount, Unclassified Tax Amount, Taxable Value, HSN SAC Code, HSN Length Warning.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Order Number, Quote Number, Customer Name, Account Number, Type, Order Category, Line Category, Order Type, Line Type, Item Type, Open only, Exclude Cancelled, Order Status, Line Status, Exclude Line Status, Item, Category Set 1, Category Set 2, Category Set 3, Shippable Flag, Order Fully/Partially Shipped, Project, Task, Schedule Ship Date From, Schedule Ship Date To, Ship To Country, Bill To Country, Ship From Warehouse, Request Date From, Request Date To, Creation Date From, Creation Date To, Line Creation Date From, Line Creation Date To, Cancelled Date From, Cancelled Date To, Invoice GL Date From, Invoice GL Date To, Intrastat Eligible Only, DIFOT Eligible Only, DFF Display, Show Order to Cash Details, Sales Agreement Number, Show Sales Credits

## Oracle EBS Tables Used
[dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [oe_order_sources](https://www.enginatics.com/library/?pg=1&find=oe_order_sources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [aso_quote_headers_all](https://www.enginatics.com/library/?pg=1&find=aso_quote_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [cs_incidents_all_b](https://www.enginatics.com/library/?pg=1&find=cs_incidents_all_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [qp_list_headers_vl](https://www.enginatics.com/library/?pg=1&find=qp_list_headers_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [oe_price_adjustments](https://www.enginatics.com/library/?pg=1&find=oe_price_adjustments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [ra_terms_vl](https://www.enginatics.com/library/?pg=1&find=ra_terms_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [wsh_carriers_v](https://www.enginatics.com/library/?pg=1&find=wsh_carriers_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [oe_sets](https://www.enginatics.com/library/?pg=1&find=oe_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [jtf_rs_salesreps](https://www.enginatics.com/library/?pg=1&find=jtf_rs_salesreps&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [jtf_rs_resource_extns_vl](https://www.enginatics.com/library/?pg=1&find=jtf_rs_resource_extns_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [pjm_seiban_numbers](https://www.enginatics.com/library/?pg=1&find=pjm_seiban_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [ra_cust_trx_types_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [ra_cust_trx_line_gl_dist_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_line_gl_dist_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [oe_order_lines_history](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_history&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [oe_reasons](https://www.enginatics.com/library/?pg=1&find=oe_reasons&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [wsh_delivery_details](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [wsh_delivery_assignments](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [wsh_new_deliveries](https://www.enginatics.com/library/?pg=1&find=wsh_new_deliveries&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines)

## Related Reports
[ONT Orders](/ONT%20Orders/ "ONT Orders Oracle EBS SQL Report"), [PPF_WP3_OM_DETAILS](/PPF_WP3_OM_DETAILS/ "PPF_WP3_OM_DETAILS Oracle EBS SQL Report"), [ONT Orders and Lines 11i](/ONT%20Orders%20and%20Lines%2011i/ "ONT Orders and Lines 11i Oracle EBS SQL Report"), [ONT Order Upload](/ONT%20Order%20Upload/ "ONT Order Upload Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [AR Transactions and Lines 11i](/AR%20Transactions%20and%20Lines%2011i/ "AR Transactions and Lines 11i Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ONT%20Orders%20and%20Lines/ONT%20Orders%20and%20Lines.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [ONT Orders and Lines - DIFOT Template 11-Oct-2022 033132.xlsm](https://www.enginatics.com/example/ont-orders-and-lines/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines) |
| Blitz Report™ XML Import | [ONT_Orders_and_Lines.xml](https://www.enginatics.com/xml/ont-orders-and-lines/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines) |
| SQL Source | [ONT Orders and Lines.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ONT%20Orders%20and%20Lines/ONT%20Orders%20and%20Lines.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ont-orders-and-lines/](https://www.enginatics.com/reports/ont-orders-and-lines/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines) |

## Case Study: End-to-End Order Fulfillment Visibility in Oracle Order Management

### Executive Summary
The **ONT Orders and Lines** report is a comprehensive operational dashboard for the Order-to-Cash (O2C) cycle. It breaks down silos between sales, shipping, and finance by providing a single, flattened view of a sales order—from the initial booking of the header to the status of individual lines, shipping deliveries, and final invoicing.

### Business Challenge
Managing the order lifecycle in Oracle EBS often requires navigating multiple screens (Order Organizer, Shipping Transactions, Invoice Status). This fragmentation leads to:
*   **Customer Service Delays:** Agents cannot quickly answer "Where is my order?" without checking multiple modules.
*   **Revenue Leakage:** Shipped lines that fail to interface to AR for invoicing ("Unbilled Receivables") can go unnoticed.
*   **Backlog Management:** Difficulty in distinguishing between "Booked" orders that are awaiting stock and "Awaiting Shipping" orders that are stuck in the warehouse.
*   **Performance Tracking:** Challenges in measuring On-Time Delivery (OTD) or DIFOT (Delivery In Full, On Time) metrics.

### The Solution
This report consolidates the entire lifecycle of a sales order line into a single row of data. It is designed to be the "one version of the truth" for Sales Operations, Logistics, and Accounts Receivable.

#### Key Features
*   **Granular Status Tracking:** Displays the flow status of the line (e.g., `AWAITING_SHIPPING`, `SHIPPED`, `CLOSED`, `CANCELLED`).
*   **Shipping Details:** Includes Delivery Name, Waybill, Carrier, and Actual Ship Date for logistics tracking.
*   **Financial Integration:** Shows the Invoice Number and Invoice Date if the line has been billed, linking OM to AR.
*   **Holds Visibility:** Identifies any credit holds or process holds preventing the order from progressing.

### Technical Architecture
The report queries the core Order Management tables and joins them to Shipping (WSH) and Receivables (RA) to build the complete picture.

#### Critical Tables
*   `OE_ORDER_HEADERS_ALL`: Contains order-level info (Customer, Order Type, Currency).
*   `OE_ORDER_LINES_ALL`: The heart of the report, containing item, quantity, price, and flow status.
*   `WSH_DELIVERY_DETAILS`: Provides the link to the shipping execution system (Pick Release, Ship Confirm).
*   `RA_CUSTOMER_TRX_LINES_ALL`: Links the order line to the generated AR invoice line.
*   `MTL_SYSTEM_ITEMS_B`: Provides item descriptions and attributes (e.g., weight, volume).

#### Key Parameters
*   **Order Number:** Search for a specific sales order.
*   **Customer Name:** Analyze the backlog or history for a specific client.
*   **Line Status:** Filter for `AWAITING_SHIPPING` to generate a pick list or `SHIPPED` to verify revenue recognition.
*   **Date Ranges:** Filter by Ordered Date, Request Date, or Actual Ship Date for period-based reporting.

### Functional Analysis
#### Use Cases
1.  **Backlog Analysis:** Sales managers run the report filtering for "Open" lines to understand the value of the current order book.
2.  **Revenue Assurance:** Finance users filter for lines where `Flow Status = CLOSED` but `Invoice Number` is NULL to find unbilled shipments.
3.  **Logistics Planning:** Warehouse managers use the report to see upcoming `Request Dates` to plan labor and carrier capacity.

#### FAQ
**Q: Does this report include cancelled lines?**
A: Yes, the report typically includes a parameter to `Exclude Cancelled` lines, but they can be included to analyze lost demand.

**Q: Can I see the tracking number?**
A: Yes, if the Waybill/Tracking number is entered in the Shipping Transactions form, it will appear in the report output.

**Q: How does it handle split lines?**
A: Split lines (e.g., Line 1.1, 1.2) are treated as individual rows, allowing for accurate tracking of partial shipments.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
