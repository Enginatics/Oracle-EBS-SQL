---
layout: default
last_modified_at: 2026-10-26
title: 'INV Items | Oracle EBS SQL Report'
description: 'Master data report that lists item master attributes such as item type, UOM, status, serial control, account numbers and various other attributes. Item…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Inventory, Enginatics, INV, Items, mtl_item_catalog_groups_b_kfv, mtl_item_status_vl, mtl_units_of_measure_tl'
permalink: /INV%20Items/
report_name: 'INV Items'
report_web_name: inv-items
module: 'Inventory'
module_url: /modules/inventory/
---

# INV Items – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-items/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items).
**Oracle EBS module:** [Inventory](/modules/inventory/ "Oracle EBS Inventory reports") · [all Inventory reports](/modules/inventory/)  

## Overview
Master data report that lists item master attributes such as item type, UOM, status, serial control, account numbers and various other attributes.

Item Cost is the item's cost in the cost type of the organization's primary cost method. Item Cost and List Price are in the organization's ledger Currency.

Sourcing Supplier is the supplier and site that Oracle's sourcing routine selects from the Sourcing Assignment Set: the most specific assignment (item and organization, item, category, organization, global) first, then the highest allocation percent and the lowest rank, skipping suppliers the approved supplier list does not allow for sourcing. The site is the one the sourcing rule names, which can belong to a different operating unit from the organization's.

An item with several manufacturer part numbers is listed once per part number.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Item, Item Description, Item Type, BOM Item Type, Exclude Item Type, Contract Item Type, Item Status, Buyer, Planner, Category Set 1, Category Set 2, Category Set 3, Category Set, Category, Last Update Date From, Last Update Date To, Last Updated By, Creation Date From, Creation Date To, Created By, Cross Reference Type, Cross Reference, Master only, Sourcing Assignment Set, DFF Display

