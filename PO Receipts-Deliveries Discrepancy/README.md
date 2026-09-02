---
layout: default
title: 'PO Receipts/Deliveries Discrepancy | Oracle EBS SQL Report'
description: 'PO Receipts/Deliveries Discrepancy highlights, at purchase order line and release level, differences between the quantities and amounts received into…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Receipts/Deliveries, Discrepancy, po_line_locations_all, rcv_transactions, rcv_shipment_headers'
permalink: /PO%20Receipts-Deliveries%20Discrepancy/
---

# PO Receipts/Deliveries Discrepancy – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/po-receipts-deliveries-discrepancy/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
PO Receipts/Deliveries Discrepancy highlights, at purchase order line and release level, differences between the quantities and amounts received into receiving (transaction type RECEIVE) and delivered to their final destination (DELIVER), including the impact of any CORRECT transactions applied to either side.

Quantity Received and Quantity Delivered show the original transaction quantities, Quantity Corrected Receipt and Quantity Corrected Delivery the net correction impact, and Total Quantity Received and Total Quantity Delivered the corrected totals. Quantity Variance and Cost Variance compare the corrected totals, with amounts valued at the purchase price of each receiving transaction.

Return to Vendor and Return to Receiving quantities (net of their corrections) are shown for reference but are not netted into the variance columns.

Provide a Last Receipt Date range (required): the report shows purchase order lines that had a receipt within that range, and for each it nets ALL of the line's receiving transactions to date, so the variance reflects the current outstanding received-vs-delivered position, not just activity in the window. Narrow the range (and/or add a PO, Supplier or Item filter) to keep large organizations fast.

By default the report shows discrepancy rows only (quantity or cost variance different from zero). Set parameter Discrepancies Only to No to list all purchase order receiving activity for the selected lines.

## Report Parameters
Operating Unit, Organization Code, Supplier, PO Number, Item, Last Receipt Date From, Last Receipt Date To, Discrepancies Only

## Oracle EBS Tables Used
[po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report"), [AP Invoices with PO, Intercompany and SLA Details](/AP%20Invoices%20with%20PO-%20Intercompany%20and%20SLA%20Details/ "AP Invoices with PO, Intercompany and SLA Details Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [PO Purchase Requisitions with PO Details](/PO%20Purchase%20Requisitions%20with%20PO%20Details/ "PO Purchase Requisitions with PO Details Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/po-receipts-deliveries-discrepancy/) |
| Blitz Report™ XML Import | [PO_Receipts_Deliveries_Discrepancy.xml](https://www.enginatics.com/xml/po-receipts-deliveries-discrepancy/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/po-receipts-deliveries-discrepancy/](https://www.enginatics.com/reports/po-receipts-deliveries-discrepancy/) |



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
