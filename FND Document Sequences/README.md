---
layout: default
last_modified_at: 2026-10-19
title: 'FND Document Sequences | Oracle EBS SQL Report'
description: 'Document sequence details including database sequence name and last seqeunce number.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Document, Sequences, dba_sequences, fnd_application_vl, fnd_document_sequences'
permalink: /FND%20Document%20Sequences/
report_name: 'FND Document Sequences'
report_web_name: fnd-document-sequences
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Document Sequences – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-document-sequences/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequences) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequences).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Document sequence details including database sequence name and last seqeunce number.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequences) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Application, Table Name

## Oracle EBS Tables Used
[dba_sequences](https://www.enginatics.com/library/?pg=1&find=dba_sequences&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequences), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequences), [fnd_document_sequences](https://www.enginatics.com/library/?pg=1&find=fnd_document_sequences&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequences)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequences)

## Related Reports
[FND Document Sequence Assignments](/FND%20Document%20Sequence%20Assignments/ "FND Document Sequence Assignments Oracle EBS SQL Report"), [FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [INV Kanban Cards](/INV%20Kanban%20Cards/ "INV Kanban Cards Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [AP Invoice and Payment Audit by Voucher Number](/AP%20Invoice%20and%20Payment%20Audit%20by%20Voucher%20Number/ "AP Invoice and Payment Audit by Voucher Number Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Document%20Sequences/FND%20Document%20Sequences.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequences) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Document Sequences 24-May-2025 131533.xlsx](https://www.enginatics.com/example/fnd-document-sequences/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequences) |
| Blitz Report™ XML Import | [FND_Document_Sequences.xml](https://www.enginatics.com/xml/fnd-document-sequences/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequences) |
| SQL Source | [FND Document Sequences.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Document%20Sequences/FND%20Document%20Sequences.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-document-sequences/](https://www.enginatics.com/reports/fnd-document-sequences/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequences) |

## Executive Summary
The **FND Document Sequences** report provides a master list of all defined document sequences in the system, regardless of whether they are currently assigned.

## Business Challenge
*   **Sequence Management:** Monitoring the consumption of sequences to prevent running out of numbers (e.g., hitting the maximum value).
*   **Cleanup:** Identifying old or unused sequences from previous years.
*   **Type Analysis:** Reviewing which sequences are "Gapless" vs. "Automatic".

## The Solution
This Blitz Report details the sequence definition:
*   **Sequence Name:** The name of the sequence object.
*   **Type:** Automatic, Manual, or Gapless.
*   **Initial Value:** The starting number.
*   **Current Value:** The last number generated (from `DBA_SEQUENCES`).

## Technical Architecture
The report queries `FND_DOCUMENT_SEQUENCES` and joins to `DBA_SEQUENCES` to fetch the current state of the database object.

## Parameters & Filtering
*   **Application:** Filter by the owning application.
*   **Table Name:** Filter by the table the sequence is intended for.

## Performance & Optimization
*   **Fast Execution:** Runs quickly against the metadata tables.

## FAQ
*   **Q: What is the difference between this and the "Assignments" report?**
    *   A: This report lists the *sequences* themselves (the number generators). The "Assignments" report shows *where* those sequences are used (linked to a Category and Ledger).

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequences)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequences)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequences)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequences)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequences)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequences)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-document-sequences)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
