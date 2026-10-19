---
layout: default
last_modified_at: 2026-10-19
title: 'INV Lot Upload | Oracle EBS SQL Report'
description: 'Creates and updates lots as in the Lot Numbers form (Inventory > On-hand, Availability > Lots). A row updates the lot when Organization Code, Item and Lot…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, INV, Lot, mtl_material_statuses_vl, mtl_lot_numbers, mtl_onhand_quantities_detail'
permalink: /INV%20Lot%20Upload/
report_name: 'INV Lot Upload'
report_web_name: inv-lot-upload
---

# INV Lot Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-lot-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload).

## Overview
Creates and updates lots as in the Lot Numbers form (Inventory > On-hand, Availability > Lots).

A row updates the lot when Organization Code, Item and Lot Number exist, and creates it otherwise. A new lot takes the item defaults for status, grade, origination type and the dates left blank, and copies the parent lot attributes where the item or organization is set up to copy them. A blank Origination Date on a new lot defaults to the current date. Parent Lot can only be entered for a new lot.

Expiration Date, Expiration Action Date and Retest Date can be changed only for items under shelf life control, and the Expiration Date of such an item cannot be cleared. Status requires a lot status enabled item, Grade a grade controlled item. Changing the Origination Date does not recalculate the other dates. Clearing the Expiration Action Date also clears the Expiration Action.

With profile INV: Global Lot Attributes set to Yes, a changed date or grade is applied to the same lot in all organizations, as in the form.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Organization Code, Item, Lot Number, Expiration Date From, Expiration Date To, Expiring Within Days

## Oracle EBS Tables Used
[mtl_material_statuses_vl](https://www.enginatics.com/library/?pg=1&find=mtl_material_statuses_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload), [mtl_lot_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_lot_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload), [mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload)

## Related Reports
[INV Onhand Quantities](/INV%20Onhand%20Quantities/ "INV Onhand Quantities Oracle EBS SQL Report"), [INV Physical Inventory Locator Count Sheet](/INV%20Physical%20Inventory%20Locator%20Count%20Sheet/ "INV Physical Inventory Locator Count Sheet Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC Onhand Lot Value (Real-Time)](/CAC%20Onhand%20Lot%20Value%20%28Real-Time%29/ "CAC Onhand Lot Value (Real-Time) Oracle EBS SQL Report"), [INV Cycle count listing](/INV%20Cycle%20count%20listing/ "INV Cycle count listing Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Lot%20Upload/INV%20Lot%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/inv-lot-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload) |
| Blitz Report™ XML Import | [INV_Lot_Upload.xml](https://www.enginatics.com/xml/inv-lot-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload) |
| SQL Source | [INV Lot Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Lot%20Upload/INV%20Lot%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-lot-upload/](https://www.enginatics.com/reports/inv-lot-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload) |

## Case Study & Technical Analysis: INV Lot Upload

### Executive Summary
The INV Lot Upload creates and updates inventory lots in Oracle Inventory, following the logic of the Lot Numbers form. A row updates a lot when its organization code, item and lot number already exist, and creates it otherwise. Inventory and quality teams use the upload to load lot master data from suppliers and manufacturing, to set expiration and retest dates for shelf-life items and to correct lot status and grade. Blitz Report downloads the lots of the selected organizations, with their dates, status, attributes and on-hand quantity, so that the spreadsheet shows the current state before changes are made.

### Business Challenge
*   **Lot master data:** Lots received from suppliers or created in manufacturing need their origination, grade and dates recorded, and entering them one at a time is slow.
*   **Shelf-life control:** Expiration, expiration action and retest dates drive the usability of the stock, and a wrong date can release expired material.
*   **Lot status and grade:** Quarantine, release and grading decisions change the availability of a lot, and they must be applied across the items that use them.
*   **Global attributes:** A change to a lot in one organization must sometimes be applied to the same lot in all organizations, as the form does with the global lot attributes profile.

### The Solution
*   Downloads the lots of the selected organizations with the item, its shelf-life control, the parent lot, status, grade, origination type and all the date fields.
*   Shows the lot attributes, the descriptive flexfield values of the lot and the on-hand quantity of the lot across subinventories.
*   Creates a new lot with the item defaults for status, grade and origination, and with the current date as origination date when the column is blank.
*   Applies the expiration and retest dates only where the item is under shelf-life control, and applies a changed date or grade to the same lot in all organizations when the global lot attributes profile is Yes.

### Technical Architecture (High Level)
#### Primary Tables
*   `MTL_LOT_NUMBERS`: the lot master, with its organization, item, parent lot, status, grade, origination, dates and attributes.
*   `MTL_SYSTEM_ITEMS_VL`: the item, its shelf-life control code and its description.
*   `MTL_PARAMETERS`: the inventory organization code.
*   `MTL_MATERIAL_STATUSES_VL`: the lot status code linked to the lot's status id.
*   `MTL_ONHAND_QUANTITIES_DETAIL`: the on-hand quantity of each lot, summed across subinventories for the download.
*   `ORG_ACCESS_VIEW`: the organizations that the responsibility can access.

#### Logical Relationships
1.  `MTL_PARAMETERS` is joined to `MTL_SYSTEM_ITEMS_VL` on the organization id, and `MTL_SYSTEM_ITEMS_VL` to `MTL_LOT_NUMBERS` on the organization id and inventory item id.
2.  The lot status is a scalar lookup on `MTL_MATERIAL_STATUSES_VL` through the status id of the lot.
3.  The on-hand quantity is a correlated subquery on `MTL_ONHAND_QUANTITIES_DETAIL` matching the organization, item and lot number.
4.  Organizations are restricted by a subquery on `ORG_ACCESS_VIEW`, using the responsibility application and responsibility id of the session.
5.  The flexfield values for the lot attributes and the lot descriptive flexfield are decoded from the attribute category of each lot.

### Parameters & Filtering
*   **Upload Mode:** controls whether lots are downloaded for update, creation or both.
*   **Organization Code** and **Item:** select the organization and item whose lots are listed.
*   **Lot Number:** selects one lot.
*   **Expiration Date From** and **Expiration Date To:** bound the expiration dates of the lots.
*   **Expiring Within Days:** selects the lots that expire within the number of days entered.

### Performance & Optimization
*   The on-hand subquery is correlated on organization, item and lot, so it reads only the detail rows of each lot listed.
*   The flexfield decoding runs once per lot row, and is applied to the attribute category of each lot rather than to all lots.
*   The organization access subquery limits the lot scan to the responsibility's organizations before the item and lot joins.
*   Narrowing by Organization Code and Item is the most effective way to keep a large lot population manageable in Excel.

### FAQ
**Q: How does the upload decide whether to create or update a lot?**
A: It matches the organization code, item and lot number. If the lot exists, the row updates it; if not, the row creates it.

**Q: Why can I not change the expiration date of an item?**
A: Expiration, expiration action and retest dates can be changed only for items under shelf-life control, and the expiration date of such an item cannot be cleared.

**Q: Can Parent Lot be changed on an existing lot?**
A: No. Parent Lot can only be entered for a new lot.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-lot-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
