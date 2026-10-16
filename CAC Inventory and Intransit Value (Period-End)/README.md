---
layout: default
last_modified_at: 2026-10-16
title: 'CAC Inventory and Intransit Value (Period-End) | Oracle EBS SQL Report'
description: 'Report showing amount of inventory at the end of the month. If you enter a cost type this report uses the item costs from the cost type; if you leave the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Inventory, Intransit, Value, pjm_org_parameters, mtl_category_accounts, mtl_parameters'
permalink: /CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/
report_name: 'CAC Inventory and Intransit Value (Period-End)'
report_web_name: cac-inventory-and-intransit-value-period-end
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Inventory and Intransit Value (Period-End) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-inventory-and-intransit-value-period-end/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Period Name (Closed), Cost Type, Category Set 1, Category Set 2, Category Set 3, Item Number, Subinventory, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[pjm_org_parameters](https://www.enginatics.com/library/?pg=1&find=pjm_org_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [mtl_category_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_category_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [cst_cost_group_accounts](https://www.enginatics.com/library/?pg=1&find=cst_cost_group_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [mtl_categories_b](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [mtl_category_sets_b](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [mtl_interorg_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_interorg_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [cst_period_close_summary](https://www.enginatics.com/library/?pg=1&find=cst_period_close_summary&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end)

## Related Reports
[CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [CAC AP Accrual IR ISO Match Analysis](/CAC%20AP%20Accrual%20IR%20ISO%20Match%20Analysis/ "CAC AP Accrual IR ISO Match Analysis Oracle EBS SQL Report"), [CAC Material Account Alias with Lot Numbers](/CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers/ "CAC Material Account Alias with Lot Numbers Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report"), [CAC Missing Receiving Accounting Transactions](/CAC%20Missing%20Receiving%20Accounting%20Transactions/ "CAC Missing Receiving Accounting Transactions Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report"), [CAC Item Cost Summary](/CAC%20Item%20Cost%20Summary/ "CAC Item Cost Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Inventory and Intransit Value (Period-End) - Discrete OPM - Pivot by Org 02-Aug-2024 142029.xlsx](https://www.enginatics.com/example/cac-inventory-and-intransit-value-period-end/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end) |
| Blitz Report™ XML Import | [CAC_Inventory_and_Intransit_Value_Period_End.xml](https://www.enginatics.com/xml/cac-inventory-and-intransit-value-period-end/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end) |
| SQL Source | [CAC Inventory and Intransit Value (Period-End).sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-inventory-and-intransit-value-period-end/](https://www.enginatics.com/reports/cac-inventory-and-intransit-value-period-end/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
