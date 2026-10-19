---
layout: default
last_modified_at: 2026-10-19
title: 'INL Duty and Tariff Analysis | Oracle EBS SQL Report'
description: 'Duty, other charges and taxes per landed cost shipment line, with tariff code, country of origin and supplier, to analyse duty rates and the landed cost…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Oracle Landed Cost Management, Enginatics, R12 only, INL, Duty, Tariff, Analysis, fnd_territories_vl, mtl_category_sets_vl, mtl_item_categories'
permalink: /INL%20Duty%20and%20Tariff%20Analysis/
report_name: 'INL Duty and Tariff Analysis'
report_web_name: inl-duty-and-tariff-analysis
module: 'Oracle Landed Cost Management'
module_url: /modules/oracle-landed-cost-management/
---

# INL Duty and Tariff Analysis – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inl-duty-and-tariff-analysis/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis).
**Oracle EBS module:** [Oracle Landed Cost Management](/modules/oracle-landed-cost-management/ "Oracle EBS Oracle Landed Cost Management reports") · [all Oracle Landed Cost Management reports](/modules/oracle-landed-cost-management/)  

## Overview
Duty, other charges and taxes per landed cost shipment line, with tariff code, country of origin and supplier, to analyse duty rates and the landed cost uplift on the item value.

The charge types counted as duty are selected in the Duty Charge Type parameter, all other charges are Other Charges. Amounts are the current landed cost allocations in functional currency, Duty Estimated the first calculation. LCM allocates a charge to the shipment lines by the charge type's allocation basis, so an actual duty invoice matched to the shipment is spread over its lines, and the duty rate per line reflects that allocation rather than the customs entry line.

Oracle has no standard HTS field: the tariff code is the item's category in the Tariff Code Category Set, an item category set holding the HTS codes.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Organization Code, Shipment Date From, Shipment Date To, Supplier, Item, Country of Origin, Duty Charge Type, Tariff Code Category Set, Tariff Code

