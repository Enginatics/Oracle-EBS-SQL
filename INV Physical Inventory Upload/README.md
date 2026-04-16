---
layout: default
title: 'INV Physical Inventory Upload | Oracle EBS SQL Report'
description: 'This upload supports the creation of new Physical Inventories and the update of existing Physical Inventories that have not yet been frozen. The upload…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, INV, Physical, Inventory, mtl_physical_inventories_v, mtl_physical_subinventories, mtl_parameters'
permalink: /INV%20Physical%20Inventory%20Upload/
---

# INV Physical Inventory Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-physical-inventory-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
This upload supports the creation of new Physical Inventories and the update of existing Physical Inventories that have not yet been frozen.

The upload supports the specification of the subinventories to be included in the Physical Inventory. 

When updating an existing Physical Inventory, the Delete Subinventory upload column allows for individual subinventories to be removed from the Physical Inventory subinventory list.

Replace Existing Subinventories
==========================
When the Replace Existing Subinventories report parameter is set to Yes, the existing physical inventory subinventories will be replaced by those specified in the upload.

When set to No, the upload will update the existing Physical Inventory subinventories, create additional subinventories, or delete specific subinventories as determined from the uploaded data.

Freeze Physical Inventory
===================== 
When set to Yes, the Freeze Physical Inventory concurrent program will be submitted after the upload is complete to freeze the uploaded Physical Inventories.

This will only occur for each uploaded Physical Inventory if no upload error has occurred in any upload row for that Physical Inventory.

Once a Physical Inventory has been frozen, it can no longer be updated by this upload.

The Snapshot Complete and Freeze Date columns in the upload excel are display only columns. They will be displayed after the upload when the Freeze Physical Inventory option is selected.  


## Report Parameters
Upload Mode, Replace Existing Subinventories, Freeze Physical Inventory, Organization Code, Physical Inventory

## Oracle EBS Tables Used
[mtl_physical_inventories_v](https://www.enginatics.com/library/?pg=1&find=mtl_physical_inventories_v), [mtl_physical_subinventories](https://www.enginatics.com/library/?pg=1&find=mtl_physical_subinventories), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Physical Inventory Purge Upload](/INV%20Physical%20Inventory%20Purge%20Upload/ "INV Physical Inventory Purge Upload Oracle EBS SQL Report"), [CAC Recost Cost of Goods Sold](/CAC%20Recost%20Cost%20of%20Goods%20Sold/ "CAC Recost Cost of Goods Sold Oracle EBS SQL Report"), [CAC Deferred COGS Out-of-Balance](/CAC%20Deferred%20COGS%20Out-of-Balance/ "CAC Deferred COGS Out-of-Balance Oracle EBS SQL Report"), [INV Material Transactions](/INV%20Material%20Transactions/ "INV Material Transactions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/inv-physical-inventory-upload/) |
| Blitz Report™ XML Import | [INV_Physical_Inventory_Upload.xml](https://www.enginatics.com/xml/inv-physical-inventory-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-physical-inventory-upload/](https://www.enginatics.com/reports/inv-physical-inventory-upload/) |

## INV Physical Inventory Upload - Case Study & Technical Analysis

### Executive Summary
The **INV Physical Inventory Upload** is a setup and maintenance tool for the physical inventory process. It allows users to create the "Header" definition of a physical inventory and assign subinventories to it in bulk. This is particularly useful for large organizations that run multiple physical inventories simultaneously or have hundreds of subinventories to assign.

### Business Challenge
Setting up a physical inventory in Oracle involves:
1.  Defining the name and date.
2.  Manually selecting which subinventories are included.
3.  Freezing the inventory (taking the snapshot).
Doing this manually for 50 warehouses is tedious and prone to setup errors (e.g., forgetting to include the "Returns" subinventory).

### Solution
The **INV Physical Inventory Upload** automates the definition phase. Users can define the scope of the count in Excel and upload it.

**Key Features:**
-   **Header Creation:** Creates the Physical Inventory definition (Name, Date, Org).
-   **Scope Definition:** Assigns specific subinventories to the count.
-   **Snapshot Trigger:** Can optionally trigger the "Freeze" process immediately after upload.
-   **Update Mode:** Can update existing definitions (e.g., adding a missed subinventory) before the freeze.

### Technical Architecture
The tool interacts with the physical inventory definition tables and submits concurrent requests.

#### Key Tables and Views
-   **`MTL_PHYSICAL_INVENTORIES`**: The header table.
-   **`MTL_PHYSICAL_SUBINVENTORIES`**: The table linking subinventories to the physical inventory.
-   **`MTL_PARAMETERS`**: Organization validation.

#### Core Logic
1.  **Upload:** Reads the configuration from Excel.
2.  **Creation:** Inserts records into `MTL_PHYSICAL_INVENTORIES` and `MTL_PHYSICAL_SUBINVENTORIES`.
3.  **Process Submission:** If "Freeze" is selected, it submits the `INV_PHY_INV_SNAPSHOT` concurrent program.

### Business Impact
-   **Standardization:** Ensures all warehouses are set up with consistent naming conventions and parameters.
-   **Completeness:** Reduces the risk of missing subinventories during the count.
-   **Efficiency:** Allows a central inventory team to set up counts for remote sites without logging into each org individually.


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
