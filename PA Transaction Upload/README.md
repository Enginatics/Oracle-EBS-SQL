---
layout: default
last_modified_at: 2026-10-19
title: 'PA Transaction Upload | Oracle EBS SQL Report'
description: 'PA Transaction Upload =================== This upload can be used to upload transactions from external cost collection systems into Oracle Projects…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Transaction, pa_transaction_sources, gl_code_combinations_kfv, pa_transaction_interface_all'
permalink: /PA%20Transaction%20Upload/
report_name: 'PA Transaction Upload'
report_web_name: pa-transaction-upload
---

# PA Transaction Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-transaction-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-transaction-upload).

## Overview
PA Transaction Upload
===================
This upload can be used to upload transactions from external cost collection systems into Oracle Projects. 
Transaction Import creates pre-approved expenditure items from transaction data entered in external cost collection systems.

If the 'Operating Unit' and/or 'Transaction Source' parameters are specified, then the upload excel will be restricted to the specified Operating Unit and/or Transaction Source.

If the 'Batch Name' parameter is specified, this will default as the Batch Name in the upload Excel.

If the 'All Negative Expend Unmatched' parameter is set to Yes, then all negative transations then the 'Unmatched Negative Txn Flag' column will automatically default to Yes against any negative transactions entered into upload Excel.

If the 'Reverse in Future Period' parameter is set to Yes, then the 'Accrual Flag' column will default to Yes against every transaction entered in the upload Excel

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-transaction-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Transaction Source, Batch Name, Expenditure Ending Date, All Negative Expend Unmatched, Reverse in Future Period, Import Transactions

## Oracle EBS Tables Used
[pa_transaction_sources](https://www.enginatics.com/library/?pg=1&find=pa_transaction_sources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-transaction-upload), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-transaction-upload), [pa_transaction_interface_all](https://www.enginatics.com/library/?pg=1&find=pa_transaction_interface_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-transaction-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-transaction-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-transaction-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-transaction-upload)

## Related Reports
[GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [ONT Orders and Lines 11i](/ONT%20Orders%20and%20Lines%2011i/ "ONT Orders and Lines 11i Oracle EBS SQL Report"), [ONT Orders and Lines](/ONT%20Orders%20and%20Lines/ "ONT Orders and Lines Oracle EBS SQL Report"), [AR Transaction Upload](/AR%20Transaction%20Upload/ "AR Transaction Upload Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Transaction%20Upload/PA%20Transaction%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-transaction-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/pa-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-transaction-upload) |
| Blitz Report™ XML Import | [PA_Transaction_Upload.xml](https://www.enginatics.com/xml/pa-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-transaction-upload) |
| SQL Source | [PA Transaction Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Transaction%20Upload/PA%20Transaction%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pa-transaction-upload/](https://www.enginatics.com/reports/pa-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-transaction-upload) |

## Case Study & Technical Analysis: PA Transaction Upload

### Executive Summary
The PA Transaction Upload is an Excel upload that loads transactions from external cost collection systems into Oracle Projects. Transaction Import then creates pre-approved expenditure items from the rows, which are entered in the transaction interface table. Project accounting teams use the upload for costs that originate outside Oracle Projects, such as timesheets, usages, miscellaneous costs and supplier invoices from other systems, and for reversals and accruals of those costs. The Blitz Report download shows the interface rows already staged, so that they can be corrected before the Import Transactions step runs.

### Business Challenge
*   **External cost capture:** Project costs recorded in time, expense or procurement systems outside Oracle Projects must be brought into the projects with the right project, task and expenditure type.
*   **Accuracy before import:** Once transactions are imported, correcting them takes more work, so the team needs to check them in Excel before they are loaded.
*   **Accrual and reversal:** Costs that are reversed or accrued in a future period require flags on each transaction, and negative transactions need to be matched to their originals.
*   **Batch control:** Transactions are grouped into batches, and the batch name, transaction source and expenditure ending date must be consistent across a load.

### The Solution
*   Lists each interface row with its operating unit, transaction source, expenditure type class, expenditure ending date and batch name.
*   Shows the organization, employee, business group, project, task, expenditure type and the cost in the transaction currency and the accounting currency.
*   Shows the exchange rate type, date and rate for the accounting, receipt and project currencies, so that the conversion is visible before import.
*   Shows the debit and credit accounts, the GL date, the vendor and purchase order references, the accrual and billable flags, and the attribute columns.

### Technical Architecture (High Level)
#### Primary Tables
*   `PA_TRANSACTION_INTERFACE_ALL`: the transactions staged for Transaction Import, with the project, task, expenditure, cost, rate and account fields.
*   `PA_TRANSACTION_SOURCES`: the user name of each transaction source.
*   `GL_CODE_COMBINATIONS_KFV`: the debit and credit accounts of each transaction.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit of each transaction.

#### Logical Relationships
1.  `PA_TRANSACTION_INTERFACE_ALL` is joined to `HR_ALL_ORGANIZATION_UNITS_VL` on the organization id, which supplies the operating unit name.
2.  The transaction source name is a scalar lookup on `PA_TRANSACTION_SOURCES` through the transaction source code of the row.
3.  The debit and credit accounts are scalar lookups on `GL_CODE_COMBINATIONS_KFV` through the debit and credit code combination ids.
4.  The report applies the parameter values as filters on the interface row fields, so each interface row is returned with its own batch and source.

### Parameters & Filtering
*   **Operating Unit:** restricts the rows to one operating unit.
*   **Transaction Source:** restricts the rows to one transaction source.
*   **Batch Name:** restricts the rows to one batch, which is also the default batch name in the upload file.
*   **Expenditure Ending Date:** the expenditure ending date applied to the rows.
*   **All Negative Expend Unmatched:** when set to Yes, the Negative Txn Flag defaults to Yes for negative transactions.
*   **Reverse in Future Period:** when set to Yes, the Accrual Flag defaults to Yes for every row.
*   **Import Transactions:** shows whether the rows are to be submitted to Transaction Import.

### Performance & Optimization
*   The rows are read from a single interface table, so the query has one large source and small lookups for the operating unit, the sources and the accounts.
*   The account and source lookups are scalar subqueries on primary keys, which return one value for each row.
*   Filtering by Operating Unit, Transaction Source and Batch Name reduces the interface rows before the lookups run.
*   Restricting the download to one batch with the Batch Name parameter gives the user a smaller set of rows to check before Transaction Import is submitted.

### FAQ
**Q: How do I load timesheet or usage costs from an external system into Oracle Projects?**
A: Enter the transactions in the upload with their project, task, expenditure type and cost, and select the transaction source and batch name. Then run Transaction Import, which creates pre-approved expenditure items.

**Q: How do I flag negative transactions as unmatched?**
A: Set the All Negative Expend Unmatched parameter to Yes. Negative transactions then default to an Unmatched Negative Txn Flag of Yes in the upload.

**Q: What does the Reverse in Future Period parameter do?**
A: When set to Yes, it sets the Accrual Flag to Yes for every transaction entered in the upload, so the costs are reversed in the future period.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-transaction-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-transaction-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-transaction-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-transaction-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-transaction-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-transaction-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-transaction-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
