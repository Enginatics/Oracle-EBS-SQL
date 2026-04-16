---
layout: default
title: 'PSA Budgetary Control Transactions | Oracle EBS SQL Report'
description: 'Imported from Concurrent Program Description: Budgetary Control Results Report Program Application: Public Sector Financials Source: Budgetary Control…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, PSA, Budgetary, Control, Transactions, &lp_expand_tables, gl_ledgers, gl_code_combinations_kfv'
permalink: /PSA%20Budgetary%20Control%20Transactions/
---

# PSA Budgetary Control Transactions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/psa-budgetary-control-transactions/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from Concurrent Program
Description: Budgetary Control Results Report Program
Application: Public Sector Financials
Source: Budgetary Control Results Report
Short Name: PSABCRRP
DB package: XXEN_PSA

The Expand Amounts Yes/No Parameter determines whether or not the Budget, Encumbrances, Expenditures, and Funds Available Amounts are displayed on the same excel row (Expand=No) or are split into separate excel rows (Expand=Yes) in the generated excel.

The following templates are provided with this report:

Budgetary Control Transactions Pivot
===========================
Corresponds to the standard Oracle Budgetary Control Status Report.
Budget, Encumbrances, Expenditures, and Funds Available Amounts are displayed on separate rows in the generated Excel

Budgetary Control Transactions Extract
============================
Flat File one row per transaction extract.
Budget, Encumbrances, Expenditures, and Funds Available Amounts are included as separate columns on the same excel row


## Report Parameters
Ledger Name, Period From, Period To, JE Batch Name, Account From, Account To, Funds Result Status, Order By, Expand Amounts

