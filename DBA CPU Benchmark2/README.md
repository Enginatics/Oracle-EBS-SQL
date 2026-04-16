---
layout: default
title: 'DBA CPU Benchmark2 | Oracle EBS SQL Report'
description: 'Benchmark report to measure a database server''s CPU speed, mainly for PLSQL processing. This report generates an output file of 200000 records from dual…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, CPU, Benchmark2, dual'
permalink: /DBA%20CPU%20Benchmark2/
---

# DBA CPU Benchmark2 – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-cpu-benchmark2/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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


## Report Parameters
Row Number

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
| Excel Example Output | [DBA CPU Benchmark2 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/dba-cpu-benchmark2/) |
| Blitz Report™ XML Import | [DBA_CPU_Benchmark2.xml](https://www.enginatics.com/xml/dba-cpu-benchmark2/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-cpu-benchmark2/](https://www.enginatics.com/reports/dba-cpu-benchmark2/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
