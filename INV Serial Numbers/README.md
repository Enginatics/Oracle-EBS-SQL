---
layout: default
last_modified_at: 2026-10-16
title: 'INV Serial Numbers | Oracle EBS SQL Report'
description: 'Serial numbers in any status (defined, in stores, issued out of stores, in transit, in receiving, in WIP), one row per serial number, with current…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Inventory, Enginatics, INV, Serial, Numbers, mtl_item_locations_kfv, mtl_object_genealogy, mtl_sales_orders'
permalink: /INV%20Serial%20Numbers/
report_name: 'INV Serial Numbers'
report_web_name: inv-serial-numbers
module: 'Inventory'
module_url: /modules/inventory/
---

# INV Serial Numbers – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-serial-numbers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers).
**Oracle EBS module:** [Inventory](/modules/inventory/ "Oracle EBS Inventory reports") · [all Inventory reports](/modules/inventory/)  

## Overview
Serial numbers in any status (defined, in stores, issued out of stores, in transit, in receiving, in WIP), one row per serial number, with current organization, subinventory and locator, the last transaction source, the customer of a serial issued on a sales order and the genealogy parent.

Organization is the current organization; for an issued serial it is the organization that issued it. Customer is the sold-to customer of the sales order of the last transaction, blank when the order no longer exists. Last Transaction Type and Date are blank where Oracle did not record the last transaction on the serial.

Use INV Transaction Register (Serial Number Detail) for the full transaction history of a serial.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Item, Serial Number like, Current Status, Subinventory, Lot Number, Last Source Type, Sales Order, Customer, Ship Date From, Ship Date To, DFF Display