## Oracle EBS Tables Used
[mtl_item_catalog_groups_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_catalog_groups_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [mtl_units_of_measure_tl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [mtl_actions](https://www.enginatics.com/library/?pg=1&find=mtl_actions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [mtl_grades](https://www.enginatics.com/library/?pg=1&find=mtl_grades&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [mtl_material_statuses](https://www.enginatics.com/library/?pg=1&find=mtl_material_statuses&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [per_people_x](https://www.enginatics.com/library/?pg=1&find=per_people_x&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [mrp_item_sourcing_levels_v](https://www.enginatics.com/library/?pg=1&find=mrp_item_sourcing_levels_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [mrp_assignment_sets](https://www.enginatics.com/library/?pg=1&find=mrp_assignment_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [po_approved_supplier_list](https://www.enginatics.com/library/?pg=1&find=po_approved_supplier_list&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [po_asl_status_rules](https://www.enginatics.com/library/?pg=1&find=po_asl_status_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [po_un_numbers](https://www.enginatics.com/library/?pg=1&find=po_un_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [po_hazard_classes](https://www.enginatics.com/library/?pg=1&find=po_hazard_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [fa_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=fa_categories_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [rcv_routing_headers](https://www.enginatics.com/library/?pg=1&find=rcv_routing_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [mtl_planners](https://www.enginatics.com/library/?pg=1&find=mtl_planners&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [mtl_atp_rules](https://www.enginatics.com/library/?pg=1&find=mtl_atp_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [wms_rules_vl](https://www.enginatics.com/library/?pg=1&find=wms_rules_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [mtl_uom_conversions](https://www.enginatics.com/library/?pg=1&find=mtl_uom_conversions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [ra_rules](https://www.enginatics.com/library/?pg=1&find=ra_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [ra_terms_vl](https://www.enginatics.com/library/?pg=1&find=ra_terms_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [oks_coverage_templts_v](https://www.enginatics.com/library/?pg=1&find=oks_coverage_templts_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [csi_item_instances](https://www.enginatics.com/library/?pg=1&find=csi_item_instances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [cs_ctr_associations](https://www.enginatics.com/library/?pg=1&find=cs_ctr_associations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [cs_counter_groups](https://www.enginatics.com/library/?pg=1&find=cs_counter_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [mtl_mfg_part_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_mfg_part_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [mtl_manufacturers](https://www.enginatics.com/library/?pg=1&find=mtl_manufacturers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items)

## Related Reports
[INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [INV Onhand Quantities](/INV%20Onhand%20Quantities/ "INV Onhand Quantities Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Items/INV%20Items.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Items 23-Jul-2025 025320.xlsx](https://www.enginatics.com/example/inv-items/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items) |
| Blitz Report™ XML Import | [INV_Items.xml](https://www.enginatics.com/xml/inv-items/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items) |
| SQL Source | [INV Items.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Items/INV%20Items.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-items/](https://www.enginatics.com/reports/inv-items/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items) |

## Case Study & Technical Analysis: INV Items Report

### Executive Summary

The INV Items report is a comprehensive master data extraction tool that provides a detailed, attribute-level view of the entire Oracle E-Business Suite item master. It serves as the primary report for auditing, analyzing, and exporting item information for business intelligence, reporting, and as a data source for mass update activities. With its extensive filtering capabilities, it empowers users to quickly access the specific item data they need in a clean, Excel-ready format.

### Business Challenge

Accessing and analyzing item master data directly within Oracle EBS presents significant hurdles for business users and data analysts. The standard forms-based interface is not designed for mass data review or extraction. Key challenges include:

-   **Lack of Holistic View:** The Oracle forms only show one item at a time, making it impossible to compare attributes across thousands of items or get a high-level view of the item master's configuration.
-   **Inefficient Data Extraction:** Standard Oracle reporting tools for extracting item data can be slow, cumbersome to use, and often produce output (like XML) that requires significant re-formatting before it can be used in Excel.
-   **Difficulty in Auditing:** Auditing the item master for consistency and accuracy is a major challenge without a simple way to extract the data and analyze it with external tools like Excel or other BI platforms.
-   **Preparing for Updates:** Before performing a mass update, it is critical to extract the current state of the data. This is often a difficult first step that can delay important data maintenance projects.

### The Solution

The INV Items report provides a fast, flexible, and direct solution to these challenges, making item master data accessible to all users.

-   **Comprehensive Data Extraction:** The report pulls all key item attributes into a single, well-structured output, providing a complete picture of each item's configuration, from purchasing and planning to costing and shipping.
-   **Powerful Filtering:** An extensive list of parameters allows users to precisely target the items they need, filtering by status, type, buyer, planner, category, creation date, and many other attributes.
-   **Direct to Excel:** By leveraging the Blitz Report framework, the report sends data directly to Excel, providing an immediately usable file for analysis, pivot tables, or as a starting point for an upload using the INV Item Upload tool.
-   **Enables Data Governance:** The report is a fundamental tool for data stewards to regularly audit the item master, identify inconsistencies, and enforce data standards across the organization.

### Technical Architecture (High Level)

The report is built on a direct, optimized SQL query that joins the core item master tables to provide a rich, detailed dataset.

-   **Primary Tables Involved:**
    -   `mtl_system_items_vl` (the central view for item master attributes)
    -   `mtl_item_categories` and `mtl_category_sets` (for item category assignments)
    -   `per_people_x` (to retrieve names for buyers and planners)
    -   `gl_code_combinations_kfv` (to show the descriptive flexfields for accounting codes)
    -   `mtl_parameters` (for organization-level settings)
-   **Logical Relationships:** The report is centered around `mtl_system_items_vl` and enriches the core item data by joining out to various other tables to provide user-friendly information, such as category names and planner details, instead of just internal IDs.

### Parameters & Filtering

The report's strength lies in its wide array of parameters that allow for highly specific data extraction:

-   **Item Selection:** Filter by Item number, description, type, status, and more.
-   **Personnel:** Narrow down results by specific Buyers or Planners.
-   **Categorization:** Select items based on their assignment to up to three different Category Sets.
-   **Date Ranges:** Filter for items created or updated within a specific time period.
-   **Show DFF Attributes:** A key parameter that allows users to include data from configured Descriptive Flexfields in the report output.

### Performance & Optimization

The report is engineered for speed and efficiency, even when extracting large volumes of data.

-   **Direct SQL Query:** The report queries the database tables directly, avoiding the significant performance overhead of middleware or XML/XSLT processing layers found in tools like BI Publisher.
-   **Indexed Access:** The query is designed to make optimal use of the standard Oracle indexes on the `mtl_system_items_b` table, ensuring fast retrieval of the selected data.

### FAQ

**1. How does this report differ from the standard Oracle 'Item Definition Detail' report?**
   While both reports show item details, this INV Items report is designed for mass data extraction and analysis with its extensive filtering and direct-to-Excel output. The standard Oracle report is typically run for a single item or a small range and is not optimized for exporting and analyzing thousands of records at once.

**2. Can I add our company's specific item attributes (Descriptive Flexfields) to the report?**
   Yes. The report includes a parameter, "Show DFF Attributes," which, when enabled, will dynamically include the Descriptive Flexfield columns in the output, making it easy to report on your company-specific data.

**3. Is it possible to use the output of this report to perform a mass update?**
   Absolutely. This report is the perfect companion to the `INV Item Upload` tool. You can use this report to filter and download the specific items you want to update, make your changes in the resulting Excel file, and then use that file as the input for the upload tool.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-items)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
