---
layout: default
title: 'AP Expenses | Oracle EBS SQL Report'
description: 'Detail AP expense report listing corresponding AP invoices with status, line details, expense type and expense justification. Including projects task…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Expenses, per_people_x, ap_invoice_payments_all, ap_checks_all'
permalink: /AP%20Expenses/
---

# AP Expenses – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-expenses/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Detail AP expense report listing corresponding AP invoices with status, line details, expense type and expense justification. Including projects task related expenses.

## Report Parameters
Ledger, Operating Unit, Expense Status, Report Submitted Date From, Report Submitted Date To, Employee Name, Expense Report Number, Auditor Name, Audit Reason, Audit Type, Source, Prompt, Show Lines, Show per diem details, Show DFF Attributes

## Oracle EBS Tables Used
[per_people_x](https://www.enginatics.com/library/?pg=1&find=per_people_x), [ap_invoice_payments_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_payments_all), [ap_checks_all](https://www.enginatics.com/library/?pg=1&find=ap_checks_all), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [ap_expense_report_headers_all](https://www.enginatics.com/library/?pg=1&find=ap_expense_report_headers_all), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [ap_aud_queues](https://www.enginatics.com/library/?pg=1&find=ap_aud_queues), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all), [ap_expense_report_lines_all](https://www.enginatics.com/library/?pg=1&find=ap_expense_report_lines_all), [ap_expense_report_params_all](https://www.enginatics.com/library/?pg=1&find=ap_expense_report_params_all), [&per_diem_table](https://www.enginatics.com/library/?pg=1&find=&per_diem_table), [gms_awards_all](https://www.enginatics.com/library/?pg=1&find=gms_awards_all)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AP Expenses 12-Sep-2025 212747.xlsx](https://www.enginatics.com/example/ap-expenses/) |
| Blitz Report™ XML Import | [AP_Expenses.xml](https://www.enginatics.com/xml/ap-expenses/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ap-expenses/](https://www.enginatics.com/reports/ap-expenses/) |

## Case Study & Technical Analysis: AP Expenses Report

### Executive Summary
The **AP Expenses Report** provides a comprehensive operational view of employee expense reports within Oracle Payables. It bridges the gap between expense submission, audit, and final payment, offering critical visibility into corporate spending. By linking expense reports directly to AP invoices and payments, this report enables finance teams to reconcile employee reimbursements, audit policy compliance, and track project-related costs in a single view.

### Business Challenge
Organizations often struggle with:
*   **Fragmented Visibility:** Expense data is often siloed from payment data, making it difficult to trace a submitted expense report to its final reimbursement check.
*   **Audit Blind Spots:** Identifying which expenses are pending audit, rejected, or approved requires navigating multiple Oracle forms.
*   **Project Cost Leakage:** Accurately associating travel and entertainment expenses with specific project tasks is often manual and error-prone.
*   **Compliance Risks:** Lack of detailed reporting on expense types and justifications can hide policy violations.

### The Solution
The **AP Expenses Report** solves these challenges by consolidating data from the expense report header, lines, and distributions with the downstream AP invoice and payment information.

*   **End-to-End Traceability:** Users can track an expense report from submission date through to the check number and payment date.
*   **Audit Efficiency:** The report exposes audit status, auditor names, and reasons, streamlining the internal audit process.
*   **Project Integration:** Includes project and task details, ensuring that billable expenses are correctly allocated.
*   **Detailed Analysis:** Provides line-level details including expense types, justifications, and per diem information for granular spend analysis.

### Technical Architecture (High Level)
This report employs a star-schema-like approach, centering on the expense report headers and lines while joining to financial and HR dimensions.

#### Primary Tables
*   `AP_EXPENSE_REPORT_HEADERS_ALL`: Stores the header information of the expense report (Employee, Date, Total).
*   `AP_EXPENSE_REPORT_LINES_ALL`: Contains the individual expense items (Amount, Type, Justification).
*   `AP_INVOICES_ALL`: Links the expense report to the generated Payables invoice.
*   `AP_INVOICE_PAYMENTS_ALL` & `AP_CHECKS_ALL`: Provides payment details (Check Number, Date).
*   `PER_PEOPLE_X`: Retrieves employee information.
*   `GMS_AWARDS_ALL`: Links to Grants/Projects for project-related expenses.

#### Logical Relationships
1.  **Expense to Invoice:** The report joins Expense Report Headers to AP Invoices to show the accounting status.
2.  **Invoice to Payment:** It further joins Invoices to Payments and Checks to confirm reimbursement.
3.  **HR Integration:** Employee IDs are resolved to names using the person tables.
4.  **Project Accounting:** If project details exist on the line, they are linked to the Grants/Projects tables for task-level reporting.

### Parameters & Filtering
The report offers flexible parameters to slice data for specific operational needs:
*   **Ledger & Operating Unit:** Filters data by financial entity for multi-org environments.
*   **Date Ranges (Submitted Date):** Essential for period-close reconciliation and trend analysis.
*   **Expense Status:** Allows filtering for specific states like 'Ready for Payment', 'Pending Audit', or 'Rejected'.
*   **Employee & Report Number:** Enables quick lookup of specific claims.
*   **Show Options:** Toggles for "Show Lines", "Show per diem details", and "Show DFF Attributes" allow users to choose between a high-level summary or a detailed audit extract.

### Performance & Optimization
*   **Direct Database Extraction:** The report queries underlying tables directly, bypassing the overhead of the XML Publisher engine for faster retrieval of large datasets.
*   **Selective Joins:** Joins to payment and project tables are likely outer joined or conditionally executed based on parameters to maintain performance when those details are not present.
*   **Indexed Columns:** Filtering on `REPORT_SUBMITTED_DATE` and `EXPENSE_REPORT_ID` leverages standard Oracle indexes for rapid query execution.

### FAQ
**Q: Can I see expenses that have been rejected?**
A: Yes, by using the "Expense Status" parameter or reviewing the status columns in the output, you can identify rejected reports and the reasons.

**Q: Does this report include credit card transactions?**
A: Yes, if the credit card transactions are imported into Oracle Internet Expenses and submitted on an expense report, they will appear here.

**Q: How do I see the project task associated with an expense?**
A: The report includes columns for Project and Task. Ensure the "Show Lines" parameter is enabled to see these details at the line level.


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
