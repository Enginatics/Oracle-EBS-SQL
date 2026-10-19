---
layout: default
last_modified_at: 2026-10-19
title: 'GL Balances (Drilldown) | Oracle EBS SQL Report'
description: 'This report is used by the GL Financial Statement and Drilldown report, to show Balance details per code combination. Shows GL balance amounts (Opening…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Balances, (Drilldown), gl_budget_versions, gl_encumbrance_types, gl_ledgers'
permalink: /GL%20Balances%20%28Drilldown%29/
report_name: 'GL Balances (Drilldown)'
report_web_name: gl-balances-drilldown
---

# GL Balances (Drilldown) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-balances-drilldown/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-balances-drilldown) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-balances-drilldown).

## Overview
** This report is used by the GL Financial Statement and Drilldown report, to show Balance details per code combination. **

Shows GL balance amounts (Opening Balance, Debit, Credit, Net, Closing Balance) grouped by code combination, with drill-to-journal capability.
Supports all balance types: PTD, YTD, QTD, PJTD, FYS, FYE, CTD.
The Drill To Journal column allows further drilldown into journal details.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-balances-drilldown) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Period, Ledger ID, Amount Type, Currency Code, Currency Type, Balance Type, Budget Name, Encumbrance Type, Concatenated Segments, Code Combination ID, Restrict CCIDs through GTT

