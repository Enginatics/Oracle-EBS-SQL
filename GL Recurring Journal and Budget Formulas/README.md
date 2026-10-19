---
layout: default
last_modified_at: 2026-10-19
title: 'GL Recurring Journal and Budget Formulas | Oracle EBS SQL Report'
description: 'Lists Oracle General Ledger recurring journal and budget formula definitions - batches, journal entries, lines and each line''s formula steps - with the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, General Ledger, Enginatics, Recurring, Journal, Budget, Formulas, gl_je_categories_vl, gl_daily_conversion_types, gl_code_combinations_kfv'
permalink: /GL%20Recurring%20Journal%20and%20Budget%20Formulas/
report_name: 'GL Recurring Journal and Budget Formulas'
report_web_name: gl-recurring-journal-and-budget-formulas
module: 'General Ledger'
module_url: /modules/general-ledger/
---

# GL Recurring Journal and Budget Formulas – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-recurring-journal-and-budget-formulas/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas).
**Oracle EBS module:** [General Ledger](/modules/general-ledger/ "Oracle EBS General Ledger reports") · [all General Ledger reports](/modules/general-ledger/)  

## Overview
Lists Oracle General Ledger recurring journal and budget formula definitions - batches, journal entries, lines and each line's formula steps - with the account code combinations exploded into one column per Accounting Flexfield segment.

Each row is one formula step. The line account, which is the account the generated journal posts to, and the formula account, which is the account a step reads a balance from, are both shown segment by segment. Company, Department, Account, Sub-Account and the remaining segments of your chart of accounts therefore become individual columns that can be sorted and filtered in Excel.

Replaces the Oracle standard report 'Other - Recurring Formula Listing' (GLXRLRFL), which prints concatenated code combinations in a fixed page layout. Definition access set security on recurring batches is applied exactly as in the standard report.

Use the Ledger, Batch Name, Journal Entry Name and Category parameters to focus on a subset, for example intercompany or intracompany batches, and the per segment like, From and To parameters to restrict the accounts.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Calendar, Batch Name, Journal Entry Name, Category, Balance Type, Batch Type, MassAllocation Batch, Enabled, Account like, GL_SEGMENT1, GL_SEGMENT1 From, GL_SEGMENT1 To, GL_SEGMENT2, GL_SEGMENT2 From, GL_SEGMENT2 To, GL_SEGMENT3, GL_SEGMENT3 From, GL_SEGMENT3 To, GL_SEGMENT4, GL_SEGMENT4 From, GL_SEGMENT4 To, GL_SEGMENT5, GL_SEGMENT5 From, GL_SEGMENT5 To, GL_SEGMENT6, GL_SEGMENT6 From, GL_SEGMENT6 To, GL_SEGMENT7, GL_SEGMENT7 From, GL_SEGMENT7 To, GL_SEGMENT8, GL_SEGMENT8 From, GL_SEGMENT8 To, GL_SEGMENT9, GL_SEGMENT9 From, GL_SEGMENT9 To, GL_SEGMENT10, GL_SEGMENT10 From, GL_SEGMENT10 To

