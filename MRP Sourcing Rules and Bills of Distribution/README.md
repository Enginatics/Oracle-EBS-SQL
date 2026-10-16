---
layout: default
last_modified_at: 2026-10-16
title: 'MRP Sourcing Rules and Bills of Distribution | Oracle EBS SQL Report'
description: 'Sourcing rules for all or a selected assignment set, along with with the item''s make / buy flag and based on rollup flag for costing. You can either…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Master Scheduling/MRP, Enginatics, MRP, Sourcing, Rules, Bills, mrp_sourcing_rules, mtl_parameters, mrp_sr_receipt_org_v'
permalink: /MRP%20Sourcing%20Rules%20and%20Bills%20of%20Distribution/
report_name: 'MRP Sourcing Rules and Bills of Distribution'
report_web_name: mrp-sourcing-rules-and-bills-of-distribution
module: 'Master Scheduling/MRP'
module_url: /modules/master-scheduling-mrp/
---

# MRP Sourcing Rules and Bills of Distribution – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/mrp-sourcing-rules-and-bills-of-distribution/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution).
**Oracle EBS module:** [Master Scheduling/MRP](/modules/master-scheduling-mrp/ "Oracle EBS Master Scheduling/MRP reports") · [all Master Scheduling/MRP reports](/modules/master-scheduling-mrp/)  

## Overview
Sourcing rules for all or a selected assignment set, along with with the item's make / buy flag and based on rollup flag for costing. You can either choose Organization or Vendor (Supplier) sourcing rules or get all sourcing rules by not selecting a sourcing rule type.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Assignment Set, Assignment Type, Assignment Organization, Assignment Customer, Assignment Item Number, Assignment Category, Sourcing Rule Type, Sourcing Rule Name, Global Sourcing Rules, Sourcing Rule Organization, Receipt Organization, Active Receipt Orgs Only, Source Type, Source Organization, Source Supplier, Source Supplier Site, Category Set 1, Category Set 2

## Oracle EBS Tables Used
[mrp_sourcing_rules](https://www.enginatics.com/library/?pg=1&find=mrp_sourcing_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution), [mrp_sr_receipt_org_v](https://www.enginatics.com/library/?pg=1&find=mrp_sr_receipt_org_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution), [mrp_sr_source_org_v](https://www.enginatics.com/library/?pg=1&find=mrp_sr_source_org_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution), [mrp_sr_assignments_v](https://www.enginatics.com/library/?pg=1&find=mrp_sr_assignments_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution), [mtl_system_items_b](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution), [mrp_assignment_sets](https://www.enginatics.com/library/?pg=1&find=mrp_assignment_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution)


## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/MRP%20Sourcing%20Rules%20and%20Bills%20of%20Distribution/MRP%20Sourcing%20Rules%20and%20Bills%20of%20Distribution.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [MRP Sourcing Rules and Bills of Distribution 10-Jun-2024 034927.xlsx](https://www.enginatics.com/example/mrp-sourcing-rules-and-bills-of-distribution/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution) |
| Blitz Report™ XML Import | [MRP_Sourcing_Rules_and_Bills_of_Distribution.xml](https://www.enginatics.com/xml/mrp-sourcing-rules-and-bills-of-distribution/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution) |
| SQL Source | [MRP Sourcing Rules and Bills of Distribution.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/MRP%20Sourcing%20Rules%20and%20Bills%20of%20Distribution/MRP%20Sourcing%20Rules%20and%20Bills%20of%20Distribution.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/mrp-sourcing-rules-and-bills-of-distribution/](https://www.enginatics.com/reports/mrp-sourcing-rules-and-bills-of-distribution/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-sourcing-rules-and-bills-of-distribution)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
