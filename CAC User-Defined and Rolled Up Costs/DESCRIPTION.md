# Case Study & Technical Analysis: CAC User-Defined and Rolled Up Costs

## Executive Summary
The **CAC User-Defined and Rolled Up Costs** report is a data integrity tool for Standard Costing. It identifies items that have conflicting cost definitions: a manually entered ("User Defined") cost *and* a system-calculated ("Rolled Up") cost. This often indicates a setup error that leads to incorrect costing.

## Business Challenge
*   **Double Counting**: If you manually enter a $10 Material Cost for an assembly, and *also* roll up the $10 cost from its components, the system might value it at $20 (or ignore the rollup).
*   **Maintenance**: "Why isn't the cost updating when I change the component price?" (Answer: The "Based on Rollup" flag is off, or a user-defined cost is overriding it).
*   **Clean Up**: Identifying items that should be switched to "Based on Rollup".

## Solution
This report finds the intersection.
*   **Condition**: Items where `rollup_source_type = 'USER DEFINED'` AND `rollup_source_type = 'ROLLED UP'` (conceptually) exist for different cost elements or levels.
*   **Details**: Shows the specific cost elements (Material, Labor, etc.) and their source.
*   **Sourcing**: Checks if the item is "Buy" or "Make" (based on Sourcing Rules) to suggest the correct setup.

## Technical Architecture
*   **Tables**: `cst_item_costs`, `cst_item_cost_details`.
*   **Logic**: Analyzes the `rollup_source_type` column in the cost details table.

## Parameters
*   **Cost Type**: (Mandatory) The cost type to validate.

## Performance
*   **Moderate**: Scans the cost details table.

## FAQ
**Q: Is it ever valid to have both?**
A: Yes, for "Value Add". You might roll up the Material cost from components but manually enter a "Material Overhead" or "Labor" cost at the assembly level.
