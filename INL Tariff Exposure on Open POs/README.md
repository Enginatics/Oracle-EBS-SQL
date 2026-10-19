---
layout: default
last_modified_at: 2026-10-19
title: 'INL Tariff Exposure on Open POs | Oracle EBS SQL Report'
description: 'Open quantity of approved PO shipments enabled for Landed Cost Management, with simulated and historical duty, to project the tariff cost of goods not…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Oracle Landed Cost Management, Enginatics, R12 only, INL, Tariff, Exposure, Open, mtl_category_sets_vl, mtl_item_categories, mtl_categories_kfv'
permalink: /INL%20Tariff%20Exposure%20on%20Open%20POs/
report_name: 'INL Tariff Exposure on Open POs'
report_web_name: inl-tariff-exposure-on-open-pos
module: 'Oracle Landed Cost Management'
module_url: /modules/oracle-landed-cost-management/
---

# INL Tariff Exposure on Open POs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inl-tariff-exposure-on-open-pos/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos).
**Oracle EBS module:** [Oracle Landed Cost Management](/modules/oracle-landed-cost-management/ "Oracle EBS Oracle Landed Cost Management reports") · [all Oracle Landed Cost Management reports](/modules/oracle-landed-cost-management/)  

## Overview
Open quantity of approved PO shipments enabled for Landed Cost Management, with simulated and historical duty, to project the tariff cost of goods not received yet.

Simulated Duty comes from the purchase order's latest landed cost simulation, scaled to the open quantity. Historical Duty Rate is the duty to item value ratio of the shipments of the same item, organization and country of origin since History Date From. Projected Duty is the simulated duty, else the open value at the historical rate.

Additional Tariff Percent applies a what-if tariff to the open value, for example a newly announced rate for one country of origin. Amounts are in functional currency at the PO exchange rate.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Organization Code, Supplier, PO Number, Item, Country of Origin, Duty Charge Type, Tariff Code Category Set, Tariff Code, History Date From, Additional Tariff Percent

