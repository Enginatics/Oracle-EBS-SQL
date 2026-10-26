---
layout: default
last_modified_at: 2026-10-26
title: 'WSH Container Items Upload | Oracle EBS SQL Report'
description: 'Creates, updates and deletes container-item relationships - the Container-Item Relationships form (Shipping > Setup > Container Load Details). A…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, WSH, Container, Items, wsh_container_items, mtl_parameters, mtl_system_items_vl'
permalink: /WSH%20Container%20Items%20Upload/
report_name: 'WSH Container Items Upload'
report_web_name: wsh-container-items-upload
---

# WSH Container Items Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/wsh-container-items-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-container-items-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-container-items-upload).

## Overview
Creates, updates and deletes container-item relationships - the Container-Item Relationships form (Shipping > Setup > Container Load Details). A relationship states the maximum quantity of a load item that fits into a container item in one inventory organization; auto-pack uses the load item's preferred container.

Setting Preferred Flag to Yes removes the flag from the load item's current preferred container, as the form does after asking, and the Message names that container. When several rows of one file make different containers preferred for the same load item, the last row wins.

Maximum Quantity is rounded to five decimals and must be a whole number for serial controlled and indivisible load items.

Changing the Container Item or Load Item of a downloaded row moves that relationship. To remove a relationship, enter Yes in Delete Relationship.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-container-items-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Organization Code, Container Type, Container Item, Load Item, Preferred Flag

## Oracle EBS Tables Used
[wsh_container_items](https://www.enginatics.com/library/?pg=1&find=wsh_container_items&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-container-items-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-container-items-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-container-items-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-container-items-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-container-items-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-container-items-upload)

## Related Reports
[WSH Shipping/Delivery Transactions](/WSH%20Shipping-Delivery%20Transactions/ "WSH Shipping/Delivery Transactions Oracle EBS SQL Report"), [ONT Orders and Lines 11i](/ONT%20Orders%20and%20Lines%2011i/ "ONT Orders and Lines 11i Oracle EBS SQL Report"), [ONT Orders and Lines](/ONT%20Orders%20and%20Lines/ "ONT Orders and Lines Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [INV Move Orders](/INV%20Move%20Orders/ "INV Move Orders Oracle EBS SQL Report"), [PPF_WP3_OM_DETAILS](/PPF_WP3_OM_DETAILS/ "PPF_WP3_OM_DETAILS Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WSH%20Container%20Items%20Upload/WSH%20Container%20Items%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-container-items-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/wsh-container-items-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-container-items-upload) |
| Blitz Report™ XML Import | [WSH_Container_Items_Upload.xml](https://www.enginatics.com/xml/wsh-container-items-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-container-items-upload) |
| SQL Source | [WSH Container Items Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WSH%20Container%20Items%20Upload/WSH%20Container%20Items%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/wsh-container-items-upload/](https://www.enginatics.com/reports/wsh-container-items-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-container-items-upload) |

## Case Study & Technical Analysis: WSH Container Items Upload

### Executive Summary
The WSH Container Items Upload creates, updates and deletes container-item relationships in Oracle Shipping Execution, the data behind the Container-Item Relationships form under Container Load Details. A relationship states the maximum quantity of a load item that fits into a container item within one inventory organisation, and auto-pack uses the preferred container of each load item to plan shipments. It is written for shipping and warehouse administrators who maintain packaging standards for many items and containers, such as pallets, cartons and drums. The upload handles the preferred container flag as the form does, and it supports deletion of relationships. It sits in the Shipping area of Oracle EBS.

### Business Challenge
*   **Packaging standards at volume:** Every item that ships in a container needs a maximum load quantity per container, and a large catalogue makes manual entry impractical.
*   **Auto-pack reliability:** Auto-pack depends on the preferred container of each load item, and an incorrect preferred container produces wrong packing plans.
*   **Serial and indivisible items:** Items that are serial controlled or indivisible must have whole-number maximum quantities, so the file must be validated against item controls.
*   **Changing standards:** Packaging standards change with new containers and suppliers, and the old relationships must be updated or removed cleanly.

### The Solution
*   **One row per relationship:** Each row shows the container item, its container type, the load item, its unit of measure, the maximum quantity and the preferred flag.
*   **Preferred flag management:** Setting the preferred flag to Yes removes the flag from the load item's current preferred container, as the form does, and the message names that container.
*   **Clear conflict rule:** When several rows make different containers preferred for the same load item, the last row in the file wins.
*   **Quantity rules:** Maximum quantities are rounded to five decimals, and must be whole numbers for serial controlled and indivisible load items.
*   **Deletion and reassignment:** A relationship is deleted by entering Yes in the delete column, and changing the container or load item of a downloaded row moves that relationship.

### Technical Architecture (High Level)
#### Primary Tables
*   `WSH_CONTAINER_ITEMS`: the container-item relationships, with the container item, load item, maximum load quantity, preferred flag and flexfield values.
*   `MTL_PARAMETERS`: the inventory organisations, with the master organisation used for the relationship.
*   `MTL_SYSTEM_ITEMS_VL`: the container and load item definitions, joined twice, once for each role.
*   `ORG_ACCESS_VIEW`: the organisations accessible to the current responsibility.

#### Logical Relationships
1. `WSH_CONTAINER_ITEMS` joins to `MTL_PARAMETERS` on the master organisation identifier.
2. The container item joins to `MTL_SYSTEM_ITEMS_VL` on the master organisation and the container item identifier.
3. The load item joins to `MTL_SYSTEM_ITEMS_VL` on the master organisation and the load item identifier, so the two item roles are resolved separately.
4. Organisations are limited to those returned by `ORG_ACCESS_VIEW` for the current responsibility.
5. The result returns the original container and load identifiers so that a changed item can be matched back to its relationship on upload.

### Parameters & Filtering
*   **Upload Mode:** Chooses between create, update and delete operations.
*   **Organization Code:** Restricts the relationships to one inventory organisation.
*   **Container Type:** Restricts the container items to one container type, such as pallet or carton.
*   **Container Item:** Restricts the output to one container item.
*   **Load Item:** Restricts the output to one load item.
*   **Preferred Flag:** Restricts the output to relationships where the container is, or is not, the preferred container for the load item.

### Performance & Optimization
*   **Organisation filter first:** The query limits the relationships to the master organisations in the access view for the current responsibility before the item joins.
*   **Item joins by identifier:** Both item joins use the inventory item identifier and the master organisation, so each relationship resolves to one row per item role.
*   **Relationship-sized data:** The table holds packaging relationships rather than transactions, so the result is bounded by the number of items and containers configured.

### FAQ
**Q: How do I set the maximum quantity of a load item that fits in a container item in Oracle Shipping?**
A: Download the relationships for the organisation, enter the maximum quantity on the row for the container and load item, and upload the file.

**Q: What happens when I make a container preferred for a load item?**
A: The previous preferred container for that load item is unflagged, as the Container-Item Relationships form does, and the message column names the container that was changed.

**Q: How do I delete a container-item relationship?**
A: Enter Yes in the Delete Relationship column for that row and upload the file.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-container-items-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-container-items-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-container-items-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-container-items-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-container-items-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-container-items-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wsh-container-items-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
