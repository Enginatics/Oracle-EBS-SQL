---
layout: default
last_modified_at: 2026-10-16
title: 'GL Journals | Oracle EBS SQL Report'
description: 'GL batches and journals report, including amounts and attachments. One row per journal line. The Knocked Off flag marks journal lines whose equal and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, General Ledger, Enginatics, Journals, gl_code_combinations_kfv, per_people_f, gl_je_sources_vl'
permalink: /GL%20Journals/
report_name: 'GL Journals'
report_web_name: gl-journals
module: 'General Ledger'
module_url: /modules/general-ledger/
---

# GL Journals – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-journals/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals).
**Oracle EBS module:** [General Ledger](/modules/general-ledger/ "Oracle EBS General Ledger reports") · [all General Ledger reports](/modules/general-ledger/)  

## Overview
GL batches and journals report, including amounts and attachments. One row per journal line.

The Knocked Off flag marks journal lines whose equal and opposite accounted amounts on the same account combination and batch fully cancel to zero; Exclude Knocked Off Journal Lines removes them from the output.

Exclude Reversed Journals removes a reversal and its reversed journal only when both fall within the selected period range, so a reversal whose original journal lies outside the range stays visible and the period totals remain complete.

Show Open/Close Balances adds a ledger currency opening balance row for the first selected period and a closing balance row for the last selected period per account combination, marked as Opening Balance or Closing Balance in the Source column. Balance rows follow the ledger, period and account filters, not journal level filters such as Source, Category or Posting Status. The chosen value controls whether balance rows appear only for accounts with journal lines in the range, also for accounts with a nonzero balance, or for every account with a balance record, while All Accounts Grouped shows a single opening and closing balance row summed over the selected accounts.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Ledger Category, Period, Period From, Period To, Show Open/Close Balances, Posted Date From, Posted Date To, Creation Date From, Creation Date To, Created By, Journal Source, Journal Category, Posting Status, Funds Status, Exclude SLA Journals, Exclude Reversed Journals, Exclude Knocked Off Journal Lines, Batch, Journal, Currency, Journal Line DFF Display, Show Attachment Details, Balance Type, Budget Name, Encumbrance Type, Reference, Concatenated Segments, GL_SEGMENT1, GL_SEGMENT1 From, GL_SEGMENT1 To, GL_SEGMENT2, GL_SEGMENT2 From, GL_SEGMENT2 To, GL_SEGMENT3, GL_SEGMENT3 From, GL_SEGMENT3 To, GL_SEGMENT4, GL_SEGMENT4 From, GL_SEGMENT4 To, GL_SEGMENT5, GL_SEGMENT5 From, GL_SEGMENT5 To, GL_SEGMENT6, GL_SEGMENT6 From, GL_SEGMENT6 To, GL_SEGMENT7, GL_SEGMENT7 From, GL_SEGMENT7 To, GL_SEGMENT8, GL_SEGMENT8 From, GL_SEGMENT8 To, GL_SEGMENT9, GL_SEGMENT9 From, GL_SEGMENT9 To, GL_SEGMENT10, GL_SEGMENT10 From, GL_SEGMENT10 To

