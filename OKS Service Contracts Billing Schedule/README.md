---
layout: default
title: 'OKS Service Contracts Billing Schedule | Oracle EBS SQL Report'
description: 'Service Contracts billing schedule with invoicing and accounting rules, and detailed to be billed period dates and amounts from the stream level elements…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, OKS, Service, Contracts, Billing, hr_all_organization_units_vl, okc_k_headers_all_b, okc_subclasses_v'
permalink: /OKS%20Service%20Contracts%20Billing%20Schedule/
---

# OKS Service Contracts Billing Schedule – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/oks-service-contracts-billing-schedule/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Service Contracts billing schedule with invoicing and accounting rules, and detailed to be billed period dates and amounts from the stream level elements table oks_level_elements.

Column date_competed is used to identify open or already billed records and date_to_interface is used by the service contracts billing program to identify the records to be billed at any given date.
For advance billing, date_to_interface is set to the beginning of the billing period and for arrears, it is set to the end. When creating new billing schedule record for past periods (that should have been billed already), date_to_interface is set to the current date.

An overview of oracle service contracts and other line types can be found here: <a href="https://www.enginatics.com/reports/okc-contract-lines-summary/" rel="nofollow" target="_blank">https://www.enginatics.com/reports/okc-contract-lines-summary/</a>

## Report Parameters
Operating Unit, Contract Number, Modifier, Contract Status, Exclude Contract Status, Interface Date From, Interface Date To, Show unbilled only, Level

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [okc_k_headers_all_b](https://www.enginatics.com/library/?pg=1&find=okc_k_headers_all_b), [okc_subclasses_v](https://www.enginatics.com/library/?pg=1&find=okc_subclasses_v), [okc_classes_v](https://www.enginatics.com/library/?pg=1&find=okc_classes_v), [okc_statuses_v](https://www.enginatics.com/library/?pg=1&find=okc_statuses_v), [okc_k_lines_b](https://www.enginatics.com/library/?pg=1&find=okc_k_lines_b), [oks_k_lines_b](https://www.enginatics.com/library/?pg=1&find=oks_k_lines_b), [okc_line_styles_b](https://www.enginatics.com/library/?pg=1&find=okc_line_styles_b), [oks_stream_levels_b](https://www.enginatics.com/library/?pg=1&find=oks_stream_levels_b), [oks_level_elements](https://www.enginatics.com/library/?pg=1&find=oks_level_elements), [ra_rules](https://www.enginatics.com/library/?pg=1&find=ra_rules), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[OKS Service Contracts Billing History](/OKS%20Service%20Contracts%20Billing%20History/ "OKS Service Contracts Billing History Oracle EBS SQL Report"), [OKC Contract Lines Summary](/OKC%20Contract%20Lines%20Summary/ "OKC Contract Lines Summary Oracle EBS SQL Report"), [AR Transactions and Lines 11i](/AR%20Transactions%20and%20Lines%2011i/ "AR Transactions and Lines 11i Oracle EBS SQL Report"), [OKL Termination Quotes](/OKL%20Termination%20Quotes/ "OKL Termination Quotes Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [OKS Service Contracts Billing Schedule 07-Jun-2020 014328.xlsx](https://www.enginatics.com/example/oks-service-contracts-billing-schedule/) |
| Blitz Report™ XML Import | [OKS_Service_Contracts_Billing_Schedule.xml](https://www.enginatics.com/xml/oks-service-contracts-billing-schedule/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/oks-service-contracts-billing-schedule/](https://www.enginatics.com/reports/oks-service-contracts-billing-schedule/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
