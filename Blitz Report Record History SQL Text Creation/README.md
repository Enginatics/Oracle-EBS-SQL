---
layout: default
title: 'Blitz Report Record History SQL Text Creation | Oracle EBS SQL Report'
description: 'Creates a string for the record history columns, based on a table alias. – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, Record, History, dual'
permalink: /Blitz%20Report%20Record%20History%20SQL%20Text%20Creation/
---

# Blitz Report Record History SQL Text Creation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-record-history-sql-text-creation/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Creates a string for the record history columns, based on a table alias.

## Report Parameters
Table Alias, Prefix

## Oracle EBS Tables Used
[dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Inventory Accounts Setup](/CAC%20Inventory%20Accounts%20Setup/ "CAC Inventory Accounts Setup Oracle EBS SQL Report"), [INV Item Attribute Master/Child Conflicts](/INV%20Item%20Attribute%20Master-Child%20Conflicts/ "INV Item Attribute Master/Child Conflicts Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA Blitz Report ORDS Configuration](/DBA%20Blitz%20Report%20ORDS%20Configuration/ "DBA Blitz Report ORDS Configuration Oracle EBS SQL Report"), [ECC Admin - Concurrent Programs](/ECC%20Admin%20-%20Concurrent%20Programs/ "ECC Admin - Concurrent Programs Oracle EBS SQL Report"), [CAC Cost Group Accounts Setup](/CAC%20Cost%20Group%20Accounts%20Setup/ "CAC Cost Group Accounts Setup Oracle EBS SQL Report"), [OPM Reconcilation](/OPM%20Reconcilation/ "OPM Reconcilation Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Report Record History SQL Text Creation 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/blitz-report-record-history-sql-text-creation/) |
| Blitz Report™ XML Import | [Blitz_Report_Record_History_SQL_Text_Creation.xml](https://www.enginatics.com/xml/blitz-report-record-history-sql-text-creation/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-report-record-history-sql-text-creation/](https://www.enginatics.com/reports/blitz-report-record-history-sql-text-creation/) |

## Executive Summary
This utility report generates the SQL syntax required to include standard Oracle EBS record history columns (Who columns) in a query, based on a provided table alias.

## Business Challenge
When developing custom SQL reports in Oracle EBS, developers frequently need to include the standard "Who" columns (Created By, Creation Date, Last Updated By, Last Update Date, Last Update Login) to track record history. Manually typing these columns for every table alias is repetitive and prone to typos.

## Solution
The Blitz Report Record History SQL Text Creation tool automates this process. By simply inputting the table alias and an optional prefix, it generates the exact SQL code snippet needed to select these columns, formatted correctly with the specified alias.

## Key Features
- Generates SQL for standard record history columns: `creation_date`, `created_by`, `last_update_date`, `last_updated_by`, `last_update_login`.
- Accepts a user-defined table alias to prefix the columns.
- Allows for an optional prefix to be added to the column aliases, useful when joining multiple tables with history columns.

## Technical Details
The report uses a simple query against the `dual` table to concatenate the input parameters into the required SQL string format. It outputs a text string that can be directly copied and pasted into a SQL editor or report definition.


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
