---
layout: default
last_modified_at: 2026-10-19
title: 'FND Flex Values | Oracle EBS SQL Report'
description: 'Report for all flex values and the hierarchies they are included in. Column ''Hierarchy Position'' can be used to validate your account hierarchy setup and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Flex, Values, fnd_flex_value_norm_hierarchy, fnd_flex_value_sets, fnd_flex_values'
permalink: /FND%20Flex%20Values/
report_name: 'FND Flex Values'
report_web_name: fnd-flex-values
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Flex Values – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-flex-values/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-values) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-values).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Report for all flex values and the hierarchies they are included in.
Column 'Hierarchy Position' can be used to validate your account hierarchy setup and check which account segment values are not included in any (or a specific) hierarchy yet.

In EBS R12.2., there is new flexfield value security in place, which would require the UMX|FND_FLEX_VSET_ALL_PRIVS_ROLE role to maintain flexfield values.
If you do not have this role but apps DB access, you can add it from the backend:

begin
  wf_local_synch.propagateuserrole(
  p_user_name=>'ANDY.HAACK',
  p_role_name=>'UMX|FND_FLEX_VSET_ALL_PRIVS_ROLE'
  );
  commit;
end;

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-values) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Used by Key Flexfield, Used by Key Flex Structure, Flex Value Set, Independent Value, Flex Value like, Created By, Creation Date From, Creation Date To, Last Updated By, Last Update Date From, Last Update Date To, Active only, Missing in Hierarchy, Parent or Child, Parent Value like, Used in Rollup Group, DFF Display

## Oracle EBS Tables Used
[fnd_flex_value_norm_hierarchy](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_norm_hierarchy&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-values), [fnd_flex_value_sets](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-values), [fnd_flex_values](https://www.enginatics.com/library/?pg=1&find=fnd_flex_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-values), [fnd_flex_values_tl](https://www.enginatics.com/library/?pg=1&find=fnd_flex_values_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-values), [fnd_flex_hierarchies_vl](https://www.enginatics.com/library/?pg=1&find=fnd_flex_hierarchies_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-values)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-values)

## Related Reports
[FND Flex Value Upload](/FND%20Flex%20Value%20Upload/ "FND Flex Value Upload Oracle EBS SQL Report"), [FND Flex Value Hierarchy](/FND%20Flex%20Value%20Hierarchy/ "FND Flex Value Hierarchy Oracle EBS SQL Report"), [FND Rollup Groups](/FND%20Rollup%20Groups/ "FND Rollup Groups Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis 11g](/GL%20Account%20Analysis%2011g/ "GL Account Analysis 11g Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Balance by Account Hierarchy](/GL%20Balance%20by%20Account%20Hierarchy/ "GL Balance by Account Hierarchy Oracle EBS SQL Report"), [GL Balance](/GL%20Balance/ "GL Balance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Flex%20Values/FND%20Flex%20Values.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-values) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Flex Values 03-Mar-2024 002021.xlsx](https://www.enginatics.com/example/fnd-flex-values/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-values) |
| Blitz Report™ XML Import | [FND_Flex_Values.xml](https://www.enginatics.com/xml/fnd-flex-values/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-values) |
| SQL Source | [FND Flex Values.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Flex%20Values/FND%20Flex%20Values.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-flex-values/](https://www.enginatics.com/reports/fnd-flex-values/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-values) |

## Executive Summary
The **FND Flex Values** report is the standard master data report for segment values. It lists every value in an Independent or Dependent value set, along with its attributes and hierarchy status.

## Business Challenge
*   **Master Data Management:** Reviewing the list of active Cost Centers, Accounts, or Products.
*   **Hierarchy Maintenance:** Identifying "Orphan" values that are missing from a parent hierarchy (using the "Missing in Hierarchy" parameter).
*   **Attribute Audit:** Checking settings like "Allow Budgeting" or "Allow Posting" for GL accounts.

## The Solution
This Blitz Report extracts the value definition:
*   **Value:** The code and description.
*   **Status:** Enabled/Disabled, Start/End Dates.
*   **Attributes:** Segment qualifiers (Account Type, Reconcile, etc.).
*   **Hierarchy:** Shows if the value is a Parent or Child and which Rollup Group it belongs to.

## Technical Architecture
The report queries `FND_FLEX_VALUES` and `FND_FLEX_VALUES_TL`. It also checks `FND_FLEX_VALUE_NORM_HIERARCHY` to determine hierarchy status.

## Parameters & Filtering
*   **Flex Value Set:** The set to analyze (e.g., "Operations_Account").
*   **Missing in Hierarchy:** A critical filter for GL maintenance. It finds values that exist but are not rolled up to any parent.
*   **Active only:** Filter out disabled values.

## Performance & Optimization
*   **Volume:** For very large charts of accounts, filter by a specific range or value set to keep the report manageable.

## FAQ
*   **Q: How do I see the "Compiled" attributes?**
    *   A: The report shows the raw attributes stored in `COMPILED_VALUE_ATTRIBUTES`. These are often decoded into readable columns like "Account Type".

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-values)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-values)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-values)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-values)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-values)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-values)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-flex-values)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
