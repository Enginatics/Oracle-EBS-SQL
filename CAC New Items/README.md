---
layout: default
title: 'CAC New Items | Oracle EBS SQL Report'
description: 'Report to show items which have been recently created, including various item controls, item costs (per your Costing Method), item master accounts, last…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, New, Items, mtl_material_transactions, mtl_transaction_types, mtl_onhand_quantities_detail'
permalink: /CAC%20New%20Items/
---

# CAC New Items – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-new-items/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show items which have been recently created, including various item controls, item costs (per your Costing Method), item master accounts, last transaction and onhand stock, based on the item master creation date.

Parameters:
===========
Creation Date From:  starting item master creation date (required).
Creation Date To: ending item master creation date (required).
Include Uncosted Items:  enter Yes to display items which are set to not be costed in your Costing Method Cost Type, defaulted as Yes (mandatory).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).S
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2010 - 2023 Douglas Volz Consulting, Inc.                         |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_new_items_rept.sql
-- |
-- |
-- | Description:
-- | Report to show zero item costs in the "costing method" cost type, 
-- | the creation date and any onhand stock.
-- | 
-- | version modified on modified by description
-- | ======= =========== ============== =========================================
-- |  1.0    14 jun 2017 Douglas Volz   Initial coding based on the zero item cost
-- |                                    report, xxx_zero_item_cost_report.sql, version 1.3
-- |  1.1    20 Jan 2020 Douglas Volz   Added Org Code and Operating Unit parameters.
-- |  1.2    07 Jul 2022 Douglas Volz   Changed to multi-language views for the item
-- |                                    master and inventory orgs.  Added item master
-- |                                    accounts and costs by cost element.
-- |  1.3    09 Jul 2023 Douglas Volz   Remove tabs and restrict to only orgs you have
-- |                                    access to, using the org access view.
-- |  1.4    08 Aug 2023 Douglas Volz   Fix item status code to use translated values.
-- |  1.5    22 Nov 2023 Douglas Volz   Add BOM/Routing/Sourcing Rule columns, item master
-- |                                    created by and std lot size and costing created by,
-- |                                    costing lot size and defaulted flag. 
-- |  1.6    05 Dec 2023 Douglas Volz   Added G/L and Operating Unit security restrictions. 
-- +=============================================================================+*/

## Report Parameters
Creation Date From, Creation Date To, Include Uncosted Items, Assignment Set, Category Set 1, Category Set 2, Category Set 3, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types), [mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail), [bom_structures_b](https://www.enginatics.com/library/?pg=1&find=bom_structures_b), [bom_operational_routings](https://www.enginatics.com/library/?pg=1&find=bom_operational_routings), [mrp_sr_receipt_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_receipt_org), [mrp_sr_source_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_source_org), [mrp_sourcing_rules](https://www.enginatics.com/library/?pg=1&find=mrp_sourcing_rules), [mrp_sr_assignments](https://www.enginatics.com/library/?pg=1&find=mrp_sr_assignments), [mrp_assignment_sets](https://www.enginatics.com/library/?pg=1&find=mrp_assignment_sets), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC Item vs. Component Include in Rollup Controls](/CAC%20Item%20vs-%20Component%20Include%20in%20Rollup%20Controls/ "CAC Item vs. Component Include in Rollup Controls Oracle EBS SQL Report"), [MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC New Items 07-Jul-2022 142245.xlsx](https://www.enginatics.com/example/cac-new-items/) |
| Blitz Report™ XML Import | [CAC_New_Items.xml](https://www.enginatics.com/xml/cac-new-items/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-new-items/](https://www.enginatics.com/reports/cac-new-items/) |

## Case Study & Technical Analysis: CAC New Items

### Executive Summary
The **CAC New Items** report is a Master Data governance tool. It lists all items created within a specified date range, providing a comprehensive view of their setup status: Costing, Accounting, Categories, and Inventory Controls. It is the "New Hire Orientation" for your Inventory Master.

### Business Challenge
*   **Data Quality**: New items are the most common source of errors. Users forget to assign a Category, set the "Costed" flag, or define the COGS account.
*   **Process Control**: "Did the Engineering team finish setting up the new product line?"
*   **Costing Gaps**: Identifying items that have been created but have a zero cost (or haven't been costed yet).

### Solution
This report provides a 360-degree view of the new item.
*   **Attributes**: Lists Status, Make/Buy, UOM, and Asset Flag.
*   **Financials**: Shows the current Unit Cost and the default GL accounts.
*   **Activity**: Shows the "Last Transaction Date" to see if the item is already being used.
*   **Stock**: Shows current On-hand quantity.

### Technical Architecture
*   **Primary Driver**: `mtl_system_items.creation_date`.
*   **Joins**: Links to `cst_item_costs` (for cost), `gl_code_combinations` (for accounts), and `mtl_onhand_quantities` (for stock).

### Parameters
*   **Creation Date From/To**: (Mandatory) The window of time to audit.
*   **Include Uncosted Items**: (Mandatory) "Yes" allows you to find items that missed the costing process.

### Performance
*   **Fast**: Filtering by Creation Date is highly efficient.

### FAQ
**Q: Does it show who created the item?**
A: Yes, it typically includes the "Created By" user ID.

**Q: Can I use this to find "Changed" items?**
A: No, this only looks at the *Creation* date. To find changed items, you would need to query the `last_update_date` or use an audit trail report.


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
