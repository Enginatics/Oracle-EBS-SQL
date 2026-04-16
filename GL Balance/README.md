---
layout: default
title: 'GL Balance | Oracle EBS SQL Report'
description: 'Summary GL report including one line per accounting period for each account segment level, including product code, with amounts for opening balance…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Balance, fnd_lookup_values_vl, gl_budget_versions, gl_encumbrance_types'
permalink: /GL%20Balance/
---

# GL Balance – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-balance/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Summary GL report including one line per accounting period for each account segment level, including product code, with amounts for opening balance, debits, credits, change amount, ending balance.

## Report Parameters
Ledger, Currency Type, Entered Currency, Period, Period From, Period To, Show Start Balance, Show Company, Show Account, Show Cost Center, Show Intercompany, Show All Segments, Account Type, Summary Template, Hierarchy Segment, Hierarchy Name, Concatenated Segments, GL_SEGMENT1, GL_SEGMENT1 From, GL_SEGMENT1 To, GL_SEGMENT2, GL_SEGMENT2 From, GL_SEGMENT2 To, GL_SEGMENT3, GL_SEGMENT3 From, GL_SEGMENT3 To, GL_SEGMENT4, GL_SEGMENT4 From, GL_SEGMENT4 To, GL_SEGMENT5, GL_SEGMENT5 From, GL_SEGMENT5 To, GL_SEGMENT6, GL_SEGMENT6 From, GL_SEGMENT6 To, GL_SEGMENT7, GL_SEGMENT7 From, GL_SEGMENT7 To, GL_SEGMENT8, GL_SEGMENT8 From, GL_SEGMENT8 To, GL_SEGMENT9, GL_SEGMENT9 From, GL_SEGMENT9 To, GL_SEGMENT10, GL_SEGMENT10 From, GL_SEGMENT10 To, Revaluation Currency, Revaluation Conversion Type, Balance Type, Budget Name, Encumbrance Type, Exclude Inactive, Batch, Journal, Relative Period, Relative Period From, Relative Period To

## Oracle EBS Tables Used
[fnd_lookup_values_vl](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values_vl), [gl_budget_versions](https://www.enginatics.com/library/?pg=1&find=gl_budget_versions), [gl_encumbrance_types](https://www.enginatics.com/library/?pg=1&find=gl_encumbrance_types)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL Balance - Pivot by Account Hierarchy 26-Sep-2023 182804.xlsx](https://www.enginatics.com/example/gl-balance/) |
| Blitz Report™ XML Import | [GL_Balance.xml](https://www.enginatics.com/xml/gl-balance/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-balance/](https://www.enginatics.com/reports/gl-balance/) |

## GL Balance - Case Study & Technical Analysis

### Executive Summary
The **GL Balance** report is a comprehensive financial reporting tool that provides a summarized view of General Ledger balances. It aggregates data to one line per accounting period for each account segment level, including opening balances, period activity (debits and credits), net change, and ending balances. This report is essential for period-end close processes, trial balance verification, and high-level financial analysis, offering a clear picture of the organization's financial health across different timeframes.

### Business Challenge
Financial controllers and analysts require accurate and timely information to monitor account balances and ensure the integrity of the general ledger. Common challenges include:
- **Data Volume:** Aggregating millions of journal lines into meaningful balances can be performance-intensive.
- **Reconciliation:** verifying that opening balances plus activity equals closing balances is often a manual and error-prone process.
- **Multi-Dimensional Analysis:** Users need to slice and dice balances by various segments (Company, Cost Center, Account, etc.) which standard reports may not flexibly support.
- **Currency Management:** Handling entered versus accounted currencies and revaluation adds complexity to balance reporting.

### Solution
The **GL Balance** report addresses these challenges by providing a flexible, parameter-driven view of GL balances. It allows users to choose the level of detail and the specific segments they wish to analyze.

**Key Features:**
- **Period-Based Reporting:** Displays balances for a specific period or range of periods.
- **Segment Flexibility:** Users can toggle the display of individual segments (Company, Account, Cost Center, Intercompany) or show all segments.
- **Balance Components:** Clearly separates Opening Balance, Debits, Credits, Change Amount, and Ending Balance.
- **Currency Support:** Handles different currency types and entered currencies for detailed foreign currency analysis.
- **Hierarchy Support:** Includes options for reporting based on account hierarchies.

### Technical Architecture
The report queries the core GL balance tables, joining with master data tables to provide descriptions and hierarchy information.

#### Key Tables and Views
- **`GL_BALANCES`**: The primary source of summarized balance information, storing period-to-date and year-to-date balances for each code combination.
- **`GL_CODE_COMBINATIONS_KFV`**: Links the balance records to the specific account code combinations and their segment values.
- **`GL_LEDGERS`**: Defines the ledger context, including currency and chart of accounts.
- **`GL_PERIOD_STATUSES`**: Used to validate periods and determine the period order.
- **`FND_LOOKUP_VALUES_VL`**: Provides user-friendly descriptions for various codes and types.
- **`GL_BUDGET_VERSIONS`**: (If applicable) Used when reporting on budget balances.
- **`GL_ENCUMBRANCE_TYPES`**: (If applicable) Used when reporting on encumbrance balances.

#### Core Logic
1.  **Parameter Parsing:** The query interprets user selections for segments to determine the grouping level (e.g., group by Company and Account only).
2.  **Balance Aggregation:** It sums the `BEGIN_BALANCE_DR`, `BEGIN_BALANCE_CR`, `PERIOD_NET_DR`, and `PERIOD_NET_CR` columns from `GL_BALANCES` based on the selected criteria.
3.  **Calculation:**
    - *Opening Balance* = (Begin Dr - Begin Cr)
    - *Ending Balance* = (Opening Balance + Period Net Dr - Period Net Cr)
4.  **Filtering:** Applies filters for Ledger, Currency, Period, and Account Type to restrict the dataset.

### Business Impact
- **Faster Close:** Accelerates the month-end close process by providing instant visibility into account balances and anomalies.
- **Improved Accuracy:** Automated calculation of opening and closing balances reduces the risk of manual spreadsheet errors.
- **Enhanced Insight:** Enables multi-dimensional analysis of financial data, supporting better decision-making.
- **Audit Readiness:** Provides a transparent and traceable record of account balances for audit purposes.


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
