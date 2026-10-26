---
layout: default
last_modified_at: 2026-10-26
title: 'PO Advance Shipment Notice Upload | Oracle EBS SQL Report'
description: 'Creates advance shipment notices (ASN) and advance shipment and billing notices (ASBN) against approved purchase order shipments, as a supplier does in…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Advance, Shipment, Notice, ap_terms_vl, fnd_territories_vl, mtl_parameters'
permalink: /PO%20Advance%20Shipment%20Notice%20Upload/
report_name: 'PO Advance Shipment Notice Upload'
report_web_name: po-advance-shipment-notice-upload
---

# PO Advance Shipment Notice Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/po-advance-shipment-notice-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload).

## Overview
Creates advance shipment notices (ASN) and advance shipment and billing notices (ASBN) against approved purchase order shipments, as a supplier does in iSupplier Portal or by EDI, and cancels them.

Each row is one shipment line. Rows with the same Ship-To Organization, supplier and Shipment Number form one shipment, whose header values are taken from its first row. The supplier and supplier site are those of the purchase order.

The rows are loaded into the receiving open interface and processed by the Receiving Transaction Processor; its errors are shown in the Message column.

Create, Update downloads the open lines of existing shipments. Cancel Shipment cancels a shipment that has not been received yet, with all of its lines. Shipments shipped more than 12 months ago cannot be cancelled.

An ASBN needs Invoice Number, Invoice Date and Invoice Amount; the Receiving Transaction Processor passes its invoice on to Payables Open Interface Import.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Ship To Organization, Supplier, Shipment Number, PO Number, Shipment Date From, Shipment Date To

## Oracle EBS Tables Used
[ap_terms_vl](https://www.enginatics.com/library/?pg=1&find=ap_terms_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload), [rcv_shipment_lines](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload)

## Related Reports
[AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report"), [PO Purchase Requisitions with PO Details](/PO%20Purchase%20Requisitions%20with%20PO%20Details/ "PO Purchase Requisitions with PO Details Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [INL Duty and Tariff Analysis](/INL%20Duty%20and%20Tariff%20Analysis/ "INL Duty and Tariff Analysis Oracle EBS SQL Report"), [INL Tariff Exposure on Open POs](/INL%20Tariff%20Exposure%20on%20Open%20POs/ "INL Tariff Exposure on Open POs Oracle EBS SQL Report"), [INL Landed Unit Cost Trend](/INL%20Landed%20Unit%20Cost%20Trend/ "INL Landed Unit Cost Trend Oracle EBS SQL Report"), [INL Landed Cost Estimated vs Actual](/INL%20Landed%20Cost%20Estimated%20vs%20Actual/ "INL Landed Cost Estimated vs Actual Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Advance%20Shipment%20Notice%20Upload/PO%20Advance%20Shipment%20Notice%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/po-advance-shipment-notice-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload) |
| Blitz Report™ XML Import | [PO_Advance_Shipment_Notice_Upload.xml](https://www.enginatics.com/xml/po-advance-shipment-notice-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload) |
| SQL Source | [PO Advance Shipment Notice Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Advance%20Shipment%20Notice%20Upload/PO%20Advance%20Shipment%20Notice%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/po-advance-shipment-notice-upload/](https://www.enginatics.com/reports/po-advance-shipment-notice-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload) |


---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-advance-shipment-notice-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
