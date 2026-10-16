---
layout: default
last_modified_at: 2026-10-16
title: 'ONT Orders and Lines 11i | Oracle EBS SQL Report'
description: 'Detail Sales Order or Quote header report with line item details including status, cost, project and shipping information. Show Sales Credits adds one row…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Order Management, Enginatics, ONT, Orders, Lines, 11i, dual, oe_order_sources, po_requisition_headers_all'
permalink: /ONT%20Orders%20and%20Lines%2011i/
report_name: 'ONT Orders and Lines 11i'
report_web_name: ont-orders-and-lines-11i
module: 'Order Management'
module_url: /modules/order-management/
---

# ONT Orders and Lines 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ont-orders-and-lines-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i).
**Oracle EBS module:** [Order Management](/modules/order-management/ "Oracle EBS Order Management reports") · [all Order Management reports](/modules/order-management/)  

## Overview
Detail Sales Order or Quote header report with line item details including status, cost, project and shipping information.

Show Sales Credits adds one row per sales credit of each line, taken from the line, or from the order header for lines without sales credits of their own. Credited Amount is the line extended price times the credit percent and is shown once per line and credit, so it can be summed by salesperson; the other amount columns stay on one row per line.

Show Order to Cash Details adds the booked date and open holds of each line, and for the line's latest invoice the due date, the amount still due, the date it was fully paid, the latest receipt applied, and the dates it was transferred to the general ledger (Accounted Date) and its journal posted (GL Posted Date, shown when the Receivables journal source imports journal references). Amount Due Remaining is shown on one row per invoice, so it can be summed. To follow lines until they are paid, leave Open only empty, so that closed orders with unpaid invoices are included.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Order Number, Quote Number, Customer Name, Account Number, Type, Order Category, Line Category, Order Type, Line Type, Item Type, Open only, Exclude Cancelled, Order Status, Line Status, Exclude Line Status, Item, Category Set 1, Category Set 2, Category Set 3, Shippable Flag, Order Fully/Partially Shipped, Project, Task, Schedule Ship Date From, Schedule Ship Date To, Ship To Country, Bill To Country, Ship From Warehouse, Request Date From, Request Date To, Creation Date From, Creation Date To, Line Creation Date From, Line Creation Date To, Cancelled Date From, Cancelled Date To, Invoice GL Date From, Invoice GL Date To, Intrastat Eligible Only, DIFOT Eligible Only, DFF Display, Show Order to Cash Details, Sales Agreement Number, Show Sales Credits

