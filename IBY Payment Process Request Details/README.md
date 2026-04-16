---
layout: default
title: 'IBY Payment Process Request Details | Oracle EBS SQL Report'
description: 'Payment manager process request details including statuses, paid or rejected documents, amounts and rejection eror messages'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, IBY, Payment, Process, Request, iby_payments_all, gl_daily_conversion_types, ce_bank_accounts'
permalink: /IBY%20Payment%20Process%20Request%20Details/
---

# IBY Payment Process Request Details – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/iby-payment-process-request-details/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Payment manager process request details including statuses, paid or rejected documents, amounts and rejection eror messages

## Report Parameters
Operating Unit, Payment Process Request, Payment Process Request Status, Payment Status, Request Creation Date From, Request Creation Date To, Request Created By, Internal Bank Account, Trading Partner, Rejected or Failed Only, Exclude Removed Documents, Expand Error Details, Exchange Rate Type, Show Invoice Distributions

## Oracle EBS Tables Used
[iby_payments_all](https://www.enginatics.com/library/?pg=1&find=iby_payments_all), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [ce_bank_accounts](https://www.enginatics.com/library/?pg=1&find=ce_bank_accounts), [iby_validation_sets_vl](https://www.enginatics.com/library/?pg=1&find=iby_validation_sets_vl), [iby_pay_service_requests](https://www.enginatics.com/library/?pg=1&find=iby_pay_service_requests), [ap_inv_selection_criteria_all](https://www.enginatics.com/library/?pg=1&find=ap_inv_selection_criteria_all), [iby_docs_payable_all](https://www.enginatics.com/library/?pg=1&find=iby_docs_payable_all), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all), [ap_invoice_distributions_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_distributions_all), [ap_checks_all](https://www.enginatics.com/library/?pg=1&find=ap_checks_all), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [iby_ext_bank_accounts_v](https://www.enginatics.com/library/?pg=1&find=iby_ext_bank_accounts_v), [iby_ext_bank_accounts](https://www.enginatics.com/library/?pg=1&find=iby_ext_bank_accounts), [iby_payment_reasons_vl](https://www.enginatics.com/library/?pg=1&find=iby_payment_reasons_vl), [iby_payment_methods_vl](https://www.enginatics.com/library/?pg=1&find=iby_payment_methods_vl), [iby_acct_pmt_profiles_vl](https://www.enginatics.com/library/?pg=1&find=iby_acct_pmt_profiles_vl), [iby_formats_vl](https://www.enginatics.com/library/?pg=1&find=iby_formats_vl), [iby_delivery_channels_vl](https://www.enginatics.com/library/?pg=1&find=iby_delivery_channels_vl), [iby_trxn_types_vl](https://www.enginatics.com/library/?pg=1&find=iby_trxn_types_vl), [iby_pay_instructions_all](https://www.enginatics.com/library/?pg=1&find=iby_pay_instructions_all), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [xle_entity_profiles](https://www.enginatics.com/library/?pg=1&find=xle_entity_profiles), [iby_transaction_errors](https://www.enginatics.com/library/?pg=1&find=iby_transaction_errors), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [IBY Payment Process Request Details 25-Jan-2021 024851.xlsx](https://www.enginatics.com/example/iby-payment-process-request-details/) |
| Blitz Report™ XML Import | [IBY_Payment_Process_Request_Details.xml](https://www.enginatics.com/xml/iby-payment-process-request-details/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/iby-payment-process-request-details/](https://www.enginatics.com/reports/iby-payment-process-request-details/) |

## IBY Payment Process Request Details - Case Study & Technical Analysis

### Executive Summary
The **IBY Payment Process Request Details** report provides a deep dive into the "Payment Process Request" (PPR) in Oracle Payments (IBY). A PPR is the central object that groups invoices for payment. This report details the lifecycle of a payment batch: which invoices were selected, which were rejected (and why), the status of the payment file generation, and the final payment amounts. It is a critical tool for the Accounts Payable department to manage mass payment runs.

### Business Use Cases
*   **Payment Run Validation**: Before confirming a payment batch, the AP Manager reviews this report to ensure the correct invoices are included and the total cash outflow matches expectations.
*   **Rejection Analysis**: Identifies invoices that were pulled into the batch but rejected due to validation errors (e.g., "Missing Bank Account", "Vendor on Hold"), allowing users to fix the issues and re-run.
*   **Audit Trail**: Documents exactly which invoices were paid in a specific batch, providing a link between the bank withdrawal and the AP liability.
*   **Vendor Communication**: Helps answer vendor queries like "Was my invoice included in the last payment run?"

### Technical Analysis

#### Core Tables
*   `IBY_PAY_SERVICE_REQUESTS`: The header table for the Payment Process Request.
*   `IBY_DOCS_PAYABLE_ALL`: The link between the PPR and the underlying AP Invoices (`AP_INVOICES_ALL`).
*   `IBY_PAYMENTS_ALL`: The resulting payment records (Checks, Wires).
*   `IBY_TRANSACTION_ERRORS`: Stores validation error messages.
*   `AP_INV_SELECTION_CRITERIA_ALL`: Stores the criteria used to select invoices for the PPR.

#### Key Joins & Logic
*   **Selection to Payment**: The report traces the flow from `AP_INV_SELECTION_CRITERIA_ALL` -> `IBY_PAY_SERVICE_REQUESTS` -> `IBY_DOCS_PAYABLE_ALL` -> `IBY_PAYMENTS_ALL`.
*   **Status Logic**: It decodes the complex status columns of the PPR (e.g., "INSERTED", "SUBMITTED", "TERMINATED") and the individual documents.
*   **Error Handling**: Joins to `IBY_TRANSACTION_ERRORS` to display specific reasons why a document or payment failed validation.

#### Key Parameters
*   **Payment Process Request**: The specific batch name.
*   **Payment Process Request Status**: Filter by status (e.g., "Completed", "Terminated").
*   **Rejected or Failed Only**: A useful flag to focus solely on exceptions.


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
