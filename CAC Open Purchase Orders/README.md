---
layout: default
last_modified_at: 2026-10-16
title: 'CAC Open Purchase Orders | Oracle EBS SQL Report'
description: 'Report to show open purchase orders and related information. This report will convert any foreign currency purchases into the currency of the general…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Open, Purchase, Orders, mtl_supply, cst_cost_types, cst_item_costs'
permalink: /CAC%20Open%20Purchase%20Orders/
report_name: 'CAC Open Purchase Orders'
report_web_name: cac-open-purchase-orders
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Open Purchase Orders – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-open-purchase-orders/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to show open purchase orders and related information.  This report will convert any foreign currency purchases into the currency of the general ledger (defaulted from the inventory organization for this session).  Use the To and From Transaction Date parameters to create an average receipt cost and use the Comparison Cost Type parameter to show a comparison 
amounts from another cost type.

Parameters:
===========
Comparison Cost Type: enter the cost type for a comparison against the purchase order prices (optional).  Defaulted from your Costing Method.
Transaction Date From:  starting transaction date for averaging the purchase order receipts (mandatory).  Use these averages for comparing to the PO unit prices.
Transaction Date To:  ending transaction date for averaging the purchase order receipts (mandatory).  Use these averages for comparing to the PO unit prices.
Currency Conversion Date:  enter the currency conversion date to use for converting foreign currency purchases into the currency of the general ledger (mandatory).
Currency Conversion Type:  enter the currency conversion type to use for converting foreign currency purchases into the currency of hhe general ledger (mandatory).
Supplier Name:  specific vendor or supplier you wish to report (optional).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2020 - 2023 Douglas Volz Consulting, Inc. 
-- | All rights reserved. 
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this
-- | permission.
-- +=============================================================================+
-- |        
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  open_po_rept.sql
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     09 Sep 2020 Douglas Volz   Initial Coding based on Purchase Price 
-- |                                     variance report, xxx_ppv_lot_rept.sql
-- |  1.1     10 Sep 2020 Douglas Volz   Added inspection flag.
-- |  1.2     01 Dec 2020 Douglas Volz   Added variance and charge accounts
-- |  1.3     20 Dec 2020 Douglas Volz   Added promise date, Need By Date, project,
-- |                                     Expected Receipt Date, Target Price (PO List Price),
-- |                                     Customer Name and difference columns.
-- |                                     And added Minimum Cost Difference parameter.
-- |  1.4     03 Feb 2021 Douglas Volz   Merged OSP with stock purchase orders.
-- |  1.5     05 Feb 2021 Douglas Volz   Added PO averages and item cost information.
-- |  1.6     07 Jul 2022 Douglas Volz   Add multi-language item status.
-- |  1.7     28 Nov 2023 Andy Haack     Remove tabs, add org access controls, fix for G/L Daily Rates, outer joins. 
-- |  1.8     15 Dec 2023 Douglas Volz   Setting the comparison cost type as mandatory, to
-- |                                     prevent a multiple rows error for the comparison cost type.  
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Comparison Cost Type, Transaction Date From, Transaction Date To, Currency Conversion Date, Currency Conversion Type, Supplier Name, Category Set 1, Category Set 2, Category Set 3, Show SLA, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_supply](https://www.enginatics.com/library/?pg=1&find=mtl_supply&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [mtl_uom_conversions_view](https://www.enginatics.com/library/?pg=1&find=mtl_uom_conversions_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [hr_employees](https://www.enginatics.com/library/?pg=1&find=hr_employees&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [cst_resource_costs](https://www.enginatics.com/library/?pg=1&find=cst_resource_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders)

## Related Reports
[CAC Item List Price vs. Item Cost](/CAC%20Item%20List%20Price%20vs-%20Item%20Cost/ "CAC Item List Price vs. Item Cost Oracle EBS SQL Report"), [CAC Calculate Average Item Costs](/CAC%20Calculate%20Average%20Item%20Costs/ "CAC Calculate Average Item Costs Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [CAC PO Receipt History for Item Costing](/CAC%20PO%20Receipt%20History%20for%20Item%20Costing/ "CAC PO Receipt History for Item Costing Oracle EBS SQL Report"), [CAC Inventory to G/L Reconciliation (Restricted by Org Access)](/CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Restricted%20by%20Org%20Access%29/ "CAC Inventory to G/L Reconciliation (Restricted by Org Access) Oracle EBS SQL Report"), [CAC PO Receipt History for Actual Costing](/CAC%20PO%20Receipt%20History%20for%20Actual%20Costing/ "CAC PO Receipt History for Actual Costing Oracle EBS SQL Report"), [CAC Recost Cost of Goods Sold](/CAC%20Recost%20Cost%20of%20Goods%20Sold/ "CAC Recost Cost of Goods Sold Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [WIP Account Distribution](/WIP%20Account%20Distribution/ "WIP Account Distribution Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Open%20Purchase%20Orders/CAC%20Open%20Purchase%20Orders.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Open Purchase Orders 07-Jul-2022 170534.xlsx](https://www.enginatics.com/example/cac-open-purchase-orders/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders) |
| Blitz Report™ XML Import | [CAC_Open_Purchase_Orders.xml](https://www.enginatics.com/xml/cac-open-purchase-orders/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders) |
| SQL Source | [CAC Open Purchase Orders.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Open%20Purchase%20Orders/CAC%20Open%20Purchase%20Orders.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-open-purchase-orders/](https://www.enginatics.com/reports/cac-open-purchase-orders/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders) |

## Case Study & Technical Analysis: CAC Open Purchase Orders

### Executive Summary
The **CAC Open Purchase Orders** report is a forward-looking financial control tool. While most variance reports analyze what *has* happened (historical PPV), this report analyzes what *is about to* happen.
It lists all open Purchase Orders (POs) and compares the negotiated PO price against the current Standard Cost of the item. This allows Finance and Procurement teams to:
1.  **Forecast PPV:** Predict the Purchase Price Variance that will hit the P&L when these goods are received.
2.  **Audit Procurement Performance:** Identify significant deviations from standard cost before the liability is incurred.
3.  **Manage Currency Risk:** Simulate the impact of exchange rate fluctuations on open foreign currency orders.

### Business Challenge
In a standard costing environment, the difference between the PO Price and the Standard Cost is recorded as Purchase Price Variance (PPV) at the moment of receipt.
*   **The "Surprise" Factor:** Often, Finance only sees PPV after the month-end close. If a buyer negotiated a price 20% higher than standard, that variance is "locked in" once the receipt occurs.
*   **Currency Volatility:** For imported goods, the final cost depends on the exchange rate at the time of receipt. A PO cut 3 months ago might be profitable then but loss-making now due to currency shifts.
*   **OSP Blind Spots:** Outside Processing (OSP) orders often have complex pricing structures that are hard to compare against the standard resource rates.

### The Solution
This report acts as a "PPV Radar," scanning the horizon of open orders.
*   **Proactive Variance Calculation:** It calculates `(PO Price - Standard Cost) * Open Quantity` to show the *potential* variance.
*   **Currency Simulation:**
    *   It doesn't just use the exchange rate on the PO (which might be old).
    *   It allows the user to input a *current* `Currency Conversion Date` and `Type`. This re-values all open foreign currency POs at today's rates, giving a mark-to-market view of the liability.
*   **Unified View:** It merges standard material POs with OSP (Outside Processing) orders, providing a single view of all external manufacturing spend.

### Technical Architecture (High Level)
The query is built on the Purchasing (`PO`) schema but heavily enriched with Costing (`CST`) and Inventory (`MTL`) data.
*   **Core Join Structure:**
    *   `PO_HEADERS_ALL`, `PO_LINES_ALL`, `PO_LINE_LOCATIONS_ALL` (Shipments), `PO_DISTRIBUTIONS_ALL`.
    *   These are joined to `MTL_SYSTEM_ITEMS_VL` for item details and `AP_SUPPLIERS` for vendor info.
*   **Cost Comparison Logic:**
    *   It joins to `CST_ITEM_COSTS` (aliased as `cic`) based on the `Comparison Cost Type` parameter.
    *   For OSP items, it links the PO line to the `BOM_RESOURCES` to compare the PO service price against the standard resource rate.
*   **Currency Logic:**
    *   If `Match Option` is 'P' (Purchase Order), it uses the rate on the PO.
    *   Otherwise, it joins to `GL_DAILY_RATES` (`gdr`) using the user-supplied `Currency Conversion Date` to get the latest rate.
*   **Supply Visibility:** A subquery against `MTL_SUPPLY` fetches the `Expected Receipt Date`, which is often more accurate than the PO Promise Date as it reflects the latest shipping status.

### Parameters & Filtering
*   **Comparison Cost Type:** The standard to measure against (usually "Frozen").
*   **Currency Conversion Date/Type:** Critical for the "Mark-to-Market" analysis of foreign orders.
*   **Transaction Date From/To:** Used to calculate average receipt costs (if the report logic includes historical averaging, though the primary focus is open orders).
*   **Minimum Cost Difference:** A filter to hide "noise" (e.g., ignore variances less than $0.01).

### Performance & Optimization
*   **View Usage:** Uses `xxen_util.meaning` to decode lookups efficiently.
*   **Outer Joins:** Uses outer joins for Project (`PPA`) and OSP Resource (`CIC`) data to ensure that standard material POs are not dropped if they lack project or OSP details.

### FAQ
**Q: Why is the "Converted PO Unit Price" different from the price on the PO?**
A: If you entered a `Currency Conversion Date` for today, the report re-calculates the value of foreign POs using today's exchange rate. This shows you the cost *if you received it today*, which may differ from the rate when the PO was created.

**Q: Does this report show received items?**
A: No, it focuses on *Open* orders (where `Closed Code` is not 'CLOSED' or 'FINALLY CLOSED'). For received items, use the "Purchase Price Variance" report.

**Q: How does it handle OSP (Outside Processing)?**
A: For OSP items, the report looks at the "Resource" linked to the item. It compares the PO Price (service charge) against the Standard Rate of that Resource.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-open-purchase-orders)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
