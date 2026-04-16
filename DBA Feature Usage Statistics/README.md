---
layout: default
title: 'DBA Feature Usage Statistics | Oracle EBS SQL Report'
description: 'Database license feature usage statistics, such as the number of times that an AWR HTML report was run'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, Feature, Usage, Statistics, dba_feature_usage_statistics, v$database'
permalink: /DBA%20Feature%20Usage%20Statistics/
---

# DBA Feature Usage Statistics – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-feature-usage-statistics/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Database license feature usage statistics, such as the number of times that an AWR HTML report was run

## Report Parameters


## Oracle EBS Tables Used
[dba_feature_usage_statistics](https://www.enginatics.com/library/?pg=1&find=dba_feature_usage_statistics), [v$database](https://www.enginatics.com/library/?pg=1&find=v$database)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR Tablespace Usage](/DBA%20AWR%20Tablespace%20Usage/ "DBA AWR Tablespace Usage Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [INV Movement Statistics](/INV%20Movement%20Statistics/ "INV Movement Statistics Oracle EBS SQL Report"), [DBA AWR Settings](/DBA%20AWR%20Settings/ "DBA AWR Settings Oracle EBS SQL Report"), [DIS Access Privileges](/DIS%20Access%20Privileges/ "DIS Access Privileges Oracle EBS SQL Report"), [DBA Tablespace Usage](/DBA%20Tablespace%20Usage/ "DBA Tablespace Usage Oracle EBS SQL Report"), [DBA AWR Interconnect Traffic](/DBA%20AWR%20Interconnect%20Traffic/ "DBA AWR Interconnect Traffic Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Feature Usage Statistics 22-Dec-2025 084053.xlsx](https://www.enginatics.com/example/dba-feature-usage-statistics/) |
| Blitz Report™ XML Import | [DBA_Feature_Usage_Statistics.xml](https://www.enginatics.com/xml/dba-feature-usage-statistics/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-feature-usage-statistics/](https://www.enginatics.com/reports/dba-feature-usage-statistics/) |

## Executive Summary
The **DBA Feature Usage Statistics** report is a critical compliance tool. It queries the internal Oracle usage tracking to see which database features have been used. This is the same data that Oracle LMS (License Management Services) uses during an audit. It helps organizations avoid unexpected bills for expensive options like "Partitioning", "Advanced Compression", or "Diagnostics Pack".

## Business Challenge
*   **Audit Defense**: "Oracle is auditing us. Are we compliant with our contract?"
*   **Cost Avoidance**: "Did a developer accidentally use the 'Advanced Security' option in the new code?"
*   **License Optimization**: "We are paying for 'OLAP', but are we actually using it?"

## Solution
This report queries `DBA_FEATURE_USAGE_STATISTICS`.

**Key Features:**
*   **Feature Name**: The specific option (e.g., "Automatic Workload Repository").
*   **Detected Usages**: How many times it was used.
*   **Last Usage Date**: When it was last triggered.
*   **Currently Used**: Boolean flag indicating active usage.

## Architecture
The report queries `DBA_FEATURE_USAGE_STATISTICS`.

**Key Tables:**
*   `DBA_FEATURE_USAGE_STATISTICS`: The system-maintained usage log.

## Impact
*   **Financial Risk Reduction**: Prevents multi-million dollar non-compliance fines.
*   **Governance**: Enforces internal policies regarding which features developers are allowed to use.
*   **Contract Negotiation**: Provides data to negotiate better terms during license renewals.


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
