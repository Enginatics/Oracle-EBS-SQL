---
layout: default
title: 'INV Physical Inventory Purge Upload | Oracle EBS SQL Report'
description: 'This upload supports the purging of existing Physical Inventories. For each Physical Inventory to be purged the user can select to purge the tags only, or…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, INV, Physical, Inventory, Purge, mtl_physical_inventories_v, mtl_parameters, org_access_view'
permalink: /INV%20Physical%20Inventory%20Purge%20Upload/
---

# INV Physical Inventory Purge Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-physical-inventory-purge-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
This upload supports the purging of existing Physical Inventories. 

For each Physical Inventory to be purged the user can select to purge the tags only, or to purge the full Physical Inventory.

On upload, the upload process will submit the standard 'Purge physical inventory information' concurrent program for each Physical Inventory to be purged.

To improve performance of the upload process, the upload does not wait for completion of the purge concurrent requests before completing.

The ‘Create, Update’ upload mode can be used to first download the Physical Inventories to be purged for initial review and selection.

Alternatively, the ‘Create’ upload mode can be used to generate an empty upload excel into which the details of the Physical Inventories to be purged can be pasted. In this mode the only columns that need to be populated in the excel are the Organization Code, Physical Inventory Name, and the Purge Option. 


## Report Parameters
Upload Mode, Default Purge Option, Organization Code, Physical Inventory, Physical Inventory Like, Physical Inventory Date From, Physical Inventory Date To, Phys. Inv. Date Older Than (Mths), Snapshot Complete

## Oracle EBS Tables Used
[mtl_physical_inventories_v](https://www.enginatics.com/library/?pg=1&find=mtl_physical_inventories_v), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[CAC Recost Cost of Goods Sold](/CAC%20Recost%20Cost%20of%20Goods%20Sold/ "CAC Recost Cost of Goods Sold Oracle EBS SQL Report"), [CAC Deferred COGS Out-of-Balance](/CAC%20Deferred%20COGS%20Out-of-Balance/ "CAC Deferred COGS Out-of-Balance Oracle EBS SQL Report"), [INV Physical Inventory Upload](/INV%20Physical%20Inventory%20Upload/ "INV Physical Inventory Upload Oracle EBS SQL Report"), [INV Material Transactions](/INV%20Material%20Transactions/ "INV Material Transactions Oracle EBS SQL Report"), [INV Physical inventory accuracy analysis](/INV%20Physical%20inventory%20accuracy%20analysis/ "INV Physical inventory accuracy analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/inv-physical-inventory-purge-upload/) |
| Blitz Report™ XML Import | [INV_Physical_Inventory_Purge_Upload.xml](https://www.enginatics.com/xml/inv-physical-inventory-purge-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-physical-inventory-purge-upload/](https://www.enginatics.com/reports/inv-physical-inventory-purge-upload/) |

## INV Physical Inventory Purge Upload - Case Study & Technical Analysis

### Executive Summary
The **INV Physical Inventory Purge Upload** is a utility tool designed to clean up historical physical inventory data. Over time, the `MTL_PHYSICAL_INVENTORIES` and related tag tables can grow significantly, cluttering the system and slowing down performance. This tool allows for the bulk purging of old inventory counts.

### Business Challenge
Oracle Inventory retains physical inventory history indefinitely unless explicitly purged.
-   **Data Clutter:** Users see a list of 50 old physical inventories when they open the form, making it hard to find the current one.
-   **Performance:** Large volumes of historical tag data can slow down the generation of new tags.
-   **Compliance:** Data retention policies may dictate that data older than 7 years should be removed.

### Solution
The **INV Physical Inventory Purge Upload** provides an Excel-based interface to manage the purging process. Instead of running the purge program manually for each inventory, users can list them in Excel and upload the request.

**Key Features:**
-   **Bulk Processing:** Purge multiple physical inventories in one go.
-   **Selective Purge:** Option to purge "Tags Only" (keeping the header) or the "Full Physical Inventory".
-   **Safety Checks:** Validates that the inventory is closed before allowing a purge.

### Technical Architecture
This is a WebADI or Blitz Report Upload style tool that interfaces with the standard Oracle concurrent programs.

#### Key Tables and Views
-   **`MTL_PHYSICAL_INVENTORIES_V`**: View used to select inventories eligible for purge.
-   **`MTL_PARAMETERS`**: Organization validation.

#### Core Logic
1.  **Upload:** Reads the list of Physical Inventory Names and Organization Codes from Excel.
2.  **Validation:** Checks if the inventory exists and is in a state that allows purging.
3.  **Execution:** Submits the standard "Purge Physical Inventory" concurrent request for each valid row.

### Business Impact
-   **System Hygiene:** Keeps the database clean and the user interface uncluttered.
-   **Performance:** Improves the speed of future physical inventory setups.
-   **Efficiency:** Reduces the administrative burden of database maintenance.


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
