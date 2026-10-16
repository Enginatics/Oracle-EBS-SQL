---
layout: default
last_modified_at: 2026-10-16
title: 'WSH Shipping/Delivery Transactions | Oracle EBS SQL Report'
description: 'This report provides details of Warehouse Shipping Transactions and Deliveries. To review details of deliveries only, set the Assigned to Delivery…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Shipping Execution, Enginatics, WSH, Shipping/Delivery, Transactions, wsh_delivery_legs, wsh_trip_stops, wsh_trips'
permalink: /WSH%20Shipping-Delivery%20Transactions/
report_name: 'WSH Shipping/Delivery Transactions'
report_web_name: wsh-shipping-delivery-transactions
module: 'Shipping Execution'
module_url: /modules/shipping-execution/
---

# WSH Shipping/Delivery Transactions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/wsh-shipping-delivery-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions).
**Oracle EBS module:** [Shipping Execution](/modules/shipping-execution/ "Oracle EBS Shipping Execution reports") · [all Shipping Execution reports](/modules/shipping-execution/)  

## Overview
This report provides details of Warehouse Shipping Transactions and Deliveries.

To review details of deliveries only, set the Assigned to Delivery Parameter = 'Yes'
To review details of shipping transaction not yet assigned to a delivery, set the Assigned to Delivery Parameter = 'No'
Set the parameter to null to review all shipping transations regardless of delivery assignment status.


When India Localization is installed, the following GST columns are also included: GST Registration No, GST PAN No, CGST Amount, SGST Amount, IGST Amount, CESS Amount, Custom Amount, Unclassified Tax Amount, Taxable Value, HSN Length Warning, CGST Rate, SGST Rate, IGST Rate, CESS Rate, CGST Recoverable, CGST Non-Recoverable, SGST Recoverable, SGST Non-Recoverable, IGST Recoverable, IGST Non-Recoverable, Reverse Charge Flag, Place of Supply, Ship From State, HSN SAC Code.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Selling Operating Unit, Shipping Operating Unit, Organization Code, Assigned to Delivery, Delivery Status, Exclude Delivery Status, Release status, Exclude Release Status, Exception Exists, Customer Name, Customer Number, Delivery Note From, Delivery Note To, Item, Item From, Item To, Category Set 1, Category Set 2, Category Set 3, Lot Number, Lot Number From, Lot Number To, Order Number From, Order Number To, Scheduled Date From, Scheduled Date To, Released Date From, Released Date To, Actual Shipment Date From, Actual Shipment Date To, Invoiced Date From, Invoiced Date To, Initial Pick Up Date From, Initial Pick Up Date To, Ultimate Drop Off Date From, Ultimate Drop Off Date To, Location Format

