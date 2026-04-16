---
layout: default
title: 'ONT Orders | Oracle EBS SQL Report'
description: 'Detail Sales Order or Quote header report, including status, amount and invoice status information.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, ONT, Orders, dual, oe_order_sources, po_requisition_headers_all'
permalink: /ONT%20Orders/
---

# ONT Orders – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ont-orders/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Detail Sales Order or Quote header report, including status, amount and invoice status information.

## Report Parameters
Operating Unit, Order Number, Quote Number, Customer Name, Account Number, Type, Order Category, Order Type, Line Type, Open only, Exclude Cancelled, Order Status, Schedule Ship Date From, Schedule Ship Date To, Ship To Country, Bill To Country, Ship From Warehouse, Request Date From, Request Date To, Creation Date From, Creation Date To, Invoice GL Date From, Invoice GL Date To

## Oracle EBS Tables Used
[dual](https://www.enginatics.com/library/?pg=1&find=dual), [oe_order_sources](https://www.enginatics.com/library/?pg=1&find=oe_order_sources), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all), [aso_quote_headers_all](https://www.enginatics.com/library/?pg=1&find=aso_quote_headers_all), [cs_incidents_all_b](https://www.enginatics.com/library/?pg=1&find=cs_incidents_all_b), [qp_list_headers_vl](https://www.enginatics.com/library/?pg=1&find=qp_list_headers_vl), [oe_price_adjustments](https://www.enginatics.com/library/?pg=1&find=oe_price_adjustments), [ra_terms_vl](https://www.enginatics.com/library/?pg=1&find=ra_terms_vl), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all), [ra_cust_trx_line_gl_dist_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_line_gl_dist_all), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [jtf_rs_salesreps](https://www.enginatics.com/library/?pg=1&find=jtf_rs_salesreps), [jtf_rs_resource_extns_vl](https://www.enginatics.com/library/?pg=1&find=jtf_rs_resource_extns_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Inventory Accounts Setup](/CAC%20Inventory%20Accounts%20Setup/ "CAC Inventory Accounts Setup Oracle EBS SQL Report"), [INV Item Attribute Master/Child Conflicts](/INV%20Item%20Attribute%20Master-Child%20Conflicts/ "INV Item Attribute Master/Child Conflicts Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA Blitz Report ORDS Configuration](/DBA%20Blitz%20Report%20ORDS%20Configuration/ "DBA Blitz Report ORDS Configuration Oracle EBS SQL Report"), [ECC Admin - Concurrent Programs](/ECC%20Admin%20-%20Concurrent%20Programs/ "ECC Admin - Concurrent Programs Oracle EBS SQL Report"), [CAC Cost Group Accounts Setup](/CAC%20Cost%20Group%20Accounts%20Setup/ "CAC Cost Group Accounts Setup Oracle EBS SQL Report"), [OPM Reconcilation](/OPM%20Reconcilation/ "OPM Reconcilation Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [ONT Orders 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/ont-orders/) |
| Blitz Report™ XML Import | [ONT_Orders.xml](https://www.enginatics.com/xml/ont-orders/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ont-orders/](https://www.enginatics.com/reports/ont-orders/) |

## Case Study & Technical Analysis: ONT Orders Report

### Executive Summary

The ONT Orders report provides a powerful, high-level summary of sales orders and quotes within Oracle E-Business Suite. Designed for sales managers, executives, and financial analysts, this report delivers a concise yet comprehensive view of order header information, including status, amounts, and invoicing progress. It serves as an essential tool for monitoring the sales pipeline, analyzing sales performance, and tracking the order-to-cash lifecycle at a summary level.

### Business Challenge

While detailed line-item reports are necessary for operational staff, managers and analysts often need a summary-level view to quickly assess business activity. Accessing this information in a standard EBS environment can be surprisingly difficult. Key challenges include:

-   **Information Overload:** Standard order reports are often too granular, forcing managers to sift through line-level details to understand the overall status of an order.
-   **Difficulty Tracking Quotes:** Monitoring the pipeline of open sales quotes and their conversion rate to orders is often a disconnected, manual process.
-   **Poor Visibility of Billing Status:** It can be difficult to get a quick answer to "Which of last month's orders have been fully invoiced?" without running complex, multi-module reports.
-   **Inflexible Reporting:** Creating a simple summary report of open orders for a specific customer or date range is not straightforward with standard tools.

### The Solution

The ONT Orders report addresses these challenges by providing a flexible, header-level summary that allows users to quickly gauge sales activity.

-   **Consolidated Order & Quote View:** The report can display both sales orders and quotes in a single output, providing a complete view of the sales pipeline from initial quote to final invoice.
-   **At-a-Glance Status Tracking:** It provides key status indicators, such as the order status (Entered, Booked) and invoice status, allowing managers to quickly identify where an order is in its lifecycle.
-   **Powerful, Summarized Analysis:** With extensive parameters, users can create summarized views of the order book by customer, date range, order type, or status, making it ideal for sales meetings and performance reviews.
-   **Actionable Filtering:** Critical parameters like "Open only" and "Exclude Cancelled" allow users to instantly focus on the active and relevant order book, filtering out the noise of closed or cancelled transactions.

### Technical Architecture (High Level)

The report is built on a direct SQL query that efficiently joins header-level tables from across the sales and billing modules.

-   **Primary Tables Involved:**
    -   `oe_order_headers_all` (the central table for sales order headers)
    -   `aso_quote_headers_all` (for sales quote header information)
    -   `hz_cust_accounts` and `hz_parties` (for customer details)
    -   `oe_transaction_types_tl` (to display the order or quote type)
    -   `ra_customer_trx_all` (queried to determine the invoicing status of the order)
    -   `oe_order_lines_all` (used in aggregate to calculate the total order amount)
-   **Logical Relationships:** The report selects key header data from `oe_order_headers_all` and optionally from `aso_quote_headers_all`. It enriches this data with customer information and then checks for the existence of related invoices in Oracle Receivables to determine the billing status.

### Parameters & Filtering

The report offers a rich set of parameters to tailor the output to specific analytical needs:

-   **Transaction Type:** Users can choose to view Orders, Quotes, or both.
-   **Customer and Order Details:** Filter by a specific Customer, Account Number, Order Number, or Order Type.
-   **Status Filters:** Key parameters like `Open only` and `Exclude Cancelled` allow for precise control over the dataset.
-   **Multiple Date Ranges:** The ability to filter on Creation Date, Schedule Ship Date, Request Date, or Invoice GL Date provides exceptional flexibility for trend analysis.

### Performance & Optimization

The report is designed to return summary data quickly, even in high-volume sales environments.

-   **Header-Level Focus:** By primarily querying the `oe_order_headers_all` table, which has significantly fewer records than the lines table, the report can aggregate and retrieve data very quickly.
-   **Efficient Joins and Indexes:** The query uses standard Oracle indexes on key fields like `order_number`, `sold_to_org_id`, and various date fields to ensure optimal performance.

### FAQ

**1. What is the difference between an 'Order' and a 'Quote' in this report's output?**
   A 'Quote' represents a potential sale that has not yet been converted into a firm customer order. An 'Order' is a confirmed sales transaction that is progressing through the fulfillment and billing cycle. This report can show both, allowing you to track the conversion of quotes to orders.

**2. How is the 'invoice status' for an order determined?**
   The report typically determines the invoice status by checking in Oracle Receivables (`ra_customer_trx_all`) to see if an invoice has been created that references the sales order. It may show statuses like 'Uninvoiced', 'Partially Invoiced', or 'Fully Invoiced' based on this lookup.

**3. Does the report's order amount include taxes and freight charges?**
   This often depends on the specific configuration of the report. Typically, the primary amount shown is the sum of the line-item totals (the subtotal). Taxes and freight charges, which are often calculated later in the process, may be in separate columns or excluded from the main order amount for simplicity.


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
