# Case Study & Technical Analysis: ENG Engineering Change Orders

## Executive Summary
This report lists engineering change orders (ECOs) with one row per revised item, showing the change header, its type, status and approval state, and for each revised item its new revision, effectivity dates, use-up item and material disposition. Change coordinators, item engineers and planners use it to see which changes are pending, approved or implemented, and their effect on items. It runs in Excel through Blitz Report™, and optionally shows component changes and the open discrete jobs that build each revised item.

## Business Challenge
*   **Change visibility:** Engineering changes move through approval and implementation across many items, and the status of each revised item must be visible in one list.
*   **Effectivity planning:** Manufacturing needs the early and scheduled effectivity dates of each revised item to plan the cut-in of new revisions.
*   **Impact on open work:** An ECO that changes an item affects the unreleased, released and on-hold jobs building that item, which planners must identify before the change takes effect.
*   **Cost tracking:** Estimated costs should be reported once per change, not once per revised item.

## The Solution
*   Lists each ECO with its change type, status, approval status, priority, reason, requestor, assignee and responsible organization.
*   Shows each revised item with its new item revision, routing revision, early and scheduled effectivity dates, implementation and cancellation dates, use-up item and disposition.
*   Adds one row per component when Show Component Changes is requested, with the old quantity and old operation sequence of the component the change replaces.
*   Counts the open jobs for each revised item in the ECO's organization, and lists the first 15 of them by scheduled start date.

## Technical Architecture (High Level)
### Primary Tables
*   `ENG_ENGINEERING_CHANGES`: the change order header, including change notice, status, approval dates, cost estimates and requestor.
*   `ENG_CHANGE_ORDER_TYPES_VL`: the change order types, restricted to those based on the Change Order change category.
*   `ENG_REVISED_ITEMS`: the items revised by each change, with new revisions, effectivity, implementation and disposition.
*   `MTL_SYSTEM_ITEMS_VL`: the revised item and the use-up item, with their item numbers and descriptions.
*   `BOM_STRUCTURES_B`: the alternate bill of material designator of a revised item.
*   `WIP_DISCRETE_JOBS` and `WIP_ENTITIES`: the discrete jobs building each revised item, with their job names and status types.
*   `HZ_PARTIES` and `HR_ALL_ORGANIZATION_UNITS_VL`: requestor, assignee and responsible organization names.
*   `MTL_PARAMETERS` and `ORG_ACCESS_VIEW`: the organization code and the organizations the responsibility can access.

### Logical Relationships
1.  Each ECO is joined to its change order type, and only types based on the CHANGE_ORDER change category are kept.
2.  ECOs are outer-joined to their revised items on change notice and organization, so an ECO with no revised items is listed once with blank item columns.
3.  Each revised item is joined to its item master record in `MTL_SYSTEM_ITEMS_VL`, and the open job summary is joined on organization and item.
4.  The open job summary is built from discrete jobs with status types 1, 3 and 6, which are the unreleased, released and on-hold statuses.
5.  Component changes, when requested, add extra joins and rows within each revised item.
6.  Results are ordered by organization code, change notice, revised item and revised item sequence.

## Parameters & Filtering
*   **Organization Code**, **ECO** and **Change Type:** narrow the changes to one organization, one change notice or one change order type.
*   **ECO Status**, **Approval Status** and **Open Only:** filter on the state of the change.
*   **Revised Item:** limits the output to ECOs that revise a given item.
*   **Effectivity Date From** and **Effectivity Date To:** select revised items by effectivity date.
*   **Show Component Changes** and **Show DFF Attributes:** add the component rows and the descriptive flexfield columns to the output.

## Performance & Optimization
*   The open job summary is an inline view grouped by organization and item, restricted to the revised items in scope.
*   The open job list is built with an aggregate string function that keeps only the first 15 jobs by scheduled start date, which bounds the length of the column.
*   Estimated costs use a row-numbering window function, so they appear once per change.
*   The organization access view limits the organizations to those of the current responsibility.

## FAQ
**Q: Why are the estimated costs shown on only one row for each ECO?**
A: The report numbers each change's rows and returns the estimated engineering and manufacturing cost only on the first row, so the costs can be summed without counting them once per revised item.

**Q: How are open jobs counted for a revised item?**
A: Open Jobs counts the discrete jobs in the ECO's organization that build the revised item and are unreleased, released or on hold, whatever the status of the ECO.

**Q: Which change types does the report include?**
A: It includes only change order types based on the Change Order change category, as shown on the Engineering Change Orders form.
