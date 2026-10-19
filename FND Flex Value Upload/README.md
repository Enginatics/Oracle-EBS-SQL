---
layout: default
last_modified_at: 2026-10-19
title: 'FND Flex Value Upload | Oracle EBS SQL Report'
description: 'Upload to create or update flex values for Independent, Dependent, Translatable Independent, and Translatable Dependent value sets. Supports: - Value…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, FND, Flex, Value, fnd_flex_values, fnd_flex_value_sets, fnd_flex_values_tl'
permalink: /FND%20Flex%20Value%20Upload/
report_name: 'FND Flex Value Upload'
report_web_name: fnd-flex-value-upload
---

# FND Flex Value Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-flex-value-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-upload).

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Flex Value Set, Flex Value Like, Independent Value

## Oracle EBS Tables Used
[fnd_flex_values](https://www.enginatics.com/library/?pg=1&find=fnd_flex_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-upload), [fnd_flex_value_sets](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-upload), [fnd_flex_values_tl](https://www.enginatics.com/library/?pg=1&find=fnd_flex_values_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-upload), [fnd_flex_hierarchies_vl](https://www.enginatics.com/library/?pg=1&find=fnd_flex_hierarchies_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-upload), [fnd_flex_value_norm_hierarchy](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_norm_hierarchy&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-upload)

## Related Reports
[FND Flex Values](/FND%20Flex%20Values/ "FND Flex Values Oracle EBS SQL Report"), [FND Flex Value Hierarchy](/FND%20Flex%20Value%20Hierarchy/ "FND Flex Value Hierarchy Oracle EBS SQL Report"), [FND Rollup Groups](/FND%20Rollup%20Groups/ "FND Rollup Groups Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis 11g](/GL%20Account%20Analysis%2011g/ "GL Account Analysis 11g Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Balance by Account Hierarchy](/GL%20Balance%20by%20Account%20Hierarchy/ "GL Balance by Account Hierarchy Oracle EBS SQL Report"), [GL Balance](/GL%20Balance/ "GL Balance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Flex%20Value%20Upload/FND%20Flex%20Value%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/fnd-flex-value-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-upload) |
| Blitz Report™ XML Import | [FND_Flex_Value_Upload.xml](https://www.enginatics.com/xml/fnd-flex-value-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-upload) |
| SQL Source | [FND Flex Value Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Flex%20Value%20Upload/FND%20Flex%20Value%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-flex-value-upload/](https://www.enginatics.com/reports/fnd-flex-value-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-upload) |

## Case Study & Technical Analysis: FND Flex Value Upload

### Executive Summary
FND Flex Value Upload is an upload template for creating and maintaining the values of Oracle Application Object Library value sets, the lists that validate the segments of Accounting, Asset and other key and descriptive flexfields. The template downloads the current values of a chosen value set, lets the user change or add rows in Excel, and writes the changes back through the standard flexfield value API. It is used by EBS functional administrators and implementation teams who load chart of accounts segment values, maintain parent and child hierarchies, or set up flexfield attributes in bulk, for example during a new legal entity or cost center rollout.

### Business Challenge
*   **Bulk Value Maintenance:** Setting up a chart of accounts or a cost center structure through the Values form means one value at a time, which is slow for hundreds of values.
*   **Hierarchy Accuracy:** Parent values, rollup groups and child ranges must be consistent, and errors in them affect every report that rolls up the values.
*   **Translation Effort:** Translatable value sets need the meaning and description in each language, and these are often maintained in separate files.
*   **Flexfield Attributes:** Qualifier values such as account type or allow posting, and the DFF attributes of each value, must be set consistently across many rows.

### The Solution
*   **Value Set Download:** Choosing a value set downloads its existing values with their enabled flag, active dates, summary flag and hierarchy assignments, so changes are made against current data.
*   **Upsert Processing:** Each uploaded row is passed to the standard value load routine, which creates the value if it is new and updates it otherwise.
*   **Hierarchy Capture:** Parent values carry their rollup group and child range, so a parent and its children can be created in one upload.
*   **Attribute Coverage:** Compiled value attributes and the thirty DFF attributes are exposed as columns, with the value category decoding the descriptive flexfield prompts.

### Technical Architecture (High Level)
#### Primary Tables
*   `FND_FLEX_VALUE_SETS`: the value set definitions, including the parent value set reference.
*   `FND_FLEX_VALUES`: the individual values with their hierarchy, dates, flags and attributes.
*   `FND_FLEX_VALUES_TL`: the translated meaning and description of each value.
*   `FND_FLEX_HIERARCHIES_VL`: the rollup group definitions used for structured hierarchies.
*   `FND_FLEX_VALUE_NORM_HIERARCHY`: the child ranges of parent values in a normalized hierarchy.

#### Logical Relationships
1.  The selected value set in `FND_FLEX_VALUE_SETS` is joined to its values in `FND_FLEX_VALUES` on the value set identifier.
2.  A self join to `FND_FLEX_VALUE_SETS` through the parent value set identifier gives the parent value set name for dependent value sets.
3.  Each value is joined to `FND_FLEX_VALUES_TL` on the value identifier, restricted to the session language.
4.  The structured hierarchy identifier of each value is outer joined to `FND_FLEX_HIERARCHIES_VL` to return the rollup group name.
5.  Each value is outer joined to `FND_FLEX_VALUE_NORM_HIERARCHY` on the value set and the parent value to return child ranges and their range attribute.

### Parameters & Filtering
*   **Upload Mode:** Selects Create, or Create and Update, which decides whether existing values are downloaded.
*   **Flex Value Set:** The value set whose values are downloaded or created. It is the main driver of the extract.
*   **Flex Value Like:** Limits the downloaded values to those whose value matches a pattern, for example a company prefix.
*   **Independent Value:** For dependent value sets, restricts the rows to the dependent values of one independent value.

### Performance & Optimization
*   **Value Set Driven Extract:** The extract starts from one named value set, so only that set's values are read.
*   **Language Filter:** The translation join is restricted to the session language, so each value returns one description row.
*   **Outer Joins for Optional Data:** Hierarchy, rollup and child range data are outer joined, so values without a hierarchy still appear.
*   **Upload Mode Filter:** The download is suppressed in Create mode through the upload mode predicate, so an empty template is produced for new values.

### FAQ
**Q: Can I create a parent value and its child range in the same upload?**
A: Yes. Parent rows carry the child range low and high values and the range attribute, so the hierarchy is created with the parent.

**Q: Do I need to run anything after uploading hierarchy changes?**
A: Yes. The description states that the Compile Value Hierarchy concurrent program must be run from the Value Sets form after parent values with hierarchy changes are uploaded.

**Q: How are the descriptive flexfield attributes handled?**
A: Attribute1 to Attribute30 show the prompts of the value category, and Attribute31 to Attribute50 are shown as raw columns. The value category is returned with its display name.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-value-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
