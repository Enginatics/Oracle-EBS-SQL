# Case Study & Technical Analysis: CAC Resources by Department Setup

## Executive Summary
The **CAC Resources by Department Setup** report validates the manufacturing topology. It shows which Resources are available in which Departments. This setup controls both Scheduling (Capacity Planning) and Costing (Departmental Rates).

## Business Challenge
*   **Routing Errors**: You cannot add a Resource to a Routing Operation if that Resource is not assigned to the Department.
*   **Capacity Planning**: "Do we have enough 'Welding' capacity in the 'Fabrication' department?"
*   **Costing**: Some overheads are Department-specific. This setup links the resource to the department context.

## Solution
This report lists the assignments.
*   **Hierarchy**: `Department` -> `Resource`.
*   **Capacity**: Shows "Capacity Units" (e.g., 2 machines) and "Available 24 Hours" flags.
*   **Costing**: Shows the resource rate (for convenience).

## Technical Architecture
*   **Tables**: `bom_departments`, `bom_department_resources`, `bom_resources`.
*   **Logic**: Standard join of the BOM setup tables.

## Parameters
*   **Organization Code**: (Optional) Filter by plant.

## Performance
*   **Fast**: Master data.

## FAQ
**Q: Can a resource be in multiple departments?**
A: Yes, "General Labor" might be assigned to every department. "Specialized CNC" might be in only one.
