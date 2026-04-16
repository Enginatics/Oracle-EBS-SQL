---
layout: default
title: 'FND Flex Hierarchies (Rollup Groups) | Oracle EBS SQL Report'
description: 'Flex value sets with rollup groups – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Flex, Hierarchies, (Rollup, fnd_flex_value_sets, fnd_flex_hierarchies_vl'
permalink: /FND%20Flex%20Hierarchies%20%28Rollup%20Groups%29/
---

# FND Flex Hierarchies (Rollup Groups) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-flex-hierarchies-rollup-groups/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Flex value sets with rollup groups

## Report Parameters


## Oracle EBS Tables Used
[fnd_flex_value_sets](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_sets), [fnd_flex_hierarchies_vl](https://www.enginatics.com/library/?pg=1&find=fnd_flex_hierarchies_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Rollup Groups](/FND%20Rollup%20Groups/ "FND Rollup Groups Oracle EBS SQL Report"), [FND Flex Value Hierarchy](/FND%20Flex%20Value%20Hierarchy/ "FND Flex Value Hierarchy Oracle EBS SQL Report"), [FND Flex Values](/FND%20Flex%20Values/ "FND Flex Values Oracle EBS SQL Report"), [FND Flex Value Upload](/FND%20Flex%20Value%20Upload/ "FND Flex Value Upload Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report"), [FA Asset Retirements](/FA%20Asset%20Retirements/ "FA Asset Retirements Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [ONT System Parameters](/ONT%20System%20Parameters/ "ONT System Parameters Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/fnd-flex-hierarchies-rollup-groups/) |
| Blitz Report™ XML Import | [FND_Flex_Hierarchies_Rollup_Groups.xml](https://www.enginatics.com/xml/fnd-flex-hierarchies-rollup-groups/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-flex-hierarchies-rollup-groups/](https://www.enginatics.com/reports/fnd-flex-hierarchies-rollup-groups/) |

## Executive Summary
The **FND Flex Hierarchies (Rollup Groups)** report documents the Rollup Groups defined for value sets. Rollup Groups are used to create summary accounts in General Ledger or to group values for reporting purposes.

## Business Challenge
*   **Summary Account Management:** Verifying which rollup groups exist before creating new summary templates.
*   **Reporting Structure:** Understanding how values are grouped for high-level financial reporting.

## The Solution
This Blitz Report lists the Rollup Groups:
*   **Value Set:** The value set the group belongs to.
*   **Rollup Group Name:** The code and description of the group.
*   **Hierarchy:** Shows the relationship between the group and the value set.

## Technical Architecture
The report queries `FND_FLEX_HIERARCHIES_VL` and `FND_FLEX_VALUE_SETS`.

## Parameters & Filtering
*   **None:** The report typically dumps all hierarchies or can be filtered by Value Set in the output.

## Performance & Optimization
*   **Lightweight:** This is a small configuration table.

## FAQ
*   **Q: How do I assign values to these groups?**
    *   A: You assign a Rollup Group to a specific Parent Value in the "Segment Values" form. Use the "FND Flex Values" report to see which values are assigned to which group.


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
