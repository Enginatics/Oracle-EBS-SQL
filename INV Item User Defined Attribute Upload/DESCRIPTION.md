# Case Study & Technical Analysis: INV Item User Defined Attribute Upload

## Executive Summary
INV Item User Defined Attribute Upload maintains the user-defined attribute values of items in Oracle Product Information Management, the extensible attribute groups attached to items in the item catalog. It creates, updates and deletes attribute values at the item, item organization and item revision levels through the Oracle EGO user attributes API. Product data stewards, catalog administrators and PIM users use it to load technical specifications, compliance data and classification attributes across many items in one file rather than through the item pages one at a time.

## Business Challenge
*   **Catalog Completeness:** Item attributes such as specifications or certifications must be populated for every item in a category before the catalog is published.
*   **Data Level Complexity:** The same attribute group can apply at item, item organization or revision level, and each level needs its own values.
*   **Multi-Row Groups:** Some attribute groups hold several rows per item, and the rows must be grouped correctly so the values stay together.
*   **Security Constraints:** Item edits are controlled by PIM privileges and item ownership, so the upload must respect the same rules as the item pages.

## The Solution
*   **One Value Per Row:** Each upload row carries a single attribute value, identified by its item, data level, attribute group and row number.
*   **Row Grouping:** A row number groups the values belonging to one row of a multi-row attribute group, and the unique key attributes are repeated on each row.
*   **Row Deletion:** A delete column removes a complete attribute group row when set to Yes.
*   **Unit Handling:** A unit of measure column is provided for numeric attributes that belong to a unit of measure class, and dates are entered in day-month-year form.

## Technical Architecture (High Level)
### Primary Tables
*   `EGO_MTL_SY_ITEMS_EXT_B`: the stored item extension rows that hold the attribute values, keyed by item, organization, data level, revision and attribute group.
*   `EGO_ATTR_GROUPS_V`: the attribute group definitions, including display names and the multi-row code.
*   `EGO_ATTRS_V`: the attributes within each group, with display names, sequence and enabled flags.
*   `EGO_DATA_LEVEL_VL`: the data level definitions.
*   `EGO_OBJ_AG_ASSOCS_B`: the associations between the item object and its attribute groups.
*   `FND_OBJECTS`: the object record for the item, used to identify the EGO_ITEM object.
*   `MTL_SYSTEM_ITEMS_VL`: the items, with concatenated segments and descriptions.
*   `MTL_PARAMETERS`: the organizations.
*   `MTL_ITEM_REVISIONS_B`: the item revisions.
*   `ORG_ACCESS_VIEW`: the organizations available to the current responsibility.

### Logical Relationships
1.  Each row of `EGO_MTL_SY_ITEMS_EXT_B` is joined to its item in `MTL_SYSTEM_ITEMS_VL` and to its organization in `MTL_PARAMETERS`.
2.  The data level is joined through `EGO_DATA_LEVEL_VL`, restricted to the item, item organization and revision levels.
3.  The attribute group is joined to `EGO_ATTR_GROUPS_V`, and the attributes of that group are joined from `EGO_ATTRS_V` on group type, group name and application.
4.  An EXISTS test confirms the attribute group is associated with the item object through `EGO_OBJ_AG_ASSOCS_B` and `FND_OBJECTS`, and is enabled.
5.  Revisions are outer joined to `MTL_ITEM_REVISIONS_B`, and each row is numbered for multi-row groups to produce the row number.

## Parameters & Filtering
*   **Upload Mode:** Selects Create, or Create and Update.
*   **Organization Code:** Restricts the items to one item organization.
*   **Item:** Restricts the output to one item.
*   **Item Catalog Category:** Limits the attribute groups to those associated with the category.
*   **Attribute Group:** Restricts the output to one attribute group.
*   **Data Level:** Restricts the output to item, item organization or item revision values.

## Performance & Optimization
*   **Organization Scope First:** The access view restricts the organization list before the extension rows are read, so the item extension table is accessed only for permitted organizations.
*   **Data Level Filter:** Only the three item data levels are read, which excludes the supplier association levels that the upload does not support.
*   **Existence Check for Association:** The association test is an EXISTS subquery, so each attribute group is checked once without multiplying the rows.
*   **Row Numbering in Subquery:** Row numbers for multi-row groups are computed in an inner query, so the outer query only formats and sorts the values.

## FAQ
**Q: How do I enter a date attribute value?**
A: Enter the date in DD-MON-YYYY format, as the description specifies.

**Q: How do I add a second row to a multi-row attribute group?**
A: Enter a Row Number that differs from the first row, and repeat the group's unique key attributes on every row of that instance.

**Q: Which data levels are supported?**
A: Item, item organization and item revision levels. Supplier association data levels are not supported by this upload.