## Oracle EBS Tables Used
[gl_budget_versions](https://www.enginatics.com/library/?pg=1&find=gl_budget_versions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-balances-drilldown), [gl_encumbrance_types](https://www.enginatics.com/library/?pg=1&find=gl_encumbrance_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-balances-drilldown), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-balances-drilldown), [gl_balances](https://www.enginatics.com/library/?pg=1&find=gl_balances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-balances-drilldown), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-balances-drilldown)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-balances-drilldown)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Balance](/GL%20Balance/ "GL Balance Oracle EBS SQL Report"), [GL Balance Drilldown](/GL%20Balance%20Drilldown/ "GL Balance Drilldown Oracle EBS SQL Report"), [GL Journals](/GL%20Journals/ "GL Journals Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Journals 11i](/GL%20Journals%2011i/ "GL Journals 11i Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Journals (Drilldown) 11g](/GL%20Journals%20%28Drilldown%29%2011g/ "GL Journals (Drilldown) 11g Oracle EBS SQL Report"), [GL Journals (Drilldown)](/GL%20Journals%20%28Drilldown%29/ "GL Journals (Drilldown) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Balances%20%28Drilldown%29/GL%20Balances%20%28Drilldown%29.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-balances-drilldown) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/gl-balances-drilldown/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-balances-drilldown) |
| Blitz Report™ XML Import | [GL_Balances_Drilldown.xml](https://www.enginatics.com/xml/gl-balances-drilldown/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-balances-drilldown) |
| SQL Source | [GL Balances (Drilldown).sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Balances%20%28Drilldown%29/GL%20Balances%20%28Drilldown%29.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/gl-balances-drilldown/](https://www.enginatics.com/reports/gl-balances-drilldown/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-balances-drilldown) |

## Case Study & Technical Analysis: GL Balances (Drilldown)

### Executive Summary
The GL Balances (Drilldown) report shows General Ledger balances for each code combination, with opening balance, debit, credit, net and closing balance. It is the balance-level detail behind the GL Financial Statement and Drilldown reports, and it can be used on its own by accountants who want to see which accounts make up a financial statement line. Each row carries a drill-to-journal formula, so the user can move from a balance to the journal lines that produced it. The report supports every balance type, including period-to-date, year-to-date, quarter-to-date, project-to-date, and the financial year start and end balances.

### Business Challenge
*   **Explaining statement lines:** Financial statement totals are sums of account balances, and reviewers need the balance of each account behind a line.
*   **Balance type choice:** Accountants need to compare period, quarter, year and project balances, and each balance type answers a different question.
*   **Actual, budget and encumbrance:** The same account may hold actual, budget and encumbrance balances, and these must be kept apart.
*   **Tracing to source:** When a balance looks wrong, the user needs to reach the journals behind it without searching the journal screens.

### The Solution
*   **Balances per combination:** Balances are summed for each code combination, so every account appears once per balance type, currency and budget or encumbrance version.
*   **Full balance set:** Opening, period debit, period credit, net and closing balances are returned together.
*   **Balance-type labels:** The actual flag is translated to its batch type description, and the budget name and encumbrance type are shown for those balances.
*   **Drill to journal:** A formula is generated for each row that opens the journal details for that ledger, period, amount type, currency, balance type and code combination.

### Technical Architecture (High Level)
#### Primary Tables
*   `GL_LEDGERS`: the ledger, which supplies the ledger name, ledger ID and chart of accounts.
*   `GL_BALANCES`: the balance rows, one per ledger, code combination, period, currency, balance type and version.
*   `GL_CODE_COMBINATIONS_KFV`: the account combinations, with the concatenated segments and the chart of accounts.
*   `GL_BUDGET_VERSIONS`: the budget version name, read for budget balances.
*   `GL_ENCUMBRANCE_TYPES`: the encumbrance type name, read for encumbrance balances.

#### Logical Relationships
1.  `GL_LEDGERS` is joined to `GL_BALANCES` on the ledger ID, and `GL_BALANCES` is joined to `GL_CODE_COMBINATIONS_KFV` on the code combination ID.
2.  The combination's chart of accounts must match the ledger's chart of accounts, and only detail accounts are kept.
3.  Template balances are excluded, so only balances from actual ledger postings are returned.
4.  Budget name and encumbrance type are looked up by scalar subquery from the balance's version and encumbrance type IDs.
5.  An inner aggregation sums the balance amounts by ledger, combination, balance type, actual flag, budget, encumbrance type, currency and drill formula. Rows with all amounts at zero are removed.
6.  The aggregated result is joined back to `GL_CODE_COMBINATIONS_KFV` to show the concatenated account, and sorted by it.

### Parameters & Filtering
*   **Ledger and Ledger ID:** Select the ledger whose balances are returned.
*   **Period and Amount Type:** Choose the accounting period and the balance type, such as PTD, YTD or QTD, that the balances are read for.
*   **Currency Code and Currency Type:** Select the currency of the balances.
*   **Balance Type and Budget Name:** Separate actual balances from budget balances, and choose the budget version.
*   **Encumbrance Type:** Selects the encumbrance balances to show.
*   **Concatenated Segments and Code Combination ID:** Restrict the accounts shown.
*   **Restrict CCIDs through GTT:** Limits the code combinations to a list held in a global temporary table.

### Performance & Optimization
*   **Ledger and balance filters first:** The ledger join and the balance restriction are applied before the code combination join, so the scan starts from one ledger's balances.
*   **Template balances excluded:** Balances with a template ID are removed in the inner query, so only balances from ledger postings are summed.
*   **Zero rows removed before the outer join:** Rows where every amount is zero are dropped in the inner query, which reduces the rows joined to the account table.
*   **Scalar lookups for names:** Budget and encumbrance names come from scalar subqueries, which are evaluated only for the balance rows that have those IDs.

### FAQ
**Q: How do I see the journals behind a balance?**
A: Use the drill-to-journal formula in the Drill To Journal column. It opens the journal details for that ledger, period, amount type, currency, balance type and code combination.
**Q: Why does an account appear more than once?**
A: The report returns a row for each balance type, currency, budget version and encumbrance type that has a non-zero amount for the account.
**Q: Which balance types can I run?**
A: The report supports PTD, YTD, QTD, PJTD, FYS, FYE and CTD balances, selected through the Amount Type parameter.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-balances-drilldown)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-balances-drilldown)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-balances-drilldown)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-balances-drilldown)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-balances-drilldown)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-balances-drilldown)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-balances-drilldown)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
