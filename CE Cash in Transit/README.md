---
layout: default
title: 'CE Cash in Transit | Oracle EBS SQL Report'
description: 'Application: Cash Management Description: Cash in Transit Provides equivalent functionality to the following standard Oracle Forms/Reports - Cash in…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Cash, Transit, ce_bank_accounts, ce_bank_branches_v, ap_checks_all'
permalink: /CE%20Cash%20in%20Transit/
---

# CE Cash in Transit – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ce-cash-in-transit/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Application: Cash Management
Description: Cash in Transit

Provides equivalent functionality to the following standard Oracle Forms/Reports
- Cash in Transit

Applicable Templates:
- Pivot: Cash in Transit - Pivot: Bank Account Currency, Bank Account, In Transit Type, Operating Unit, Third Party (Supplier/Customer) with drill down to details
- Cash In Transit Detail - Detail Extract

Source: Cash in Transit (CEXCSHTR)
DB package: CE_CEXCSHTR_XMLP_PKG (required to initialize security)


## Report Parameters
Bank Name, Bank Branch, Bank Account Name, Bank Account Number, Transaction Type, Payroll Business Group, AP/AR Operating Unit, As Of Date

## Oracle EBS Tables Used
[ce_bank_accounts](https://www.enginatics.com/library/?pg=1&find=ce_bank_accounts), [ce_bank_branches_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_branches_v), [ap_checks_all](https://www.enginatics.com/library/?pg=1&find=ap_checks_all), [ce_bank_acct_uses_all](https://www.enginatics.com/library/?pg=1&find=ce_bank_acct_uses_all), [ce_security_profiles_gt](https://www.enginatics.com/library/?pg=1&find=ce_security_profiles_gt), [ce_system_parameters](https://www.enginatics.com/library/?pg=1&find=ce_system_parameters), [iby_payment_methods_vl](https://www.enginatics.com/library/?pg=1&find=iby_payment_methods_vl), [ap_payment_history_all](https://www.enginatics.com/library/?pg=1&find=ap_payment_history_all), [ar_receipt_methods](https://www.enginatics.com/library/?pg=1&find=ar_receipt_methods), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [ar_cash_receipts](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts), [ar_cash_receipt_history_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipt_history_all), [ce_999_interface_v](https://www.enginatics.com/library/?pg=1&find=ce_999_interface_v), [ce_bank_accts_gt_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_accts_gt_v), [ce_statement_recon_gt_v](https://www.enginatics.com/library/?pg=1&find=ce_statement_recon_gt_v), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books), [pay_ce_reconciled_payments](https://www.enginatics.com/library/?pg=1&find=pay_ce_reconciled_payments), [pay_pre_payments](https://www.enginatics.com/library/?pg=1&find=pay_pre_payments), [pay_assignment_actions](https://www.enginatics.com/library/?pg=1&find=pay_assignment_actions), [pay_payroll_actions](https://www.enginatics.com/library/?pg=1&find=pay_payroll_actions), [pay_org_payment_methods_f](https://www.enginatics.com/library/?pg=1&find=pay_org_payment_methods_f), [pay_payment_types](https://www.enginatics.com/library/?pg=1&find=pay_payment_types), [pay_action_interlocks](https://www.enginatics.com/library/?pg=1&find=pay_action_interlocks)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ce-cash-in-transit/) |
| Blitz Report™ XML Import | [CE_Cash_in_Transit.xml](https://www.enginatics.com/xml/ce-cash-in-transit/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ce-cash-in-transit/](https://www.enginatics.com/reports/ce-cash-in-transit/) |

## Executive Summary
The **CE Cash in Transit** report provides a detailed view of cash flows that have been recorded in the subledgers (AP/AR) but have not yet cleared the bank. This "float" is a critical component of liquidity management. The report allows Treasury Managers to see the pipeline of incoming receipts and outgoing payments, enabling more accurate cash positioning and forecasting.

## Business Challenge
Between the time a check is printed or a receipt is recorded and the time it actually clears the bank, the cash is "in transit."
*   **Liquidity Blind Spots**: Ignoring in-transit cash can lead to overdrafts (if outgoing payments clear faster than expected) or idle cash (if receipts are delayed).
*   **Reconciliation Delays**: Large volumes of aged in-transit items often indicate lost checks, failed transmissions, or reconciliation process breakdowns.
*   **Forecasting Accuracy**: To know how much cash will be available tomorrow, you must know what is currently in the banking pipeline.

## Solution
This report aggregates all uncleared transactions from AP, AR, and Payroll, presenting them by Bank Account and Transaction Type.

**Key Features:**
*   **Multi-Source Aggregation**: Combines data from Accounts Payable (Payments), Accounts Receivable (Receipts), and Payroll into a single view.
*   **Aging Analysis**: Helps identify old items that should have cleared by now (e.g., uncashed checks > 90 days).
*   **Drill-Down**: Provides details on the specific Third Party (Supplier/Customer) and transaction numbers.

## Architecture
The report queries the `CE_AVAILABLE_TRANSACTIONS_V` (or similar union views) which pulls data from `AP_CHECKS_ALL`, `AR_CASH_RECEIPTS`, and `PAY_PRE_PAYMENTS`.

**Key Tables:**
*   `AP_CHECKS_ALL`: Uncleared payments.
*   `AR_CASH_RECEIPTS`: Uncleared receipts.
*   `PAY_PRE_PAYMENTS`: Uncleared payroll payments.
*   `CE_BANK_ACCOUNTS`: The bank account associated with the transactions.

## Impact
*   **Cash Visibility**: Provides the "missing link" between book balance and bank balance.
*   **Risk Management**: Highlights potential fraud or operational issues (e.g., uncashed checks).
*   **Working Capital Optimization**: Allows for tighter management of cash buffers by understanding the exact timing of flows.


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
