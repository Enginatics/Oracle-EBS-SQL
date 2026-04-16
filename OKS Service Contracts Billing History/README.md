---
layout: default
title: 'OKS Service Contracts Billing History | Oracle EBS SQL Report'
description: 'Service Contracts billing history with invoicing and accounting rules, bill action, billed period dates, amounts and counter reading details for usage…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, OKS, Service, Contracts, Billing, hr_all_organization_units_vl, okc_k_headers_all_b, okc_subclasses_v'
permalink: /OKS%20Service%20Contracts%20Billing%20History/
---

# OKS Service Contracts Billing History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/oks-service-contracts-billing-history/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

The OKS billing history does not have a link to the originating billing schedule record in oks_level_elements (see <a href="https://www.enginatics.com/reports/oks-service-contracts-billing-schedule/" rel="nofollow" target="_blank">https://www.enginatics.com/reports/oks-service-contracts-billing-schedule/</a>)

An overview of oracle service contracts and other line types can be found here: <a href="https://www.enginatics.com/reports/okc-contract-lines-summary/" rel="nofollow" target="_blank">https://www.enginatics.com/reports/okc-contract-lines-summary/</a>

oks_billing_history_v

## Report Parameters
Operating Unit, Contract Number, Modifier, Contract Status, Exclude Contract Status, Billed From, Billed To, Bill Action

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [okc_k_headers_all_b](https://www.enginatics.com/library/?pg=1&find=okc_k_headers_all_b), [okc_subclasses_v](https://www.enginatics.com/library/?pg=1&find=okc_subclasses_v), [okc_classes_v](https://www.enginatics.com/library/?pg=1&find=okc_classes_v), [okc_statuses_v](https://www.enginatics.com/library/?pg=1&find=okc_statuses_v), [okc_k_lines_b](https://www.enginatics.com/library/?pg=1&find=okc_k_lines_b), [oks_k_lines_b](https://www.enginatics.com/library/?pg=1&find=oks_k_lines_b), [okc_line_styles_b](https://www.enginatics.com/library/?pg=1&find=okc_line_styles_b), [ra_rules](https://www.enginatics.com/library/?pg=1&find=ra_rules), [oks_bill_cont_lines](https://www.enginatics.com/library/?pg=1&find=oks_bill_cont_lines), [oks_bill_sub_lines](https://www.enginatics.com/library/?pg=1&find=oks_bill_sub_lines), [oks_bill_sub_line_dtls](https://www.enginatics.com/library/?pg=1&find=oks_bill_sub_line_dtls), [&counter_tbls](https://www.enginatics.com/library/?pg=1&find=&counter_tbls), [oks_bill_txn_lines](https://www.enginatics.com/library/?pg=1&find=oks_bill_txn_lines), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all), [ra_cust_trx_types_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types_all), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual), [okc_subclasses_b](https://www.enginatics.com/library/?pg=1&find=okc_subclasses_b)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[OKS Service Contracts Billing Schedule](/OKS%20Service%20Contracts%20Billing%20Schedule/ "OKS Service Contracts Billing Schedule Oracle EBS SQL Report"), [AR Transactions and Lines 11i](/AR%20Transactions%20and%20Lines%2011i/ "AR Transactions and Lines 11i Oracle EBS SQL Report"), [OKC Contract Lines Summary](/OKC%20Contract%20Lines%20Summary/ "OKC Contract Lines Summary Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [OKL Termination Quotes](/OKL%20Termination%20Quotes/ "OKL Termination Quotes Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [OKS Service Contracts Billing History 14-Oct-2020 080331.xlsx](https://www.enginatics.com/example/oks-service-contracts-billing-history/) |
| Blitz Report™ XML Import | [OKS_Service_Contracts_Billing_History.xml](https://www.enginatics.com/xml/oks-service-contracts-billing-history/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/oks-service-contracts-billing-history/](https://www.enginatics.com/reports/oks-service-contracts-billing-history/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
