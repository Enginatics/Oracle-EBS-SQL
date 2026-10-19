---
layout: default
last_modified_at: 2026-10-19
title: 'WSH Pick Confirm Upload | Oracle EBS SQL Report'
description: 'WSH Pick Confirm Upload ======================= Confirms released sales order pick tasks in bulk from Excel: the picked quantity, the subinventory…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, WSH, Pick, Confirm, wsh_delivery_legs, wsh_trip_stops, wsh_trips'
permalink: /WSH%20Pick%20Confirm%20Upload/
report_name: 'WSH Pick Confirm Upload'
report_web_name: wsh-pick-confirm-upload
---

# WSH Pick Confirm Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/wsh-pick-confirm-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload).

## Overview
WSH Pick Confirm Upload
=======================
Confirms released sales order pick tasks in bulk from Excel: the picked quantity, the subinventory, locator and lot actually picked, the staging location and, in WMS enabled organizations, the LPN the material was packed into.

Download the released to warehouse lines of an organization, optionally restricted to an order, delivery, trip, move order (pick slip), customer or item. One row is created per pick allocation, and per allocated lot for lot controlled items.

Overwrite the pre-filled allocation where the pick differs, enter the LPN and upload. Each pick task is confirmed through the standard pick confirm API, which moves the material to the staging subinventory and sets the delivery line to Staged/Pick Confirmed. Unknown LPN names are created as new LPNs in the organization.

Parameter Confirm All Downloaded Lines pre-flags every downloaded row, so an unchanged pick list can be uploaded as it is.

Parameter Ship Confirm additionally ship confirms a delivery as soon as its last released line has been confirmed by the upload. Unpicked quantities of the delivery are backordered.

Serial controlled items are not supported.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Order Number, Delivery, Trip, Move Order, Customer, Item, Confirm All Downloaded Lines, Ship Confirm

