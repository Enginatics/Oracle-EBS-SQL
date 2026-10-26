---
layout: default
last_modified_at: 2026-10-26
title: 'XLA Subledger Period Close Exceptions | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Description: This report extracts all those events which are either untransferred or are not accounted for. Application…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Subledger Accounting, Enginatics, R12 only, XLA, Subledger, Period, Close, fnd_application_vl'
permalink: /XLA%20Subledger%20Period%20Close%20Exceptions/
report_name: 'XLA Subledger Period Close Exceptions'
report_web_name: xla-subledger-period-close-exceptions
module: 'Subledger Accounting'
module_url: /modules/subledger-accounting/
---

# XLA Subledger Period Close Exceptions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/xla-subledger-period-close-exceptions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-period-close-exceptions) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-period-close-exceptions).
**Oracle EBS module:** [Subledger Accounting](/modules/subledger-accounting/ "Oracle EBS Subledger Accounting reports") · [all Subledger Accounting reports](/modules/subledger-accounting/)  

## Overview
Imported from BI Publisher
Description: This report extracts all those events which are either untransferred or are not accounted for.
Application: Subledger Accounting
Source: Subledger Period Close Exceptions Report
Short Name: XLAPEXRPT
DB package: XLA_PERIOD_CLOSE_EXP_PKG

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-period-close-exceptions) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Journal Source, Ledger/Ledger Set, Period From, Period To, Event Class, Journal Category

## Oracle EBS Tables Used
[fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-period-close-exceptions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-period-close-exceptions), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-period-close-exceptions)

