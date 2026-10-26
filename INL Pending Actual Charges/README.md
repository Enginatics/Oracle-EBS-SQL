---
layout: default
last_modified_at: 2026-10-26
title: 'INL Pending Actual Charges | Oracle EBS SQL Report'
description: 'Estimated landed cost charges per shipment line, charge type and charging party that no AP invoice has been matched to yet, aged by shipment date at the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Oracle Landed Cost Management, Enginatics, R12 only, INL, Pending, Actual, Charges, rcv_transactions, inl_ship_headers_all, inl_allocations'
permalink: /INL%20Pending%20Actual%20Charges/
report_name: 'INL Pending Actual Charges'
report_web_name: inl-pending-actual-charges
module: 'Oracle Landed Cost Management'
module_url: /modules/oracle-landed-cost-management/
---

# INL Pending Actual Charges – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inl-pending-actual-charges/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges).
**Oracle EBS module:** [Oracle Landed Cost Management](/modules/oracle-landed-cost-management/ "Oracle EBS Oracle Landed Cost Management reports") · [all Oracle Landed Cost Management reports](/modules/oracle-landed-cost-management/)  

## Overview
Estimated landed cost charges per shipment line, charge type and charging party that no AP invoice has been matched to yet, aged by shipment date at the As of Date. It lists the freight, duty and brokerage invoices still to be received and the accrual exposure they carry.

Estimated Amount is the current estimate in functional currency, including estimate changes made after the shipment was submitted, and Original Estimated Amount the first calculation. A charge type stops being pending on a receipt line once any invoice of that type is matched to it, whatever the amount.

A charge invoice that Payables has matched but that has not reached the shipment yet, because it is still in the LCM matches interface or failed there, shows its amount, interface status and invoice number in the Interface columns. Such a charge stays pending until the Landed Cost Management matches import has processed it.

Shipment lines closed for matching are excluded unless Include Closed for Matching is set.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Organization Code, As of Date, Minimum Age Days, Shipment Date From, Shipment Date To, Supplier, Item, Charge Type, Charging Party, Include Closed for Matching

