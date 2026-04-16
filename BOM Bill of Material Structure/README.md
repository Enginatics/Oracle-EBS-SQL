---
layout: default
title: 'BOM Bill of Material Structure | Oracle EBS SQL Report'
description: 'Description: Bill of Material Structure Report Provides equivalent functionality to the the following standard reports: - Bill of Material Structure…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, BOM, Bill, Material, Structure, hr_all_organization_units_vl, mtl_item_categories, mtl_categories_b_kfv'
permalink: /BOM%20Bill%20of%20Material%20Structure/
---

# BOM Bill of Material Structure – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/bom-bill-of-material-structure/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Description: Bill of Material Structure Report

Provides equivalent functionality to the the following standard reports:
- Bill of Material Structure Report
  (Template 'Bill of Material Structure Report' with parameter 'Bills with Loop Errors Only' = No)
- Bill of Material Loop Report
  (Template Bill of Material Structure Report with parameter 'Bills with Loop Errors Only' = Yes)
- Consolidated Bills of Material Report
  (Template 'Consolidated Bill of Material Report')

Application: Bills of Material
Source: Bill of Material Structure Report GUI (XML)
Short Name: BOMRBOMSG_XML
DB package: BOM_BOMRBOMS_XMLP_PKG

## Report Parameters
All Organizations, Organization Hierarchy, Assembly Item, Assembly Item From, Assembly Item To, Alternate Selection, Alternate, Revision, Date, Category Set, Categories From, Categories To, Levels to Explode, Implemented Only, Display Option, Explosion Quantity, Show Substitute Components, Use Planning Percent, Bills with Loop Errors Only, Show Assembly DFF, Show Assembly Item DFF, Show Component DFF, Show Component Item DFF

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories), [mtl_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b_kfv), [bom_dependent_desc_elements](https://www.enginatics.com/library/?pg=1&find=bom_dependent_desc_elements), [bom_explosion_temp](https://www.enginatics.com/library/?pg=1&find=bom_explosion_temp), [bom_bill_of_materials](https://www.enginatics.com/library/?pg=1&find=bom_bill_of_materials), [bom_lists](https://www.enginatics.com/library/?pg=1&find=bom_lists), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_revisions_b](https://www.enginatics.com/library/?pg=1&find=mtl_item_revisions_b), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [bom_alternate_designators](https://www.enginatics.com/library/?pg=1&find=bom_alternate_designators), [bom_ref_designators_view](https://www.enginatics.com/library/?pg=1&find=bom_ref_designators_view), [bom_explosion_view](https://www.enginatics.com/library/?pg=1&find=bom_explosion_view), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv), [bom_components_b](https://www.enginatics.com/library/?pg=1&find=bom_components_b), [mtl_system_items_b](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b), [mtl_default_category_sets](https://www.enginatics.com/library/?pg=1&find=mtl_default_category_sets), [bom_sub_components_view](https://www.enginatics.com/library/?pg=1&find=bom_sub_components_view), [q_assemblies](https://www.enginatics.com/library/?pg=1&find=q_assemblies), [q_components](https://www.enginatics.com/library/?pg=1&find=q_components), [q_subst_comp](https://www.enginatics.com/library/?pg=1&find=q_subst_comp)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [BOM Bill of Material Structure - Bill of Material Structure Report 10-Oct-2025 143544.xlsx](https://www.enginatics.com/example/bom-bill-of-material-structure/) |
| Blitz Report™ XML Import | [BOM_Bill_of_Material_Structure.xml](https://www.enginatics.com/xml/bom-bill-of-material-structure/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/bom-bill-of-material-structure/](https://www.enginatics.com/reports/bom-bill-of-material-structure/) |

## BOM Bill of Material Structure - Case Study & Technical Analysis

### Executive Summary
The **BOM Bill of Material Structure** report is the blueprint of manufacturing and engineering within Oracle EBS. It provides a hierarchical representation of product structures, detailing every component, sub-assembly, and raw material required to build a finished good. This report is indispensable for production planning, cost estimation, and maintaining accurate product definitions.

### Business Challenge
Manufacturing and Engineering teams often struggle with:
*   **Complexity:** Visualizing multi-level BOMs (indented bills) to understand deep dependencies.
*   **Accuracy:** Ensuring that the "As-Built" or "As-Planned" structure matches the engineering documentation.
*   **Change Management:** Tracking component changes across different BOM versions and effectivity dates.
*   **Costing Errors:** Incorrect BOM structures leading to wrong standard costs and inventory valuation issues.

### Solution
This report offers a flexible, multi-level explosion of the Bill of Materials. It empowers users to:
*   **Visualize Hierarchy:** See the full indented structure of an assembly, level by level.
*   **Manage Effectivity:** Filter components based on "Effectivity Date" to see what is valid for a specific production run.
*   **Handle Alternates:** View primary and alternate BOMs to support different manufacturing processes.
*   **Audit Components:** Verify component quantities, yield factors, and supply types (Push, Pull, Phantom).

### Technical Architecture
The report utilizes the Oracle BOM explosion logic to traverse the parent-child relationships defined in the database.

#### Key Tables & Views
| Table Name | Description |
| :--- | :--- |
| `BOM_BILL_OF_MATERIALS` | Stores the header information for a BOM (Assembly Item, Organization). |
| `BOM_INVENTORY_COMPONENTS` | Stores the components (children) for each bill, including quantity and effectivity. |
| `MTL_SYSTEM_ITEMS_B` | Defines the items (Assemblies and Components) and their attributes. |
| `BOM_EXPLOSION_TEMP` | A temporary table often used by system reports to store the results of the BOM explosion processor. |
| `BOM_STRUCTURES_B` | (R12) The underlying table for BOM headers, replacing some legacy views. |

#### Core Logic
1.  **BOM Explosion:** The report logic mimics the "BOM Explosion" process, starting from the top-level Assembly and recursively finding components.
2.  **Effectivity Filtering:** It applies `Effectivity Date` and `Disable Date` filters to ensure only currently active components are listed (unless "All" is requested).
3.  **Organization Context:** BOMs are organization-specific. The query ensures data is pulled for the correct manufacturing organization.
4.  **Item Details:** It joins to `MTL_SYSTEM_ITEMS` to retrieve descriptions, item statuses, and units of measure.

### FAQ
**Q: Can this report show "Phantom" assemblies?**
A: Yes, the report displays the supply type of components, allowing you to identify Phantoms, Assembly Pull, or Operation Pull items.

**Q: Does it support "Alternate" BOMs?**
A: Yes, the `Alternate Selection` parameter allows you to choose specific alternates or view the primary BOM.

**Q: How many levels deep can it go?**
A: The `Levels to Explode` parameter allows you to control the depth, from a single level to a full multi-level explosion.

**Q: Does it show component substitutes?**
A: Yes, there is a parameter `Show Substitute Components` to include valid substitutes defined for the BOM components.


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
