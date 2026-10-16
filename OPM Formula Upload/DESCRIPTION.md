# Case Study & Technical Analysis: OPM Formula Upload

## Executive Summary
This upload creates and updates process manufacturing formulas in Oracle Process Manufacturing (OPM), the recipes that define the ingredients, products and by-products of a process. It downloads the formulas of an organization, one spreadsheet row per formula line, and lets a formulation or product development team add formulas, change quantities and attributes, and add lines. Changes are applied through the public GMDFORMULAPUB and GMDFORMULADETAILPUB APIs, so the OPM rules are enforced on every row. It is used when new formulas are loaded from a development system, when many formula quantities are revised, or when formulas are copied between organizations. Blitz Report™ provides the spreadsheet in which the formulas are reviewed and edited.

## Business Challenge
*   **Formulas are multi-line:** A formula is a header with several ingredient, product and by-product lines, which is awkward to maintain one screen at a time.
*   **OPM validation rules:** A formula must have at least one ingredient and at least one product, and items must be recipe-enabled, so bad rows must be found before the upload.
*   **Versions and keys:** Formulas are identified by organization, formula number and version, and the key must stay stable through an update.
*   **Status control:** Formula status changes are workflow operations, so the upload must not change status directly.

## The Solution
*   Downloads each formula line with its header fields, including organization code, formula number and version, description, class, owner, scale type, status and header attributes.
*   Shows each line's type as ingredient, product or by-product, with its item, revision, quantity, detail unit of measure, scale type, release type, scrap factor, phantom type, rework type and yield and cost flags.
*   Assigns an upload row number in formula order, so the rows of one formula stay together for the upload.
*   Shows the header and line flexfield attributes of each formula and line, so they can be edited in the same file.
*   Supports creating new formulas with an empty template, and updating existing formulas in the chosen organization while adding new lines to them.

## Technical Architecture (High Level)
### Primary Tables
*   `FM_FORM_MST_VL`: the formula header, with formula number, version, description, class, owner, scale type, status and attributes.
*   `FM_MATL_DTL`: the formula lines, with the line type, item, quantity, unit of measure, scale and attributes.
*   `MTL_SYSTEM_ITEMS_VL`: the item and its description.
*   `MTL_PARAMETERS`: the owner organization of the formula.
*   `GMD_STATUS_VL`: the formula status meaning.
*   `FND_USER`: the formula owner's user name.
*   `ORG_ACCESS_VIEW`: the organizations the responsibility can access.

### Logical Relationships
1. `FM_FORM_MST_VL` is joined to `FM_MATL_DTL` on the formula identifier, so each line carries its header.
2. The owner organization of the formula is joined to `MTL_PARAMETERS`.
3. Each line's item is joined to `MTL_SYSTEM_ITEMS_VL` on inventory item and organization.
4. The owner user and formula status are looked up from `FND_USER` and `GMD_STATUS_VL`.
5. Deleted formulas and inactive formulas are excluded, and the owner organization is limited to the organizations the responsibility can access.
6. An outer query orders the lines within each formula as ingredients, then products, then by-products, and by line number.

## Parameters & Filtering
*   **Upload Mode:** selects create with an empty template, or create and update, which downloads existing formulas.
*   **Organization Code:** selects the owner organization of the formulas.
*   **Formula:** limits the download to one formula number.

## Performance & Optimization
*   The organization restriction is applied through `ORG_ACCESS_VIEW`, so only formulas the user can access are read.
*   Deleted and inactive formulas are excluded in the header filter, so their lines are not read.
*   The flexfield values are resolved by the flexfield functions for each row, using the attribute category of the header and the line.
*   The download is ordered by formula and line type, which keeps rows of one formula contiguous, as the upload requires.

## FAQ
**Q: Why does an upload row fail for a formula with no product?**
A: OPM requires at least one ingredient and one product on every formula. A header-only formula is rejected by the API.

**Q: Can I change the status of a formula through this upload?**
A: No. New formulas are created in status New, and status changes are workflow operations that this upload does not drive.

**Q: Which fields identify an existing formula on update?**
A: The organization code, formula number and version. These cannot be changed on update.
