---
layout: default
last_modified_at: 2026-10-16
title: 'AR Applied Receipts | Oracle EBS SQL Report'
description: 'Application: Receivables Description: Receivables Applied Receipts Register Provided Templates: Default: Detail - Detail Listing with no Pivot…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Receivables, Enginatics, R12 only, Applied, Receipts, ar_receivable_apps_all_mrc_v, where, ar_receivable_applications_all'
permalink: /AR%20Applied%20Receipts/
report_name: 'AR Applied Receipts'
report_web_name: ar-applied-receipts
module: 'Receivables'
module_url: /modules/receivables/
---

# AR Applied Receipts – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-applied-receipts/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-applied-receipts) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-applied-receipts).
**Oracle EBS module:** [Receivables](/modules/receivables/ "Oracle EBS Receivables reports") · [all Receivables reports](/modules/receivables/)  

## Overview
Application: Receivables
Description: Receivables Applied Receipts Register

Provided Templates:
Default: Detail - Detail Listing with no Pivot Summarization
Pivot: Summary by Apply Date - Summary by Balancing Segment, Receipt Currency, Apply Date
Pivot: Summary by Batch - Summary by Balancing Segment, Receipt Currency, Batch
Pivot: Summary by Customer Name - Summary by Balancing Segment, Receipt Currency, Customer with drilldown to details
Pivot: Summary by Debit Account - Summary by Balancing Segment, Account Segment, Debit Account, Receipt Currency
Pivot: Summary by GL Date - Summary by Balancing Segment, Receipt Currency, GL Date

Source: Applied Receipts Register
Short Name: RXARARRG

When India Localization is installed, the following GST columns are also included: GST Registration No, GST PAN No, CESS Amount, CESS Rate, CGST Amount, CGST Non-Recoverable, CGST Recoverable, CGST Rate, Custom Amount, IGST Amount, IGST Non-Recoverable, IGST Recoverable, IGST Rate, Reverse Charge Flag, SGST Amount, SGST Non-Recoverable, SGST Recoverable, SGST Rate, Unclassified Tax Amount, Taxable Value, HSN SAC Code.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-applied-receipts) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Reporting Level, Reporting Context, Balancing Segment Low, Balancing Segment High, Accounting Period, Applied GL Date From, Applied GL Date To, Entered Currency, Customer Name, Customer Name Low, Customer Name High, Customer Account Number, Customer Account Num Low, Customer Account Num High, Receipt Method, Receipt Status, Batch Name Low, Batch Name High, Receipt Date From, Receipt Date To, Deposit Date From, Deposit Date To, Apply Date From, Apply Date To, Receipt Last Updated From, Receipt Last Updated To, Receipt Number Low, Receipt Number High, Document Sequence Name, Document Number Low, Document Number High, Transaction Number Low, Transaction Number High, Transaction Type Low, Transaction Type High, Transaction Date From, Transaction Date To

