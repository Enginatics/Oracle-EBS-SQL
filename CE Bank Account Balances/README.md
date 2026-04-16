---
layout: default
title: 'CE Bank Account Balances | Oracle EBS SQL Report'
description: 'Application: Cash Management Description: Bank Accounts - Balances Report Provides equivalent functionality to the following standard Oracle Forms/Reports…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Bank, Account, Balances, ce_bank_acct_balances, ce_projected_balances, ce_bank_acct_bal_qry1'
permalink: /CE%20Bank%20Account%20Balances/
---

# CE Bank Account Balances – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ce-bank-account-balances/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Application: Cash Management
Description: Bank Accounts - Balances Report

Provides equivalent functionality to the following standard Oracle Forms/Reports
- Bank Account Balances OAF Page
- Bank Account Balance Range Day Report
- Bank Account Balance Single Date Report
- Bank Account Balance Actual vs Projected Report

Single (As Of) Date Report
- Specify the required Date in the As Of Date parameter
- Specify Yes in the 'Bring Forward Prior Balances' if you want to roll the most recent prior balance entries forward if a balance does not exist on the specified As Of Date
- Specify No in the  'Bring Forward Prior Balances' if you only want to see the balances that have been entered on the specified As Of Date.
- Applicable Templates:
  Pivot: As of Date Summary by Currency and Account
  Detail As of Date/Range Date Report  

Range Day Report
- Specify the required date range in the Balance Date From/To Parameters
- When run in this mode the report shows the balances entered for every date within the date range.
- Balances are not rolled forward in this mode.
- Applicable Templates:
  Detail As of Date/Range Date Report  

Actual vs Projected Report
- The report includes actual and projected balances in both As Of Date and Date Range Modes
- Optionally specify the actual balance type to be compared to the projected balance in the  'Actual vs Projected Balance Type' parameter. When specified, the variance between the actual balance and projected balance will be displayed in the report.
- Applicable Templates:
  Pivot: As of Date Summary by Currency and Account
  Detail As of Date/Range Date Report  

Sources: 
Bank Account Balance Single Date Report (CEBABSGR)
Bank Account Balance Range Day Report (CEBABRGR)
Bank Account Balance Actual vs Projected Report (CEBABAPR)
DB package:  CE_CEXSTMRR_XMLP_PKG (required to initialize security)


## Report Parameters
Legal Entity, Bank Name, Bank Branch, Bank Account Name, Bank Account Number, Balance Type, Balance Date From, Balance Date To, Balance As Of Date, Bring Forward Prior Balances, Actual vs Projected Balance Type, Bank Account Currency, Reporting Currency, Reporting Exchange Rate Type, Reporting Exchange Rate Date

