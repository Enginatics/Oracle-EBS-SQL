# Case Study & Technical Analysis: OPM Item Process and Recipe Attributes

## Executive Summary
The OPM Item Process and Recipe Attributes report lists the items of Oracle Process Manufacturing that are enabled for recipes, process execution, process quality or process costing, with the attributes that govern how each item is produced and controlled. For each item it shows the enabled flags, grade control and default grade, lot and child lot control, lot divisibility and shelf life control. Formulation chemists, quality assurance teams and process engineers use it to confirm that an item is set up correctly before it is used in a recipe or batch, and to find items whose lot or shelf life settings differ from the standard for their organization. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Recipe readiness:** An item can be used in a formula or a batch only if it is enabled for recipes and process execution, and these flags must be checked item by item.
*   **Quality control setup:** Items that require quality sampling must be flagged as process quality enabled, so that the quality workflow applies to them.
*   **Lot and shelf life control:** Items that are lot controlled, divisible or shelf life controlled behave differently in inventory and in batch consumption, and their settings must be verified.
*   **Grade management:** Items with grade control need a default grade so that receipts and batches carry the correct grade.

## The Solution
*   **Process-enabled filter:** Only items with at least one of the recipe, process execution, process quality or process costing flags set to Y are listed.
*   **Readable flags:** The Y and N flags are displayed as Yes and No, and the lot control and shelf life codes are translated into text.
*   **Item context:** The organization code, item number, description, status and primary unit of measure are shown with each attribute set.

## Technical Architecture (High Level)
### Primary Tables
*   `MTL_SYSTEM_ITEMS_VL`: the item master, with the process manufacturing flags, grade and lot attributes, shelf life settings and status.
*   `ORG_ORGANIZATION_DEFINITIONS`: the organization code of each item.
*   `ORG_ACCESS_VIEW`: the organizations visible to the current responsibility.

### Logical Relationships
1.  `MTL_SYSTEM_ITEMS_VL` joins to `ORG_ORGANIZATION_DEFINITIONS` on the organization ID.
2.  The item rows are restricted to organizations in `ORG_ACCESS_VIEW` for the current responsibility.
3.  The process-enabled condition is applied as an OR of the recipe, process execution, process quality and process costing flags.
4.  Output is ordered by organization code and item concatenated segments.

## Parameters & Filtering
*   **Organization Code:** selects the organization.
*   **Item:** selects one item by its concatenated segments.
*   **Item Status:** filters the items by their inventory item status code.

## Performance & Optimization
*   The query reads only the item master view and the organization definitions, so no transaction table is touched.
*   The organization restriction is an `IN` subquery on `ORG_ACCESS_VIEW`, which limits the item rows to the organizations the user can see.
*   The process-enabled condition is a single predicate on four flag columns, applied in the item query, so items that are not process enabled are excluded before the output.
*   Flag values are converted by the `XXEN_UTIL` yes-no helper, which keeps the presentation consistent across reports.

## FAQ
**Q: Which items appear in this report?**
A: Items that are enabled for recipes, process execution, process quality or process costing in the accessible organizations.

**Q: What does Grade Controlled show?**
A: It shows whether grade control is enabled for the item, together with the default grade of the item.

**Q: How is shelf life control displayed?**
A: The shelf life control column shows No shelf life control, Shelf life days, or User-defined expiration, depending on the shelf life code, with the shelf life days alongside.