## Oracle EBS Tables Used
[dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [oe_order_sources](https://www.enginatics.com/library/?pg=1&find=oe_order_sources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [aso_quote_headers_all](https://www.enginatics.com/library/?pg=1&find=aso_quote_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [cs_incidents_all_b](https://www.enginatics.com/library/?pg=1&find=cs_incidents_all_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [qp_list_headers_vl](https://www.enginatics.com/library/?pg=1&find=qp_list_headers_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [oe_price_adjustments](https://www.enginatics.com/library/?pg=1&find=oe_price_adjustments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [ra_terms_vl](https://www.enginatics.com/library/?pg=1&find=ra_terms_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [wsh_carriers_v](https://www.enginatics.com/library/?pg=1&find=wsh_carriers_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [oe_sets](https://www.enginatics.com/library/?pg=1&find=oe_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [jtf_rs_salesreps](https://www.enginatics.com/library/?pg=1&find=jtf_rs_salesreps&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [jtf_rs_resource_extns_vl](https://www.enginatics.com/library/?pg=1&find=jtf_rs_resource_extns_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [pjm_seiban_numbers](https://www.enginatics.com/library/?pg=1&find=pjm_seiban_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [ra_cust_trx_types_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [ra_cust_trx_line_gl_dist_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_line_gl_dist_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [oe_order_lines_history](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_history&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [oe_reasons](https://www.enginatics.com/library/?pg=1&find=oe_reasons&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [wsh_delivery_details](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [wsh_delivery_assignments](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [wsh_new_deliveries](https://www.enginatics.com/library/?pg=1&find=wsh_new_deliveries&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i)

## Related Reports
[ONT Orders and Lines](/ONT%20Orders%20and%20Lines/ "ONT Orders and Lines Oracle EBS SQL Report"), [PPF_WP3_OM_DETAILS](/PPF_WP3_OM_DETAILS/ "PPF_WP3_OM_DETAILS Oracle EBS SQL Report"), [ONT Orders](/ONT%20Orders/ "ONT Orders Oracle EBS SQL Report"), [ONT Order Upload](/ONT%20Order%20Upload/ "ONT Order Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ONT%20Orders%20and%20Lines%2011i/ONT%20Orders%20and%20Lines%2011i.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ont-orders-and-lines-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i) |
| Blitz Report™ XML Import | [ONT_Orders_and_Lines_11i.xml](https://www.enginatics.com/xml/ont-orders-and-lines-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i) |
| SQL Source | [ONT Orders and Lines 11i.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ONT%20Orders%20and%20Lines%2011i/ONT%20Orders%20and%20Lines%2011i.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ont-orders-and-lines-11i/](https://www.enginatics.com/reports/ont-orders-and-lines-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i) |

## Case Study & Technical Analysis: ONT Orders and Lines 11i

### Executive Summary
The ONT Orders and Lines 11i report is a detailed listing of Oracle Order Management sales orders and quotes, with the header, each line, its status, cost, project and shipping information. It can also show the sales credits of each line and the order-to-cash position of each line, from booking through invoice payment. Sales operations, order managers and finance teams use it to track backlog, delivery performance and the invoicing and collection of orders. It runs in Excel through Blitz Report, where rows can be summed by salesperson, warehouse or item.

### Business Challenge
*   **Backlog and status:** Open orders must be followed line by line, with the flow status, the schedule ship date and the open holds that block shipment.
*   **Delivery performance:** Deliver in full and on time measures need the ordered and shipped quantities of each line and the promise and actual shipment dates.
*   **Invoicing and collection:** An order is complete only when its invoice is paid, so the team needs the invoice, the amount still due and the receipt applied to each line.
*   **Sales credit:** Sales credits must be split by salesperson, with the credited amount of each line.

### The Solution
*   Lists each order header and line with the customer, ship-to and bill-to details, addresses, tax references and payment terms.
*   Shows the ordered, shipped, invoiced and cancelled quantities, the unit prices, discounts and freight charges, and the extended price of each line.
*   Shows the delivery, release status and next step of each shipped line, with the warehouse, carrier, shipping method and freight terms.
*   Adds the sales credit rows and the order-to-cash details, the booked date, open holds and invoice position, when the parameters for these are set.

### Technical Architecture (High Level)
#### Primary Tables
*   `OE_ORDER_HEADERS_ALL` and `OE_ORDER_LINES_ALL`: the order header and line, with status, pricing, quantities and dates.
*   `OE_ORDER_LINES_HISTORY` and `OE_REASONS`: the cancellation history and the cancel reason of a line.
*   `OE_PRICE_ADJUSTMENTS`: the discounts and freight charges applied to a line.
*   `RA_CUSTOMER_TRX_ALL`, `RA_CUSTOMER_TRX_LINES_ALL` and `RA_CUST_TRX_LINE_GL_DIST_ALL`: the invoice an order line was interfaced to, its lines and accounting distributions.
*   `WSH_DELIVERY_DETAILS`, `WSH_DELIVERY_ASSIGNMENTS` and `WSH_NEW_DELIVERIES`: the shipping delivery of each line.
*   `HZ_CUST_ACCOUNTS`, `HZ_PARTIES`, `HZ_CUST_SITE_USES_ALL`, `HZ_CUST_ACCT_SITES_ALL`, `HZ_PARTY_SITES` and `HZ_LOCATIONS`: the customer and its addresses.
*   `MTL_SYSTEM_ITEMS_VL`, `PA_PROJECTS_ALL`, `PA_TASKS`, `JTF_RS_SALESREPS` and `JTF_RS_RESOURCE_EXTNS_VL`: the item, project, task and salesperson.

#### Logical Relationships
1.  `OE_ORDER_HEADERS_ALL` is joined to `OE_ORDER_LINES_ALL` on the header id, and the lines are restricted to the operating units in `MO_GLOB_ORG_ACCESS_TMP`.
2.  Each line is linked to its invoice through the interface line attribute 6, which holds the order line id, on `RA_CUSTOMER_TRX_LINES_ALL`, then to the transaction header and type.
3.  Each line is linked to its delivery through `WSH_DELIVERY_DETAILS` on the source line id, with the assignment and new delivery joined from there.
4.  Ship-to and bill-to are reached through the site uses, account sites, party sites and locations of each address.
5.  Cancellation rows from `OE_ORDER_LINES_HISTORY` are joined to each line, and price adjustments are summed per line in inline views.

### Parameters & Filtering
*   **Operating Unit**, **Order Number**, **Quote Number**, **Customer Name** and **Account Number** select the orders by organization, document and customer.
*   **Type**, **Order Category**, **Line Category**, **Order Type** and **Line Type** select the document type and the category of the lines.
*   **Open only:** restricts the output to open lines. Leave it empty to follow closed orders with unpaid invoices.
*   **Order Status**, **Line Status** and **Exclude Line Status** filter the status of the header and lines.
*   **Item** and **Category Set 1** to **3** filter by item and item category.
*   **Schedule Ship Date**, **Request Date** and **Creation Date** ranges bound the dates.

### Performance & Optimization
*   The main query uses DISTINCT with push-predicate hints on the cancellation, delivery and line history joins, so the filters apply before the joins are processed.
*   Price adjustments are summed per line in inline views with a filter on the applied flag, so only applied discounts and charges are included.
*   Invoice data is taken with analytic functions over the interface line attribute, which returns the last invoice of each line without a second query.
*   Setting Operating Unit and Open only narrows the order population early. Leaving Open only empty reads closed orders as well, so it is best combined with a date range.

### FAQ
**Q: How do I see the sales credit of each salesperson on an order?**
A: Set Show Sales Credits. Each sales credit has its own row, with the credited amount equal to the line extended price times the credit percent, so the amounts can be summed by salesperson.

**Q: How do I track an order until its invoice is paid?**
A: Set Show Order to Cash Details and leave Open only empty. The report then includes closed orders with unpaid invoices, and shows the amount due, the payment date and the receipt applied.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-orders-and-lines-11i)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
