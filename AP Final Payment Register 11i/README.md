---
layout: default
title: 'AP Final Payment Register 11i | Oracle EBS SQL Report'
description: 'Imported from Concurrent Program Application: Payables Source: Final Payment Register Short Name: APXPBFPR'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Final, Payment, Register, 11i, ap_invoice_selection_criteria, ap_check_stocks, ap_bank_accounts'
permalink: /AP%20Final%20Payment%20Register%2011i/
---

# AP Final Payment Register 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-final-payment-register-11i/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from Concurrent Program
Application: Payables
Source: Final Payment Register
Short Name: APXPBFPR

## Report Parameters
Payment Batch, Payment Date From, Payment Date To

## Oracle EBS Tables Used
[ap_invoice_selection_criteria](https://www.enginatics.com/library/?pg=1&find=ap_invoice_selection_criteria), [ap_check_stocks](https://www.enginatics.com/library/?pg=1&find=ap_check_stocks), [ap_bank_accounts](https://www.enginatics.com/library/?pg=1&find=ap_bank_accounts), [ap_system_parameters](https://www.enginatics.com/library/?pg=1&find=ap_system_parameters), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [ap_checks](https://www.enginatics.com/library/?pg=1&find=ap_checks), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[AP Preliminary Payment Register 11i](/AP%20Preliminary%20Payment%20Register%2011i/ "AP Preliminary Payment Register 11i Oracle EBS SQL Report"), [IBY Payment Process Request Details](/IBY%20Payment%20Process%20Request%20Details/ "IBY Payment Process Request Details Oracle EBS SQL Report"), [AP Invoice Payments](/AP%20Invoice%20Payments/ "AP Invoice Payments Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AP Period Close Exceptions](/AP%20Period%20Close%20Exceptions/ "AP Period Close Exceptions Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [AP Invoices and Lines 11i](/AP%20Invoices%20and%20Lines%2011i/ "AP Invoices and Lines 11i Oracle EBS SQL Report"), [AR Receipt Register](/AR%20Receipt%20Register/ "AR Receipt Register Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AP Final Payment Register 11i 22-Aug-2024 060750.xlsx](https://www.enginatics.com/example/ap-final-payment-register-11i/) |
| Blitz Report™ XML Import | [AP_Final_Payment_Register_11i.xml](https://www.enginatics.com/xml/ap-final-payment-register-11i/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ap-final-payment-register-11i/](https://www.enginatics.com/reports/ap-final-payment-register-11i/) |

## Case Study & Technical Analysis: AP Final Payment Register 11i

### Executive Summary
The **AP Final Payment Register 11i** is a critical control report for Oracle Payables (specifically for the 11i architecture). It provides a definitive list of payments generated within a specific payment batch. This report is essential for finalizing payment runs, verifying check numbers, and ensuring that the payment process has completed successfully before checks are printed or EFT files are transmitted.

### Business Challenge
*   **Payment Verification:** Finance teams need a reliable way to verify that a payment batch has been processed correctly before releasing funds.
*   **Audit Trail:** Maintaining a hard copy or digital record of every payment run is a standard audit requirement.
*   **Check Stock Control:** Ensuring that the system-generated check numbers match the physical check stock is vital for fraud prevention.
*   **Reconciliation:** Discrepancies between the payment batch and the general ledger need to be identified immediately.

### The Solution
The **AP Final Payment Register 11i** offers a snapshot of the finalized payment batch.

*   **Batch Confirmation:** Lists all payments included in a specific batch, confirming they are ready for disbursement.
*   **Detailed Listing:** Provides vendor names, payment amounts, check numbers, and dates for every transaction in the batch.
*   **Currency Management:** Displays payment amounts in both the payment currency and the functional currency, handling exchange rates where applicable.
*   **Bank Account Association:** Clearly identifies the bank account and check stock used, aiding in cash management.

### Technical Architecture (High Level)
This report is based on the 11i Payables data model, focusing on payment batches and checks.

#### Primary Tables
*   `AP_INVOICE_SELECTION_CRITERIA`: Stores the criteria and status of the payment batch.
*   `AP_CHECKS`: Contains the details of the generated payments (checks).
*   `AP_BANK_ACCOUNTS`: Defines the bank account from which funds are drawn.
*   `AP_CHECK_STOCKS`: Links the payments to a specific stationery/check stock definition.
*   `GL_SETS_OF_BOOKS`: Provides ledger context (11i equivalent of Ledgers).
*   `GL_DAILY_CONVERSION_TYPES`: Used for currency conversion logic.

#### Logical Relationships
1.  **Batch to Check:** The report drives from the payment batch (`AP_INVOICE_SELECTION_CRITERIA`) to the checks generated (`AP_CHECKS`).
2.  **Bank Details:** It joins to `AP_BANK_ACCOUNTS` and `AP_CHECK_STOCKS` to validate the source of funds and document numbering.
3.  **System Parameters:** `AP_SYSTEM_PARAMETERS` is accessed for system-wide settings.

### Parameters & Filtering
*   **Payment Batch:** The primary filter, allowing the user to select a specific payment run to report on.
*   **Payment Date From/To:** Allows for reporting on payments within a specific date range, useful for daily or weekly reconciliation.

### Performance & Optimization
*   **Batch-Based Retrieval:** Querying by `CHECKRUN_NAME` (Payment Batch) is highly efficient as it targets a specific, limited set of records.
*   **Direct Table Access:** The SQL likely joins these tables directly, avoiding the overhead of calling multiple PL/SQL functions for standard data retrieval.

### FAQ
**Q: Is this report relevant for R12?**
A: This specific version is tailored for 11i. R12 uses a different payment engine (Oracle Payments/IBY), so a different report (like "Payment Process Request Status Report") would be used, although the underlying data concepts remain similar.

**Q: Can I use this to reprint checks?**
A: No, this is a register report for listing payments. Check printing is a separate process.

**Q: Does it show voided checks?**
A: It primarily shows the payments generated in the final run. Voided checks would typically be reported in a separate Void Payment Register, though their status might be reflected here depending on when the report is run relative to the voiding action.


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
