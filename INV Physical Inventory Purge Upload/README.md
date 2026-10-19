---
layout: default
last_modified_at: 2026-10-19
title: 'INV Physical Inventory Purge Upload | Oracle EBS SQL Report'
description: 'This upload supports the purging of existing Physical Inventories. For each Physical Inventory to be purged the user can select to purge the tags only, or…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, INV, Physical, Inventory, Purge, mtl_physical_inventories_v, mtl_parameters, org_access_view'
permalink: /INV%20Physical%20Inventory%20Purge%20Upload/
report_name: 'INV Physical Inventory Purge Upload'
report_web_name: inv-physical-inventory-purge-upload
---

# INV Physical Inventory Purge Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-physical-inventory-purge-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-purge-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-purge-upload).

## Overview
This upload supports the purging of existing Physical Inventories. 

For each Physical Inventory to be purged the user can select to purge the tags only, or to purge the full Physical Inventory.

On upload, the upload process will submit the standard 'Purge physical inventory information' concurrent program for each Physical Inventory to be purged.

To improve performance of the upload process, the upload does not wait for completion of the purge concurrent requests before completing.

The ‘Create, Update’ upload mode can be used to first download the Physical Inventories to be purged for initial review and selection.

Alternatively, the ‘Create’ upload mode can be used to generate an empty upload excel into which the details of the Physical Inventories to be purged can be pasted. In this mode the only columns that need to be populated in the excel are the Organization Code, Physical Inventory Name, and the Purge Option.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-purge-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Default Purge Option, Organization Code, Physical Inventory, Physical Inventory Like, Physical Inventory Date From, Physical Inventory Date To, Phys. Inv. Date Older Than (Mths), Snapshot Complete

## Oracle EBS Tables Used
[mtl_physical_inventories_v](https://www.enginatics.com/library/?pg=1&find=mtl_physical_inventories_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-purge-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-purge-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-purge-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-purge-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-purge-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-purge-upload)

## Related Reports
[CAC Recost Cost of Goods Sold](/CAC%20Recost%20Cost%20of%20Goods%20Sold/ "CAC Recost Cost of Goods Sold Oracle EBS SQL Report"), [CAC Deferred COGS Out-of-Balance](/CAC%20Deferred%20COGS%20Out-of-Balance/ "CAC Deferred COGS Out-of-Balance Oracle EBS SQL Report"), [INV Physical Inventory Upload](/INV%20Physical%20Inventory%20Upload/ "INV Physical Inventory Upload Oracle EBS SQL Report"), [INV Physical Inventory Locator Count Sheet](/INV%20Physical%20Inventory%20Locator%20Count%20Sheet/ "INV Physical Inventory Locator Count Sheet Oracle EBS SQL Report"), [INV Material Transactions](/INV%20Material%20Transactions/ "INV Material Transactions Oracle EBS SQL Report"), [INV Physical inventory accuracy analysis](/INV%20Physical%20inventory%20accuracy%20analysis/ "INV Physical inventory accuracy analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Physical%20Inventory%20Purge%20Upload/INV%20Physical%20Inventory%20Purge%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-purge-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/inv-physical-inventory-purge-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-purge-upload) |
| Blitz Report™ XML Import | [INV_Physical_Inventory_Purge_Upload.xml](https://www.enginatics.com/xml/inv-physical-inventory-purge-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-purge-upload) |
| SQL Source | [INV Physical Inventory Purge Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Physical%20Inventory%20Purge%20Upload/INV%20Physical%20Inventory%20Purge%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-physical-inventory-purge-upload/](https://www.enginatics.com/reports/inv-physical-inventory-purge-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-purge-upload) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-purge-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-purge-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-purge-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-purge-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-purge-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-purge-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-physical-inventory-purge-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
