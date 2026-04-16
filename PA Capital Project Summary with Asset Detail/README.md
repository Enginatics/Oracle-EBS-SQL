---
layout: default
title: 'PA Capital Project Summary with Asset Detail | Oracle EBS SQL Report'
description: 'Detail project report that shows the project asset details, and combined project level costs breakdown, along with the project assets details from the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Capital, Project, Summary, Asset, pa_projects_all, pa_project_statuses, pa_project_classes'
permalink: /PA%20Capital%20Project%20Summary%20with%20Asset%20Detail/
---

# PA Capital Project Summary with Asset Detail – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-capital-project-summary-with-asset-detail/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Detail project report that shows the project asset details, and combined project level costs breakdown, along with the project assets details from the Capital Summary

## Report Parameters
Project Type, Project Number, Operating Unit, Project Organization, Class Category, Class Code, Asset Trx Entered Period, Asset Date Effective Period, Asset Trx Entered Date From, Asset Trx Entered Date To, Asset Date Effective From, Asset Date Effective To, Include Unassigned Asset Lines, Unassigned Asset Line Type

## Oracle EBS Tables Used
[pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all), [pa_project_statuses](https://www.enginatics.com/library/?pg=1&find=pa_project_statuses), [pa_project_classes](https://www.enginatics.com/library/?pg=1&find=pa_project_classes), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [fa_locations_kfv](https://www.enginatics.com/library/?pg=1&find=fa_locations_kfv), [pa_project_assets_v](https://www.enginatics.com/library/?pg=1&find=pa_project_assets_v), [pa_capital_projects_v](https://www.enginatics.com/library/?pg=1&find=pa_capital_projects_v), [pa_retirement_costs_v](https://www.enginatics.com/library/?pg=1&find=pa_retirement_costs_v), [fa_transaction_headers](https://www.enginatics.com/library/?pg=1&find=fa_transaction_headers), [fa_deprn_periods](https://www.enginatics.com/library/?pg=1&find=fa_deprn_periods), [pa_project_asset_lines_v](https://www.enginatics.com/library/?pg=1&find=pa_project_asset_lines_v), [pa_asset_line_details_v](https://www.enginatics.com/library/?pg=1&find=pa_asset_line_details_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PA Capital Project Summary with Asset Detail 10-Jul-2020 142116.xlsx](https://www.enginatics.com/example/pa-capital-project-summary-with-asset-detail/) |
| Blitz Report™ XML Import | [PA_Capital_Project_Summary_with_Asset_Detail.xml](https://www.enginatics.com/xml/pa-capital-project-summary-with-asset-detail/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/pa-capital-project-summary-with-asset-detail/](https://www.enginatics.com/reports/pa-capital-project-summary-with-asset-detail/) |

## Case Study & Technical Analysis: PA Capital Project Summary with Asset Detail

### Executive Summary

The PA Capital Project Summary with Asset Detail report is a comprehensive financial and operational tool for managing the entire lifecycle of capital projects in Oracle E-Business Suite. It provides a unified view that links the costs accumulated in a capital project with the detailed fixed asset lines generated from those costs. This report is essential for project accountants, fixed asset managers, and financial controllers to monitor project spending, manage the capitalization process, and ensure accurate reconciliation between Oracle Projects (PA) and Oracle Fixed Assets (FA).

### Business Challenge

The process of accounting for capital projects—from accumulating construction-in-process (CIP) costs to placing the final assets in service—is one of the more complex processes in an ERP system. Key challenges include:

-   **Disconnected Modules:** Data for a single capital project resides in two different modules. The costs are captured and tracked in Oracle Projects, while the final, depreciating assets are managed in Oracle Fixed Assets. There is a lack of standard reports that effectively bridge this gap.
-   **Difficult Reconciliation:** Reconciling the CIP cost balance in Projects with the asset cost that has been interfaced to Fixed Assets is a critical but often difficult month-end task.
-   **Poor Visibility into Capitalization:** It's hard to get a clear, consolidated view of which project costs have been grouped into asset lines, which assets have been created, and what the status of the interface to the Fixed Assets module is.
-   **Managing Unassigned Costs:** Identifying project costs that have not yet been assigned to a capital asset can be a manual and error-prone process, risking that costs are not capitalized in a timely manner.

### The Solution

This report provides a complete, end-to-end view of a capital project's financial lifecycle, from cost inception to asset capitalization.

-   **Unified Project and Asset View:** It displays project-level cost breakdowns alongside a detailed listing of all the assets generated from that project, providing a single source of truth for all stakeholders.
-   **Streamlined Reconciliation:** By showing both the project costs and the created asset lines, the report greatly simplifies the process of reconciling the PA subledger to the FA subledger for capital projects.
-   **Clear Asset Line Auditing:** The report allows for a detailed review of all asset lines, both those that have been interfaced and those that are pending. The "Include Unassigned Asset Lines" parameter is a powerful feature for ensuring all eligible costs are capitalized.
-   **Improved Project Oversight:** It provides project managers and financial analysts with a clear picture of how project expenditures are being converted into tangible company assets, improving financial control and project governance.

### Technical Architecture (High Level)

The report is built on a query that joins data across the Oracle Projects and Oracle Fixed Assets schemas to provide its consolidated view.

-   **Primary Tables Involved:**
    -   `pa_projects_all` (for the basic project details).
    -   `pa_capital_projects_v` (a view summarizing capital project information).
    -   `pa_project_assets_v` (a view showing the assets defined within the project).
    -   `pa_project_asset_lines_v` (a view showing the detailed project cost distribution lines that have been assigned to each asset).
    -   `fa_transaction_headers` (to check the status of the asset interface transaction in Fixed Assets).
-   **Logical Relationships:** The report starts with a capital project and uses the project ID to find the defined assets in `pa_project_assets_v`. For each of these assets, it retrieves the detailed cost lines from `pa_project_asset_lines_v`. Finally, it checks for corresponding transactions in Fixed Assets to determine the capitalization and depreciation status.

### Parameters & Filtering

The report's parameters are designed to allow users to focus on specific projects or timeframes within the capital asset process:

-   **Project Selection:** Users can select data for a specific `Project Type` (e.g., Capital), `Project Number`, or `Project Organization`.
-   **Date and Period Filtering:** Multiple date and accounting period parameters (`Asset Trx Entered Period`, `Asset Date Effective Period`, etc.) allow for precise, time-based analysis of capitalization activity.
-   **Include Unassigned Asset Lines:** A critical parameter for financial controllers, this allows the report to also show any project costs that have been flagged for capitalization but have not yet been grouped and assigned to a specific asset.

### Performance & Optimization

The report queries across multiple modules and large data tables, and is optimized by its focused parameters.

-   **Project-Driven Query:** The query is most efficient when a specific `Project Number` is provided, as this is the primary key that drives the selection of all other data.
-   **Indexed Date Lookups:** The use of specific accounting periods and date ranges for filtering asset transactions allows the database to use its indexes on the transaction tables for efficient data retrieval.

### FAQ

**1. What does an "unassigned asset line" represent?**
   An unassigned asset line is a project cost (an expenditure item) that has been identified as capitalizable but has not yet been grouped together with other costs to form a specific, named asset (e.g., "Building A - Roof"). This report helps you find these "in-limbo" costs so they can be properly processed.

**2. How can I tell if an asset from this report is already depreciating in Fixed Assets?**
   The report typically includes status fields or information derived from the Fixed Assets module. Looking for a transaction status of 'Posted' in the FA transaction tables or seeing depreciation amounts would indicate that the asset is now active and depreciating in the FA subledger.

**3. What is the difference between the 'Asset Trx Entered Period' and the 'Asset Date Effective Period'?**
   The 'Asset Trx Entered Period' usually refers to the accounting period in which the capitalization transaction was entered into the system. The 'Asset Date Effective Period' (often called the Date Placed in Service) is the accounting period in which the asset becomes active and depreciation begins. These can be different.


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
