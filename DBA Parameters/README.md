---
layout: default
title: 'DBA Parameters | Oracle EBS SQL Report'
description: 'To validate recommended settings validate following notes: Database Initialization Parameters for Oracle E-Business Suite Release 12 (Doc ID 396009.1) EBS…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, Parameters, gv$parameter'
permalink: /DBA%20Parameters/
---

# DBA Parameters – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-parameters/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
To validate recommended settings validate following notes:
Database Initialization Parameters for Oracle E-Business Suite Release 12 (Doc ID 396009.1)
EBS Database Performance and Statistics Analyzer (Doc ID 2126712.1)
Get Proactive with Oracle E-Business Suite - Product Support Analyzer Index (Doc ID 1545562.1)

## Report Parameters
Parameter Name, Non Default only, Different across Instances only

## Oracle EBS Tables Used
[gv$parameter](https://www.enginatics.com/library/?pg=1&find=gv$parameter)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/ "FND Concurrent Requests 11i Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [DBA SGA Buffer Cache Object Usage](/DBA%20SGA%20Buffer%20Cache%20Object%20Usage/ "DBA SGA Buffer Cache Object Usage Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA SGA SQL Performance Summary](/DBA%20SGA%20SQL%20Performance%20Summary/ "DBA SGA SQL Performance Summary Oracle EBS SQL Report"), [DBA SGA SQL Execution Plan History](/DBA%20SGA%20SQL%20Execution%20Plan%20History/ "DBA SGA SQL Execution Plan History Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Parameters 22-Dec-2025 084307.xlsx](https://www.enginatics.com/example/dba-parameters/) |
| Blitz Report™ XML Import | [DBA_Parameters.xml](https://www.enginatics.com/xml/dba-parameters/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-parameters/](https://www.enginatics.com/reports/dba-parameters/) |

## Executive Summary
The **DBA Parameters** report audits the database initialization parameters (`init.ora` / `spfile`). These parameters control every aspect of the database's behavior, from memory allocation (`sga_target`) to optimizer behavior (`optimizer_features_enable`). Incorrect parameters are a leading cause of performance issues and instability.

## Business Challenge
*   **Standardization**: "Does our Production database have the same parameters as our Test database?"
*   **Performance Tuning**: "Is `cursor_sharing` set to `EXACT` or `FORCE`?"
*   **Change Tracking**: "Who changed `open_cursors` from 1000 to 500?"

## Solution
This report lists the current value of all database parameters.

**Key Features:**
*   **Is Default**: Indicates if the parameter is set to its default value or has been overridden.
*   **Is Modified**: Shows if the parameter was changed in the current session.
*   **RAC Consistency**: In a RAC environment, checks if parameters are consistent across all instances.

## Architecture
The report queries `GV$PARAMETER`.

**Key Tables:**
*   `GV$PARAMETER`: The in-memory view of active parameters.

## Impact
*   **Stability**: Prevents "drift" where configuration changes are made in one environment but not others.
*   **Best Practices**: Allows DBAs to validate settings against Oracle Support recommendations (e.g., "bde_chk_cbo.sql").
*   **Troubleshooting**: Quickly rules out misconfiguration as the cause of a new issue.


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
