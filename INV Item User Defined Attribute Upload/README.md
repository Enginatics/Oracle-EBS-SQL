---
layout: default
title: 'INV Item User Defined Attribute Upload | Oracle EBS SQL Report'
description: 'Item user-defined attribute (UDA) values upload for Oracle Product Information Management (PIM / Advanced Product Catalog). Creates, updates and deletes…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, INV, Item, User, Defined, ego_mtl_sy_items_ext_b, mtl_parameters, mtl_system_items_vl'
permalink: /INV%20Item%20User%20Defined%20Attribute%20Upload/
---

# INV Item User Defined Attribute Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-user-defined-attribute-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Item user-defined attribute (UDA) values upload for Oracle Product Information Management (PIM / Advanced Product Catalog).

Creates, updates and deletes item user-defined attribute values (attribute groups defined in the item catalog) at the item, item organization and item revision data levels through the Oracle EGO user attributes API. Each upload row carries one attribute value; the rows of one attribute group row instance (same item, data level, attribute group and row number) are processed together.

For multi-row attribute groups, enter a Row Number to group the attribute values belonging to one row and include the group's unique key attributes on every row. Set Delete Row to Yes to delete a complete attribute group row.

Enter date attribute values in format DD-MON-YYYY, and enter a UOM for numeric attributes that have a unit of measure class. Users need PIM edit privileges on the items (for example through an item owner role); the upload enforces the same item and attribute group security as the PIM pages.

Only attribute groups associated to item catalog categories are included. The seeded Detailed Description and Images item features are not user-defined attribute groups and are excluded, and supplier association data levels (item supplier, item supplier site, item supplier site organization) are not supported.

## Report Parameters
Upload Mode, Organization Code, Item, Item Catalog Category, Attribute Group, Data Level

## Oracle EBS Tables Used
[ego_mtl_sy_items_ext_b](https://www.enginatics.com/library/?pg=1&find=ego_mtl_sy_items_ext_b), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [ego_data_level_vl](https://www.enginatics.com/library/?pg=1&find=ego_data_level_vl), [mtl_item_revisions_b](https://www.enginatics.com/library/?pg=1&find=mtl_item_revisions_b), [ego_attr_groups_v](https://www.enginatics.com/library/?pg=1&find=ego_attr_groups_v), [ego_attrs_v](https://www.enginatics.com/library/?pg=1&find=ego_attrs_v), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [ego_obj_ag_assocs_b](https://www.enginatics.com/library/?pg=1&find=ego_obj_ag_assocs_b), [fnd_objects](https://www.enginatics.com/library/?pg=1&find=fnd_objects)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[DIS Access Privileges](/DIS%20Access%20Privileges/ "DIS Access Privileges Oracle EBS SQL Report"), [AP Posted Payment Register](/AP%20Posted%20Payment%20Register/ "AP Posted Payment Register Oracle EBS SQL Report"), [Blitz Report Extension Package API Signatures](/Blitz%20Report%20Extension%20Package%20API%20Signatures/ "Blitz Report Extension Package API Signatures Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/inv-item-user-defined-attribute-upload/) |
| Blitz Report™ XML Import | [INV_Item_User_Defined_Attribute_Upload.xml](https://www.enginatics.com/xml/inv-item-user-defined-attribute-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-item-user-defined-attribute-upload/](https://www.enginatics.com/reports/inv-item-user-defined-attribute-upload/) |



---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
