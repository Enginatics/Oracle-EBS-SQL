---
layout: default
last_modified_at: 2026-10-16
title: 'INL Landed Cost Estimated vs Actual | Oracle EBS SQL Report'
description: 'Landed cost per Landed Cost Management shipment line and cost component (item price, each charge type and each tax), comparing the estimate with the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Oracle Landed Cost Management, Enginatics, R12 only, INL, Landed, Cost, Estimated, fnd_territories_vl, inl_charge_lines, inl_tax_lines'
permalink: /INL%20Landed%20Cost%20Estimated%20vs%20Actual/
report_name: 'INL Landed Cost Estimated vs Actual'
report_web_name: inl-landed-cost-estimated-vs-actual
module: 'Oracle Landed Cost Management'
module_url: /modules/oracle-landed-cost-management/
---

# INL Landed Cost Estimated vs Actual – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inl-landed-cost-estimated-vs-actual/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual).
**Oracle EBS module:** [Oracle Landed Cost Management](/modules/oracle-landed-cost-management/ "Oracle EBS Oracle Landed Cost Management reports") · [all Oracle Landed Cost Management reports](/modules/oracle-landed-cost-management/)  

## Overview
Landed cost per Landed Cost Management shipment line and cost component (item price, each charge type and each tax), comparing the estimate with the current landed cost.

Estimated Amount is the allocation of the shipment's first landed cost calculation (adjustment 0) and Current Amount the allocation of its latest adjustment, both in functional currency. A component without a matched AP invoice still carries its estimate; an estimate changed in the Shipment Workbench after submission shows as a variance without a match.

LCM allocates a charge to the shipment lines by the charge type's allocation basis, so Current Amount per line can differ from Matched Amount, which is the amount distributed to that receipt line on the AP invoice. The shipment totals agree.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Organization Code, Shipment Date From, Shipment Date To, Shipment Number, Supplier, Item, Component Type, Charge Type, Charging Party, Variances Only

