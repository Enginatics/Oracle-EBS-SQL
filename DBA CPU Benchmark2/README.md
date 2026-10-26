---
layout: default
last_modified_at: 2026-10-26
title: 'DBA CPU Benchmark2 | Oracle EBS SQL Report'
description: 'Benchmark report to measure a database server''s CPU speed, mainly for PLSQL processing. This report generates an output file of 200000 records from dual…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, CPU, Benchmark2, dual'
permalink: /DBA%20CPU%20Benchmark2/
report_name: 'DBA CPU Benchmark2'
report_web_name: dba-cpu-benchmark2
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA CPU Benchmark2 – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-cpu-benchmark2/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark2) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark2).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Benchmark report to measure a database server's CPU speed, mainly for PLSQL processing.
This report generates an output file of 200000 records from dual.
As the query itself should complete in less than a second, most of the execution time is spend in PLSQL code to generate the Blitz Report output file.
To measure meaningful results, there should be enough SGA memory assigned to ensure that the execution time is entirely spent on CPU and not IO related wait events (to be confirmed using the DBA SGA Active Session History report).

example performance for different CPU types:
seconds	rows/s	CPU
8	25000	AMD Ryzen 9 5950X 16-Core Processor
11	18182
12	16667	AMD EPYC 7742 64-Core Processor
13	15385	Exadata CS X8M
18	11111	Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz
20	10000	Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
18	11111	Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz
24	8333	Intel(R) Xeon(R) CPU E5-2670 v2 @ 2.50GHz
22	9091	Intel(R) Xeon(R) CPU E5-2686 v4 @ 2.30GHz 
24	8333	Intel(R) Xeon(R) Platinum 8167M CPU @ 2.00GHz
21	9524	Intel(R) Xeon(R) Platinum 8167M CPU @ 2.00GHz
65	3077	SPARC-T5, chipid 1, clock 3600 MHz

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark2) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Row Number

## Oracle EBS Tables Used
[dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark2)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark2)

## Related Reports
[DBA Database Parameter Validation](/DBA%20Database%20Parameter%20Validation/ "DBA Database Parameter Validation Oracle EBS SQL Report"), [INV Item Attribute Master/Child Conflicts](/INV%20Item%20Attribute%20Master-Child%20Conflicts/ "INV Item Attribute Master/Child Conflicts Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [ECC Admin - Concurrent Programs](/ECC%20Admin%20-%20Concurrent%20Programs/ "ECC Admin - Concurrent Programs Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [OPM Reconcilation](/OPM%20Reconcilation/ "OPM Reconcilation Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20CPU%20Benchmark2/DBA%20CPU%20Benchmark2.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark2) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA CPU Benchmark2 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/dba-cpu-benchmark2/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark2) |
| Blitz Report™ XML Import | [DBA_CPU_Benchmark2.xml](https://www.enginatics.com/xml/dba-cpu-benchmark2/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark2) |
| SQL Source | [DBA CPU Benchmark2.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20CPU%20Benchmark2/DBA%20CPU%20Benchmark2.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-cpu-benchmark2/](https://www.enginatics.com/reports/dba-cpu-benchmark2/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark2) |

## Executive Summary
The **DBA CPU Benchmark2** report is a simplified version of the CPU benchmark. Instead of joining tables, it generates 200,000 rows directly from `DUAL` using a `CONNECT BY` clause. This isolates the performance of the SQL and PL/SQL engines even further, removing any potential dependency on table statistics or data distribution.

## Business Challenge
*   **Pure CPU Testing**: "I want to test raw CPU speed without any table I/O interference."
*   **Quick Check**: "I need a fast test to see if the server is performing normally."
*   **Comparison**: Comparing results with Benchmark1 to see if table access overhead is a factor.

## Solution
This report generates a fixed number of rows using a hierarchical query on `DUAL`.

**Key Features:**
*   **Zero Dependencies**: Does not rely on any application tables, only the Oracle data dictionary.
*   **High Speed**: Completes very quickly, allowing for rapid iteration.
*   **Reference Data**: Includes benchmark results for various CPU architectures.

## Architecture
The report queries `DUAL`.

**Key Tables:**
*   `DUAL`: The standard Oracle dummy table.

## Impact
*   **Infrastructure Verification**: Quickly validates CPU performance after maintenance or migration.
*   **Environment Comparison**: consistently compares performance across Dev, Test, and Prod environments.
*   **PL/SQL Efficiency**: Measures the raw speed of the PL/SQL output generation process.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark2)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark2)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark2)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark2)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark2)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark2)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark2)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
