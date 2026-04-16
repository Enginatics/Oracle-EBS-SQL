---
layout: default
title: 'CAC ICP PII WIP Material Usage Variance | Oracle EBS SQL Report'
description: 'For your open and closed WIP jobs use this report to calculate the amount of profit in inventory (PII) in WIP as well as the amount of PII in the WIP…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CAC, ICP, PII, WIP, wip_discrete_jobs, org_acct_periods, mtl_parameters'
permalink: /CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/
---

# CAC ICP PII WIP Material Usage Variance – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-icp-pii-wip-material-usage-variance/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
For your open and closed WIP jobs use this report to calculate the amount of profit in inventory (PII) in WIP as well as the amount of PII in the WIP variances for the month.

Report your material usage variances for your open and closed WIP jobs.  If the job is open the Report Type column displays "Valuation", as this WIP job and potential material usage variance is still in your WIP inventory balances.  If the job has been closed during the reporting period, the Report Type column displays "Variance", as this WIP job was written off on a WIP Job Close Variance transaction during the reporting period.  You can report prior periods and this report will automatically adjust the assembly completion quantities and component issue quantities to reflect what it was for the specified reported accounting period.  And by specifying the profit in inventory (PII) cost type you can determine how much PII or ICP (intercompany profit) was either remaining on your balance sheet or how much was recorded as part of your WIP job close variances.

Closed, Pending Close, Cancelled, Complete and Complete No Charges WIP job statuses use the completion quantities.  All other WIP jobs use the parameter "Use Completion Quantities". 

Rules:  If component issue quantity = zero, and the WIP job is open, there is no PII as the components are in onhand inventory.  But if the WIP job is closed, PII is calculated in order to correct the WIP variance.

Parameters:
===========
Report Option:  Open jobs, Closed jobs or All jobs.  Use this to limit the size of the report.  (mandatory)
Period Name:  the accounting period you wish to report.  (mandatory)
Cost Type:  defaults to your Costing Method; if the cost type is missing component costs the report will find any missing item costs from your Costing Method cost type.
PII Cost Type:  the profit in inventory cost type you wish to report
PII Sub-Element:  the sub-element or resource for profit in inventory, such as PII or ICP (optional)
Include Scrap Quantities:  for calculating your completion quantities and component quantity requirements, include or exclude any scrapped assembly quantities.  (mandatory)
Include Unreleased Jobs:  include jobs which have not been released and are not started.  (mandatory)
Include Bulk Supply Items:  include Bulk items to match the results from the Oracle Discrete Job Value Report; exclude knowing that Bulk items are usually not issued to the WIP job.  (mandatory)
Use Completion Qtys:  for jobs in a released status, use the completion quantities for the material usage and configuration variance calculations.  Useful if you backflush your materials based on your completion quantities.  Complete, Complete - No Charges, Cancelled, Closed, Pending Close or Failed Close alway use the completion quantities for the variance calculations.  (mandatory)
Category Set 1:  any item category you wish (optional).
Category Set 2:  any item category you wish (optional).
Organization Code:  any inventory organization, defaults to your session's inventory organization (optional).
Class Code:  specific type of WIP class to report (optional).
Job Status:  specific WIP job status (optional).
WIP Job:  specific WIP job (optional).
Assembly Number:  specific assembly number you wish to report (optional)
Component Number:   specific component item you wish to report (optional)
Operating Unit:  specific operating unit (optional)
Ledger:  specific ledger (optional)

