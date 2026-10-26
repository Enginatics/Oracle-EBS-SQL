---
layout: default
last_modified_at: 2026-10-26
title: 'CST Supply Chain Indented Bills of Material Cost | Oracle EBS SQL Report'
description: 'This report is based on the (static) Oracle Supply Chain Indented Bills of Material Cost Report and merely sums up the available information from the Cost…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Management, BI Publisher, Enginatics, R12 only, CST, Supply, Chain, Indented, cst_sc_bom_structures, mtl_system_items_vl, mtl_item_categories'
permalink: /CST%20Supply%20Chain%20Indented%20Bills%20of%20Material%20Cost/
report_name: 'CST Supply Chain Indented Bills of Material Cost'
report_web_name: cst-supply-chain-indented-bills-of-material-cost
module: 'Cost Management'
module_url: /modules/cost-management/
---

# CST Supply Chain Indented Bills of Material Cost – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-supply-chain-indented-bills-of-material-cost/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost).
**Oracle EBS module:** [Cost Management](/modules/cost-management/ "Oracle EBS Cost Management reports") · [all Cost Management reports](/modules/cost-management/)  

## Overview
This report is based on the (static) Oracle Supply Chain Indented Bills of Material Cost Report and merely sums up the available information from the Cost Type.  It does not do a Cost Rollup and as a result, the "Extended Cost" column might not add up to the total item cost for the assembly especially  if changes have been made to the bills of material, routing or item costs, since the last cost rollup.  If this is the case, run a Supply Chain Cost Rollup in Pending or some other cost type (such as Current) for reporting purposes, to synchronize the cost information and then use this report, using the same cost type, to correctly report your item costs.

Imported from BI Publisher
Description: Supply Chain Indented Bills of Material Cost Report
Application: Bills of Material
Source: Supply Chain Indented Bills of Material Cost Report (XML)
Short Name: CSTRSCCRI_XML
DB package: BOM_CSTRSCCR_XMLP_PKG

-- |  Version   Modified on       Modified  by              Description
-- |  ======= ===========   ==============  =========================================
-- |  1.0            04-APR-2023    Eric Clegg               Initial Conversion
--|   1.1            24-DEC-2023   Eric Clegg               Added Multi-Select Item Parameter

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Cost Type, Organization, Assignment Set, Report Number of Levels, Exclude Level, Past Rollup, Effective Date, Include Inactive BOMs, Include Unimplemented ECOs, Alternate Bill, Engineering Bills, Item, Item From, Item To, Category set, Category From, Category To

