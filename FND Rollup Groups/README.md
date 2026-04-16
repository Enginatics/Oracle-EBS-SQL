---
layout: default
title: 'FND Rollup Groups | Oracle EBS SQL Report'
description: 'Flex value sets with rollup groups (FND Flex Hierarchies) – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Rollup, Groups, fnd_flex_values, fnd_flex_value_sets, fnd_flex_hierarchies_vl'
permalink: /FND%20Rollup%20Groups/
---

# FND Rollup Groups – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-rollup-groups/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Flex value sets with rollup groups (FND Flex Hierarchies)

## Report Parameters
Flex Value Set, Rollup Group

## Oracle EBS Tables Used
[fnd_flex_values](https://www.enginatics.com/library/?pg=1&find=fnd_flex_values), [fnd_flex_value_sets](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_sets), [fnd_flex_hierarchies_vl](https://www.enginatics.com/library/?pg=1&find=fnd_flex_hierarchies_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Flex Value Hierarchy](/FND%20Flex%20Value%20Hierarchy/ "FND Flex Value Hierarchy Oracle EBS SQL Report"), [FND Flex Values](/FND%20Flex%20Values/ "FND Flex Values Oracle EBS SQL Report"), [FND Flex Value Upload](/FND%20Flex%20Value%20Upload/ "FND Flex Value Upload Oracle EBS SQL Report"), [FND Flex Hierarchies (Rollup Groups)](/FND%20Flex%20Hierarchies%20%28Rollup%20Groups%29/ "FND Flex Hierarchies (Rollup Groups) Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Rollup Groups 25-Sep-2025 104414.xlsx](https://www.enginatics.com/example/fnd-rollup-groups/) |
| Blitz Report™ XML Import | [FND_Rollup_Groups.xml](https://www.enginatics.com/xml/fnd-rollup-groups/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-rollup-groups/](https://www.enginatics.com/reports/fnd-rollup-groups/) |

## Executive Summary
The **FND Rollup Groups** report lists Flex Value Sets that utilize rollup groups, which are used to define summary relationships (hierarchies) for segment values. This is essential for financial reporting and other processes that rely on parent-child relationships within chart of accounts or other flexfields.

## Business Challenge
In General Ledger and other modules, "Parent" values are used to sum up "Child" values for reporting (e.g., a "Total Assets" parent account summing up individual asset accounts). These relationships are defined using Rollup Groups and Hierarchies. Verifying that these groups are defined correctly and assigned to the right value sets is crucial for accurate financial consolidation and reporting.

## The Solution
This report provides a configuration audit of Rollup Groups. It allows administrators to:
- Identify which value sets have hierarchy structures enabled.
- Verify the names and codes of defined rollup groups.
- Ensure consistency in hierarchy definitions across different value sets.

## Technical Architecture
The report joins `fnd_flex_value_sets` with `fnd_flex_hierarchies_vl` and `fnd_flex_values` to display the configuration of rollup groups.

## Parameters & Filtering
- **Flex Value Set:** Filter by the specific value set (e.g., 'Operations Account').
- **Rollup Group:** Filter by a specific rollup group name.

## Performance & Optimization
This is a lightweight configuration report and typically runs very quickly.

## FAQ
**Q: What is a Rollup Group?**
A: A Rollup Group is a tag used to identify a group of parent values in a value set. It allows you to perform summary reporting based on that level of the hierarchy.

**Q: Does this report show the parent-child value assignments?**
A: No, this report shows the definition of the groups themselves. To see the actual hierarchy of values (which child belongs to which parent), use the **FND Flex Value Hierarchy** report.


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
