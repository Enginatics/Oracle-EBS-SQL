---
layout: default
last_modified_at: 2026-10-19
title: 'ONT Order Upload | Oracle EBS SQL Report'
description: 'Upload to Create, Update, Book and Cancel Sales Orders in Oracle Order Management. Supports creating new orders, updating existing orders, adding new…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, ONT, Order, oe_contacts_v, hz_cust_account_roles, hz_relationships'
permalink: /ONT%20Order%20Upload/
report_name: 'ONT Order Upload'
report_web_name: ont-order-upload
---

# ONT Order Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ont-order-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload).

## Overview
Upload to Create, Update, Book and Cancel Sales Orders in Oracle Order Management.
Supports creating new orders, updating existing orders, adding new lines to existing orders, splitting lines, booking orders and cancelling orders.

To split a line, add a row for the order with the line to split in Split From Line and the new shipment's quantity in Ordered Quantity. The original line is reduced by that quantity unless its own row sets its new quantity. As in the Split Line window, the new shipment copies all other values from the original line, only Request Date, Warehouse and Ship To can differ.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Operating Unit, Order Number, Customer PO, Customer Name, Account Number, Order Type, Line Type, Open only, Exclude Cancelled, Order Status, Order Action, Line Status, Shippable Flag, Creation Date From, Creation Date To, Line Creation Date From, Line Creation Date To, Order Category, Line Category, Item, Item Type, Schedule Ship Date From, Schedule Ship Date To, Ship From Warehouse, Request Date From, Request Date To, Cancelled Date From, Cancelled Date To, Debug

