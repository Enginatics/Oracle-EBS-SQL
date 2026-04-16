---
layout: default
title: 'GL Journals 11i | Oracle EBS SQL Report'
description: 'GL batches and journals report, including amounts and attachments – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Journals, 11i, gl_code_combinations_kfv, gl_je_sources_vl, gl_je_categories_vl'
permalink: /GL%20Journals%2011i/
---

# GL Journals 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-journals-11i/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
GL batches and journals report, including amounts and attachments

## Report Parameters
Ledger, Ledger Category, Period, Period From, Period To, Posted Date From, Posted Date To, Creation Date From, Creation Date To, Created By, Journal Source, Journal Category, Posting Status, Funds Status, Exclude SLA Journals, Batch, Journal, Currency, Show Journal Line DFF Attributes, Show Attachment Details, Balance Type, Budget Name, Encumbrance Type, Reference, Concatenated Segments, GL_SEGMENT1, GL_SEGMENT1 From, GL_SEGMENT1 To, GL_SEGMENT2, GL_SEGMENT2 From, GL_SEGMENT2 To, GL_SEGMENT3, GL_SEGMENT3 From, GL_SEGMENT3 To, GL_SEGMENT4, GL_SEGMENT4 From, GL_SEGMENT4 To, GL_SEGMENT5, GL_SEGMENT5 From, GL_SEGMENT5 To, GL_SEGMENT6, GL_SEGMENT6 From, GL_SEGMENT6 To, GL_SEGMENT7, GL_SEGMENT7 From, GL_SEGMENT7 To, GL_SEGMENT8, GL_SEGMENT8 From, GL_SEGMENT8 To, GL_SEGMENT9, GL_SEGMENT9 From, GL_SEGMENT9 To, GL_SEGMENT10, GL_SEGMENT10 From, GL_SEGMENT10 To

## Oracle EBS Tables Used
[gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [gl_je_sources_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_sources_vl), [gl_je_categories_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_categories_vl), [gl_budget_versions](https://www.enginatics.com/library/?pg=1&find=gl_budget_versions), [gl_encumbrance_types](https://www.enginatics.com/library/?pg=1&find=gl_encumbrance_types), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [gl_je_headers](https://www.enginatics.com/library/?pg=1&find=gl_je_headers), [xxen_gl_ledgers_v](https://www.enginatics.com/library/?pg=1&find=xxen_gl_ledgers_v), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods), [gl_je_batches](https://www.enginatics.com/library/?pg=1&find=gl_je_batches), [gl_je_lines](https://www.enginatics.com/library/?pg=1&find=gl_je_lines), [gl_je_lines_recon](https://www.enginatics.com/library/?pg=1&find=gl_je_lines_recon), [gcck](https://www.enginatics.com/library/?pg=1&find=gcck), [fnd_attached_documents](https://www.enginatics.com/library/?pg=1&find=fnd_attached_documents), [fnd_documents](https://www.enginatics.com/library/?pg=1&find=fnd_documents), [fnd_documents_tl](https://www.enginatics.com/library/?pg=1&find=fnd_documents_tl), [fnd_document_datatypes](https://www.enginatics.com/library/?pg=1&find=fnd_document_datatypes), [fnd_document_categories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_document_categories_vl), [fnd_lobs](https://www.enginatics.com/library/?pg=1&find=fnd_lobs), [fnd_documents_short_text](https://www.enginatics.com/library/?pg=1&find=fnd_documents_short_text), [fnd_documents_long_text](https://www.enginatics.com/library/?pg=1&find=fnd_documents_long_text)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Journals (Drilldown) 11g](/GL%20Journals%20%28Drilldown%29%2011g/ "GL Journals (Drilldown) 11g Oracle EBS SQL Report"), [GL Journals (Drilldown)](/GL%20Journals%20%28Drilldown%29/ "GL Journals (Drilldown) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/gl-journals-11i/) |
| Blitz Report™ XML Import | [GL_Journals_11i.xml](https://www.enginatics.com/xml/gl-journals-11i/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-journals-11i/](https://www.enginatics.com/reports/gl-journals-11i/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
