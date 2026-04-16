---
layout: default
title: 'FND Descriptive Flexfields | Oracle EBS SQL Report'
description: 'Descriptive flexfields table, context, column and validation information – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Descriptive, Flexfields, fnd_application_vl, fnd_descriptive_flexs_vl, fnd_descr_flex_contexts_vl'
permalink: /FND%20Descriptive%20Flexfields/
---

# FND Descriptive Flexfields – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-descriptive-flexfields/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Descriptive flexfields table, context, column and validation information

## Report Parameters
Application, Name, Title, Table Name, Window Prompt, Validation Table Name, Show LOV Query

## Oracle EBS Tables Used
[fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_descriptive_flexs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_descriptive_flexs_vl), [fnd_descr_flex_contexts_vl](https://www.enginatics.com/library/?pg=1&find=fnd_descr_flex_contexts_vl), [fnd_descr_flex_col_usage_vl](https://www.enginatics.com/library/?pg=1&find=fnd_descr_flex_col_usage_vl), [fnd_flex_value_sets](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_sets), [fnd_flex_validation_tables](https://www.enginatics.com/library/?pg=1&find=fnd_flex_validation_tables)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Flex Value Sets, Usages and Values](/FND%20Flex%20Value%20Sets-%20Usages%20and%20Values/ "FND Flex Value Sets, Usages and Values Oracle EBS SQL Report"), [FND Concurrent Programs and Executables 11i](/FND%20Concurrent%20Programs%20and%20Executables%2011i/ "FND Concurrent Programs and Executables 11i Oracle EBS SQL Report"), [FND Concurrent Programs and Executables](/FND%20Concurrent%20Programs%20and%20Executables/ "FND Concurrent Programs and Executables Oracle EBS SQL Report"), [PER Organizations](/PER%20Organizations/ "PER Organizations Oracle EBS SQL Report"), [FND Key Flexfields](/FND%20Key%20Flexfields/ "FND Key Flexfields Oracle EBS SQL Report"), [HR Organization Upload](/HR%20Organization%20Upload/ "HR Organization Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Descriptive Flexfields 24-Jul-2017 144351.xlsx](https://www.enginatics.com/example/fnd-descriptive-flexfields/) |
| Blitz Report™ XML Import | [FND_Descriptive_Flexfields.xml](https://www.enginatics.com/xml/fnd-descriptive-flexfields/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-descriptive-flexfields/](https://www.enginatics.com/reports/fnd-descriptive-flexfields/) |

## Executive Summary
The **FND Descriptive Flexfield** report is the comprehensive documentation tool for all DFF configurations in the system. It details every context, segment, and validation rule associated with a flexfield.

## Business Challenge
*   **Configuration Audit:** Documenting all custom fields added to screens for compliance or upgrade planning.
*   **Troubleshooting:** Debugging why a specific field is mandatory or has a specific list of values.
*   **Knowledge Transfer:** Explaining the custom data model to new developers or business analysts.

## The Solution
This Blitz Report extracts the full DFF definition:
*   **Contexts:** Lists the "Global Data Elements" and any context-sensitive structures.
*   **Segments:** Details each segment (Attribute1, Attribute2, etc.), its prompt, and display size.
*   **Validation:** Shows the Value Set attached to each segment and the underlying validation logic (SQL or independent values).

## Technical Architecture
The report joins `FND_DESCRIPTIVE_FLEXS`, `FND_DESCR_FLEX_CONTEXTS`, and `FND_DESCR_FLEX_COL_USAGE`. It provides a hierarchical view of the flexfield structure.

## Parameters & Filtering
*   **Title:** Search by the user-friendly name of the DFF (e.g., "Order Headers").
*   **Table Name:** Search by the underlying table (e.g., `OE_ORDER_HEADERS_ALL`).
*   **Show LOV Query:** Option to display the SQL query used by Table-validated value sets.

## Performance & Optimization
*   **Complex Validations:** If "Show LOV Query" is enabled, the report may take slightly longer to render large SQL blocks.

## FAQ
*   **Q: Can I see Key Flexfields here?**
    *   A: No, this is for Descriptive Flexfields. Use "FND Key Flexfields" for the accounting flexfield, item category, etc.


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
