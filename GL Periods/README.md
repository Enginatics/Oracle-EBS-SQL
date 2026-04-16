---
layout: default
title: 'GL Periods | Oracle EBS SQL Report'
description: 'Geleral ledger calendars and accounting periods – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Periods, gl_period_statuses, gl_period_sets, gl_periods'
permalink: /GL%20Periods/
---

# GL Periods – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-periods/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Geleral ledger calendars and accounting periods

## Report Parameters
Period From, Period To, Calendar, Period Type, Ledger, Chart of Accounts

## Oracle EBS Tables Used
[gl_period_statuses](https://www.enginatics.com/library/?pg=1&find=gl_period_statuses), [gl_period_sets](https://www.enginatics.com/library/?pg=1&find=gl_period_sets), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods), [gl_period_types](https://www.enginatics.com/library/?pg=1&find=gl_period_types)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [AP Invoices and Lines 11i](/AP%20Invoices%20and%20Lines%2011i/ "AP Invoices and Lines 11i Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC OPM Batch Material Summary](/CAC%20OPM%20Batch%20Material%20Summary/ "CAC OPM Batch Material Summary Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL Periods 24-May-2025 162348.xlsx](https://www.enginatics.com/example/gl-periods/) |
| Blitz Report™ XML Import | [GL_Periods.xml](https://www.enginatics.com/xml/gl-periods/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-periods/](https://www.enginatics.com/reports/gl-periods/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
