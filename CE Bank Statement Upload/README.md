---
layout: default
last_modified_at: 2026-10-19
title: 'CE Bank Statement Upload | Oracle EBS SQL Report'
description: 'CE Bank Statement Upload ======================== Loads bank statements (header and lines) into Oracle Cash Management through the bank statement open…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Bank, Statement, ce_statement_headers_int, ce_statement_lines_interface'
permalink: /CE%20Bank%20Statement%20Upload/
report_name: 'CE Bank Statement Upload'
report_web_name: ce-bank-statement-upload
---

# CE Bank Statement Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ce-bank-statement-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-upload).

## Overview
CE Bank Statement Upload
========================
Loads bank statements (header and lines) into Oracle Cash Management through the bank statement open interface and runs Oracle's Bank Statement Import automatically after upload.

Optionally, AutoReconciliation runs in the same step to match the imported statement lines against AR receipts, AP payments and GL journal lines according to the bank account's transaction codes and matching rules, in the same way as the standard 'Bank Statement Import & AutoReconciliation' concurrent program.

Each row represents one statement line. Statement header information (Account Number, Statement Number, Statement Date, Currency, Control Balances) repeats on every row and the statement header is created once per statement number. Line numbers are assigned automatically per statement when left blank.

Credit and debit control totals are computed automatically from the entered lines and their transaction code types.

Upload Mode
===========

Create
------
Opens an empty spreadsheet to enter new bank statements, for example pasted from a bank portal export.

Create, Update
--------------
Additionally returns statement lines that are still sitting in the bank statement open interface and did not import. Correct them and re-upload; corrected lines replace the previously staged interface records and are imported again.

Notes
=====
- Statements that are already imported into Cash Management cannot be loaded again under the same statement number.
- Rows failing the import show the Cash Management interface error messages in the result file. The standard Bank Statement Import Execution Report provides the same details.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, AutoReconciliation, GL Date, Account Number, Statement Number

## Oracle EBS Tables Used
[ce_statement_headers_int](https://www.enginatics.com/library/?pg=1&find=ce_statement_headers_int&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-upload), [ce_statement_lines_interface](https://www.enginatics.com/library/?pg=1&find=ce_statement_lines_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-upload)

## Related Reports
[CE Bank Statement and Reconciliation](/CE%20Bank%20Statement%20and%20Reconciliation/ "CE Bank Statement and Reconciliation Oracle EBS SQL Report"), [CE Bank Statement Import Execution](/CE%20Bank%20Statement%20Import%20Execution/ "CE Bank Statement Import Execution Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [CE Transactions Available for Reconciliation](/CE%20Transactions%20Available%20for%20Reconciliation/ "CE Transactions Available for Reconciliation Oracle EBS SQL Report"), [CE General Ledger Reconciliation](/CE%20General%20Ledger%20Reconciliation/ "CE General Ledger Reconciliation Oracle EBS SQL Report"), [CE Cash in Transit](/CE%20Cash%20in%20Transit/ "CE Cash in Transit Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CE%20Bank%20Statement%20Upload/CE%20Bank%20Statement%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ce-bank-statement-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-upload) |
| Blitz Report™ XML Import | [CE_Bank_Statement_Upload.xml](https://www.enginatics.com/xml/ce-bank-statement-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-upload) |
| SQL Source | [CE Bank Statement Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CE%20Bank%20Statement%20Upload/CE%20Bank%20Statement%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ce-bank-statement-upload/](https://www.enginatics.com/reports/ce-bank-statement-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-upload) |

## Case Study & Technical Analysis: CE Bank Statement Upload

### Executive Summary
This upload loads bank statement headers and lines into Oracle Cash Management through the bank statement open interface, then runs Oracle's Bank Statement Import automatically. It can also run AutoReconciliation in the same step, matching imported lines against AR receipts, AP payments and GL journal lines according to the bank account's transaction codes and matching rules. Treasury and cash management teams use it to load statements exported from bank portals without keying each line, and to reconcile the day's cash in one pass. The template runs in Excel through Blitz Report.

### Business Challenge
*   **Manual statement entry:** Keying bank lines into Cash Management is slow when accounts produce daily statements with many transactions.
*   **Unreconciled cash:** Statement lines that stay unmatched delay bank reconciliation and hide differences between the bank and the ledger.
*   **Import failures:** Lines that fail import must be found, corrected and loaded again without losing the statement.
*   **Duplicate loads:** A statement number must not be loaded twice into the same bank account.

### The Solution
*   **Header and line rows:** Each row is one statement line, and the header fields repeat on every row of the same statement.
*   **Automatic line numbers:** Line numbers are assigned per statement when left blank.
*   **Control totals:** Credit and debit control totals are computed from the entered lines and their transaction code types.
*   **Import and reconcile:** Bank Statement Import runs after upload, and AutoReconciliation is optional through the AutoReconciliation parameter.
*   **Correct and resubmit:** In Create, Update mode, lines still held in the interface are returned for correction, and corrected lines replace the staged records.

### Technical Architecture (High Level)
#### Primary Tables
*   `CE_STATEMENT_HEADERS_INT`: the statement header interface, holding the bank account number, statement number, date, currency and control balances.
*   `CE_STATEMENT_LINES_INTERFACE`: the statement line interface, holding the line number, transaction date and code, amount, bank transaction number, text fields and value date.

#### Logical Relationships
1. `CE_STATEMENT_HEADERS_INT` is the driving table, and `CE_STATEMENT_LINES_INTERFACE` is joined to it on bank account number and statement number as an outer join, so a header without lines still appears.
2. The GL date and the auto-reconcile flag are passed in as bind values and returned on each row.
3. A row number ordered by bank account, statement number and line number is produced as the upload row reference.
4. Rows whose header record status is T, meaning already transferred, are excluded by the filter on record status.

### Parameters & Filtering
*   **Upload Mode:** selects Create, or Create, Update to return lines that did not import.
*   **AutoReconciliation:** when set, the import runs AutoReconciliation against AR, AP and GL records.
*   **GL Date:** the accounting date applied to the imported lines.
*   **Account Number:** restricts the returned statements to one bank account.
*   **Statement Number:** restricts the returned statements to one statement number.

### Performance & Optimization
*   The filter on record status excludes statements already transferred, so the interface scan is limited to pending and new records.
*   The outer join on bank account and statement number keeps headers without lines in the result without a second query.
*   The row number is computed with an analytic function over the account, statement and line keys, which gives a stable upload row reference for the file.

### FAQ
**Q: Can I load a statement number that was already imported?**
A: No. Statements already imported into Cash Management cannot be loaded again under the same statement number.

**Q: Where do I see why a line failed to import?**
A: Failed rows show the Cash Management interface error messages in the result file. The standard Bank Statement Import Execution Report gives the same detail.

**Q: How do I fix a line that did not import?**
A: Download with Create, Update, correct the returned line, and upload it again. The corrected line replaces the staged interface record and is imported again.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
