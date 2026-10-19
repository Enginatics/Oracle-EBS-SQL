---
layout: default
last_modified_at: 2026-10-19
title: 'OPM Batch Lot Genealogy | Oracle EBS SQL Report'
description: 'Oracle Process Manufacturing (OPM) batch lot genealogy as a multi-level tree, as shown in the Source and Where Used tabs of the Oracle Genealogy form…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Process Manufacturing, Enginatics, OPM, Batch, Lot, Genealogy, mtl_system_items_vl, dual, po_headers_all'
permalink: /OPM%20Batch%20Lot%20Genealogy/
report_name: 'OPM Batch Lot Genealogy'
report_web_name: opm-batch-lot-genealogy
module: 'Process Manufacturing'
module_url: /modules/process-manufacturing/
---

# OPM Batch Lot Genealogy – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/opm-batch-lot-genealogy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy).
**Oracle EBS module:** [Process Manufacturing](/modules/process-manufacturing/ "Oracle EBS Process Manufacturing reports") · [all Process Manufacturing reports](/modules/process-manufacturing/)  

## Overview
Oracle Process Manufacturing (OPM) batch lot genealogy as a multi-level tree, as shown in the Source and Where Used tabs of the Oracle Genealogy form.

Source walks from a lot through its producing batch to the ingredient lots, to any depth. Where Used walks from a lot through the consuming batches to the product lots. Each tree starts with its start lot at level 0.

Each row is a lot or batch with its level, lot status, grade, dates and the WIP issue or completion that created the link. Ended genealogy links are excluded.

Source, Supplier and Supplier Site show each lot's origination as in the form: the document and trading partner of the lot's first transaction. Supplier Site is shown for purchase order receipts only.

Without an Item or Lot Number, only lots with no other lot above them in the chosen direction start a tree, so each chain is listed once instead of under every lot within it. Enter an Item or Lot Number to see the tree of any lot.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Item, Lot Number like, Direction

