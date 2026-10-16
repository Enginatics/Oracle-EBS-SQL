---
layout: default
last_modified_at: 2026-10-16
title: 'DBA Text Search | Oracle EBS SQL Report'
description: 'Full text search through database source code objects such as packages, procedures, functions, triggers etc. The search can also be done using regular…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, Text, Search, dba_source'
permalink: /DBA%20Text%20Search/
report_name: 'DBA Text Search'
report_web_name: dba-text-search
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Text Search – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-text-search/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-text-search) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-text-search).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Full text search through database source code objects such as packages, procedures, functions, triggers etc.
The search can also be done using regular expressions.
To retrieve incorrect custom code such as a frequent performance issue calling the fnd_concurrent\.wait_for_request\s function with a zero interval time, for example, use parameter 'Multi Line Regex search' with the following value: fnd_concurrent\.wait_for_request\s*\(\s*request_id\s*=>\s*\w+\s*,\s*interval\s*=>\s*0\s*,

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-text-search) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Code Text contains, Multi Line Regex search, Multi Line window size, Object Name starts with, FND Message Text, Object Type, Schema, Line Number From, Line Number To

## Oracle EBS Tables Used
[dba_source](https://www.enginatics.com/library/?pg=1&find=dba_source&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-text-search)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-text-search)

## Related Reports
[XLA Distribution Links Summary](/XLA%20Distribution%20Links%20Summary/ "XLA Distribution Links Summary Oracle EBS SQL Report"), [DBA Object Access Privileges](/DBA%20Object%20Access%20Privileges/ "DBA Object Access Privileges Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [Blitz Report Custom Reports Converter](/Blitz%20Report%20Custom%20Reports%20Converter/ "Blitz Report Custom Reports Converter Oracle EBS SQL Report"), [DBA Profiler Data](/DBA%20Profiler%20Data/ "DBA Profiler Data Oracle EBS SQL Report"), [DBA Hierarchical Profiler Data](/DBA%20Hierarchical%20Profiler%20Data/ "DBA Hierarchical Profiler Data Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Text%20Search/DBA%20Text%20Search.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-text-search) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Text Search 11-May-2017 125907.xlsx](https://www.enginatics.com/example/dba-text-search/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-text-search) |
| Blitz Report™ XML Import | [DBA_Text_Search.xml](https://www.enginatics.com/xml/dba-text-search/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-text-search) |
| SQL Source | [DBA Text Search.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Text%20Search/DBA%20Text%20Search.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-text-search/](https://www.enginatics.com/reports/dba-text-search/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-text-search) |

## Case Study & Technical Analysis

### Abstract
The **DBA Text Search** report is a powerful code analysis tool that performs full-text searches across the database's stored procedures, functions, packages, and triggers. Unlike simple string matching, this report supports Regular Expressions (Regex), enabling sophisticated pattern matching to find complex coding structures, deprecated API calls, or hard-coded values.

### Technical Analysis

#### Core Features
*   **Regex Support**: Allows for patterns like `fnd_concurrent\.wait_for_request\s*\(.*interval\s*=>\s*0` to find specific dangerous function calls regardless of whitespace formatting.
*   **Context**: Can return lines of code surrounding the match (window size), providing immediate context for the developer.
*   **Scope**: Searches `DBA_SOURCE`, covering all PL/SQL code in the database.

#### Key View
*   `DBA_SOURCE`: The text of the stored objects.

#### Operational Use Cases
*   **Impact Analysis**: Finding all custom code that calls a specific Oracle API before applying a patch that changes that API.
*   **Code Quality**: Scanning for forbidden patterns (e.g., `GRANT DBA`, hardcoded passwords, or `SELECT *`).
*   **Refactoring**: Locating all usages of a table or column within PL/SQL logic.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-text-search)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-text-search)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-text-search)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-text-search)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-text-search)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-text-search)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-text-search)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