## Oracle EBS Tables Used
[&lp_expand_tables](https://www.enginatics.com/library/?pg=1&find=&lp_expand_tables), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [CAC AP Accrual IR ISO Match Analysis](/CAC%20AP%20Accrual%20IR%20ISO%20Match%20Analysis/ "CAC AP Accrual IR ISO Match Analysis Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC Standard Cost Update Submissions](/CAC%20Standard%20Cost%20Update%20Submissions/ "CAC Standard Cost Update Submissions Oracle EBS SQL Report"), [AP Expenses](/AP%20Expenses/ "AP Expenses Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/psa-budgetary-control-transactions/) |
| Blitz Report™ XML Import | [PSA_Budgetary_Control_Transactions.xml](https://www.enginatics.com/xml/psa-budgetary-control-transactions/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/psa-budgetary-control-transactions/](https://www.enginatics.com/reports/psa-budgetary-control-transactions/) |

## Case Study & Technical Analysis: PSA Budgetary Control Transactions Report

### Executive Summary

The PSA Budgetary Control Transactions report is a critical financial control and audit tool designed for organizations utilizing Oracle Public Sector Financials, particularly for budgetary control. It provides a detailed view of transactions that have passed through budgetary control, showing the impact on budgets, encumbrances, expenditures, and funds available. This report is indispensable for finance managers, budget officers, and auditors to monitor spending against approved budgets, prevent over-expenditure, ensure compliance with government accounting regulations, and maintain fiscal accountability.

### Business Challenge

Managing public or grant funds requires stringent budgetary control to prevent overspending and ensure resources are allocated appropriately. Organizations often face significant challenges in achieving this:

-   **Preventing Overspending:** Without real-time visibility into funds available and their consumption, it's easy for departments to inadvertently overspend their allocated budgets, leading to financial penalties or audit findings.
-   **Tracking Encumbrances:** Accurately tracking outstanding commitments (encumbrances) against a budget is crucial for understanding true available funds, but this can be complex to report on effectively.
-   **Reconciliation and Audit:** Reconciling actual expenditures and encumbrances with the budget for specific accounts or periods is a foundational requirement for public sector financial reporting and a major audit focus.
-   **Reporting Flexibility:** Standard Oracle budgetary control reports may lack the flexibility to present data in different formats (e.g., flat file extract vs. pivot) or to filter precisely for specific budget transaction statuses or accounts.

### The Solution

This report offers a powerful, configurable, and auditable solution for budgetary control analysis, providing the transparency needed for responsible fund management.

-   **Real-time Funds Availability:** It provides a clear picture of budget, encumbrances, expenditures, and available funds for each transaction or account, enabling proactive financial management and preventing overspending.
-   **Flexible Output Formats:** The `Expand Amounts` parameter is a key feature, allowing users to choose between a summarized view (amounts on one row) or a detailed view (amounts split into separate rows for pivot analysis), catering to different reporting needs.
-   **Targeted Discrepancy Identification:** By detailing the status of funds checks (`Funds Result Status`), the report helps finance teams quickly identify transactions that failed budgetary control, allowing for prompt investigation and resolution.
-   **Enhanced Compliance:** The report provides robust documentation of budgetary control activity, which is essential for demonstrating fiscal accountability and compliance with public sector financial regulations.

### Technical Architecture (High Level)

The report queries core Oracle General Ledger and Public Sector Financials tables related to budgetary control.

-   **Primary Tables Involved:**
    -   `gl_ledgers` (for ledger context).
    -   `gl_periods` (for accounting period details).
    -   `gl_code_combinations_kfv` (for GL account segment details).
    -   Underlying Public Sector Financials (PSA) tables for budgetary control (e.g., `PSA_BC_XLA_ACCTS_V`, `PSA_BC_TRANSACTIONS`) are likely involved to track the specific budgetary control impact of transactions.
    -   `XXEN_PSA` (the custom database package for this report) suggests custom logic for data extraction and formatting.
-   **Logical Relationships:** The report links General Ledger accounts to their budgetary control activity. It retrieves budgetary balances, encumbrance amounts, and expenditure values, aggregating them by account and period. The `Funds Result Status` is derived from the budgetary control processing results, indicating whether a transaction passed or failed its funds check.

### Parameters & Filtering

The report offers flexible parameters for targeted budgetary control analysis:

-   **Financial Context:** `Ledger Name` and `Operating Unit` (if applicable) define the financial and organizational scope.
-   **Period Range:** `Period From` and `Period To` are critical for analyzing budgetary control activity over specific accounting periods.
-   **Account Filters:** `Account From` and `Account To` allow for precise targeting of specific GL accounts or ranges for analysis.
-   **Status Filters:** `Funds Result Status` allows users to focus on transactions that passed, failed, or were partially processed by budgetary control.
-   **Output Format:** `Expand Amounts` (Yes/No) is a crucial parameter for controlling the report's layout for pivot table analysis or flat-file extraction.
-   **Order By:** Provides flexibility in sorting the report output.

### Performance & Optimization

As a financial report querying transactional and budgetary data, it is optimized by period and account-driven filtering.

-   **Period and Account-Driven Efficiency:** The `Period From/To` and `Account From/To` parameters are crucial for performance, allowing the database to efficiently narrow down the large volume of GL and budgetary control data to the relevant timeframe and accounts using existing indexes.
-   **Leveraging PSA Views (if applicable):** Oracle Public Sector Financials often provides specialized views for budgetary control data, which can be optimized for performance. The `XXEN_PSA` package indicates custom optimization efforts.
-   **Conditional Output Generation:** The `Expand Amounts` parameter allows the report to generate different output structures efficiently, avoiding unnecessary data manipulation when a simpler view is requested.

### FAQ

**1. What is "Budgetary Control" and why is it important in Public Sector Financials?**
   Budgetary Control is a set of rules and processes that prevent spending in excess of approved budget amounts. In public sector financials, it is critical for ensuring fiscal responsibility, compliance with legal budget limits, and preventing agencies or departments from overspending their allocated funds.

**2. What does a "Funds Result Status" of 'Failed' indicate?**
   A 'Failed' status indicates that a transaction (e.g., a purchase requisition, a journal entry) attempted to consume funds from a budget, but doing so would have caused the budget to be exceeded. The transaction was therefore rejected by the budgetary control system, preventing the overspending.

**3. How does the `Expand Amounts` parameter change the report's usefulness?**
   When `Expand Amounts` is 'No', all budgetary figures (Budget, Encumbrance, Expenditure, Funds Available) appear as separate columns on a single row per account, ideal for a flat-file extract. When `Expand Amounts` is 'Yes', these amounts are typically broken into separate rows, which is perfect for building pivot tables in Excel to dynamically analyze and summarize budgetary data across different dimensions.


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
