# Case Study & Technical Analysis: CAC Where Used by Cost Type

## Executive Summary
The **CAC Where Used by Cost Type** report is a "Costed Bill of Materials" tool. It performs a single-level explosion of the BOM, displaying the parent Assembly and the child Component, along with their respective costs. It is essential for analyzing cost drivers and the impact of component price changes.

## Business Challenge
*   **Impact Analysis**: "The price of Copper just went up 20%. Which products use Copper, and how much does it contribute to their total cost?"
*   **Make vs. Buy**: Comparing the cost of the component (if bought) to the value it adds to the assembly.
*   **Zero Cost Audit**: Finding components with Zero Cost that are being used in active assemblies (which causes under-costing).

## Solution
This report links BOMs to Costs.
*   **Structure**: `Assembly` -> `Component`.
*   **Quantities**: Component Quantity per Assembly.
*   **Costs**: Shows the Unit Cost of the Component and the Unit Cost of the Assembly.
*   **Extended Value**: `Component Qty * Component Cost` = Contribution to Assembly.

## Technical Architecture
*   **Tables**: `bom_structures_b`, `bom_components_b`, `cst_item_costs`.
*   **Logic**: Single-level join (not a recursive explosion).

## Parameters
*   **Cost Type**: (Mandatory) The cost type to report.
*   **Component Number**: (Optional) "Show me all assemblies using this component."

## Performance
*   **Fast**: Single-level joins are much faster than recursive BOM explosions.

## FAQ
**Q: Does it show Phantom items?**
A: Yes, it shows the immediate component. If the component is a Phantom, it is listed. To see the *ingredients* of the Phantom, you would need a multi-level report.