## Related Reports
[FND Flex Value Sets, Usages and Values](/FND%20Flex%20Value%20Sets-%20Usages%20and%20Values/ "FND Flex Value Sets, Usages and Values Oracle EBS SQL Report"), [FND Lookup Upload](/FND%20Lookup%20Upload/ "FND Lookup Upload Oracle EBS SQL Report"), [FND Cross-Validation Rules](/FND%20Cross-Validation%20Rules/ "FND Cross-Validation Rules Oracle EBS SQL Report"), [FND Responsibilities](/FND%20Responsibilities/ "FND Responsibilities Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [AR Aging](/AR%20Aging/ "AR Aging Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [CAC Accounting Period Status](/CAC%20Accounting%20Period%20Status/ "CAC Accounting Period Status Oracle EBS SQL Report"), [OPM Recipe Upload](/OPM%20Recipe%20Upload/ "OPM Recipe Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/XLA%20Subledger%20Period%20Close%20Exceptions/XLA%20Subledger%20Period%20Close%20Exceptions.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-period-close-exceptions) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [XLA Subledger Period Close Exceptions - Default 04-May-2024 063410.xlsx](https://www.enginatics.com/example/xla-subledger-period-close-exceptions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-period-close-exceptions) |
| Blitz Report™ XML Import | [XLA_Subledger_Period_Close_Exceptions.xml](https://www.enginatics.com/xml/xla-subledger-period-close-exceptions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-period-close-exceptions) |
| SQL Source | [XLA Subledger Period Close Exceptions.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/XLA%20Subledger%20Period%20Close%20Exceptions/XLA%20Subledger%20Period%20Close%20Exceptions.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/xla-subledger-period-close-exceptions/](https://www.enginatics.com/reports/xla-subledger-period-close-exceptions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-period-close-exceptions) |

## Case Study & Technical Analysis: XLA Subledger Period Close Exceptions Report

### Executive Summary

The XLA Subledger Period Close Exceptions report is a critical financial closing and reconciliation tool for Oracle Subledger Accounting (SLA). It identifies and lists all subledger events that are either untransferred to the General Ledger (GL) or have not been accounted for, thus preventing a successful period close. This report is indispensable for finance teams, GL accountants, and system administrators to proactively resolve outstanding accounting issues, ensure timely completion of the financial close, and maintain the integrity and completeness of financial data originating from various Oracle modules.

### Business Challenge

One of the most significant challenges during the financial close process is ensuring that all subledger transactions have been fully accounted for and transferred to the General Ledger. Failure to do so can lead to an unbalanced GL and an inability to close the accounting period. Organizations frequently face:

-   **Delayed Financial Close:** Unaccounted or untransferred subledger events are a primary reason for delays in month-end and year-end financial closes, impacting the timeliness of financial reporting and compliance.
-   **Reconciliation Discrepancies:** If transactions are not fully accounted for in SLA and transferred to the GL, it leads to discrepancies between subledger reports and GL balances, requiring time-consuming manual investigation.
-   **Identifying Root Causes:** Pinpointing which specific events are causing period close exceptions (e.g., a batch of invoices not accounted for, or a project transaction stuck in SLA) can be difficult without a dedicated report.
-   **Compliance and Audit Risk:** Incomplete or inaccurate accounting for subledger transactions poses a significant risk to financial statement accuracy and compliance with accounting regulations and audit requirements.

### The Solution

This report offers a powerful, detailed, and actionable solution for identifying and resolving Subledger Period Close Exceptions, accelerating the financial close process.

-   **Clear Exception Identification:** It extracts and lists all subledger events that are preventing the period close, clearly identifying those that are untransferred to GL or unaccounted for.
-   **Granular Detail for Investigation:** The report provides details about the source of the transaction (e.g., `Journal Source`, `Event Class`), allowing finance teams to quickly pinpoint the originating module and transaction type for targeted investigation.
-   **Accelerated Resolution:** By providing a focused list of exceptions, the report enables accountants to prioritize their efforts, address the underlying issues (e.g., run accounting programs, fix data errors), and resolve the exceptions quickly.
-   **Improved Financial Integrity:** Ensuring all subledger events are fully accounted for and transferred to the GL maintains the integrity and completeness of financial data, leading to more accurate financial statements.

### Technical Architecture (High Level)

This report queries underlying Oracle Subledger Accounting (XLA) tables, which store the status of accounting events and their transfer to the General Ledger. It is an enhanced version of a standard Oracle BI Publisher report.

-   **Primary Tables Involved:**
    -   `XLA_EVENTS` (the central table for subledger accounting events).
    -   `XLA_AE_HEADERS` (for accounting entry headers, which contain the status of accounting generation and transfer to GL).
    -   `XLA_TRANSACTION_ENTITIES` (links events to the originating subledger transactions).
    -   `FND_APPLICATION_VL` (to provide the application name, e.g., 'Payables', 'Receivables', 'Projects', 'Inventory').
    -   `GL_LEDGERS` and `GL_PERIODS` (for ledger and period context).
-   **Logical Relationships:** The report selects events from `XLA_EVENTS` and `XLA_AE_HEADERS` where the accounting status is not 'Final' or the transfer status to GL is not 'Transferred', for the specified period and journal source. It links these exceptions back to the originating `Journal Source` (subledger application) and `Event Class` (type of transaction, e.g., 'Invoices', 'Payments') to provide context for debugging.

### Parameters & Filtering

The report offers flexible parameters for targeted analysis of period close exceptions:

-   **Journal Source:** Filters by the originating subledger application (e.g., 'Payables', 'Receivables', 'Projects'). This is crucial for isolating exceptions by module.
-   **Ledger/Ledger Set:** Defines the financial reporting entity.
-   **Period From/To:** Critical for defining the specific accounting period(s) for which exceptions are to be identified.
-   **Event Class:** Filters by the specific type of transaction (e.g., 'Invoices', 'Payments', 'Adjustments') within a subledger.
-   **Journal Category:** Filters by the GL journal category assigned to the accounting entries.

### Performance & Optimization

As a critical period-end report querying transactional SLA data, it is optimized by strong period and source-driven filtering.

-   **Period and Source Filtering:** The `Period From/To` and `Journal Source` parameters are extremely critical for performance. They allow the database to efficiently narrow down the large volumes of `XLA_EVENTS` and `XLA_AE_HEADERS` data to the specific timeframe and originating subledger, leveraging existing indexes.
-   **Targeted Exception Identification:** The report's SQL is specifically designed to query for records that meet the exception criteria (unaccounted or untransferred), avoiding full table scans of all SLA data.

### FAQ

**1. What does 'Untransferred' mean in the context of SLA period close exceptions?**
   'Untransferred' means that the accounting entries for the subledger event have been successfully generated in Subledger Accounting (SLA), but they have not yet been transferred from SLA to the General Ledger. This typically requires running a concurrent program like "Create Accounting" or "Transfer Journal Entries to GL."

**2. What does 'Unaccounted' mean?**
   'Unaccounted' means that the subledger event has occurred (e.g., an invoice was validated), but the accounting entries for that event have not yet been generated in Subledger Accounting (SLA). This usually indicates that the "Create Accounting" concurrent program needs to be run for the relevant subledger and period.

**3. How can I use this report to prevent future period close exceptions?**
   By regularly running this report throughout the accounting period (not just at month-end), finance teams can identify and resolve exceptions proactively. Analyzing common `Journal Source`s or `Event Class`es that frequently appear as exceptions can also highlight systemic issues in configuration or business processes that need to be addressed.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-period-close-exceptions)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-period-close-exceptions)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-period-close-exceptions)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-period-close-exceptions)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-period-close-exceptions)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-period-close-exceptions)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=xla-subledger-period-close-exceptions)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
