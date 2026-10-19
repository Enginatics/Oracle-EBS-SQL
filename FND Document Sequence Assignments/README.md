---
layout: default
last_modified_at: 2026-10-19
title: 'FND Document Sequence Assignments | Oracle EBS SQL Report'
description: 'Document sequence asssignments to application tables, ledgers and categories, including sequence details such as database sequence name and last seqeunce…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Document, Sequence, Assignments, dba_sequences, fnd_application_vl, fnd_doc_sequence_assignments'
permalink: /FND%20Document%20Sequence%20Assignments/
report_name: 'FND Document Sequence Assignments'
report_web_name: fnd-document-sequence-assignments
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Document Sequence Assignments – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-document-sequence-assignments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequence-assignments) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequence-assignments).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Document sequence asssignments to application tables, ledgers and categories, including sequence details such as database sequence name and last seqeunce number.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequence-assignments) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Application, Ledger

## Oracle EBS Tables Used
[dba_sequences](https://www.enginatics.com/library/?pg=1&find=dba_sequences&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequence-assignments), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequence-assignments), [fnd_doc_sequence_assignments](https://www.enginatics.com/library/?pg=1&find=fnd_doc_sequence_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequence-assignments), [fnd_document_sequences](https://www.enginatics.com/library/?pg=1&find=fnd_document_sequences&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequence-assignments), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequence-assignments), [fnd_doc_sequence_categories](https://www.enginatics.com/library/?pg=1&find=fnd_doc_sequence_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequence-assignments)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequence-assignments)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [AP Invoice and Payment Audit by Voucher Number](/AP%20Invoice%20and%20Payment%20Audit%20by%20Voucher%20Number/ "AP Invoice and Payment Audit by Voucher Number Oracle EBS SQL Report"), [FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Document%20Sequence%20Assignments/FND%20Document%20Sequence%20Assignments.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequence-assignments) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Document Sequence Assignments 24-May-2025 131440.xlsx](https://www.enginatics.com/example/fnd-document-sequence-assignments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequence-assignments) |
| Blitz Report™ XML Import | [FND_Document_Sequence_Assignments.xml](https://www.enginatics.com/xml/fnd-document-sequence-assignments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequence-assignments) |
| SQL Source | [FND Document Sequence Assignments.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Document%20Sequence%20Assignments/FND%20Document%20Sequence%20Assignments.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-document-sequence-assignments/](https://www.enginatics.com/reports/fnd-document-sequence-assignments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequence-assignments) |

## Executive Summary
The **FND Document Sequence Assignments** report is a critical audit tool for verifying voucher numbering configurations. It shows which sequence is active for a given document category and ledger.

## Business Challenge
*   **Gap Analysis:** Ensuring that every transaction type has an active sequence assigned to prevent "Sequence not found" errors.
*   **Audit Trail:** Verifying that the correct sequence is being used for the current fiscal year.
*   **Legal Compliance:** Proving to auditors that document numbering is continuous and gapless (if required).

## The Solution
This Blitz Report joins the assignment definition with the sequence status:
*   **Assignment:** Shows the Category, Ledger (or Set of Books), and Method (Automatic, Manual, Gapless).
*   **Sequence Details:** Displays the name of the assigned sequence and its current value in the database.
*   **Date Range:** Shows the effective start and end dates of the assignment.

## Technical Architecture
The report joins `FND_DOC_SEQUENCE_ASSIGNMENTS` with `FND_DOCUMENT_SEQUENCES` and `GL_LEDGERS`. It also checks `DBA_SEQUENCES` to show the actual "Last Number" generated by the database object.

## Parameters & Filtering
*   **Application:** Filter by module.
*   **Ledger:** Filter by specific legal entity or ledger.

## Performance & Optimization
*   **Database Check:** The report queries `DBA_SEQUENCES` to get real-time values, which is very fast.

## FAQ
*   **Q: Why is the "Last Number" different from the maximum number in the table?**
    *   A: `DBA_SEQUENCES` shows the *next* available number or the cached high water mark. It may be slightly ahead of the actual used numbers due to caching.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequence-assignments)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequence-assignments)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequence-assignments)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequence-assignments)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequence-assignments)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequence-assignments)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequence-assignments)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
