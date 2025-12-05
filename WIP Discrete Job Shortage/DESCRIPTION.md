# Case Study: Proactive Material Shortage Management

## Executive Summary
The **WIP Discrete Job Shortage** report is a critical production planning tool designed to prevent manufacturing delays caused by material unavailability. By comparing the component requirements of open Discrete Jobs against current on-hand inventory, this report identifies shortages *before* they impact the shop floor. It supports multiple logic modes—including Net Quantity On-Hand (QOH) and Total QOH—to provide a realistic and actionable view of material readiness.

## Business Challenge
In manufacturing, material shortages are a primary cause of missed delivery dates and idle production lines.
*   **Reactive Planning:** Planners often discover shortages only when the shop floor attempts to issue material, leading to immediate stoppages.
*   **Inventory Visibility:** Standard reports may show "total" inventory but fail to account for "non-nettable" subinventories (e.g., quarantine, defective) or material already reserved for other jobs.
*   **Complex Supply Logic:** Determining availability requires checking not just the total stock, but stock in specific supply subinventories or locators defined on the Bill of Materials (BOM).
*   **Pegging Visibility:** Understanding which supply orders (POs, Work Orders) are pegged to a specific requirement is difficult without navigating complex MRP screens.

## The Solution
This report provides a sophisticated shortage analysis engine directly within a reporting format.
*   **Predictive Analysis:** Calculates "Open Requirements" vs. "Onhand Supply" to highlight deficits immediately.
*   **Flexible Availability Logic:**
    *   **Net QOH:** Considers only nettable subinventories.
    *   **Total QOH:** Considers all on-hand inventory.
    *   **Supply Sub/Loc:** Checks availability strictly within the specific subinventory/locator assigned to the component.
*   **Pegging Integration:** Optionally displays supply pegged by the MRP plan, allowing planners to see if a PO is already inbound to cover the shortage.
*   **Cumulative Shortage:** Displays cumulative shortage by date, helping to prioritize which jobs to reschedule.

## Technical Architecture
The report logic is built upon the complex relationships between Work in Process and Inventory.
*   **Demand Source:** `WIP_DISCRETE_JOBS` and `WIP_REQUIREMENT_OPERATIONS` define the demand (what is needed and when).
*   **Supply Source:** `MTL_ONHAND_QUANTITIES_DETAIL` (or related views like `MTL_ITEM_QUANTITIES_VIEW`) provides the current stock position.
*   **Item Definition:** `MTL_SYSTEM_ITEMS_B` defines item attributes like "Nettable" status and default supply locators.
*   **MRP Integration:** Joins with `MRP_GROSS_REQUIREMENTS` and `MRP_FULL_PEGGING` when the pegging option is enabled.

## Parameters & Filtering
*   **Scope:** Organization Code, Job Name (From/To), Assembly, Component.
*   **Report Mode:** Open Requirements, Shortage based on Net QOH, Shortage based on QOH, Shortage based on Supply Sub/Loc.
*   **Dates:** Date Required (From/To), Requirement End Date.
*   **Responsibility:** Planner, Buyer, Department.
*   **Inclusions:** Include Bulk Items, Include Supplier Items, Exclude Subinventory.

## Performance & Optimization
*   **On-Hand Calculation:** Calculating on-hand quantity on the fly can be resource-intensive. The report uses optimized views, but running for a specific "Schedule Group" or "Department" is recommended for large organizations.
*   **MRP Data:** The "Display Pegged Supply" option requires joining to large MRP tables. Use this option only when necessary, as it significantly increases query complexity and runtime.

## FAQ
**Q: What is the difference between "Net QOH" and "Total QOH"?**
A: "Net QOH" excludes subinventories that are flagged as non-nettable (e.g., MRB, Scrap). "Total QOH" includes all inventory regardless of status.

**Q: Does this report show shortages for Phantom assemblies?**
A: Phantom assemblies are typically blown through to their components. This report focuses on the components required by the Discrete Job itself.

**Q: Can I see which specific job is causing the shortage?**
A: Yes, the report lists the specific Job and Operation where the component is required.
