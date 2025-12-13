# Case Study & Technical Analysis: CAC Item Cost Break-Out by Activity

## Executive Summary
The **CAC Item Cost Break-Out by Activity** report is an Activity-Based Costing (ABC) analysis tool. It moves beyond the traditional "Material/Labor/Overhead" view and breaks down costs by the specific business activities defined in the system (e.g., "Setup", "Quality Control", "Machining", "Plating"). This perspective is vital for organizations trying to understand the true process costs of their products.

## Business Challenge
Traditional cost elements often hide the true drivers of expense.
*   **Hidden Costs**: A "Labor" cost of $10 could be $1 of actual assembly and $9 of machine setup. Without activity visibility, management might try to cut assembly time instead of optimizing setup.
*   **Process Improvement**: Lean manufacturing initiatives require data on which activities consume the most resources.
*   **Pricing Strategy**: Accurate pricing depends on knowing the cost of the specific activities required to produce a custom order.

## Solution
This report leverages the "Activity" field in Oracle Costing.
*   **Activity Columns**: Allows the user to specify up to 5 specific activities (e.g., 'SETUP', 'TEST') to break out into dedicated columns.
*   **Granularity**: Shows the cost contribution of each activity to the total unit cost.
*   **Flexibility**: Can be run for any Cost Type (Standard, Frozen, etc.).

## Technical Architecture
The report relies on the `activity_id` stored in `cst_item_cost_details`:
*   **Mapping**: Joins to `cst_activities` to resolve the activity names.
*   **Pivot Logic**: Uses SQL logic to sum the costs for the user-specified activities into distinct columns for easy analysis.
*   **Prerequisite**: Requires that the organization has actually defined Activities and assigned them to Resources or Overheads in the setup.

## Parameters
*   **Activity 1-5**: (Optional) The specific activity codes you want to isolate.
*   **Cost Type**: (Mandatory) The cost type to analyze.
*   **Item Number**: (Optional) Specific item focus.

## Performance
*   **Aggregation**: The report aggregates detailed cost rows by activity, which is generally efficient.
*   **Configuration**: If no activities are entered, it simply reports the total cost, behaving like a standard cost report.

## FAQ
**Q: What if I don't use Activities?**
A: Then this report will likely show zeros in the activity columns. It is only useful if you have implemented Activity-Based Costing features in Oracle.

**Q: Can I see more than 5 activities?**
A: The standard template supports 5. To see more, you would need to modify the SQL or run the report multiple times with different parameters.

**Q: Does this work for OPM?**
A: This specific report is designed for Discrete Costing (Standard/Average). OPM has its own Activity Costing structure.
