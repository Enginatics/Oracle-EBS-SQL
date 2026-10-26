---
layout: default
last_modified_at: 2026-10-26
title: 'INV Item User Defined Attribute Upload | Oracle EBS SQL Report'
description: 'Item user-defined attribute (UDA) values upload for Oracle Product Information Management (PIM / Advanced Product Catalog). Creates, updates and deletes…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, INV, Item, User, Defined, ego_mtl_sy_items_ext_b, mtl_parameters, mtl_system_items_vl'
permalink: /INV%20Item%20User%20Defined%20Attribute%20Upload/
report_name: 'INV Item User Defined Attribute Upload'
report_web_name: inv-item-user-defined-attribute-upload
---

# INV Item User Defined Attribute Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-user-defined-attribute-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload).

## Overview
Item user-defined attribute (UDA) values upload for Oracle Product Information Management (PIM / Advanced Product Catalog).

Creates, updates and deletes item user-defined attribute values (attribute groups defined in the item catalog) at the item, item organization and item revision data levels through the Oracle EGO user attributes API. Each upload row carries one attribute value; the rows of one attribute group row instance (same item, data level, attribute group and row number) are processed together.

For multi-row attribute groups, enter a Row Number to group the attribute values belonging to one row and include the group's unique key attributes on every row. Set Delete Row to Yes to delete a complete attribute group row.

Enter date attribute values in format DD-MON-YYYY, and enter a UOM for numeric attributes that have a unit of measure class. Users need PIM edit privileges on the items (for example through an item owner role); the upload enforces the same item and attribute group security as the PIM pages.

Only attribute groups associated to item catalog categories are included. The seeded Detailed Description and Images item features are not user-defined attribute groups and are excluded, and supplier association data levels (item supplier, item supplier site, item supplier site organization) are not supported.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Organization Code, Item, Item Catalog Category, Attribute Group, Data Level

## Oracle EBS Tables Used
[ego_mtl_sy_items_ext_b](https://www.enginatics.com/library/?pg=1&find=ego_mtl_sy_items_ext_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload), [ego_data_level_vl](https://www.enginatics.com/library/?pg=1&find=ego_data_level_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload), [mtl_item_revisions_b](https://www.enginatics.com/library/?pg=1&find=mtl_item_revisions_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload), [ego_attr_groups_v](https://www.enginatics.com/library/?pg=1&find=ego_attr_groups_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload), [ego_attrs_v](https://www.enginatics.com/library/?pg=1&find=ego_attrs_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload), [ego_obj_ag_assocs_b](https://www.enginatics.com/library/?pg=1&find=ego_obj_ag_assocs_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload), [fnd_objects](https://www.enginatics.com/library/?pg=1&find=fnd_objects&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload)

## Related Reports
[INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [BOM Resource Upload](/BOM%20Resource%20Upload/ "BOM Resource Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Item%20User%20Defined%20Attribute%20Upload/INV%20Item%20User%20Defined%20Attribute%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/inv-item-user-defined-attribute-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload) |
| Blitz Report™ XML Import | [INV_Item_User_Defined_Attribute_Upload.xml](https://www.enginatics.com/xml/inv-item-user-defined-attribute-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload) |
| SQL Source | [INV Item User Defined Attribute Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Item%20User%20Defined%20Attribute%20Upload/INV%20Item%20User%20Defined%20Attribute%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-item-user-defined-attribute-upload/](https://www.enginatics.com/reports/inv-item-user-defined-attribute-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload) |

## Case Study & Technical Analysis: INV Item User Defined Attribute Upload

### Executive Summary
INV Item User Defined Attribute Upload maintains the user-defined attribute values of items in Oracle Product Information Management, the extensible attribute groups attached to items in the item catalog. It creates, updates and deletes attribute values at the item, item organization and item revision levels through the Oracle EGO user attributes API. Product data stewards, catalog administrators and PIM users use it to load technical specifications, compliance data and classification attributes across many items in one file rather than through the item pages one at a time.

### Business Challenge
*   **Catalog Completeness:** Item attributes such as specifications or certifications must be populated for every item in a category before the catalog is published.
*   **Data Level Complexity:** The same attribute group can apply at item, item organization or revision level, and each level needs its own values.
*   **Multi-Row Groups:** Some attribute groups hold several rows per item, and the rows must be grouped correctly so the values stay together.
*   **Security Constraints:** Item edits are controlled by PIM privileges and item ownership, so the upload must respect the same rules as the item pages.

### The Solution
*   **One Value Per Row:** Each upload row carries a single attribute value, identified by its item, data level, attribute group and row number.
*   **Row Grouping:** A row number groups the values belonging to one row of a multi-row attribute group, and the unique key attributes are repeated on each row.
*   **Row Deletion:** A delete column removes a complete attribute group row when set to Yes.
*   **Unit Handling:** A unit of measure column is provided for numeric attributes that belong to a unit of measure class, and dates are entered in day-month-year form.

### Technical Architecture (High Level)
#### Primary Tables
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

#### Logical Relationships
1.  Each row of `EGO_MTL_SY_ITEMS_EXT_B` is joined to its item in `MTL_SYSTEM_ITEMS_VL` and to its organization in `MTL_PARAMETERS`.
2.  The data level is joined through `EGO_DATA_LEVEL_VL`, restricted to the item, item organization and revision levels.
3.  The attribute group is joined to `EGO_ATTR_GROUPS_V`, and the attributes of that group are joined from `EGO_ATTRS_V` on group type, group name and application.
4.  An EXISTS test confirms the attribute group is associated with the item object through `EGO_OBJ_AG_ASSOCS_B` and `FND_OBJECTS`, and is enabled.
5.  Revisions are outer joined to `MTL_ITEM_REVISIONS_B`, and each row is numbered for multi-row groups to produce the row number.

### Parameters & Filtering
*   **Upload Mode:** Selects Create, or Create and Update.
*   **Organization Code:** Restricts the items to one item organization.
*   **Item:** Restricts the output to one item.
*   **Item Catalog Category:** Limits the attribute groups to those associated with the category.
*   **Attribute Group:** Restricts the output to one attribute group.
*   **Data Level:** Restricts the output to item, item organization or item revision values.

### Performance & Optimization
*   **Organization Scope First:** The access view restricts the organization list before the extension rows are read, so the item extension table is accessed only for permitted organizations.
*   **Data Level Filter:** Only the three item data levels are read, which excludes the supplier association levels that the upload does not support.
*   **Existence Check for Association:** The association test is an EXISTS subquery, so each attribute group is checked once without multiplying the rows.
*   **Row Numbering in Subquery:** Row numbers for multi-row groups are computed in an inner query, so the outer query only formats and sorts the values.

### FAQ
**Q: How do I enter a date attribute value?**
A: Enter the date in DD-MON-YYYY format, as the description specifies.

**Q: How do I add a second row to a multi-row attribute group?**
A: Enter a Row Number that differs from the first row, and repeat the group's unique key attributes on every row of that instance.

**Q: Which data levels are supported?**
A: Item, item organization and item revision levels. Supplier association data levels are not supported by this upload.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-user-defined-attribute-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