/* +=============================================================================+
-- |  Copyright 2009 - 2022 Douglas Volz Consulting, Inc. 
-- |  All rights reserved. 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== =============== =========================================
-- |  1.26     20 Mar 2022 Douglas Volz   Adjust PII, if the wip job is closed, even if there are no issued quantities, still calculate PII in order to correct the job close WIP variance.





## Report Parameters
Report Option, Period Name, Cost Type, PII Cost Type, PII Sub-Element, Include Scrap Quantities, Include Unreleased Jobs, Include Bulk Supply Items, Use Completion Quantities, Category Set 1, Category Set 2, Category Set 3, Organization Code, Class Code, Job Status, WIP Job, Component Number, Assembly Number, Operating Unit, Ledger

## Oracle EBS Tables Used
[wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [wdj0](https://www.enginatics.com/library/?pg=1&find=wdj0), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [wdj](https://www.enginatics.com/library/?pg=1&find=wdj), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [wdj_assys](https://www.enginatics.com/library/?pg=1&find=wdj_assys), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC ICP PII WIP Material Usage Variance 23-Jun-2022 155150.xlsx](https://www.enginatics.com/example/cac-icp-pii-wip-material-usage-variance/) |
| Blitz Report™ XML Import | [CAC_ICP_PII_WIP_Material_Usage_Variance.xml](https://www.enginatics.com/xml/cac-icp-pii-wip-material-usage-variance/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-icp-pii-wip-material-usage-variance/](https://www.enginatics.com/reports/cac-icp-pii-wip-material-usage-variance/) |

## Case Study & Technical Analysis: CAC ICP PII WIP Material Usage Variance

### Executive Summary
The **CAC ICP PII WIP Material Usage Variance** report is a specialized forensic tool for manufacturing organizations that need to track **Profit in Inventory (PII)** within their Work in Process (WIP). It serves a dual purpose:
1.  **Valuation:** For open jobs, it calculates the PII embedded in the current WIP balance.
2.  **Variance Analysis:** For closed jobs, it calculates how much PII was written off to the P&L as part of the WIP Job Close Variance.
This report is critical for ensuring that intercompany profit is not accidentally expensed or lost when manufacturing variances occur.

### Business Challenge
Standard WIP variance reports focus on the *total* cost. However, for multinational companies, a portion of that cost is actually intercompany profit.
*   **The "Phantom Loss" Problem:** If a job has a negative usage variance (used more material than standard), the system writes off the extra cost. If that material had PII, the PII is also written off. Finance needs to know this to adjust the consolidated elimination entries.
*   **WIP Valuation:** At month-end, the "WIP Inventory" account on the balance sheet includes PII. To eliminate it correctly, Finance needs a report showing exactly how much PII is sitting in open jobs.
*   **Component Logic:** PII only exists on the *components* issued to the job, not the labor or overhead. Tracking this through the complexity of WIP (issues, returns, scrap, completions) is mathematically difficult.

### The Solution
This report reconstructs the WIP material history to isolate the PII component.
*   **Dual Reporting Mode:**
    *   **Valuation (Open Jobs):** Shows the PII currently residing in WIP.
    *   **Variance (Closed Jobs):** Shows the PII portion of the final variance calculation.
*   **Component-Level Precision:** It calculates variances at the component level (Standard Qty vs. Actual Qty) and applies the PII unit cost to that difference.
*   **As-Of Date Logic:** The report can roll back to prior periods, adjusting assembly completions and component issues to reflect the state of the job at that specific month-end.

### Technical Architecture (High Level)
The query is a complex assembly of Common Table Expressions (CTEs) that mimic the Oracle WIP variance calculation engine.
*   **`wdj0` (Job Definition):** Defines the universe of jobs (Open vs. Closed) based on the `Period Name` parameter.
*   **`wdj_assys` (Assembly Quantities):** Calculates the "As-Of" completion and scrap quantities by summing `MTL_MATERIAL_TRANSACTIONS` up to the period end date.
*   **`wdj` (Component Requirements):** Explodes the Bill of Materials (BOM) to determine what *should* have been issued (Standard Quantity).
*   **Main Query:** Joins the requirements with actual issues and the PII cost details (`CST_ITEM_COST_DETAILS`) to calculate:
    *   `Usage Variance = (Standard Qty - Actual Qty) * Standard Cost`
    *   `PII Variance = (Standard Qty - Actual Qty) * PII Unit Cost`

### Parameters & Filtering
*   **Report Option:** Toggle between "Open Jobs" (Valuation), "Closed Jobs" (Variance), or "All".
*   **Use Completion Qtys:** A critical flag. If "Yes", it calculates standard requirements based on what was actually completed (Backflush logic). If "No", it uses the job start quantity (Discrete logic).
*   **Include Scrap:** Determines if scrapped assemblies should credit the material requirements.
*   **PII Cost Type:** The specific cost bucket holding the profit value.

### Performance & Optimization
*   **Transaction Rollback:** The logic to calculate "As-Of" quantities is performance-intensive as it sums transaction history. It is optimized by filtering `MTL_MATERIAL_TRANSACTIONS` early in the CTEs.
*   **Indexed Joins:** The query relies heavily on `WIP_ENTITY_ID` and `INVENTORY_ITEM_ID` to join the massive transaction tables with the cost definitions.

### FAQ
**Q: Why does the report show "Valuation" for a job that is now closed?**
A: If you run the report for a prior period (e.g., January) and the job closed in February, the report correctly identifies that *in January*, the job was Open and therefore represents a Valuation balance, not a Variance write-off.

**Q: How does it handle "PII Zero Component Quantity"?**
A: If a job is Open and no components have been issued yet, the report correctly shows 0 PII, because the profit is still sitting in Raw Materials inventory, not WIP.

**Q: Does this report match the General Ledger?**
A: The "Variance" section should match the PII portion of the WIP Job Close Variance account in the GL. The "Valuation" section supports the WIP Inventory balance.


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
