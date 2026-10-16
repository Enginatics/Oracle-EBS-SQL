---
layout: default
last_modified_at: 2026-10-16
title: 'INL Landed Unit Cost Trend | Oracle EBS SQL Report'
description: 'Unit landed cost per item over its landed cost shipments, broken down into item cost, charges and taxes, with the change against the item''s previous…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Oracle Landed Cost Management, Enginatics, R12 only, INL, Landed, Unit, Cost, fnd_territories_vl, inl_ship_headers_all, inl_allocations'
permalink: /INL%20Landed%20Unit%20Cost%20Trend/
report_name: 'INL Landed Unit Cost Trend'
report_web_name: inl-landed-unit-cost-trend
module: 'Oracle Landed Cost Management'
module_url: /modules/oracle-landed-cost-management/
---

# INL Landed Unit Cost Trend – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inl-landed-unit-cost-trend/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend).
**Oracle EBS module:** [Oracle Landed Cost Management](/modules/oracle-landed-cost-management/ "Oracle EBS Oracle Landed Cost Management reports") · [all Oracle Landed Cost Management reports](/modules/oracle-landed-cost-management/)  

## Overview
Unit landed cost per item over its landed cost shipments, broken down into item cost, charges and taxes, with the change against the item's previous shipment in the same organization.

Unit amounts are the current landed cost allocations in functional currency divided by the shipment line's primary quantity, Estimated Unit Landed Cost the first calculation. The previous shipment is taken from the shipments within the parameter selection.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Organization Code, Shipment Date From, Shipment Date To, Supplier, Item, Country of Origin

