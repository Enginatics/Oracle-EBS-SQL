---
layout: default
title: 'ONT Orders and Lines | Oracle EBS SQL Report'
description: 'Detail Sales Order or Quote header report with line item details including status, cost, project and shipping information.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Nidec changes, R12 only, ONT, Orders, Lines, dual, oe_order_sources, po_requisition_headers_all'
permalink: /ONT%20Orders%20and%20Lines/
---

# ONT Orders and Lines – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ont-orders-and-lines/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Detail Sales Order or Quote header report with line item details including status, cost, project and shipping information.

## Report Parameters
Operating Unit, Order Number, Quote Number, Customer Name, Account Number, Type, Order Category, Line Category, Order Type, Line Type, Item Type, Open only, Exclude Cancelled, Order Status, Line Status, Item, Category Set 1, Category Set 2, Category Set 3, Shippable Flag, Order Fully/Partially Shipped, Project, Task, Schedule Ship Date From, Schedule Ship Date To, Ship To Country, Bill To Country, Ship From Warehouse, Request Date From, Request Date To, Creation Date From, Creation Date To, Line Creation Date From, Line Creation Date To, Cancelled Date From, Cancelled Date To, Invoice GL Date From, Invoice GL Date To, Intrastat Eligible Only, DIFOT Eligible Only, Show DFF Attributes

## Oracle EBS Tables Used
[dual](https://www.enginatics.com/library/?pg=1&find=dual), [oe_order_sources](https://www.enginatics.com/library/?pg=1&find=oe_order_sources), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all), [aso_quote_headers_all](https://www.enginatics.com/library/?pg=1&find=aso_quote_headers_all), [cs_incidents_all_b](https://www.enginatics.com/library/?pg=1&find=cs_incidents_all_b), [qp_list_headers_vl](https://www.enginatics.com/library/?pg=1&find=qp_list_headers_vl), [oe_price_adjustments](https://www.enginatics.com/library/?pg=1&find=oe_price_adjustments), [ra_terms_vl](https://www.enginatics.com/library/?pg=1&find=ra_terms_vl), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Nidec changes](https://www.enginatics.com/library/?pg=1&category[]=Nidec%20changes), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [ONT Orders and Lines - DIFOT Template 11-Oct-2022 033132.xlsm](https://www.enginatics.com/example/ont-orders-and-lines/) |
| Blitz Report™ XML Import | [ONT_Orders_and_Lines.xml](https://www.enginatics.com/xml/ont-orders-and-lines/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ont-orders-and-lines/](https://www.enginatics.com/reports/ont-orders-and-lines/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