## Oracle EBS Tables Used
[gl_je_categories_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_categories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas), [gl_recurring_batches](https://www.enginatics.com/library/?pg=1&find=gl_recurring_batches&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas), [gl_recurring_headers](https://www.enginatics.com/library/?pg=1&find=gl_recurring_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas), [gl_recurring_lines](https://www.enginatics.com/library/?pg=1&find=gl_recurring_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas), [gl_recurring_line_calc_rules](https://www.enginatics.com/library/?pg=1&find=gl_recurring_line_calc_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas)

## Related Reports
[AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown)](/GL%20Account%20Analysis%20%28Drilldown%29/ "GL Account Analysis (Drilldown) Oracle EBS SQL Report"), [GL Account Analysis 11g](/GL%20Account%20Analysis%2011g/ "GL Account Analysis 11g Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AP Invoices and Lines 11i](/AP%20Invoices%20and%20Lines%2011i/ "AP Invoices and Lines 11i Oracle EBS SQL Report"), [GL Journals 11i](/GL%20Journals%2011i/ "GL Journals 11i Oracle EBS SQL Report"), [GL Journals (Drilldown)](/GL%20Journals%20%28Drilldown%29/ "GL Journals (Drilldown) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Recurring%20Journal%20and%20Budget%20Formulas/GL%20Recurring%20Journal%20and%20Budget%20Formulas.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL Recurring Journal and Budget Formulas 30-Jul-2026 203224.xlsx](https://www.enginatics.com/example/gl-recurring-journal-and-budget-formulas/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas) |
| Blitz Report™ XML Import | [GL_Recurring_Journal_and_Budget_Formulas.xml](https://www.enginatics.com/xml/gl-recurring-journal-and-budget-formulas/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas) |
| SQL Source | [GL Recurring Journal and Budget Formulas.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Recurring%20Journal%20and%20Budget%20Formulas/GL%20Recurring%20Journal%20and%20Budget%20Formulas.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/gl-recurring-journal-and-budget-formulas/](https://www.enginatics.com/reports/gl-recurring-journal-and-budget-formulas/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas) |

## Case Study & Technical Analysis: GL Recurring Journal and Budget Formulas

### Executive Summary
GL Recurring Journal and Budget Formulas lists the recurring journal and budget definitions of Oracle General Ledger, with their batches, journal entries, lines and the formula steps behind each line. Every account is split into one column per Accounting Flexfield segment, so the company, department, account, sub-account and other segments can be sorted and filtered in Excel. General Ledger administrators and month-end close teams use it to review what each recurring entry posts and which balances it reads.

### Business Challenge
*   **Review Before Close:** Recurring journals post automatically each period, so the team needs to confirm the accounts and formulas before the close begins.
*   **Segment Analysis:** Reviewers want to see all intercompany or intracompany batches for one company or department, which is hard when the account is one concatenated string.
*   **Formula Transparency:** A line can use several formula steps that read balances from different accounts, and the relationship between steps must be visible.
*   **Access Control:** Recurring batches can be secured, so the listing must respect the same definition access rules as the standard report.

### The Solution
*   **Segment Columns:** Each Accounting Flexfield segment of the line account and of the formula account is returned as its own column, so filtering by a single segment is direct.
*   **Step Level Detail:** Each row is one formula step, showing the operator, the amount, the amount type, the relative period, the balance type and the currency type.
*   **Security Respect:** The batch rows are filtered with the same data security check the standard report applies to recurring journals.
*   **Scoped Selection:** Ledger, batch, journal entry and category parameters, together with per-segment ranges, focus the listing on the required accounts.

### Technical Architecture (High Level)
#### Primary Tables
*   `GL_RECURRING_BATCHES`: the batch definitions, including the batch type, the budget flag, the allocation flag and the period calendar.
*   `GL_RECURRING_HEADERS`: the journal entries within a batch, with their category, currency, conversion type and dates.
*   `GL_RECURRING_LINES`: the lines of each journal entry, with the line account and the entered debit or credit.
*   `GL_RECURRING_LINE_CALC_RULES`: the formula steps of each line, with the operator, amount, period and assigned account.
*   `GL_CODE_COMBINATIONS_KFV`: the account combinations, used for both the line account and the formula account.
*   `GL_LEDGERS`: the ledger name for each batch.
*   `GL_JE_CATEGORIES_VL`: the user name of the journal category.
*   `GL_DAILY_CONVERSION_TYPES`: the user name of the conversion type.

#### Logical Relationships
1.  `GL_RECURRING_BATCHES` is joined to `GL_LEDGERS` on the ledger identifier.
2.  Batches are joined to `GL_RECURRING_HEADERS` on the recurring batch identifier.
3.  Headers are joined to `GL_RECURRING_LINES` on the recurring header identifier.
4.  Lines are outer joined to `GL_RECURRING_LINE_CALC_RULES` on header and line number, so each line returns one row per formula step.
5.  Each line's account is joined to `GL_CODE_COMBINATIONS_KFV`, and each step's assigned account is looked up in a correlated subquery against the same view.
6.  Category and conversion type names are resolved through correlated subqueries against their definition views.

### Parameters & Filtering
*   **Ledger, Calendar and Batch Name:** Select the ledger and the batch, the main drivers of the extract.
*   **Journal Entry Name and Category:** Narrow the output to one journal entry or journal category.
*   **Balance Type and Batch Type:** Separate budget batches from accounting batches.
*   **MassAllocation Batch and Enabled:** Limit the output to allocation batches or to enabled entries.
*   **Account like:** Matches the concatenated line account.
*   **GL_SEGMENT1 to GL_SEGMENT10 with From and To:** Each pair restricts the line account to a range of values for one segment, and each segment has its own value filter.

### Performance & Optimization
*   **Batch and Ledger Drive:** The ledger and batch parameters restrict the batch rows first, so the join to headers, lines and rules is limited to the selected batches.
*   **Outer Join to Rules:** Formula steps are joined as an outer join, so lines without formula steps are still returned.
*   **Security Check Per Batch:** The data security function is evaluated once per batch row, which keeps the check proportionate to the number of batches.
*   **Segment Derivation:** Segment values are taken from the code combination view with the flexfield column expansion, so no extra lookup table is joined.

### FAQ
**Q: How do I see every recurring entry that posts to a particular department?**
A: Enter the department value in the matching GL_SEGMENT parameter, or use the From and To range for that segment. Each row shows the line account segment by segment.

**Q: What is the difference between the line account and the formula account?**
A: The line account is the account the generated journal posts to. The formula account is the account a formula step reads a balance from.

**Q: Does this report replace the standard recurring formula listing?**
A: It covers the same definitions, with segments in separate columns and one row per formula step. The description notes that it replaces the standard Other Recurring Formula Listing.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-recurring-journal-and-budget-formulas)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
