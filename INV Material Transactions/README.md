---
layout: default
title: 'INV Material Transactions | Oracle EBS SQL Report'
description: 'Detail report of Inventory transactions with item, primary qty, secondary qty, transaction type, transaction ID and total transaction qty'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Material, Transactions, gl_periods, mtl_item_locations_kfv, gl_ledgers'
permalink: /INV%20Material%20Transactions/
---

# INV Material Transactions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-material-transactions/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Detail report of Inventory transactions with item, primary qty, secondary qty, transaction type, transaction ID and total transaction qty

## Report Parameters
Operating Unit, Organization Code, Subinventory, Item, Item Description, Category Set 1, Category Set 2, Category Set 3, Transaction within Days, Transaction Date From, Transaction Date To, Source Type, Exclude Source Type, Action, Exclude Action, Transaction Type, Supplier, Project, Show Lots, Exclude Transaction Type, Created By, Exclude Logical Transactions

## Oracle EBS Tables Used
[gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types), [mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations), [mtl_transaction_reasons](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_reasons), [mtl_generic_dispositions](https://www.enginatics.com/library/?pg=1&find=mtl_generic_dispositions), [mtl_sales_orders](https://www.enginatics.com/library/?pg=1&find=mtl_sales_orders), [cst_cost_updates](https://www.enginatics.com/library/?pg=1&find=cst_cost_updates), [mtl_cycle_count_headers](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_headers), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [mtl_physical_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_physical_inventories), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers), [okc_k_headers_all_b](https://www.enginatics.com/library/?pg=1&find=okc_k_headers_all_b), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [mtl_txn_request_headers](https://www.enginatics.com/library/?pg=1&find=mtl_txn_request_headers), [mtl_transaction_lot_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_lot_numbers), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[INV Material Account Distribution Detail](/INV%20Material%20Account%20Distribution%20Detail/ "INV Material Account Distribution Detail Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [CAC Deferred COGS Out-of-Balance](/CAC%20Deferred%20COGS%20Out-of-Balance/ "CAC Deferred COGS Out-of-Balance Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report"), [CAC Missing WIP Accounting Transactions](/CAC%20Missing%20WIP%20Accounting%20Transactions/ "CAC Missing WIP Accounting Transactions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Material Transactions 24-Jul-2017 143718.xlsx](https://www.enginatics.com/example/inv-material-transactions/) |
| Blitz Report™ XML Import | [INV_Material_Transactions.xml](https://www.enginatics.com/xml/inv-material-transactions/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-material-transactions/](https://www.enginatics.com/reports/inv-material-transactions/) |

## Case Study & Technical Analysis: INV Material Transactions

### Executive Summary
The **INV Material Transactions** report is the definitive audit trail for all inventory movements within the Oracle E-Business Suite. It captures every receipt, issue, transfer, and adjustment, providing a granular history of stock activity. This report is indispensable for Warehouse Managers, Cost Accountants, and Auditors to ensure inventory accuracy, investigate variances, and maintain compliance.

### Business Challenge
Inventory is often the largest asset on a company's balance sheet, yet it is prone to errors.
*   **Loss of Control:** Without detailed tracking, it is impossible to know *who* moved stock, *when* it moved, and *where* it went.
*   **Reconciliation Nightmares:** When physical counts don't match system records, finding the discrepancy requires digging through thousands of transactions.
*   **Compliance Risks:** For regulated industries, tracing the history of a specific Lot or Serial number is a legal requirement.

### The Solution
This report provides a powerful search engine for the `MTL_MATERIAL_TRANSACTIONS` table, offering a complete **Operational View** of material flow.
*   **Root Cause Analysis:** Users can filter by specific items or transaction types (e.g., "Account Alias Issue") to identify process gaps or theft.
*   **Audit Readiness:** It provides a complete lineage for any item, showing the exact time, user, and reference document (e.g., PO or Sales Order) for every move.
*   **Cost Visibility:** It often includes transaction costs, helping cost accountants validate the value of inventory updates.

### Technical Architecture (High Level)
The report queries the core inventory transaction history table, which is typically one of the largest tables in an Oracle EBS database.

*   **Primary Tables:**
    *   `MTL_MATERIAL_TRANSACTIONS` (MMT): The massive header table containing all transaction data.
    *   `MTL_SYSTEM_ITEMS_B`: Item master data (Description, UOM).
    *   `MTL_TRANSACTION_TYPES`: Definitions of transaction actions (e.g., "PO Receipt", "Subinventory Transfer").
    *   `ORG_ORGANIZATION_DEFINITIONS`: Organization names and codes.
    *   `MTL_TRANSACTION_LOT_NUMBERS`: (Joined if needed) For lot-controlled items.
*   **Logical Relationships:**
    *   MMT is the center of the star schema. It joins to `MTL_SYSTEM_ITEMS_B` on `INVENTORY_ITEM_ID` and `ORGANIZATION_ID`.
    *   It links to `MTL_TRANSACTION_TYPES` on `TRANSACTION_TYPE_ID` to decode the nature of the move.
    *   Source documents are linked via `TRANSACTION_SOURCE_ID` (which can point to PO headers, WIP Jobs, or Sales Orders depending on the Source Type).

### Parameters & Filtering
*   **Organization Code / Subinventory:** Essential for narrowing the scope to a specific warehouse or storage location.
*   **Item / Item Description:** Allows tracing the history of a single product.
*   **Transaction Date From/To:** Filters the massive dataset to a manageable time window.
*   **Transaction Type / Source Type:** Critical for specific analysis (e.g., "Show me all 'Sales Order Issues' to analyze shipping volume").
*   **Show Lots:** A parameter to optionally join lot details, which can expand the row count significantly but is necessary for lot traceability.

### Performance & Optimization
*   **Indexed Access:** The query is heavily dependent on the composite indexes on `MTL_MATERIAL_TRANSACTIONS` (typically `INVENTORY_ITEM_ID`, `ORGANIZATION_ID`, and `TRANSACTION_DATE`).
*   **Partition Pruning:** In large environments, MMT is often partitioned by date. Using the "Transaction Date" parameter allows the database to skip scanning older partitions, drastically improving speed.
*   **Avoid XML Parsing:** By extracting directly to Excel/Text, the report avoids the heavy memory usage associated with rendering millions of transaction lines in standard PDF reports.

### FAQ
**Q: Why can't I see the cost for some transactions?**
A: If the organization uses Standard Costing, costs are typically updated periodically or may not be stamped on every transaction type in the same way as Average Costing. Also, some "Logical" transactions might not carry a value impact in the same way as physical moves.

**Q: Does this report show serial numbers?**
A: Standard Material Transaction reports focus on Quantity and Lot. Serial numbers are stored in a child table (`MTL_UNIT_TRANSACTIONS`). While some versions of this report join to that table, it often multiplies the row count (one row per serial), so it is sometimes a separate option or report.

**Q: What is the difference between "Transaction Date" and "Creation Date"?**
A: "Transaction Date" is when the movement physically occurred (or was backdated to). "Creation Date" is when the record was actually entered into the system. Large gaps between these two can indicate process issues (e.g., users entering data days after the work was done).


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
