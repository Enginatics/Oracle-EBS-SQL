---
layout: default
title: 'DBA Alert Log | Oracle EBS SQL Report'
description: 'V$DIAGALERTEXT shows the contents of the XML-based alert log in the Automatic Diagnostic Repository (ADR) for the current container (PDB). You could…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, Alert, Log, v$diag_alert_ext'
permalink: /DBA%20Alert%20Log/
---

# DBA Alert Log – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-alert-log/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
V$DIAG_ALERT_EXT shows the contents of the XML-based alert log in the Automatic Diagnostic Repository (ADR) for the current container (PDB).
You could schedule it, for example, in incremental mode to send an email with errors that occured since the last scheduled report run.

## Report Parameters
Message Text includes, Message Type, Message Level, History Days, Date From, Exceptions and ORA-% only, Incremental Mode

## Oracle EBS Tables Used
[v$diag_alert_ext](https://www.enginatics.com/library/?pg=1&find=v$diag_alert_ext)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA Trace File Contents](/DBA%20Trace%20File%20Contents/ "DBA Trace File Contents Oracle EBS SQL Report"), [ALR Alerts](/ALR%20Alerts/ "ALR Alerts Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Alert Log - Default 08-Mar-2024 094258.xlsx](https://www.enginatics.com/example/dba-alert-log/) |
| Blitz Report™ XML Import | [DBA_Alert_Log.xml](https://www.enginatics.com/xml/dba-alert-log/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-alert-log/](https://www.enginatics.com/reports/dba-alert-log/) |

## Executive Summary
The **DBA Alert Log** report provides a direct interface to the Oracle Database's XML-based Alert Log, located within the Automatic Diagnostic Repository (ADR). The Alert Log is the primary chronological record of messages and errors for the database. This report allows DBAs to query, filter, and export these critical system messages without needing to log in to the database server OS.

## Business Challenge
*   **Proactive Monitoring**: "Did any critical errors (ORA-00600, ORA-07445) occur last night?"
*   **Accessibility**: Developers and functional support often need to see if a process failed due to a database error, but they don't have SSH access to the server.
*   **Audit**: Reviewing the history of database startups, shutdowns, and parameter changes.

## Solution
This report queries the `V$DIAG_ALERT_EXT` view to present the alert log contents in a tabular format.

**Key Features:**
*   **Incremental Mode**: Can be scheduled to run periodically (e.g., every hour) and report only new messages since the last run.
*   **Filtering**: Parameters allow filtering by Message Text (e.g., "ORA-"), Message Level, or Timeframe.
*   **Unified View**: In a RAC environment, it can potentially show alerts from the local instance (or all, depending on the view definition).

## Architecture
The report leverages the ADR infrastructure introduced in Oracle 11g.

**Key Tables:**
*   `V$DIAG_ALERT_EXT`: The external table view that parses the XML alert log file.

## Impact
*   **Uptime**: Enables faster detection and resolution of critical database errors.
*   **Security**: Provides read-only access to logs without granting OS privileges.
*   **Efficiency**: Automates the daily check of the alert log via scheduled email delivery.


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
