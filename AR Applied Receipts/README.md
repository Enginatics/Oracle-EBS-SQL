---
layout: default
title: 'AR Applied Receipts | Oracle EBS SQL Report'
description: 'Application: Receivables Description: Receivables Applied Receipts Register Provided Templates: Default: Detail - Detail Listing with no Pivot…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Applied, Receipts, ar_receivable_apps_all_mrc_v, ar_receivable_applications_all, &lp_table_list'
permalink: /AR%20Applied%20Receipts/
---

# AR Applied Receipts – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-applied-receipts/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
Reporting Level, Reporting Context, Balancing Segment Low, Balancing Segment High, Accounting Period, Applied GL Date From, Applied GL Date To, Entered Currency, Customer Name, Customer Name Low, Customer Name High, Customer Account Number, Customer Account Num Low, Customer Account Num High, Receipt Method, Receipt Status, Batch Name Low, Batch Name High, Receipt Date From, Receipt Date To, Deposit Date From, Deposit Date To, Apply Date From, Apply Date To, Receipt Last Updated From, Receipt Last Updated To, Receipt Number Low, Receipt Number High, Document Sequence Name, Document Number Low, Document Number High, Transaction Number Low, Transaction Number High, Transaction Type Low, Transaction Type High

## Oracle EBS Tables Used
[ar_receivable_apps_all_mrc_v](https://www.enginatics.com/library/?pg=1&find=ar_receivable_apps_all_mrc_v), [ar_receivable_applications_all](https://www.enginatics.com/library/?pg=1&find=ar_receivable_applications_all), [&lp_table_list](https://www.enginatics.com/library/?pg=1&find=&lp_table_list), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[AR Receipt Register](/AR%20Receipt%20Register/ "AR Receipt Register Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AR Applied Receipts - Pivot Summary by Customer Name 01-Dec-2023 081511.xlsx](https://www.enginatics.com/example/ar-applied-receipts/) |
| Blitz Report™ XML Import | [AR_Applied_Receipts.xml](https://www.enginatics.com/xml/ar-applied-receipts/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-applied-receipts/](https://www.enginatics.com/reports/ar-applied-receipts/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