## Oracle EBS Tables Used
[wsh_delivery_legs](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_legs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [wsh_trip_stops](https://www.enginatics.com/library/?pg=1&find=wsh_trip_stops&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [wsh_trips](https://www.enginatics.com/library/?pg=1&find=wsh_trips&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [wsh_exceptions_v](https://www.enginatics.com/library/?pg=1&find=wsh_exceptions_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [mtl_txn_request_lines](https://www.enginatics.com/library/?pg=1&find=mtl_txn_request_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [mtl_material_transactions_temp](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions_temp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [mtl_txn_request_headers](https://www.enginatics.com/library/?pg=1&find=mtl_txn_request_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [wsh_delivery_details](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [wsh_delivery_assignments](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [wsh_new_deliveries](https://www.enginatics.com/library/?pg=1&find=wsh_new_deliveries&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [wsh_picking_batches](https://www.enginatics.com/library/?pg=1&find=wsh_picking_batches&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [wsh_document_instances](https://www.enginatics.com/library/?pg=1&find=wsh_document_instances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [wsh_carriers](https://www.enginatics.com/library/?pg=1&find=wsh_carriers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [wsh_freight_costs](https://www.enginatics.com/library/?pg=1&find=wsh_freight_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [wsh_freight_cost_types](https://www.enginatics.com/library/?pg=1&find=wsh_freight_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [mtl_transaction_lot_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_lot_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [oe_order_holds_all](https://www.enginatics.com/library/?pg=1&find=oe_order_holds_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [ra_salesreps_all](https://www.enginatics.com/library/?pg=1&find=ra_salesreps_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions)

## Related Reports
[WSH Pick Confirm Upload](/WSH%20Pick%20Confirm%20Upload/ "WSH Pick Confirm Upload Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [INV Period Close Pending Transactions](/INV%20Period%20Close%20Pending%20Transactions/ "INV Period Close Pending Transactions Oracle EBS SQL Report"), [INV Move Orders](/INV%20Move%20Orders/ "INV Move Orders Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WSH%20Shipping-Delivery%20Transactions/WSH%20Shipping-Delivery%20Transactions.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [WSH Shipping Delivery Transactions 29-Jun-2026 214203.xlsx](https://www.enginatics.com/example/wsh-shipping-delivery-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions) |
| Blitz Report™ XML Import | [WSH_Shipping_Delivery_Transactions.xml](https://www.enginatics.com/xml/wsh-shipping-delivery-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions) |
| SQL Source | [WSH Shipping-Delivery Transactions.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WSH%20Shipping-Delivery%20Transactions/WSH%20Shipping-Delivery%20Transactions.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/wsh-shipping-delivery-transactions/](https://www.enginatics.com/reports/wsh-shipping-delivery-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions) |

## Case Study & Technical Analysis: WSH Shipping/Delivery Transactions Report

### Executive Summary

The WSH Shipping/Delivery Transactions report is a crucial operational and customer service tool for Oracle Shipping Execution. It provides a comprehensive, detailed view of all sales order shipping transactions and their associated deliveries, encompassing various statuses, customer information, and item details. This report is indispensable for logistics managers, customer service representatives, and order fulfillment teams to track the entire shipping lifecycle, monitor delivery progress, identify exceptions, and ensure timely and accurate fulfillment of customer orders, thereby enhancing customer satisfaction and optimizing logistical efficiency.

### Business Challenge

Managing the shipping and delivery of customer orders is a complex logistical challenge, with numerous touchpoints and potential for delays or errors. Organizations often struggle with:

-   **Lack of End-to-End Visibility:** Tracking a sales order from its initial release for shipping, through picking, packing, staging, actual shipment, and final delivery, is often fragmented across multiple Oracle modules (Order Management, Inventory, Shipping).
-   **Monitoring Delivery Progress:** Getting real-time status updates on individual shipments and deliveries, especially in transit, is crucial for proactive customer communication and managing delivery expectations.
-   **Identifying Bottlenecks and Exceptions:** Delays in picking, packing, or carrier handoff, or discrepancies in delivered quantities, can lead to customer complaints and increased costs. Proactively identifying these exceptions is critical.
-   **Customer Service Inquiries:** Responding to customer inquiries about their order's shipping status requires immediate access to accurate and comprehensive delivery information.
-   **Audit and Compliance:** For high-value shipments or regulated goods, an auditable record of all shipping and delivery events is necessary for compliance and dispute resolution.

### The Solution

This report offers a powerful, integrated, and actionable solution for managing shipping and delivery transactions, bringing transparency and control to the order fulfillment process.

-   **Comprehensive Shipping Lifecycle View:** It consolidates detailed information from shipping transactions and deliveries, linking them to sales orders, customers, items, and various statuses (e.g., released, shipped, delivered). This provides an unparalleled end-to-end perspective.
-   **Flexible Status Filtering:** Crucial parameters like `Delivery Status`, `Release status`, and `Assigned to Delivery` (Yes/No/Null) allow users to precisely focus on specific stages of the shipping process, such as orders awaiting delivery assignment or those in transit.
-   **Proactive Exception Management:** The `Exception Exists` flag (if applicable) highlights problematic deliveries, enabling logistics teams to proactively investigate and resolve issues before they escalate into customer complaints.
-   **Enhanced Customer Communication:** Customer service representatives can leverage this report to provide accurate, real-time updates to customers on their order's shipping status, improving transparency and satisfaction.

### Technical Architecture (High Level)

The report queries core Oracle Shipping Execution, Order Management, and customer master tables to provide its detailed output.

-   **Primary Tables Involved:**
    -   `wsh_delivery_details` (the central table for individual items released for shipment and their status).
    -   `wsh_new_deliveries` (for delivery headers, grouping delivery details).
    -   `wsh_delivery_assignments` (links delivery details to deliveries).
    -   `oe_order_lines_all` and `oe_order_headers_all` (for sales order context).
    -   `hz_cust_accounts`, `hz_parties`, `hz_cust_site_uses_all` (for customer and ship-to site details).
    -   `mtl_system_items_vl` (for item master details).
-   **Logical Relationships:** The report typically starts with `wsh_delivery_details` to identify all shipping lines. It then joins to `wsh_new_deliveries` (via `wsh_delivery_assignments`) to get delivery-level information. Further joins to Order Management tables link these deliveries back to the original sales order, and to customer master tables to provide full customer context. The various date parameters and status flags are applied to filter and present the data at different stages of the shipping lifecycle.

### Parameters & Filtering

The report offers an extensive set of parameters for precise filtering and detailed data inclusion:

-   **Organizational Context:** `Selling Operating Unit`, `Shipping Operating Unit`, `Organization Code` define the business and inventory scope.
-   **Status Filters:** `Assigned to Delivery` (Yes/No/Null), `Delivery Status`, `Exclude Delivery Status`, `Release status`, `Exclude Release Status`, `Exception Exists` are crucial for pinpointing specific operational states or problems.
-   **Customer and Order Identification:** `Customer Name`, `Customer Number`, `Order Number From/To` allow for granular targeting of specific customer orders.
-   **Item and Lot Filters:** `Item`, `Item From/To`, `Lot Number`, `Lot Number From/To` enable tracking of specific products or batches.
-   **Date Ranges:** A wide array of date parameters (`Scheduled Date From/To`, `Released Date From/To`, `Actual Shipment Date From/To`, `Invoiced Date From/To`, `Initial Pick Up Date From/To`, `Ultimate Drop Off Date From/To`) support detailed chronological analysis of the shipping process.
-   **Location Format:** Customizes the display of location information.

### Performance & Optimization

As a detailed transactional report integrating data across multiple modules (Shipping, OM, Inventory), it is optimized through strong filtering and date-driven processing.

-   **Parameter-Driven Efficiency:** The extensive filtering capabilities (by status, customer, order, dates) are critical for performance, allowing the database to efficiently narrow down the large transactional datasets to relevant shipments and deliveries using existing indexes.
-   **Date Range Filters:** The various date parameters (`Actual Shipment Date From/To`, `Scheduled Date From/To`) are particularly effective in limiting the data volume to a manageable timeframe.
-   **Conditional Joins:** The `Assigned to Delivery` parameter effectively acts as a filter that can simplify the query by focusing only on delivery details that are or are not assigned to a delivery, preventing unnecessary complex joins when only a subset is required.

### FAQ

**1. What is the difference between a 'Shipping Transaction' and a 'Delivery' in Oracle Shipping?**
   A 'Shipping Transaction' (represented by a `wsh_delivery_detail`) refers to an individual item line that has been released for shipment. A 'Delivery' (represented by a `wsh_new_delivery`) is a grouping of one or more shipping transactions that are to be shipped together to a single customer location. A single delivery can contain multiple items from one or more sales order lines.

**2. How does the 'Assigned to Delivery' parameter help operations?**
   Setting `Assigned to Delivery` to 'No' allows operations teams to quickly identify all shipping transaction lines that have been picked or staged but have not yet been assigned to a delivery. This is crucial for completing the packing and shipping process and preventing items from being left unshipped.

**3. Can this report help identify reasons for delayed shipments?**
   Yes. By filtering for shipments with a `Delivery Status` indicating delay or exception, and then comparing the `Scheduled Date` to the `Actual Shipment Date`, logistics managers can pinpoint delayed shipments. Further investigation into associated exceptions (`Exception Exists`) can help determine the root cause (e.g., inventory shortage, carrier issue, documentation hold).

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-shipping-delivery-transactions)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
