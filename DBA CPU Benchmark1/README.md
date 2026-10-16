---
layout: default
last_modified_at: 2026-10-16
title: 'DBA CPU Benchmark1 | Oracle EBS SQL Report'
description: 'Benchmark report to measure a database server''s CPU speed, mainly for PLSQL processing. This report generates an output file of 500000 out of a total of…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, CPU, Benchmark1, fnd_languages, fnd_currencies, fnd_application'
permalink: /DBA%20CPU%20Benchmark1/
report_name: 'DBA CPU Benchmark1'
report_web_name: dba-cpu-benchmark1
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA CPU Benchmark1 – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-cpu-benchmark1/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark1) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark1).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Benchmark report to measure a database server's CPU speed, mainly for PLSQL processing.
This report generates an output file of 500000 out of a total of 561495 records from a cartesian product based on EBS standard FND tables. These tables contain the same data for all EBS clients and the report can be used as a benchmark to test the database server's CPU performance.
As the query itself should complete in less than a second, most of the execution time is spend in PLSQL code to generate the Blitz Report output file.
To measure meaningful results, there should be enough SGA memory assigned to ensure that the execution time is entirely spent on CPU and not IO related wait events (to be confirmed using the DBA SGA Active Session History report).

example performance for different CPU types:
seconds	rows/s	CPU
8	62500	AMD Ryzen 9 5950X 16-Core Processor
12	41667
13	38462	AMD EPYC 7742 64-Core Processor
16	31250	Exadata CS X8M
20	25000	Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz
22	22727	Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
23	21739	Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz
25	20000	Intel(R) Xeon(R) CPU E5-2670 v2 @ 2.50GHz
28	17857	Intel(R) Xeon(R) CPU E5-2686 v4 @ 2.30GHz 
29	17241	Intel(R) Xeon(R) Platinum 8167M CPU @ 2.00GHz
39	12821	Intel(R) Xeon(R) Platinum 8167M CPU @ 2.00GHz
140	3571	SPARC-T5 chipid 1, clock 3600 MHz

Oracle Ace Johannes Michler from Promatis has written a blog about this topic:
<a href="https://promatis.com/de/benchmarking-cpus-for-oracle-e-business-suite-database/" rel="nofollow" target="_blank">https://promatis.com/de/benchmarking-cpus-for-oracle-e-business-suite-database/</a>

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark1) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Row Number

## Oracle EBS Tables Used
[fnd_languages](https://www.enginatics.com/library/?pg=1&find=fnd_languages&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark1), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark1), [fnd_application](https://www.enginatics.com/library/?pg=1&find=fnd_application&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark1)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark1)

## Related Reports
[FND Forms Personalizations](/FND%20Forms%20Personalizations/ "FND Forms Personalizations Oracle EBS SQL Report"), [FND Lookup Values](/FND%20Lookup%20Values/ "FND Lookup Values Oracle EBS SQL Report"), [CST Detailed Item Cost](/CST%20Detailed%20Item%20Cost/ "CST Detailed Item Cost Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20CPU%20Benchmark1/DBA%20CPU%20Benchmark1.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark1) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/dba-cpu-benchmark1/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark1) |
| Blitz Report™ XML Import | [DBA_CPU_Benchmark1.xml](https://www.enginatics.com/xml/dba-cpu-benchmark1/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark1) |
| SQL Source | [DBA CPU Benchmark1.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20CPU%20Benchmark1/DBA%20CPU%20Benchmark1.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-cpu-benchmark1/](https://www.enginatics.com/reports/dba-cpu-benchmark1/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark1) |

## Executive Summary
The **DBA CPU Benchmark1** report is a synthetic benchmark designed to measure the single-threaded CPU performance of the database server. It generates a large dataset (500,000 rows) by creating a Cartesian product of standard Oracle EBS tables (`FND_LANGUAGES`, `FND_CURRENCIES`, `FND_APPLICATION`). The execution time is dominated by the PL/SQL engine's ability to process these rows and generate the output, making it a good proxy for PL/SQL performance.

## Business Challenge
*   **Hardware Validation**: "We migrated to new servers. Are the CPUs actually faster?"
*   **Cloud Migration**: "How does the performance of an AWS r5.xlarge compare to our on-premise Exadata?"
*   **Baseline Creation**: Establishing a performance baseline before applying OS patches or upgrades.

## Solution
This report runs a query that forces the database to do significant work (generating rows) and measures the elapsed time.

**Key Features:**
*   **Standardized Workload**: Uses standard FND tables present in every EBS instance, ensuring comparability.
*   **CPU Bound**: Designed to be CPU-intensive (assuming the data is in the buffer cache), minimizing I/O noise.
*   **Comparative Data**: The description includes reference timings for various processors (e.g., AMD Ryzen, Intel Xeon).

## Architecture
The report queries `FND_LANGUAGES`, `FND_CURRENCIES`, and `FND_APPLICATION`.

**Key Tables:**
*   `FND_LANGUAGES`, `FND_CURRENCIES`, `FND_APPLICATION`: Used as data sources for the Cartesian product.

## Impact
*   **Vendor Accountability**: Verifies that the cloud provider or hardware vendor is delivering the promised performance.
*   **Sizing Decisions**: Helps determine the correct CPU SKU for a new deployment.
*   **Performance Troubleshooting**: Rules out (or confirms) "slow CPU" as a cause of general system sluggishness.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark1)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark1)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark1)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark1)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark1)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark1)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-cpu-benchmark1)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