## Oracle EBS Tables Used
[fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [mtl_category_sets_vl](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [inl_matches](https://www.enginatics.com/library/?pg=1&find=inl_matches&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [inl_charge_lines](https://www.enginatics.com/library/?pg=1&find=inl_charge_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [inl_ship_headers_all](https://www.enginatics.com/library/?pg=1&find=inl_ship_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [inl_allocations](https://www.enginatics.com/library/?pg=1&find=inl_allocations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [inl_ship_lines_all](https://www.enginatics.com/library/?pg=1&find=inl_ship_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [pon_cost_factors_vl](https://www.enginatics.com/library/?pg=1&find=pon_cost_factors_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [inl_ship_line_groups](https://www.enginatics.com/library/?pg=1&find=inl_ship_line_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [rcv_shipment_lines](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis)

## Related Reports
[INL Tariff Exposure on Open POs](/INL%20Tariff%20Exposure%20on%20Open%20POs/ "INL Tariff Exposure on Open POs Oracle EBS SQL Report"), [INL Landed Cost Estimated vs Actual](/INL%20Landed%20Cost%20Estimated%20vs%20Actual/ "INL Landed Cost Estimated vs Actual Oracle EBS SQL Report"), [INL Pending Actual Charges](/INL%20Pending%20Actual%20Charges/ "INL Pending Actual Charges Oracle EBS SQL Report"), [INL Landed Unit Cost Trend](/INL%20Landed%20Unit%20Cost%20Trend/ "INL Landed Unit Cost Trend Oracle EBS SQL Report"), [INL Landed Cost Adjustments](/INL%20Landed%20Cost%20Adjustments/ "INL Landed Cost Adjustments Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INL%20Duty%20and%20Tariff%20Analysis/INL%20Duty%20and%20Tariff%20Analysis.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INL Duty and Tariff Analysis 10-Oct-2026 151355.xlsx](https://www.enginatics.com/example/inl-duty-and-tariff-analysis/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis) |
| Blitz Report™ XML Import | [INL_Duty_and_Tariff_Analysis.xml](https://www.enginatics.com/xml/inl-duty-and-tariff-analysis/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis) |
| SQL Source | [INL Duty and Tariff Analysis.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INL%20Duty%20and%20Tariff%20Analysis/INL%20Duty%20and%20Tariff%20Analysis.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inl-duty-and-tariff-analysis/](https://www.enginatics.com/reports/inl-duty-and-tariff-analysis/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis) |

## Case Study & Technical Analysis: INL Duty and Tariff Analysis

### Executive Summary
The INL Duty and Tariff Analysis report shows duty, other charges and taxes for each landed cost shipment line, together with the tariff code, country of origin and supplier. It supports the analysis of duty rates and of the landed cost uplift on the item value, comparing the estimated and current duty amounts. Import compliance and cost accounting teams in Oracle Landed Cost Management (LCM) use it to check how duty has been allocated to receipts, to find lines with a high duty rate or uplift, and to review the tariff classification behind the duty. The report runs in Excel via Blitz Report.

### Business Challenge
*   **Duty cost visibility:** Duty is recorded as charges on landed cost shipments, and its effect on each item's cost is not easy to see in standard reporting.
*   **Estimate versus actual:** The first duty calculation and the current allocation can differ once customs invoices are matched, and the variance needs to be explained.
*   **Tariff classification review:** Oracle has no standard HTS field, so the tariff code must be traced to the item category used for classification.

### The Solution
*   **Charge classification:** Charges are split into duty, which is selected by the Duty Charge Type parameter, and other charges, with taxes shown separately.
*   **Estimate and current amounts:** The estimated duty from the first calculation is shown beside the current duty, with the variance between them.
*   **Rate and uplift calculations:** Duty rate, duty per unit, landed cost and landed cost uplift are calculated per shipment line, with division by zero guarded.
*   **Tariff code from category set:** The tariff code is the item's category in the Tariff Code Category Set, shown with the country of origin and supplier.

### Technical Architecture (High Level)
#### Primary Tables
*   `INL_SHIP_HEADERS_ALL`: the landed cost shipment header, with shipment number, date, adjustment number and organization.
*   `INL_SHIP_LINES_ALL`, `INL_SHIP_LINE_GROUPS`: the shipment lines, their item, primary quantity and supplier party group.
*   `INL_ALLOCATIONS`: the amount allocated from each charge, tax or item component to each shipment line, with the landed cost flag and the adjustment number.
*   `INL_CHARGE_LINES`: the charge lines and their charge line types.
*   `INL_MATCHES`: the matches between charges and shipment lines, used to flag matched duty.
*   `PON_COST_FACTORS_VL`: the charge type names used to label each charge line.
*   `PO_LINE_LOCATIONS_ALL`, `PO_LINES_ALL`, `PO_HEADERS_ALL`: the purchase order documents of the shipment lines.
*   `RCV_SHIPMENT_LINES`, `RCV_SHIPMENT_HEADERS`: the receipt that the shipment line was matched to, and its receipt number.
*   `MTL_SYSTEM_ITEMS_VL`, `MTL_CATEGORY_SETS_VL`, `MTL_ITEM_CATEGORIES`, `MTL_CATEGORIES_KFV`: the item and its tariff category.
*   `AP_SUPPLIERS`, `FND_TERRITORIES_VL`: the supplier and the country name.
*   `HR_ALL_ORGANIZATION_UNITS_VL`, `MTL_PARAMETERS`, `ORG_ORGANIZATION_DEFINITIONS`, `GL_LEDGERS`, `ORG_ACCESS_VIEW`: operating unit, organization, ledger and security.

#### Logical Relationships
1. The inner block `x` groups the allocations by shipment header, shipment line and component type (item, charge or tax), using the allocation's adjustment number.
2. Each charge component is flagged as matched when a row exists in `INL_MATCHES` for the same shipment line and charge line type.
3. The block `z` sums the item value, estimated duty, current duty, other charges and taxes per shipment line.
4. `z` joins to `INL_SHIP_HEADERS_ALL`, `INL_SHIP_LINES_ALL` and `INL_SHIP_LINE_GROUPS`, then to the organization, ledger and item tables.
5. Purchase order and receipt details are outer joined through the shipment line source type and `RCV_SHIPMENT_LINES.LCM_SHIPMENT_LINE_ID`.

### Parameters & Filtering
*   **Operating Unit, Organization Code, Shipment Date From and To:** Restrict the shipments to the operating unit, organization and shipment date range.
*   **Supplier, Item, Country of Origin:** Restrict the lines to one supplier, item or country of origin.
*   **Duty Charge Type:** Selects the charge types that are counted as duty; all other charges are reported as Other Charges.
*   **Tariff Code Category Set and Tariff Code:** Name the item category set that holds the HTS codes and filter the tariff codes.

### Performance & Optimization
*   Allocations are filtered on the landed cost flag and on adjustment numbers 0 and the current adjustment, which limits each shipment to the estimated and current calculations.
*   The matched-duty flag is a correlated subquery on `INL_MATCHES`.
*   Divisions use `nullif`, so lines with zero item value or zero quantity return null rates rather than errors.

### FAQ
**Q: Why does the duty rate on a line differ from the customs entry?**
A: LCM allocates each charge to shipment lines by the charge type's allocation basis, so the duty per line reflects that allocation rather than the customs entry line.

**Q: Where does the tariff code come from?**
A: Oracle has no standard HTS field, so the tariff code is the item's category in the Tariff Code Category Set, which must be named as a parameter.

**Q: What does Duty Variance show?**
A: It is the current duty less the estimated duty from the first calculation, so a positive value means the duty has increased since the estimate.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-duty-and-tariff-analysis)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
