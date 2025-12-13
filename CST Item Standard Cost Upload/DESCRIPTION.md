# Executive Summary
The **CST Item Standard Cost Upload** is a specialized tool for managing Standard Costs in Oracle EBS. It extends the capabilities of the basic cost upload by adding features specifically designed for the standard costing lifecycle, such as the ability to trigger a "Cost Rollup" directly after upload. This ensures that when component costs are updated, the parent assembly costs are immediately recalculated to reflect the change.

# Business Challenge
*   **Cost Rollup Latency**: In standard processes, updating a raw material cost requires a separate, manual step to run the "Supply Chain Cost Rollup" to propagate that change to finished goods. Forgetting this step leads to undervalued inventory.
*   **Mass Updates**: Updating thousands of items for the new fiscal year is labor-intensive.
*   **Simulation**: Creating "What-If" cost scenarios requires a quick way to populate a simulation Cost Type.

# Solution
This tool provides a seamless "Download -> Update -> Upload -> Rollup" workflow.

**Key Features:**
*   **Integrated Rollup**: Can automatically submit the "Supply Chain Cost Rollup" concurrent request after the upload completes.
*   **Rollup Scope**: Can roll up only the specific items uploaded or all items in the organization.
*   **Update Modes**: Supports "Remove and Replace" or "Insert New".
*   **Source Copy**: Can download costs from a Source Cost Type (e.g., "Frozen") to populate a Target Cost Type (e.g., "Pending").

# Architecture
The tool populates the standard interface tables and then calls the Cost Rollup API.

**Key Tables:**
*   `CST_ITEM_COSTS_INTERFACE`: Interface for item costs.
*   `CST_ITEM_CST_DTLS_INTERFACE`: Interface for cost details.
*   `CST_COST_TYPES`: Cost types definition.

# Impact
*   **Data Integrity**: Ensures that finished good costs are always synchronized with their component costs via the immediate rollup.
*   **Process Efficiency**: Combines two distinct tasks (Data Entry + Rollup) into a single action.
*   **Strategic Planning**: Facilitates rapid iteration of cost scenarios for budgeting.
