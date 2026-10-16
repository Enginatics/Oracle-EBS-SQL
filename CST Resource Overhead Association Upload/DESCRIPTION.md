# Case Study & Technical Analysis: CST Resource Overhead Association Upload

## Executive Summary
The CST Resource Overhead Association Upload maintains the links between Resource or Outside Processing sub-elements and the Overhead or Material Overhead sub-elements they absorb in Oracle Cost Management. Each row is one resource-to-overhead association for one organization and one target cost type. Cost accountants and manufacturing engineers use it to build, copy and correct standard costing structures in bulk, for example when setting up a new cost type or aligning a target cost type with a source one before a cost rollup. The report runs in Excel via Blitz Report; the upload goes through the Oracle Cost Import Process.

## Business Challenge
*   **Manual association maintenance:** Associating each resource with its overheads through the Overheads form is repetitive when many organizations and resources are involved.
*   **Copying between cost types:** Rebuilding the same overhead structure by hand invites inconsistencies.
*   **Frozen and non-updateable types:** Changes are only permitted on cost types that are not frozen and are flagged as updateable, so costing teams need to check the cost type status before loading.
*   **Stale item costs:** Association changes do not change item costs until a rollup is run, and the rollup scope needs to be chosen deliberately.

## The Solution
*   **Source-to-target copy:** Associations are downloaded from a source cost type and written to a target cost type, so an existing structure can be replicated.
*   **Controlled upload modes:** Existing associations for the same resource, overhead and cost type are replaced in "Remove and replace" mode, or uploads that duplicate an existing association raise an error in "Insert new Cost Information Only" mode.
*   **Optional rollup:** The upload can run a cost rollup for specific items or for all items in each organization, in single-level or full-cost form.

## Technical Architecture (High Level)
### Primary Tables
*   `CST_RESOURCE_OVERHEADS`: the resource-to-overhead association rows, keyed by cost type, organization, resource and overhead.
*   `CST_COST_TYPES`: the source and target cost types, referenced by name.
*   `MTL_PARAMETERS`: the organizations and their cost organization assignment.
*   `BOM_RESOURCES`: the resource and overhead sub-element definitions, referenced twice for the resource and the overhead.
*   `ORG_ACCESS_VIEW`: the organizations the current responsibility can access.

### Logical Relationships
1. `CST_COST_TYPES` is referenced twice: the source cost type supplies the associations to download, and the target cost type labels every output row.
2. `CST_RESOURCE_OVERHEADS` is joined to the source cost type on cost_type_id and to `MTL_PARAMETERS` on organization_id.
3. The resource_id of `CST_RESOURCE_OVERHEADS` is joined to `BOM_RESOURCES` to obtain the resource code and description.
4. The overhead_id is joined to a second alias of `BOM_RESOURCES` to obtain the overhead code and description.
5. `MTL_PARAMETERS` is limited to organizations in `ORG_ACCESS_VIEW` for the current responsibility, to cost organizations, and to organizations without process enabled flags.

## Parameters & Filtering
*   **Target Cost Type:** The cost type that receives the associations. It is the cost type shown on every row and the one the upload writes to.
*   **Mode:** Sets the upload behaviour: "Remove and replace cost information" replaces an existing association, while "Insert new Cost Information Only" raises an error for an existing one. The SQL filters on the mode through a bind comparison.
*   **Auto Populate Upload Columns:** When set to Yes, downloaded associations are flagged ready for upload even without changes.
*   **Source Cost Type:** The cost type from which the current associations are downloaded. It is the only bind that drives the download source.
*   **Rollup Costs?, Rollup Type, Rollup Option:** Control whether a cost rollup runs after import, whether it covers all items or specific items, and whether it is single-level or full.
*   **Organization Code, Resource, Overhead:** Optionally restrict the downloaded associations to one organization, resource or overhead.

## Performance & Optimization
*   Cost type and organization filters are applied as equality conditions on `CST_COST_TYPES` and `MTL_PARAMETERS`, which limit the scan of `CST_RESOURCE_OVERHEADS` to one source cost type.
*   Organization access is handled by an `IN` subquery on `ORG_ACCESS_VIEW` filtered by the current responsibility, so only permitted organizations are read.
*   The rollup is not performed by this query; the upload triggers it after import.

## FAQ
**Q: How do I copy resource overhead associations from one cost type to another?**
A: Set the Source Cost Type to the existing cost type and the Target Cost Type to the new one, then upload in "Remove and replace cost information" mode.

**Q: Can this upload delete a resource overhead association?**
A: Yes. Setting the Delete Association column to Yes removes the association directly, because the Cost Import Process cannot delete it; deletion is not allowed for frozen standard cost types.

**Q: Why are some items not updated by the Specific item rollup?**
A: In Specific item mode the items are derived from existing cost details in the target cost type, so items never rolled up in that cost type are not found; use All items mode for them.
