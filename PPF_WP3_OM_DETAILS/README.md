---
layout: default
title: 'PPF_WP3_OM_DETAILS | Oracle EBS SQL Report'
description: 'Detail Sales Order or Quote header report with line item details including status, cost, project and shipping information.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, PPF_WP3_OM_DETAILS, dual, oe_order_sources, po_requisition_headers_all'
permalink: /PPF_WP3_OM_DETAILS/
---

# PPF_WP3_OM_DETAILS – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ppf_wp3_om_details/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Detail Sales Order or Quote header report with line item details including status, cost, project and shipping information.

## Report Parameters
Operating Unit, Order Number, Quote Number, Customer Name, Ship to Country, Account Number, Type, Order Category, Line Category, Order Type, Line Type, Open only, Exclude Cancelled, Order Status, Line Status, Item, Shippable Flag, Project, Task, Schedule Ship Date From, Schedule Ship Date To, Request Date From, Request Date To, Line Creation Date From, Line Creation Date To, Cancelled Date From, Cancelled Date To

## Oracle EBS Tables Used
[dual](https://www.enginatics.com/library/?pg=1&find=dual), [oe_order_sources](https://www.enginatics.com/library/?pg=1&find=oe_order_sources), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all), [aso_quote_headers_all](https://www.enginatics.com/library/?pg=1&find=aso_quote_headers_all), [cs_incidents_all_b](https://www.enginatics.com/library/?pg=1&find=cs_incidents_all_b), [qp_list_headers_vl](https://www.enginatics.com/library/?pg=1&find=qp_list_headers_vl), [oe_price_adjustments](https://www.enginatics.com/library/?pg=1&find=oe_price_adjustments), [ra_terms_vl](https://www.enginatics.com/library/?pg=1&find=ra_terms_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [oe_sets](https://www.enginatics.com/library/?pg=1&find=oe_sets), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_categories_v](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories_v), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [jtf_rs_salesreps](https://www.enginatics.com/library/?pg=1&find=jtf_rs_salesreps), [jtf_rs_resource_extns_vl](https://www.enginatics.com/library/?pg=1&find=jtf_rs_resource_extns_vl), [wsh_delivery_details](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_details), [wsh_delivery_assignments](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_assignments)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ppf_wp3_om_details/) |
| Blitz Report™ XML Import | [PPF_WP3_OM_DETAILS.xml](https://www.enginatics.com/xml/ppf_wp3_om_details/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ppf_wp3_om_details/](https://www.enginatics.com/reports/ppf_wp3_om_details/) |

## Case Study & Technical Analysis: PPF_WP3_OM_DETAILS Report

### Executive Summary

The PPF_WP3_OM_DETAILS report is a highly granular and comprehensive operational report designed for Oracle Order Management, likely tailored for specific project or internal operational analysis (indicated by "PPF_WP3"). It provides a detailed view of sales order and quote headers, meticulously integrating line item details, associated costs, project contexts, and crucial shipping information. This report is an indispensable tool for order administrators, project managers, cost analysts, and logistics teams who require an exhaustive, single source of truth for the end-to-end lifecycle of sales orders, from initial quote through fulfillment and associated project costs.

### Business Challenge

In complex sales and project-oriented organizations, understanding the full lifecycle of a sales order, especially its financial and logistical implications, is challenging due to data fragmentation across modules. Key pain points include:

-   **Fragmented Order Information:** Details regarding order status, item costs, associated projects/tasks, and shipping information are typically scattered across Order Management, Inventory, Projects, and Shipping modules, making a holistic view difficult.
-   **Cost-to-Revenue Disconnect:** Accurately linking the cost of goods sold to specific sales order lines, especially in project-based scenarios, is critical for profitability analysis but often requires manual data reconciliation.
-   **Operational Bottlenecks:** Identifying delays in order fulfillment, shipping, or project-related activities requires granular visibility across various stages of the order lifecycle. Lack of this insight can lead to customer dissatisfaction and missed revenue targets.
-   **Compliance and Audit Trail:** For project costing, revenue recognition, and shipping compliance, a detailed, auditable record of each sales order line, its attributes, and its status is essential.

### The Solution

This report offers a powerful, integrated, and granular solution for comprehensive sales order analysis, directly addressing the challenges of data fragmentation and operational visibility.

-   **Unified Order Lifecycle View:** It consolidates header and line-level details from sales orders and quotes, integrating data on item costs, project allocations, and shipping statuses. This provides an unprecedented end-to-end perspective on order fulfillment and profitability.
-   **Integrated Cost and Project Context:** The report ties sales orders to their underlying cost and project/task details, enabling precise profitability analysis for individual order lines and better tracking of project-related revenue and expenses.
-   **Operational Monitoring at Detail Level:** With extensive filtering options, users can quickly identify open orders, pending shipments, cancelled lines, or orders associated with specific items or projects, facilitating proactive management of operational exceptions.
-   **Robust Data for Analysis:** By providing a wealth of detailed attributes, the report serves as a rich data source for advanced analytics, business intelligence, and custom reporting tailored to specific operational or financial needs.

### Technical Architecture (High Level)

The report queries numerous Oracle Order Management, Inventory, Shipping, and Projects tables to build its comprehensive, integrated view.

-   **Primary Tables Involved:**
    -   `oe_order_headers_all` and `oe_order_lines_all` (for sales order header and line details).
    -   `aso_quote_headers_all` (for sales quote header information, if applicable).
    -   `mtl_system_items_vl` (for item master details).
    -   `mtl_parameters` (for inventory organization context).
    -   `wsh_delivery_details` and `wsh_delivery_assignments` (for shipping and delivery information).
    -   `pa_projects_all` and `pa_tasks` (for project and task details, linking order lines to projects).
    -   `hz_cust_accounts` and `hz_parties` (for customer details).
-   **Logical Relationships:** The report establishes its core from `oe_order_headers_all` and `oe_order_lines_all`. It then performs extensive joins to contextual tables for items, customers, and organizations. Crucially, it links to `wsh_delivery_details` for shipping status and to Oracle Projects tables (`pa_projects_all`, `pa_tasks`) when order lines are tied to specific projects, providing a truly integrated view of the order lifecycle.

### Parameters & Filtering

The report offers an extensive set of parameters for highly targeted and granular analysis:

-   **Organizational & Customer Filters:** `Operating Unit`, `Customer Name`, `Account Number`, `Ship to Country` allow for broad or specific data selection.
-   **Document Identification:** `Order Number`, `Quote Number`, `Type` (Order/Quote), `Order Category`, `Line Category`, `Order Type`, `Line Type` enable precise targeting of documents.
-   **Status Filters:** `Open only`, `Exclude Cancelled`, `Order Status`, `Line Status`, `Shippable Flag` are critical for focusing on active or problematic orders.
-   **Item & Project Filters:** `Item`, `Project`, and `Task` allow for analysis by specific products or project contexts.
-   **Date Ranges:** A wide array of date parameters (`Schedule Ship Date From/To`, `Request Date From/To`, `Line Creation Date From/To`, `Cancelled Date From/To`) supports detailed chronological analysis.

### Performance & Optimization

As a highly detailed transactional report integrating data across multiple modules, it is optimized through strong filtering and efficient joining strategies.

-   **Parameter-Driven Efficiency:** The extensive filtering capabilities (by order number, dates, item, status) are critical for performance, allowing the database to efficiently narrow down the large transactional datasets before performing complex joins.
-   **Indexed Joins:** Queries leverage standard Oracle indexes on `order_header_id`, `order_line_id`, `item_id`, `organization_id`, `customer_id`, `project_id`, and `task_id` for efficient data retrieval across Order Management, Shipping, Inventory, and Projects tables.
-   **Targeted Data Retrieval:** The report avoids full table scans where possible by using specific criteria to access relevant subsets of data.

### FAQ

**1. How does this report help reconcile order data with project costs?**
   When sales order lines are associated with Oracle Projects, this report explicitly includes the `Project` and `Task` details. This allows project managers to compare the revenue-generating order lines against the project's actual costs (from other Project reports) to analyze profitability and ensure accurate project accounting.

**2. Can this report show the full status history of an order line?**
   While the report shows the current `Line Status`, capturing the full status *history* (all status changes over time) would typically require querying the `OE_ORDER_HISTORY` or `OE_ORDER_LINES_HISTORY` tables. This report provides a detailed snapshot of the order's current state with key attributes.

**3. What is the significance of the 'Shippable Flag' parameter?**
   The `Shippable Flag` indicates whether an item on an order line is eligible to be shipped. Filtering by this flag allows logistics and order management teams to focus on lines that are ready for fulfillment, separating them from non-shippable items (e.g., service lines, configured items not yet complete) or lines pending other actions.


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
