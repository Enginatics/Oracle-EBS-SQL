---
layout: default
title: 'CE Cleared Transactions | Oracle EBS SQL Report'
description: 'Application: Cash Management Description: Transactions - Cleared Payment/Receipt Transactions Provides equivalent functionality to the following standard…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Cleared, Transactions, ap_checks_all, iby_payment_methods_vl, iby_payments_all'
permalink: /CE%20Cleared%20Transactions/
---

# CE Cleared Transactions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ce-cleared-transactions/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Application: Cash Management
Description: Transactions - Cleared Payment/Receipt Transactions

Provides equivalent functionality to the following standard Oracle Forms/Reports
- Cleared Transactions Report
  Applicable Templates:
  Pivot: Cleared Transactions Summary
  Pivot: Cleared Batches Summary

Source: Cleared Transactions Report (CEXCLEAR)
DB package: CE_CEXCLEAR_XMLP_PKG (required to initialize security)


## Report Parameters
Bank Name, Bank Branch, Bank Account Name, Bank Account Number, Transaction Type, Treasury Legal Entity, Payroll Business Group, AP/AR Operating Unit, Cleared Date From, Cleared Date To

## Oracle EBS Tables Used
[ap_checks_all](https://www.enginatics.com/library/?pg=1&find=ap_checks_all), [iby_payment_methods_vl](https://www.enginatics.com/library/?pg=1&find=iby_payment_methods_vl), [iby_payments_all](https://www.enginatics.com/library/?pg=1&find=iby_payments_all), [iby_pay_instructions_all](https://www.enginatics.com/library/?pg=1&find=iby_pay_instructions_all), [ce_bank_accts_gt_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_accts_gt_v), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [ce_bank_acct_uses_all](https://www.enginatics.com/library/?pg=1&find=ce_bank_acct_uses_all), [ce_security_profiles_gt](https://www.enginatics.com/library/?pg=1&find=ce_security_profiles_gt), [xle_entity_profiles](https://www.enginatics.com/library/?pg=1&find=xle_entity_profiles), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [ar_cash_receipts](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts), [ar_cash_receipt_history_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipt_history_all), [ar_batches_all](https://www.enginatics.com/library/?pg=1&find=ar_batches_all), [ce_lookups](https://www.enginatics.com/library/?pg=1&find=ce_lookups), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all), [ar_receipt_methods](https://www.enginatics.com/library/?pg=1&find=ar_receipt_methods), [ce_801_reconciled_v](https://www.enginatics.com/library/?pg=1&find=ce_801_reconciled_v), [pay_pre_payments](https://www.enginatics.com/library/?pg=1&find=pay_pre_payments), [pay_assignment_actions](https://www.enginatics.com/library/?pg=1&find=pay_assignment_actions), [pay_org_payment_methods_f](https://www.enginatics.com/library/?pg=1&find=pay_org_payment_methods_f), [ce_801_eft_reconciled_v](https://www.enginatics.com/library/?pg=1&find=ce_801_eft_reconciled_v), [ce_999_interface_v](https://www.enginatics.com/library/?pg=1&find=ce_999_interface_v), [ce_bank_branches_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_branches_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CE Cash in Transit](/CE%20Cash%20in%20Transit/ "CE Cash in Transit Oracle EBS SQL Report"), [CE Bank Statement and Reconciliation](/CE%20Bank%20Statement%20and%20Reconciliation/ "CE Bank Statement and Reconciliation Oracle EBS SQL Report"), [IBY Payment Process Request Details](/IBY%20Payment%20Process%20Request%20Details/ "IBY Payment Process Request Details Oracle EBS SQL Report"), [CE General Ledger Reconciliation](/CE%20General%20Ledger%20Reconciliation/ "CE General Ledger Reconciliation Oracle EBS SQL Report"), [AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ce-cleared-transactions/) |
| Blitz Report™ XML Import | [CE_Cleared_Transactions.xml](https://www.enginatics.com/xml/ce-cleared-transactions/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ce-cleared-transactions/](https://www.enginatics.com/reports/ce-cleared-transactions/) |

## Executive Summary
The **CE Cleared Transactions** report is a historical record of all payments and receipts that have successfully cleared the bank. It serves as the definitive proof of payment or receipt for audit and vendor inquiry purposes. By filtering on clearance dates, Treasury teams can analyze the actual timing of cash flows compared to their issuance dates, helping to refine float assumptions.

## Business Challenge
Once a transaction clears the bank, it moves from "In Transit" to "Cleared."
*   **Vendor Inquiries**: Suppliers often ask, "Has check #1234 cleared yet?" This report provides the answer.
*   **Float Analysis**: Understanding the average time it takes for a check to clear (e.g., 3 days vs. 7 days) is essential for accurate cash forecasting.
*   **Audit Evidence**: Auditors require a list of cleared transactions to verify the bank reconciliation.

## Solution
This report lists all transactions with a status of 'CLEARED' within a specified date range.

**Key Features:**
*   **Status Confirmation**: Only includes transactions that have been matched to a bank statement line.
*   **Float Calculation**: By comparing the Transaction Date to the Cleared Date, users can calculate the actual float days.
*   **Batch Summary**: Option to summarize by batch for high-volume environments.

## Architecture
The report queries the subledger tables (`AP_CHECKS_ALL`, `AR_CASH_RECEIPTS`) where the status is 'CLEARED' or 'RECONCILED'.

**Key Tables:**
*   `AP_CHECKS_ALL`: Cleared payments.
*   `AR_CASH_RECEIPTS`: Cleared receipts.
*   `CE_BANK_ACCOUNTS`: The bank account.
*   `CE_STATEMENT_LINES`: The bank statement line that cleared the transaction.

## Impact
*   **Customer Service**: Enables rapid response to vendor and customer payment status inquiries.
*   **Forecasting Refinement**: Provides the historical data needed to calculate accurate float times.
*   **Audit Support**: Generates the detailed transaction lists required for financial audits.


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
