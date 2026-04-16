---
layout: default
title: 'CAC ICP PII WIP Pending Cost Adjustment | Oracle EBS SQL Report'
description: 'Report showing the potential standard cost changes for WIP discrete jobs, for the WIP completions, WIP component issues and WIP resource (labor)…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, ICP, PII, WIP'
permalink: /CAC%20ICP%20PII%20WIP%20Pending%20Cost%20Adjustment/
---

# CAC ICP PII WIP Pending Cost Adjustment – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-icp-pii-wip-pending-cost-adjustment/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report showing the potential standard cost changes for WIP discrete jobs, for the WIP completions, WIP component issues and WIP resource (labor) transactions, including gross costs, profit in inventory (commonly abbreviated as PII or ICP - InterCompany Profit).  (Note that resource overheads / production overheads are not included in this report version.)  The Cost Type (Old) defaults to your Costing Method Cost Type (Average, Standard, etc.); the Currency Conversion Dates default to the latest open or closed accounting period; and the To Currency Code and the Organization Code default from the organization code set for this session.   And if you choose Yes for "Include All WIP Jobs" all WIP jobs will be reported even if there are no valuation changes.

-- =================================================================
Copyright 2022 Douglas Volz Consulting, Inc.
All rights reserved.
Permission to use this code is granted provided the original author is  acknowledged
Original Author: Douglas Volz (doug@volzconsulting.com)
-- =================================================================

Hidden Parameters:
p_sign_pii:  Hidden parameter to set the sign of the profit in inventory amounts.  This parameter determines if PII is normally entered as a positive or negative amount.

Displayed Parameters:
Cost Type (New):  the new cost type to be reported, mandatory
Cost Type (Old):  the old cost type to be reported, mandatory
PII Cost Type (New):  the new PII_Cost_Type you wish to report
PII Cost Type(Old):  the prior or old PII_Cost_Type you wish to report such as PII or ICP (mandatory)
PII Sub-Element:  the sub-element or resource for profit in inventory, such as PII or ICP (mandatory)
Currency Conversion Date (New):  the new currency conversion date, mandatory
Currency Conversion Date (Old):   the old currency conversion date, mandatory
Currency Conversion Type (New):  the desired currency conversion type to use for cost type 1, mandatory
Currency Conversion Type (Old ):  the desired currency conversion type to use for cost type 2, mandatory
To Currency Code:  the currency you are converting into
Category Set 1:  the first item category set to report, typically the Cost or Product Line Category_Set
Category Set 2:  the second item category set to report, typically the Inventory Category_Set
All WIP Jobs:  enter No to only report WIP jobs with valuation changes, enter Yes to report all WIP jobs.
Org Code:  specific inventory organization you wish to report (optional)
Operating Unit:  operating unit you wish to report, leave blank for all operating units (optional) 
Ledger:  general ledger you wish to report, leave blank for all ledgers (optional)

-- |  Version Modified on  Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |      1.6 08 Jun 2022 Douglas Volz   Create PII version based on WIP Pending Cost Adjust Rept.


## Report Parameters
Cost Type (New), Cost Type (Old), PII Cost Type (New), PII Cost Type (Old), PII Sub-Element, Currency Conversion Date (New), Currency Conversion Type (New), Currency Conversion Date (Old), Currency Conversion Type (Old), To Currency Code, Category Set 1, Category Set 2, Category Set 3, Include All WIP Jobs, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used


## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC ICP PII WIP Pending Cost Adjustment 23-Jun-2022 155341.xlsx](https://www.enginatics.com/example/cac-icp-pii-wip-pending-cost-adjustment/) |
| Blitz Report™ XML Import | [CAC_ICP_PII_WIP_Pending_Cost_Adjustment.xml](https://www.enginatics.com/xml/cac-icp-pii-wip-pending-cost-adjustment/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-icp-pii-wip-pending-cost-adjustment/](https://www.enginatics.com/reports/cac-icp-pii-wip-pending-cost-adjustment/) |

## Case Study & Technical Analysis: CAC ICP PII WIP Pending Cost Adjustment

### Executive Summary
The **CAC ICP PII WIP Pending Cost Adjustment** report is a predictive financial tool designed for manufacturing organizations undergoing standard cost updates. It forecasts the financial impact of revaluing Work in Process (WIP) inventory, with a specific focus on **Profit in Inventory (PII)**.
By comparing "Old" (current) standard costs against "New" (proposed) standard costs, this report allows Finance to:
1.  **Preview the P&L Impact:** Calculate the potential revaluation gain/loss before running the official cost update.
2.  **Isolate PII Movements:** Specifically track how the intercompany profit portion of WIP value will change, ensuring that elimination entries remain accurate.
3.  **Audit Cost Changes:** Verify that proposed cost changes are applied correctly across all open WIP jobs.

### Business Challenge
Changing standard costs in an Oracle EBS environment triggers an automatic revaluation of on-hand and WIP inventory.
*   **The "Black Box" Update:** The standard `WIP Standard Cost Adjustment` process posts entries to the General Ledger but doesn't provide a detailed, job-by-job breakdown of *why* the value changed, especially regarding PII.
*   **Intercompany Complexity:** For multinational corporations, a change in the transfer price of a component affects the PII embedded in every open job using that component. Finance needs to know if a $1M revaluation is due to genuine material cost changes or just a shift in intercompany profit.
*   **Month-End Surprise:** Without this report, the revaluation entry is often a surprise at month-end. This report moves that analysis to the *pre-close* phase.

### The Solution
This report simulates the revaluation logic used by the Oracle Cost Management engine.
*   **Dual Cost Type Comparison:** It joins the WIP job components and assemblies to two distinct cost types (e.g., "Frozen" vs. "Pending") to calculate the delta.
*   **Granular Analysis:** It breaks down the revaluation by:
    *   **WIP Completions:** Finished goods sitting in WIP (moved to inventory but not yet closed).
    *   **Component Issues:** Raw materials issued to the job.
    *   **Resources:** Labor and overhead applied to the job.
*   **PII Isolation:** It specifically looks for the PII cost element (defined by parameter) to report the "Profit" portion of the revaluation separately from the "Gross" cost change.

### Technical Architecture (High Level)
The query constructs a "What-If" scenario by aggregating the current state of all open WIP jobs and pricing them twice.
*   **`sumwip` (CTE):** This is the core engine. It aggregates the three main sources of WIP value:
    1.  **Net Assemblies:** (Completions - Returns) * Standard Cost.
    2.  **Net Components:** (Issues - Returns) * Standard Cost.
    3.  **Net Resources:** (Applied) * Resource Rate.
*   **Cost Joins:** The query joins `sumwip` to `CST_ITEM_COSTS` twice (aliased as `cic1` for New and `cic2` for Old).
*   **PII Logic:** It uses the `PII Cost Type` and `PII Sub-Element` parameters to fetch the specific cost element representing profit from `CST_ITEM_COST_DETAILS`.

### Parameters & Filtering
*   **Cost Type (New/Old):** The two snapshots to compare (e.g., "Pending" vs. "Frozen").
*   **PII Cost Type (New/Old):** The specific cost types holding the PII values (often the same as the main cost types, but can be separate).
*   **PII Sub-Element:** The resource name used to tag PII (e.g., "ICP", "PII").
*   **Include All WIP Jobs:** If "No", filters out jobs with zero variance, focusing the user only on material changes.

### Performance & Optimization
*   **Aggregation First:** The query aggregates transactions in the `sumwip` CTE *before* joining to the heavy cost tables. This significantly reduces the number of rows processed in the final join.
*   **Materialized View Usage:** It leverages `MTL_MATERIAL_TRANSACTIONS` and `WIP_TRANSACTION_ACCOUNTS` logic (simulated) to determine the current quantity balances in WIP.

### FAQ
**Q: Why does the report show a revaluation for "Resources"?**
A: If your labor rates or overhead rates are changing in the new cost type, the value of the labor already applied to open jobs will be revalued.

**Q: Does this report update the costs?**
A: No, this is a *reporting-only* tool. It simulates the update. The actual update is performed by the "Update Standard Costs" concurrent program.

**Q: What happens if a job has no PII?**
A: The "PII" columns will show 0, but the "Gross" columns will still show the standard cost impact. This allows the report to serve as a general-purpose revaluation preview tool, not just for PII.


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
