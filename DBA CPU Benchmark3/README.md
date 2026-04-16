---
layout: default
title: 'DBA CPU Benchmark3 | Oracle EBS SQL Report'
description: 'This Benchmark report measures a database server''s CPU performance for arithmetic calculations by calculating about 40 million square roots. example…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, CPU, Benchmark3, dual'
permalink: /DBA%20CPU%20Benchmark3/
---

# DBA CPU Benchmark3 – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-cpu-benchmark3/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
This Benchmark report measures a database server's CPU performance for arithmetic calculations by calculating about 40 million square roots.

example performance for different CPU types:
seconds	rows/s	CPU
7	285714	AMD Ryzen 9 5950X 16-Core Processor
13	153846	
12	166667	AMD EPYC 7742 64-Core Processor
31	64516	Exadata CS X8M
42	47619	Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz
42	47619	Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
41	48780	Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz
41	48780	Intel(R) Xeon(R) CPU E5-2670 v2 @ 2.50GHz
43	46512	Intel(R) Xeon(R) CPU E5-2686 v4 @ 2.30GHz 
49	40816	Intel(R) Xeon(R) Platinum 8167M CPU @ 2.00GHz
47	42553	Intel(R) Xeon(R) Platinum 8167M CPU @ 2.00GHz
115	17391	SPARC-T5, chipid 1, clock 3600 MHz

## Report Parameters


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
| Excel Example Output | [DBA CPU Benchmark3 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/dba-cpu-benchmark3/) |
| Blitz Report™ XML Import | [DBA_CPU_Benchmark3.xml](https://www.enginatics.com/xml/dba-cpu-benchmark3/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-cpu-benchmark3/](https://www.enginatics.com/reports/dba-cpu-benchmark3/) |

## Executive Summary
The **DBA CPU Benchmark3** report is a specialized CPU test that focuses on floating-point arithmetic performance. Unlike the other benchmarks that test general PL/SQL loop speed or data generation, this report forces the CPU to calculate 40 million square roots. This is particularly useful for assessing the performance of scientific or financial calculations.

## Business Challenge
*   **Math-Intensive Workloads**: "We run complex forecasting models. Which server is best for number crunching?"
*   **FPU Testing**: "Is the Floating Point Unit (FPU) on this new chip architecture efficient?"
*   **Comparative Analysis**: "How does the new ARM-based processor compare to x86 for math operations?"

## Solution
This report executes a query that performs millions of `SQRT()` calculations.

**Key Features:**
*   **Floating Point Stress**: Specifically targets the FPU (Floating Point Unit) of the processor.
*   **Minimal I/O**: Like other benchmarks, it runs from memory to isolate CPU performance.
*   **Reference Data**: Includes benchmark results for various CPU architectures (e.g., AMD EPYC, Intel Xeon).

## Architecture
The report queries `DUAL`.

**Key Tables:**
*   `DUAL`: Used as the row generator.

## Impact
*   **Workload Placement**: Helps decide which server pool should host math-intensive batch jobs.
*   **Hardware Selection**: Provides data to support purchasing decisions for high-performance computing (HPC) tasks.
*   **Performance Baseline**: Establishes a baseline for arithmetic performance.


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
