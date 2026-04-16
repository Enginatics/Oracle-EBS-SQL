---
layout: default
title: 'CAC Inventory and Intransit Value (Period-End) - Discrete/OPM | Oracle EBS SQL Report'
description: 'Report showing amount of inventory at the end of the month for both Discrete and Process Manufacturing (OPM) inventory organizations. If you enter a cost…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Inventory, Intransit, Value, mtl_secondary_inventories, inv_organizations, cst_cost_group_accounts'
permalink: /CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/
---

# CAC Inventory and Intransit Value (Period-End) - Discrete/OPM – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-inventory-and-intransit-value-period-end-discrete-opm/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report showing amount of inventory at the end of the month for both Discrete and Process Manufacturing (OPM) inventory organizations.  If you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end snapshot.  In either case this report uses the month-end quantities, based on the entered period name, OPM calendar code and OPM period code.  And as these quantities come from the month-end snapshot (created when you close the inventory accounting period or run the GMF Period Close Process) and this snapshot is only by inventory organization, subinventory and item and not split out by cost element, this report only shows the Material Account, based upon your Costing Method.

Notes:  
1)  OPM intransit balances based upon last two years of Intransit Shipments.  As of Release 12.2.13, OPM does not have a month-end snapshot for intransit quantities or balances.
2)  This report assumes you use both OPM and Discrete Manufacturing.  If you only use Discrete Manufacturing, use the CAC Inventory and Intransit Value (Period-End) report instead.

Discrete and OPM Parameters:
============================
Period Name (Closed):  the closed inventory accounting period you wish to report (mandatory).
Cost Type:  enter a Cost Type to value the quantities using the Cost Type item costs; or, if Cost Type is not entered the report will use the stored month-end snapshot values (optional).
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
-- | Copyright 2009 - 2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission.                                                                           
-- +=============================================================================+
-- | 1.0     27 Sep 2009 Douglas Volz Initial Coding
-- | 1.29    04 Jun 2024 Douglas Volz Fix SQL error for Intransit code section, due to duplicate transactions in GXEH
-- |                                  (ORA-01427: single-row subquery returns more than one row).
-- | 1.30    09 Jun 2024 Douglas Volz Fix Intransit joins for UOMs, organizations and for duplicate Intransit quantities.
-- | 1.31    25 Jun 2024 Douglas Volz Add Period Code join for Intransit, to avoid cross-joining.
-- | 1.32    27 Jun 2024 Douglas Volz Get intransit account based on the Shipping Network, to avoid duplicate quantities.
-- | 1.33    28 Jun 2024 Douglas Volz Base Intransit SQL logic on two years of Intransit Shipments, not on mtl_supply.
-- | 1.34    30 Jun 2024 Douglas Volz Get default intransit account in case the Shipping Network has been deleted or changed.
-- | 1.35    08 Aug 2024 Douglas Volz Add OPM Cost Organizations to get correct item costs and qtys.
-- +=============================================================================+*/

