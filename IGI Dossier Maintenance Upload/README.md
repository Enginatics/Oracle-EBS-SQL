---
layout: default
last_modified_at: 2026-10-16
title: 'IGI Dossier Maintenance Upload | Oracle EBS SQL Report'
description: 'Upload to create and maintain dossier transactions (budget transfers) for Oracle Public Sector Financials International (IGI). Supports header creation…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, IGI, Dossier, Maintenance, igi_dos_trx_headers, igi_dos_doc_types, gl_ledgers'
permalink: /IGI%20Dossier%20Maintenance%20Upload/
report_name: 'IGI Dossier Maintenance Upload'
report_web_name: igi-dossier-maintenance-upload
---

# IGI Dossier Maintenance Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/igi-dossier-maintenance-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload).

## Overview
Upload to create and maintain dossier transactions (budget transfers) for Oracle Public Sector Financials International (IGI). Supports header creation with source and destination budget lines using the seeded IGI Dossier Maintenance APIs.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Ledger, Transaction Number

## Oracle EBS Tables Used
[igi_dos_trx_headers](https://www.enginatics.com/library/?pg=1&find=igi_dos_trx_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload), [igi_dos_doc_types](https://www.enginatics.com/library/?pg=1&find=igi_dos_doc_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload), [igi_dos_trx_sources](https://www.enginatics.com/library/?pg=1&find=igi_dos_trx_sources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload), [igi_dos_trx_dest](https://www.enginatics.com/library/?pg=1&find=igi_dos_trx_dest&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload)

## Related Reports
[GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/IGI%20Dossier%20Maintenance%20Upload/IGI%20Dossier%20Maintenance%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/igi-dossier-maintenance-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload) |
| Blitz Report™ XML Import | [IGI_Dossier_Maintenance_Upload.xml](https://www.enginatics.com/xml/igi-dossier-maintenance-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload) |
| SQL Source | [IGI Dossier Maintenance Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/IGI%20Dossier%20Maintenance%20Upload/IGI%20Dossier%20Maintenance%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/igi-dossier-maintenance-upload/](https://www.enginatics.com/reports/igi-dossier-maintenance-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload) |

## Case Study & Technical Analysis: IGI Dossier Maintenance Upload

### Executive Summary
IGI Dossier Maintenance Upload provides a spreadsheet interface for dossier transactions in Oracle Public Sector Financials International (IGI). A dossier transaction is a budget transfer that moves funds from a source budget line to one or more destination budget lines, and this upload downloads existing transactions and creates new ones through the seeded IGI dossier maintenance APIs. It is used by public sector finance teams who must process budget transfers in bulk and keep the source and destination lines consistent.

### Business Challenge
*   **Budget Transfer Volume:** Public sector budgets are revised frequently, and each transfer must be entered with its source and destination lines.
*   **Consistency of Lines:** A transfer must reference the same source and destination lines in a way the dossier structure accepts, which is error prone when typed by hand.
*   **Status Tracking:** Transactions move through statuses, and the team needs to see which transfers are pending and which are complete.
*   **Parent Transactions:** Some corrections reference an earlier transaction, so the link between the two must be visible.

### The Solution
*   **Header Upload:** Each row describes a transaction header with its dossier type, amount type, number, description and status.
*   **Paired Budget Lines:** The source and destination budget lines, with their budget, period, account and amounts, are shown on the same row, so the transfer is visible as a whole.
*   **Funds Visibility:** Funds available and new balance values are returned for both sides, so the effect of the transfer can be checked before it is posted.
*   **Ledger Scope:** The ledger parameter restricts the transactions to one set of books.

### Technical Architecture (High Level)
#### Primary Tables
*   `IGI_DOS_TRX_HEADERS`: the transaction headers with the transaction number, description, status and parent transaction number.
*   `IGI_DOS_DOC_TYPES`: the dossier document types, which give the dossier name and amount type.
*   `IGI_DOS_TRX_SOURCES`: the source lines of each transaction, with the budget, the period, the code combination and the funds figures.
*   `IGI_DOS_TRX_DEST`: the destination lines of each transaction, carrying the same kind of figures.
*   `GL_LEDGERS`: the ledger that owns the transaction.
*   `GL_CODE_COMBINATIONS_KFV`: the account combinations of the source and destination lines.

#### Logical Relationships
1.  Each header in `IGI_DOS_TRX_HEADERS` is joined to its document type in `IGI_DOS_DOC_TYPES` on the dossier identifier.
2.  The header is joined to `GL_LEDGERS` on the set of books identifier.
3.  Source lines in `IGI_DOS_TRX_SOURCES` are joined to the header on the transaction identifier.
4.  Destination lines in `IGI_DOS_TRX_DEST` are joined to their source line on the source transaction identifier, and to the header on the transaction identifier.
5.  Each source and destination line is outer joined to `GL_CODE_COMBINATIONS_KFV` to return its account.

### Parameters & Filtering
*   **Upload Mode:** Selects Create, or Create and Update, which controls whether existing transactions are downloaded.
*   **Ledger:** Restricts the transactions to one ledger.
*   **Transaction Number:** Selects one transaction for review or correction.

### Performance & Optimization
*   **Header Driven Extract:** The header is the driving table, and the source and destination lines are reached through their transaction identifiers.
*   **Outer Joins to Accounts:** Code combination lookups are outer joined, so a line with no account still returns its budget data.
*   **Ledger Filter:** The ledger join keeps the header set to one set of books when a ledger is selected.
*   **Scope:** The report is classified as R12 only, and the data it reads is limited to the IGI dossier tables and the ledger.

### FAQ
**Q: Can this upload create a budget transfer with several destination lines?**
A: The source and destination structure is shown as one row per line pair. Each destination line carries its own budget, period, account and amount values.

**Q: Where can I find the parent transaction of a correction?**
A: The Parent Transaction Number column returns the transaction number of the earlier transaction that the current one references.

**Q: Does the upload show the funds check result?**
A: It shows the funds available and the new balance for the source and destination lines. These values come from the transaction lines as stored.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=igi-dossier-maintenance-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
