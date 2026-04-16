---
layout: default
title: 'PN Generate Lease Details | Oracle EBS SQL Report'
description: 'Application: Property Manager Source: Generate Lease Details Report Short Name: PNGLDRXML DB package: XXENPN'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Generate, Lease, Details, pn_leases_all, pn_eqp_leases_all, pn_lease_details_all'
permalink: /PN%20Generate%20Lease%20Details/
---

# PN Generate Lease Details – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pn-generate-lease-details/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Application: Property Manager
Source: Generate Lease Details Report
Short Name: PNGLDR_XML
DB package: XXEN_PN

## Report Parameters
Operating Unit, As of Period, To Date, Lease Number, Lease Number From, Lease Number To, Lease Name, Lease Name From, Lease Name To, Lease Category, Include Period Summary, Include Payment Schedules, Include Amortization Schedules

## Oracle EBS Tables Used
[pn_leases_all](https://www.enginatics.com/library/?pg=1&find=pn_leases_all), [pn_eqp_leases_all](https://www.enginatics.com/library/?pg=1&find=pn_eqp_leases_all), [pn_lease_details_all](https://www.enginatics.com/library/?pg=1&find=pn_lease_details_all), [pn_pmt_item_pv_all](https://www.enginatics.com/library/?pg=1&find=pn_pmt_item_pv_all), [pn_payment_terms_all](https://www.enginatics.com/library/?pg=1&find=pn_payment_terms_all), [pn_options_all](https://www.enginatics.com/library/?pg=1&find=pn_options_all), [pn_leases_hist](https://www.enginatics.com/library/?pg=1&find=pn_leases_hist), [pn_lease_details_hist](https://www.enginatics.com/library/?pg=1&find=pn_lease_details_hist), [pn_eqp_lease_details_all](https://www.enginatics.com/library/?pg=1&find=pn_eqp_lease_details_all), [pn_system_setup_options](https://www.enginatics.com/library/?pg=1&find=pn_system_setup_options)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/pn-generate-lease-details/) |
| Blitz Report™ XML Import | [PN_Generate_Lease_Details.xml](https://www.enginatics.com/xml/pn-generate-lease-details/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/pn-generate-lease-details/](https://www.enginatics.com/reports/pn-generate-lease-details/) |

## Case Study & Technical Analysis: PN Generate Lease Details Report

### Executive Summary

The PN Generate Lease Details report is a comprehensive operational and financial reporting tool for Oracle Property Management. It provides a granular view of all aspects of a lease, including lease header information, detailed lease terms, payment schedules, and critical options. This report is indispensable for property administrators, accountants, and legal teams to understand the full specifics of lease agreements, audit contract compliance, and accurately manage the financial obligations and entitlements associated with a property portfolio.

### Business Challenge

Detailed lease contract management involves numerous complex attributes, clauses, and schedules. Obtaining a consolidated and flexible view of these details is a significant challenge for organizations with large property portfolios:

-   **Fragmented Contract Information:** Key lease details (e.g., lease type, start/end dates, tenant/landlord information, payment terms, options, historical changes) are often spread across various screens and tables in Oracle PN, making it difficult to get a complete picture.
-   **Difficult Audit and Compliance:** Auditing lease contracts for adherence to terms, verifying payment schedules, and ensuring compliance with regulatory requirements (e.g., proper accounting for lease options) is a time-consuming manual process prone to errors.
-   **Lack of Granular Financial Schedules:** While high-level financial reports exist, getting a detailed, itemized breakdown of future payment and billing schedules, including amortization calculations, is crucial for financial planning but often requires complex custom queries.
-   **Supporting Legal and Operational Reviews:** Legal teams need to quickly access all clauses and terms of a lease. Operational teams need clear schedules for managing payments and billing. Standard forms often don't provide this flexibility.

### The Solution

This report provides a flexible, detailed, and easily auditable solution for lease contract analysis, transforming how property management teams access and utilize lease information.

-   **Comprehensive Lease Overview:** It consolidates lease header details, key financial terms, associated payment schedules, and option clauses into a single, comprehensive report, offering an unparalleled view of the lease agreement.
-   **Date-Effective Historical Context:** The "As of Period" and "To Date" parameters enable users to view lease details as they existed at any specific point in time, which is crucial for historical analysis, dispute resolution, and audit purposes.
-   **Configurable Financial Detail:** Parameters like "Include Period Summary," "Include Payment Schedules," and "Include Amortization Schedules" allow users to dynamically control the level of financial detail presented, from high-level summaries to granular amortization calculations.
-   **Enhanced Audit Trail:** By providing a detailed breakdown of lease terms and historical data, the report serves as a robust audit trail, facilitating compliance checks and supporting lease renewal or renegotiation discussions.

### Technical Architecture (High Level)

The report queries core Oracle Property Management tables, including historical records, to assemble a complete picture of lease details and financial schedules.

-   **Primary Tables Involved:**
    -   `pn_leases_all` (the central table for lease header information).
    -   `pn_lease_details_all` (contains various detailed attributes of the lease).
    -   `pn_payment_terms_all` (stores the individual billing and payment terms).
    -   `pn_options_all` (for lease options and their details).
    -   `pn_leases_hist` and `pn_lease_details_hist` (for historical versions of lease data).
    -   `pn_pmt_item_pv_all` (a view often used for present value calculations or amortization schedules).
-   **Logical Relationships:** The report begins with the `pn_leases_all` table and then performs extensive joins to related tables and historical views to gather all available lease attributes, terms, options, and financial schedules. The `As of Period` and `To Date` parameters are crucial for selecting the correct date-effective records from these tables.

### Parameters & Filtering

The report offers a rich set of parameters for highly targeted and detailed lease analysis:

-   **Operating Unit:** Filters the report to a specific business unit.
-   **Date Range:** `As of Period` and `To Date` allow for precise historical or forward-looking analysis.
-   **Lease Identification:** `Lease Number`, `Lease Name` (and `From`/`To` ranges), and `Lease Category` enable granular selection of leases.
-   **Content Inclusion Flags:** Critical parameters like `Include Period Summary`, `Include Payment Schedules`, and `Include Amortization Schedules` dynamically control the detailed financial sections of the report output, allowing users to tailor the report to their specific analytical needs.

### Performance & Optimization

As a detailed report querying multiple tables, it is optimized by its specific filtering and modular data inclusion.

-   **Period-Driven Query Optimization:** The `As of Period` parameter is vital. It allows the database to efficiently retrieve the correct date-effective records and summarize financial data for the specified period, rather than processing all historical data.
-   **Modular Data Loading:** The "Include" parameters (e.g., `Include Amortization Schedules`) allow the report to conditionally execute more complex queries only when that specific detail is required, preventing unnecessary processing for simpler views.
-   **Indexed Lookups:** Filtering by `Lease Number` and `Lease Name` leverages standard Oracle indexes for quick data retrieval, especially for large lease portfolios.

### FAQ

**1. What is the difference between the 'Lease Analysis' and 'Lease Details' reports?**
   The 'Lease Analysis' report typically provides a summarized, higher-level financial overview of leases, often for portfolio assessment and strategic planning. The 'Lease Details' report, in contrast, offers a much more granular, attribute-level breakdown of the lease contract itself, including its specific terms, schedules, and options, suitable for operational and audit purposes.

**2. How does the report handle amendments or changes to a lease?**
   Oracle Property Management, through its date-effective tables (`_hist` tables), tracks changes to leases over time. This report, by using `As of Period` or `To Date` parameters, can show the lease details as they existed at a specific point in time, reflecting any amendments or changes that were effective by that date.

**3. Can this report help in preparing for lease renewal negotiations?**
   Absolutely. By providing a detailed view of current lease terms, payment schedules, and any defined options (e.g., renewal clauses), this report gives property managers all the necessary information to prepare for and conduct informed lease renewal or renegotiation discussions.


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