## Oracle EBS Tables Used
[ar_receivable_apps_all_mrc_v](https://www.enginatics.com/library/?pg=1&find=ar_receivable_apps_all_mrc_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-applied-receipts), [where](https://www.enginatics.com/library/?pg=1&find=where&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-applied-receipts), [ar_receivable_applications_all](https://www.enginatics.com/library/?pg=1&find=ar_receivable_applications_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-applied-receipts), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-applied-receipts), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-applied-receipts)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-applied-receipts), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-applied-receipts)

## Related Reports
[AR Receipt Register](/AR%20Receipt%20Register/ "AR Receipt Register Oracle EBS SQL Report"), [AR Unapplied Receipts Register](/AR%20Unapplied%20Receipts%20Register/ "AR Unapplied Receipts Register Oracle EBS SQL Report"), [ONT Order to Cash Tracker](/ONT%20Order%20to%20Cash%20Tracker/ "ONT Order to Cash Tracker Oracle EBS SQL Report"), [AR Refund Upload](/AR%20Refund%20Upload/ "AR Refund Upload Oracle EBS SQL Report"), [PA Revenue, Cost, Budgets by Resources](/PA%20Revenue-%20Cost-%20Budgets%20by%20Resources/ "PA Revenue, Cost, Budgets by Resources Oracle EBS SQL Report"), [AR Credit Memo Application Upload](/AR%20Credit%20Memo%20Application%20Upload/ "AR Credit Memo Application Upload Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Applied%20Receipts/AR%20Applied%20Receipts.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-applied-receipts) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AR Applied Receipts - Pivot Summary by Customer Name 01-Dec-2023 081511.xlsx](https://www.enginatics.com/example/ar-applied-receipts/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-applied-receipts) |
| Blitz Report™ XML Import | [AR_Applied_Receipts.xml](https://www.enginatics.com/xml/ar-applied-receipts/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-applied-receipts) |
| SQL Source | [AR Applied Receipts.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Applied%20Receipts/AR%20Applied%20Receipts.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ar-applied-receipts/](https://www.enginatics.com/reports/ar-applied-receipts/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-applied-receipts) |

## AR Applied Receipts Register Report

### Executive Summary
The AR Applied Receipts Register provides a detailed record of all customer payments that have been applied to invoices and other receivables transactions. This report is an essential tool for accounts receivable departments, offering a clear and auditable trail of all cash receipts and their application. By providing a comprehensive view of applied receipts, the report helps to ensure the accuracy of customer balances, facilitate reconciliation, and improve cash flow management.

### Business Challenge
Tracking and managing customer payments can be a complex and time-consuming process. Without a clear and comprehensive report, organizations may face:
- **Lack of Visibility:** Difficulty in tracking the status of customer payments and their application to outstanding invoices.
- **Reconciliation Issues:** Discrepancies between the accounts receivable subledger and the general ledger, leading to inaccurate financial reporting.
- **Customer Disputes:** Disputes with customers over the application of payments, which can damage customer relationships and delay collections.
- **Inefficient Cash Management:** Difficulty in forecasting cash inflows and managing working capital effectively.

### The Solution
The AR Applied Receipts Register provides a detailed and actionable view of all applied customer payments. The report helps to:
- **Improve Accuracy:** By providing a clear and detailed record of all applied receipts, the report helps to ensure the accuracy of customer balances and reduce the risk of errors.
- **Streamline Reconciliation:** The report makes it easier to reconcile the accounts receivable subledger with the general ledger, helping to ensure the accuracy of financial statements.
- **Resolve Customer Disputes:** The report provides a clear and auditable trail of all payment applications, which can help to resolve customer disputes quickly and efficiently.
- **Enhance Cash Management:** The report provides a reliable basis for forecasting cash inflows, enabling organizations to better manage their working capital and make more informed financial decisions.

### Technical Architecture (High Level)
The report is based on a query of the `ar_receivable_applications_all` table, which is the central table for storing information about the application of cash receipts in Oracle Receivables. The report also uses the `ar_receivable_apps_all_mrc_v` view to provide support for multiple reporting currencies.

### Parameters & Filtering
The report includes a wide range of parameters that allow you to customize the output to your specific needs. The key parameters include:
- **Reporting Level and Context:** These parameters allow you to run the report for a specific ledger or operating unit, or for all accessible ledgers or operating units.
- **Applied GL Date Range:** This parameter allows you to filter the report by the GL date of the receipt applications.
- **Customer Name and Account Number:** These parameters allow you to filter the report by a specific customer.
- **Receipt Method and Status:** These parameters allow you to filter the report by the receipt method and status.
- **Receipt Date Range:** This parameter allows you to filter the report by the date of the receipts.

### Performance & Optimization
The AR Applied Receipts Register is designed to be both efficient and flexible. It is optimized to use the standard indexes on the `ar_receivable_applications_all` table, which helps to ensure that the report runs quickly, even with large amounts of data. The use of the `ar_receivable_apps_all_mrc_v` view also ensures that the report can be run efficiently in multi-currency environments.

### FAQ
**Q: What is the difference between the "Applied GL Date" and the "Receipt Date"?**
A: The "Receipt Date" is the date on which the payment was received from the customer. The "Applied GL Date" is the date on which the receipt was applied to an invoice or other transaction in the general ledger.

**Q: Can I use this report to see the details of the invoices that a receipt was applied to?**
A: Yes, the report provides a detailed breakdown of each receipt application, including the invoice number, the amount applied, and the date of the application.

**Q: Can I use this report to see the unapplied and on-account portions of a receipt?**
A: This report focuses on applied receipts. To see unapplied and on-account amounts, you would typically use the AR Receipt Register or a similar report.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-applied-receipts)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-applied-receipts)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-applied-receipts)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-applied-receipts)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-applied-receipts)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-applied-receipts)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-applied-receipts)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
