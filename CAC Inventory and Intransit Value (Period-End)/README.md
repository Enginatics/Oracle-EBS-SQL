---
layout: default
title: 'CAC Inventory and Intransit Value (Period-End) | Oracle EBS SQL Report'
description: 'Report showing amount of inventory at the end of the month. If you enter a cost type this report uses the item costs from the cost type; if you leave the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CAC, Inventory, Intransit, Value, mtl_secondary_inventories, inv_organizations, cst_cost_group_accounts'
permalink: /CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/
---

# CAC Inventory and Intransit Value (Period-End) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-inventory-and-intransit-value-period-end/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report showing amount of inventory at the end of the month.  If you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end snapshot.  In either case this report uses the month-end quantities, based on the entered period name.  And as these quantities come from the month-end snapshot (created when you close the inventory accounting period) and this snapshot is only by inventory organization, subinventory and item and not split out by cost element, this report only shows the Material Account, based upon your Costing Method.

Note:  if you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end snapshot.

/* +=============================================================================+
-- | Copyright 2009 - 2022 Douglas Volz Consulting, Inc.                         |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Parameters:
-- |  p_period_name         -- Accounting period you wish to report for
-- |  p_org_code            -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit      -- Operating Unit you wish to report, leave blank for all operating units (optional) 
-- |  p_ledger              -- general ledger you wish to report, leave blank for all ledgers (optional)
-- |  p_cost_type           -- Enter a Cost Type to value the quantities using the Cost Type Item Costs; or, if 
-- |                           Cost Type is blank or null the report will use the stored month-end snapshot values
-- |  p_category_set1       -- The first item category set to report, typically the Cost or Product Line Category Set
-- |  p_category_set2       -- The second item category set to report, typically the Inventory Category Set 
-- |  p_item_number         -- The part or item number you wish to report (optional)
-- |  p_subinventory        -- The specific subinventory you wish to report (optional)
-- |
-- | ===================================================================
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     27 Sep 2009 Douglas Volz Initial Coding
-- | 1.1     28 Sep 2009 Douglas Volz Added a sum for the ICP costs from cicd
-- | 1.16    23 Apr 2020 Douglas Volz Changed to multi-language views for the item master,
-- |                                  item categories and operating units.  Used mfg_lookups for "Intransit".
-- | 1.17    05 Mar 2022 Douglas Volz Use With statement for category, subinventory and intransit valuation accounts.
-- |                                  And changed from four union all statements to only two.
-- | 1.18    11 Mar 2022 Douglas Volz Performance improvements for category accounting
-- | 1.19    20 Mar 2022 Douglas Volz Fix for category accounts (valuation accounts) and
-- |                                  added subinventory description.
-- | 1.20    19 Oct 2022 Douglas Volz Fix for valuation accounts, causing duplicate rows.
-- | 1.21    21 Oct 2022 Douglas Volz Fix for detecting Cost Group Accounting.
-- +=============================================================================+*/

