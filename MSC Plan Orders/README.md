---
layout: default
title: 'MSC Plan Orders | Oracle EBS SQL Report'
description: 'ASCP: Export Supply and Demand Orders from the Planners Workbench. – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, MSC, Plan, Orders, msc_safety_stocks&a2m_dblink, msc_trading_partner_sites&a2m_dblink, msc_trading_partners&a2m_dblink'
permalink: /MSC%20Plan%20Orders/
---

# MSC Plan Orders – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/msc-plan-orders/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
ASCP: Export Supply and Demand Orders from the Planners Workbench.


## Report Parameters
Planning Instance, Plan, Organization, Source Organiziation, Category Set, Category, Item, Supply/Demand, Planner, Buyer, Make/Buy, Order Type, Exclude Onhand Supply, Suggested Due Date From, Suggested Due Date To, Suggested Start Date From, Suggested Start Date To, Show Pegging, Show Item Descriptive Attributes

## Oracle EBS Tables Used
[msc_safety_stocks&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_safety_stocks&a2m_dblink), [msc_trading_partner_sites&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_trading_partner_sites&a2m_dblink), [msc_trading_partners&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_trading_partners&a2m_dblink), [msc_location_associations&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_location_associations&a2m_dblink)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/msc-plan-orders/) |
| Blitz Report™ XML Import | [MSC_Plan_Orders.xml](https://www.enginatics.com/xml/msc-plan-orders/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/msc-plan-orders/](https://www.enginatics.com/reports/msc-plan-orders/) |

## MSC Plan Orders - Case Study & Technical Analysis

### Executive Summary
The **MSC Plan Orders** report exports the detailed supply and demand transactions from the ASCP plan. It is the raw data feed for any detailed analysis of the plan's output, listing every Planned Order, Purchase Order, Work Order, and Sales Order considered by the engine.

### Business Challenge
Planners and analysts need access to the raw planning data for custom analysis.
-   **Custom Reporting:** "I need to build a pivot table showing the total planned spend by supplier for the next quarter."
-   **Data Validation:** "I need to check if the plan is respecting the 'Fixed Days Supply' modifier for these 20 items."
-   **Integration:** "We need to export the planned orders to a third-party logistics system."

### Solution
The **MSC Plan Orders** report provides a flat-file export of the plan data.

**Key Features:**
-   **Comprehensive:** Includes all transaction types (Supply and Demand).
-   **Detailed:** Includes dates (Suggested, Original), quantities, order numbers, and action messages.
-   **Filtering:** Allows filtering by Plan, Organization, Item, Planner, and Order Type.

### Technical Architecture
The report queries the core supply and demand tables in the ASCP schema.

#### Key Tables and Views
-   **`MSC_SUPPLIES`**: Stores all supply transactions (PO, WIP, Planned Orders, On-Hand).
-   **`MSC_DEMANDS`**: Stores all demand transactions (SO, Forecast, WIP Component Demand).
-   **`MSC_SYSTEM_ITEMS`**: Item attributes.
-   **`MSC_TRADING_PARTNERS`**: Organization and Supplier details.

#### Core Logic
1.  **Union:** Combines data from `MSC_SUPPLIES` and `MSC_DEMANDS` into a single list.
2.  **Joins:** Links to item and partner tables to resolve IDs to names.
3.  **Filtering:** Applies user-selected parameters to limit the output.

### Business Impact
-   **Flexibility:** Enables unlimited custom analysis using Excel or BI tools.
-   **Transparency:** Provides full visibility into the inputs and outputs of the planning engine.
-   **Collaboration:** Facilitates data sharing with external partners or internal departments.


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
