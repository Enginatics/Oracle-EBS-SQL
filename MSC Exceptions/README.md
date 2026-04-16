---
layout: default
title: 'MSC Exceptions | Oracle EBS SQL Report'
description: 'ASCP: Export Planning Exceptions from the Planners Workbench. – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, MSC, Exceptions, msc_category_sets&a2m_dblink, msc_apps_instances&a2m_dblink, msc_plans&a2m_dblink'
permalink: /MSC%20Exceptions/
---

# MSC Exceptions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/msc-exceptions/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
ASCP: Export Planning Exceptions from the Planners Workbench.

## Report Parameters
Planning Instance, Plan, Organization, Category Set, Category, Item, Planner, Buyer, Exception Group, Exception Type, Due Date From, Due Date To, From Date From, From Date To, To Date From, To Date To, Show Item Descriptive Attributes

## Oracle EBS Tables Used
[msc_category_sets&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_category_sets&a2m_dblink), [msc_apps_instances&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_apps_instances&a2m_dblink), [msc_plans&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_plans&a2m_dblink), [msc_exception_details_v&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_exception_details_v&a2m_dblink), [msc_system_items&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_system_items&a2m_dblink), [msc_demands&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_demands&a2m_dblink)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[MSC Pegging Hierarchy 11i](/MSC%20Pegging%20Hierarchy%2011i/ "MSC Pegging Hierarchy 11i Oracle EBS SQL Report"), [MSC Pegging Hierarchy](/MSC%20Pegging%20Hierarchy/ "MSC Pegging Hierarchy Oracle EBS SQL Report"), [MSC Plan Orders](/MSC%20Plan%20Orders/ "MSC Plan Orders Oracle EBS SQL Report"), [MSC Vertical Plan](/MSC%20Vertical%20Plan/ "MSC Vertical Plan Oracle EBS SQL Report"), [MSC Horizontal Plan](/MSC%20Horizontal%20Plan/ "MSC Horizontal Plan Oracle EBS SQL Report"), [MSC Plan Order Upload](/MSC%20Plan%20Order%20Upload/ "MSC Plan Order Upload Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [MSC Exceptions - Dashboard 17-Jan-2023 234651.xlsm](https://www.enginatics.com/example/msc-exceptions/) |
| Blitz Report™ XML Import | [MSC_Exceptions.xml](https://www.enginatics.com/xml/msc-exceptions/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/msc-exceptions/](https://www.enginatics.com/reports/msc-exceptions/) |

## MSC Exceptions - Case Study & Technical Analysis

### Executive Summary
The **MSC Exceptions** report is the primary alerting mechanism for the Advanced Supply Chain Planning (ASCP) engine. It highlights critical issues in the supply chain plan that require planner intervention, such as late orders, resource overloads, or material shortages.

### Business Challenge
ASCP plans are complex and cover the entire supply chain. Planners cannot review every single order. They need to know:
-   **Criticality:** "Which customer orders are in danger of being late?"
-   **Capacity:** "Which manufacturing lines are overloaded next week?"
-   **Data Quality:** "Which items have invalid lead times or missing costs?"

### Solution
The **MSC Exceptions** report filters the plan results into actionable alerts.

**Key Features:**
-   **Exception Groups:** Categorizes exceptions (e.g., "Late Sales Orders", "Resource Overloaded", "Material Shortage").
-   **Drill-Down:** Provides the specific details (Item, Order, Date, Quantity) for each exception.
-   **Prioritization:** Allows filtering by Exception Type and Planner to focus on the most urgent issues.

### Technical Architecture
The report queries the exception tables in the ASCP schema (often on a separate planning server).

#### Key Tables and Views
-   **`MSC_EXCEPTION_DETAILS_V`**: The primary view for exception messages.
-   **`MSC_PLANS`**: Defines the plan being analyzed.
-   **`MSC_SYSTEM_ITEMS`**: Provides item details within the plan.
-   **`MSC_DEMANDS`**: Links exceptions to specific demand records.

#### Core Logic
1.  **Exception Generation:** During the ASCP run, the engine identifies violations of constraints (time, capacity, material).
2.  **Storage:** These violations are stored in the exception tables with a specific Exception Type ID.
3.  **Reporting:** The report retrieves these records, joined with the relevant entity (Item, Resource, Order) for context.

### Business Impact
-   **Proactive Management:** Enables planners to fix problems before they impact the customer.
-   **Resource Optimization:** Helps identify bottlenecks (overloaded resources) and excess capacity.
-   **Plan Quality:** Highlights data issues that are causing poor planning results.


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
