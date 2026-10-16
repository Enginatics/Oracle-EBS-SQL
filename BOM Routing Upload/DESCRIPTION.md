# Case Study & Technical Analysis: BOM Routing Upload

## Executive Summary
This upload maintains manufacturing routings in Oracle Bills of Material. It downloads the existing routings of an organization, with their operations, departments, resources, substitute resources and operation networks, and lets a planner or process engineer create, correct, or delete them in a spreadsheet before uploading the changes. It covers Standard, Flow and Lot Based (network) routings, and it can also upload Common Routing Assignments. Manufacturing engineering and planning teams use it when routings are created from a template, when resource usage rates change, or when a large number of items need the same operation sequence.

## Business Challenge
*   **Routing data is deep:** A routing is a header, several operations, each with departments and resources, plus substitute resources and network links, which is hard to maintain through the forms one record at a time.
*   **Effectivity by revision:** Routing revisions carry effectivity dates, and the correct revision must be matched to the planning date.

## The Solution
*   Downloads routings for one organization, filtered by assembly type, routing type, item, alternate, revision and effective date, using the same effectivity rule as the Bills of Material forms.
*   Returns each operation with its department, standard operation code, count point, backflush, yield, labour and machine times, and the flexfield values of the routing, revision, operation and resource.
*   Adds the substitute resources and the operation networks as separate sets of rows, shown only when the corresponding Show options are set.
*   Provides delete flags for routings, revisions, operations, resources and network links, so that the upload can remove rows that are no longer needed.

## Technical Architecture (High Level)
### Primary Tables
*   `BOM_OPERATIONAL_ROUTINGS`: the routing header, with its assembly item, routing type, alternate, completion data and common routing assignment.
*   `MTL_RTG_ITEM_REVISIONS`: the routing revisions and their effectivity and implementation dates.
*   `BOM_OPERATION_SEQUENCES`: the operations of a routing, with effectivity and disable dates, yields and times.
*   `BOM_STANDARD_OPERATIONS` and `BOM_DEPARTMENTS`: the operation code and the department of each operation.
*   `BOM_OPERATION_RESOURCES` and `BOM_RESOURCES`: the resources of each operation, with usage rate, basis and scheduling.
*   `BOM_SUB_OPERATION_RESOURCES`: the substitute resources of an operation.
*   `BOM_OPERATION_NETWORKS`: the transitions between operations in a network routing.
*   `MTL_SYSTEM_ITEMS_VL`, `MTL_PARAMETERS`, `MTL_ITEM_LOCATIONS_KFV`, `WIP_LINES`, `BOM_DEPARTMENT_RESOURCES`, `BOM_SETUP_TYPES` and `CST_ACTIVITIES_VAL_V`: the item, organization, completion locator, production line, department availability, setup and activity reference data.

### Logical Relationships
1. `MTL_PARAMETERS` and `MTL_SYSTEM_ITEMS_VL` restrict the rows to one organization and to BOM-enabled items that are not EAM maintenance items.
2. `BOM_OPERATIONAL_ROUTINGS` is joined to the item and to the production line in `WIP_LINES`.
3. `MTL_RTG_ITEM_REVISIONS` is matched to the routing on item and organization, with the revision whose effectivity date is the latest on or before the effective date.
4. `BOM_OPERATION_SEQUENCES` is joined to the routing on routing sequence, and to `BOM_STANDARD_OPERATIONS` and `BOM_DEPARTMENTS`.
5. The resource branch joins `BOM_OPERATION_RESOURCES` to `BOM_RESOURCES`, the substitute branch joins `BOM_SUB_OPERATION_RESOURCES`, and the network branch joins `BOM_OPERATION_NETWORKS` to a second operation sequence for the target operation.
6. The three branches are combined with UNION ALL, so resources, substitute resources and networks each appear as their own rows.

## Parameters & Filtering
*   **Upload Mode:** selects create only, or create and update with the existing routings downloaded.
*   **Routing Type:** selects Standard, Flow or Lot Based routings.
*   **Organization Code**, **Item**, **Item From** and **Item To:** limit the routings to an organization and item range.
*   **Alternate** and **Revision:** select an alternate routing and a specific revision.
*   **Effective Date:** sets the date used to choose the routing revision and the operations that are current.
*   **Display** and **Implemented Only:** choose All, Current or Future and Current operations, and whether only implemented operations are shown.
*   **Show Operations**, **Show Resources**, **Show Substitute Resources** and **Show Networks:** control which levels of the routing are included.
*   **Routings With Substitutes Only** and **Routings With Networks Only:** limit the download to routings that have those structures.

## Performance & Optimization
*   The revision is selected through a correlated maximum effectivity date, which avoids returning every revision of the item to the report.
*   The operation join is driven by the Show Operations flag through a decode on the routing identifier, so operations are attached only when that flag is Y.

## FAQ
**Q: How do I download the routings of one item for correction?**
A: Enter the Organization Code and the Item, and set Show Operations, Show Resources and Show Substitute Resources to Yes. Edit the rows and upload with Create, Update.

**Q: Which revision does the download show?**
A: The revision whose effectivity date is the latest on or before the Effective Date, or the earliest revision when none is on or before that date.

