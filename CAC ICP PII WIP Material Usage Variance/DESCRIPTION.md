# Case Study & Technical Analysis: CAC ICP PII WIP Material Usage Variance

## Executive Summary
The **CAC ICP PII WIP Material Usage Variance** report is a specialized forensic tool for manufacturing organizations that need to track **Profit in Inventory (PII)** within their Work in Process (WIP). It serves a dual purpose:
1.  **Valuation:** For open jobs, it calculates the PII embedded in the current WIP balance.
2.  **Variance Analysis:** For closed jobs, it calculates how much PII was written off to the P&L as part of the WIP Job Close Variance.
This report is critical for ensuring that intercompany profit is not accidentally expensed or lost when manufacturing variances occur.

## Business Challenge
Standard WIP variance reports focus on the *total* cost. However, for multinational companies, a portion of that cost is actually intercompany profit.
*   **The "Phantom Loss" Problem:** If a job has a negative usage variance (used more material than standard), the system writes off the extra cost. If that material had PII, the PII is also written off. Finance needs to know this to adjust the consolidated elimination entries.
*   **WIP Valuation:** At month-end, the "WIP Inventory" account on the balance sheet includes PII. To eliminate it correctly, Finance needs a report showing exactly how much PII is sitting in open jobs.
*   **Component Logic:** PII only exists on the *components* issued to the job, not the labor or overhead. Tracking this through the complexity of WIP (issues, returns, scrap, completions) is mathematically difficult.

## The Solution
This report reconstructs the WIP material history to isolate the PII component.
*   **Dual Reporting Mode:**
    *   **Valuation (Open Jobs):** Shows the PII currently residing in WIP.
    *   **Variance (Closed Jobs):** Shows the PII portion of the final variance calculation.
*   **Component-Level Precision:** It calculates variances at the component level (Standard Qty vs. Actual Qty) and applies the PII unit cost to that difference.
*   **As-Of Date Logic:** The report can roll back to prior periods, adjusting assembly completions and component issues to reflect the state of the job at that specific month-end.

## Technical Architecture (High Level)
The query is a complex assembly of Common Table Expressions (CTEs) that mimic the Oracle WIP variance calculation engine.
*   **`wdj0` (Job Definition):** Defines the universe of jobs (Open vs. Closed) based on the `Period Name` parameter.
*   **`wdj_assys` (Assembly Quantities):** Calculates the "As-Of" completion and scrap quantities by summing `MTL_MATERIAL_TRANSACTIONS` up to the period end date.
*   **`wdj` (Component Requirements):** Explodes the Bill of Materials (BOM) to determine what *should* have been issued (Standard Quantity).
*   **Main Query:** Joins the requirements with actual issues and the PII cost details (`CST_ITEM_COST_DETAILS`) to calculate:
    *   `Usage Variance = (Standard Qty - Actual Qty) * Standard Cost`
    *   `PII Variance = (Standard Qty - Actual Qty) * PII Unit Cost`

## Parameters & Filtering
*   **Report Option:** Toggle between "Open Jobs" (Valuation), "Closed Jobs" (Variance), or "All".
*   **Use Completion Qtys:** A critical flag. If "Yes", it calculates standard requirements based on what was actually completed (Backflush logic). If "No", it uses the job start quantity (Discrete logic).
*   **Include Scrap:** Determines if scrapped assemblies should credit the material requirements.
*   **PII Cost Type:** The specific cost bucket holding the profit value.

## Performance & Optimization
*   **Transaction Rollback:** The logic to calculate "As-Of" quantities is performance-intensive as it sums transaction history. It is optimized by filtering `MTL_MATERIAL_TRANSACTIONS` early in the CTEs.
*   **Indexed Joins:** The query relies heavily on `WIP_ENTITY_ID` and `INVENTORY_ITEM_ID` to join the massive transaction tables with the cost definitions.

## FAQ
**Q: Why does the report show "Valuation" for a job that is now closed?**
A: If you run the report for a prior period (e.g., January) and the job closed in February, the report correctly identifies that *in January*, the job was Open and therefore represents a Valuation balance, not a Variance write-off.

**Q: How does it handle "PII Zero Component Quantity"?**
A: If a job is Open and no components have been issued yet, the report correctly shows 0 PII, because the profit is still sitting in Raw Materials inventory, not WIP.

**Q: Does this report match the General Ledger?**
A: The "Variance" section should match the PII portion of the WIP Job Close Variance account in the GL. The "Valuation" section supports the WIP Inventory balance.
