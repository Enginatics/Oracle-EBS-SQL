---
layout: default
last_modified_at: 2026-10-26
title: 'FUN Intercompany Transaction Upload | Oracle EBS SQL Report'
description: 'FUN Intercompany Transaction Upload ================================== Creates, updates and submits Advanced Global Intercompany System (AGIS)…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, FUN, Intercompany, Transaction, fun_trx_batches, hz_parties, fun_trx_types_vl'
permalink: /FUN%20Intercompany%20Transaction%20Upload/
report_name: 'FUN Intercompany Transaction Upload'
report_web_name: fun-intercompany-transaction-upload
---

# FUN Intercompany Transaction Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fun-intercompany-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload).

## Overview
FUN Intercompany Transaction Upload
==================================
Creates, updates and submits Advanced Global Intercompany System (AGIS) intercompany batches as entered on the Intercompany Super User > Transactions > Outbound pages: the batch with its initiator, the transactions to each recipient, and their initiator and recipient distributions.

Each row is one initiator distribution and/or one recipient distribution of a transaction. Batch columns repeat on every row of the batch and transaction columns on every row of the transaction. Rows are grouped into a batch by Initiator and Batch Number. With automatic batch numbering (Intercompany System Options) the entered Batch Number only groups the rows and the batch receives the next number, which the result file shows.

Rows are loaded into the intercompany open interface and imported by Oracle's Intercompany Import Program, which applies the same validations as the Outbound pages. A batch is imported completely or not at all, and the rows of a rejected batch show the import's rejection reasons.

Submit = Yes imports the batch as sent, which starts the intercompany approval workflow, as the Submit button does.

Upload Mode
===========

Create
------
Opens an empty spreadsheet to enter new batches.

Create, Update
--------------
Additionally downloads existing batches. Only batches with status New can be changed or submitted. An updated batch is imported again as a whole, including its transactions and distributions not present in the upload, and replaces the existing batch once the import has accepted it. It keeps its batch number but gets a new batch id. Distributions cannot be deleted.

Only batches of initiators the user is an intercompany contact for are listed, and the user must be assigned to an employee.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Initiator, Batch Number, Batch Status, GL Date From, GL Date To

## Oracle EBS Tables Used
[fun_trx_batches](https://www.enginatics.com/library/?pg=1&find=fun_trx_batches&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload), [fun_trx_types_vl](https://www.enginatics.com/library/?pg=1&find=fun_trx_types_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload), [fun_trx_headers](https://www.enginatics.com/library/?pg=1&find=fun_trx_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload), [fun_dist_lines](https://www.enginatics.com/library/?pg=1&find=fun_dist_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload)

## Related Reports
[GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown)](/GL%20Account%20Analysis%20%28Drilldown%29/ "GL Account Analysis (Drilldown) Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [AR Transaction Upload](/AR%20Transaction%20Upload/ "AR Transaction Upload Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FUN%20Intercompany%20Transaction%20Upload/FUN%20Intercompany%20Transaction%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/fun-intercompany-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload) |
| Blitz Report™ XML Import | [FUN_Intercompany_Transaction_Upload.xml](https://www.enginatics.com/xml/fun-intercompany-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload) |
| SQL Source | [FUN Intercompany Transaction Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FUN%20Intercompany%20Transaction%20Upload/FUN%20Intercompany%20Transaction%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fun-intercompany-transaction-upload/](https://www.enginatics.com/reports/fun-intercompany-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fun-intercompany-transaction-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
