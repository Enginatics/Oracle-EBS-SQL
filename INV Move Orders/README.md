---
layout: default
last_modified_at: 2026-10-19
title: 'INV Move Orders | Oracle EBS SQL Report'
description: 'Move order lines of all move order types (requisition, replenishment, pick wave, manufacturing component pick, put away), one row per line, with…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Inventory, Enginatics, INV, Move, Orders, mtl_item_locations_kfv, gl_code_combinations_kfv, wsh_delivery_assignments'
permalink: /INV%20Move%20Orders/
report_name: 'INV Move Orders'
report_web_name: inv-move-orders
module: 'Inventory'
module_url: /modules/inventory/
---

# INV Move Orders – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-move-orders/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders).
**Oracle EBS module:** [Inventory](/modules/inventory/ "Oracle EBS Inventory reports") · [all Inventory reports](/modules/inventory/)  

## Overview
Move order lines of all move order types (requisition, replenishment, pick wave, manufacturing component pick, put away), one row per line, with requested, allocated (detailed), delivered, unallocated and open quantity.

Unallocated and open quantity are shown for open lines only. Source shows the sales order, WIP job, purchase order or internal requisition the line was created for; Reference Source and Kanban Card identify replenishment move orders created by kanban, min-max or replenishment counts.

Show Allocations lists the pending allocations (subinventory, locator and lot) of each line, repeating the line quantities on each allocation row.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Move Order Type, Move Order, Line Status, Open Lines Only, Unallocated Only, Item, From Subinventory, To Subinventory, Date Required From, Date Required To, Creation Date From, Creation Date To, Created By, Show Allocations, DFF Display