## Oracle EBS Tables Used
[fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [inl_charge_lines](https://www.enginatics.com/library/?pg=1&find=inl_charge_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [inl_tax_lines](https://www.enginatics.com/library/?pg=1&find=inl_tax_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [inl_ship_headers_all](https://www.enginatics.com/library/?pg=1&find=inl_ship_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [inl_allocations](https://www.enginatics.com/library/?pg=1&find=inl_allocations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [inl_ship_lines_all](https://www.enginatics.com/library/?pg=1&find=inl_ship_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [inl_matches](https://www.enginatics.com/library/?pg=1&find=inl_matches&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [ap_invoice_distributions_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [inl_ship_line_groups](https://www.enginatics.com/library/?pg=1&find=inl_ship_line_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [rcv_shipment_lines](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [pon_cost_factors_vl](https://www.enginatics.com/library/?pg=1&find=pon_cost_factors_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual)

## Related Reports
[INL Pending Actual Charges](/INL%20Pending%20Actual%20Charges/ "INL Pending Actual Charges Oracle EBS SQL Report"), [INL Duty and Tariff Analysis](/INL%20Duty%20and%20Tariff%20Analysis/ "INL Duty and Tariff Analysis Oracle EBS SQL Report"), [INL Landed Unit Cost Trend](/INL%20Landed%20Unit%20Cost%20Trend/ "INL Landed Unit Cost Trend Oracle EBS SQL Report"), [INL Tariff Exposure on Open POs](/INL%20Tariff%20Exposure%20on%20Open%20POs/ "INL Tariff Exposure on Open POs Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [INL Landed Cost Adjustments](/INL%20Landed%20Cost%20Adjustments/ "INL Landed Cost Adjustments Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INL%20Landed%20Cost%20Estimated%20vs%20Actual/INL%20Landed%20Cost%20Estimated%20vs%20Actual.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INL Landed Cost Estimated vs Actual 10-Oct-2026 151355.xlsx](https://www.enginatics.com/example/inl-landed-cost-estimated-vs-actual/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual) |
| Blitz Report™ XML Import | [INL_Landed_Cost_Estimated_vs_Actual.xml](https://www.enginatics.com/xml/inl-landed-cost-estimated-vs-actual/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual) |
| SQL Source | [INL Landed Cost Estimated vs Actual.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INL%20Landed%20Cost%20Estimated%20vs%20Actual/INL%20Landed%20Cost%20Estimated%20vs%20Actual.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inl-landed-cost-estimated-vs-actual/](https://www.enginatics.com/reports/inl-landed-cost-estimated-vs-actual/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual) |

## Case Study & Technical Analysis: INL Landed Cost Estimated vs Actual

### Executive Summary
The INL Landed Cost Estimated vs Actual report compares the estimated landed cost of each Landed Cost Management shipment line with its current landed cost, by cost component. The components are the item price, each charge type and each tax. The estimate is the first landed cost calculation of the shipment, and the current amount is its latest adjustment, both in functional currency. Import and cost accountants use the report to find where landed costs moved after the shipment was estimated and to match the charges to the AP invoices that paid them. It runs in Excel through Blitz Report.

### Business Challenge
*   **Estimate accuracy:** Landed costs are estimated when a shipment is created, and actual freight, duty and tax charges often differ, which changes the cost of the received goods.
*   **Charge matching:** Each charge should be matched to the AP invoice that billed it, so the team can confirm the landed cost was fully invoiced.
*   **Allocation differences:** Landed Cost Management allocates charges to shipment lines by allocation basis, so a line's amount can differ from the amount matched to its receipt line.
*   **Variance review:** Estimate changes made in the Shipment Workbench after submission must be visible as variances.

### The Solution
*   Shows the estimated and current amounts of each shipment line and component, with the difference and the variance as a percentage of the estimate.
*   Shows the estimated and current unit amounts, based on the primary quantity of the shipment line.
*   Shows the matched amount, whether a match exists, and the AP invoice numbers the matched amount came from.
*   Shows the supplier, purchase order and shipment line, the receipt number and the country of origin for each line.

### Technical Architecture (High Level)
#### Primary Tables
*   `INL_SHIP_HEADERS_ALL`, `INL_SHIP_LINES_ALL` and `INL_SHIP_LINE_GROUPS`: the shipment header, its lines and the supplier group of each line.
*   `INL_ALLOCATIONS`: the allocation of each charge and tax to the shipment lines, by adjustment number.
*   `INL_CHARGE_LINES` and `INL_TAX_LINES`: the charge and tax lines that generated the allocations.
*   `INL_MATCHES`: the links between shipment lines and AP invoice distributions.
*   `AP_INVOICE_DISTRIBUTIONS_ALL` and `AP_INVOICES_ALL`: the invoice distribution and invoice that were matched.
*   `PO_LINE_LOCATIONS_ALL`, `PO_LINES_ALL`, `PO_HEADERS_ALL`, `RCV_SHIPMENT_LINES` and `RCV_SHIPMENT_HEADERS`: the purchase order and receipt of the shipment line.
*   `PON_COST_FACTORS_VL`: the names of the charge types.
*   `AP_SUPPLIERS`, `HZ_PARTIES`, `MTL_SYSTEM_ITEMS_VL`, `FND_TERRITORIES_VL` and `ORG_ACCESS_VIEW`: the supplier, party, item, country and organization access.

#### Logical Relationships
1.  The estimate and current amounts are summed in an inline view from `INL_ALLOCATIONS`. The estimate is the allocation of adjustment 0, and the current amount is the allocation of the shipment's latest adjustment.
2.  Matched amounts are summed in a second inline view, which links `INL_MATCHES` to the AP invoice distributions and invoices, and excludes matches that are the parent of another match.
3.  The two inline views are joined on the shipment line, component type, charge line type and tax code, with null-safe comparisons so that item and tax components match.
4.  The shipment, lines and organization are joined to the purchase order, receipt and supplier, and to `PON_COST_FACTORS_VL` for charge names.

### Parameters & Filtering
*   **Operating Unit**, **Organization Code**, **Shipment Date From** and **Shipment Date To:** restrict the shipments reported.
*   **Shipment Number**, **Supplier** and **Item:** select one shipment, supplier or item.
*   **Component Type** and **Charge Type:** select item, charge or tax components, or one charge type.
*   **Charging Party:** selects the party that charged the component.
*   **Variances Only:** when set, keeps only components whose current amount differs from the estimate.

### Performance & Optimization
*   Allocations are read only for adjustment 0 and the shipment's current adjustment number, which avoids reading every adjustment history.
*   Matched amounts are aggregated before the join, so each shipment component joins to a single summarized row.
*   The organization restriction is applied to the shipment headers through `ORG_ACCESS_VIEW`, so the allocation scan is limited early.
*   Shipment Number, Shipment Date and Organization Code are the most selective parameters on large LCM histories.

### FAQ
**Q: Why does the Current Amount per line differ from the Matched Amount?**
A: Landed Cost Management allocates each charge to shipment lines by the allocation basis of its charge type. The Matched Amount is the amount distributed to the receipt line on the AP invoice, so the two can differ per line while the shipment totals agree.

**Q: What does a variance with no match mean?**
A: The estimate was changed in the Shipment Workbench after submission and the component has no AP invoice match yet, so the variance is shown without a matched amount.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-estimated-vs-actual)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
