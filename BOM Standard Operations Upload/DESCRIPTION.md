# Case Study & Technical Analysis: BOM Standard Operations Upload

## Executive Summary
This upload creates and updates Oracle Bills of Material standard operations, the reusable operation templates that routings reference. It covers the operation header, its primary resource assignments and substitute resources, and the descriptive flexfield values on the header and primary resources. Manufacturing engineers and process engineers use it to maintain operation libraries across many organizations, especially when a new production line or a shop floor management set-up needs many operations at once. The template runs in Excel through Blitz Report.

## Business Challenge
*   **Large operation libraries:** Standard operations are maintained one at a time in the Standard Operations form, which slows down the setup of a new plant or line.
*   **Type-dependent rules:** Discrete, flow event, flow process and flow line operations accept different columns, and an error in one of them blocks the whole routing.
*   **Resource consistency:** Each operation needs its primary and substitute resources, departments and activities to agree with the resource setup.
*   **Safe deletion:** Operations referenced by a routing or a setup transition cannot be removed without first checking those references.

## The Solution
*   **One row per resource:** The header columns repeat across the resource rows of one standard operation, and an operation with no resource is uploaded by leaving Resource Code blank.
*   **Type-specific templates:** Five templates cover the four operation types and the shop floor management variant, and each shows only the columns that apply to its type.
*   **Substitute resources:** Setting Substitute Resource to Yes with a Substitute Group and Replacement Group records an alternate resource.
*   **Two-level deletion:** Delete Std Op removes the operation with its resources, substitutes and shop floor management child rows, provided no active routing operation or setup transition uses it. Delete Resource removes a single resource.
*   **Contextual download:** Contains Resource returns each matching operation with all of its resource and substitute rows, so each resource appears within its whole operation.

## Technical Architecture (High Level)
### Primary Tables
*   `BOM_STANDARD_OPERATIONS`: the operation header, including type, line, department, yield, count point, auto-charge and backflush settings.
*   `BOM_STD_OP_RESOURCES`: the primary resource assignments of a standard operation.
*   `BOM_STD_SUB_OP_RESOURCES`: the substitute resource assignments and their substitute and replacement groups.
*   `BOM_RESOURCES`: the resource code and description for each assignment.
*   `BOM_DEPARTMENTS`: the department that owns the operation.
*   `WIP_LINES`: the production line for flow operations.
*   `CST_ACTIVITIES_VAL_V`: the activity attached to a resource assignment.
*   `MTL_PARAMETERS` and `MTL_ITEM_LOCATIONS_KFV`: the organization and the default locator.

### Logical Relationships
1. `MTL_PARAMETERS` is matched to `BOM_STANDARD_OPERATIONS` on organization id, and the organization code is the download filter.
2. `BOM_STANDARD_OPERATIONS` joins to `BOM_DEPARTMENTS` on department id and to `WIP_LINES` on line id as an outer join, since discrete operations have no line.
3. `BOM_STANDARD_OPERATIONS` joins to `BOM_STD_SUB_OP_RESOURCES` on the standard operation id, which carries the resource and substitute group assignments.
4. Each assignment joins to `BOM_RESOURCES` on resource id and to `CST_ACTIVITIES_VAL_V` on activity id, as an outer join for resources with no activity.
5. The default locator is resolved from the locator id to `MTL_ITEM_LOCATIONS_KFV` within the same organization.

## Parameters & Filtering
*   **Upload Mode:** selects Create or Create, Update for the download.
*   **Organization Code:** sets the organization. It defaults to the current manufacturing organization.
*   **Manufacturing Mode:** restricts the operations to Flow or Standard.
*   **Operation Type:** restricts the operations to one of the four types.
*   **Operation Code and Operation Code like:** select one operation or a pattern.
*   **Department:** restricts the operations to one department.
*   **Contains Resource:** returns each matching operation in full, with all its resource rows.

## Performance & Optimization
*   The organization parameter is the first filter, so every join runs inside one manufacturing organization.
*   Activity and line joins are outer joins, which keeps resources without an activity and discrete operations without a line in the result.
*   Flexfield values are rendered through `xxen_util.display_flexfield_value` with the operations flexfield identifier, so the download reads the segment labels rather than raw columns.

## FAQ
**Q: How do I upload a standard operation that has no resources?**
A: Enter the header columns and leave Resource Code blank on that row.

**Q: Why can a standard operation not be deleted?**
A: Header deletion is blocked when an active routing operation or a setup transition references the standard operation.

**Q: Which template should I use for a flow line operation?**
A: Use Flow Standard Line Operations, which is a Flow Line operation tied to a production line.
