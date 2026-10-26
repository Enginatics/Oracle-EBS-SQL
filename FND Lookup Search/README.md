---
layout: default
last_modified_at: 2026-10-26
title: 'FND Lookup Search | Oracle EBS SQL Report'
description: 'Finds the best matching lookuptype for a given set of lookupcodes in a custom application base table. Example: Coding a sql for ap suppliers, the value of…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Lookup, Search, dba_tables, fnd_oracle_userid, fnd_product_installations'
permalink: /FND%20Lookup%20Search/
report_name: 'FND Lookup Search'
report_web_name: fnd-lookup-search
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Lookup Search – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-lookup-search/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-search) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-search).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Finds the best matching lookup_type for a given set of lookup_codes in a custom application base table.

Example:
Coding a sql for ap suppliers, the value of column vendor_type_lookup_code should get translated to the user visible meaning instead of the code.
The lookup_type used for translation can be found by this report entering table name AP_SUPPLIERS and column name VENDOR_TYPE_LOOKUP_CODE.
The output contains a column SQL_TEXT which can be used directly in the sql where clause:

=flv.lookup_code(+) and
flv.lookup_type(+)='VENDOR TYPE' and
flv.view_application_id(+)=201 and
flv.language(+)=userenv('lang') and
flv.security_group_id(+)=0 and

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-search) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Table Name, Colum Name

## Oracle EBS Tables Used
[dba_tables](https://www.enginatics.com/library/?pg=1&find=dba_tables&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-search), [fnd_oracle_userid](https://www.enginatics.com/library/?pg=1&find=fnd_oracle_userid&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-search), [fnd_product_installations](https://www.enginatics.com/library/?pg=1&find=fnd_product_installations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-search), [fnd_application](https://www.enginatics.com/library/?pg=1&find=fnd_application&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-search), [xo](https://www.enginatics.com/library/?pg=1&find=xo&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-search), [fnd_lookup_values](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-search), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-search)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-search)

## Related Reports
[FND Audit Setup](/FND%20Audit%20Setup/ "FND Audit Setup Oracle EBS SQL Report"), [DBA Users](/DBA%20Users/ "DBA Users Oracle EBS SQL Report"), [FND Applications](/FND%20Applications/ "FND Applications Oracle EBS SQL Report"), [FND Histogram Columns](/FND%20Histogram%20Columns/ "FND Histogram Columns Oracle EBS SQL Report"), [CAC Accounting Period Status](/CAC%20Accounting%20Period%20Status/ "CAC Accounting Period Status Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [XLA Subledger Accounting Rules Detail Listing](/XLA%20Subledger%20Accounting%20Rules%20Detail%20Listing/ "XLA Subledger Accounting Rules Detail Listing Oracle EBS SQL Report"), [Blitz Report VPD Policy Setup](/Blitz%20Report%20VPD%20Policy%20Setup/ "Blitz Report VPD Policy Setup Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Lookup%20Search/FND%20Lookup%20Search.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-search) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Lookup Search 27-Jul-2018 212528.xlsx](https://www.enginatics.com/example/fnd-lookup-search/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-search) |
| Blitz Report™ XML Import | [FND_Lookup_Search.xml](https://www.enginatics.com/xml/fnd-lookup-search/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-search) |
| SQL Source | [FND Lookup Search.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Lookup%20Search/FND%20Lookup%20Search.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-lookup-search/](https://www.enginatics.com/reports/fnd-lookup-search/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-search) |

## Executive Summary
The **FND Lookup Search** report is a developer utility designed to reverse-engineer lookup codes. It helps find the correct `LOOKUP_TYPE` for a given column in a table.

## Business Challenge
*   **Data Mapping:** When writing SQL queries, you often see a code (e.g., 'S') in a column but don't know which Lookup Type decodes it to 'Standard'.
*   **Legacy Analysis:** Understanding the data model of older or custom tables.

## The Solution
This Blitz Report analyzes the data in a specific table and column:
*   **Pattern Matching:** It compares the values in your target column against all active Lookup Types in the system.
*   **Recommendation:** It suggests the most likely Lookup Type that matches your data.
*   **SQL Generation:** It generates the SQL join syntax to link your table to `FND_LOOKUP_VALUES`.

## Technical Architecture
The report uses a heuristic approach to match distinct values from the target table with lookup codes.

## Parameters & Filtering
*   **Table Name:** The table you are investigating (e.g., `AP_SUPPLIERS`).
*   **Column Name:** The column containing the code (e.g., `VENDOR_TYPE_LOOKUP_CODE`).

## Performance & Optimization
*   **Analysis Tool:** This is an interactive tool, not a standard report. It runs a dynamic query to find matches.

## FAQ
*   **Q: Does it work for custom lookups?**
    *   A: Yes, it searches all lookups in `FND_LOOKUP_TYPES`.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-search)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-search)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-search)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-search)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-search)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-search)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-lookup-search)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
