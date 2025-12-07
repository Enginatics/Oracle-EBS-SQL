# Case Study & Technical Analysis: CAC Department Overhead Rates

## Executive Summary
The **CAC Department Overhead Rates** report is a configuration audit tool that displays the overhead rates assigned to manufacturing departments. In Oracle EBS Cost Management, overheads can be applied at the department level (based on resource usage) rather than just at the item level. This report provides a clear view of these rates, their basis (e.g., Resource Units, Resource Value), and the associated General Ledger absorption accounts, ensuring that indirect costs are being allocated correctly to Work in Process (WIP).

## Business Challenge
Setting up departmental overheads involves linking multiple entities: Departments, Resources (Overheads), Cost Types, and Rates. Common challenges include:
*   **Rate Visibility:** It is difficult to see all overhead rates across different departments and cost types in a single screen.
*   **Basis Verification:** Ensuring that the overhead is applied on the correct basis (e.g., $10 per hour vs. 150% of labor cost).
*   **Account Alignment:** Verifying that the absorption account defined on the Overhead resource matches the financial expectation for credit absorption.
*   **Multi-Org Management:** Comparing rates across different factories (Inventory Organizations) to ensure consistency or explain variances.

## The Solution
The report solves these challenges by:
*   **Unified View:** Joining `CST_DEPARTMENT_OVERHEADS` with Department and Resource definitions to show the complete picture in one row.
*   **Basis Decoding:** Translating the numeric `BASIS_TYPE` code into a user-friendly description (e.g., "Item", "Lot", "Resource value", "Resource units").
*   **GL Integration:** Displaying the full accounting flexfield for the absorption account, allowing for immediate validation against the Chart of Accounts.
*   **Cost Type Comparison:** Allowing users to run the report for different Cost Types (e.g., "Frozen" vs. "Pending") to analyze proposed rate changes.

## Technical Architecture (High Level)
The query is a straightforward join of the Costing and Manufacturing definition tables.
*   **Core Table:** `CST_DEPARTMENT_OVERHEADS` stores the intersection of Department, Overhead Resource, and Cost Type, along with the Rate.
*   **Key Joins:**
    *   `BOM_DEPARTMENTS`: For Department codes.
    *   `BOM_RESOURCES`: For Overhead names and Absorption Accounts.
    *   `CST_COST_TYPES`: For Cost Type names.
    *   `MFG_LOOKUPS`: To decode the `BASIS_TYPE` (Lookup Type `CST_BASIS_SHORT`).

## Parameters & Filtering
*   **Cost Type:** Filter by specific cost scenario (e.g., "Frozen", "FY2024 Standard").
*   **Organization Code:** Filter by specific factory/inventory org.
*   **Operating Unit/Ledger:** Standard multi-org filters.

## Performance & Optimization
*   **Direct Joins:** The query uses standard primary key joins, making it highly efficient.
*   **Security:** Implements standard Oracle MOAC (Multi-Org Access Control) and GL Security to restrict data visibility.

## FAQ
**Q: What is the difference between "Resource Units" and "Resource Value" basis?**
A: "Resource Units" means the overhead is applied as a fixed amount per hour (or unit) of the resource used (e.g., $50 overhead per 1 hour of Labor). "Resource Value" means it is applied as a percentage of the resource's cost (e.g., 150% of the Labor rate).

**Q: Why don't I see Item-based overheads here?**
A: This report focuses on *Departmental* overheads, which are driven by routing operations. Item-based overheads (Material Overhead) are typically defined on the Item Master or Category and are reported separately (e.g., "CAC Material Overhead Setup").

**Q: Can I see the history of rate changes?**
A: The report shows the `Last_Update_Date`, which indicates when the rate was last modified. However, it does not show a full audit trail of prior values; it shows the current state for the selected Cost Type.
