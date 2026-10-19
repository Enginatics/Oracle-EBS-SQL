---
layout: default
last_modified_at: 2026-10-19
title: 'PO Receiving Transaction Upload | Oracle EBS SQL Report'
description: 'PO Receiving Transaction Upload ================================ Create receiving transactions (receipts) against approved standard purchase orders…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Receiving, Transaction, po_distributions_all, hr_locations_all, fnd_territories_vl'
permalink: /PO%20Receiving%20Transaction%20Upload/
report_name: 'PO Receiving Transaction Upload'
report_web_name: po-receiving-transaction-upload
---

# PO Receiving Transaction Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/po-receiving-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload).

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Organization, PO Number

## Oracle EBS Tables Used
[po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload), [mtl_system_items_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload)

## Related Reports
[AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [PO Purchase Requisitions with PO Details](/PO%20Purchase%20Requisitions%20with%20PO%20Details/ "PO Purchase Requisitions with PO Details Oracle EBS SQL Report"), [INL Landed Cost Estimated vs Actual](/INL%20Landed%20Cost%20Estimated%20vs%20Actual/ "INL Landed Cost Estimated vs Actual Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Receiving%20Transaction%20Upload/PO%20Receiving%20Transaction%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/po-receiving-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload) |
| Blitz Report™ XML Import | [PO_Receiving_Transaction_Upload.xml](https://www.enginatics.com/xml/po-receiving-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload) |
| SQL Source | [PO Receiving Transaction Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Receiving%20Transaction%20Upload/PO%20Receiving%20Transaction%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/po-receiving-transaction-upload/](https://www.enginatics.com/reports/po-receiving-transaction-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload) |

## Case Study & Technical Analysis: PO Receiving Transaction Upload

### Executive Summary
The PO Receiving Transaction Upload creates receiving transactions, or receipts, against approved standard, blanket and scheduled purchase orders in Oracle Purchasing and Receiving. The download lists the open purchase order shipment lines that still have quantity to receive in the selected receiving organization, and the user enters the quantity and transaction date for each line to receive. Receiving clerks and warehouse supervisors use it to record deliveries in bulk, for example when a supplier delivers many lines on one day or when receipts are captured from a paper delivery log. The report runs in Excel via Blitz Report.

### Business Challenge
*   **High receipt volume:** Receiving a large delivery line by line in the Receiving form is slow and creates a backlog in the receiving system.
*   **Open quantity visibility:** Receivers need to see the quantity ordered, received and remaining for each shipment before entering a receipt.
*   **Destination control:** Each receipt must go to the correct destination type, subinventory, locator and deliver-to location as defined on the purchase order distribution.
*   **Trade and lot information:** Country of origin and vendor lot numbers are needed for trade compliance and lot traceability at receipt.

### The Solution
*   **Open shipment download:** The download returns shipments that are approved, not cancelled or closed, and still have quantity remaining to receive.
*   **Pre-filled defaults:** Destination type, subinventory and deliver-to location are taken from the purchase order distribution, and can be overridden on the row.
*   **Quantity remaining:** Quantity ordered, quantity received and quantity remaining are shown beside the receipt entry columns.
*   **Trade fields:** Country of origin and vendor lot number columns are included for receipts that require them.

### Technical Architecture (High Level)
#### Primary Tables
*   `PO_HEADERS_ALL`: the purchase order header, with the document number, supplier and supplier site.
*   `PO_LINES_ALL`: the purchase order lines, with line number, item revision, description and unit of measure.
*   `PO_LINE_LOCATIONS_ALL`: the shipments, with ship-to organization, quantities, approval, cancel and closed codes, and country of origin.
*   `PO_DISTRIBUTIONS_ALL`: the distributions of each shipment, with destination type, subinventory and deliver-to location.
*   `AP_SUPPLIERS`, `AP_SUPPLIER_SITES_ALL`: the supplier name and site code.
*   `MTL_PARAMETERS`: the receiving inventory organization.
*   `MTL_SYSTEM_ITEMS_B_KFV`: the item for the shipment's ship-to organization.
*   `HR_LOCATIONS_ALL`, `FND_TERRITORIES_VL`: the deliver-to location and the country of origin name.

#### Logical Relationships
1. `PO_HEADERS_ALL` is joined to `PO_LINES_ALL` on the purchase order identifier, and `PO_LINES_ALL` to `PO_LINE_LOCATIONS_ALL` on the line identifier.
2. `PO_HEADERS_ALL` is joined to `AP_SUPPLIERS` on vendor, and outer joined to `AP_SUPPLIER_SITES_ALL` on vendor site.
3. `PO_LINE_LOCATIONS_ALL` is joined to `MTL_PARAMETERS` on the ship-to organization.
4. `PO_LINES_ALL` is outer joined to `MTL_SYSTEM_ITEMS_B_KFV` on item and organization.
5. Destination type, subinventory and deliver-to location are scalar subqueries on `PO_DISTRIBUTIONS_ALL` for the shipment, with the first distribution returned.

### Parameters & Filtering
*   **Upload Mode:** Create opens an empty spreadsheet for manually entered receipts; Create, Update downloads the open shipment lines for editing.
*   **Organization:** Restricts the download to the selected receiving inventory organization.
*   **PO Number:** Restricts the download to one purchase order.

The description states the prerequisites for a receipt: the purchase order must be approved and not cancelled or closed, the shipment must have remaining quantity, and the transaction date must be in an open receiving period.

### Performance & Optimization
*   The download predicates filter on shipment type, approval, cancellation, closed status and remaining quantity in the main query, so closed or fully received lines are not read.
*   The destination lookups are scalar subqueries that return the first distribution, so each shipment yields one value per column.
*   Supplier site and item joins are outer joins on keyed identifiers, so they do not change the number of shipment rows.
*   The query uses no aggregation or analytic functions.

### FAQ
**Q: Why is a purchase order line missing from the download?**
A: A line is only downloaded when its shipment is approved, not cancelled or closed, and has quantity remaining to receive, so fully received or closed lines are excluded.

**Q: Where do the destination type and subinventory come from?**
A: They are taken from the purchase order distribution of the shipment, and they can be overridden on the row before upload.

**Q: What is required for a receipt to be accepted?**
A: The quantity must be greater than zero, and the transaction date must fall in an open inventory receiving period.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transaction-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