## Report Parameters
Period Name (Closed), Cost Type, OPM Calendar Code, OPM Period Code, Category Set 1, Category Set 2, Category Set 3, Item Number, Subinventory, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [inv_organizations](https://www.enginatics.com/library/?pg=1&find=inv_organizations), [cst_cost_group_accounts](https://www.enginatics.com/library/?pg=1&find=cst_cost_group_accounts), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups), [mtl_categories_b](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b), [mtl_category_sets_b](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_b), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories), [mtl_category_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_category_accounts), [mtl_interorg_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_interorg_parameters), [valuation_accounts](https://www.enginatics.com/library/?pg=1&find=valuation_accounts), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [select](https://www.enginatics.com/library/?pg=1&find=select), [inventory_item_id](https://www.enginatics.com/library/?pg=1&find=inventory_item_id), [concatenated_segments](https://www.enginatics.com/library/?pg=1&find=concatenated_segments), [regexp_replace](https://www.enginatics.com/library/?pg=1&find=regexp_replace), [primary_uom_code](https://www.enginatics.com/library/?pg=1&find=primary_uom_code), [inventory_item_status_code](https://www.enginatics.com/library/?pg=1&find=inventory_item_status_code), [item_type](https://www.enginatics.com/library/?pg=1&find=item_type), [planning_make_buy_code](https://www.enginatics.com/library/?pg=1&find=planning_make_buy_code), [inventory_asset_flag](https://www.enginatics.com/library/?pg=1&find=inventory_asset_flag), [period_name](https://www.enginatics.com/library/?pg=1&find=period_name), [acct_period_id](https://www.enginatics.com/library/?pg=1&find=acct_period_id), [nvl](https://www.enginatics.com/library/?pg=1&find=nvl), [sum](https://www.enginatics.com/library/?pg=1&find=sum), [cst_period_close_summary](https://www.enginatics.com/library/?pg=1&find=cst_period_close_summary), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [subinventory_code](https://www.enginatics.com/library/?pg=1&find=subinventory_code), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [category_organization_id](https://www.enginatics.com/library/?pg=1&find=category_organization_id), [category_set_id](https://www.enginatics.com/library/?pg=1&find=category_set_id), [category_id](https://www.enginatics.com/library/?pg=1&find=category_id), [inventory_item_id](https://www.enginatics.com/library/?pg=1&find=inventory_item_id), [concatenated_segments](https://www.enginatics.com/library/?pg=1&find=concatenated_segments), [description](https://www.enginatics.com/library/?pg=1&find=description), [primary_uom_code](https://www.enginatics.com/library/?pg=1&find=primary_uom_code), [inventory_item_status_code](https://www.enginatics.com/library/?pg=1&find=inventory_item_status_code), [item_type](https://www.enginatics.com/library/?pg=1&find=item_type), [planning_make_buy_code](https://www.enginatics.com/library/?pg=1&find=planning_make_buy_code), [period_name](https://www.enginatics.com/library/?pg=1&find=period_name), [subinventory_code](https://www.enginatics.com/library/?pg=1&find=subinventory_code), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Inventory and Intransit Value (Period-End) - Discrete OPM - Pivot by Org 02-Aug-2024 142029.xlsx](https://www.enginatics.com/example/cac-inventory-and-intransit-value-period-end-discrete-opm/) |
| Blitz Report™ XML Import | [CAC_Inventory_and_Intransit_Value_Period_End_Discrete_OPM.xml](https://www.enginatics.com/xml/cac-inventory-and-intransit-value-period-end-discrete-opm/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-inventory-and-intransit-value-period-end-discrete-opm/](https://www.enginatics.com/reports/cac-inventory-and-intransit-value-period-end-discrete-opm/) |

## Case Study & Technical Analysis: CAC Inventory and Intransit Value (Period-End) - Discrete/OPM

### Executive Summary
The **CAC Inventory and Intransit Value (Period-End) - Discrete/OPM** report is a unified valuation tool designed for hybrid manufacturing environments. It consolidates inventory reporting for organizations using Oracle Discrete Manufacturing and Oracle Process Manufacturing (OPM). By providing a single view of inventory assets across both methodologies, it simplifies the month-end reconciliation process for complex enterprises.

### Business Challenge
Companies operating both Discrete and Process manufacturing often face a "reporting divide."
*   **Data Silos**: Discrete inventory data lives in `cst_period_close_summary`, while OPM data is historically stored in separate GMF tables.
*   **Consolidation Pain**: Finance teams often have to run two separate sets of reports and manually merge them in Excel to get a total inventory number.
*   **Intransit Complexity**: OPM has historically lacked robust month-end snapshots for intransit inventory, making accurate valuation difficult.

### Solution
This report bridges the architectural gap between the two modules.
*   **Unified Output**: Presents Discrete and OPM inventory side-by-side in a consistent format.
*   **OPM Intransit Logic**: Implements a custom logic (based on the last two years of shipments) to reconstruct OPM intransit balances, addressing a known gap in standard OPM reporting.
*   **Flexible Costing**: Allows valuation using either the historical snapshot cost or a "What-If" cost type.

### Technical Architecture
The report employs a sophisticated "Union" structure to merge the data sources:
*   **Discrete Leg**: Queries `cst_period_close_summary` for standard discrete organizations.
*   **OPM Leg**: Queries OPM-specific tables (implied by the need for Calendar/Period codes) and logic to derive quantities.
*   **Intransit Calculation**: For OPM, it calculates intransit based on shipment history rather than a simple table read, ensuring accuracy even without a native snapshot.

### Parameters
*   **Period Name**: (Mandatory) The accounting period to report.
*   **OPM Calendar/Period Code**: (Mandatory) Specific OPM timeframes required to align with the Discrete period.
*   **Cost Type**: (Optional) For revaluation analysis.

### Performance
*   **Complex Execution**: Due to the need to calculate OPM intransit from transaction history, this report may take longer to run than a standard discrete-only report.
*   **Optimization**: Users should filter by Organization or Operating Unit if performance becomes an issue in large environments.

### FAQ
**Q: Why do I need OPM Calendar codes?**
A: OPM uses a different calendar system than the standard General Ledger/Inventory calendar. The report needs these codes to find the correct period in the OPM subledger.

**Q: Does this support "Process" organizations that use Standard Costing?**
A: Yes, the report is designed to handle the specific costing nuances of OPM organizations.

**Q: What if I only have Discrete orgs?**
A: You can use this report, but the standard "CAC Inventory and Intransit Value (Period-End)" report might be slightly faster as it doesn't contain the OPM logic overhead.


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
