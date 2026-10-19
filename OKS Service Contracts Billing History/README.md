---
layout: default
last_modified_at: 2026-10-19
title: 'OKS Service Contracts Billing History | Oracle EBS SQL Report'
description: 'Service Contracts billing history with invoicing and accounting rules, bill action, billed period dates, amounts and counter reading details for usage…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Service Contracts, Enginatics, OKS, Service, Contracts, Billing, hr_all_organization_units_vl, okc_k_headers_all_b, okc_subclasses_v'
permalink: /OKS%20Service%20Contracts%20Billing%20History/
report_name: 'OKS Service Contracts Billing History'
report_web_name: oks-service-contracts-billing-history
module: 'Service Contracts'
module_url: /modules/service-contracts/
---

# OKS Service Contracts Billing History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/oks-service-contracts-billing-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history).
**Oracle EBS module:** [Service Contracts](/modules/service-contracts/ "Oracle EBS Service Contracts reports") · [all Service Contracts reports](/modules/service-contracts/)  

## Overview
Service Contracts billing history with invoicing and accounting rules, bill action, billed period dates, amounts and counter reading details for usage billing.
When running service contracts billing, there is always a full set of records created in the following billing history tables: 

oks_bill_cont_lines obcl
oks_bill_sub_lines obsl
oks_bill_sub_line_dtls obsld
oks_bill_transactions obt
oks_bill_txn_lines obtl

This set of records is complete down to subline level obsl/obsld, regardless if the billed contract line type has a subline or not.
For subscription lines (lse_id=46, lty_code='SUBSCRIPTION') without a subline, for example, both obcl and obsl point their cle_id to the same line in okc_k_lines_b instead of different line and subline.

Unique identifier for the billing entry is obtl.bill_instance_number, which links to receivables line rctla.interface_line_attribute3.
When driving queries from the OKS side, make sure to include a to_char() conversion for the numeric obtl.bill_instance_number, to enable index use on character type rctla.interface_line_attribute3.

