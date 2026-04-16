---
layout: default
title: 'FND Tables and Columns | Oracle EBS SQL Report'
description: 'Registered FND tables, columns, primary keys and their flexfields – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Tables, Columns, fnd_application_vl, fnd_tables, fnd_columns'
permalink: /FND%20Tables%20and%20Columns/
---

# FND Tables and Columns – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-tables-and-columns/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Registered FND tables, columns, primary keys and their flexfields

## Report Parameters
Table Name, Column Name like, Key Columns only

## Oracle EBS Tables Used
[fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_tables](https://www.enginatics.com/library/?pg=1&find=fnd_tables), [fnd_columns](https://www.enginatics.com/library/?pg=1&find=fnd_columns), [fnd_primary_key_columns](https://www.enginatics.com/library/?pg=1&find=fnd_primary_key_columns), [fnd_primary_keys](https://www.enginatics.com/library/?pg=1&find=fnd_primary_keys), [fnd_descriptive_flexs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_descriptive_flexs_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Flex Value Sets, Usages and Values](/FND%20Flex%20Value%20Sets-%20Usages%20and%20Values/ "FND Flex Value Sets, Usages and Values Oracle EBS SQL Report"), [FND Descriptive Flexfield Table Columns](/FND%20Descriptive%20Flexfield%20Table%20Columns/ "FND Descriptive Flexfield Table Columns Oracle EBS SQL Report"), [FND Audit Setup](/FND%20Audit%20Setup/ "FND Audit Setup Oracle EBS SQL Report"), [CAC Invoice Price Variance](/CAC%20Invoice%20Price%20Variance/ "CAC Invoice Price Variance Oracle EBS SQL Report"), [Blitz Report Parameter DFF Table Validation](/Blitz%20Report%20Parameter%20DFF%20Table%20Validation/ "Blitz Report Parameter DFF Table Validation Oracle EBS SQL Report"), [FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report"), [CST Detailed Item Cost](/CST%20Detailed%20Item%20Cost/ "CST Detailed Item Cost Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC OPM WIP Account Value](/CAC%20OPM%20WIP%20Account%20Value/ "CAC OPM WIP Account Value Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/fnd-tables-and-columns/) |
| Blitz Report™ XML Import | [FND_Tables_and_Columns.xml](https://www.enginatics.com/xml/fnd-tables-and-columns/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-tables-and-columns/](https://www.enginatics.com/reports/fnd-tables-and-columns/) |

## Executive Summary
The **FND Tables and Columns** report serves as a dynamic data dictionary for the Oracle EBS application. It lists registered tables, their columns, primary keys, and associated descriptive flexfields. This is an invaluable resource for developers, report writers, and data analysts.

## Business Challenge
Oracle EBS has thousands of tables. Finding the correct table name, column name, or understanding the primary key structure for a specific entity can be challenging. Documentation is not always up to date with custom extensions or specific patch levels.

## The Solution
This report provides an "as-built" view of the database schema as registered in the Application Object Library (AOL). It helps users:
- Search for tables by name or pattern.
- Find specific columns across the entire schema.
- Identify primary keys for joining tables.
- See which tables have Descriptive Flexfields (DFFs) enabled.

## Technical Architecture
The report queries the AOL dictionary tables: `fnd_tables`, `fnd_columns`, `fnd_primary_keys`, and `fnd_descriptive_flexs`. This ensures the information matches exactly what the application "knows" about the database.

## Parameters & Filtering
- **Table Name:** Search for a specific table (e.g., `PO_HEADERS_ALL`).
- **Column Name like:** Find tables containing a specific column (e.g., `%VENDOR_ID%`).
- **Key Columns only:** Restrict the output to only show primary key columns, useful for understanding join conditions.

## Performance & Optimization
The report is optimized for metadata querying. Searching by `Column Name like` with a leading wildcard (e.g., `%ID`) may be slower than searching by Table Name.

## FAQ
**Q: Does this include custom tables?**
A: It includes any custom tables that have been registered in EBS using the `AD_DD` package or the "Register Table" form. It will not show custom tables that exist in the database but are not registered in AOL.

**Q: Why don't I see a specific view?**
A: This report focuses on *Tables*. While some views are registered in `fnd_tables`, many are not.


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
