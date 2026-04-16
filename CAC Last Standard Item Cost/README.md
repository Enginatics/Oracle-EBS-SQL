---
layout: default
title: 'CAC Last Standard Item Cost | Oracle EBS SQL Report'
description: 'Report to show the last standard item cost as of a specified cost update date; expecially useful if you have not saved off your Frozen costs at year-end…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Last, Standard, Item, mtl_category_sets_vl, mtl_categories_v, cst_item_costs'
permalink: /CAC%20Last%20Standard%20Item%20Cost/
---

# CAC Last Standard Item Cost – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-last-standard-item-cost/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show the last standard item cost as of a specified cost update date; expecially useful if you have not saved off your Frozen costs at year-end, before updating to your new standard costs for the following year.  Including various item controls, last cost update submission, last standard item cost and current (Frozen) item cost.  And whether or not BOMs, routings or (inventory organization) sourcing rules exist for the item as of the specified cost update date.  And as allowed with no onhand or intransit quantities, if an item cost has been directly entered into the Frozen Cost Type, the Cost Update Request Id, Cost Update Description, Cost Update Status and related cost update submission columns will be blank or empty.

This report complements the CAC New Standard Item Cost report.  The CAC New Standard Item Cost report shows you the cost update history over a range of  Standard Cost Revision Dates, useful to track standard cost changes on a weekly basis.  The CAC Last Standard Item Cost report shows you how each item got its last Standard Item Cost as of a given Standard Cost Revision Date.  Useful to assess when the current standard costs were created and by whom.

Parameters:
==========
Cost Update Date To: ending cost update revision date, based on standard cost submission history (required).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Item Status to Exclude:  enter the item status to exclude from this report, defaults to Inactive (optional).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2024 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.                                                                 |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_last_standard_item_cost_rept.sql
-- |
-- | Description:
-- | Report to show the last standard cost for all items in an inventory organization,
-- | up to the entered Cost Update Date parameter.
-- | 
-- | Version Modified on Modified by    Description
-- | ======= =========== ============== =========================================
-- |  1.0    15 Jan 2024 Douglas Volz   Initial coding based on the New Standard Item Cost report.
-- +=============================================================================+*/

## Report Parameters
Cost Update Date To, Category Set 1, Category Set 2, Category Set 3, Item Status to Exclude, Assignment Set, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_category_sets_vl](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_vl), [mtl_categories_v](https://www.enginatics.com/library/?pg=1&find=mtl_categories_v), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [bom_structures_b](https://www.enginatics.com/library/?pg=1&find=bom_structures_b), [bom_operational_routings](https://www.enginatics.com/library/?pg=1&find=bom_operational_routings), [mrp_sr_receipt_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_receipt_org), [mrp_sr_source_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_source_org), [mrp_sourcing_rules](https://www.enginatics.com/library/?pg=1&find=mrp_sourcing_rules), [mrp_sr_assignments](https://www.enginatics.com/library/?pg=1&find=mrp_sr_assignments), [mrp_assignment_sets](https://www.enginatics.com/library/?pg=1&find=mrp_assignment_sets), [cst_standard_costs](https://www.enginatics.com/library/?pg=1&find=cst_standard_costs), [cst_cost_updates](https://www.enginatics.com/library/?pg=1&find=cst_cost_updates), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/cac-last-standard-item-cost/) |
| Blitz Report™ XML Import | [CAC_Last_Standard_Item_Cost.xml](https://www.enginatics.com/xml/cac-last-standard-item-cost/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-last-standard-item-cost/](https://www.enginatics.com/reports/cac-last-standard-item-cost/) |

## Case Study & Technical Analysis: CAC Last Standard Item Cost

### Executive Summary
The **CAC Last Standard Item Cost** report is a forensic costing tool. It reconstructs the history of the "Frozen" (Standard) cost by identifying the last time a Standard Cost Update was successfully run for each item. This is crucial for year-end audits and for understanding the provenance of the current standard cost.

### Business Challenge
In a Standard Costing environment, the "Frozen" cost is static until explicitly updated.
*   **Stale Costs**: An item might have a cost that was set 5 years ago. Management needs to know *how old* the cost is.
*   **Audit Trail**: Auditors often ask, "When was this cost established and who approved it?"
*   **Process Validation**: Did the annual cost roll/update process actually update *all* items, or were some skipped?

### Solution
This report links the current cost back to the update event.
*   **Timestamp**: Shows the `Cost Update Date` for the most recent update.
*   **Source**: Identifies the `Cost Update Description` (e.g., "2023 Annual Roll").
*   **Status**: Confirms that the update status was "Completed".
*   **Context**: Shows the cost value at that time compared to the current Frozen cost.

### Technical Architecture
The report joins the item cost to the standard cost history tables:
*   **Tables**: `cst_item_costs` (Current), `cst_standard_costs` (History), `cst_cost_updates` (The Event).
*   **Logic**: It finds the `MAX(cost_update_date)` for each item to pinpoint the latest revision.
*   **Outer Joins**: Handles cases where an item might have a cost but no update history (e.g., direct SQL insert or legacy migration).

### Parameters
*   **Cost Update Date To**: (Mandatory) The cutoff date for the analysis.
*   **Organization Code**: (Optional) The inventory org.
*   **Item Status**: (Optional) To exclude obsolete items.

### Performance
*   **Historical Data**: The `cst_standard_costs` table can be very large. The report uses the `Cost Update Date` to limit the scan, but performance depends on the volume of historical updates.

### FAQ
**Q: Why is the "Last Update" date blank?**
A: If the item was created and costed via a direct interface or data load that didn't use the standard "Cost Update" concurrent program, there may be no record in `cst_cost_updates`.

**Q: Does this show the *previous* cost?**
A: It shows the cost *as of* the update. To see the previous cost, you would need to look at the history prior to that update.

**Q: Is this useful for Average Costing?**
A: No, this is specific to Standard Costing (`cst_standard_costs`). Average costs change with every transaction.


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
