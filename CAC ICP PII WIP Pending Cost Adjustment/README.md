---
layout: default
last_modified_at: 2026-10-26
title: 'CAC ICP PII WIP Pending Cost Adjustment | Oracle EBS SQL Report'
description: 'Report showing the potential standard cost changes for WIP discrete jobs, for the WIP completions, WIP component issues and WIP resource (labor)…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, ICP, PII, WIP, gl_daily_conversion_types, gl_daily_rates, cst_cost_types'
permalink: /CAC%20ICP%20PII%20WIP%20Pending%20Cost%20Adjustment/
report_name: 'CAC ICP PII WIP Pending Cost Adjustment'
report_web_name: cac-icp-pii-wip-pending-cost-adjustment
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC ICP PII WIP Pending Cost Adjustment – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-icp-pii-wip-pending-cost-adjustment/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report showing the potential standard cost changes for WIP discrete jobs, for the WIP completions, WIP component issues and WIP resource (labor) transactions, including gross costs, profit in inventory (commonly abbreviated as PII or ICP - InterCompany Profit).

Production overheads (resource overheads) are reported per WIP operation and overhead, from the department overhead rates of the two cost types.  Move-based overheads earn on the operation quantity completed (Item basis) or once per operation (Lot basis); resource-based overheads earn on the applied resource units (Resource Units basis) or on the applied resource units at the resource rate of each cost type (Resource Value basis), for the overheads assigned to the resource.  For these rows the WIP Quantity is this overhead basis quantity.

The Cost Type (Old) defaults to your Costing Method Cost Type (Average, Standard, etc.); the Currency Conversion Dates default to the latest open or closed accounting period; and the To Currency Code and the Organization Code default from the organization code set for this session.   And if you choose Yes for "Include All WIP Jobs" all WIP jobs will be reported even if there are no valuation changes.  The To Currency columns are blank when no conversion rate exists for the date and type.

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
-- |      1.7 19 Sep 2026 Enginatics     Add production (resource) overhead cost adjustments,
-- |                                     correct the net value, percentage and FX columns.
-- |      1.8 28 Sep 2026 Enginatics     Report rows without a currency conversion rate.
-- |  1.10    23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Cost Type (New), Cost Type (Old), PII Cost Type (New), PII Cost Type (Old), PII Sub-Element, Currency Conversion Date (New), Currency Conversion Type (New), Currency Conversion Date (Old), Currency Conversion Type (Old), To Currency Code, Category Set 1, Category Set 2, Category Set 3, Include All WIP Jobs, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [cst_resource_costs](https://www.enginatics.com/library/?pg=1&find=cst_resource_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [wip_requirement_operations](https://www.enginatics.com/library/?pg=1&find=wip_requirement_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [wip_operation_resources](https://www.enginatics.com/library/?pg=1&find=wip_operation_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [wip_operations](https://www.enginatics.com/library/?pg=1&find=wip_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [cst_department_overheads](https://www.enginatics.com/library/?pg=1&find=cst_department_overheads&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [cst_resource_overheads](https://www.enginatics.com/library/?pg=1&find=cst_resource_overheads&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment)

## Related Reports
[CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report"), [CAC Calculate Average Item Costs](/CAC%20Calculate%20Average%20Item%20Costs/ "CAC Calculate Average Item Costs Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs](/CAC%20Calculate%20ICP%20PII%20Item%20Costs/ "CAC Calculate ICP PII Item Costs Oracle EBS SQL Report"), [CAC WIP Pending Cost Adjustment](/CAC%20WIP%20Pending%20Cost%20Adjustment/ "CAC WIP Pending Cost Adjustment Oracle EBS SQL Report"), [CAC PO Price vs. Costing Method Comparison](/CAC%20PO%20Price%20vs-%20Costing%20Method%20Comparison/ "CAC PO Price vs. Costing Method Comparison Oracle EBS SQL Report"), [CAC Open Purchase Orders](/CAC%20Open%20Purchase%20Orders/ "CAC Open Purchase Orders Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20ICP%20PII%20WIP%20Pending%20Cost%20Adjustment/CAC%20ICP%20PII%20WIP%20Pending%20Cost%20Adjustment.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC ICP PII WIP Pending Cost Adjustment 23-Jun-2022 155341.xlsx](https://www.enginatics.com/example/cac-icp-pii-wip-pending-cost-adjustment/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment) |
| Blitz Report™ XML Import | [CAC_ICP_PII_WIP_Pending_Cost_Adjustment.xml](https://www.enginatics.com/xml/cac-icp-pii-wip-pending-cost-adjustment/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment) |
| SQL Source | [CAC ICP PII WIP Pending Cost Adjustment.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20ICP%20PII%20WIP%20Pending%20Cost%20Adjustment/CAC%20ICP%20PII%20WIP%20Pending%20Cost%20Adjustment.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-icp-pii-wip-pending-cost-adjustment/](https://www.enginatics.com/reports/cac-icp-pii-wip-pending-cost-adjustment/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-wip-pending-cost-adjustment)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
