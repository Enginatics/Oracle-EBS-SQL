---
layout: default
last_modified_at: 2026-10-26
title: 'GL Periods | Oracle EBS SQL Report'
description: 'Geleral ledger calendars and accounting periods – Oracle EBS General Ledger SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, General Ledger, Enginatics, R12 only, Periods, gl_period_statuses, gl_period_sets, gl_periods'
permalink: /GL%20Periods/
report_name: 'GL Periods'
report_web_name: gl-periods
module: 'General Ledger'
module_url: /modules/general-ledger/
---

# GL Periods – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-periods/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-periods) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-periods).
**Oracle EBS module:** [General Ledger](/modules/general-ledger/ "Oracle EBS General Ledger reports") · [all General Ledger reports](/modules/general-ledger/)  

## Overview
Geleral ledger calendars and accounting periods

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-periods) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Period From, Period To, Calendar, Period Type, Ledger, Chart of Accounts

## Oracle EBS Tables Used
[gl_period_statuses](https://www.enginatics.com/library/?pg=1&find=gl_period_statuses&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-periods), [gl_period_sets](https://www.enginatics.com/library/?pg=1&find=gl_period_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-periods), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-periods), [gl_period_types](https://www.enginatics.com/library/?pg=1&find=gl_period_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-periods)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-periods), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-periods)

## Related Reports
[AP Invoices and Lines 11i](/AP%20Invoices%20and%20Lines%2011i/ "AP Invoices and Lines 11i Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Periods/GL%20Periods.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-periods) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL Periods 24-May-2025 162348.xlsx](https://www.enginatics.com/example/gl-periods/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-periods) |
| Blitz Report™ XML Import | [GL_Periods.xml](https://www.enginatics.com/xml/gl-periods/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-periods) |
| SQL Source | [GL Periods.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Periods/GL%20Periods.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/gl-periods/](https://www.enginatics.com/reports/gl-periods/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-periods) |

## GL Periods - Case Study & Technical Analysis

### Executive Summary
The **GL Periods** report is a master data report that lists the definitions of accounting periods within the General Ledger calendars. It details the start dates, end dates, quarter, and fiscal year for each period. This report is used to verify the calendar setup, ensuring that fiscal years are correctly defined and that there are no gaps or overlaps in the accounting calendar.

### Business Use Cases
*   **Calendar Validation**: Verifies that the accounting calendar for the upcoming fiscal year has been defined correctly before the new year begins.
*   **System Setup Verification**: Ensures that the "Adjusting" periods are correctly flagged and that the period names follow the corporate naming convention.
*   **Reporting Alignment**: Helps align external reporting deadlines with the system's defined period end dates.
*   **Troubleshooting**: Assists in resolving issues where a date derivation fails because a date falls into a gap between defined periods.

### Technical Analysis

#### Core Tables
*   `GL_PERIODS`: The master table containing the period definitions for each period set.
*   `GL_PERIOD_SETS`: Defines the calendar name and type.
*   `GL_PERIOD_TYPES`: Defines the frequency (Month, Quarter, Year).
*   `GL_PERIOD_STATUSES`: (Optional) May be joined to show the current status of these periods for a specific ledger.

#### Key Joins & Logic
*   **Calendar Definition**: The query selects from `GL_PERIODS`, often filtering by the `PERIOD_SET_NAME` associated with the user's ledger.
*   **Date Logic**: It displays `START_DATE` and `END_DATE`. Critical logic often involves checking that `END_DATE` of Period N is exactly one day before `START_DATE` of Period N+1.
*   **Adjustment Flag**: Highlights periods where `ADJUSTMENT_PERIOD_FLAG = 'Y'`, which are used for year-end closing entries.

#### Key Parameters
*   **Calendar**: The specific accounting calendar to view.
*   **Period Type**: Filter by Month, Quarter, or Year.
*   **Period From/To**: Range of periods to display.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-periods)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-periods)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-periods)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-periods)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-periods)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-periods)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-periods)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
