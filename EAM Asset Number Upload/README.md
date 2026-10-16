---
layout: default
last_modified_at: 2026-10-16
title: 'EAM Asset Number Upload | Oracle EBS SQL Report'
description: 'Create and update Oracle Enterprise Asset Management asset numbers (maintenance assets). Parent Asset Number places the asset in the asset hierarchy…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, EAM, Asset, Number, mtl_system_items_b_kfv, csi_item_instances, mtl_eam_asset_numbers_all_v'
permalink: /EAM%20Asset%20Number%20Upload/
report_name: 'EAM Asset Number Upload'
report_web_name: eam-asset-number-upload
---

# EAM Asset Number Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/eam-asset-number-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-number-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-number-upload).

## Overview
Create and update Oracle Enterprise Asset Management asset numbers (maintenance assets). Parent Asset Number places the asset in the asset hierarchy; clearing it on an existing asset removes the parent. Parent Asset Serial Number and Parent Asset Id follow the parent asset number and are read only.

An existing asset is identified by its Asset Id, so its Asset Number can be changed. Current Location Address lists the addresses of the TCA locations, as the Update Asset page does; an address that exists more than once carries the location id in brackets.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-number-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Organization, Asset Number From, Asset Number To, Asset Group, Asset Category, Asset Status

## Oracle EBS Tables Used
[mtl_system_items_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-number-upload), [csi_item_instances](https://www.enginatics.com/library/?pg=1&find=csi_item_instances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-number-upload), [mtl_eam_asset_numbers_all_v](https://www.enginatics.com/library/?pg=1&find=mtl_eam_asset_numbers_all_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-number-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-number-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-number-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-number-upload)

## Related Reports
[INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [EAM Assets](/EAM%20Assets/ "EAM Assets Oracle EBS SQL Report"), [EAM PM Schedule Upload](/EAM%20PM%20Schedule%20Upload/ "EAM PM Schedule Upload Oracle EBS SQL Report"), [EAM Work Orders](/EAM%20Work%20Orders/ "EAM Work Orders Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/EAM%20Asset%20Number%20Upload/EAM%20Asset%20Number%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-number-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/eam-asset-number-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-number-upload) |
| Blitz Report™ XML Import | [EAM_Asset_Number_Upload.xml](https://www.enginatics.com/xml/eam-asset-number-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-number-upload) |
| SQL Source | [EAM Asset Number Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/EAM%20Asset%20Number%20Upload/EAM%20Asset%20Number%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/eam-asset-number-upload/](https://www.enginatics.com/reports/eam-asset-number-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-number-upload) |

## Case Study & Technical Analysis: EAM Asset Number Upload

### Executive Summary
This upload creates and updates Oracle Enterprise Asset Management asset numbers, the maintenance assets that work orders, preventive maintenance and failure tracking are performed against. It covers the asset's organization, group, category, criticality, status, location, equipment link and parent asset in the asset hierarchy, together with the asset's descriptive flexfield. Maintenance planners and EAM administrators use it to load new equipment, reorganize the asset hierarchy and correct asset attributes in bulk. The template runs in Excel through Blitz Report.

### Business Challenge
*   **Asset hierarchy maintenance:** Placing equipment under its parent asset is needed for rollups and for work order visibility, and is slow to do asset by asset.
*   **Asset master data quality:** Category, criticality, owning department, area and warranty dates must be consistent across a plant.
*   **Location and equipment links:** Assets must point to the right address and to the equipment item and serial they were built from.
*   **Migration and synchronization:** Assets that also appear in Fixed Assets need their synchronization flag and asset number maintained.

### The Solution
*   **Create and update by asset id:** An existing asset is identified by its asset id, so its asset number can be changed in the same upload.
*   **Parent placement:** Entering a Parent Asset Number places the asset in the hierarchy, and clearing it on an existing asset removes the parent.
*   **Read-only references:** Parent Asset Serial Number and Parent Asset Id follow the parent asset number and cannot be entered directly.
*   **Location addresses:** Current Location Address lists the addresses of the trading community locations, and an address that appears more than once carries its location id in brackets.
*   **Flexfield values:** The asset's instance flexfield is rendered with its segment labels, so the workbook shows readable values.

### Technical Architecture (High Level)
#### Primary Tables
*   `MTL_EAM_ASSET_NUMBERS_ALL_V`: the view of EAM asset numbers, with the asset's organization, group, status, criticality and parent data.
*   `CSI_ITEM_INSTANCES`: the installed instance that holds the asset number, serial and location.
*   `MTL_SYSTEM_ITEMS_B_KFV`: the asset group and the equipment item, identified by inventory item id and organization.

#### Logical Relationships
1. The asset number view is the single driving source, and each asset's equipment item is resolved from its equipment item id and production organization id.
2. The parent asset is resolved by matching the parent instance number to `CSI_ITEM_INSTANCES`, which returns the parent asset id.
3. The asset group, category and status are resolved from the asset number view's own columns, using meaning lookups for asset type and status.
4. The instance flexfield is joined through the context and row identifier of the asset record.

### Parameters & Filtering
*   **Upload Mode:** selects Create, or Create, Update to download existing assets.
*   **Organization:** restricts the assets to one inventory organization.
*   **Asset Number From / Asset Number To:** bound the assets by their asset number range.
*   **Asset Group:** restricts the assets to one asset group.
*   **Asset Category:** restricts the assets to one category.
*   **Asset Status:** restricts the assets to one current status.

### Performance & Optimization
*   The organization and number range parameters are applied to the asset number view, which limits the rows before the equipment and parent lookups run.
*   The equipment item lookup is a scalar subquery keyed on the inventory item and organization, so it is evaluated only for the rows returned.
*   The parent asset id lookup uses the instance number, which keeps the join to the instance table a single indexed-style match.

### FAQ
**Q: How do I remove an asset from its parent?**
A: On an existing asset, clear the Parent Asset Number. The parent link is removed when the row is uploaded.

**Q: Can I change the asset number of an existing asset?**
A: Yes. The asset is identified by its Asset Id, so the Asset Number can be changed on the same row.

**Q: Why is Parent Asset Id blank on my new row?**
A: The parent asset id follows the parent asset number and is read only. It is returned for assets whose parent exists.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-number-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-number-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-number-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-number-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-number-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-number-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-asset-number-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
