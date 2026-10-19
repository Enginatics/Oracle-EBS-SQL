---
layout: default
last_modified_at: 2026-10-19
title: 'FND Log Messages | Oracle EBS SQL Report'
description: 'Oracle EBS Application Object Library SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Log, Messages, fnd_log_messages, fnd_log_transaction_context'
permalink: /FND%20Log%20Messages/
report_name: 'FND Log Messages'
report_web_name: fnd-log-messages
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Log Messages – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-log-messages/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-log-messages) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-log-messages).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview


> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-log-messages) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
User Name, Module, Module Contains, Logged within x Days, Date From, Date To, Log Level From, Log Level To

## Oracle EBS Tables Used
[fnd_log_messages](https://www.enginatics.com/library/?pg=1&find=fnd_log_messages&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-log-messages), [fnd_log_transaction_context](https://www.enginatics.com/library/?pg=1&find=fnd_log_transaction_context&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-log-messages)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-log-messages)

## Related Reports
[CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [FND Messages](/FND%20Messages/ "FND Messages Oracle EBS SQL Report"), [DBA Database Parameter Validation](/DBA%20Database%20Parameter%20Validation/ "DBA Database Parameter Validation Oracle EBS SQL Report"), [GL Summary Account Upload](/GL%20Summary%20Account%20Upload/ "GL Summary Account Upload Oracle EBS SQL Report"), [AR Autoinvoice Interface](/AR%20Autoinvoice%20Interface/ "AR Autoinvoice Interface Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Log%20Messages/FND%20Log%20Messages.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-log-messages) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Log Messages - Summary by month - Excel pivot 30-Aug-2025 152352.xlsx](https://www.enginatics.com/example/fnd-log-messages/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-log-messages) |
| Blitz Report™ XML Import | [FND_Log_Messages.xml](https://www.enginatics.com/xml/fnd-log-messages/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-log-messages) |
| SQL Source | [FND Log Messages.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Log%20Messages/FND%20Log%20Messages.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-log-messages/](https://www.enginatics.com/reports/fnd-log-messages/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-log-messages) |

## Executive Summary
The **FND Log Messages** report provides access to the Oracle EBS debug log (FND Logging). It is the primary tool for diagnosing runtime errors and performance issues.

## Business Challenge
*   **Error Diagnosis:** Finding the specific error message and stack trace when a user reports a "System Error".
*   **Performance Tuning:** Analyzing the timing of log messages to identify slow-running code blocks.
*   **Security Audit:** Reviewing login failures or access denials logged by the system.

## The Solution
This Blitz Report queries `FND_LOG_MESSAGES`:
*   **Message Text:** The actual log entry.
*   **Module:** The code module (e.g., `fnd.plsql.Security`).
*   **User:** The user who triggered the message.
*   **Level:** The severity (Statement, Procedure, Event, Exception, Error, Unexpected).

## Technical Architecture
The report queries `FND_LOG_MESSAGES` and joins to `FND_USER` for context.

## Parameters & Filtering
*   **User Name:** Filter for logs generated by a specific user session.
*   **Module Contains:** Filter for specific code areas (e.g., `%OAF%`).
*   **Log Level:** Filter to see only Errors or Exceptions.

## Performance & Optimization
*   **High Volume:** The log table can be massive. Always filter by Date and User/Module.
*   **Retention:** Logs are typically purged daily or weekly, so run this report soon after the issue occurs.

## FAQ
*   **Q: Why is the report empty?**
    *   A: FND Logging must be enabled via profile options (`FND: Debug Log Enabled`, `FND: Debug Log Level`) for messages to be written to the database.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-log-messages)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-log-messages)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-log-messages)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-log-messages)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-log-messages)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-log-messages)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-log-messages)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