## Oracle EBS Tables Used
[fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend), [inl_ship_headers_all](https://www.enginatics.com/library/?pg=1&find=inl_ship_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend), [inl_allocations](https://www.enginatics.com/library/?pg=1&find=inl_allocations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend), [inl_ship_lines_all](https://www.enginatics.com/library/?pg=1&find=inl_ship_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend), [inl_ship_line_groups](https://www.enginatics.com/library/?pg=1&find=inl_ship_line_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend), [rcv_shipment_lines](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend)


## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INL%20Landed%20Unit%20Cost%20Trend/INL%20Landed%20Unit%20Cost%20Trend.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INL Landed Unit Cost Trend 10-Oct-2026 151355.xlsx](https://www.enginatics.com/example/inl-landed-unit-cost-trend/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend) |
| Blitz Report™ XML Import | [INL_Landed_Unit_Cost_Trend.xml](https://www.enginatics.com/xml/inl-landed-unit-cost-trend/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend) |
| SQL Source | [INL Landed Unit Cost Trend.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INL%20Landed%20Unit%20Cost%20Trend/INL%20Landed%20Unit%20Cost%20Trend.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inl-landed-unit-cost-trend/](https://www.enginatics.com/reports/inl-landed-unit-cost-trend/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend) |

## Case Study & Technical Analysis: INL Landed Unit Cost Trend

### Executive Summary
The INL Landed Unit Cost Trend report shows the unit landed cost of each item across its landed cost shipments in Oracle Landed Cost Management. For each shipment line it splits the unit cost into item cost, charges and taxes, and compares the current landed cost with the item's previous shipment in the same organization. Cost accountants and procurement analysts use it to see how freight, duty and other landed charges move the true cost of an item over time, and to judge the effect of a supplier or country of origin on total acquisition cost. The report runs in Excel through Blitz Report.

### Business Challenge
*   **True acquisition cost:** The purchase price of an item does not show the cost of getting it into stock, because freight, duties and taxes are allocated to the shipment after receipt.
*   **Cost movement between shipments:** Inventory valuation depends on how landed cost changes from one shipment to the next, and those changes must be measured per item.
*   **Estimate versus current cost:** Landed cost is first estimated and later re-calculated when charges are finalized, so the difference must be visible.
*   **Sourcing decisions:** Procurement needs to compare the landed uplift of suppliers and countries of origin for the same item.

### The Solution
*   **Allocation roll-up:** Landed cost allocations are summed by shipment line for the estimated adjustment and for the current adjustment, separated into item, charge and tax components.
*   **Unit conversion:** Each component is divided by the shipment line's primary quantity to give unit amounts in functional currency.
*   **Previous shipment comparison:** A `LAG` over shipments of the same item and organization gives the previous unit landed cost, and the change is shown in amount and percentage.
*   **Uplift measure:** The landed cost uplift percentage shows the charges and taxes as a share of the item cost.

### Technical Architecture (High Level)
#### Primary Tables
*   `INL_SHIP_HEADERS_ALL`: the landed cost shipment headers, with the shipment date, number, organization and adjustment number.
*   `INL_SHIP_LINES_ALL`: the shipment lines, with the primary quantity, unit of measure, item and parent line.
*   `INL_SHIP_LINE_GROUPS`: the shipment line group, linked to the supplier party.
*   `INL_ALLOCATIONS`: the allocation amounts by adjustment, with the source table of each amount (item, charge or tax).
*   `PO_LINE_LOCATIONS_ALL`, `PO_LINES_ALL` and `PO_HEADERS_ALL`: the purchase order shipment, line and header.
*   `RCV_SHIPMENT_LINES`: the receiving line that links the shipment to the country of origin.
*   `MTL_SYSTEM_ITEMS_VL`: the item number and description.
*   `AP_SUPPLIERS`: the supplier name.
*   `MTL_PARAMETERS` and `ORG_ORGANIZATION_DEFINITIONS`: the organization code and ledger link.
*   `GL_LEDGERS`: the ledger and functional currency.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit name.
*   `FND_TERRITORIES_VL`: the country of origin name.
*   `ORG_ACCESS_VIEW`: the organizations visible to the current responsibility.

#### Logical Relationships
1.  The inner allocation query joins `INL_SHIP_HEADERS_ALL` to `INL_ALLOCATIONS` and `INL_SHIP_LINES_ALL`, keeping only landed cost allocations and non-simulated shipments.
2.  Allocations are grouped by shipment header and by parent shipment line, with separate sums for the estimated adjustment (0) and the current adjustment.
3.  The grouped result joins back to the shipment header, line, line group, operating unit, organization, ledger and item.
4.  Suppliers, purchase order lines and receiving lines are attached through the line group party and the shipment line source.
5.  The `LAG` for the previous unit landed cost partitions by organization and item and orders by shipment date, shipment number and line number.

### Parameters & Filtering
*   **Operating Unit** and **Organization Code:** select the operating unit and inventory organization.
*   **Shipment Date From** and **Shipment Date To:** bound the shipment date.
*   **Supplier:** limits the output to one supplier.
*   **Item:** limits the output to one item.
*   **Country of Origin:** limits the output to items from one country.

### Performance & Optimization
*   The allocation roll-up is computed in an inline view grouped by shipment header and parent line, so the item, charge and tax amounts are aggregated once per line.
*   Only allocations flagged as landed cost are read, and only the estimated adjustment and the current adjustment numbers are used, which limits the rows that the aggregation touches.
*   Simulated shipments are excluded with a null check on the simulation ID, so simulation data does not enter the trend.
*   The organization restriction is an `IN` subquery on `ORG_ACCESS_VIEW`.

### FAQ
**Q: What does the Estimated Unit Landed Cost column show?**
A: It is the landed cost of the first calculation, from the adjustment number zero allocations, divided by the primary quantity of the shipment line.

**Q: How is the change from the previous shipment calculated?**
A: The unit landed cost of the previous shipment for the same item and organization is subtracted from the current unit landed cost, and the percentage is calculated against that previous value.

**Q: Which previous shipment is used for the comparison?**
A: The previous shipment is taken from the shipments inside the selected date range, ordered by shipment date, shipment number and shipment line.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-unit-cost-trend)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
