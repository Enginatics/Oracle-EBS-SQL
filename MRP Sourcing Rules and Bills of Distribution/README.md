---
layout: default
title: 'MRP Sourcing Rules and Bills of Distribution | Oracle EBS SQL Report'
description: 'Sourcing rules for all or a selected assignment set, along with with the item''s make / buy flag and based on rollup flag for costing. You can either…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, MRP, Sourcing, Rules, Bills, mrp_sourcing_rules, mtl_parameters, mrp_sr_receipt_org_v'
permalink: /MRP%20Sourcing%20Rules%20and%20Bills%20of%20Distribution/
---

# MRP Sourcing Rules and Bills of Distribution – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/mrp-sourcing-rules-and-bills-of-distribution/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Sourcing rules for all or a selected assignment set, along with with the item's make / buy flag and based on rollup flag for costing. You can either choose Organization or Vendor (Supplier) sourcing rules or get all sourcing rules by not selecting a sourcing rule type.

## Report Parameters
Assignment Set, Assignment Type, Assignment Organization, Assignment Customer, Assignment Item Number, Assignment Category, Sourcing Rule Type, Sourcing Rule Name, Global Sourcing Rules, Sourcing Rule Organization, Receipt Organization, Active Receipt Orgs Only, Source Type, Source Organization, Source Supplier, Source Supplier Site, Category Set 1, Category Set 2

## Oracle EBS Tables Used
[mrp_sourcing_rules](https://www.enginatics.com/library/?pg=1&find=mrp_sourcing_rules), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mrp_sr_receipt_org_v](https://www.enginatics.com/library/?pg=1&find=mrp_sr_receipt_org_v), [mrp_sr_source_org_v](https://www.enginatics.com/library/?pg=1&find=mrp_sr_source_org_v), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [mrp_sr_assignments_v](https://www.enginatics.com/library/?pg=1&find=mrp_sr_assignments_v), [mtl_system_items_b](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b), [mrp_assignment_sets](https://www.enginatics.com/library/?pg=1&find=mrp_assignment_sets), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC New Items](/CAC%20New%20Items/ "CAC New Items Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs](/CAC%20Calculate%20ICP%20PII%20Item%20Costs/ "CAC Calculate ICP PII Item Costs Oracle EBS SQL Report"), [CAC Item vs. Component Include in Rollup Controls](/CAC%20Item%20vs-%20Component%20Include%20in%20Rollup%20Controls/ "CAC Item vs. Component Include in Rollup Controls Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [MRP Sourcing Rules and Bills of Distribution 10-Jun-2024 034927.xlsx](https://www.enginatics.com/example/mrp-sourcing-rules-and-bills-of-distribution/) |
| Blitz Report™ XML Import | [MRP_Sourcing_Rules_and_Bills_of_Distribution.xml](https://www.enginatics.com/xml/mrp-sourcing-rules-and-bills-of-distribution/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/mrp-sourcing-rules-and-bills-of-distribution/](https://www.enginatics.com/reports/mrp-sourcing-rules-and-bills-of-distribution/) |

## MRP Sourcing Rules and Bills of Distribution - Case Study & Technical Analysis

### Executive Summary
The **MRP Sourcing Rules and Bills of Distribution** report provides a comprehensive listing of the defined sourcing logic. It documents the supply chain network, showing how items are sourced (Make, Buy, Transfer) and from where.

### Business Challenge
Understanding the supply chain network requires visibility into the sourcing rules.
-   **Network Visualization:** "What is our current strategy for sourcing 'Electronics'? Are we single-sourced or dual-sourced?"
-   **Audit:** "Show me all rules where we are sourcing from 'Supplier X' so we can assess the impact of their bankruptcy."
-   **Validation:** "Do we have any rules where the allocation percentages don't add up to 100%?"

### Solution
The **MRP Sourcing Rules and Bills of Distribution** report lists the rules and their details.

**Key Features:**
-   **Rule Details:** Shows the name, description, and type (Sourcing Rule vs. Bill of Distribution).
-   **Source Logic:** Lists the sources (Supplier, Org), Ranks, and Allocation Percentages.
-   **Assignments (Optional):** Can optionally show which items or categories are assigned to these rules.

### Technical Architecture
The report queries the sourcing rule definition tables.

#### Key Tables and Views
-   **`MRP_SOURCING_RULES`**: The rule header.
-   **`MRP_SR_SOURCE_ORG_V`**: The details of the sources (Suppliers/Orgs).
-   **`MRP_SR_RECEIPT_ORG_V`**: The receiving organizations.
-   **`MRP_ASSIGNMENT_SETS`**: (If joined) shows where the rules are used.

#### Core Logic
1.  **Retrieval:** Selects rules based on parameters (Name, Organization).
2.  **Expansion:** Joins to the source details to show the specific suppliers or transfer origins.
3.  **Formatting:** Presents the data in a hierarchical or flat format for analysis.

### Business Impact
-   **Supply Chain Visibility:** Provides a clear map of the physical flow of goods through the supply chain.
-   **Risk Management:** Helps identify single points of failure (single-sourced items).
-   **Compliance:** Ensures that sourcing strategies are being implemented as designed in the system.


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
