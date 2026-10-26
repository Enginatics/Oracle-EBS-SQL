---
layout: default
last_modified_at: 2026-10-26
title: 'OKS Service Contracts Billing Schedule | Oracle EBS SQL Report'
description: 'Service Contracts billing schedule with invoicing and accounting rules, and detailed to be billed period dates and amounts from the stream level elements…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Service Contracts, Enginatics, OKS, Service, Contracts, Billing, hr_all_organization_units_vl, okc_k_headers_all_b, okc_subclasses_v'
permalink: /OKS%20Service%20Contracts%20Billing%20Schedule/
report_name: 'OKS Service Contracts Billing Schedule'
report_web_name: oks-service-contracts-billing-schedule
module: 'Service Contracts'
module_url: /modules/service-contracts/
---

# OKS Service Contracts Billing Schedule – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/oks-service-contracts-billing-schedule/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule).
**Oracle EBS module:** [Service Contracts](/modules/service-contracts/ "Oracle EBS Service Contracts reports") · [all Service Contracts reports](/modules/service-contracts/)  

## Overview
Service Contracts billing schedule with invoicing and accounting rules, and detailed to be billed period dates and amounts from the stream level elements table oks_level_elements.

Column date_competed is used to identify open or already billed records and date_to_interface is used by the service contracts billing program to identify the records to be billed at any given date.
For advance billing, date_to_interface is set to the beginning of the billing period and for arrears, it is set to the end. When creating new billing schedule record for past periods (that should have been billed already), date_to_interface is set to the current date.

An overview of oracle service contracts and other line types can be found here: <a href="https://www.enginatics.com/reports/okc-contract-lines-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule" rel="nofollow" target="_blank">https://www.enginatics.com/reports/okc-contract-lines-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule</a>

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Contract Number, Modifier, Contract Status, Exclude Contract Status, Interface Date From, Interface Date To, Show unbilled only, Level

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule), [okc_k_headers_all_b](https://www.enginatics.com/library/?pg=1&find=okc_k_headers_all_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule), [okc_subclasses_v](https://www.enginatics.com/library/?pg=1&find=okc_subclasses_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule), [okc_classes_v](https://www.enginatics.com/library/?pg=1&find=okc_classes_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule), [okc_statuses_v](https://www.enginatics.com/library/?pg=1&find=okc_statuses_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule), [okc_k_lines_b](https://www.enginatics.com/library/?pg=1&find=okc_k_lines_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule), [oks_k_lines_b](https://www.enginatics.com/library/?pg=1&find=oks_k_lines_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule), [okc_line_styles_b](https://www.enginatics.com/library/?pg=1&find=okc_line_styles_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule), [oks_stream_levels_b](https://www.enginatics.com/library/?pg=1&find=oks_stream_levels_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule), [oks_level_elements](https://www.enginatics.com/library/?pg=1&find=oks_level_elements&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule), [ra_rules](https://www.enginatics.com/library/?pg=1&find=ra_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule)

## Related Reports
[OKS Service Contracts Billing History](/OKS%20Service%20Contracts%20Billing%20History/ "OKS Service Contracts Billing History Oracle EBS SQL Report"), [OKC Contract Lines Summary](/OKC%20Contract%20Lines%20Summary/ "OKC Contract Lines Summary Oracle EBS SQL Report"), [OKS Service Contract Line Upload](/OKS%20Service%20Contract%20Line%20Upload/ "OKS Service Contract Line Upload Oracle EBS SQL Report"), [AR Transactions and Lines 11i](/AR%20Transactions%20and%20Lines%2011i/ "AR Transactions and Lines 11i Oracle EBS SQL Report"), [OKL Termination Quotes](/OKL%20Termination%20Quotes/ "OKL Termination Quotes Oracle EBS SQL Report"), [OKS Contract Termination Upload](/OKS%20Contract%20Termination%20Upload/ "OKS Contract Termination Upload Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OKS%20Service%20Contracts%20Billing%20Schedule/OKS%20Service%20Contracts%20Billing%20Schedule.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [OKS Service Contracts Billing Schedule 07-Jun-2020 014328.xlsx](https://www.enginatics.com/example/oks-service-contracts-billing-schedule/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule) |
| Blitz Report™ XML Import | [OKS_Service_Contracts_Billing_Schedule.xml](https://www.enginatics.com/xml/oks-service-contracts-billing-schedule/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule) |
| SQL Source | [OKS Service Contracts Billing Schedule.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OKS%20Service%20Contracts%20Billing%20Schedule/OKS%20Service%20Contracts%20Billing%20Schedule.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/oks-service-contracts-billing-schedule/](https://www.enginatics.com/reports/oks-service-contracts-billing-schedule/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule) |

## OKS Service Contracts Billing Schedule - Case Study & Technical Analysis

### Executive Summary
The **OKS Service Contracts Billing Schedule** report looks *forward* (and backward) at the billing schedule defined for a contract. Unlike the "Billing History" report which shows what *was* billed, this report shows what *is scheduled* to be billed. It is the primary tool for forecasting future service revenue.

### Business Challenge
Finance needs to know future cash flow from service contracts.
-   **Forecasting:** "What is our projected billing for the 'Maintenance' category next quarter?"
-   **Validation:** "We just booked a 3-year contract. Did the system generate the correct quarterly billing schedule?"
-   **Unbilled Revenue:** "Which periods have passed but haven't been billed yet?"

### Solution
The **OKS Service Contracts Billing Schedule** report exposes the `OKS_LEVEL_ELEMENTS` table.

**Key Features:**
-   **Schedule Visibility:** Lists every future billing event (Date, Amount) for the life of the contract.
-   **Status:** Shows whether a scheduled event has been "Interfaced" (billed) or is still "Open".
-   **Rules:** Displays the Invoicing Rule (e.g., Advance/Arrears) and Accounting Rule.

### Technical Architecture
The report queries the stream level elements in OKS.

#### Key Tables and Views
-   **`OKS_LEVEL_ELEMENTS`**: The core table storing the individual billing installments.
-   **`OKS_STREAM_LEVELS_B`**: Defines the billing frequency and rules.
-   **`OKS_K_LINES_B`**: The contract line details.

#### Core Logic
1.  **Schedule Generation:** When a contract is authorized, OKS generates the billing schedule in `OKS_LEVEL_ELEMENTS`.
2.  **Reporting:** The report queries this table.
3.  **Status Check:** It checks the `DATE_COMPLETED` column to determine if a specific installment has been processed.

### Business Impact
-   **Cash Flow Management:** Provides accurate data for cash flow forecasting.
-   **Operational Control:** Helps identify "stuck" billing schedules that are not being picked up by the billing program.
-   **Customer Transparency:** Allows providing customers with a schedule of future payments.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=oks-service-contracts-billing-schedule)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
