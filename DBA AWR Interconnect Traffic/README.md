---
layout: default
last_modified_at: 2026-10-16
title: 'DBA AWR Interconnect Traffic | Oracle EBS SQL Report'
description: 'Displays information about the usage of an interconnect device by instance in a RAC configuration. ipq - Parallel query communications dlm - Database lock…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, AWR, Interconnect, Traffic, dba_hist_snapshot, dba_hist_ic_client_stats'
permalink: /DBA%20AWR%20Interconnect%20Traffic/
report_name: 'DBA AWR Interconnect Traffic'
report_web_name: dba-awr-interconnect-traffic
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA AWR Interconnect Traffic – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-interconnect-traffic/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-interconnect-traffic) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-interconnect-traffic).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Displays information about the usage of an interconnect device by instance in a RAC configuration.

ipq - Parallel query communications
dlm - Database lock management
cache - Global cache communications

All other values are internal to Oracle and are not expected to have high usage.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-interconnect-traffic) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Date From, Date To, Name, Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[dba_hist_snapshot](https://www.enginatics.com/library/?pg=1&find=dba_hist_snapshot&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-interconnect-traffic), [dba_hist_ic_client_stats](https://www.enginatics.com/library/?pg=1&find=dba_hist_ic_client_stats&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-interconnect-traffic)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-interconnect-traffic)

## Related Reports
[DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [DBA AWR Latch by Time](/DBA%20AWR%20Latch%20by%20Time/ "DBA AWR Latch by Time Oracle EBS SQL Report"), [DBA AWR Settings](/DBA%20AWR%20Settings/ "DBA AWR Settings Oracle EBS SQL Report"), [DBA AWR System Time Percentages](/DBA%20AWR%20System%20Time%20Percentages/ "DBA AWR System Time Percentages Oracle EBS SQL Report"), [DBA AWR PGA History](/DBA%20AWR%20PGA%20History/ "DBA AWR PGA History Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Wait Class by Time](/DBA%20AWR%20Wait%20Class%20by%20Time/ "DBA AWR Wait Class by Time Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20AWR%20Interconnect%20Traffic/DBA%20AWR%20Interconnect%20Traffic.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-interconnect-traffic) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR Interconnect Traffic 24-Aug-2024 132126.xlsx](https://www.enginatics.com/example/dba-awr-interconnect-traffic/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-interconnect-traffic) |
| Blitz Report™ XML Import | [DBA_AWR_Interconnect_Traffic.xml](https://www.enginatics.com/xml/dba-awr-interconnect-traffic/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-interconnect-traffic) |
| SQL Source | [DBA AWR Interconnect Traffic.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20AWR%20Interconnect%20Traffic/DBA%20AWR%20Interconnect%20Traffic.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-awr-interconnect-traffic/](https://www.enginatics.com/reports/dba-awr-interconnect-traffic/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-interconnect-traffic) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-interconnect-traffic)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-interconnect-traffic)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-interconnect-traffic)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-interconnect-traffic)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-interconnect-traffic)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-interconnect-traffic)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-interconnect-traffic)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