## Oracle EBS Tables Used
[gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [per_people_f](https://www.enginatics.com/library/?pg=1&find=per_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [gl_je_sources_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_sources_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [gl_je_categories_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_categories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [gl_budget_versions](https://www.enginatics.com/library/?pg=1&find=gl_budget_versions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [gl_encumbrance_types](https://www.enginatics.com/library/?pg=1&find=gl_encumbrance_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [gl_je_headers](https://www.enginatics.com/library/?pg=1&find=gl_je_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [gl_system_usages](https://www.enginatics.com/library/?pg=1&find=gl_system_usages&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [zx_rates_b](https://www.enginatics.com/library/?pg=1&find=zx_rates_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [gl_je_batches](https://www.enginatics.com/library/?pg=1&find=gl_je_batches&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [gl_je_lines](https://www.enginatics.com/library/?pg=1&find=gl_je_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [gl_je_lines_recon](https://www.enginatics.com/library/?pg=1&find=gl_je_lines_recon&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [fnd_attached_documents](https://www.enginatics.com/library/?pg=1&find=fnd_attached_documents&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [fnd_documents](https://www.enginatics.com/library/?pg=1&find=fnd_documents&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [fnd_documents_tl](https://www.enginatics.com/library/?pg=1&find=fnd_documents_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [fnd_document_datatypes](https://www.enginatics.com/library/?pg=1&find=fnd_document_datatypes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [fnd_document_categories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_document_categories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [fnd_lobs](https://www.enginatics.com/library/?pg=1&find=fnd_lobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [fnd_documents_short_text](https://www.enginatics.com/library/?pg=1&find=fnd_documents_short_text&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [fnd_documents_long_text](https://www.enginatics.com/library/?pg=1&find=fnd_documents_long_text&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals), [gl_balances](https://www.enginatics.com/library/?pg=1&find=gl_balances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals)

## Related Reports
[GL Journals (Drilldown)](/GL%20Journals%20%28Drilldown%29/ "GL Journals (Drilldown) Oracle EBS SQL Report"), [GL Journals (Drilldown) 11g](/GL%20Journals%20%28Drilldown%29%2011g/ "GL Journals (Drilldown) 11g Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Journals/GL%20Journals.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL Journals 30-Apr-2021 220634.xlsx](https://www.enginatics.com/example/gl-journals/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals) |
| Blitz Report™ XML Import | [GL_Journals.xml](https://www.enginatics.com/xml/gl-journals/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals) |
| SQL Source | [GL Journals.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Journals/GL%20Journals.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/gl-journals/](https://www.enginatics.com/reports/gl-journals/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals) |

## Case Study & Technical Analysis: GL Journals

### Executive Summary
The **GL Journals** report is the backbone of financial auditing and analysis in Oracle General Ledger. It provides a granular view of all journal entries—whether manual, imported, or generated by subledgers. This report is indispensable for Controllers and Auditors to verify the accuracy of financial statements, investigate account anomalies, and ensure strict adherence to internal controls.

### Business Challenge
The General Ledger is the final repository for all financial transactions. However, analyzing this data can be challenging due to:
*   **Volume:** Millions of journal lines make it difficult to find specific transactions using standard forms.
*   **Source Traceability:** Determining the origin of a journal (e.g., "Did this come from Payables or Inventory?") often requires navigating multiple screens.
*   **Compliance Audits:** Auditors frequently request lists of manual journals, unposted entries, or journals created by specific users to test for segregation of duties.
*   **Reconciliation:** Identifying the specific journal lines that make up a GL account balance is often a manual, error-prone process.

### The Solution
This report solves these challenges by offering a powerful, parameter-driven "Operational View" of the General Ledger.
*   **Comprehensive Filtering:** Users can slice data by Period, Source, Category, Status, and specific Account Segments to isolate exactly what they need.
*   **Full Audit Trail:** Displays the "Who, What, When, and Why" of every journal, including the Creator, Approval Status, and Posting Date.
*   **Subledger Visibility:** By including "Reference" and "Description" fields, it helps link GL entries back to their operational source.

### Technical Architecture (High Level)
The report queries the core GL transaction tables, optimized for the star-schema design of Oracle GL.
*   **Primary Tables:**
    *   `GL_JE_BATCHES`: The container for journals, holding control totals and approval status.
    *   `GL_JE_HEADERS`: The journal entry header, defining the Category, Source, and Currency.
    *   `GL_JE_LINES`: The individual debit and credit lines.
    *   `GL_CODE_COMBINATIONS_KFV`: The Chart of Accounts structure.
    *   `GL_LEDGERS` & `GL_PERIODS`: Provides the accounting context.

*   **Logical Relationships:**
    The report follows the standard hierarchy: Batch -> Header -> Line. It joins to the Code Combinations table to resolve the accounting flexfield segments (Company, Department, Account, etc.) into readable values.

### Parameters & Filtering
*   **Posting Status:** Critical for month-end close. Allows users to find 'Unposted' or 'Error' journals that are holding up the close process.
*   **Source & Category:** Enables targeted analysis (e.g., "Show me all 'Manual' journals" or "Show me all 'Accrual' entries").
*   **Account Segments (GL_SEGMENT1...10):** Allows for precise account analysis (e.g., "Show all journals hitting the 'Travel Expense' account in the 'Sales' department").
*   **Exclude SLA Journals:** A performance and usability feature. Since Subledger Accounting (SLA) generates massive volumes of detailed journals, excluding them allows for a cleaner view of manual and summary-level entries.

### Performance & Optimization
*   **Partition Pruning:** By filtering on `GL_LEDGERS` and `GL_PERIODS`, the query takes advantage of Oracle's standard partitioning strategies for GL tables.
*   **Selective Columns:** The report allows users to toggle "Show Journal Line DFF Attributes" and "Show Attachment Details," preventing unnecessary data retrieval when not needed.

### FAQ
**Q: How can I find all manual journal entries created last month?**
A: Set the "Period" to last month and the "Journal Source" parameter to 'Manual'.

**Q: Does this report show the foreign currency amounts?**
A: Yes, the report displays both the "Entered" (foreign) currency amounts and the "Accounted" (functional) currency amounts, along with the conversion rate used.

**Q: Why can't I see the subledger transaction details (e.g., Invoice Number) here?**
A: This report shows the *GL* view. While some references are carried over to `GL_JE_LINES.REFERENCE_1`, detailed subledger data is best viewed in the "GL Account Analysis (Drilldown)" report or specific subledger reports.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-journals)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