The OKS billing history does not have a link to the originating billing schedule record in oks_level_elements (see <a href="https://www.enginatics.com/reports/oks-service-contracts-billing-schedule/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history" rel="nofollow" target="_blank">https://www.enginatics.com/reports/oks-service-contracts-billing-schedule/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history</a>)

An overview of oracle service contracts and other line types can be found here: <a href="https://www.enginatics.com/reports/okc-contract-lines-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history" rel="nofollow" target="_blank">https://www.enginatics.com/reports/okc-contract-lines-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history</a>

oks_billing_history_v

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Contract Number, Modifier, Contract Status, Exclude Contract Status, Billed From, Billed To, Bill Action

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history), [okc_k_headers_all_b](https://www.enginatics.com/library/?pg=1&find=okc_k_headers_all_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history), [okc_subclasses_v](https://www.enginatics.com/library/?pg=1&find=okc_subclasses_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history), [okc_classes_v](https://www.enginatics.com/library/?pg=1&find=okc_classes_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history), [okc_statuses_v](https://www.enginatics.com/library/?pg=1&find=okc_statuses_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history), [okc_k_lines_b](https://www.enginatics.com/library/?pg=1&find=okc_k_lines_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history), [oks_k_lines_b](https://www.enginatics.com/library/?pg=1&find=oks_k_lines_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history), [okc_line_styles_b](https://www.enginatics.com/library/?pg=1&find=okc_line_styles_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history), [ra_rules](https://www.enginatics.com/library/?pg=1&find=ra_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history), [oks_bill_cont_lines](https://www.enginatics.com/library/?pg=1&find=oks_bill_cont_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history), [oks_bill_sub_lines](https://www.enginatics.com/library/?pg=1&find=oks_bill_sub_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history), [oks_bill_sub_line_dtls](https://www.enginatics.com/library/?pg=1&find=oks_bill_sub_line_dtls&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history), [oks_bill_transactions](https://www.enginatics.com/library/?pg=1&find=oks_bill_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history), [oks_bill_txn_lines](https://www.enginatics.com/library/?pg=1&find=oks_bill_txn_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history), [ra_cust_trx_types_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history), [okc_subclasses_b](https://www.enginatics.com/library/?pg=1&find=okc_subclasses_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history)

## Related Reports
[OKS Service Contracts Billing Schedule](/OKS%20Service%20Contracts%20Billing%20Schedule/ "OKS Service Contracts Billing Schedule Oracle EBS SQL Report"), [AR Transactions and Lines 11i](/AR%20Transactions%20and%20Lines%2011i/ "AR Transactions and Lines 11i Oracle EBS SQL Report"), [OKS Service Contract Line Upload](/OKS%20Service%20Contract%20Line%20Upload/ "OKS Service Contract Line Upload Oracle EBS SQL Report"), [OKC Contract Lines Summary](/OKC%20Contract%20Lines%20Summary/ "OKC Contract Lines Summary Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [OKL Termination Quotes](/OKL%20Termination%20Quotes/ "OKL Termination Quotes Oracle EBS SQL Report"), [OKS Contract Termination Upload](/OKS%20Contract%20Termination%20Upload/ "OKS Contract Termination Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OKS%20Service%20Contracts%20Billing%20History/OKS%20Service%20Contracts%20Billing%20History.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [OKS Service Contracts Billing History 14-Oct-2020 080331.xlsx](https://www.enginatics.com/example/oks-service-contracts-billing-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history) |
| Blitz Report™ XML Import | [OKS_Service_Contracts_Billing_History.xml](https://www.enginatics.com/xml/oks-service-contracts-billing-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history) |
| SQL Source | [OKS Service Contracts Billing History.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OKS%20Service%20Contracts%20Billing%20History/OKS%20Service%20Contracts%20Billing%20History.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/oks-service-contracts-billing-history/](https://www.enginatics.com/reports/oks-service-contracts-billing-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history) |

## OKS Service Contracts Billing History - Case Study & Technical Analysis

### Executive Summary
The **OKS Service Contracts Billing History** report provides a detailed audit trail of all billing transactions generated by the Service Contracts module. It links the contract lines to the specific AR Invoices created, allowing for full reconciliation between the Service and Finance departments.

### Business Challenge
Discrepancies between what was promised (Contract) and what was billed (Invoice) are common sources of customer disputes.
-   **Reconciliation:** "The customer says we overbilled them for the 'Gold Support' line. Show me exactly what was sent to AR."
-   **Usage Billing:** "We bill based on copier usage. I need to see the meter readings that generated this month's invoice."
-   **Audit:** "Did we successfully bill all 500 active subscriptions for January?"

### Solution
The **OKS Service Contracts Billing History** report joins OKS billing tables with AR tables.

**Key Features:**
-   **Granularity:** Shows billing at the Subline level (e.g., specific serial number covered).
-   **AR Linkage:** Includes the AR Invoice Number and Transaction Date.
-   **Usage Details:** For usage-based contracts, includes the counter readings (Start Reading, End Reading).

### Technical Architecture
The report queries the OKS billing history tables and links them to AR.

#### Key Tables and Views
-   **`OKS_BILL_CONT_LINES`**: Billing header for the contract line.
-   **`OKS_BILL_TXN_LINES`**: The specific transaction lines sent to AR.
-   **`RA_CUSTOMER_TRX_ALL`**: The AR Invoice header.
-   **`RA_CUSTOMER_TRX_LINES_ALL`**: The AR Invoice lines.

#### Core Logic
1.  **History Retrieval:** Queries the `OKS_BILL_%` tables which store the history of the "Service Contracts Main Billing" concurrent program.
2.  **Linking:** Uses the `BILL_INSTANCE_NUMBER` (in OKS) to match with `INTERFACE_LINE_ATTRIBUTE3` (in AR) to find the corresponding invoice.
3.  **Detailing:** Joins to counter tables if the line type is Usage.

### Business Impact
-   **Revenue Assurance:** Verifies that all active contracts are being billed correctly.
-   **Dispute Resolution:** Provides the evidence needed to resolve billing inquiries quickly.
-   **Compliance:** Ensures that billing aligns with the accounting rules defined in the contract.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-history)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