## Oracle EBS Tables Used
[ce_bank_acct_balances](https://www.enginatics.com/library/?pg=1&find=ce_bank_acct_balances), [ce_projected_balances](https://www.enginatics.com/library/?pg=1&find=ce_projected_balances), [ce_bank_acct_bal_qry1](https://www.enginatics.com/library/?pg=1&find=ce_bank_acct_bal_qry1), [ce_bank_accts_calc_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_accts_calc_v), [ce_bank_accts_gt_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_accts_gt_v), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [xle_entity_profiles](https://www.enginatics.com/library/?pg=1&find=xle_entity_profiles), [ce_cashpools](https://www.enginatics.com/library/?pg=1&find=ce_cashpools), [ce_cashpool_sub_accts](https://www.enginatics.com/library/?pg=1&find=ce_cashpool_sub_accts)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CE Bank Account Balances 19-Aug-2021 075222.xlsx](https://www.enginatics.com/example/ce-bank-account-balances/) |
| Blitz Report™ XML Import | [CE_Bank_Account_Balances.xml](https://www.enginatics.com/xml/ce-bank-account-balances/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ce-bank-account-balances/](https://www.enginatics.com/reports/ce-bank-account-balances/) |

## Case Study & Technical Analysis: CE Bank Account Balances Report

### Executive Summary
The **CE Bank Account Balances** report is a comprehensive Treasury Management tool designed to provide immediate visibility into cash positions across the enterprise. It consolidates functionality from multiple standard Oracle Cash Management reports into a single, flexible interface. This report is essential for Treasury Managers and Financial Controllers who need to monitor liquidity, reconcile bank statements, and forecast cash flow requirements without running disparate processes.

### Business Challenge
Managing cash visibility in Oracle EBS can be fragmented:
*   **Fragmented Reporting:** Users often have to run separate reports for "As Of" dates versus "Date Ranges," making trend analysis difficult.
*   **Data Gaps:** If no transaction occurred on a specific date, standard reports might show a zero balance or no record, rather than carrying forward the last known closing balance.
*   **Forecasting Disconnect:** Comparing actual bank balances against projected cash flows usually requires manual extraction and merging of data in Excel.
*   **Multi-Currency Complexity:** Consolidating balances across different currencies and legal entities for a global cash position is time-consuming.

### The Solution
This report solves these challenges by offering a unified view of bank balances with advanced logic to handle data gaps.
*   **Unified Modes:** Supports "Single Date," "Date Range," and "Actual vs. Projected" analysis in one report.
*   **Smart Roll-Forward:** Includes a "Bring Forward Prior Balances" feature. If a bank account had no activity on the requested date, the report automatically retrieves the most recent closing balance, ensuring a complete picture of liquidity.
*   **Variance Analysis:** Allows direct comparison between Actual Ledger Balances and Projected Balances (based on cash flow forecasting), highlighting variances immediately.
*   **Global Visibility:** Aggregates data across Legal Entities and Currencies, with options for reporting currency conversion.

### Technical Architecture (High Level)
The report utilizes advanced SQL analytic functions to perform complex balance calculations directly in the database.

#### Primary Tables
*   `CE_BANK_ACCT_BALANCES`: The core table storing daily closing balances (Ledger, Available, Value Dated).
*   `CE_PROJECTED_BALANCES`: Stores forecasted balances derived from Cash Flow Mapping.
*   `CE_BANK_ACCTS_GT_V`: View providing bank account details and security.
*   `XLE_ENTITY_PROFILES`: Links bank accounts to Legal Entities.
*   `HZ_PARTIES`: Provides Bank and Branch names.

#### Logical Relationships
*   **Complex Balance Logic:** The query uses a Common Table Expression (CTE) with analytic functions (`KEEP (DENSE_RANK LAST ORDER BY ...)`). This is the technical engine behind the "Bring Forward" logic, allowing the query to efficiently find the last valid balance for each account without expensive correlated subqueries.
*   **Full Outer Join:** It performs a full outer join between `CE_BANK_ACCT_BALANCES` and `CE_PROJECTED_BALANCES`. This ensures that the report shows days where there is a projection but no actual balance, and vice versa.
*   **Security:** The report integrates with Oracle's security model via `CE_BANK_ACCTS_GT_V` to ensure users only see bank accounts they are authorized to access.

### Parameters & Filtering
The report offers versatile parameters to switch between reporting modes:
*   **As Of Date:** Defines the target date for a snapshot view.
*   **Balance Date From / To:** Defines the range for trend analysis.
*   **Bring Forward Prior Balances:** (Yes/No) Determines if the report should search for the last known balance if the "As Of" date has no record.
*   **Actual vs Projected Balance Type:** Selects the specific balance type (e.g., Ledger, Available) to compare against projections.
*   **Bank Account / Legal Entity:** Standard filters to narrow down the scope of the report.

### Performance & Optimization
*   **Analytic Functions:** By using window functions to calculate the "last known balance," the report avoids the performance penalty of running a separate query for every bank account to find its max date.
*   **Single Pass Execution:** The report calculates actuals, projections, and variances in a single database pass, reducing I/O overhead compared to running three separate standard reports.

### FAQ
**Q: Why do I see a balance date different from my "As Of Date"?**
A: If you set "Bring Forward Prior Balances" to 'Yes', and there was no activity on your "As Of Date," the report shows the date of the last actual balance update. This confirms you are looking at the most current valid data.

**Q: Can I see both Ledger and Available balances?**
A: Yes, the report extracts multiple balance types (Ledger, Available, Value Dated, 1-Day Float, etc.) simultaneously. You can choose which columns to display in the Excel output.

**Q: How does the "Actual vs Projected" comparison work?**
A: When you select a balance type for comparison, the report calculates the variance (Actual - Projected). This is useful for validating the accuracy of your cash forecasting rules.


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
