# Case Study & Technical Analysis: INV Item Cross Reference Upload

## Executive Summary
INV Item Cross Reference Upload maintains item cross references in Oracle Inventory, the alternate identifiers that link an item to a customer item number, a supplier item number, a legacy part number or a GTIN barcode. It creates, updates and deletes cross references in bulk through the Cross Reference Types setup, which is also reached from the Item form. Inventory and product data teams use it when loading customer or supplier part catalogs, migrating legacy numbering, or maintaining the GTIN values that trading partners use on orders and labels.

## Business Challenge
*   **Partner Catalogs:** Customers and suppliers identify items by their own part numbers, and each mapping must be recorded against the correct item.
*   **Organization Scope:** A cross reference can apply to all organizations or only to one, and an item can be assigned to only some organizations.
*   **GTIN Rules:** Barcode references carry revision and unit of measure values that are valid only for the GTIN cross reference type, so incorrect entries must be prevented.
*   **Maintenance Effort:** Thousands of mappings created by hand through the Item form are slow and error prone.

## The Solution
*   **Item Based Rows:** Each row names the item, its master organization, the cross reference type, the reference value and the description, so the mapping is complete on one line.
*   **Scope Control:** The Applicable To All Organizations flag and the Organization Code column together set whether a reference is global or organization specific.
*   **Type Specific Attributes:** Revision and unit of measure are accepted only for the GTIN type, which the description states is defined by the INV: GTIN Cross Reference Type profile option.
*   **Delete Option:** A delete column removes a downloaded cross reference when set to Yes.

## Technical Architecture (High Level)
### Primary Tables
*   `MTL_CROSS_REFERENCES_VL`: the cross references with their type, reference value, description, unit of measure and descriptive flexfield attributes.
*   `MTL_SYSTEM_ITEMS_VL`: the items, with their concatenated segments and descriptions.
*   `MTL_PARAMETERS`: the organizations, used to identify the item master organization and the cross reference organization.
*   `MTL_ITEM_REVISIONS_B`: the item revisions referenced by a GTIN cross reference.
*   `ORG_ACCESS_VIEW`: the organizations the current responsibility can access.

### Logical Relationships
1.  Each cross reference in `MTL_CROSS_REFERENCES_VL` is joined to its item in `MTL_SYSTEM_ITEMS_VL` on the inventory item identifier.
2.  The item's organization is joined to `MTL_PARAMETERS` and restricted to the master organization.
3.  The cross reference's own organization is outer joined to `MTL_PARAMETERS`, so organization independent references return no organization code.
4.  The revision is outer joined to `MTL_ITEM_REVISIONS_B` on the revision identifier.
5.  Rows are limited to items in organizations returned by `ORG_ACCESS_VIEW` for the current responsibility.

## Parameters & Filtering
*   **Upload Mode:** Selects Create, or Create and Update, which controls whether existing cross references are downloaded.
*   **Item:** Restricts the cross references to one item.
*   **Cross Reference Type:** Restricts the output to one cross reference type.
*   **Cross Reference:** Matches the reference value itself, for example a customer part number.
*   **Organization Code:** Restricts the output to references in one organization.

## Performance & Optimization
*   **Item Driven Joins:** Cross references join to the item view on a single identifier, so the item attributes are fetched once per reference.
*   **Responsibility Scope Filter:** The organization restriction uses the access view, so the extract covers only the organizations the user is allowed to maintain.
*   **Outer Joins for Scope:** Organization and revision joins are outer joins, so organization independent references and references without revisions are still returned.
*   **Flexfield Expansion:** Descriptive flexfield values are expanded through the flexfield value function, which decodes segment values for display.

## FAQ
**Q: How do I create a cross reference that applies to all organizations?**
A: Leave the Org column blank and set the Applicable To All Organizations flag to Yes for the row.

**Q: Why is my revision rejected for a customer cross reference?**
A: Revision and unit of measure apply only to the GTIN cross reference type. Entering them for any other type is rejected.

**Q: How do I remove a cross reference?**
A: Download the reference, enter Yes in the Delete Cross Reference column for that row, and upload the template.
