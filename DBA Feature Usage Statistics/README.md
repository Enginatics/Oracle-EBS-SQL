---
layout: default
last_modified_at: 2026-10-19
title: 'DBA Feature Usage Statistics | Oracle EBS SQL Report'
description: 'Database license feature usage statistics, such as the number of times that an AWR HTML report was run'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, Feature, Usage, Statistics, dba_feature_usage_statistics, v$database'
permalink: /DBA%20Feature%20Usage%20Statistics/
report_name: 'DBA Feature Usage Statistics'
report_web_name: dba-feature-usage-statistics
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Feature Usage Statistics – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-feature-usage-statistics/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-feature-usage-statistics) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-feature-usage-statistics).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Database license feature usage statistics, such as the number of times that an AWR HTML report was run

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-feature-usage-statistics) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[dba_feature_usage_statistics](https://www.enginatics.com/library/?pg=1&find=dba_feature_usage_statistics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-feature-usage-statistics), [v$database](https://www.enginatics.com/library/?pg=1&find=v%24database&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-feature-usage-statistics)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-feature-usage-statistics)

## Related Reports
[DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [DBA AWR Tablespace Usage](/DBA%20AWR%20Tablespace%20Usage/ "DBA AWR Tablespace Usage Oracle EBS SQL Report"), [DBA Database Parameter Validation](/DBA%20Database%20Parameter%20Validation/ "DBA Database Parameter Validation Oracle EBS SQL Report"), [INV Movement Statistics](/INV%20Movement%20Statistics/ "INV Movement Statistics Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA AWR Settings](/DBA%20AWR%20Settings/ "DBA AWR Settings Oracle EBS SQL Report"), [DIS Access Privileges](/DIS%20Access%20Privileges/ "DIS Access Privileges Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Feature%20Usage%20Statistics/DBA%20Feature%20Usage%20Statistics.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-feature-usage-statistics) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Feature Usage Statistics 22-Dec-2025 084053.xlsx](https://www.enginatics.com/example/dba-feature-usage-statistics/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-feature-usage-statistics) |
| Blitz Report™ XML Import | [DBA_Feature_Usage_Statistics.xml](https://www.enginatics.com/xml/dba-feature-usage-statistics/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-feature-usage-statistics) |
| SQL Source | [DBA Feature Usage Statistics.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Feature%20Usage%20Statistics/DBA%20Feature%20Usage%20Statistics.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-feature-usage-statistics/](https://www.enginatics.com/reports/dba-feature-usage-statistics/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-feature-usage-statistics) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-feature-usage-statistics)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-feature-usage-statistics)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-feature-usage-statistics)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-feature-usage-statistics)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-feature-usage-statistics)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-feature-usage-statistics)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-feature-usage-statistics)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
