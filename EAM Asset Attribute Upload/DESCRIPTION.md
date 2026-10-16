# Case Study & Technical Analysis: EAM Asset Attribute Upload

## Executive Summary
This upload creates and updates the attribute group values of Oracle Enterprise Asset Management (EAM) assets and rebuildable numbers. Maintenance planners and asset administrators use it to enter the descriptive attributes of many assets in one spreadsheet, rather than opening the Asset Attributes window for each asset. The file is worked in Excel through Blitz Report™ in Create, Update mode, so existing values are downloaded and changed in place.

## Business Challenge
*   **Attribute data entry:** Asset attribute groups hold technical data such as ratings, manufacturer details and inspection dates, and entering them asset by asset is slow.
*   **Attribute group structure:** Each asset group has its own attribute groups, and the set of attributes differs between them, so the spreadsheet must follow the group being maintained.
*   **Consistency across assets:** Asset attributes must be applied consistently across an asset population to support maintenance reporting and inspection schedules.
*   **Mixed data types:** Character, number and date attributes must each be entered in the correct type.

## The Solution
*   Downloads the existing attribute values for the selected assets, showing the organization, asset number, asset group and attribute group of each row.
*   Lets each row carry one attribute group of one asset number, so an asset with several attribute groups occupies several rows.
*   Presents the flexfield segments as Attribute 1 to 20 for character values, Number Attribute 1 to 10 for numbers and Date Attribute 1 to 10 for dates.
*   Displays the value of each flexfield segment as its descriptive value where one applies, so users see meaningful values rather than raw codes.

## Technical Architecture (High Level)
### Primary Tables
*   `MTL_EAM_ASSET_ATTR_VALUES`: the stored attribute values, held per inventory item, serial number and attribute category, with character, number and date columns.
*   `MTL_EAM_ASSET_NUMBERS_ALL_V`: the asset numbers, giving the organization code, asset number and the concatenated asset group segments.

### Logical Relationships
1.  Each asset number in `MTL_EAM_ASSET_NUMBERS_ALL_V` is joined to its attribute values on the inventory item identifier and the serial number.
2.  The attribute category of each value row defines its attribute group, which is returned through the flexfield context display function under application identifier 401 for the table `MTL_EAM_ASSET_ATTR_VALUES`.
3.  Each character attribute column is passed through the flexfield value display function together with its segment name, so that value sets and meanings are resolved.
4.  Number and date attribute columns are returned directly from the value table.
5.  Rows carry blank action, status, message and modified-column columns, which the upload framework uses to record the outcome of each change.

## Parameters & Filtering
*   **Upload Mode:** sets whether the file is used to create or to create and update attribute values.
*   **Organization:** limits the assets to one inventory organization.
*   **Asset Number From** and **Asset Number To:** define a range of asset numbers.
*   **Asset Group:** limits the assets to one asset group, whose attribute groups are then available.
*   **Attribute Group:** selects the attribute group whose values are maintained.

## Performance & Optimization
*   The join between the asset number view and the attribute values is a single equality join on item and serial number, so the query cost follows the number of attribute value rows.
*   Each attribute column is resolved by a display function call, which adds work per row and per segment, so narrowing the selection by organization and asset range keeps the run time short.
*   Filtering by attribute group in the parameters restricts the rows to one flexfield structure, which reduces the number of segments that must be resolved.
*   The report reads only EAM tables and views, so it adds no load to other modules.

## FAQ
**Q: How are multiple attribute groups for one asset entered?**
A: Each attribute group of an asset is one row, so an asset with several attribute groups has one row for each group, identified by the Attribute Group column.

**Q: Which columns hold the attribute values?**
A: Character values use Attribute 1 to 20, numbers use Number Attribute 1 to 10, and dates use Date Attribute 1 to 10, following the segments of the selected attribute group.

**Q: Can this upload be used to create a new asset?**
A: No, the upload works on the attribute values of existing asset numbers, which are identified by organization and asset number.
