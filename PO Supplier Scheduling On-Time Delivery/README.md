---
layout: default
last_modified_at: 2026-10-19
title: 'PO Supplier Scheduling On-Time Delivery | Oracle EBS SQL Report'
description: 'Supplier on-time delivery (OTD) based on the Oracle Supplier Scheduling (CHV) module instead of the purchase order form. For each firm scheduled release…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Purchasing, Enginatics, R12 only, Supplier, Scheduling, On-Time, Delivery, per_all_people_f, rcv_transactions, rcv_shipment_headers'
permalink: /PO%20Supplier%20Scheduling%20On-Time%20Delivery/
report_name: 'PO Supplier Scheduling On-Time Delivery'
report_web_name: po-supplier-scheduling-on-time-delivery
module: 'Purchasing'
module_url: /modules/purchasing/
---

# PO Supplier Scheduling On-Time Delivery – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/po-supplier-scheduling-on-time-delivery/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery).
**Oracle EBS module:** [Purchasing](/modules/purchasing/ "Oracle EBS Purchasing reports") · [all Purchasing reports](/modules/purchasing/)  

## Overview
Supplier on-time delivery (OTD) based on the Oracle Supplier Scheduling (CHV) module instead of the purchase order form. For each firm scheduled release the report compares the scheduling-module requested delivery date against the actual goods receipt date and reports the delivery delay, ordered vs received quantity, and a partial-delivery flag. Designed for environments where the blanket PO holds only a skeleton (with placeholder dates) and the real call-off dates arrive via EDI into Supplier Scheduling. First-pass draft - see version comments for open scoping items.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Supplier, Requested Date From, Requested Date To, Received Date From, Received Date To, On Time Tolerance Days

