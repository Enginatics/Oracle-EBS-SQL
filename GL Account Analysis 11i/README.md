---
layout: default
title: 'GL Account Analysis 11i | Oracle EBS SQL Report'
description: 'Detail GL transaction report with one line per journal line including all segments, with amounts in both transaction currency and ledger currency.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Account, Analysis, 11i, gl_je_sources_vl, gl_je_categories_vl, gl_budget_versions'
permalink: /GL%20Account%20Analysis%2011i/
---

# GL Account Analysis 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-account-analysis-11i/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Detail GL transaction report with one line per journal line including all segments, with amounts in both transaction currency and ledger currency.


## Report Parameters
Ledger, Period, Period From, Period To, Posted Date From, Posted Date To, Journal Source, Journal Category, Batch, Journal, Journal Line, Account Matching Level, Account Type, Concatenated Segments, GL_SEGMENT1, GL_SEGMENT1 From, GL_SEGMENT1 To, GL_SEGMENT2, GL_SEGMENT2 From, GL_SEGMENT2 To, GL_SEGMENT3, GL_SEGMENT3 From, GL_SEGMENT3 To, GL_SEGMENT4, GL_SEGMENT4 From, GL_SEGMENT4 To, GL_SEGMENT5, GL_SEGMENT5 From, GL_SEGMENT5 To, GL_SEGMENT6, GL_SEGMENT6 From, GL_SEGMENT6 To, GL_SEGMENT7, GL_SEGMENT7 From, GL_SEGMENT7 To, GL_SEGMENT8, GL_SEGMENT8 From, GL_SEGMENT8 To, GL_SEGMENT9, GL_SEGMENT9 From, GL_SEGMENT9 To, GL_SEGMENT10, GL_SEGMENT10 From, GL_SEGMENT10 To, Status, Revaluation Currency, Revaluation Conversion Type, Balance Type, Budget Name, Encumbrance Type

## Oracle EBS Tables Used
[gl_je_sources_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_sources_vl), [gl_je_categories_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_categories_vl), [gl_budget_versions](https://www.enginatics.com/library/?pg=1&find=gl_budget_versions), [gl_encumbrance_types](https://www.enginatics.com/library/?pg=1&find=gl_encumbrance_types), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods), [gl_je_batches](https://www.enginatics.com/library/?pg=1&find=gl_je_batches), [gl_je_headers](https://www.enginatics.com/library/?pg=1&find=gl_je_headers), [gl_je_lines](https://www.enginatics.com/library/?pg=1&find=gl_je_lines), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [GL Journals 11i](/GL%20Journals%2011i/ "GL Journals 11i Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Journals (Drilldown) 11g](/GL%20Journals%20%28Drilldown%29%2011g/ "GL Journals (Drilldown) 11g Oracle EBS SQL Report"), [GL Journals (Drilldown)](/GL%20Journals%20%28Drilldown%29/ "GL Journals (Drilldown) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/gl-account-analysis-11i/) |
| Blitz Report™ XML Import | [GL_Account_Analysis_11i.xml](https://www.enginatics.com/xml/gl-account-analysis-11i/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-account-analysis-11i/](https://www.enginatics.com/reports/gl-account-analysis-11i/) |

## Case Study: Financial Reconciliation & Subledger Audit

### Executive Summary
The **GL Account Analysis** report is the definitive tool for financial reconciliation and audit within Oracle E-Business Suite. It bridges the gap between General Ledger (GL) balances and the supporting Subledger Accounting (SLA) transactions. By providing a detailed, line-by-line listing of journal entries—complete with source documents, currency details, and segment breakdowns—it empowers finance teams to validate period-end balances, investigate anomalies, and ensure the integrity of financial statements.

### Business Challenge
Financial close processes are often delayed by the difficulty of reconciling high-level GL balances with granular transaction data.
*   **Black Box Balances:** A GL balance tells you *how much*, but not *why*. Understanding the composition of a balance requires tedious drill-down through multiple screens.
*   **Subledger Disconnect:** Tracing a GL journal line back to the specific AP Invoice, AR Receipt, or Inventory Transaction that generated it is technically complex due to the SLA architecture.
*   **Multi-Currency Complexity:** Reconciling entered currency amounts vs. accounted (functional) currency amounts is a common source of confusion and error.
*   **Audit Requirements:** External auditors require detailed transaction listings that prove the validity of account balances.

### The Solution
This report serves as a universal "Subledger to GL" reconciliation engine.
*   **Unified View:** Combines GL journal headers, lines, and batches into a single flat view.
*   **Drill-Back Capability:** Uses the SLA linking tables to retrieve the original transaction number (e.g., Invoice Number, Check Number) and display it alongside the GL account.
*   **Segment Analysis:** Breaks down the Accounting Flexfield into individual segments (Company, Cost Center, Account, etc.) for pivot-table friendly analysis.
*   **Currency Precision:** Reports both "Entered" (Transaction) and "Accounted" (Ledger) amounts, exposing FX impacts clearly.

### Technical Architecture
The report navigates the core Financials data model, specifically the link between GL and SLA.
*   **GL Core:** `GL_JE_BATCHES`, `GL_JE_HEADERS`, `GL_JE_LINES` hold the journal entries.
*   **Account Structure:** `GL_CODE_COMBINATIONS` resolves the Chart of Accounts segments.
*   **SLA Linkage:** `GL_IMPORT_REFERENCES` is the critical bridge that connects GL lines to `XLA_AE_LINES` and `XLA_AE_HEADERS`.
*   **Source Tables:** Depending on the source, it links to `AP_INVOICES_ALL`, `RA_CUSTOMER_TRX_ALL`, etc., to fetch the "Source Document" details.

### Parameters & Filtering
*   **Ledger Context:** Ledger, Period (From/To), Posted Date.
*   **Journal Attributes:** Source (e.g., Payables, Receivables), Category, Batch Name.
*   **Account Segments:** Filters for individual segments (e.g., Account Type, Cost Center range).
*   **Display Options:** Show Segments with Descriptions, Show Open/Close Balances, Show Sub Ledger Contra Accounts.
*   **Currency:** Transaction Currency, Revaluation Currency.

### Performance & Optimization
*   **Data Volume:** This report can generate millions of rows for large periods. It is highly recommended to filter by specific **Account Types** (e.g., Expense Accounts) or **Journal Sources** rather than dumping the entire GL for a period.
*   **Indexing:** The query relies heavily on the `GL_CODE_COMBINATIONS` and `GL_JE_LINES` indexes. Ensure statistics are gathered regularly on these tables.
*   **Pivot Mode:** The output is designed for Excel pivot tables. Users should be trained to export the raw data and use Pivot Tables to summarize by Cost Center or Account, rather than trying to read the raw list.

### FAQ
**Q: Why do I see multiple lines for one transaction?**
A: A single business transaction (like an invoice) can generate multiple GL journal lines (liability, expense, tax, etc.). This report shows every line to ensure the debits and credits balance.

**Q: Can I use this report to reconcile Intercompany accounts?**
A: Yes, by filtering on the Intercompany segment and the relevant Contra Accounts, you can match transactions between entities.

**Q: Does it show unposted journals?**
A: You can filter by "Status" to include or exclude unposted journals, depending on whether you are doing a pre-close review or a final audit.


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