## Oracle EBS Tables Used
[mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy), [mtl_transaction_lot_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_lot_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy), [mtl_object_genealogy](https://www.enginatics.com/library/?pg=1&find=mtl_object_genealogy&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy), [mtl_lot_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_lot_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy), [gme_batch_header](https://www.enginatics.com/library/?pg=1&find=gme_batch_header&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy), [mtl_serial_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_serial_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy), [mtl_material_statuses_vl](https://www.enginatics.com/library/?pg=1&find=mtl_material_statuses_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy)

## Related Reports
[INV Serial Numbers](/INV%20Serial%20Numbers/ "INV Serial Numbers Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [WSH Shipping/Delivery Transactions](/WSH%20Shipping-Delivery%20Transactions/ "WSH Shipping/Delivery Transactions Oracle EBS SQL Report"), [INV Onhand Quantities](/INV%20Onhand%20Quantities/ "INV Onhand Quantities Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Material Transactions](/INV%20Material%20Transactions/ "INV Material Transactions Oracle EBS SQL Report"), [CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OPM%20Batch%20Lot%20Genealogy/OPM%20Batch%20Lot%20Genealogy.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [OPM Batch Lot Genealogy 05-Jun-2026 120007.xlsx](https://www.enginatics.com/example/opm-batch-lot-genealogy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy) |
| Blitz Report™ XML Import | [OPM_Batch_Lot_Genealogy.xml](https://www.enginatics.com/xml/opm-batch-lot-genealogy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy) |
| SQL Source | [OPM Batch Lot Genealogy.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OPM%20Batch%20Lot%20Genealogy/OPM%20Batch%20Lot%20Genealogy.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/opm-batch-lot-genealogy/](https://www.enginatics.com/reports/opm-batch-lot-genealogy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy) |

## Case Study & Technical Analysis: OPM Batch Lot Genealogy

### Executive Summary
This report shows lot genealogy in Oracle Process Manufacturing (OPM) as a multi-level tree. It reproduces the Source and Where Used views of the Oracle Genealogy form: the Source tree walks from a lot through the batch that produced it to the ingredient lots, to any depth, and the Where Used tree walks from a lot through the batches that consumed it to the product lots. It is used by quality, recall and traceability teams in process industries, who must answer which raw material lots went into a finished lot, and which finished lots contain a given ingredient lot. Each row is a lot or batch with its level in the tree, its status and grade, its dates and the transaction that created the link.

### Business Challenge
*   **Traceability for recalls:** When an ingredient lot is found to be defective, every batch and finished lot that used it must be identified quickly.
*   **Origin of a lot:** The supplier, purchase order and supplier site of the lot must be known to contain a supplier issue.
*   **Multi-level chains:** A finished lot can be made from intermediate lots that were themselves made from other lots, so the chain must be followed through several levels.

### The Solution
*   Builds the genealogy tree from the `MTL_OBJECT_GENEALOGY` links, starting at the lot and walking up or down the chain to any depth, with the start lot at level 0.
*   Shows, for each lot or batch, its level, object type, lot status, grade, origination date and expiration date.
*   Shows the source of each lot, its trading partner and, for purchase order receipts, the supplier site, from the first transaction of the lot.
*   Shows the genealogy type and the transaction type, transaction date, quantity and unit of measure of the transaction that created the link.
*   Without an item or lot number, starts a tree only at lots that have no other lot above them in the chosen direction, so each chain is listed once.

### Technical Architecture (High Level)
#### Primary Tables
*   `MTL_OBJECT_GENEALOGY`: the parent and child links between objects, with the genealogy type, origin transaction and end date.
*   `MTL_LOT_NUMBERS`: the lots, with the generic object identifier, status, grade, origination and expiration dates.
*   `MTL_MATERIAL_TRANSACTIONS` and `MTL_TRANSACTION_LOT_NUMBERS`: the transactions that created the lot links, and the lot of each transaction.
*   `MTL_TRANSACTION_TYPES`: the transaction type name.
*   `WIP_ENTITIES` and `GME_BATCH_HEADER`: the batch identifier, batch number and WIP entity of a batch.
*   `MTL_SERIAL_NUMBERS`: serial numbers that are genealogy objects.
*   `MTL_SYSTEM_ITEMS_VL` and `MTL_PARAMETERS`: the item and organization.
*   `MTL_MATERIAL_STATUSES_VL`: the lot status.
*   `PO_HEADERS_ALL` and `AP_SUPPLIER_SITES_ALL`: the purchase order and the supplier site of a receipt.
*   `ORG_ACCESS_VIEW`: the organizations the responsibility can access.

#### Logical Relationships
1. Active links are those whose end date is empty or in the future, so ended genealogy links are excluded.
2. A hierarchical CONNECT BY over the links walks the tree from the start objects, and the level and root are recorded.
3. The start objects are the lots that have no link above them in the chosen direction, or the lot named by the Item and Lot Number parameters.
4. Each object is joined to its lot, batch and serial number, and to its origin transaction through the lowest transaction identifier of the lot.
5. The tree is ordered by organization, item, starting lot, and the row number of the walk.

### Parameters & Filtering
*   **Organization Code:** selects the organization of the starting lot.
*   **Item:** selects the item of the starting lot, and restricts the trees to that item.
*   **Lot Number like:** selects starting lots by a lot number pattern.
*   **Direction:** chooses Source, which walks towards the ingredients, or Where Used, which walks towards the products.

### Performance & Optimization
*   Without an item or lot number, only the top lots of each chain start a tree, so a chain is not repeated for every lot inside it.
*   The origin transaction is found by a minimum-identifier subquery on each lot, which gives one origination transaction per lot.
*   The supplier site is looked up only for transactions whose source is a purchase order, so the purchase order tables are read only for receipts.

### FAQ
**Q: How do I find all lots that went into a finished lot?**
A: Enter the Item or Lot Number of the finished lot, and choose Source as the direction. The tree lists each ingredient lot and batch at its level.

**Q: How do I find all finished lots that contain an ingredient lot?**
A: Enter the ingredient lot number and choose Where Used. The tree lists the consuming batches and the product lots below them.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-batch-lot-genealogy)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
