---
layout: default
last_modified_at: 2026-10-16
title: 'FND Flex Value Hierarchy | Oracle EBS SQL Report'
description: 'Flexfield value hierarchy showing a hierarchical tree of parent and child relations and child ranges. Parameter ''Parents without Child only'' can be used…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Flex, Value, Hierarchy, fnd_flex_value_norm_hierarchy, fnd_flex_value_sets, fnd_flex_values'
permalink: /FND%20Flex%20Value%20Hierarchy/
report_name: 'FND Flex Value Hierarchy'
report_web_name: fnd-flex-value-hierarchy
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Flex Value Hierarchy – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-flex-value-hierarchy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-hierarchy) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-hierarchy).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Flexfield value hierarchy showing a hierarchical tree of parent and child relations and child ranges.
Parameter 'Parents without Child only' can be used to validate the hierarchy for nodes where the child range does not include a single child value.

The query is based on a treewalk through table fnd_flex_value_norm_hierarchy, which contains one record for every parent node, and a range_attribute column to indicate if the child value low/high range should match either parent nodes or child values.

While table fnd_flex_value_norm_hierarchy contains one record for each hierarchy node, table fnd_flex_value_hierarchies shows a flat representation of all hierarchy nodes and their lowest child ranges (range_attribute=C). For any lowest child range value, it contains one record for every higher hierarchy, that this child range is included in, up to the topmost hierarchy node. It can be used, for example, to validate directly if a child value is included in a specific higher level hierarchy node.

For GL flex value hierarchies, there are additional tables gl_seg_val_norm_hierarchy and gl_seg_val_hierarchies, which store one record for each matching child value for parent nodes, instead of just the range.
These tables are updated automatically after each flex value hierarchy change by concurrent 'General Ledger Accounting Setup Program' (GLSTFL).
gl_seg_val_norm_hierarchy stores one record for every child and their direct parent.
gl_seg_val_hierarchies stores one record for every node in the hierarchy (regardless if child or parent) and all their parent records, regardless on which level. It can be used, for example, to directly find all childs of one parent node.

Table gl_account_hierarchies stores the relation between summary template and detail code combination ids.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-hierarchy) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Flex Value Set, Hierarchy Start Value, Parents without Child only, Show Child Values

## Oracle EBS Tables Used
[fnd_flex_value_norm_hierarchy](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_norm_hierarchy&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-hierarchy), [fnd_flex_value_sets](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-hierarchy), [fnd_flex_values](https://www.enginatics.com/library/?pg=1&find=fnd_flex_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-hierarchy), [fnd_flex_values_vl](https://www.enginatics.com/library/?pg=1&find=fnd_flex_values_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-hierarchy), [fnd_flex_hierarchies_vl](https://www.enginatics.com/library/?pg=1&find=fnd_flex_hierarchies_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-hierarchy)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-hierarchy)

## Related Reports
[FND Flex Values](/FND%20Flex%20Values/ "FND Flex Values Oracle EBS SQL Report"), [FND Flex Value Upload](/FND%20Flex%20Value%20Upload/ "FND Flex Value Upload Oracle EBS SQL Report"), [FND Rollup Groups](/FND%20Rollup%20Groups/ "FND Rollup Groups Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Balance by Account Hierarchy](/GL%20Balance%20by%20Account%20Hierarchy/ "GL Balance by Account Hierarchy Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Flex%20Value%20Hierarchy/FND%20Flex%20Value%20Hierarchy.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-hierarchy) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Flex Value Hierarchy 03-Mar-2024 002741.xlsx](https://www.enginatics.com/example/fnd-flex-value-hierarchy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-hierarchy) |
| Blitz Report™ XML Import | [FND_Flex_Value_Hierarchy.xml](https://www.enginatics.com/xml/fnd-flex-value-hierarchy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-hierarchy) |
| SQL Source | [FND Flex Value Hierarchy.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Flex%20Value%20Hierarchy/FND%20Flex%20Value%20Hierarchy.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-flex-value-hierarchy/](https://www.enginatics.com/reports/fnd-flex-value-hierarchy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-hierarchy) |

## Executive Summary
The **FND Flex Value Hierarchy** report visualizes the parent-child relationships within your Chart of Accounts or other hierarchical value sets. It is essential for validating financial reporting structures (FSGs).

## Business Challenge
*   **FSG Troubleshooting:** Debugging why a financial report is missing data (often due to a new child value not being added to the parent range).
*   **Orphan Analysis:** Finding child values that are not included in any parent node.
*   **Structure Validation:** Ensuring that parent ranges do not overlap incorrectly.

## The Solution
This Blitz Report performs a tree-walk of the hierarchy:
*   **Tree Structure:** Shows the Parent -> Child relationship at multiple levels.
*   **Range Definition:** Displays the Low and High values for each parent node.
*   **Flattened View:** Can show a flattened list of all child values rolling up to a specific parent.

## Technical Architecture
The report uses `FND_FLEX_VALUE_NORM_HIERARCHY` for the range definitions and `FND_FLEX_VALUE_HIERARCHIES` for the compiled hierarchy.

## Parameters & Filtering
*   **Flex Value Set:** The specific segment (e.g., "Company" or "Account").
*   **Parents without Child only:** A powerful validation filter to find empty parent nodes.
*   **Show Child Values:** Toggle to expand ranges into individual child values.

## Performance & Optimization
*   **Recursion:** The report uses recursive SQL to walk the tree. For very deep hierarchies, it may take a moment to run.

## FAQ
*   **Q: Why doesn't my new account show up in the FSG?**
    *   A: Run this report for the parent value used in the FSG. If the new account falls outside the defined ranges, it won't be included.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-hierarchy)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-hierarchy)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-hierarchy)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-hierarchy)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-hierarchy)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-hierarchy)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-hierarchy)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
