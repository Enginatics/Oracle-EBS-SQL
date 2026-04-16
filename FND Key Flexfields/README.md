---
layout: default
title: 'FND Key Flexfields | Oracle EBS SQL Report'
description: 'Key flexfields table, structure, column and validation information – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Key, Flexfields, fnd_segment_attribute_values, fnd_application_vl, fnd_id_flexs'
permalink: /FND%20Key%20Flexfields/
---

# FND Key Flexfields – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-key-flexfields/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Key flexfields table, structure, column and validation information

## Report Parameters
Title, Flexfield Code, Structure Name, Table Name, Window Prompt, Validation Table Name

## Oracle EBS Tables Used
[fnd_segment_attribute_values](https://www.enginatics.com/library/?pg=1&find=fnd_segment_attribute_values), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_id_flexs](https://www.enginatics.com/library/?pg=1&find=fnd_id_flexs), [fnd_id_flex_structures_vl](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_structures_vl), [fnd_id_flex_segments_vl](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_segments_vl), [fnd_flex_value_sets](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_sets), [fnd_flex_validation_tables](https://www.enginatics.com/library/?pg=1&find=fnd_flex_validation_tables)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Flex Value Sets, Usages and Values](/FND%20Flex%20Value%20Sets-%20Usages%20and%20Values/ "FND Flex Value Sets, Usages and Values Oracle EBS SQL Report"), [FND Flex Value Security Rules](/FND%20Flex%20Value%20Security%20Rules/ "FND Flex Value Security Rules Oracle EBS SQL Report"), [GL Code Combinations](/GL%20Code%20Combinations/ "GL Code Combinations Oracle EBS SQL Report"), [AR Transaction Upload](/AR%20Transaction%20Upload/ "AR Transaction Upload Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [FND Descriptive Flexfields](/FND%20Descriptive%20Flexfields/ "FND Descriptive Flexfields Oracle EBS SQL Report"), [AP Invoice Upload 11i](/AP%20Invoice%20Upload%2011i/ "AP Invoice Upload 11i Oracle EBS SQL Report"), [GL Account Upload](/GL%20Account%20Upload/ "GL Account Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Key Flexfields 02-Mar-2024 231637.xlsx](https://www.enginatics.com/example/fnd-key-flexfields/) |
| Blitz Report™ XML Import | [FND_Key_Flexfields.xml](https://www.enginatics.com/xml/fnd-key-flexfields/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-key-flexfields/](https://www.enginatics.com/reports/fnd-key-flexfields/) |

## Executive Summary
The **FND Key Flexfields** report documents the structure of the major accounting and system keys in Oracle EBS (e.g., Accounting Flexfield, Item Category, Asset Key).

## Business Challenge
*   **Chart of Accounts Review:** Documenting the segment structure (Company, Department, Account) for the GL.
*   **System Configuration:** Verifying the setup of Item Categories or Sales Territories.
*   **Validation Analysis:** Checking which value set is attached to each segment of the key.

## The Solution
This Blitz Report details the KFF structure:
*   **Structure:** The name of the structure (e.g., "Operations Accounting Flex").
*   **Segments:** The list of segments, their order, and window prompt.
*   **Validation:** The value set and any specific segment qualifiers (e.g., "Balancing Segment").

## Technical Architecture
The report joins `FND_ID_FLEXS`, `FND_ID_FLEX_STRUCTURES`, and `FND_ID_FLEX_SEGMENTS`. It also links to `FND_SEGMENT_ATTRIBUTE_VALUES` to show qualifiers.

## Parameters & Filtering
*   **Title:** Filter by the flexfield name (e.g., "Accounting Flexfield").
*   **Structure Name:** Filter by a specific chart of accounts structure.

## Performance & Optimization
*   **Fast Execution:** Runs quickly against the metadata tables.

## FAQ
*   **Q: What is the difference between "Title" and "Code"?**
    *   A: "Title" is the user-friendly name (e.g., "Accounting Flexfield"). "Code" is the internal short code (e.g., "GL#").


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