## Oracle EBS Tables Used
[rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [inl_ship_headers_all](https://www.enginatics.com/library/?pg=1&find=inl_ship_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [inl_allocations](https://www.enginatics.com/library/?pg=1&find=inl_allocations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [inl_ship_lines_all](https://www.enginatics.com/library/?pg=1&find=inl_ship_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [inl_charge_lines](https://www.enginatics.com/library/?pg=1&find=inl_charge_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [inl_matches_int](https://www.enginatics.com/library/?pg=1&find=inl_matches_int&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [ap_invoice_distributions_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [inl_matches](https://www.enginatics.com/library/?pg=1&find=inl_matches&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [inl_ship_line_groups](https://www.enginatics.com/library/?pg=1&find=inl_ship_line_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [rcv_shipment_lines](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [pon_cost_factors_vl](https://www.enginatics.com/library/?pg=1&find=pon_cost_factors_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges)

## Related Reports
[INL Landed Cost Estimated vs Actual](/INL%20Landed%20Cost%20Estimated%20vs%20Actual/ "INL Landed Cost Estimated vs Actual Oracle EBS SQL Report"), [INL Duty and Tariff Analysis](/INL%20Duty%20and%20Tariff%20Analysis/ "INL Duty and Tariff Analysis Oracle EBS SQL Report"), [INL Tariff Exposure on Open POs](/INL%20Tariff%20Exposure%20on%20Open%20POs/ "INL Tariff Exposure on Open POs Oracle EBS SQL Report"), [INL Landed Unit Cost Trend](/INL%20Landed%20Unit%20Cost%20Trend/ "INL Landed Unit Cost Trend Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [INL Landed Cost Adjustments](/INL%20Landed%20Cost%20Adjustments/ "INL Landed Cost Adjustments Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INL%20Pending%20Actual%20Charges/INL%20Pending%20Actual%20Charges.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INL Pending Actual Charges 10-Oct-2026 151355.xlsx](https://www.enginatics.com/example/inl-pending-actual-charges/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges) |
| Blitz Report™ XML Import | [INL_Pending_Actual_Charges.xml](https://www.enginatics.com/xml/inl-pending-actual-charges/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges) |
| SQL Source | [INL Pending Actual Charges.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INL%20Pending%20Actual%20Charges/INL%20Pending%20Actual%20Charges.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inl-pending-actual-charges/](https://www.enginatics.com/reports/inl-pending-actual-charges/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges) |

## Case Study & Technical Analysis: INL Pending Actual Charges

### Executive Summary
This report lists the landed cost charges on receipts that no Accounts Payable invoice has been matched to yet. Each row is a shipment line, charge type and charging party combination, aged by shipment date at the chosen as-of date. It shows the estimated amount of the freight, duty and brokerage charges still awaiting their invoices, and the accrual exposure they carry. Import and logistics accountants use it at period close to see which landed costs are still estimates and to chase the missing supplier invoices. The report runs in Excel through Blitz Report.

### Business Challenge
*   **Unmatched landed costs:** Freight, duty and brokerage charges are estimated at receipt, and their invoices may arrive weeks later.
*   **Accrual exposure:** Estimated landed costs that are not yet invoiced affect inventory value and accruals at period end.
*   **Aging of open charges:** Charges that have waited for their invoices for months need escalation to the forwarder or broker.
*   **Interface failures:** A charge invoice that failed in the landed cost matches interface looks matched in Payables but is still pending in landed cost management.

### The Solution
*   **Estimate and current amount:** The current estimate, including later estimate changes, is shown with the original first calculation for comparison.
*   **Pending test per charge type:** A charge stops being pending on a receipt line once any invoice of that charge type is matched to it, whatever the amount.
*   **Aging buckets:** Each row is placed in 0-30, 31-60, 61-90, 91-180 or 181-plus day buckets by shipment date at the as-of date.
*   **Interface visibility:** The matched amount, interface status and invoice numbers of charges still in the matches interface are shown.
*   **Closed lines excluded:** Shipment lines closed for matching are excluded unless the Include Closed for Matching parameter is set.

### Technical Architecture (High Level)
#### Primary Tables
*   `INL_SHIP_HEADERS_ALL` and `INL_SHIP_LINES_ALL`: the landed cost shipment and its lines.
*   `INL_ALLOCATIONS`: the allocated landed cost amounts, by adjustment number.
*   `INL_CHARGE_LINES`: the charge lines, with charge type and charging party.
*   `INL_MATCHES`: the matches already made to a charge type on a shipment line.
*   `INL_MATCHES_INT`: the charges waiting in the matches interface, with their processing status.
*   `RCV_SHIPMENT_LINES` and `RCV_SHIPMENT_HEADERS`: the receipt lines and headers linked to the landed cost line.
*   `RCV_TRANSACTIONS`: the receive transactions that give the receipt date.
*   `PO_HEADERS_ALL`, `PO_LINES_ALL` and `PO_LINE_LOCATIONS_ALL`: the purchase order that the shipment line came from.
*   `PON_COST_FACTORS_VL`: the landed cost charge type names.
*   `AP_SUPPLIERS` and `HZ_PARTIES`: the supplier and the charging party.
*   `GL_LEDGERS` and `ORG_ORGANIZATION_DEFINITIONS`: the ledger currency of each organization.

#### Logical Relationships
1. The estimated amounts come from an inline view that sums allocations of the landed cost flag by shipment line and charge line type, for the original adjustment and the current adjustment.
2. The inline view is joined to the interface matches view on shipment line and charge line type, as an outer join, so a charge with no interface record still appears.
3. A charge is excluded when a matching `INL_MATCHES` row of type CHARGE already exists for the shipment line and charge type.
4. The shipment line joins to `RCV_SHIPMENT_LINES` through the LCM shipment line id, and to the purchase order through the line location of a PO source.
5. The charge type joins to `PON_COST_FACTORS_VL` on the price element type id, and the charging party to `HZ_PARTIES`.

### Parameters & Filtering
*   **Operating Unit and Organization Code:** restrict the shipments to one operating unit and organization.
*   **As of Date:** sets the date from which the age of each shipment is measured.
*   **Minimum Age Days:** excludes younger shipments from the list.
*   **Shipment Date From / Shipment Date To:** bound the shipments by shipment date.
*   **Supplier, Item, Charge Type and Charging Party:** narrow the charges to one supplier, item, charge or charging party.
*   **Include Closed for Matching:** when set to Y, includes shipment lines closed for matching.

### Performance & Optimization
*   The organization restriction uses the organization access view for the responsibility, so the inline view reads only the shipments the user can access.
*   The matched-charge exclusion is a NOT IN subquery on `INL_MATCHES`, which removes charges already invoiced before the outer joins run.

### FAQ
**Q: Why does a charge still show as pending after I entered its invoice?**
A: The invoice must be matched to the same shipment line and charge type, and the Landed Cost Management matches import must have processed it. Until then the charge stays pending.

**Q: Why are closed shipment lines missing?**
A: Shipment lines closed for matching are excluded unless the Include Closed for Matching parameter is set to Y.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-pending-actual-charges)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
