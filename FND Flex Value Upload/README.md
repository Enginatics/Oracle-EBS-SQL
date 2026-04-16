---
layout: default
title: 'FND Flex Value Upload | Oracle EBS SQL Report'
description: 'Upload to create or update flex values for Independent, Dependent, Translatable Independent, and Translatable Dependent value sets. Supports: - Value…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, FND, Flex, Value, fnd_flex_value_sets, fnd_flex_values, fnd_flex_values_tl'
permalink: /FND%20Flex%20Value%20Upload/
---

# FND Flex Value Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-flex-value-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Upload to create or update flex values for Independent, Dependent, Translatable Independent, and Translatable Dependent value sets.

Supports:
- Value creation and update (auto-detects via fnd_flex_values_pkg.load_row upsert)
- Enabled flag, start/end dates
- Summary flag (parent/child designation)
- Rollup group assignment for parent values
- Compiled value attributes (qualifier values for KFF segments, e.g. GL Account Type, Allow Posting)
- Hierarchy level
- Attribute sort order
- DFF attributes (ATTRIBUTE1..50)
- Translatable value meaning and description (for Translatable Independent/Dependent value sets)

Note: After uploading parent values with hierarchy changes, run the 'Compile Value Hierarchy' concurrent program from the Value Sets form to update the compiled hierarchy.

## Report Parameters
Upload Mode, Flex Value Set, Flex Value Like, Independent Value

## Oracle EBS Tables Used
[fnd_flex_value_sets](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_sets), [fnd_flex_values](https://www.enginatics.com/library/?pg=1&find=fnd_flex_values), [fnd_flex_values_tl](https://www.enginatics.com/library/?pg=1&find=fnd_flex_values_tl), [fnd_flex_hierarchies_vl](https://www.enginatics.com/library/?pg=1&find=fnd_flex_hierarchies_vl), [fnd_flex_value_norm_hierarchy](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_norm_hierarchy)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[FND Flex Values](/FND%20Flex%20Values/ "FND Flex Values Oracle EBS SQL Report"), [FND Flex Value Hierarchy](/FND%20Flex%20Value%20Hierarchy/ "FND Flex Value Hierarchy Oracle EBS SQL Report"), [FND Rollup Groups](/FND%20Rollup%20Groups/ "FND Rollup Groups Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [GL Account Analysis 11g](/GL%20Account%20Analysis%2011g/ "GL Account Analysis 11g Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/fnd-flex-value-upload/) |
| Blitz Report™ XML Import | [FND_Flex_Value_Upload.xml](https://www.enginatics.com/xml/fnd-flex-value-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-flex-value-upload/](https://www.enginatics.com/reports/fnd-flex-value-upload/) |



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