## Oracle EBS Tables Used
[oe_contacts_v](https://www.enginatics.com/library/?pg=1&find=oe_contacts_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [hz_cust_account_roles](https://www.enginatics.com/library/?pg=1&find=hz_cust_account_roles&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [hz_relationships](https://www.enginatics.com/library/?pg=1&find=hz_relationships&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [hz_org_contacts](https://www.enginatics.com/library/?pg=1&find=hz_org_contacts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [qp_secu_list_headers_v](https://www.enginatics.com/library/?pg=1&find=qp_secu_list_headers_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [jtf_rs_salesreps](https://www.enginatics.com/library/?pg=1&find=jtf_rs_salesreps&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [jtf_rs_resource_extns_tl](https://www.enginatics.com/library/?pg=1&find=jtf_rs_resource_extns_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [ra_terms_vl](https://www.enginatics.com/library/?pg=1&find=ra_terms_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [oe_ship_methods_v](https://www.enginatics.com/library/?pg=1&find=oe_ship_methods_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [oe_agreements_vl](https://www.enginatics.com/library/?pg=1&find=oe_agreements_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [ra_rules](https://www.enginatics.com/library/?pg=1&find=ra_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [oe_order_sources](https://www.enginatics.com/library/?pg=1&find=oe_order_sources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [aso_quote_headers_all](https://www.enginatics.com/library/?pg=1&find=aso_quote_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [cs_incidents_all_b](https://www.enginatics.com/library/?pg=1&find=cs_incidents_all_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [qp_list_headers_vl](https://www.enginatics.com/library/?pg=1&find=qp_list_headers_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [oe_price_adjustments](https://www.enginatics.com/library/?pg=1&find=oe_price_adjustments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload)

## Related Reports
[AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [ONT Orders and Lines 11i](/ONT%20Orders%20and%20Lines%2011i/ "ONT Orders and Lines 11i Oracle EBS SQL Report"), [ONT Orders and Lines](/ONT%20Orders%20and%20Lines/ "ONT Orders and Lines Oracle EBS SQL Report"), [PPF_WP3_OM_DETAILS](/PPF_WP3_OM_DETAILS/ "PPF_WP3_OM_DETAILS Oracle EBS SQL Report"), [ONT Orders](/ONT%20Orders/ "ONT Orders Oracle EBS SQL Report"), [AR Transactions and Lines](/AR%20Transactions%20and%20Lines/ "AR Transactions and Lines Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ONT%20Order%20Upload/ONT%20Order%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ont-order-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload) |
| Blitz Report™ XML Import | [ONT_Order_Upload.xml](https://www.enginatics.com/xml/ont-order-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload) |
| SQL Source | [ONT Order Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ONT%20Order%20Upload/ONT%20Order%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ont-order-upload/](https://www.enginatics.com/reports/ont-order-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload) |

## Case Study & Technical Analysis: ONT Order Upload

### Executive Summary
This upload creates, updates, books and cancels sales orders in Oracle Order Management, and adds lines to existing orders or splits lines into shipments. Order entry and order management teams use it to load and maintain large volumes of orders in one spreadsheet. It runs in Excel through Blitz Report™, and the download shows the existing orders that the upload will change.

### Business Challenge
*   **High-volume order entry:** Orders keyed one by one in the Sales Orders window are slow, and errors in customer, item or pricing data are costly to correct after booking.
*   **Maintaining open orders:** Changes to lines, quantities, dates and shipping details must be made in the right sequence and with the reason and comments that Oracle requires for a booked line.
*   **Splitting shipments:** A line sometimes has to ship in parts, each with its own request date, warehouse or ship-to address.
*   **Controlled booking:** Orders must be booked or cancelled in batch with a clear record of changes.

### The Solution
*   Downloads existing orders, one row per header or line, with customer, order type, price list, salesperson, shipping, tax and flexfield values.
*   Each row can create, update, book or cancel an order, or add a line, using the Order Action column.
*   Splits a line by entering a new row for the order with the line to split in Split From Line and the new shipment's quantity in Ordered Quantity.
*   Keeps the new shipment's other values equal to the original line, so that only Request Date, Warehouse and Ship To can differ, as in the Split Line window.

### Technical Architecture (High Level)
#### Primary Tables
*   `OE_ORDER_HEADERS_ALL` and `OE_ORDER_LINES_ALL`: the order headers and lines, with status, quantities, dates, pricing and flexfield columns.
*   `OE_TRANSACTION_TYPES_TL`: the order type and line type names.
*   `OE_ORDER_SOURCES`: the order source of each order.
*   `OE_PRICE_ADJUSTMENTS`: the applied discount or surcharge of each line.
*   `HZ_CUST_ACCOUNTS`, `HZ_PARTIES` and `HZ_CUST_SITE_USES_ALL`: the customer, contact and ship-to and bill-to site locations.
*   `OE_CONTACTS_V`, `HZ_CUST_ACCOUNT_ROLES`, `HZ_RELATIONSHIPS` and `HZ_ORG_CONTACTS`: the customer contact and contact number.
*   `RA_TERMS_VL`, `OE_SHIP_METHODS_V` and `OE_AGREEMENTS_VL`: payment terms, shipping methods and agreements.
*   `QP_SECU_LIST_HEADERS_V` and `QP_LIST_HEADERS_VL`: the price lists and the discount modifiers.
*   `JTF_RS_SALESREPS` and `JTF_RS_RESOURCE_EXTNS_TL`: the salesperson of the header and line.
*   `MTL_SYSTEM_ITEMS_VL` and `MTL_PARAMETERS`: the item and the warehouse.
*   `PA_PROJECTS_ALL`, `PA_TASKS`, `PO_REQUISITION_HEADERS_ALL`, `ASO_QUOTE_HEADERS_ALL` and `CS_INCIDENTS_ALL_B`: the project, task and source document references.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit.

#### Logical Relationships
1.  Each order header is joined to its operating unit, its customer account and party, and its order type and source.
2.  Each header is outer-joined to its lines, and each line to its line type, its item in the warehouse, and its ship-from organization.
3.  Header and line flexfield and third-party attribute contexts are displayed by their contexts and segment values.
4.  The line discount is the applied discount or surcharge adjustment, with its modifier, operator and value.
5.  Source references are resolved by source document type.
6.  Who-columns are converted to user names and client times, and header and line identifiers are kept as keys.

### Parameters & Filtering
*   **Upload Mode** and **Order Action:** set whether the file creates, updates, books or cancels orders.
*   **Operating Unit**, **Order Number**, **Customer PO**, **Customer Name** and **Account Number:** select the orders to download.
*   **Order Type**, **Line Type**, **Order Status** and **Line Status:** restrict orders and lines by their type and status.
*   **Item**, **Item Type**, **Ship From Warehouse** and **Schedule Ship Date From** and **To:** restrict lines by product and shipping.
*   **Request Date From** and **To**, **Creation Date From** and **To**, **Cancelled Date From** and **To:** restrict orders and lines by date.

### Performance & Optimization
*   Every header and line join is an outer join on an identifier, so the cost is one keyed lookup per row for each reference.
*   Discount, price list, salesperson and address values are scalar subqueries, and discount lookups stop at the first match.
*   Because the lookups are evaluated per row, the header selection by operating unit and order number is the main lever on run time.

### FAQ
**Q: How do I split an order line into two shipments in this upload?**
A: Add a row for the order with the line to split in Split From Line, and enter the new shipment's quantity in Ordered Quantity; the original line is reduced by that quantity unless its own row sets its new quantity.

**Q: Which values can differ on a split shipment?**
A: Only Request Date, Warehouse and Ship To can differ; all other values are copied from the original line, as in the Split Line window.

**Q: Why does a booked line need a change reason?**
A: Oracle requires a reason and comments to modify a booked line, so the upload carries Line Change Reason and Line Change Comments.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
