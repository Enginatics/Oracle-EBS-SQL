---
layout: default
last_modified_at: 2026-10-26
title: 'CAC Intransit Value (Real-Time) | Oracle EBS SQL Report'
description: 'Report to show intransit values across all ledgers for current onhand balances and current costing method costs. This is a "real-time" report, showing the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Intransit, Value, (Real-Time), mtl_supply, rcv_shipment_headers, mtl_parameters'
permalink: /CAC%20Intransit%20Value%20%28Real-Time%29/
report_name: 'CAC Intransit Value (Real-Time)'
report_web_name: cac-intransit-value-real-time
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Intransit Value (Real-Time) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-intransit-value-real-time/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to show intransit values across all ledgers for current onhand balances and current costing method costs.  This is a "real-time" report, showing the quantities and values at the time you run this report.  (Used the cst_intransit_value_view to simplify the design.)

/* +=============================================================================+
-- |  Copyright 2009-20 Douglas Volz Consulting, Inc.                            |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged. No warranties, express or otherwise is included in this      |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_intransit_value_report.sql
-- |
-- |  Parameters:
-- |  p_org_code            -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit      -- Operating Unit you wish to report, leave blank for all
-- |                           operating units (optional) 
-- |  p_ledger              -- general ledger you wish to report, leave blank for all
-- |                           ledgers (optional)
-- |  p_category_set1       -- The first item category set to report, typically the
-- |                           Cost or Product Line Category Set
-- |  p_category_set2       -- The second item category set to report, typically the
-- |                           Inventory Category Set
-- | 
-- |  Description:
-- |  Report to show intransit values across all ledgers, for current onhand
-- |  balances and current costing method costs.  This is a "real-time" report,
-- |  showing the quantities and values at the time you run this report.
-- |  (Note:  Used the cst_intransit_value_view to simplify the design.)
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     18 Nov 2008 Douglas Volz   Initial Coding
-- |  1.1     10 Dec 2009 Douglas Volz   Modified for Celgene
-- |  1.2     04 Jan 2010 Douglas Volz   Added intransit value accounts
-- |  1.3     03 Mar 2010 Douglas Volz   Set the company account number based on
-- |                                     the item's cost of goods sold account
-- |  1.4     04 Mar 2010 Douglas Volz   Screen out invalid Intransit balances from
-- |                                     Dec 2009 transactions for Ledger CHE_EUR_PL.
-- |                                     These intransit balances were written-off
-- |                                     in the G/L in December 2009.  Was not able
-- |                                     to get these entries fixed in Oracle.
-- |  1.10    23 Apr 2020 Douglas Volz   Changed to multi-language views for the item
-- |                                     master, item categories and operating units.
-- |  1.11    23 Aug 2020 Douglas Volz   Modified to get intransit_owning_org_id directly
-- |                                     from mtl_supply; if you change the shipping 
-- |                                     network FOB Point and you can no longer get
-- |                                     the FOB Point from cst_intransit_value_view.
-- |  1.12    27 Nov 2024 Eric Clegg. Added Minimum Absolute Intransit Quantity parameter
-- |  1.13    23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger, Minimum Absolute Intransit Qty

## Oracle EBS Tables Used
[mtl_supply](https://www.enginatics.com/library/?pg=1&find=mtl_supply&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time), [mtl_interorg_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_interorg_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time)

## Related Reports
[CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment](/CAC%20Inventory%20Pending%20Cost%20Adjustment/ "CAC Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [CAC ICP PII vs. Item Costs](/CAC%20ICP%20PII%20vs-%20Item%20Costs/ "CAC ICP PII vs. Item Costs Oracle EBS SQL Report"), [PO Internal Requisitions and Sales Orders](/PO%20Internal%20Requisitions%20and%20Sales%20Orders/ "PO Internal Requisitions and Sales Orders Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC PO Price vs. Costing Method Comparison](/CAC%20PO%20Price%20vs-%20Costing%20Method%20Comparison/ "CAC PO Price vs. Costing Method Comparison Oracle EBS SQL Report"), [CAC Open Purchase Orders](/CAC%20Open%20Purchase%20Orders/ "CAC Open Purchase Orders Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Intransit%20Value%20%28Real-Time%29/CAC%20Intransit%20Value%20%28Real-Time%29.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Intransit Value (Real-Time) 23-Jun-2022 160746.xlsx](https://www.enginatics.com/example/cac-intransit-value-real-time/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time) |
| Blitz Report™ XML Import | [CAC_Intransit_Value_Real_Time.xml](https://www.enginatics.com/xml/cac-intransit-value-real-time/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time) |
| SQL Source | [CAC Intransit Value (Real-Time).sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Intransit%20Value%20%28Real-Time%29/CAC%20Intransit%20Value%20%28Real-Time%29.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-intransit-value-real-time/](https://www.enginatics.com/reports/cac-intransit-value-real-time/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time) |

## Case Study & Technical Analysis: CAC Intransit Value (Real-Time)

### Executive Summary
The **CAC Intransit Value (Real-Time)** report is a critical inventory management tool that provides a snapshot of the value of goods currently in transit between inventory organizations. Unlike period-end reports, this report offers "real-time" visibility, enabling logistics and finance teams to understand their immediate financial exposure and stock availability within the supply chain network.

### Business Challenge
In complex supply chains, a significant amount of inventory can be "on the water" or "on the road" at any given time.
*   **Financial Blind Spots:** Organizations often struggle to get an accurate, up-to-the-minute valuation of this floating inventory.
*   **Stockout Risks:** Without knowing what is in transit, planners may over-order or face unexpected stockouts.
*   **Period-End Surprises:** Waiting for month-end close processes to see intransit values can lead to surprises in financial reporting.
*   **FOB Confusion:** Determining ownership (and thus financial liability) based on FOB points (Shipment vs. Receipt) is often manual and error-prone.

### The Solution
The **CAC Intransit Value (Real-Time)** report solves these problems by querying the current state of supply and shipment tables.
*   **Real-Time Valuation:** Calculates the value of intransit stock based on current quantities and current costs, providing an immediate financial picture.
*   **Global Visibility:** Spans across all ledgers and operating units, offering a consolidated view for the entire enterprise.
*   **Ownership Logic:** Correctly handles FOB logic to determine which organization "owns" the inventory and should report it on their balance sheet.
*   **Simplified Design:** Leverages standard Oracle views (like `CST_INTRANSIT_VALUE_VIEW` logic) to ensure consistency with standard Oracle costing.

### Technical Architecture (High Level)
The report is built to extract data from the receiving and supply subsystems of Oracle Inventory.

**Primary Tables Involved:**
*   `RCV_SHIPMENT_HEADERS` / `RCV_SHIPMENT_LINES`: Stores details of the shipments that are currently active.
*   `MTL_SUPPLY`: The central table for tracking supply availability, including intransit stock.
*   `MTL_SYSTEM_ITEMS_VL`: Provides item definitions and attributes.
*   `CST_ITEM_COSTS`: Used to retrieve the current cost of items to calculate valuation.
*   `MTL_INTERORG_PARAMETERS`: Defines the shipping network rules, including FOB points and transfer types.

**Logical Relationships:**
*   **Supply to Shipment:** The report links `MTL_SUPPLY` records (where `supply_type_code` indicates intransit) to `RCV_SHIPMENT_LINES` to get specific shipment details.
*   **Cost Application:** It applies the current item cost from `CST_ITEM_COSTS` to the quantity derived from the supply/shipment tables.
*   **Ownership Determination:** Logic checks the FOB point defined in the shipping network (`MTL_INTERORG_PARAMETERS`) or the shipment itself to assign the value to the correct owning organization.

### Parameters & Filtering
*   **Category Sets:** Allows filtering by item categories to focus on specific segments of inventory (e.g., Raw Materials vs. Finished Goods).
*   **Item Number:** Enables tracking of specific high-value items.
*   **Organization Context:** Parameters for `Organization Code`, `Operating Unit`, and `Ledger` allow for scoping the report from a single warehouse to the entire enterprise.
*   **Minimum Absolute Intransit Qty:** A useful filter to exclude negligible or "dust" quantities, focusing the report on material variances.

### Performance & Optimization
*   **View Utilization:** By basing logic on or similar to `CST_INTRANSIT_VALUE_VIEW`, the report leverages Oracle's pre-optimized logic for intransit calculations.
*   **Current State Query:** As a real-time report, it queries current balance tables rather than aggregating millions of historical transaction records, making it generally faster than retrospective period-end reports.
*   **Efficient Filtering:** Parameters are applied early in the query execution to limit the dataset to relevant organizations or items.

### FAQ
**Q: How does this differ from the Period-End Intransit Value report?**
A: This report shows the *current* status at the moment of execution. The Period-End report reconstructs the value as of a specific past date, which is required for reconciliation but more computationally intensive.

**Q: Does it handle both Discrete and OPM inventory?**
A: The description suggests it is designed for standard discrete inventory costing. OPM (Process Manufacturing) often has separate valuation logic, though the principles of intransit tracking are similar.

**Q: What determines if inventory is "Intransit"?**
A: Inventory is considered intransit if it has been shipped from the source organization but not yet received (delivered) at the destination, and the shipment transaction is complete.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-intransit-value-real-time)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
