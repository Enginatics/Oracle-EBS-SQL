# Case Study & Technical Analysis: EAM Asset Number Upload

## Executive Summary
This upload creates and updates Oracle Enterprise Asset Management asset numbers, the maintenance assets that work orders, preventive maintenance and failure tracking are performed against. It covers the asset's organization, group, category, criticality, status, location, equipment link and parent asset in the asset hierarchy, together with the asset's descriptive flexfield. Maintenance planners and EAM administrators use it to load new equipment, reorganize the asset hierarchy and correct asset attributes in bulk. The template runs in Excel through Blitz Report.

## Business Challenge
*   **Asset hierarchy maintenance:** Placing equipment under its parent asset is needed for rollups and for work order visibility, and is slow to do asset by asset.
*   **Asset master data quality:** Category, criticality, owning department, area and warranty dates must be consistent across a plant.
*   **Location and equipment links:** Assets must point to the right address and to the equipment item and serial they were built from.
*   **Migration and synchronization:** Assets that also appear in Fixed Assets need their synchronization flag and asset number maintained.

## The Solution
*   **Create and update by asset id:** An existing asset is identified by its asset id, so its asset number can be changed in the same upload.
*   **Parent placement:** Entering a Parent Asset Number places the asset in the hierarchy, and clearing it on an existing asset removes the parent.
*   **Read-only references:** Parent Asset Serial Number and Parent Asset Id follow the parent asset number and cannot be entered directly.
*   **Location addresses:** Current Location Address lists the addresses of the trading community locations, and an address that appears more than once carries its location id in brackets.
*   **Flexfield values:** The asset's instance flexfield is rendered with its segment labels, so the workbook shows readable values.

## Technical Architecture (High Level)
### Primary Tables
*   `MTL_EAM_ASSET_NUMBERS_ALL_V`: the view of EAM asset numbers, with the asset's organization, group, status, criticality and parent data.
*   `CSI_ITEM_INSTANCES`: the installed instance that holds the asset number, serial and location.
*   `MTL_SYSTEM_ITEMS_B_KFV`: the asset group and the equipment item, identified by inventory item id and organization.

### Logical Relationships
1. The asset number view is the single driving source, and each asset's equipment item is resolved from its equipment item id and production organization id.
2. The parent asset is resolved by matching the parent instance number to `CSI_ITEM_INSTANCES`, which returns the parent asset id.
3. The asset group, category and status are resolved from the asset number view's own columns, using meaning lookups for asset type and status.
4. The instance flexfield is joined through the context and row identifier of the asset record.

## Parameters & Filtering
*   **Upload Mode:** selects Create, or Create, Update to download existing assets.
*   **Organization:** restricts the assets to one inventory organization.
*   **Asset Number From / Asset Number To:** bound the assets by their asset number range.
*   **Asset Group:** restricts the assets to one asset group.
*   **Asset Category:** restricts the assets to one category.
*   **Asset Status:** restricts the assets to one current status.

## Performance & Optimization
*   The organization and number range parameters are applied to the asset number view, which limits the rows before the equipment and parent lookups run.
*   The equipment item lookup is a scalar subquery keyed on the inventory item and organization, so it is evaluated only for the rows returned.
*   The parent asset id lookup uses the instance number, which keeps the join to the instance table a single indexed-style match.

## FAQ
**Q: How do I remove an asset from its parent?**
A: On an existing asset, clear the Parent Asset Number. The parent link is removed when the row is uploaded.

**Q: Can I change the asset number of an existing asset?**
A: Yes. The asset is identified by its Asset Id, so the Asset Number can be changed on the same row.

**Q: Why is Parent Asset Id blank on my new row?**
A: The parent asset id follows the parent asset number and is read only. It is returned for assets whose parent exists.
