---
layout: default
title: 'AP Invoice Hold Upload | Oracle EBS SQL Report'
description: 'Releases and places AP invoice holds in bulk - the Excel equivalent of the Invoice Workbench Holds tab. Download the open holds with the download…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Invoice, Hold, ap_lookup_codes, ap_holds_all, ap_invoices_all'
permalink: /AP%20Invoice%20Hold%20Upload/
---

# AP Invoice Hold Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-invoice-hold-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Releases and places AP invoice holds in bulk - the Excel equivalent of the Invoice Workbench Holds tab.

Download the open holds with the download parameters, pick a Release Name (and optionally overwrite the defaulted Release Reason) on the rows to release, and upload. Each hold row is released through the same Oracle logic as the form, including the invoice holds workflow abort, the hold business event and the E-Business Tax synchronization. To place a new manual hold, add a row with the invoice reference and a Hold Name, leaving the Release Name blank.

Holds are identified by Operating Unit, Invoice Number, Supplier and Hold Name, so rows can also be pasted from an external list instead of downloaded. When an invoice has several open holds of the same name (for example matching holds on different purchase order shipments), the PO Number, PO Line, PO Shipment or Invoice Line columns identify the exact hold.

By default only user releasable holds are downloaded - system holds such as Line Variance or Distribution Variance cannot be released manually and are removed by correcting the invoice and revalidating. Set User Releasable Only to No to review them.

Releasing all holds of an invoice does not submit Invoice Validation - the invoice status is derived by Oracle and updates automatically, exactly as after releasing holds in the form.

## Report Parameters
Upload Mode, Operating Unit, Supplier, Invoice Number, Invoice Date From, Invoice Date To, Hold Name, Hold Date From, Hold Date To, Held By, PO Number, User Releasable Only

## Oracle EBS Tables Used
[ap_lookup_codes](https://www.enginatics.com/library/?pg=1&find=ap_lookup_codes), [ap_holds_all](https://www.enginatics.com/library/?pg=1&find=ap_holds_all), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [ap_hold_codes](https://www.enginatics.com/library/?pg=1&find=ap_hold_codes), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [AP Invoice on Hold](/AP%20Invoice%20on%20Hold/ "AP Invoice on Hold Oracle EBS SQL Report"), [AP Accounted Invoice Aging](/AP%20Accounted%20Invoice%20Aging/ "AP Accounted Invoice Aging Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/ap-invoice-hold-upload/) |
| Blitz Report™ XML Import | [AP_Invoice_Hold_Upload.xml](https://www.enginatics.com/xml/ap-invoice-hold-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ap-invoice-hold-upload/](https://www.enginatics.com/reports/ap-invoice-hold-upload/) |



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
