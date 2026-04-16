---
layout: default
title: 'PO Receiving Transaction Upload | Oracle EBS SQL Report'
description: 'PO Receiving Transaction Upload ================================ Create receiving transactions (receipts) against approved standard purchase orders…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Receiving, Transaction, po_distributions_all, hr_locations_all, fnd_territories_vl'
permalink: /PO%20Receiving%20Transaction%20Upload/
---

# PO Receiving Transaction Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/po-receiving-transaction-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
PO Receiving Transaction Upload
================================
Create receiving transactions (receipts) against approved standard purchase orders.

Upload Modes
============

Create
------
Opens an empty spreadsheet where the user can manually enter PO receiving details.

Create, Update
--------------
Downloads open PO shipment lines with quantities available to receive for the selected organization.
The user fills in the Quantity and Transaction Date columns for each line to receive, then uploads.

Prerequisites
=============
- PO must be approved and not cancelled or closed.
- PO shipment must have remaining quantity to receive.
- Transaction date must be in an open inventory receiving period.

Fields
======
- Organization Code: Required. The receiving inventory organization.
- PO Number: Required. The purchase order number.
- Line Num: Required. The PO line number.
- Shipment Num: Required. The PO shipment number.
- Item Revision: Optional. Item revision (defaults from PO line, override for revision-controlled items).
- Quantity: Required. The quantity to receive (must be greater than zero).
- Transaction Date: Required. The date of the receipt.
- Destination Type: Optional. Inventory, Expense, or Shop Floor (defaults from PO distribution).
- Subinventory: Optional. Destination subinventory (defaults from PO distribution).
- Locator: Optional. Stock locator within the subinventory (required for locator-controlled subinventories).
- Deliver To Location: Optional. Override the deliver-to location.
- Country of Origin: Optional. Country of origin for trade compliance.
- Vendor Lot Num: Optional. Supplier lot number for lot tracking.
- Comments: Optional. Receipt comments.

## Report Parameters
Upload Mode, Organization, PO Number

## Oracle EBS Tables Used
[po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_system_items_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b_kfv)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/po-receiving-transaction-upload/) |
| Blitz Report™ XML Import | [PO_Receiving_Transaction_Upload.xml](https://www.enginatics.com/xml/po-receiving-transaction-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/po-receiving-transaction-upload/](https://www.enginatics.com/reports/po-receiving-transaction-upload/) |



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