## Report Parameters
Period Name (Closed), Cost Type, Category Set 1, Category Set 2, Category Set 3, Item Number, Subinventory, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [inv_organizations](https://www.enginatics.com/library/?pg=1&find=inv_organizations), [cst_cost_group_accounts](https://www.enginatics.com/library/?pg=1&find=cst_cost_group_accounts), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups), [mtl_categories_b](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b), [mtl_category_sets_b](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_b), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories), [mtl_category_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_category_accounts), [mtl_interorg_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_interorg_parameters), [valuation_accounts](https://www.enginatics.com/library/?pg=1&find=valuation_accounts), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [select](https://www.enginatics.com/library/?pg=1&find=select), [inventory_item_id](https://www.enginatics.com/library/?pg=1&find=inventory_item_id), [concatenated_segments](https://www.enginatics.com/library/?pg=1&find=concatenated_segments), [regexp_replace](https://www.enginatics.com/library/?pg=1&find=regexp_replace), [primary_uom_code](https://www.enginatics.com/library/?pg=1&find=primary_uom_code), [inventory_item_status_code](https://www.enginatics.com/library/?pg=1&find=inventory_item_status_code), [item_type](https://www.enginatics.com/library/?pg=1&find=item_type), [inventory_asset_flag](https://www.enginatics.com/library/?pg=1&find=inventory_asset_flag), [period_name](https://www.enginatics.com/library/?pg=1&find=period_name), [acct_period_id](https://www.enginatics.com/library/?pg=1&find=acct_period_id), [nvl](https://www.enginatics.com/library/?pg=1&find=nvl), [sum](https://www.enginatics.com/library/?pg=1&find=sum), [cst_period_close_summary](https://www.enginatics.com/library/?pg=1&find=cst_period_close_summary), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [subinventory_code](https://www.enginatics.com/library/?pg=1&find=subinventory_code), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [category_organization_id](https://www.enginatics.com/library/?pg=1&find=category_organization_id), [category_set_id](https://www.enginatics.com/library/?pg=1&find=category_set_id), [category_id](https://www.enginatics.com/library/?pg=1&find=category_id), [inventory_item_id](https://www.enginatics.com/library/?pg=1&find=inventory_item_id), [concatenated_segments](https://www.enginatics.com/library/?pg=1&find=concatenated_segments), [description](https://www.enginatics.com/library/?pg=1&find=description), [primary_uom_code](https://www.enginatics.com/library/?pg=1&find=primary_uom_code), [inventory_item_status_code](https://www.enginatics.com/library/?pg=1&find=inventory_item_status_code), [item_type](https://www.enginatics.com/library/?pg=1&find=item_type), [period_name](https://www.enginatics.com/library/?pg=1&find=period_name), [subinventory_code](https://www.enginatics.com/library/?pg=1&find=subinventory_code), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Inventory and Intransit Value (Period-End) - Discrete OPM - Pivot by Org 02-Aug-2024 142029.xlsx](https://www.enginatics.com/example/cac-inventory-and-intransit-value-period-end/) |
| Blitz Report™ XML Import | [CAC_Inventory_and_Intransit_Value_Period_End.xml](https://www.enginatics.com/xml/cac-inventory-and-intransit-value-period-end/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-inventory-and-intransit-value-period-end/](https://www.enginatics.com/reports/cac-inventory-and-intransit-value-period-end/) |

## Case Study & Technical Analysis: CAC Inventory and Intransit Value (Period-End)

### Executive Summary
The CAC Inventory and Intransit Value (Period-End) report provides a critical financial view of inventory assets at the close of an accounting period. It enables finance and supply chain teams to reconcile inventory subledger balances with the General Ledger, ensuring accurate financial reporting and compliance. By leveraging period-end snapshots, it offers a stable and auditable record of inventory value.

### Business Challenge
- **Reconciliation Difficulties:** reconciling dynamic inventory balances to static GL period-end balances is often prone to timing errors.
- **Valuation Flexibility:** Standard reports often lack the ability to simulate inventory value using alternative cost types (e.g., for "what-if" analysis or standard cost updates).
- **Granularity:** High-level GL balances do not provide the item or subinventory-level detail needed to investigate variances.

### The Solution
This report solves these challenges by utilizing the inventory period-close process to capture a static snapshot of quantities.
- **Operational View:** It provides a detailed listing of inventory value by Organization, Subinventory, and Item.
- **Flexible Valuation:** Users can choose to value the snapshot quantities using the actual period-end costs or apply a different `Cost Type` to analyze potential revaluation impacts.
- **Focus on Material:** The report specifically isolates Material Account values, aligning with the primary cost element for most inventory valuations.

### Technical Architecture (High Level)
- **Primary Tables:** `MTL_SECONDARY_INVENTORIES`, `INV_ORGANIZATIONS`, `CST_COST_GROUPS`, `MTL_CATEGORIES_B`, `CST_ITEM_COSTS`, `ORG_ACCT_PERIODS`.
- **Logical Relationships:**
    - The report links Inventory Organizations to their respective Operating Units and Ledgers.
    - It retrieves item quantities based on the period-end snapshot logic (implicitly linked to `CST_PERIOD_CLOSE_SUMMARY` or similar snapshot mechanisms via the period name).
    - Item costs are derived either from the historical snapshot or joined from `CST_ITEM_COSTS` based on the selected `Cost Type`.
    - Category sets are joined to provide product-line classification.

### Parameters & Filtering
- **Period Name (Closed):** Mandatory. Specifies the accounting period for which the snapshot data is retrieved. The period must be closed to ensure data integrity.
- **Cost Type:** Optional. If left blank, the report uses the historical costs from the period-end snapshot. If populated, it revalues the period-end quantities using the specified Cost Type (e.g., 'Frozen', 'Pending').
- **Category Set 1 & 2:** Allows filtering and grouping by specific item categories (e.g., Product Line, Inventory Category).
- **Organization Code:** Limits the report to a specific Inventory Organization.
- **Subinventory:** Filters for a specific storage location.
- **Item Number:** Focuses the analysis on a specific item.

### Performance & Optimization
- **Snapshot Utilization:** By querying period-end snapshots rather than recalculating balances from transaction history, the report achieves high performance and consistency.
- **Direct Database Extraction:** The SQL bypasses the overhead of XML parsing often found in standard Oracle reports, delivering large datasets directly to Excel for pivot analysis.
- **Indexed Lookups:** Joins on `INVENTORY_ITEM_ID` and `ORGANIZATION_ID` leverage standard indices to ensure efficient execution even for high-volume organizations.

### FAQ
**Q: Why does the report require a closed period?**
A: The report relies on the inventory snapshot created during the period close process. Without this snapshot, there is no static record of quantities at that specific point in time.

**Q: What happens if I specify a Cost Type?**
A: The report will take the quantities from the period end but value them using the unit costs from the selected Cost Type. This is useful for comparing "Book Value" vs. "Standard Cost" or simulating the impact of a cost update.

**Q: Does this report include WIP value?**
A: No, this report focuses on Inventory and Intransit value. WIP value is typically reported separately via WIP Period Value reports.


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
