# Case Study & Technical Analysis: INV Item Attribute Master/Child Conflicts

## Executive Summary
This Inventory report lists items whose attribute values differ between a master inventory organization and its child organizations, for the attributes that Inventory controls at the master level. Item maintenance teams, inventory administrators and Oracle EBS DBAs use it to find the records behind "Master - Child Conflict" errors in Item Upload, so the values can be aligned before the next import. Each conflicting attribute is shown as `M:[master value] C:[child value]`, and attributes with no conflict are null. The report runs in Excel through Blitz Report™.

## Business Challenge
*   **Rejected item uploads:** Item Upload fails with a Master - Child Conflict error when a child-organization value differs from a value the master organization controls.
*   **Silent divergence:** Attribute values drift between organizations until an upload or update encounters the check, so the problem surfaces late.
*   **Cross-organization comparison:** Item masters often span several child organizations, and comparing each attribute by hand across them is slow and error-prone.
*   **Error-code diagnosis:** The error text names the conflicting attributes and a MASTERCHILDnn code, and this report translates that into item-level values.

## The Solution
*   **Master-child pairing:** The query pairs every child organization with its master organization and matches item records on the inventory item ID.
*   **Control-level awareness:** For each attribute, it looks up whether Inventory controls the value at the master level and compares values on that basis.
*   **Side-by-side values:** For each attribute that differs, it outputs the master and child values, and returns a blank result where they match.
*   **Upload-aware counting:** It parses the Item Upload package body from `USER_SOURCE` to identify columns whose null handling is defined there, and uses those flags when deciding how an empty master value is counted.

## Technical Architecture (High Level)
### Primary Tables
*   `MTL_SYSTEM_ITEMS_VL`: item attribute values, referenced twice, once for the child-organization item and once for the master-organization item.
*   `MTL_PARAMETERS`: organization definitions, referenced twice to identify each child organization and its master organization.
*   `USER_SOURCE`: data dictionary view, read for the `INVUPD1B` package body to derive the column flags.
*   `DUAL`: source of the attribute control lookups inside the `item_attrib_ctl_lvls` CTE.

### Logical Relationships
1. `item_attrib_ctl_lvls` (a materialized CTE) calls `inv_attribute_control_pvt.get_attribute_control` for each attribute from a `DUAL` select, producing one row of control levels.
2. `sentinel_support` (a materialized CTE) selects from `USER_SOURCE` for the `INVUPD1B` package body, extracts column names from `msii_temp_data` assignments and `G_UPD_NULL` DECODE expressions, and returns one row of 0/1 flags per attribute.
3. `MTL_PARAMETERS` `mp` (child organizations, where organization_id differs from master_organization_id) joins to `mpm` (master) on master_organization_id.
4. `MTL_SYSTEM_ITEMS_VL` `msi` (child item) joins to `mp` on organization_id; `msim` (master item) joins to `mpm` on organization_id and to `msi` on inventory_item_id.
5. The inner query builds an `M:[...] C:[...]` string per attribute, kept only when a WHERE group of NOT-AND equality tests fails. The outer query joins the result to `sentinel_support` and concatenates the names of the conflicting attributes into one text value.

## Parameters & Filtering
*   **Organization Code:** The only declared parameter. The query text does not reference it by name, so its effect cannot be confirmed from the SQL alone.
*   **Child-organization scope:** Built into the query, not a parameter. Only organizations whose organization_id differs from the master_organization_id are evaluated, and only items present in both the master and the child organization are compared.
*   **Attribute groups:** A row is returned when at least one attribute group fails the equality test. The groups are tagged in the SQL comments as 1A to 1IK, 4A to 4O, 7A to 7J and "other", and reference the item import validation routines INVPVALM and INVPVLM3.

## Performance & Optimization
*   **Materialized lookups:** The `/*+ materialize */` hints on `item_attrib_ctl_lvls` and `sentinel_support` ensure the control-level lookups and the `USER_SOURCE` parse run once, not once per item row.
*   **Early master exclusion:** The predicate `mp.organization_id != mp.master_organization_id` removes the master organization before the item join.
*   **Key-based item join:** Items are matched between master and child on `inventory_item_id`, and the decode-based comparisons then filter out rows with no difference.
*   **Single-row sentinel join:** `sentinel_support` uses aggregates without GROUP BY, so it returns one row and its join adds no row multiplication. The query has no organization predicate in its body, so every item in every child organization is evaluated.

## FAQ
**Q: What does M:[ ] C:[ ] mean in the INV Item Attribute Master/Child Conflicts report?**
A: It shows the master organization value and the child organization value for an attribute that differs between them. A blank result means the values match.

**Q: Why does Item Upload return a Master - Child Conflict error?**
A: The upload compares child-organization values with attributes that the master organization controls. This report lists the attributes where those values differ, so you can align them before uploading again.

**Q: How do I find item attribute conflicts across child organizations in Oracle EBS?**
A: Run the report and review the rows with non-null values. Each row identifies the item, the master organization code and the child organization code, and the conflicting attributes with their master and child values.
