---
layout: default
last_modified_at: 2026-10-26
title: 'CAC Inventory and Intransit Value (Period-End) - Discrete/OPM | Oracle EBS SQL Report'
description: 'Report showing amount of inventory at the end of the month for both Discrete and Process Manufacturing (OPM) inventory organizations. If you enter a cost…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Inventory, Intransit, Value, pjm_org_parameters, mtl_category_accounts, mtl_parameters'
permalink: /CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/
report_name: 'CAC Inventory and Intransit Value (Period-End) - Discrete/OPM'
report_web_name: cac-inventory-and-intransit-value-period-end-discrete-opm
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Inventory and Intransit Value (Period-End) - Discrete/OPM – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-inventory-and-intransit-value-period-end-discrete-opm/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

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
-- |  1.36    24 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Period Name (Closed), Cost Type, OPM Calendar Code, OPM Period Code, Category Set 1, Category Set 2, Category Set 3, Item Number, Subinventory, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[pjm_org_parameters](https://www.enginatics.com/library/?pg=1&find=pjm_org_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [mtl_category_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_category_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [cm_whse_asc](https://www.enginatics.com/library/?pg=1&find=cm_whse_asc&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [gmf_fiscal_policies](https://www.enginatics.com/library/?pg=1&find=gmf_fiscal_policies&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [gmf_period_statuses](https://www.enginatics.com/library/?pg=1&find=gmf_period_statuses&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [gl_item_cst](https://www.enginatics.com/library/?pg=1&find=gl_item_cst&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [cm_mthd_mst](https://www.enginatics.com/library/?pg=1&find=cm_mthd_mst&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [cm_cmpt_dtl](https://www.enginatics.com/library/?pg=1&find=cm_cmpt_dtl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [cm_cmpt_mst_b](https://www.enginatics.com/library/?pg=1&find=cm_cmpt_mst_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [mtl_interorg_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_interorg_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [cst_cost_group_accounts](https://www.enginatics.com/library/?pg=1&find=cst_cost_group_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [cst_period_close_summary](https://www.enginatics.com/library/?pg=1&find=cst_period_close_summary&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [gmf_period_balances](https://www.enginatics.com/library/?pg=1&find=gmf_period_balances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [gmf_xla_extract_headers](https://www.enginatics.com/library/?pg=1&find=gmf_xla_extract_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [gmf_xla_extract_lines](https://www.enginatics.com/library/?pg=1&find=gmf_xla_extract_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [mtl_transaction_lot_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_lot_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm)

## Related Reports
[CAC OPM Costed Formula](/CAC%20OPM%20Costed%20Formula/ "CAC OPM Costed Formula Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC OPM Batch Material Summary](/CAC%20OPM%20Batch%20Material%20Summary/ "CAC OPM Batch Material Summary Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [CAC OPM WIP Account Value](/CAC%20OPM%20WIP%20Account%20Value/ "CAC OPM WIP Account Value Oracle EBS SQL Report"), [INV Slow Moving Inventory](/INV%20Slow%20Moving%20Inventory/ "INV Slow Moving Inventory Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [ONT Orders and Lines 11i](/ONT%20Orders%20and%20Lines%2011i/ "ONT Orders and Lines 11i Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Inventory and Intransit Value (Period-End) - Discrete OPM - Pivot by Org 02-Aug-2024 142029.xlsx](https://www.enginatics.com/example/cac-inventory-and-intransit-value-period-end-discrete-opm/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm) |
| Blitz Report™ XML Import | [CAC_Inventory_and_Intransit_Value_Period_End_Discrete_OPM.xml](https://www.enginatics.com/xml/cac-inventory-and-intransit-value-period-end-discrete-opm/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm) |
| SQL Source | [CAC Inventory and Intransit Value (Period-End) - Discrete-OPM.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-inventory-and-intransit-value-period-end-discrete-opm/](https://www.enginatics.com/reports/cac-inventory-and-intransit-value-period-end-discrete-opm/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-inventory-and-intransit-value-period-end-discrete-opm)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
