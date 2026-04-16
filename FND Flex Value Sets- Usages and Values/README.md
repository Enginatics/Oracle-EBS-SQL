---
layout: default
title: 'FND Flex Value Sets, Usages and Values | Oracle EBS SQL Report'
description: 'Value sets and values including usages, validation type, format type, validation table, columns etc.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Flex, Value, Sets,, fnd_flex_value_sets, fnd_flex_validation_tables, fnd_application_vl'
permalink: /FND%20Flex%20Value%20Sets-%20Usages%20and%20Values/
---

# FND Flex Value Sets, Usages and Values – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-flex-value-sets-usages-and-values/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Value sets and values including usages, validation type, format type, validation table, columns etc.

## Report Parameters
Flex Value Set Name like, Show LOV Query, Show Usages, Show Values, Validation Type, Table Name, Last Update Date From

## Oracle EBS Tables Used
[fnd_flex_value_sets](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_sets), [fnd_flex_validation_tables](https://www.enginatics.com/library/?pg=1&find=fnd_flex_validation_tables), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_flex_values_vl](https://www.enginatics.com/library/?pg=1&find=fnd_flex_values_vl), [fnd_descr_flex_col_usage_vl](https://www.enginatics.com/library/?pg=1&find=fnd_descr_flex_col_usage_vl), [fnd_descriptive_flexs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_descriptive_flexs_vl), [fnd_id_flex_segments_vl](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_segments_vl), [fnd_id_flex_structures_vl](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_structures_vl), [fnd_id_flexs](https://www.enginatics.com/library/?pg=1&find=fnd_id_flexs), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Descriptive Flexfields](/FND%20Descriptive%20Flexfields/ "FND Descriptive Flexfields Oracle EBS SQL Report"), [FND Key Flexfields](/FND%20Key%20Flexfields/ "FND Key Flexfields Oracle EBS SQL Report"), [FND Concurrent Programs and Executables 11i](/FND%20Concurrent%20Programs%20and%20Executables%2011i/ "FND Concurrent Programs and Executables 11i Oracle EBS SQL Report"), [FND Concurrent Programs and Executables](/FND%20Concurrent%20Programs%20and%20Executables/ "FND Concurrent Programs and Executables Oracle EBS SQL Report"), [FND Flex Value Security Rules](/FND%20Flex%20Value%20Security%20Rules/ "FND Flex Value Security Rules Oracle EBS SQL Report"), [PER Organizations](/PER%20Organizations/ "PER Organizations Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [GL Account Upload](/GL%20Account%20Upload/ "GL Account Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Flex Value Sets, Usages and Values 20-Jan-2019 123359.xlsx](https://www.enginatics.com/example/fnd-flex-value-sets-usages-and-values/) |
| Blitz Report™ XML Import | [FND_Flex_Value_Sets_Usages_and_Values.xml](https://www.enginatics.com/xml/fnd-flex-value-sets-usages-and-values/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-flex-value-sets-usages-and-values/](https://www.enginatics.com/reports/fnd-flex-value-sets-usages-and-values/) |

## Executive Summary
The **FND Flex Value Sets, Usages and Values** report is a comprehensive dictionary of all value sets in the system. It documents not just the list of values, but where the value set is used (DFFs, Key Flexfields, Concurrent Programs).

## Business Challenge
*   **Impact Analysis:** Before changing a value set (e.g., adding a value or changing validation), knowing every report and screen that uses it.
*   **Cleanup:** Identifying unused value sets.
*   **Standardization:** Finding duplicate value sets that could be consolidated.

## The Solution
This Blitz Report provides a 360-degree view:
*   **Definition:** Validation type (Independent, Table, None), Format, and Maximum Size.
*   **Content:** Can list the actual values contained in the set.
*   **Usage:** Lists every DFF Segment, Key Flexfield Segment, and Concurrent Program Parameter that references this value set.

## Technical Architecture
The report joins `FND_FLEX_VALUE_SETS` with `FND_DESCR_FLEX_COL_USAGE`, `FND_ID_FLEX_SEGMENTS`, and `FND_CONCURRENT_PROGRAMS`.

## Parameters & Filtering
*   **Flex Value Set Name:** Search for a specific set.
*   **Show Usages:** Toggle to see the "Where Used" analysis.
*   **Show Values:** Toggle to see the list of values (careful with large sets like GL Accounts).

## Performance & Optimization
*   **Large Sets:** Do not use "Show Values" for large table-validated sets (like Suppliers or Customers) as it will try to dump the entire table.

## FAQ
*   **Q: Can I see the SQL for table-validated sets?**
    *   A: Yes, enable "Show LOV Query" to see the exact SQL used to populate the list.


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
