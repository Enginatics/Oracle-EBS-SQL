---
layout: default
title: 'GL effective vs accounting vs period start and end date comparison | Oracle EBS SQL Report'
description: 'For developers to understand the GL data: Shows the relationship between effective, accounting and period start and end dates by counting how many records…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, effective, accounting, period, start, gl_ledgers, gl_periods, gl_je_headers'
permalink: /GL%20effective%20vs%20accounting%20vs%20period%20start%20and%20end%20date%20comparison/
---

# GL effective vs accounting vs period start and end date comparison – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-effective-vs-accounting-vs-period-start-and-end-date-comparison/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
For developers to understand the GL data: Shows the relationship between effective, accounting and period start and end dates by counting how many records exist where the effective date is before or after the accounting date.

## Report Parameters
Number Of History Days

## Oracle EBS Tables Used
[gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods), [gl_je_headers](https://www.enginatics.com/library/?pg=1&find=gl_je_headers), [gl_je_lines](https://www.enginatics.com/library/?pg=1&find=gl_je_lines), [gl_import_references](https://www.enginatics.com/library/?pg=1&find=gl_import_references), [xla_ae_lines](https://www.enginatics.com/library/?pg=1&find=xla_ae_lines)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown)](/GL%20Account%20Analysis%20%28Drilldown%29/ "GL Account Analysis (Drilldown) Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL effective vs accounting vs period start and end date comparison 11-Aug-2025 112858.xlsx](https://www.enginatics.com/example/gl-effective-vs-accounting-vs-period-start-and-end-date-comparison/) |
| Blitz Report™ XML Import | [GL_effective_vs_accounting_vs_period_start_and_end_date_comparison.xml](https://www.enginatics.com/xml/gl-effective-vs-accounting-vs-period-start-and-end-date-comparison/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-effective-vs-accounting-vs-period-start-and-end-date-comparison/](https://www.enginatics.com/reports/gl-effective-vs-accounting-vs-period-start-and-end-date-comparison/) |

## GL effective vs accounting vs period start and end date comparison - Case Study & Technical Analysis

### Executive Summary
The **GL effective vs accounting vs period start and end date comparison** report is a technical diagnostic tool designed for developers and system administrators. It analyzes the temporal relationships between three critical dates in the General Ledger: the Effective Date, the Accounting Date, and the Period Start/End Dates. By identifying discrepancies (e.g., an effective date falling outside the accounting period), this report helps diagnose data integrity issues, period close problems, and potential reporting inconsistencies.

### Business Use Cases
*   **Data Integrity Audit**: Identifies transactions where the "Effective Date" (when the business event occurred) does not align with the "Accounting Date" (when it was recorded in the books), which can impact aging reports and interest calculations.
*   **Period Close Troubleshooting**: Helps resolve "unprocessed" or "stuck" journals during month-end by highlighting entries that technically fall outside the open period's date range.
*   **SLA vs. GL Reconciliation**: Assists in reconciling Subledger Accounting (SLA) entries to GL by verifying that date logic was applied consistently during the transfer process.
*   **Developer Diagnostics**: Provides a quick way for developers to understand the distribution of date mismatches across ledgers and periods when debugging custom reports or interfaces.

### Technical Analysis

#### Core Tables
*   `GL_JE_HEADERS`: Stores the `DEFAULT_EFFECTIVE_DATE` and `POSTED_DATE`.
*   `GL_JE_LINES`: Stores the `EFFECTIVE_DATE` at the line level.
*   `GL_PERIODS`: Defines the `START_DATE` and `END_DATE` for each accounting period.
*   `XLA_AE_LINES`: (Optional/Contextual) Used if tracing back to the subledger accounting layer.
*   `GL_IMPORT_REFERENCES`: Links GL lines to their source in XLA.

#### Key Joins & Logic
*   **Date Comparison Logic**: The core logic involves comparing `GL_JE_LINES.EFFECTIVE_DATE` against `GL_PERIODS.START_DATE` and `GL_PERIODS.END_DATE`.
*   **Counting Discrepancies**: The report likely aggregates data to count how many records have an effective date *before* the period start or *after* the period end.
*   **Ledger Context**: Joins to `GL_LEDGERS` to ensure the analysis is specific to a legal entity or set of books.

#### Key Parameters
*   **Number Of History Days**: A parameter to limit the lookback period for the analysis, ensuring performance and relevance.


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
