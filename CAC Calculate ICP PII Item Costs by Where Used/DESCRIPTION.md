# Case Study & Technical Analysis: CAC Calculate ICP PII Item Costs by Where Used

## Executive Summary
The **CAC Calculate ICP PII Item Costs by Where Used** report extends the functionality of the standard PII calculation by integrating it with the Bill of Materials (BOM) structure. It not only identifies the Intercompany Profit (ICP/PII) for specific items but also traces these items upwards to see which parent assemblies consume them. This is critical for understanding how intercompany profits roll up into finished goods and for validating the cost structure of complex manufactured products that rely on intercompany transfers.

## Business Challenge
While knowing the PII for a specific component is useful, organizations often need to know:
*   **Impact Analysis:** Which finished goods are affected by a change in the transfer price of a raw material or sub-assembly?
*   **Cost Rollup Validation:** Are the intercompany profits correctly propagating through the multi-level BOMs?
*   **Inventory Valuation:** How much PII is embedded in the on-hand inventory of finished goods, not just the components themselves?
*   **Sourcing Visibility:** Which specific assemblies are driving the demand for intercompany transfers?

## The Solution
This report provides a multi-dimensional view of PII:
*   **Component-Level PII:** Calculates the PII for the transferred item (Component) using the same robust logic as the base PII report (Sourcing Rules + Cost Comparison).
*   **Where-Used Traceability:** Links the component to its parent Assembly via the BOM, showing the quantity per assembly and yield.
*   **Contextual Data:** Displays on-hand quantities for the source component, giving a sense of the potential financial magnitude.
*   **Flexible Filtering:** Allows users to filter by specific components or assemblies to perform targeted investigations.

## Technical Architecture (High Level)
The report combines supply chain network logic with manufacturing data.
*   **Sourcing Engine:** Uses `MRP_SOURCING_RULES` and `MRP_ASSIGNMENT_SETS` to determine the "Source Org" and "To Org" relationship for the component.
*   **BOM Explosion:** Queries `BOM_STRUCTURES_B` and `BOM_COMPONENTS_B` to identify the parent-child relationships in the "To Org".
*   **Cost Calculation:**
    *   Retrieves the *Source Item Cost* (minus upstream PII).
    *   Converts it to the *To Org Currency* using `GL_DAILY_RATES`.
    *   Compares it against the *To Org Net Item Cost* to derive the *Calculated To Org PII*.
*   **Inventory Integration:** Joins with `MTL_ONHAND_QUANTITIES_DETAIL` to provide a snapshot of the component's availability in the source organization.

## Parameters & Filtering
The report offers granular control for detailed analysis:
*   **Assignment Set:** Defines the sourcing network to be analyzed.
*   **Cost Types:** Specifies the standard cost type (e.g., Frozen) and the PII cost type for comparison.
*   **BOM Filters:**
    *   *Component Number:* Focus on a specific raw material or sub-assembly.
    *   *Assembly Number:* Focus on a specific finished good.
    *   *Include Expense/Uncosted Items:* Toggles to include non-standard inventory items in the BOM structure.
    *   *Include Unimplemented ECOs:* Option to see future BOM changes.
*   **Organization Context:** From/To Organization, Operating Unit, and Ledger filters.

## Performance & Optimization
*   **Efficient Joins:** The query structure is optimized to handle the complex joins between MRP, BOM, and Costing tables.
*   **Selective Aggregation:** On-hand quantities are aggregated at the sub-query level to prevent row explosion before joining to the main dataset.
*   **Date Effectivity:** Respects the `EFFECTIVE_FROM` and `EFFECTIVE_TO` dates on BOM components to ensure only currently valid relationships are reported.

## FAQ
**Q: How is this different from the "CAC Calculate ICP PII Item Costs" report?**
A: The base report lists PII for items in a flat list. This report adds the "Where Used" dimension, showing you *which assemblies* consume those items. It's a "bottom-up" view of your product structure with PII data attached.

**Q: Why do I see "Quantity per Assembly"?**
A: This field allows you to calculate the total PII impact on one unit of the parent assembly (PII per unit * Quantity per Assembly).

**Q: Can I use this to find items with missing sourcing rules?**
A: Yes, if an item exists in a BOM but has no sourcing rule defined (and thus no calculated PII where expected), it can highlight gaps in your supply chain setup.

**Q: Does it handle phantom assemblies?**
A: The report logic respects the BOM structure. If phantom assemblies are part of the structure, their components would typically be blown through, but this report focuses on the direct parent-child link defined in the BOM tables.
