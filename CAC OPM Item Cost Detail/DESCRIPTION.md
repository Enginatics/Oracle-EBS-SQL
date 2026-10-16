# Case Study & Technical Analysis: CAC OPM Item Cost Detail

## Executive Summary
The CAC OPM Item Cost Detail report shows the costed value of each Oracle Process Manufacturing (OPM) item, broken out by cost component class and cost analysis code. It is organized by organization, item, cost calendar, period and cost method, so a cost accountant can see what makes up the cost of an item in a given period. Cost accountants and plant controllers use it to explain item cost movements, to check material, labor, burden and overhead rates and to compare costing methods. The report runs in Excel through Blitz Report, and its rows can be summed by component class in the workbook.

## Business Challenge
*   **Cost explanation:** A change in an item's OPM cost must be traced to the component class that caused it, which requires the cost detail rather than the total cost.
*   **Period analysis:** Items are costed for each period of a cost calendar, so the cost of the same item must be compared across periods.
*   **Method comparison:** An item can be costed under more than one cost method, and the results must be read side by side.
*   **Responsibility-based access:** Cost data must be restricted to the organizations the user is authorized to see.

## The Solution
*   Shows the costed value of each item, the component cost, for each cost component class such as material, labor, burden and overhead.
*   Adds the cost analysis code and the total quantity used in the cost calculation, so that the cost per unit can be checked.
*   Shows the item code and description from the item master, the organization code, the calendar and period code and the cost method and its description.
*   Excludes rows marked as deleted, so that only current cost detail is listed.

## Technical Architecture (High Level)
### Primary Tables
*   `CM_CMPT_DTL`: the cost component detail of each item, with the component cost, total quantity and cost analysis code.
*   `MTL_SYSTEM_ITEMS_VL`: the item, its concatenated segments and its description.
*   `CM_CMPT_MST_VL`: the cost component class names and codes.
*   `CM_MTHD_MST`: the cost method names and codes, linked to the cost type of each detail row.
*   `GMF_PERIOD_STATUSES`: the periods of each calendar, linked to the period of the cost detail.
*   `ORG_ORGANIZATION_DEFINITIONS`: the organization code.
*   `ORG_ACCESS_VIEW`: the organizations the responsibility can access.

### Logical Relationships
1.  `CM_CMPT_DTL` is joined to `MTL_SYSTEM_ITEMS_VL` on inventory item id and organization id, which gives the item for each cost row.
2.  `CM_CMPT_DTL` is joined to `CM_CMPT_MST_VL` on the cost component class id, and to `CM_MTHD_MST` on the cost type id.
3.  The period is an outer join to `GMF_PERIOD_STATUSES` on the period id, so cost rows without a period still appear.
4.  The organization is restricted by a subquery on `ORG_ACCESS_VIEW` using the application and responsibility of the current session, and the organization code comes from `ORG_ORGANIZATION_DEFINITIONS`.

## Parameters & Filtering
*   **Organization Code:** restricts the cost detail to one OPM organization.
*   **Item:** restricts the report to one item.
*   **Cost Calendar:** selects the cost calendar whose periods are reported.
*   **Cost Method:** selects one cost method.
*   **Cost Component Class:** selects one component class, such as material or overhead.

## Performance & Optimization
*   The organization access check is an IN subquery on `ORG_ACCESS_VIEW`, so it reads only the organizations granted to the responsibility.
*   The period join is an outer join on the period id, which keeps the period columns out of the driving path of the query.
*   Rows with a delete mark are excluded in the WHERE clause, which keeps deleted cost detail out of the result.
*   Filtering by Organization Code, Item and Cost Calendar is the most selective way to run the report, because the cost detail table is the largest in the query.

## FAQ
**Q: What makes up the cost of an OPM item in a period?**
A: Run the report for the item, calendar and period. Each row is one cost component class, such as material, labor, burden or overhead, with its component cost.

**Q: How do I compare the cost of an item under two cost methods?**
A: Run the report for the item once for each Cost Method, or leave Cost Method blank to list every method. Each row shows the cost method and its description.

**Q: Which cost analysis code is shown?**
A: The cost analysis code of each cost detail row, with the total quantity used in the cost calculation.
