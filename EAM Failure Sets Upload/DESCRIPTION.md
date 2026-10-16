# Case Study & Technical Analysis: EAM Failure Sets Upload

## Executive Summary
This upload creates and updates Oracle Enterprise Asset Management failure sets. A failure set groups the failure, cause and resolution codes that maintenance planners can record against the asset groups and rebuildable items it is associated with. The upload maintains three kinds of rows: the set header, the item associations and the failure, cause and resolution combinations. Maintenance engineers and reliability analysts use it to set up failure coding for a plant in one workbook rather than through the Failure Sets form item by item. The template runs in Excel through Blitz Report.

## Business Challenge
*   **Consistent failure coding:** Work orders are only useful for reliability analysis when the same failure, cause and resolution codes are used for the same equipment.
*   **Large setup effort:** Each failure set needs many item associations and combinations, which is slow to maintain one at a time.
*   **Validation of codes and items:** Combinations must use codes that already exist, and associated items must be eligible asset groups or rebuildable items.
*   **Retiring obsolete coding:** Sets and their children must be ended without losing history.

## The Solution
*   **Three row types:** SET rows define the header, ASSOCIATION rows link the set to an asset group or rebuildable item, and COMBINATION rows add a failure, cause and resolution triple.
*   **Header created from child rows:** On Create, the first ASSOCIATION or COMBINATION row for a new Set Name creates the missing header.
*   **Item eligibility:** An association item must have an EAM item type of 1 or 3 and must exist in the master item organization.
*   **Ending rather than deleting:** A SET row cannot be deleted, so it is end-dated instead. ASSOCIATION and COMBINATION rows can be deleted by setting Delete to Yes.
*   **Reactivation:** Blanking the effective end date of an ended record on update reactivates it.

## Technical Architecture (High Level)
### Primary Tables
*   `EAM_FAILURE_SETS`: the failure set header, with set name, description and effective end date.
*   `EAM_FAILURE_SET_ASSOCIATIONS`: the links between a set and an inventory item, with the failure code required flag and effective end date.
*   `EAM_FAILURE_COMBINATIONS`: the failure, cause and resolution code triples of a set, with their effective end dates.
*   `MTL_SYSTEM_ITEMS_B_KFV`: the associated inventory item and its concatenated segments.
*   `MTL_PARAMETERS`: the master organization test that restricts associations to the master item organization.

### Logical Relationships
1. `EAM_FAILURE_SETS` is the parent of both child sets, joined on set id.
2. `EAM_FAILURE_SET_ASSOCIATIONS` joins to `MTL_SYSTEM_ITEMS_B_KFV` on inventory item id, and the item's organization must equal the master organization in `MTL_PARAMETERS`.
3. `EAM_FAILURE_COMBINATIONS` carries the failure, cause and resolution codes directly on each row.
4. The three row types are combined with UNION ALL, so every row shares the set name and the row type column.

## Parameters & Filtering
*   **Upload Mode:** selects Create, or Create, Update to download the sets, associations and combinations.
*   **Set Name:** restricts the download to one failure set.

## Performance & Optimization
*   The query returns three UNION ALL blocks, each a direct join from the set table, so no block depends on another's result.
*   The master organization test on `MTL_PARAMETERS` limits the item join to one organization, which avoids repeated item rows across organizations.
*   The Set Name parameter reduces the set scan to a single set when a plant maintains one set at a time.

## FAQ
**Q: Why can I not delete a failure set?**
A: The Oracle API does not provide a delete for failure sets. Set Set Effective End Date instead to end the set.

**Q: Which items can I associate with a failure set?**
A: Items with an EAM item type of asset group or rebuildable, which exist in the master item organization.

**Q: Do I need the failure codes to exist before I upload combinations?**
A: Yes. The individual codes must already exist in the EAM failure code setup, which the EAM Failure Codes Upload maintains.
