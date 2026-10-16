# Case Study & Technical Analysis: CST Department Overhead Rate Upload

## Executive Summary
The CST Department Overhead Rate Upload maintains department overhead rates in Oracle Cost Management, the rates that charge overhead sub-elements to departments by item, lot, resource units or resource value. It is written for cost accountants and manufacturing finance teams who set up or revise standard costs and need to change many department overhead rates at once. The upload can download current rates for a cost type, amend them, copy them from a source cost type to a target cost type, create new rates or delete existing ones.
## Business Challenge
*   **Standard cost maintenance at volume:** Department overhead rates are defined per department and overhead, so a plant-wide change touches many rows that are tedious to key in the form.
*   **Copying rates between cost types:** Companies that maintain several cost types, such as frozen and pending standards, need the same overhead structure in each.
*   **Import limitations:** The Cost Import Process cannot delete a rate and accepts only one row per department, overhead and cost type in a single run, so the workflow must handle these constraints.

## The Solution
*   **Download, amend and upload:** The report downloads the current rates for a target cost type, optionally from a source cost type, and the user edits and re-uploads them.
*   **Two import behaviours:** Remove and replace mode replaces an existing rate for the same department, overhead and cost type, while Insert new mode raises an error if the combination already exists.
*   **Direct deletion:** A row flagged with Delete Overhead Rate is removed directly, in the same way as the Overheads form, because the Cost Import Process cannot perform deletions.
*   **Optional rollup:** Rollup can be run for specific items that reference the uploaded overheads, or for all items in each organisation, with single level or full cost options.

## Technical Architecture (High Level)
### Primary Tables
*   `CST_DEPARTMENT_OVERHEADS`: the department overhead rates, holding the basis type, rate or amount, activity and flexfield values.
*   `CST_COST_TYPES`: the source and target cost types, used to select the rates to download and the type to upload into.
*   `MTL_PARAMETERS`: the inventory organisations, with their cost organisation and process manufacturing flags.
*   `BOM_DEPARTMENTS`: the departments that carry overhead rates.
*   `BOM_RESOURCES`: the overhead resources, restricted to the overhead cost element.
*   `CST_ACTIVITIES`: the activity attached to each rate.

### Logical Relationships
1. `CST_COST_TYPES` is joined twice, once as the source type and once as the target type, which allows rates to be copied between cost types.
2. `CST_DEPARTMENT_OVERHEADS` joins to the source cost type on its cost type identifier, and to `MTL_PARAMETERS` on the organisation identifier.
3. Rates join to `BOM_DEPARTMENTS` on the department identifier and to `BOM_RESOURCES` on the overhead identifier, with the resource restricted to cost element 5.
4. Rates join to `CST_ACTIVITIES` through an outer join on the activity identifier.
5. Organisations are limited to those returned by `ORG_ACCESS_VIEW` for the current responsibility.

## Parameters & Filtering
*   **Target Cost Type:** The cost type into which rates are uploaded, and the type whose rates are returned.
*   **Mode:** Remove and replace cost information, or Insert new cost information only, as described in the Technical Architecture section.
*   **Auto Populate Upload Columns:** When set to Yes, downloaded rows are flagged for upload even if unchanged.
*   **Source Cost Type:** The cost type from which rates are downloaded when copying between types.
*   **Rollup Costs?, Rollup Type and Rollup Option:** Control whether a cost rollup runs after import, whether it covers specific or all items, and whether it is single level or full cost.

## Performance & Optimization
*   **Organisation filter first:** The query limits `MTL_PARAMETERS` to the organisations in `ORG_ACCESS_VIEW` before joining the rate tables.
*   **Current records only:** Departments and resources are filtered to those with no disable date or a future one, so retired records are excluded from download.

## FAQ
**Q: How do I copy department overhead rates from one cost type to another in Oracle Cost Management?**
A: Set the Source Cost Type and Target Cost Type parameters, download the rates, and upload the file to the target type.

**Q: Why is a deleted department overhead rate still in my item costs?**
A: The description states that deletion does not trigger a rollup. Run a rollup separately if the removal should be reflected in item costs.

**Q: Can I upload two overhead rates for the same department with different basis types in one run?**
A: No. The Cost Import Process accepts only one row per department, overhead and cost type in a single run, so in Remove and replace mode the uploaded row replaces all existing basis rows for that combination.
