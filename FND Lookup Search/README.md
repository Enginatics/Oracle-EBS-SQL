---
layout: default
title: 'FND Lookup Search | Oracle EBS SQL Report'
description: 'Finds the best matching lookuptype for a given set of lookupcodes in a custom application base table. Example: Coding a sql for ap suppliers, the value of…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Lookup, Search'
permalink: /FND%20Lookup%20Search/
---

# FND Lookup Search – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-lookup-search/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
Table Name, Colum Name

## Oracle EBS Tables Used


## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Lookup Search 27-Jul-2018 212528.xlsx](https://www.enginatics.com/example/fnd-lookup-search/) |
| Blitz Report™ XML Import | [FND_Lookup_Search.xml](https://www.enginatics.com/xml/fnd-lookup-search/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-lookup-search/](https://www.enginatics.com/reports/fnd-lookup-search/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