## Oracle EBS Tables Used
[mtl_category_sets_vl](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos), [inl_charge_lines](https://www.enginatics.com/library/?pg=1&find=inl_charge_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos), [inl_simulations](https://www.enginatics.com/library/?pg=1&find=inl_simulations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos), [inl_ship_headers_all](https://www.enginatics.com/library/?pg=1&find=inl_ship_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos), [inl_ship_lines_all](https://www.enginatics.com/library/?pg=1&find=inl_ship_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos), [inl_allocations](https://www.enginatics.com/library/?pg=1&find=inl_allocations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos), [pon_cost_factors_vl](https://www.enginatics.com/library/?pg=1&find=pon_cost_factors_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos), [rcv_shipment_lines](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos)

## Related Reports
[INL Duty and Tariff Analysis](/INL%20Duty%20and%20Tariff%20Analysis/ "INL Duty and Tariff Analysis Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report"), [PO Purchase Price Variance](/PO%20Purchase%20Price%20Variance/ "PO Purchase Price Variance Oracle EBS SQL Report"), [CAC Calculate Average Item Costs](/CAC%20Calculate%20Average%20Item%20Costs/ "CAC Calculate Average Item Costs Oracle EBS SQL Report"), [PO Invoice Price Variance](/PO%20Invoice%20Price%20Variance/ "PO Invoice Price Variance Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [PO Purchase Requisitions with PO Details](/PO%20Purchase%20Requisitions%20with%20PO%20Details/ "PO Purchase Requisitions with PO Details Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INL%20Tariff%20Exposure%20on%20Open%20POs/INL%20Tariff%20Exposure%20on%20Open%20POs.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INL Tariff Exposure on Open POs 10-Oct-2026 151355.xlsx](https://www.enginatics.com/example/inl-tariff-exposure-on-open-pos/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos) |
| Blitz Report™ XML Import | [INL_Tariff_Exposure_on_Open_POs.xml](https://www.enginatics.com/xml/inl-tariff-exposure-on-open-pos/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos) |
| SQL Source | [INL Tariff Exposure on Open POs.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INL%20Tariff%20Exposure%20on%20Open%20POs/INL%20Tariff%20Exposure%20on%20Open%20POs.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inl-tariff-exposure-on-open-pos/](https://www.enginatics.com/reports/inl-tariff-exposure-on-open-pos/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos) |

## Case Study & Technical Analysis: INL Tariff Exposure on Open POs

### Executive Summary
This report estimates the tariff cost of goods that are on approved purchase orders but not yet received. For each open purchase order shipment enabled for Landed Cost Management, it shows the open quantity and value, the duty from the latest landed cost simulation, and a projected duty based on the historical duty rate of the same item from the same country of origin. It also applies an optional what-if tariff percentage. Procurement and trade compliance teams use it to see the duty that will land with open orders, especially when a new tariff rate is announced for one country of origin. The report runs in Excel through Blitz Report.

### Business Challenge
*   **Unplanned duty cost:** Duty on goods still in transit is often unknown until receipt, which hides the true landed cost of open orders.
*   **Sourcing decisions:** Buyers need to compare the landed cost of suppliers in different countries of origin before placing or changing orders.
*   **Tariff changes:** A newly announced rate must be tested against the open book before it takes effect.
*   **Simulation coverage:** Some orders have a landed cost simulation and others have none, and the two must be treated consistently.

### The Solution
*   **Simulated duty first:** Where a latest landed cost simulation exists, its duty per unit is scaled to the open quantity.
*   **Historical fallback:** Where no simulation exists, the open value is multiplied by the historical duty rate of the same item, organization and country of origin.
*   **Projected duty:** The projected duty is the simulated duty if present, otherwise the historical estimate.
*   **What-if tariff:** The Additional Tariff Percent is applied to the open value, so a new rate can be tested for each country of origin.
*   **Projected landed cost:** The open value, projected duty, additional tariff and other simulated charges are summed into one landed cost figure in functional currency.

### Technical Architecture (High Level)
#### Primary Tables
*   `PO_HEADERS_ALL`, `PO_LINES_ALL` and `PO_LINE_LOCATIONS_ALL`: the approved purchase order, its lines and its shipments, with open quantity, price and country of origin.
*   `INL_SIMULATIONS`: the landed cost simulation for a purchase order line, with its creation date.
*   `INL_CHARGE_LINES`: the duty and other charge lines of a simulation or shipment.
*   `INL_SHIP_HEADERS_ALL`, `INL_SHIP_LINES_ALL` and `INL_ALLOCATIONS`: the shipments and allocations that give the historical duty to item value ratio.
*   `RCV_SHIPMENT_LINES`: the receipt lines that give the country of origin of received shipments.
*   `MTL_SYSTEM_ITEMS_VL`: the item and its description.
*   `MTL_CATEGORY_SETS_VL`, `MTL_ITEM_CATEGORIES` and `MTL_CATEGORIES_KFV`: the tariff code category set and its category for each item.
*   `AP_SUPPLIERS`, `FND_TERRITORIES_VL`, `MTL_PARAMETERS`, `ORG_ORGANIZATION_DEFINITIONS` and `GL_LEDGERS`: the supplier, country names, organization and currency.

#### Logical Relationships
1. `PO_HEADERS_ALL` joins to `PO_LINES_ALL` on purchase order header id, and `PO_LINES_ALL` to `PO_LINE_LOCATIONS_ALL` on purchase order line id.
2. The simulated duty is an inline view on the line location id, drawn from the simulations, the simulated charges and the allocations of each shipment line.
3. The historical duty rate is an inline view on organization, item and country of origin, computed from shipments that have the same item and country and a history date from the report parameter.
4. The tariff code is the category from the selected tariff category set that is assigned to the item in the ship-to organization. Where several categories match, the query takes the maximum concatenated value.
5. The inner query is wrapped in two outer levels that compute the projected duty, the additional tariff and the projected landed cost.

### Parameters & Filtering
*   **Operating Unit and Organization Code:** restrict the purchase orders to one operating unit and ship-to organization.
*   **Supplier and PO Number:** narrow the orders to one supplier or one purchase order.
*   **Item and Country of Origin:** narrow the lines to one item or one country of origin.
*   **Duty Charge Type:** identifies the charge type treated as duty in the simulation and history.
*   **Tariff Code Category Set and Tariff Code:** select the category set holding tariff codes and one tariff code.
*   **History Date From:** sets the start date of the shipments used for the historical duty rate.
*   **Additional Tariff Percent:** the what-if rate applied to the open value.

### Performance & Optimization
*   The ship-to organization is restricted by the organization access view, so the simulation and history views only read organizations the responsibility can access.
*   Open quantity is filtered to a positive value, and only approved, enabled, non-cancelled shipments are read.

### FAQ
**Q: Which duty figure is used when a purchase order has a simulation?**
A: The simulated duty per unit from the latest simulation, scaled to the open quantity, is used as the projected duty.

**Q: How is the historical duty rate calculated?**
A: It is the duty divided by the item value of shipments with the same item, organization and country of origin, since the History Date From.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-tariff-exposure-on-open-pos)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
