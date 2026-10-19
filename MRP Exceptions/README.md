---
layout: default
last_modified_at: 2026-10-19
title: 'MRP Exceptions | Oracle EBS SQL Report'
description: 'Detail report for MRP Exception messages, including item, make or buy, default buyer, planner and exception message to use.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Master Scheduling/MRP, Enginatics, MRP, Exceptions, mrp_exception_details_v, mtl_system_items_vl, per_people_x'
permalink: /MRP%20Exceptions/
report_name: 'MRP Exceptions'
report_web_name: mrp-exceptions
module: 'Master Scheduling/MRP'
module_url: /modules/master-scheduling-mrp/
---

# MRP Exceptions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/mrp-exceptions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-exceptions) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-exceptions).
**Oracle EBS module:** [Master Scheduling/MRP](/modules/master-scheduling-mrp/ "Oracle EBS Master Scheduling/MRP reports") · [all Master Scheduling/MRP reports](/modules/master-scheduling-mrp/)  

## Overview
Detail report for MRP Exception messages, including item, make or buy, default buyer, planner and exception message to use.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-exceptions) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Plan, Exception, Planner Code, Buyer, Item

## Oracle EBS Tables Used
[mrp_exception_details_v](https://www.enginatics.com/library/?pg=1&find=mrp_exception_details_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-exceptions), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-exceptions), [per_people_x](https://www.enginatics.com/library/?pg=1&find=per_people_x&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-exceptions), [mtl_planners](https://www.enginatics.com/library/?pg=1&find=mtl_planners&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-exceptions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-exceptions)

## Related Reports
[MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [WIP Required Components](/WIP%20Required%20Components/ "WIP Required Components Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [MRP Horizontal Plan](/MRP%20Horizontal%20Plan/ "MRP Horizontal Plan Oracle EBS SQL Report"), [MRP End Assembly Pegging](/MRP%20End%20Assembly%20Pegging/ "MRP End Assembly Pegging Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report"), [WIP Discrete Job Shortage](/WIP%20Discrete%20Job%20Shortage/ "WIP Discrete Job Shortage Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/MRP%20Exceptions/MRP%20Exceptions.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-exceptions) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [MRP Exceptions 03-Aug-2018 212438.xlsx](https://www.enginatics.com/example/mrp-exceptions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-exceptions) |
| Blitz Report™ XML Import | [MRP_Exceptions.xml](https://www.enginatics.com/xml/mrp-exceptions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-exceptions) |
| SQL Source | [MRP Exceptions.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/MRP%20Exceptions/MRP%20Exceptions.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/mrp-exceptions/](https://www.enginatics.com/reports/mrp-exceptions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-exceptions) |

## MRP Exceptions - Case Study & Technical Analysis

### Executive Summary
The **MRP Exceptions** report is the primary "to-do list" for material planners. It filters the massive amount of data generated by an MRP run into actionable alerts. Instead of reviewing every item, planners focus only on items where the plan is "broken" or requires intervention, such as late orders, potential shortages, or excess inventory.

### Business Challenge
An MRP run might generate thousands of planned orders and recommendations. Planners cannot review them all. They need to know:
-   **Urgency:** "Which orders are already late and need immediate expediting?"
-   **Efficiency:** "Which orders can be cancelled because the demand went away?"
-   **Data Integrity:** "Which items have missing lead times or invalid planning parameters?"

### Solution
The **MRP Exceptions** report highlights these specific issues using standard exception messages.

**Key Features:**
-   **Action-Oriented:** Groups items by exception type (e.g., "Orders to be cancelled," "Orders with compression days").
-   **Prioritization:** Allows filtering by Planner Code, so each planner sees only their own items.
-   **Details:** Provides the specific context (e.g., "Order 123 is late by 5 days").

### Technical Architecture
The report queries the exception messages generated during the planning process.

#### Key Tables and Views
-   **`MRP_EXCEPTION_DETAILS_V`**: The primary view containing the exception messages linked to specific items and plans.
-   **`MTL_SYSTEM_ITEMS_VL`**: Provides item descriptions and planning attributes.
-   **`MTL_PLANNERS`**: Used to filter exceptions by the responsible planner.

#### Core Logic
1.  **Exception Generation:** During the MRP run, the engine identifies conditions that violate planning rules (e.g., supply date > need date).
2.  **Categorization:** These conditions are flagged with specific Exception Types (e.g., Type 10 = "Orders to be cancelled").
3.  **Reporting:** The report retrieves these records, joined with item and planner details for context.

### Business Impact
-   **Productivity:** Drastically reduces the time planners spend analyzing data, allowing them to focus on fixing problems.
-   **Responsiveness:** Ensures that critical shortages (potential stockouts) are identified and addressed immediately.
-   **Cost Reduction:** Helps identify excess inventory (orders to cancel) and avoid unnecessary expediting costs.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-exceptions)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-exceptions)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-exceptions)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-exceptions)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-exceptions)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-exceptions)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-exceptions)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
