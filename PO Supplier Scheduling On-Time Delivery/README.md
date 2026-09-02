---
layout: default
title: 'PO Supplier Scheduling On-Time Delivery | Oracle EBS SQL Report'
description: 'Supplier on-time delivery (OTD) based on the Oracle Supplier Scheduling (CHV) module instead of the purchase order form. For each firm scheduled release…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Supplier, Scheduling, On-Time, Delivery, per_all_people_f, rcv_transactions, rcv_shipment_headers'
permalink: /PO%20Supplier%20Scheduling%20On-Time%20Delivery/
---

# PO Supplier Scheduling On-Time Delivery – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/po-supplier-scheduling-on-time-delivery/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Supplier on-time delivery (OTD) based on the Oracle Supplier Scheduling (CHV) module instead of the purchase order form. For each firm scheduled release the report compares the scheduling-module requested delivery date against the actual goods receipt date and reports the delivery delay, ordered vs received quantity, and a partial-delivery flag. Designed for environments where the blanket PO holds only a skeleton (with placeholder dates) and the real call-off dates arrive via EDI into Supplier Scheduling. First-pass draft - see version comments for open scoping items.

## Report Parameters
Operating Unit, Supplier, Requested Date From, Requested Date To, Received Date From, Received Date To, On Time Tolerance Days

## Oracle EBS Tables Used
[per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers), [rcv_shipment_lines](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_lines), [chv_item_orders](https://www.enginatics.com/library/?pg=1&find=chv_item_orders), [chv_schedule_headers](https://www.enginatics.com/library/?pg=1&find=chv_schedule_headers), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors), [po_vendor_sites_all](https://www.enginatics.com/library/?pg=1&find=po_vendor_sites_all), [mtl_system_items_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b_kfv), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[PO Printed Planning Schedule](/PO%20Printed%20Planning%20Schedule/ "PO Printed Planning Schedule Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PO Supplier Scheduling On-Time Delivery 01-Jun-2026 020909.xlsx](https://www.enginatics.com/example/po-supplier-scheduling-on-time-delivery/) |
| Blitz Report™ XML Import | [PO_Supplier_Scheduling_On_Time_Delivery.xml](https://www.enginatics.com/xml/po-supplier-scheduling-on-time-delivery/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/po-supplier-scheduling-on-time-delivery/](https://www.enginatics.com/reports/po-supplier-scheduling-on-time-delivery/) |



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