## Oracle EBS Tables Used
[wsh_delivery_legs](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_legs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload), [wsh_trip_stops](https://www.enginatics.com/library/?pg=1&find=wsh_trip_stops&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload), [wsh_trips](https://www.enginatics.com/library/?pg=1&find=wsh_trips&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload), [mtl_material_transactions_temp](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions_temp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload), [wsh_delivery_details](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload), [wsh_delivery_assignments](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload), [wsh_new_deliveries](https://www.enginatics.com/library/?pg=1&find=wsh_new_deliveries&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload), [mtl_transaction_lots_temp](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_lots_temp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload), [mtl_txn_request_lines](https://www.enginatics.com/library/?pg=1&find=mtl_txn_request_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload), [mtl_txn_request_headers](https://www.enginatics.com/library/?pg=1&find=mtl_txn_request_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload), [wms_dispatched_tasks](https://www.enginatics.com/library/?pg=1&find=wms_dispatched_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload), [wms_license_plate_numbers](https://www.enginatics.com/library/?pg=1&find=wms_license_plate_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload)

## Related Reports
[WSH Shipping/Delivery Transactions](/WSH%20Shipping-Delivery%20Transactions/ "WSH Shipping/Delivery Transactions Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [INV Period Close Pending Transactions](/INV%20Period%20Close%20Pending%20Transactions/ "INV Period Close Pending Transactions Oracle EBS SQL Report"), [INV Move Orders](/INV%20Move%20Orders/ "INV Move Orders Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WSH%20Pick%20Confirm%20Upload/WSH%20Pick%20Confirm%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/wsh-pick-confirm-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload) |
| Blitz Report™ XML Import | [WSH_Pick_Confirm_Upload.xml](https://www.enginatics.com/xml/wsh-pick-confirm-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload) |
| SQL Source | [WSH Pick Confirm Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WSH%20Pick%20Confirm%20Upload/WSH%20Pick%20Confirm%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/wsh-pick-confirm-upload/](https://www.enginatics.com/reports/wsh-pick-confirm-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload) |

## Case Study & Technical Analysis: WSH Pick Confirm Upload

### Executive Summary
The WSH Pick Confirm Upload confirms released sales order pick tasks in bulk from Excel in Oracle Shipping Execution. Warehouse operators download the released-to-warehouse lines of an organization, correct the picked quantity, subinventory, locator and lot where the pick differs, enter the license plate number in WMS-enabled organizations, and upload the result. Each pick task is confirmed through the standard pick confirm API, which moves the material to the staging subinventory and sets the delivery line to Staged/Pick Confirmed. The upload can also ship confirm a delivery once its last released line has been confirmed. The report runs in Excel via Blitz Report, and serial controlled items are not supported.

### Business Challenge
*   **High pick volume:** Confirming pick tasks one at a time in the mobile or forms interface is slow when a wave or a pick list covers many lines.
*   **Pick differences:** Operators often pick a different quantity, lot, subinventory or locator from the one allocated, and each difference must be recorded accurately.
*   **Staging and LPN control:** Material must be moved to the staging subinventory and packed into license plates in WMS organizations before shipping.
*   **Shipping cut-off:** Deliveries should be ship confirmed as soon as their last line is picked, while unpicked quantities are backordered.

### The Solution
*   **Pre-filled allocations:** The download creates one row per pick allocation, and one row per allocated lot for lot controlled items, with the allocated values filled in.
*   **Overwrite where needed:** Operators overwrite the allocation where the pick differs, enter the LPN and upload.
*   **Confirm all option:** The Confirm All Downloaded Lines parameter pre-flags every row so an unchanged pick list can be uploaded as it is.
*   **Ship confirmation:** The Ship Confirm parameter ship confirms a delivery when its last released line has been confirmed, and backorders any unpicked quantity.
*   **LPN creation:** Unknown LPN names are created as new license plates in the organization.

### Technical Architecture (High Level)
#### Primary Tables
*   `MTL_MATERIAL_TRANSACTIONS_TEMP`: the pending move order transactions, one per pick allocation, with subinventory, locator, quantity and staging details.
*   `MTL_TRANSACTION_LOTS_TEMP`: the lot allocations of lot controlled pick allocations.
*   `MTL_TXN_REQUEST_LINES`, `MTL_TXN_REQUEST_HEADERS`: the move order lines and headers, which carry the move order number.
*   `WSH_DELIVERY_DETAILS`: the delivery lines, with the released status and the move order line link.
*   `WSH_DELIVERY_ASSIGNMENTS`, `WSH_NEW_DELIVERIES`: the delivery assignment and the delivery.
*   `WSH_DELIVERY_LEGS`, `WSH_TRIP_STOPS`, `WSH_TRIPS`: the trip that the delivery belongs to.
*   `OE_ORDER_HEADERS_ALL`, `OE_ORDER_LINES_ALL`: the sales order and line.
*   `HZ_CUST_ACCOUNTS`, `HZ_PARTIES`, `HZ_CUST_SITE_USES_ALL`: the customer and ship-to site.
*   `WMS_DISPATCHED_TASKS`: the dispatched WMS task and its status.
*   `WMS_LICENSE_PLATE_NUMBERS`: the license plate used for the transfer.
*   `MTL_ITEM_LOCATIONS_KFV`, `MTL_SYSTEM_ITEMS_VL`, `MTL_PARAMETERS`: the locator, item and organization.

#### Logical Relationships
1. `MTL_PARAMETERS` is joined to `MTL_MATERIAL_TRANSACTIONS_TEMP` on organization, restricted to sales order transactions by transaction source type.
2. `MTL_MATERIAL_TRANSACTIONS_TEMP` is joined to `WSH_DELIVERY_DETAILS` on move order line, with the line in released status.
3. `WSH_DELIVERY_DETAILS` is joined to `OE_ORDER_LINES_ALL`, then to `OE_ORDER_HEADERS_ALL`, the customer account, the party and the ship-to site.
4. `WSH_DELIVERY_DETAILS` is outer joined to `WSH_DELIVERY_ASSIGNMENTS` and `WSH_NEW_DELIVERIES` to find the delivery.
5. The lot allocations, move order lines and WMS dispatched tasks are outer joined on the transaction temporary identifier.
6. The pick and staging locators and the transfer license plate are outer joined on their identifiers.
7. The trip name is a `listagg` over distinct trip names reached through the delivery legs and trip stops.

### Parameters & Filtering
*   **Organization Code:** Restricts the download to one organization.
*   **Order Number, Delivery, Trip, Move Order, Customer, Item:** Restrict the downloaded lines to the chosen sales order, delivery, trip, pick slip or move order, customer or item.
*   **Confirm All Downloaded Lines:** When set, every downloaded row is pre-flagged for upload.
*   **Ship Confirm:** When set, the upload ship confirms a delivery once its last released line has been confirmed.

### Performance & Optimization
*   The main extraction joins the pending move order transactions to the released delivery lines, so only released lines with allocations are read.
*   Lot, WMS task and move order lookups are outer joins on the transaction identifier, so lines without lots or tasks are kept without duplication beyond the lot rows.
*   The trip name aggregation runs as a correlated subquery over distinct delivery and trip pairs, which is evaluated per delivery row.

### FAQ
**Q: Why does one order line appear on several rows?**
A: One row is created per pick allocation, and per allocated lot for lot controlled items, so a line picked from several locations or lots appears several times.

**Q: How do I pick an unchanged pick list quickly?**
A: Set Confirm All Downloaded Lines so every row is pre-flagged, then upload the file without changes.

**Q: Are serial controlled items supported?**
A: No. The description states that serial controlled items are not supported by this upload.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-pick-confirm-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
