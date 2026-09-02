---
layout: default
title: 'CE Bank Statement Upload | Oracle EBS SQL Report'
description: 'CE Bank Statement Upload ======================== Loads bank statements (header and lines) into Oracle Cash Management through the bank statement open…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Bank, Statement, ce_statement_headers_int, ce_statement_lines_interface'
permalink: /CE%20Bank%20Statement%20Upload/
---

# CE Bank Statement Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ce-bank-statement-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
Upload Mode, AutoReconciliation, GL Date, Account Number, Statement Number

## Oracle EBS Tables Used
[ce_statement_headers_int](https://www.enginatics.com/library/?pg=1&find=ce_statement_headers_int), [ce_statement_lines_interface](https://www.enginatics.com/library/?pg=1&find=ce_statement_lines_interface)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[CE Bank Statement and Reconciliation](/CE%20Bank%20Statement%20and%20Reconciliation/ "CE Bank Statement and Reconciliation Oracle EBS SQL Report"), [CE Bank Statement Import Execution](/CE%20Bank%20Statement%20Import%20Execution/ "CE Bank Statement Import Execution Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [CE General Ledger Reconciliation](/CE%20General%20Ledger%20Reconciliation/ "CE General Ledger Reconciliation Oracle EBS SQL Report"), [CE Transactions Available for Reconciliation](/CE%20Transactions%20Available%20for%20Reconciliation/ "CE Transactions Available for Reconciliation Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/ce-bank-statement-upload/) |
| Blitz Report™ XML Import | [CE_Bank_Statement_Upload.xml](https://www.enginatics.com/xml/ce-bank-statement-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ce-bank-statement-upload/](https://www.enginatics.com/reports/ce-bank-statement-upload/) |



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