## Oracle EBS Tables Used
[per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery), [rcv_shipment_lines](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery), [chv_item_orders](https://www.enginatics.com/library/?pg=1&find=chv_item_orders&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery), [chv_schedule_headers](https://www.enginatics.com/library/?pg=1&find=chv_schedule_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery), [po_vendor_sites_all](https://www.enginatics.com/library/?pg=1&find=po_vendor_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery), [mtl_system_items_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery)

## Related Reports
[PO Printed Planning Schedule](/PO%20Printed%20Planning%20Schedule/ "PO Printed Planning Schedule Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [CST AP and PO Accrual Reconciliation](/CST%20AP%20and%20PO%20Accrual%20Reconciliation/ "CST AP and PO Accrual Reconciliation Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Supplier%20Scheduling%20On-Time%20Delivery/PO%20Supplier%20Scheduling%20On-Time%20Delivery.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PO Supplier Scheduling On-Time Delivery 01-Jun-2026 020909.xlsx](https://www.enginatics.com/example/po-supplier-scheduling-on-time-delivery/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery) |
| Blitz Report™ XML Import | [PO_Supplier_Scheduling_On_Time_Delivery.xml](https://www.enginatics.com/xml/po-supplier-scheduling-on-time-delivery/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery) |
| SQL Source | [PO Supplier Scheduling On-Time Delivery.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Supplier%20Scheduling%20On-Time%20Delivery/PO%20Supplier%20Scheduling%20On-Time%20Delivery.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/po-supplier-scheduling-on-time-delivery/](https://www.enginatics.com/reports/po-supplier-scheduling-on-time-delivery/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery) |

## Case Study & Technical Analysis: PO Supplier Scheduling On-Time Delivery

### Executive Summary
The PO Supplier Scheduling On-Time Delivery report measures supplier on-time delivery against the Oracle Supplier Scheduling (CHV) module rather than against the purchase order form. For each firm scheduled release it compares the requested delivery date held in Supplier Scheduling with the first goods receipt date, and it reports the delivery delay, the ordered and received quantities, and a partial delivery flag. It is intended for environments in which the blanket purchase order holds only a skeleton with placeholder dates, and the real call-off dates arrive by EDI into Supplier Scheduling. Supplier quality and purchasing teams use it to score suppliers on delivery performance. The description labels the report a first-pass draft, and the report runs in Excel via Blitz Report.

### Business Challenge
*   **Placeholder dates on blankets:** Blanket purchase orders often carry skeleton promise dates, which makes standard on-time measures meaningless.
*   **Real call-off dates in Supplier Scheduling:** The dates that matter are the scheduled releases received by EDI, which sit in the Supplier Scheduling tables.
*   **Supplier scorecards:** Purchasing needs a consistent measure of how early or late each supplier delivers against its schedule.
*   **Partial deliveries:** Shipments that arrive in parts must be identified, because a single receipt can hide an incomplete delivery.

### The Solution
*   **Scheduling-based requested date:** The requested delivery date is the first scheduled date of each release in Supplier Scheduling, rather than the purchase order promise date.
*   **Receipt-based actual date:** The first goods receipt is the earliest receive transaction against the shipment.
*   **Delay and on-time flag:** The delivery delay is the difference in whole days between the two dates, and a delivery is on time when the delay is within the tolerance entered.
*   **Quantity and partial flag:** Ordered, received and open quantities are shown, and a partial delivery is flagged when some but not all of the quantity has been received.

### Technical Architecture (High Level)
#### Primary Tables
*   `CHV_SCHEDULE_HEADERS`: the Supplier Scheduling header, with the schedule number, type and last EDI date.
*   `CHV_ITEM_ORDERS`: the scheduled items, with due dates and the document shipment link to the purchase order shipment.
*   `PO_LINE_LOCATIONS_ALL`: the purchase order shipments, with promise and need-by dates, quantities and terms.
*   `PO_LINES_ALL`, `PO_HEADERS_ALL`: the purchase order lines and headers.
*   `PO_VENDORS`, `PO_VENDOR_SITES_ALL`: the supplier and supplier site.
*   `RCV_TRANSACTIONS`: the receive transactions, used for the first and last goods receipt dates.
*   `RCV_SHIPMENT_HEADERS`, `RCV_SHIPMENT_LINES`: the shipment notices, used for the ASN date.
*   `MTL_SYSTEM_ITEMS_B_KFV`, `MTL_PARAMETERS`, `HR_LOCATIONS_ALL`, `HR_ALL_ORGANIZATION_UNITS_VL`: item, ship-to organization, location and operating unit.
*   `PER_ALL_PEOPLE_F`: the buyer, valid on the current date.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating unit access list for the session.

#### Logical Relationships
1. `CHV_ITEM_ORDERS` is joined to `CHV_SCHEDULE_HEADERS` for release documents, and summarized per shipment and schedule number.
2. The summaries are aggregated per purchase order shipment, giving the first and last scheduled date, the list of schedule numbers and the last EDI date.
3. The aggregated schedule block is joined to `PO_LINE_LOCATIONS_ALL` on the line location identifier, then to `PO_LINES_ALL`, `PO_HEADERS_ALL`, `PO_VENDORS` and `PO_VENDOR_SITES_ALL`.
4. Receive transactions give the minimum and maximum transaction dates for each shipment, and ASN shipment headers give the ASN date.
5. Item and ship-to organization are taken from the purchase order line and shipment, and the operating unit is restricted by the access list.

### Parameters & Filtering
*   **Operating Unit:** Restricts the report to one operating unit within the accessible set.
*   **Supplier:** Restricts the output to one supplier.
*   **Requested Date From and To:** Restrict the scheduled delivery dates considered.
*   **Received Date From and To:** Restrict the goods receipt dates considered.
*   **On Time Tolerance Days:** The number of days a delivery can be late and still count as on time; when blank, zero is used.

### Performance & Optimization
*   Scheduled releases are summarized in nested inline views before the join to the purchase order, so each shipment is read once for its schedule.
*   Receipt and ASN lookups are correlated scalar subqueries on the shipment line location, so they run once for each returned shipment.
*   The operating unit restriction is an `IN` subquery on `MO_GLOB_ORG_ACCESS_TMP`.
*   The description notes that the report is a first-pass draft with open scoping items, so the performance profile should be checked against a production volume before scheduled use.

### FAQ
**Q: Why is the requested date not the purchase order promise date?**
A: The report is built for blanket orders whose promise dates are placeholders, so the requested date is the first scheduled date in Supplier Scheduling.

**Q: How is an on-time delivery determined?**
A: A delivery is on time when its first goods receipt is within the number of days in On Time Tolerance Days after the requested delivery date.

**Q: What does the partial delivery flag mean?**
A: It is set when some quantity has been received on the shipment but the received quantity is less than the ordered quantity.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-supplier-scheduling-on-time-delivery)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
