---
layout: default
title: 'CAC Open Purchase Orders | Oracle EBS SQL Report'
description: 'Report to show open purchase orders and related information. This report will convert any foreign currency purchases into the currency of the general…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Nidec changes, CAC, Open, Purchase, Orders, mtl_supply, cst_cost_types, cst_item_costs'
permalink: /CAC%20Open%20Purchase%20Orders/
---

# CAC Open Purchase Orders – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-open-purchase-orders/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
Comparison Cost Type, Transaction Date From, Transaction Date To, Currency Conversion Date, Currency Conversion Type, Supplier Name, Category Set 1, Category Set 2, Category Set 3, Show SLA, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_supply](https://www.enginatics.com/library/?pg=1&find=mtl_supply), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all), [&sla_tables](https://www.enginatics.com/library/?pg=1&find=&sla_tables), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_uom_conversions_view](https://www.enginatics.com/library/?pg=1&find=mtl_uom_conversions_view), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all), [hr_employees](https://www.enginatics.com/library/?pg=1&find=hr_employees), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [cst_resource_costs](https://www.enginatics.com/library/?pg=1&find=cst_resource_costs), [select](https://www.enginatics.com/library/?pg=1&find=select), [inventory_item_id](https://www.enginatics.com/library/?pg=1&find=inventory_item_id), [sum](https://www.enginatics.com/library/?pg=1&find=sum)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Nidec changes](https://www.enginatics.com/library/?pg=1&category[]=Nidec%20changes)

## Related Reports
[CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC WIP Pending Cost Adjustment](/CAC%20WIP%20Pending%20Cost%20Adjustment/ "CAC WIP Pending Cost Adjustment Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [CAC ICP PII WIP Pending Cost Adjustment](/CAC%20ICP%20PII%20WIP%20Pending%20Cost%20Adjustment/ "CAC ICP PII WIP Pending Cost Adjustment Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [CAC WIP Material Usage Variance](/CAC%20WIP%20Material%20Usage%20Variance/ "CAC WIP Material Usage Variance Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [BOM Bill of Materials Upload](/BOM%20Bill%20of%20Materials%20Upload/ "BOM Bill of Materials Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Open Purchase Orders 07-Jul-2022 170534.xlsx](https://www.enginatics.com/example/cac-open-purchase-orders/) |
| Blitz Report™ XML Import | [CAC_Open_Purchase_Orders.xml](https://www.enginatics.com/xml/cac-open-purchase-orders/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-open-purchase-orders/](https://www.enginatics.com/reports/cac-open-purchase-orders/) |


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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
