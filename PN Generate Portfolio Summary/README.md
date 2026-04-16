---
layout: default
title: 'PN Generate Portfolio Summary | Oracle EBS SQL Report'
description: 'Application: Property Manager Source: Generate Portfolio Summary Report Short Name: PNGPSRXML DB package: XXENPN'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Generate, Portfolio, Summary, pn_lease_reports_data_gtt, pn_amendment_report_gtt, pn_leases_all'
permalink: /PN%20Generate%20Portfolio%20Summary/
---

# PN Generate Portfolio Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pn-generate-portfolio-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Application: Property Manager
Source: Generate Portfolio Summary Report
Short Name: PNGPSR_XML
DB package: XXEN_PN

## Report Parameters
Operating Unit, As Of Period, End Date, Representation

## Oracle EBS Tables Used
[pn_lease_reports_data_gtt](https://www.enginatics.com/library/?pg=1&find=pn_lease_reports_data_gtt), [pn_amendment_report_gtt](https://www.enginatics.com/library/?pg=1&find=pn_amendment_report_gtt), [pn_leases_all](https://www.enginatics.com/library/?pg=1&find=pn_leases_all), [pn_lease_details_all](https://www.enginatics.com/library/?pg=1&find=pn_lease_details_all), [pn_eqp_leases_all](https://www.enginatics.com/library/?pg=1&find=pn_eqp_leases_all), [pn_eqp_lease_details_all](https://www.enginatics.com/library/?pg=1&find=pn_eqp_lease_details_all), [q_portfolio_summary](https://www.enginatics.com/library/?pg=1&find=q_portfolio_summary), [q_amendment_detail](https://www.enginatics.com/library/?pg=1&find=q_amendment_detail)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[PN Generate Portfolio Detail](/PN%20Generate%20Portfolio%20Detail/ "PN Generate Portfolio Detail Oracle EBS SQL Report"), [PN Generate Lease Details](/PN%20Generate%20Lease%20Details/ "PN Generate Lease Details Oracle EBS SQL Report"), [PN Generate Lease Analysis](/PN%20Generate%20Lease%20Analysis/ "PN Generate Lease Analysis Oracle EBS SQL Report"), [PN Schedule Approval Status Upload](/PN%20Schedule%20Approval%20Status%20Upload/ "PN Schedule Approval Status Upload Oracle EBS SQL Report"), [PN GL Reconciliation](/PN%20GL%20Reconciliation/ "PN GL Reconciliation Oracle EBS SQL Report"), [PN Billing/Payment Term Upload](/PN%20Billing-Payment%20Term%20Upload/ "PN Billing/Payment Term Upload Oracle EBS SQL Report"), [XLA Entity ID Mappings](/XLA%20Entity%20ID%20Mappings/ "XLA Entity ID Mappings Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/pn-generate-portfolio-summary/) |
| Blitz Report™ XML Import | [PN_Generate_Portfolio_Summary.xml](https://www.enginatics.com/xml/pn-generate-portfolio-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/pn-generate-portfolio-summary/](https://www.enginatics.com/reports/pn-generate-portfolio-summary/) |

## Case Study & Technical Analysis: PN Generate Portfolio Summary Report

### Executive Summary

The PN Generate Portfolio Summary report is a high-level strategic and financial reporting tool for Oracle Property Management (PN). It provides an aggregated overview of an entire lease portfolio, presenting key financial and operational metrics as of a specified period. This report is essential for executives, financial controllers, and portfolio managers to quickly assess the overall health, performance, and composition of their leased assets, supporting strategic planning, financial forecasting, and compliance initiatives.

### Business Challenge

For senior management and financial stakeholders, detailed, lease-by-lease reports can be overwhelming. What is needed is a clear, concise summary of the entire portfolio to support strategic decisions. Organizations often struggle with:

-   **Lack of Aggregated View:** Obtaining a single, high-level summary of the entire lease portfolio (e.g., total annual rent, total leased area, overall occupancy rates) is challenging with standard Oracle reports that focus on individual leases.
-   **Strategic Decision Support:** Without a consolidated summary, making informed strategic decisions about the overall portfolio (e.g., investment in new properties, divestment of underperforming assets, overall market exposure) is difficult.
-   **Efficient Performance Monitoring:** Executives need a quick snapshot to monitor key performance indicators (KPIs) of the portfolio without sifting through granular data. Manual compilation of such summaries is time-consuming and prone to errors.
-   **Financial Reporting and Compliance:** Providing aggregated data for financial statements (especially with new lease accounting standards like ASC 842 and IFRS 16) requires a reliable summary report that accurately reflects the portfolio's financial position.

### The Solution

This report offers a powerful, aggregated solution for comprehensive lease portfolio oversight, transforming complex data into executive-level insights.

-   **Consolidated Portfolio Metrics:** It provides key summarized financial and operational metrics for the entire lease portfolio, such as total revenue, total expenses, number of active leases, and potentially total leased area, all as of a specific reporting period.
-   **Date-Effective Snapshot:** The "As Of Period" parameter is crucial, allowing users to generate a precise snapshot of the portfolio's summary performance and composition for any given accounting period, vital for trend analysis and historical comparisons.
-   **Streamlined Executive Reporting:** The summarized nature of the report makes it ideal for executive dashboards, board presentations, and quick performance reviews, enabling faster and more informed strategic decision-making.
-   **Foundation for Compliance:** By providing aggregated financial data at the portfolio level, it serves as a valuable input for preparing financial disclosures related to lease accounting standards.

### Technical Architecture (High Level)

The report queries core Oracle Property Management tables and leverages Global Temporary Tables (GTTs) for efficient aggregation and summarization of portfolio data.

-   **Primary Tables/Views Involved:**
    -   `pn_leases_all` and `pn_lease_details_all` (to gather foundational lease data).
    -   `pn_eqp_leases_all` and `pn_eqp_lease_details_all` (corresponding tables for equipment leases).
    -   `pn_lease_reports_data_gtt` and `pn_amendment_report_gtt` (Global Temporary Tables used to stage and process intermediate detailed data before summarization, ensuring high performance).
    -   `q_portfolio_summary` (likely a complex view or internal query logic that performs the final aggregations).
-   **Logical Relationships:** The report first gathers detailed lease information (potentially into GTTs) from various PN tables for the specified period. It then performs aggregations (e.g., sums, counts) across these detailed records to produce the high-level summary metrics. The use of GTTs is critical here to efficiently handle the intermediate data processing for a large portfolio.

### Parameters & Filtering

The report offers focused parameters for strategic portfolio summaries:

-   **Operating Unit:** Filters the report to a specific business unit or organizational context.
-   **As Of Period:** The primary parameter for time-sensitive reporting, allowing users to select the accounting period for which they want to view the portfolio summary.
-   **End Date:** Often works in conjunction with `As Of Period` to define the exact end point of the reporting period.
-   **Representation:** (If applicable) Allows selection of the currency or format in which financial amounts are displayed (e.g., functional currency, reporting currency).

### Performance & Optimization

As an aggregated report designed for large portfolios, it utilizes specific optimizations for efficiency.

-   **Global Temporary Tables (GTTs):** The use of GTTs is a significant optimization. They enable the report to perform complex intermediate aggregations and calculations for the entire portfolio efficiently by storing temporary results without impacting transaction logs or permanent storage.
-   **Period-Driven Aggregation:** The `As Of Period` and `End Date` parameters are crucial for performance. They ensure that the report only aggregates data relevant to the specified timeframe, preventing unnecessary processing of historical or future data.
-   **Pre-aggregated Data (if applicable):** The `q_portfolio_summary` reference suggests the use of pre-aggregated data or highly optimized views for rapid summary calculations.

### FAQ

**1. What is the key difference between this 'Portfolio Summary' and the 'Portfolio Detail' reports?**
   This 'Portfolio Summary' report provides an aggregated, high-level overview of the entire lease portfolio (e.g., total revenue, total occupied area), ideal for executive reviews and strategic planning. The 'Portfolio Detail' report offers a granular, lease-by-lease breakdown of all individual lease attributes and terms, suited for operational management and in-depth auditing.

**2. Can this report be used to compare portfolio performance over different periods?**
   Yes, by running the report for multiple `As Of Period` values and exporting the results, users can compare key metrics of the portfolio (e.g., total revenue, occupancy rate) across different accounting periods to analyze trends and assess changes in portfolio performance.

**3. Does this report include both revenue and expense aspects of the portfolio?**
   Typically, a comprehensive portfolio summary like this would include both revenue-generating leases (e.g., tenant rents) and expense-incurring leases (e.g., landlord obligations for master leases or equipment). The report provides an overall financial health check of the entire lease portfolio.


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
