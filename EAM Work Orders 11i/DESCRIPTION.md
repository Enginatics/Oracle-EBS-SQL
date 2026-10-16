# Case Study & Technical Analysis: EAM Work Orders 11i

## Executive Summary
The EAM Work Orders 11i report lists Enterprise Asset Management work orders with the asset they maintain, the asset group and category, the owning department, the project and task, and the actual, estimated and variance costs of each job. Maintenance managers, planners and asset accountants use it to review planned and unplanned maintenance, to compare each work order with its estimate, and to see the cumulative cost of an asset across accounting periods. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Maintenance backlog visibility:** Planners need one list of open and completed work orders per organization, with scheduled dates, priority and status.
*   **Asset cost control:** Maintenance cost must be tracked per asset and per work order, split into material, labor and equipment, and compared with the estimate.
*   **Preventive maintenance follow-up:** Work orders generated from PM schedules must be traceable to the schedule that created them.
*   **Period cost reporting:** Accounting needs cost totals restricted to the open accounting periods of the organization.

## The Solution
*   **Work order header:** Work orders are taken from discrete jobs for maintenance entities, with name, type, activity, cause, source, priority and shutdown type.
*   **Asset identification:** The asset serial number, asset group item, category and EAM location are attached through the maintenance object.
*   **Cost summaries:** Actual and estimated costs are summed from period balances, and cost detail is summed by material, labor and equipment through analytic functions.
*   **Status and action code:** The work order status is translated, and an action code of Complete or Uncomplete is derived from the status type.

## Technical Architecture (High Level)
### Primary Tables
*   `WIP_DISCRETE_JOBS` and `WIP_ENTITIES`: the maintenance work orders and their names, entity type and organization.
*   `WIP_EAM_PERIOD_BALANCES`: the actual and estimated cost balances of each work order by accounting period.
*   `WIP_EAM_COST_DETAILS_V`: the cost detail view supplying material, labor and equipment costs.
*   `MTL_SYSTEM_ITEMS_B_KFV`: the asset group item, also used for the activity name.
*   `MTL_SERIAL_NUMBERS` and `MTL_EAM_LOCATIONS`: the asset number and its location.
*   `MTL_CATEGORIES_B_KFV`: the item category of the asset.
*   `BOM_DEPARTMENTS`: the owning department.
*   `PA_PROJECTS_ALL` and `PA_TASKS`: the project and task charged by the work order.
*   `EAM_PM_SCHEDULINGS`: the preventive maintenance schedule that created the work order.
*   `ORG_ACCT_PERIODS` and `GL_PERIODS`: the accounting periods used to restrict the cost balances.

### Logical Relationships
1.  The inner query selects discrete jobs for maintenance entities, restricted to organizations in `ORG_ACCESS_VIEW`.
2.  The job joins to `MTL_SYSTEM_ITEMS_B_KFV` on the asset group or rebuild item, and to `MTL_SERIAL_NUMBERS` through the maintenance object ID.
3.  The serial number joins to `MTL_EAM_LOCATIONS` and to `MTL_CATEGORIES_B_KFV`.
4.  Period balances are grouped by organization and work order, using the open organization periods and non-adjustment GL periods.
5.  Cost detail is aggregated per work order with analytic sums, and joined on organization and work order ID.

## Parameters & Filtering
*   **Organization Code:** selects the maintenance organization.
*   **Department** and **Asset Group:** limit the work orders to the owning department and asset group.
*   **Asset Number:** limits the output to one asset serial number.
*   **Scheduled Start Date From** and **To:** bound the scheduled start date.
*   **Work Order Creation Date From** and **To:** bound the creation date.
*   **Cost Period from Date** and **Cost Period to Date:** define the accounting periods whose costs are summed.

## Performance & Optimization
*   Work orders are filtered before the joins by excluding certain status types and by maintenance entity type, which reduces the rows that reach the cost subqueries.
*   Period balances are pre-aggregated by organization and work order in an inline view, so each work order contributes one row to the cost join.
*   Cost detail is computed with analytic `SUM` over partitions by organization and work order, avoiding a separate aggregate per column.
*   The activity name lookup uses a `ROWNUM` limit on the item table.

## FAQ
**Q: How do I compare actual and estimated maintenance cost for each work order?**
A: Use the actual, estimated and variance cost columns, which show the material, labor and equipment components and the cumulative totals by work order.

**Q: How can I filter the work orders to one asset?**
A: Enter the asset number in the Asset Number parameter, and optionally restrict the asset group or department.

**Q: Which accounting periods are used for the cost figures?**
A: The periods between Cost Period from Date and Cost Period to Date are used, drawing on organization accounting periods and non-adjustment GL periods in that range.
