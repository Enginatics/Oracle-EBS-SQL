---
layout: default
last_modified_at: 2026-10-26
title: 'INV Item Cross Reference Upload | Oracle EBS SQL Report'
description: 'Creates, updates and deletes item cross references - the Cross Reference Types form (Inventory > Setup > Items > Cross-Reference Types), also reached from…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, INV, Item, Cross, Reference, mtl_cross_references_vl, mtl_system_items_vl, mtl_parameters'
permalink: /INV%20Item%20Cross%20Reference%20Upload/
report_name: 'INV Item Cross Reference Upload'
report_web_name: inv-item-cross-reference-upload
---

# INV Item Cross Reference Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-cross-reference-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-cross-reference-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-cross-reference-upload).

## Overview
Creates, updates and deletes item cross references - the Cross Reference Types form (Inventory > Setup > Items > Cross-Reference Types), also reached from the Item form via Tools > Cross References.

A cross reference is either organization independent (Applicable To All Organizations is set and Org is blank) or specific to one organization (Org is entered). The organization must be one the item is assigned to.

Revision and Unit of Measure only apply to the GTIN cross reference type named by the profile option INV: GTIN Cross Reference Type, and Revision additionally requires an organization. Entering them for any other type is rejected.

Descriptions are translatable and are downloaded in the session language.

To remove a cross reference, enter Yes in Delete Cross Reference on a downloaded row.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-cross-reference-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Item, Cross Reference Type, Cross Reference, Organization Code

## Oracle EBS Tables Used
[mtl_cross_references_vl](https://www.enginatics.com/library/?pg=1&find=mtl_cross_references_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-cross-reference-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-cross-reference-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-cross-reference-upload), [mtl_item_revisions_b](https://www.enginatics.com/library/?pg=1&find=mtl_item_revisions_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-cross-reference-upload), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-cross-reference-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-cross-reference-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-cross-reference-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-cross-reference-upload)

## Related Reports
[INV Item User Defined Attribute Upload](/INV%20Item%20User%20Defined%20Attribute%20Upload/ "INV Item User Defined Attribute Upload Oracle EBS SQL Report"), [ENG Engineering Change Order Upload](/ENG%20Engineering%20Change%20Order%20Upload/ "ENG Engineering Change Order Upload Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [CAC Where Used by Cost Type](/CAC%20Where%20Used%20by%20Cost%20Type/ "CAC Where Used by Cost Type Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report"), [BOM Bill of Material Structure](/BOM%20Bill%20of%20Material%20Structure/ "BOM Bill of Material Structure Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Item%20Cross%20Reference%20Upload/INV%20Item%20Cross%20Reference%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-cross-reference-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/inv-item-cross-reference-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-cross-reference-upload) |
| Blitz Report™ XML Import | [INV_Item_Cross_Reference_Upload.xml](https://www.enginatics.com/xml/inv-item-cross-reference-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-cross-reference-upload) |
| SQL Source | [INV Item Cross Reference Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Item%20Cross%20Reference%20Upload/INV%20Item%20Cross%20Reference%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-item-cross-reference-upload/](https://www.enginatics.com/reports/inv-item-cross-reference-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-cross-reference-upload) |

## Case Study & Technical Analysis: INV Item Cross Reference Upload

### Executive Summary
INV Item Cross Reference Upload maintains item cross references in Oracle Inventory, the alternate identifiers that link an item to a customer item number, a supplier item number, a legacy part number or a GTIN barcode. It creates, updates and deletes cross references in bulk through the Cross Reference Types setup, which is also reached from the Item form. Inventory and product data teams use it when loading customer or supplier part catalogs, migrating legacy numbering, or maintaining the GTIN values that trading partners use on orders and labels.

### Business Challenge
*   **Partner Catalogs:** Customers and suppliers identify items by their own part numbers, and each mapping must be recorded against the correct item.
*   **Organization Scope:** A cross reference can apply to all organizations or only to one, and an item can be assigned to only some organizations.
*   **GTIN Rules:** Barcode references carry revision and unit of measure values that are valid only for the GTIN cross reference type, so incorrect entries must be prevented.
*   **Maintenance Effort:** Thousands of mappings created by hand through the Item form are slow and error prone.

### The Solution
*   **Item Based Rows:** Each row names the item, its master organization, the cross reference type, the reference value and the description, so the mapping is complete on one line.
*   **Scope Control:** The Applicable To All Organizations flag and the Organization Code column together set whether a reference is global or organization specific.
*   **Type Specific Attributes:** Revision and unit of measure are accepted only for the GTIN type, which the description states is defined by the INV: GTIN Cross Reference Type profile option.
*   **Delete Option:** A delete column removes a downloaded cross reference when set to Yes.

### Technical Architecture (High Level)
#### Primary Tables
*   `MTL_CROSS_REFERENCES_VL`: the cross references with their type, reference value, description, unit of measure and descriptive flexfield attributes.
*   `MTL_SYSTEM_ITEMS_VL`: the items, with their concatenated segments and descriptions.
*   `MTL_PARAMETERS`: the organizations, used to identify the item master organization and the cross reference organization.
*   `MTL_ITEM_REVISIONS_B`: the item revisions referenced by a GTIN cross reference.
*   `ORG_ACCESS_VIEW`: the organizations the current responsibility can access.

#### Logical Relationships
1.  Each cross reference in `MTL_CROSS_REFERENCES_VL` is joined to its item in `MTL_SYSTEM_ITEMS_VL` on the inventory item identifier.
2.  The item's organization is joined to `MTL_PARAMETERS` and restricted to the master organization.
3.  The cross reference's own organization is outer joined to `MTL_PARAMETERS`, so organization independent references return no organization code.
4.  The revision is outer joined to `MTL_ITEM_REVISIONS_B` on the revision identifier.
5.  Rows are limited to items in organizations returned by `ORG_ACCESS_VIEW` for the current responsibility.

### Parameters & Filtering
*   **Upload Mode:** Selects Create, or Create and Update, which controls whether existing cross references are downloaded.
*   **Item:** Restricts the cross references to one item.
*   **Cross Reference Type:** Restricts the output to one cross reference type.
*   **Cross Reference:** Matches the reference value itself, for example a customer part number.
*   **Organization Code:** Restricts the output to references in one organization.

### Performance & Optimization
*   **Item Driven Joins:** Cross references join to the item view on a single identifier, so the item attributes are fetched once per reference.
*   **Responsibility Scope Filter:** The organization restriction uses the access view, so the extract covers only the organizations the user is allowed to maintain.
*   **Outer Joins for Scope:** Organization and revision joins are outer joins, so organization independent references and references without revisions are still returned.
*   **Flexfield Expansion:** Descriptive flexfield values are expanded through the flexfield value function, which decodes segment values for display.

### FAQ
**Q: How do I create a cross reference that applies to all organizations?**
A: Leave the Org column blank and set the Applicable To All Organizations flag to Yes for the row.

**Q: Why is my revision rejected for a customer cross reference?**
A: Revision and unit of measure apply only to the GTIN cross reference type. Entering them for any other type is rejected.

**Q: How do I remove a cross reference?**
A: Download the reference, enter Yes in the Delete Cross Reference column for that row, and upload the template.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-cross-reference-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-cross-reference-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-cross-reference-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-cross-reference-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-cross-reference-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-cross-reference-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-item-cross-reference-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