## Oracle EBS Tables Used
[cst_sc_bom_structures](https://www.enginatics.com/library/?pg=1&find=cst_sc_bom_structures&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [bom_parameters](https://www.enginatics.com/library/?pg=1&find=bom_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [bom_inventory_components](https://www.enginatics.com/library/?pg=1&find=bom_inventory_components&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [cst_cost_elements](https://www.enginatics.com/library/?pg=1&find=cst_cost_elements&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [cst_sc_sourcing_rules](https://www.enginatics.com/library/?pg=1&find=cst_sc_sourcing_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [cst_organization_definitions](https://www.enginatics.com/library/?pg=1&find=cst_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [po_vendor_sites_all](https://www.enginatics.com/library/?pg=1&find=po_vendor_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost)

## Report Categories
[BI Publisher](https://www.enginatics.com/library/?pg=1&category%5B%5D=BI%20Publisher&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost)

## Related Reports
[INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Supply%20Chain%20Indented%20Bills%20of%20Material%20Cost/CST%20Supply%20Chain%20Indented%20Bills%20of%20Material%20Cost.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CST Supply Chain Indented Bills of Material Cost - Item Cost Detail 31-Oct-2023 055034 (1).xlsx](https://www.enginatics.com/example/cst-supply-chain-indented-bills-of-material-cost/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost) |
| Blitz Report™ XML Import | [CST_Supply_Chain_Indented_Bills_of_Material_Cost.xml](https://www.enginatics.com/xml/cst-supply-chain-indented-bills-of-material-cost/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost) |
| SQL Source | [CST Supply Chain Indented Bills of Material Cost.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Supply%20Chain%20Indented%20Bills%20of%20Material%20Cost/CST%20Supply%20Chain%20Indented%20Bills%20of%20Material%20Cost.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cst-supply-chain-indented-bills-of-material-cost/](https://www.enginatics.com/reports/cst-supply-chain-indented-bills-of-material-cost/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost) |

## Case Study & Technical Analysis: CST Supply Chain Indented Bills of Material Cost

### Executive Summary
The **CST Supply Chain Indented Bills of Material Cost** report is the "Blueprints with Price Tags" for manufacturing finance. It provides a hierarchical view of an assembly's cost structure, exploding the Bill of Material (BOM) level by level to show exactly how the final cost is built up.
Unlike a flat "Item Cost" report, this report preserves the parent-child relationships, allowing users to see not just *that* an assembly costs $100, but that $40 came from Sub-Assembly A (which in turn has $20 of raw material and $20 of labor).

### Business Challenge
Understanding the cost of a complex product (like a car or a server) is difficult because the costs are buried in layers of sub-assemblies.
*   **The "Black Box" Assembly:** If a top-level assembly cost increases by 5%, where did it come from? A raw material price hike at Level 4? A routing change at Level 2?
*   **Supply Chain Complexity:** In a multi-org environment, Sub-Assembly A might be manufactured in Plant 1 and shipped to Plant 2. The cost at Plant 2 includes the manufacturing cost at Plant 1 plus freight and transfer charges.
*   **Make vs. Buy Analysis:** To decide whether to outsource a sub-assembly, you need to know its full "rolled-up" cost, including all lower-level components and value-added activities.

### The Solution
This report visualizes the "Cost Rollup" results in a tree structure.
*   **Indented Visualization:** It uses indentation (Level 1, .Level 2, ..Level 3) to represent the BOM depth. This makes it easy to trace a cost component from the bottom of the structure to the top.
*   **Supply Chain Awareness:** It leverages the Supply Chain Cost Rollup tables (`CST_SC_BOM_STRUCTURES`), which means it understands cross-organization sourcing rules. If Item X is sourced from Org Y, the report follows that path.
*   **Detailed Cost Elements:** For each component at every level, it breaks down the cost into:
    *   **Material:** The cost of the component itself.
    *   **Resource/Overhead:** The value added at that specific step.
    *   **Extended Cost:** `Quantity per Assembly * Unit Cost`, showing the total contribution of that component to the parent.

### Technical Architecture (High Level)
The query is based on the output of the Oracle Supply Chain Cost Rollup engine.
*   **`CST_SC_BOM_STRUCTURES`:** This is the core table. When you run a Supply Chain Cost Rollup, Oracle populates this table with the exploded BOM structure. The report queries this table using the `Rollup ID` generated by that process.
*   **Static vs. Dynamic:** As noted in the description, this report is *static*. It reads the snapshot taken during the last cost rollup. It does *not* re-calculate costs based on the current live BOM. This is a critical distinction for users: if you change a BOM today, you must run a Cost Rollup before this report will reflect the change.
*   **CTE Structure:**
    *   `q_assembly`: Fetches the top-level item details.
    *   `q_components`: Fetches the exploded children from `CST_SC_BOM_STRUCTURES`.
    *   `q_cost_details`: Joins to `CST_ITEM_COST_DETAILS` to get the granular cost element breakdown for each component.

### Parameters & Filtering
*   **Cost Type:** The cost set to report (e.g., "Frozen", "Pending").
*   **Rollup ID / Assignment Set:** Identifies the specific cost rollup run to analyze.
*   **Report Number of Levels:** Limits the depth of the explosion (e.g., show only top 3 levels).
*   **Effective Date:** Used to filter BOM components based on effectivity.

### Performance & Optimization
*   **Pre-Calculated Structure:** Because the heavy lifting of exploding the BOM is done by the C++ Cost Rollup engine (and stored in `CST_SC_BOM_STRUCTURES`), this report is relatively fast compared to a query that tries to walk the `BOM_INVENTORY_COMPONENTS` tree recursively in real-time.
*   **Indexed Access:** The query relies heavily on `ROLLUP_ID`, which is indexed, ensuring efficient retrieval of the specific rollup data.

### FAQ
**Q: Why doesn't the "Extended Cost" add up to the "Item Cost"?**
A: This usually happens if the BOM or Item Costs have changed *after* the last Cost Rollup was run. Since the report reads the static rollup structure but might join to current item details (depending on the exact join logic), discrepancies can occur. Always run a fresh Cost Rollup before running this report for accurate analysis.

**Q: Can I see costs for a specific Department?**
A: Yes, the report joins to `BOM_DEPARTMENTS` and `BOM_RESOURCES`, allowing you to see the resource costs contributed by specific work centers.

**Q: What is "Phantom" logic?**
A: A "Phantom" assembly is a non-stocked sub-assembly that is built transiently. The report respects the `Phantom Flag`, typically blowing through the phantom level to show the underlying components directly attached to the parent.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-supply-chain-indented-bills-of-material-cost)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