## Oracle EBS Tables Used
[mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers), [mtl_object_genealogy](https://www.enginatics.com/library/?pg=1&find=mtl_object_genealogy&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers), [mtl_sales_orders](https://www.enginatics.com/library/?pg=1&find=mtl_sales_orders&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers), [mtl_serial_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_serial_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers), [mtl_material_statuses_vl](https://www.enginatics.com/library/?pg=1&find=mtl_material_statuses_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers), [wms_license_plate_numbers](https://www.enginatics.com/library/?pg=1&find=wms_license_plate_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers), [mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers), [mtl_txn_request_headers](https://www.enginatics.com/library/?pg=1&find=mtl_txn_request_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers)

## Related Reports
[INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [INV Move Orders](/INV%20Move%20Orders/ "INV Move Orders Oracle EBS SQL Report"), [CAC Purchase Price Variance](/CAC%20Purchase%20Price%20Variance/ "CAC Purchase Price Variance Oracle EBS SQL Report"), [INV Default Category Sets](/INV%20Default%20Category%20Sets/ "INV Default Category Sets Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Serial%20Numbers/INV%20Serial%20Numbers.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Serial Numbers 15-Oct-2026 022617.xlsx](https://www.enginatics.com/example/inv-serial-numbers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers) |
| Blitz Report™ XML Import | [INV_Serial_Numbers.xml](https://www.enginatics.com/xml/inv-serial-numbers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers) |
| SQL Source | [INV Serial Numbers.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Serial%20Numbers/INV%20Serial%20Numbers.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-serial-numbers/](https://www.enginatics.com/reports/inv-serial-numbers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers) |

## Case Study & Technical Analysis: INV Serial Numbers

### Executive Summary
This report lists every serial number in Oracle Inventory, in any status, with one row per serial. For each serial it shows the current organization, subinventory and locator, the material status, the last transaction source and type, the customer of a serial issued on a sales order, and the genealogy parent. Inventory controllers and service teams use it to locate a specific unit, to confirm which customer holds a serial, or to check the status of serialized stock across the organizations they can access. The report runs in Excel through Blitz Report.

### Business Challenge
*   **Locating serialized stock:** Serialized items must be traced to the organization, subinventory and locator where each unit sits.
*   **Customer serial visibility:** Warranty and service claims need the customer that a serial was shipped to, which is held on the sales order rather than on the serial.
*   **Genealogy questions:** Assemblies built from serialized components need the parent serial to be traced.
*   **Status checks:** Units can be defined, in stores, issued, in transit, in receiving or in WIP, and each state needs a different follow up.

### The Solution
*   **Current location:** The current organization, subinventory, locator and license plate are returned for each serial.
*   **Last transaction:** The last source type, source document, transaction type and date show how the serial last moved.
*   **Customer of issued serials:** For a serial issued on a sales order, the sold-to customer and account number are returned, and they are blank when the order no longer exists.
*   **Genealogy parent:** The parent item and parent serial number are returned through the genealogy relationship.
*   **Source document reference:** The source document is chosen by source type, whether a sales order, job, purchase order, requisition or move request.

### Technical Architecture (High Level)
#### Primary Tables
*   `MTL_SERIAL_NUMBERS`: the serial record, with status, current organization, subinventory, locator and last transaction.
*   `MTL_PARAMETERS` and `MTL_SYSTEM_ITEMS_VL`: the organization and the serialized item.
*   `MTL_OBJECT_GENEALOGY`: the parent object of each serial.
*   `MTL_MATERIAL_TRANSACTIONS` and `MTL_TRANSACTION_TYPES`: the last transaction and its type.
*   `MTL_TXN_SOURCE_TYPES`: the name of the last source type.
*   `MTL_SALES_ORDERS`, `OE_ORDER_HEADERS_ALL` and `OE_TRANSACTION_TYPES_TL`: the sales order, its order header and the transaction type name used to match the order.
*   `HZ_CUST_ACCOUNTS` and `HZ_PARTIES`: the sold-to customer.
*   `WIP_ENTITIES`, `PO_HEADERS_ALL`, `PO_REQUISITION_HEADERS_ALL` and `MTL_TXN_REQUEST_HEADERS`: the source documents of the last transaction.
*   `MTL_ITEM_LOCATIONS_KFV`, `MTL_MATERIAL_STATUSES_VL` and `WMS_LICENSE_PLATE_NUMBERS`: the locator, material status and license plate.
*   `AP_SUPPLIERS`: the original supplier of the serial.

#### Logical Relationships
1. `MTL_PARAMETERS` restricts the organizations to those the responsibility can access, and `MTL_SERIAL_NUMBERS` joins on the current organization.
2. The parent serial is found by a subquery on `MTL_OBJECT_GENEALOGY` for the serial's generation object, with an active parent of object type 2.
3. The order header is matched to the sales order by order number, and the customer is reached through the sold-to customer id.
4. The last source document is selected by a CASE on the last transaction source type, so each source type joins only to its own table.
5. The last transaction joins to `MTL_MATERIAL_TRANSACTIONS` and then to `MTL_TRANSACTION_TYPES`, as outer joins.

### Parameters & Filtering
*   **Organization Code:** restricts the serials to one organization.
*   **Item and Serial Number like:** select one item or a serial number pattern.
*   **Current Status:** restricts the serials to one status such as defined, in stores or issued.
*   **Subinventory and Lot Number:** narrow the serials to a subinventory or a lot.
*   **Last Source Type:** restricts the serials to those last moved from one source type.
*   **Sales Order and Customer:** restrict the serials to one sales order or customer.
*   **Ship Date From / Ship Date To:** bound the serials by ship date.
*   **DFF Display:** controls whether the serial flexfield columns are shown.

### Performance & Optimization
*   The organization filter is applied in the inner query on `MTL_SERIAL_NUMBERS`, which limits the main scan to accessible organizations.
*   The order-header match is a scalar subquery restricted to sales order sources, so it is evaluated only for serials last moved by a sales order.
*   The source document joins are CASE-based outer joins, so each source type reads only its own table.

### FAQ
**Q: Why is the customer blank for a serial that was shipped?**
A: The customer comes from the sold-to customer of the sales order of the last transaction. It is blank when the order no longer exists or the serial was not last issued on an order.

**Q: Why is the last transaction date blank?**
A: Oracle did not record the last transaction on the serial. For the full transaction history of a serial, use INV Transaction Register (Serial Number Detail).

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-serial-numbers)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