## Oracle EBS Tables Used
[mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [wsh_delivery_assignments](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [wsh_new_deliveries](https://www.enginatics.com/library/?pg=1&find=wsh_new_deliveries&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [mtl_txn_request_headers](https://www.enginatics.com/library/?pg=1&find=mtl_txn_request_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [mtl_txn_request_lines](https://www.enginatics.com/library/?pg=1&find=mtl_txn_request_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [mtl_sales_orders](https://www.enginatics.com/library/?pg=1&find=mtl_sales_orders&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [rcv_shipment_lines](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [po_requisition_lines_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [mtl_kanban_cards](https://www.enginatics.com/library/?pg=1&find=mtl_kanban_cards&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [mtl_transaction_reasons](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_reasons&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [mtl_material_transactions_temp](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions_temp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders)

## Related Reports
[WSH Pick Confirm Upload](/WSH%20Pick%20Confirm%20Upload/ "WSH Pick Confirm Upload Oracle EBS SQL Report"), [WSH Shipping/Delivery Transactions](/WSH%20Shipping-Delivery%20Transactions/ "WSH Shipping/Delivery Transactions Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Move%20Orders/INV%20Move%20Orders.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Move Orders 15-Oct-2026 022611.xlsx](https://www.enginatics.com/example/inv-move-orders/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders) |
| Blitz Report™ XML Import | [INV_Move_Orders.xml](https://www.enginatics.com/xml/inv-move-orders/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders) |
| SQL Source | [INV Move Orders.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Move%20Orders/INV%20Move%20Orders.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-move-orders/](https://www.enginatics.com/reports/inv-move-orders/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders) |

## Case Study & Technical Analysis: INV Move Orders

### Executive Summary
The INV Move Orders report lists Oracle Inventory move order lines across all move order types, one row per line. Each row shows the requested, allocated, delivered, unallocated and open quantity, together with the source the line was created for. Warehouse supervisors, inventory planners and material handlers use it to see which moves are waiting for stock to be allocated, which are still open, and which have been delivered. It covers requisition, replenishment, pick wave, manufacturing component pick and put away move orders, and it can list the pending allocations for each line.

### Business Challenge
*   **Stalled moves:** Move order lines that cannot be allocated leave material stranded or work waiting, and supervisors need a list of unallocated lines to act on.
*   **Mixed move order types:** A warehouse runs several move order types at once, and each has different sources and workflows, so one view by type is needed.
*   **Traceability to demand:** Each move must be linked to the sales order, WIP job, purchase order or internal requisition that caused it, so the business reason is clear.

### The Solution
*   **Quantity breakdown per line:** Requested, allocated (detailed), delivered, unallocated and open quantities are returned together.
*   **Open-line logic:** Unallocated and open quantities are calculated only for lines in the open statuses, so closed lines do not show a backlog.
*   **Source resolution:** The source is shown as the sales order, WIP entity, purchase order or requisition the line was created for, with the source line where applicable.
*   **Allocation detail:** When Show Allocations is set to Yes, each pending allocation appears on its own row with its subinventory, locator and lot, and the line quantities repeat on each row.

### Technical Architecture (High Level)
#### Primary Tables
*   `MTL_TXN_REQUEST_HEADERS`: the move order header, with its request number, type and header status.
*   `MTL_TXN_REQUEST_LINES`: the move order lines, with item, quantities, subinventories, locators, dates, reference and source fields.
*   `MTL_MATERIAL_TRANSACTIONS_TEMP`: the pending allocations, read only when Show Allocations is Yes.
*   `MTL_SYSTEM_ITEMS_VL`: the item, revision and description.
*   `MTL_ITEM_LOCATIONS_KFV`: the from and to locators.
*   `MTL_PARAMETERS`: the organization code.
*   `MTL_TRANSACTION_TYPES`, `MTL_TXN_SOURCE_TYPES` and `MTL_TRANSACTION_REASONS`: the transaction type, source type and reason.
*   `MTL_SALES_ORDERS`, `OE_ORDER_LINES_ALL` and `OE_ORDER_HEADERS_ALL`: the sales order source and the customer order lines.
*   `HZ_CUST_ACCOUNTS` and `HZ_PARTIES`: the customer on the sales order.
*   `WIP_ENTITIES`: the WIP job source.
*   `PO_HEADERS_ALL`, `PO_LINES_ALL` and `PO_LINE_LOCATIONS_ALL`: the purchase order source.
*   `RCV_SHIPMENT_LINES`, `PO_REQUISITION_HEADERS_ALL` and `PO_REQUISITION_LINES_ALL`: the receiving and internal requisition links.
*   `MTL_KANBAN_CARDS`: the kanban card for replenishment moves.
*   `WSH_DELIVERY_ASSIGNMENTS` and `WSH_NEW_DELIVERIES`: the delivery that carries the move.
*   `PA_PROJECTS_ALL` and `PA_TASKS`: the project and task on the line.
*   `GL_CODE_COMBINATIONS_KFV`: the to-account of the line.
*   `ORG_ACCESS_VIEW`: the organizations the responsibility can access.

#### Logical Relationships
1.  `MTL_PARAMETERS` is restricted to the organizations of the current responsibility through `ORG_ACCESS_VIEW`, and joined to the move order lines.
2.  Each line is joined to its header, to its item in `MTL_SYSTEM_ITEMS_VL`, and to its transaction type and source type.
3.  The source is resolved by source type. Sales order types 2, 8 and 12 join to `MTL_SALES_ORDERS` and `OE_ORDER_LINES_ALL`, type 5 joins to `WIP_ENTITIES`, type 1 joins to the purchase order chain, and type 7 joins to the requisition chain.
4.  Reference-based links are then applied: a purchase order line location, a receipt shipment line, a requisition line, or a kanban card, depending on the reference type.

### Parameters & Filtering
*   **Organization Code, Move Order Type and Move Order:** Select the organization, the move order type and a specific move order.
*   **Line Status, Open Lines Only and Unallocated Only:** Control which line statuses are shown, and limit the output to open or unallocated lines.
*   **Item, From Subinventory and To Subinventory:** Restrict the lines by item or by the subinventories moved from and to.
*   **Date Required From and To, Creation Date From and To, Created By:** Restrict the lines by required date, creation date or creator.
*   **Show Allocations:** Adds the pending allocation rows to each line.
*   **DFF Display:** Controls the display of the descriptive flexfield columns.

### Performance & Optimization
*   **Organization access restriction:** The organization filter runs through `ORG_ACCESS_VIEW` for the current responsibility, so the lines come only from organizations the user can see.
*   **Source joins by type:** Each source table is joined only when the source type matches, using CASE expressions on the source type and reference, so a line joins to one source chain rather than to all of them.
*   **Allocation rows only on request:** The temporary allocation table is read only when Show Allocations is Yes, so the default run avoids that join.

### FAQ
**Q: How do I find move orders that are waiting for allocation?**
A: Set Unallocated Only to Yes, and optionally Open Lines Only, to list open lines whose quantity is not yet allocated.
**Q: How do I see which subinventory and locator a move is allocated from?**
A: Set Show Allocations to Yes. Each pending allocation then appears on its own row with its subinventory, locator and lot.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-move-orders)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
