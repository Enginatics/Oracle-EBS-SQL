---
layout: default
last_modified_at: 2026-10-19
title: 'INV Stock Locator Upload | Oracle EBS SQL Report'
description: 'Create, update and delete Stock Locators. Note on entering a locator as a concatenated segment value: if a segment value contains the KFF delimiter…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, INV, Stock, Locator, mtl_item_locations_kfv, mtl_parameters, mtl_material_statuses_vl'
permalink: /INV%20Stock%20Locator%20Upload/
report_name: 'INV Stock Locator Upload'
report_web_name: inv-stock-locator-upload
---

# INV Stock Locator Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-stock-locator-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locator-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locator-upload).

## Overview
Create, update and delete Stock Locators.

Note on entering a locator as a concatenated segment value: if a segment value contains the KFF delimiter character or a backslash (\), each such character must be preceded with a backslash. For example, with delimiter '.', the segment value '1\4\4.' must be written as '1\\4\\4\.'

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locator-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Organization Code, Subinventory, Locator, Locator From, Locator To, Locator Type, Status

## Oracle EBS Tables Used
[mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locator-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locator-upload), [mtl_material_statuses_vl](https://www.enginatics.com/library/?pg=1&find=mtl_material_statuses_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locator-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locator-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locator-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locator-upload)

## Related Reports
[INV Physical Inventory Locator Count Sheet](/INV%20Physical%20Inventory%20Locator%20Count%20Sheet/ "INV Physical Inventory Locator Count Sheet Oracle EBS SQL Report"), [INV Onhand Quantities](/INV%20Onhand%20Quantities/ "INV Onhand Quantities Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Stock Locators](/INV%20Stock%20Locators/ "INV Stock Locators Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [INV Serial Numbers](/INV%20Serial%20Numbers/ "INV Serial Numbers Oracle EBS SQL Report"), [INV Subinventory Upload](/INV%20Subinventory%20Upload/ "INV Subinventory Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Stock%20Locator%20Upload/INV%20Stock%20Locator%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locator-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/inv-stock-locator-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locator-upload) |
| Blitz Report™ XML Import | [INV_Stock_Locator_Upload.xml](https://www.enginatics.com/xml/inv-stock-locator-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locator-upload) |
| SQL Source | [INV Stock Locator Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Stock%20Locator%20Upload/INV%20Stock%20Locator%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-stock-locator-upload/](https://www.enginatics.com/reports/inv-stock-locator-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locator-upload) |

## Case Study & Technical Analysis: INV Stock Locator Upload

### Executive Summary
INV Stock Locator Upload creates, updates and deletes stock locators in Oracle Inventory, the physical positions inside a subinventory where material is stored. It is used by warehouse managers, inventory administrators and implementation teams who need to set up rack, bin and aisle structures in bulk, change locator attributes such as picking order and capacity, or retire locators that are no longer used. The upload downloads existing locators with their segments, descriptions and physical attributes, and writes changes back through the standard locator setup.

### Business Challenge
*   **Warehouse Layout Setup:** A new warehouse may need hundreds of locators defined across subinventories, which is slow to enter one at a time.
*   **Picking Efficiency:** Picking and dropping orders decide the travel path of warehouse staff, and they must be maintained for every locator.
*   **Capacity Data:** Maximum units, volume and weight limits per locator are needed for put-away rules and must be kept current.
*   **Status Control:** Locators that are disabled or no longer needed must be ended without losing their history.

### The Solution
*   **Segment Expansion:** The concatenated locator and each of its segments are shown in separate columns, so the locator structure is readable in Excel.
*   **Physical Attributes:** Maximum units, volume, weight, pick unit of measure and dimensions are provided as columns, with their units.
*   **Status and Type:** Locator type and status are returned as text, so they can be set in the template.
*   **Delete Option:** A delete column removes a locator when set to Yes.

### Technical Architecture (High Level)
#### Primary Tables
*   `MTL_ITEM_LOCATIONS_KFV`: the stock locators with their subinventory, segments, physical attributes, picking and dropping order, and the descriptive flexfield values.
*   `MTL_PARAMETERS`: the organization that owns each locator.
*   `MTL_MATERIAL_STATUSES_VL`: the material status names that the locator status identifier refers to.
*   `ORG_ACCESS_VIEW`: the organizations available to the current responsibility.

#### Logical Relationships
1.  Each locator in `MTL_ITEM_LOCATIONS_KFV` is joined to its organization in `MTL_PARAMETERS` on the organization identifier.
2.  The organization is restricted to those returned by `ORG_ACCESS_VIEW` for the current responsibility.
3.  The locator status identifier is outer joined to `MTL_MATERIAL_STATUSES_VL`, so the status name is returned.
4.  The concatenated locator and each segment, up to twenty, are produced by the flexfield expansion function, with the number of segments limiting how many segment columns are populated.
5.  The locator type code is converted to its meaning through the Blitz Report™ meaning function.

### Parameters & Filtering
*   **Upload Mode:** Selects Create, or Create and Update, which controls whether existing locators are downloaded.
*   **Organization Code:** Restricts the locators to one organization.
*   **Subinventory:** Restricts the locators to one subinventory.
*   **Locator and Locator From and Locator To:** Match one locator or a range of locator values.
*   **Locator Type:** Restricts the output to one locator type.
*   **Status:** Restricts the output to locators with one material status.

### Performance & Optimization
*   **Organization Filter Before Locators:** The organization access check limits the locator scan to permitted organizations before the flexfield functions are evaluated.
*   **Segment Count Guard:** Each segment column is populated only when the segment count is at least its position, so unused segment columns return blank values.
*   **Status Outer Join:** The status is an outer join, so locators without a status still appear in the output.
*   **Flexfield Function Cost:** Concatenated and segment values are computed by the flexfield function on each row, so the extract cost grows with the number of locators returned.

### FAQ
**Q: How do I enter a locator whose segment contains the delimiter character?**
A: Precede each delimiter character and each backslash in the segment value with a backslash. The description gives an example with a period as the delimiter.

**Q: Can I end a locator without losing its record?**
A: Use the disable date column to end the locator, rather than deleting it, so the record remains for history.

**Q: How do I see the capacity of each locator?**
A: The maximum units, maximum volume and maximum weight columns return the capacity values held on each locator, with their units of measure.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locator-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locator-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locator-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locator-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locator-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locator-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locator-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
