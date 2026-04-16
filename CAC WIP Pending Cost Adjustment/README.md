---
layout: default
title: 'CAC WIP Pending Cost Adjustment | Oracle EBS SQL Report'
description: 'Report showing the potential standard cost changes for WIP discrete jobs, for the WIP completions, WIP component issues and WIP resource (labor)…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, WIP, Pending, Cost'
permalink: /CAC%20WIP%20Pending%20Cost%20Adjustment/
---

# CAC WIP Pending Cost Adjustment – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-wip-pending-cost-adjustment/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report showing the potential standard cost changes for WIP discrete jobs, for the WIP completions, WIP component issues and WIP resource (labor) transactions.  (Note that resource overheads / production overheads are not included in this report version.)  The Cost Type (Old) defaults to your Costing Method Cost Type (Average, Standard, etc.); the Currency Conversion Dates default to the latest open or closed accounting period; and the To Currency Code and the Organization Code default from the organization code set for this session.   And if you choose Yes for "Include All WIP Jobs" all WIP jobs will be reported even if there are no valuation changes.

Parameters:
===========
Cost Type (New):  enter the Cost Type that has the revised or new item costs (mandatory).
Cost Type (Old):  enter the Cost Type that has the existing or current item costs, defaults to the Frozen Cost Type (mandatory).
Currency Conversion Date (New):  enter the currency conversion date to use for the new item costs (mandatory).
Currency Conversion Type (New):  enter the currency conversion type to use for the new item costs, defaults to Corporate (mandatory).
Currency Conversion Date (Old):  enter the currency conversion date to use for the existing item costs (mandatory).
Currency Conversion Type (Old):  enter the currency conversion type to use for the existing item costs, defaults to Corporate (mandatory).
To Currency Code:  enter the currency code used to translate the item costs and inventory values into.
Category Set 1:  the first item category set to report, typically the Cost or Product Line Category Set (optional).
Category Set 2:  The second item category set to report, typically the Inventory Category Set (optional).
Include All WIP Jobs:  enter No to only report WIP jobs with valuation changes, enter Yes to report all WIP jobs. (mandatory).
Item Number:  specific buy or make item you wish to report (optional).
Organization Code:  enter the inventory organization(s) you wish to report, defaults to your session's inventory organization (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2020 - 2024 Douglas Volz Consulting, Inc.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this
-- |  permission. All rights reserved.
-- +=============================================================================+

-- |  Version Modified on  Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |      1.0 04 Dec 2020 Douglas Volz   Created initial Report based on the Pending
-- |                                     Cost Adjustment Report for Inventory and Intransit.
-- |      1.1 11 Dec 2020 Douglas Volz   Corrected cost adjustments for assemblies
-- |      1.2 16 Dec 2020 Douglas Volz   Change SIGN of completion quantities to match
-- |                                     the Oracle WIP Standard Cost Adjustment Report.
-- |      1.3 10 Feb 2021 Douglas Volz   Fixes for WIP completion quantities, needed to
-- |                                     change the SIGN of completion quantities.
-- |      1.4 17 Feb 2021 Douglas Volz   Add absolute difference column.
-- |      1.5 13 Dec 2021 Douglas Volz   Add parameter to report all WIP jobs, even
-- |                                     if there is no valuation change.
-- |      1.6 12 Feb 2024 Douglas Volz   Remove tabs, simplify G/L conversion rates,
-- |                                     added inventory org access security.
-- +=============================================================================+*/

## Report Parameters
Cost Type (New), Cost Type (Old), Currency Conversion Date (New), Currency Conversion Type (New), Currency Conversion Date (Old), Currency Conversion Type (Old), To Currency Code, Category Set 1, Category Set 2, Category Set 3, Include All WIP Jobs, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used


## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC WIP Pending Cost Adjustment 10-Jul-2022 165903.xlsx](https://www.enginatics.com/example/cac-wip-pending-cost-adjustment/) |
| Blitz Report™ XML Import | [CAC_WIP_Pending_Cost_Adjustment.xml](https://www.enginatics.com/xml/cac-wip-pending-cost-adjustment/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-wip-pending-cost-adjustment/](https://www.enginatics.com/reports/cac-wip-pending-cost-adjustment/) |


## Case Study & Technical Analysis: CAC WIP Pending Cost Adjustment

### Executive Summary
The **CAC WIP Pending Cost Adjustment** report is a predictive financial tool used during the Standard Cost Update process. While the "Inventory Pending Cost Adjustment" report covers goods on the shelf, this report covers goods *in production*.
It simulates the revaluation of Work in Process (WIP) balances that will occur when standard costs are updated. This allows Finance to:
1.  **Forecast WIP Revaluation:** Predict the gain or loss that will hit the P&L due to the revaluation of open jobs.
2.  **Validate Resource Rates:** Ensure that changes to labor and machine rates are correctly reflected in the WIP value.
3.  **Audit Component Costs:** Verify that the new standard costs for raw materials are correctly propagating to the jobs where they have been issued.

### Business Challenge
Updating standard costs affects not just inventory, but also the value of every open work order.
*   **The "WIP Revaluation" Event:** When you run "Update Standard Costs," Oracle takes a snapshot of all open jobs.
    *   If you issued a component at $10 (Old Cost) and it is now $12 (New Cost), the system revalues that issued quantity and posts a $2 variance.
    *   If you completed an assembly at $100 (Old Cost) but it hasn't been closed, and the new cost is $110, the system adjusts the relief amount.
*   **Complexity:** WIP value is a mix of Materials, Resources, Overheads, and Outside Processing. A simple "Item Cost" report doesn't show the impact on labor or machine time already charged to the job.

### The Solution
This report acts as a "What-If" engine for WIP.
*   **Three-Pronged Analysis:** It breaks down the revaluation into:
    1.  **WIP Completions:** The impact on the assembly itself (for jobs that are partially complete).
    2.  **Component Issues:** The impact on raw materials sitting in the job.
    3.  **Resources:** The impact on labor and machine hours already charged.
*   **Currency Simulation:** Like its Inventory counterpart, it allows users to simulate the impact of exchange rate changes on the cost of components or resources defined in foreign currencies.
*   **Granular Visibility:** It lists every job, operation, and resource, allowing users to pinpoint exactly *where* the value change is coming from (e.g., "Job 12345, Operation 10, Labor Rate increase").

### Technical Architecture (High Level)
The query constructs a massive union of the three WIP value drivers.
*   **Component Logic:**
    *   Scans `WIP_REQUIREMENT_OPERATIONS` (or `MTL_MATERIAL_TRANSACTIONS` depending on the exact logic variant) to find issued quantities.
    *   Joins to `CST_ITEM_COSTS` twice (Old vs. New) to calculate the delta.
*   **Resource Logic:**
    *   Scans `WIP_OPERATIONS` (or `WIP_TRANSACTION_ACCOUNTS` history) to find applied resource hours.
    *   Joins to `BOM_RESOURCES` and `CST_ITEM_COSTS` (for resource rates) to calculate the delta.
*   **Assembly Logic:**
    *   Looks at `WIP_DISCRETE_JOBS.QUANTITY_COMPLETED` to determine the relief value adjustment.
*   **Exclusions:** The description notes that "resource overheads / production overheads are not included." This is a key technical detail—it focuses on the *direct* costs (Material and Direct Labor) rather than the allocated burdens.

### Parameters & Filtering
*   **Cost Type (New/Old):** The two sets of costs to compare.
*   **Currency Conversion:** For simulating FX impacts.
*   **Include All WIP Jobs:** A toggle to show even those jobs with $0 variance (useful for proving that a cost update *won't* affect certain product lines).
*   **Organization/Item:** Standard filters.

### Performance & Optimization
*   **Union All:** The query likely uses `UNION ALL` to combine the Component, Resource, and Assembly datasets. This is efficient but results in a large number of rows for high-volume manufacturing.
*   **Cost Type Filtering:** By filtering `CST_ITEM_COSTS` early, the query minimizes the join volume.

### FAQ
**Q: Why is the "New Material Overhead Cost" calculated differently for WIP Completions?**
A: The code snippet shows a `CASE` statement: `round(nvl(cic1.material_overhead_cost,0) - nvl(cic1.tl_material_overhead,0),5)`. This logic subtracts "This Level" (TL) overheads. This is likely to avoid double-counting overheads that are applied at the assembly level versus those rolled up from components.

**Q: Does this report update the costs?**
A: No, it is purely a reporting tool. The actual update happens when you run the "Update Standard Costs" concurrent program.

**Q: Why don't I see Overhead variances?**
A: As noted in the description, this specific version of the report excludes overheads. This is often done because overheads are calculated as a percentage of resource/material, so their variance is a derivative of the base cost variance.


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
