---
layout: default
title: 'DBA Text Search | Oracle EBS SQL Report'
description: 'Full text search through database source code objects such as packages, procedures, functions, triggers etc. The search can also be done using regular…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, Text, Search, dba_source'
permalink: /DBA%20Text%20Search/
---

# DBA Text Search – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-text-search/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Full text search through database source code objects such as packages, procedures, functions, triggers etc.
The search can also be done using regular expressions.
To retrieve incorrect custom code such as a frequent performance issue calling the fnd_concurrent\.wait_for_request\s function with a zero interval time, for example, use parameter 'Multi Line Regex search' with the following value: fnd_concurrent\.wait_for_request\s*\(\s*request_id\s*=>\s*\w+\s*,\s*interval\s*=>\s*0\s*,

## Report Parameters
Code Text contains, Multi Line Regex search, Cote Text Regexp search, Multi Line window size, Object Name starts with, FND Message Text, Object Type, Schema, Line Number From, Line Number To

## Oracle EBS Tables Used
[dba_source](https://www.enginatics.com/library/?pg=1&find=dba_source)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[XLA Distribution Links Summary](/XLA%20Distribution%20Links%20Summary/ "XLA Distribution Links Summary Oracle EBS SQL Report"), [DBA Object Access Privileges](/DBA%20Object%20Access%20Privileges/ "DBA Object Access Privileges Oracle EBS SQL Report"), [DBA Profiler Data](/DBA%20Profiler%20Data/ "DBA Profiler Data Oracle EBS SQL Report"), [DBA Hierarchical Profiler Data](/DBA%20Hierarchical%20Profiler%20Data/ "DBA Hierarchical Profiler Data Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA Tablespace Usage](/DBA%20Tablespace%20Usage/ "DBA Tablespace Usage Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Text Search 11-May-2017 125907.xlsx](https://www.enginatics.com/example/dba-text-search/) |
| Blitz Report™ XML Import | [DBA_Text_Search.xml](https://www.enginatics.com/xml/dba-text-search/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-text-search/](https://www.enginatics.com/reports/dba-text-search/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
