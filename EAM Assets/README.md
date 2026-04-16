---
layout: default
title: 'EAM Assets | Oracle EBS SQL Report'
description: 'Enterprise asset management asset details such as location, department etc. – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, EAM, Assets, hz_party_sites, ap_supplier_sites_all, mtl_parameters'
permalink: /EAM%20Assets/
---

# EAM Assets – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/eam-assets/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Enterprise asset management asset details such as location, department etc.

## Report Parameters
Organization Code, Department, Asset Group, Asset Number

## Oracle EBS Tables Used
[hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [csi_item_instances](https://www.enginatics.com/library/?pg=1&find=csi_item_instances), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv), [eam_org_maint_defaults](https://www.enginatics.com/library/?pg=1&find=eam_org_maint_defaults), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments), [mtl_eam_locations](https://www.enginatics.com/library/?pg=1&find=mtl_eam_locations), [mtl_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b_kfv), [csi_i_assets](https://www.enginatics.com/library/?pg=1&find=csi_i_assets), [fa_additions_b](https://www.enginatics.com/library/?pg=1&find=fa_additions_b), [pn_locations_all](https://www.enginatics.com/library/?pg=1&find=pn_locations_all), [mtl_serial_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_serial_numbers), [mtl_object_genealogy](https://www.enginatics.com/library/?pg=1&find=mtl_object_genealogy), [mtl_system_items_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b_kfv), [eam_failure_set_associations](https://www.enginatics.com/library/?pg=1&find=eam_failure_set_associations), [eam_failure_sets](https://www.enginatics.com/library/?pg=1&find=eam_failure_sets), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[EAM Weekly Schedule](/EAM%20Weekly%20Schedule/ "EAM Weekly Schedule Oracle EBS SQL Report"), [EAM Work Orders](/EAM%20Work%20Orders/ "EAM Work Orders Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [EAM Assets 28-Jul-2020 182205.xlsx](https://www.enginatics.com/example/eam-assets/) |
| Blitz Report™ XML Import | [EAM_Assets.xml](https://www.enginatics.com/xml/eam-assets/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/eam-assets/](https://www.enginatics.com/reports/eam-assets/) |


## Case Study & Technical Analysis: EAM Assets

### Executive Summary
The **EAM Assets** report is the master registry for the Enterprise Asset Management module. It provides a comprehensive view of the physical assets being maintained, linking the operational view (Maintenance) with the financial view (Fixed Assets) and the logistical view (Inventory).
This report is essential for:
1.  **Asset Registry Audits:** Verifying that all physical equipment is correctly registered in the system with the right attributes.
2.  **Location Tracking:** Identifying exactly where assets are located, whether in a subinventory, a specific area, or at a vendor site.
3.  **Hierarchy Analysis:** Understanding the parent-child relationships between assets (e.g., a Motor belonging to a Pump belonging to a Processing Line).

### Business Challenge
Managing a large asset fleet involves coordinating data across multiple domains.
*   **The "Ghost Asset" Problem:** Assets might exist on the floor but not in the system, or vice versa.
*   **Data Disconnects:** The Maintenance team knows the asset as "Pump-101", while Finance knows it as "FA-55432". Without a report linking `CSI_ITEM_INSTANCES` to `FA_ADDITIONS`, these two worlds remain separate.
*   **Location Complexity:** Assets move. They go to repair depots (Vendor Sites), move between buildings (HZ Locations), or sit in inventory. A simple "Location" field isn't enough; the system uses a complex polymorphic location logic.

### The Solution
This report flattens the complex EAM data model into a single, readable row per asset.
*   **Unified Identity:** It displays the Asset Number (Instance Number), the Asset Group (Inventory Item), and the Fixed Asset Number side-by-side.
*   **Polymorphic Location Logic:** It intelligently decodes the `LOCATION_TYPE_CODE`.
    *   If the asset is at a street address (`HZ_LOCATIONS`), it formats the address fields.
    *   If it's an internal HR location, it pulls from `HR_LOCATIONS_ALL`.
    *   If it's at a vendor, it resolves the Vendor Site address.
*   **Operational Context:** It includes the "Owning Department" (who pays for the maintenance) and the "Accounting Class" (how costs are categorized), which are critical for work order generation.

### Technical Architecture (High Level)
The query is built around `CSI_ITEM_INSTANCES` (the Install Base), which is the repository for EAM assets in R12.
*   **Core Join:** `CSI_ITEM_INSTANCES` (cii) joins to `MTL_SYSTEM_ITEMS_VL` (msiv) to get the Asset Group definition.
*   **Hierarchy Logic:** It joins to `MTL_OBJECT_GENEALOGY` (via subquery or direct join logic depending on the version) to find the `Parent_Asset_Number`.
*   **Fixed Asset Link:** It joins to `CSI_I_ASSETS` and `FA_ADDITIONS_B` to bridge the gap to the Fixed Assets module.
*   **Maintenance Defaults:** It joins to `EAM_ORG_MAINT_DEFAULTS` to fetch the Department and Area, which are specific EAM attributes not found on the standard item instance.

### Parameters & Filtering
*   **Organization Code:** The maintenance organization.
*   **Asset Group/Number:** Specific assets to target.
*   **Department:** Filter by the owning department (e.g., "Show me all assets owned by Facilities").

### Performance & Optimization
*   **Inline Views:** The query uses an inline view for `CSI_ITEM_INSTANCES` to pre-filter by organization security (`ORG_ACCESS_VIEW`) and resolve the polymorphic `Location_ID` before joining to the heavy address tables.
*   **Date Filtering:** It strictly filters for active assets (`sysdate between active_start_date and active_end_date`) to avoid reporting retired or scrapped equipment.

### FAQ
**Q: Why is the "Fixed Asset Number" blank?**
A: Not all EAM assets are capitalized Fixed Assets (e.g., small tools). Also, the link might not have been established in the "Asset Numbers" form.

**Q: What is the difference between "Asset Group" and "Asset Number"?**
A: The "Asset Group" is the *type* of asset (e.g., "Ford F-150 Truck"). The "Asset Number" is the specific instance (e.g., "Truck #44, License Plate XYZ"). In Oracle, the Group is an Inventory Item, and the Number is a Serial Number/Instance.

**Q: Why do I see "HZ_LOCATIONS" in the raw data?**
A: This is the internal code for the Trading Community Architecture (TCA) location model, used for external addresses. The report decodes this into a readable address string.


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
