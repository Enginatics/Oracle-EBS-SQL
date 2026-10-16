# Case Study & Technical Analysis: CST Resource Rate Upload

## Executive Summary
The CST Resource Rate Upload maintains resource rates in Oracle Cost Management. Each row is one resource in one organization for one target cost type, with its rate and descriptive flexfield attributes. Cost accountants, manufacturing engineers and implementation teams use it to rate new resources, amend existing rates in bulk, and copy rates between cost types, including the AvgRates cost types used by average costing organizations. The report runs in Excel via Blitz Report, and the rates are imported through the Oracle Cost Import Process, with deletions applied directly to the resource rate records.

## Business Challenge
*   **Bulk rate changes:** Updating standard rates for many resources through the Resources form is slow when several organizations and cost types are involved.
*   **Rating new resources:** Resources added to an organization need rates in each cost type, and rates for them must be entered before costs roll up correctly.
*   **Cost type restrictions:** Rates can only be loaded to cost types that are not frozen and are flagged as updateable, so the target cost type status must be checked.
*   **Rate effect on item costs:** Rate changes do not reach item costs until a rollup runs, so the rollup scope must be chosen deliberately.

## The Solution
*   **Download, amend and upload:** Current rates are downloaded from a source cost type, amended in Excel and uploaded to the target cost type.
*   **Copy between cost types:** A rate set from one cost type can be written to another, including rates for AvgRates cost types.
*   **Unrated resource capture:** The optional Include Resources without a Rate setting adds rate-eligible resources with a blank rate, ready to be entered.
*   **Optional rollup:** The upload can run a cost rollup for specific items or for all items in each organization.

## Technical Architecture (High Level)
### Primary Tables
*   `CST_RESOURCE_COSTS`: the resource rate rows, keyed by cost type, organization and resource.
*   `CST_COST_TYPES`: the source and target cost types, referenced by name.
*   `MTL_PARAMETERS`: the organizations and their cost organization assignment.
*   `BOM_RESOURCES`: the resource definitions, including unit of measure, cost element and disable date.
*   `ORG_ACCESS_VIEW`: the organizations the current responsibility can access.

### Logical Relationships
1. `CST_COST_TYPES` is referenced twice: the source cost type is joined to `CST_RESOURCE_COSTS` on cost_type_id, and the target cost type labels every output row.
2. `BOM_RESOURCES` is joined to `MTL_PARAMETERS` on organization_id, restricted to resources with cost element 3 or 4.
3. `CST_RESOURCE_COSTS` is outer joined to `BOM_RESOURCES` on cost type, organization and resource, so resources without a rate are present as rows.
4. `MTL_PARAMETERS` is limited to organizations in `ORG_ACCESS_VIEW` for the current responsibility and to cost organizations without process enabled flags.

## Parameters & Filtering
*   **Target Cost Type:** The cost type to which the rates are uploaded and that labels every row.
*   **Mode:** "Remove and replace cost information" replaces an existing rate for the same resource, while "Insert new Cost Information Only" raises an error when a rate already exists.
*   **Auto Populate Upload Columns:** For downloaded rates, Yes flags every record ready for upload even without changes.
*   **Source Cost Type:** The cost type from which the current rates are downloaded.
*   **Include Resources without a Rate:** When Yes, rate-eligible resources without a rate in the source cost type are also downloaded with a blank rate.
*   **Rollup Costs?, Rollup Type, Rollup Option:** Control whether a rollup runs after import, whether it covers all items or specific items, and whether it is single-level or full.
*   **Organization Code, Resource, Resource Like:** Optionally restrict the downloaded resources, with Resource Like allowing a pattern match on the resource code.

## Performance & Optimization
*   Equality conditions on the cost type names and the organization access subquery limit the main scan to the source cost type and the permitted organizations.
*   The include flag and the outer join on `CST_RESOURCE_COSTS` decide whether unrated resources are returned.
*   Resource eligibility is filtered directly in the query: cost element identifiers 3 and 4, a non-functional-currency flag, allowed costs, and an open disable date.
*   The rollup is run by the upload after import, not by this query.

## FAQ
**Q: How do I rate a new resource in an organization for a cost type?**
A: Select the same cost type as both Source and Target Cost Type, set Include Resources without a Rate to Yes, enter the rate in the blank row, and upload.

**Q: Can this upload delete a resource rate?**
A: Yes. Setting the Delete Resource Rate column to Yes removes the rate directly, since the Cost Import Process cannot delete it; deletion is not allowed for frozen standard cost types.

**Q: Are rates loaded into average costing organizations?**
A: Yes. The description states that the rates cost types used by average costing organizations, such as AvgRates, can be uploaded to, provided they are not frozen and are updateable.
