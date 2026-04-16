---
layout: default
title: 'DBA AWR Interconnect Traffic | Oracle EBS SQL Report'
description: 'Displays information about the usage of an interconnect device by instance in a RAC configuration. ipq - Parallel query communications dlm - Database lock…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, AWR, Interconnect, Traffic, dba_hist_snapshot, dba_hist_ic_client_stats'
permalink: /DBA%20AWR%20Interconnect%20Traffic/
---

# DBA AWR Interconnect Traffic – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-interconnect-traffic/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Displays information about the usage of an interconnect device by instance in a RAC configuration.

ipq - Parallel query communications
dlm - Database lock management
cache - Global cache communications

All other values are internal to Oracle and are not expected to have high usage.

## Report Parameters
Date From, Date To, Name, Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[dba_hist_snapshot](https://www.enginatics.com/library/?pg=1&find=dba_hist_snapshot), [dba_hist_ic_client_stats](https://www.enginatics.com/library/?pg=1&find=dba_hist_ic_client_stats)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [DBA AWR Latch by Time](/DBA%20AWR%20Latch%20by%20Time/ "DBA AWR Latch by Time Oracle EBS SQL Report"), [DBA AWR Settings](/DBA%20AWR%20Settings/ "DBA AWR Settings Oracle EBS SQL Report"), [DBA AWR System Time Percentages](/DBA%20AWR%20System%20Time%20Percentages/ "DBA AWR System Time Percentages Oracle EBS SQL Report"), [DBA AWR PGA History](/DBA%20AWR%20PGA%20History/ "DBA AWR PGA History Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Wait Class by Time](/DBA%20AWR%20Wait%20Class%20by%20Time/ "DBA AWR Wait Class by Time Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR Interconnect Traffic 24-Aug-2024 132126.xlsx](https://www.enginatics.com/example/dba-awr-interconnect-traffic/) |
| Blitz Report™ XML Import | [DBA_AWR_Interconnect_Traffic.xml](https://www.enginatics.com/xml/dba-awr-interconnect-traffic/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-awr-interconnect-traffic/](https://www.enginatics.com/reports/dba-awr-interconnect-traffic/) |

## Executive Summary
The **DBA AWR Interconnect Traffic** report is essential for managing Oracle Real Application Clusters (RAC). In a RAC environment, instances communicate over a private high-speed network (the Interconnect) to share data blocks and manage locks. If this network becomes congested, the entire cluster's performance suffers. This report monitors the traffic across this critical link.

## Business Challenge
*   **RAC Scalability**: "Why does adding a node make the application slower?" (Often due to excessive interconnect traffic).
*   **Application Design**: Identifying "Chatty" applications that constantly move data blocks between instances (Global Cache Transfer).
*   **Network Sizing**: Verifying if the private network bandwidth is sufficient for the workload.

## Solution
This report displays traffic statistics for the interconnect.

**Key Features:**
*   **Traffic Types**: Breaks down traffic by category:
    *   `ipq`: Parallel Query (often high bandwidth).
    *   `dlm`: Distributed Lock Manager (locking coordination).
    *   `cache`: Global Cache (block transfers).
*   **Instance View**: Shows traffic per instance.

## Architecture
The report queries `DBA_HIST_IC_CLIENT_STATS`.

**Key Tables:**
*   `DBA_HIST_IC_CLIENT_STATS`: Interconnect statistics history.

## Impact
*   **Cluster Stability**: Prevents node evictions caused by interconnect saturation.
*   **Performance Tuning**: Highlights the need for "Application Partitioning" (keeping related data on the same node) to reduce traffic.
*   **Infrastructure Validation**: Confirms that the network hardware is performing as expected.


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
