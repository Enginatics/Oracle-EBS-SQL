---
layout: default
title: 'CAC Inventory Lot and Locator OPM Value (Period-End) | Oracle EBS SQL Report'
description: 'Report showing amount of inventory at the end of the month for Process Manufacturing (OPM) inventory organizations, for both onhand and intransit…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Inventory, Lot, Locator, inv_organizations, mtl_units_of_measure_vl, mtl_item_status_vl'
permalink: /CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/
---

# CAC Inventory Lot and Locator OPM Value (Period-End) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-inventory-lot-and-locator-opm-value-period-end/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report showing amount of inventory at the end of the month for Process Manufacturing (OPM) inventory organizations, for both onhand and intransit inventory.  If you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end snapshot.  In either case this report uses the month-end quantities, based on the entered period name, calendar code and period code.  As these quantities come from the month-end snapshot, this also also allows you to specify the lot number and locator (row/rack/bin) for your onhand quantities. And as a default valuation account, this report uses the Material Account from your subinventory setups and your Intransit Account from your Shipping Network setups.

Note:  OPM intransit balances based upon last two years of Intransit Shipments.  As of Release 12.2.13, OPM does not have a month-end snapshot for intransit quantities or balances.

General Parameters:
===================
Period Name (Closed):  the closed inventory accounting period you wish to report (mandatory).
Cost Type:  enter a Cost Type to value the quantities using the Cost Type item costs; or, if Cost Type is not entered the report will use the stored month-end snapshot values (optional).
Show OPM Lot Number:  choose Yes to show the OPM lot number for the inventory quantities.  Otherwise choose No (mandatory).
Show OPM Locator:  choose Yes to show the OPM locator and Lot Expiration Date for the inventory quantities.  Otherwise choose No (mandatory).
OPM Calendar Code:  Choose the OPM Calendar Code which corresponds to the inventory accounting period you wish to report (mandatory).
OPM Period Code:  enter the OPM Period Code related to the inventory accounting period and OPM Calendar Code you wish to report (mandatory).
Category Set 1:  the first item category set to report, typically the Cost or Product Line Category Set (optional).
Category Set 2:  The second item category set to report, typically the Inventory Category Set (optional).
Item Number:  specific buy or make item you wish to report (optional).
Subinventory:  specific area within the warehouse or inventory area you wish to report (optional).
Organization Code:  any inventory organization, defaults to your session's inventory organization (optional).
Operating Unit:  specific operating unit (optional).
Ledger:  specific ledger (optional).

/* +=============================================================================+
-- | Copyright 2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission.                                                                           
-- +=============================================================================+
-- |
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     10 May 2024 Douglas Volz Initial Coding.
-- | 1.1     30 Jun 2024 Douglas Volz Cumulative fixes for OPM intransit balances and accounts.
-- | 1.2     02 Aug 2024 Douglas Volz Add OPM Cost Organizations to get correct item costs and qtys.
-- | 1.3     30 Sep 2024 Douglas Volz Add Lot expiration date to report.
-- +=============================================================================+*/



## Report Parameters
Period Name (Closed), Cost Type, Show Lot Number, Show Locator, OPM Calendar Code, OPM Period Code, Category Set 1, Category Set 2, Category Set 3, Item Number, Subinventory, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[inv_organizations](https://www.enginatics.com/library/?pg=1&find=inv_organizations), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv), [mtl_material_statuses_vl](https://www.enginatics.com/library/?pg=1&find=mtl_material_statuses_vl), [mtl_lot_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_lot_numbers), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [gl_item_cst](https://www.enginatics.com/library/?pg=1&find=gl_item_cst), [gmf_period_statuses](https://www.enginatics.com/library/?pg=1&find=gmf_period_statuses), [gmf_fiscal_policies](https://www.enginatics.com/library/?pg=1&find=gmf_fiscal_policies), [gmf_calendar_assignments](https://www.enginatics.com/library/?pg=1&find=gmf_calendar_assignments), [gmf_period_balances](https://www.enginatics.com/library/?pg=1&find=gmf_period_balances), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [cm_cmpt_dtl](https://www.enginatics.com/library/?pg=1&find=cm_cmpt_dtl), [cm_cmpt_mst_b](https://www.enginatics.com/library/?pg=1&find=cm_cmpt_mst_b), [cm_mthd_mst](https://www.enginatics.com/library/?pg=1&find=cm_mthd_mst), [mtl_interorg_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_interorg_parameters)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/cac-inventory-lot-and-locator-opm-value-period-end/) |
| Blitz Report™ XML Import | [CAC_Inventory_Lot_and_Locator_OPM_Value_Period_End.xml](https://www.enginatics.com/xml/cac-inventory-lot-and-locator-opm-value-period-end/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-inventory-lot-and-locator-opm-value-period-end/](https://www.enginatics.com/reports/cac-inventory-lot-and-locator-opm-value-period-end/) |

## Case Study & Technical Analysis: CAC Inventory Lot and Locator OPM Value (Period-End)

### Executive Summary
The **CAC Inventory Lot and Locator OPM Value (Period-End)** report provides a granular audit trail for Process Manufacturing (OPM) inventory. Unlike high-level summary reports, this tool drills down to the specific Lot and Locator (Row/Rack/Bin) level, providing the detailed evidence needed to substantiate inventory valuations for sensitive or regulated materials (e.g., chemicals, pharmaceuticals).

### Business Challenge
In Process Manufacturing, the value of inventory is often tied to specific batches or lots which may have different costs or expiration dates.
*   **Audit Granularity**: Auditors often require a "floor-to-sheet" count where they verify specific lots in specific bins. Summary reports are insufficient for this.
*   **Expiration Risk**: High-value chemicals often expire. Finance needs to know the value of inventory that is approaching its shelf life to accrue for potential write-offs.
*   **Locator Accuracy**: Verifying that hazardous materials are stored in the correct locations requires visibility into the locator-level balances.

### Solution
This report unlocks the detailed subledger data for OPM.
*   **Deep Dive**: Reports Quantity and Value by Item, Lot, and Locator.
*   **Expiration Visibility**: Includes the Lot Expiration Date, enabling "At-Risk" inventory analysis.
*   **Intransit Detail**: Also covers intransit inventory, providing a complete picture of owned assets.

### Technical Architecture
The report navigates the complex OPM table structure:
*   **Data Sources**: Joins `mtl_system_items` with OPM-specific quantity tables (likely `gmf_period_balances` or similar derived logic) and `mtl_item_locations` for locator definitions.
*   **Lot Details**: Pulls lot attributes from `mtl_lot_numbers`.
*   **Valuation**: Applies the period-end cost to the detailed quantities to derive the line-level value.

### Parameters
*   **Show OPM Lot Number**: (Mandatory) Toggle to enable/disable lot detail.
*   **Show OPM Locator**: (Mandatory) Toggle to enable/disable bin location detail.
*   **OPM Calendar/Period**: (Mandatory) Defines the reporting timeframe.

### Performance
*   **High Volume**: Enabling Lot and Locator details can result in a massive number of rows (millions) for large warehouses.
*   **Export Strategy**: It is recommended to export this report to Excel or a database for further analysis rather than printing it.

### FAQ
**Q: Can I see expired lots only?**
A: The report lists all lots. You can filter the output in Excel based on the "Lot Expiration Date" column.

**Q: Why is the locator field empty?**
A: If the item is not locator-controlled, or if the inventory is in an intransit location, the locator field will be blank.

**Q: Does this include Quality status?**
A: Yes, it typically includes the Lot Status (e.g., "Quarantine", "Released"), which is crucial for valuation (e.g., valuing quarantined items at zero).


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
