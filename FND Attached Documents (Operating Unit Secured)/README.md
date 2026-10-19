---
layout: default
last_modified_at: 2026-10-19
title: 'FND Attached Documents (Operating Unit Secured) | Oracle EBS SQL Report'
description: 'Attachments of operating unit striped documents: sales orders and lines, purchase orders, lines, shipments and releases, requisitions, AP invoices, AR…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, R12 only, FND, Attached, Documents, (Operating, po_releases_all, po_headers_all, po_lines_all'
permalink: /FND%20Attached%20Documents%20%28Operating%20Unit%20Secured%29/
report_name: 'FND Attached Documents (Operating Unit Secured)'
report_web_name: fnd-attached-documents-operating-unit-secured
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Attached Documents (Operating Unit Secured) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-attached-documents-operating-unit-secured/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Attachments of operating unit striped documents: sales orders and lines, purchase orders, lines, shipments and releases, requisitions, AP invoices, AR transactions, projects and delivery details. Each row shows the document the attachment belongs to, its category, title, file name and a clickable download link for file attachments. Short text, long text and URL attachments are shown inline.

The report is secured by operating unit: only documents of the operating units accessible to the running responsibility (profile options MO: Security Profile or MO: Operating Unit) are returned, so it can be assigned to business users without exposing other organizations' attachments. Attachments on entities which are not operating unit striped, such as items, work orders, bills of material, journals, employees or payment instructions, are not included; use the report FND Attached Documents for those.

The Sales Order Number, PO Number and Requisition Number parameters return the header and line level attachments of a document. Their lists show only documents with attachments the report can return.

The download link is created with Oracle's secure file download for the user running the report and expires after the number of minutes set in profile option FND: Security File Download Time Limit. Re-run the report to get fresh links.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Sales Order Number, PO Number, Requisition Number, Document Entity, Category, Datatype, File Name contains, Short Text contains, Text contains, Creation Date from, Creation Date to, Created within days, Created By

## Oracle EBS Tables Used
[po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [po_requisition_lines_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [wsh_delivery_details](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [fnd_documents](https://www.enginatics.com/library/?pg=1&find=fnd_documents&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [fnd_documents_tl](https://www.enginatics.com/library/?pg=1&find=fnd_documents_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [fnd_document_datatypes_vl](https://www.enginatics.com/library/?pg=1&find=fnd_document_datatypes_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [fnd_document_categories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_document_categories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [fnd_lobs](https://www.enginatics.com/library/?pg=1&find=fnd_lobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [fnd_documents_short_text](https://www.enginatics.com/library/?pg=1&find=fnd_documents_short_text&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [fnd_documents_long_text](https://www.enginatics.com/library/?pg=1&find=fnd_documents_long_text&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [fnd_attached_documents](https://www.enginatics.com/library/?pg=1&find=fnd_attached_documents&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [fnd_document_entities_vl](https://www.enginatics.com/library/?pg=1&find=fnd_document_entities_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [fnd_dm_nodes](https://www.enginatics.com/library/?pg=1&find=fnd_dm_nodes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured)

## Related Reports
[FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [INV Movement Statistics](/INV%20Movement%20Statistics/ "INV Movement Statistics Oracle EBS SQL Report"), [ONT Orders and Lines 11i](/ONT%20Orders%20and%20Lines%2011i/ "ONT Orders and Lines 11i Oracle EBS SQL Report"), [ONT Orders and Lines](/ONT%20Orders%20and%20Lines/ "ONT Orders and Lines Oracle EBS SQL Report"), [PPF_WP3_OM_DETAILS](/PPF_WP3_OM_DETAILS/ "PPF_WP3_OM_DETAILS Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Attached%20Documents%20%28Operating%20Unit%20Secured%29/FND%20Attached%20Documents%20%28Operating%20Unit%20Secured%29.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/fnd-attached-documents-operating-unit-secured/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured) |
| Blitz Report™ XML Import | [FND_Attached_Documents_Operating_Unit_Secured.xml](https://www.enginatics.com/xml/fnd-attached-documents-operating-unit-secured/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured) |
| SQL Source | [FND Attached Documents (Operating Unit Secured).sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Attached%20Documents%20%28Operating%20Unit%20Secured%29/FND%20Attached%20Documents%20%28Operating%20Unit%20Secured%29.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-attached-documents-operating-unit-secured/](https://www.enginatics.com/reports/fnd-attached-documents-operating-unit-secured/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured) |

## Case Study & Technical Analysis: FND Attached Documents (Operating Unit Secured)

### Executive Summary
The FND Attached Documents (Operating Unit Secured) report lists the attachments held on operating unit striped documents, such as sales orders, purchase orders, requisitions, AP invoices, AR transactions, projects and delivery details. Each row shows the document the attachment belongs to, its category, title, file name and, for file attachments, a clickable download link. Short text, long text and URL attachments are shown inline. Procurement, order management and receivables users use it to locate supporting documents for their transactions. The report runs in Excel via Blitz Report.

### Business Challenge
*   **Locating supporting evidence:** Approvals, contracts, invoices and delivery proofs are attached to transactions in Oracle EBS, and finding them one document at a time is slow.
*   **Cross-organization exposure:** Attachments often contain commercial or customer information, so they must only be visible for the operating units the user can access.
*   **Mixed attachment types:** Files, URLs and text notes are stored in different structures, which makes a single view difficult to build in the forms.

### The Solution
*   **Operating unit security:** Only documents of the operating units accessible to the running responsibility are returned, using the MO security profile or operating unit profile.
*   **Entity-based reference:** Each attachment is linked to a readable reference, such as a purchase order number with its release, a requisition line, a sales order line or an invoice number.
*   **Typed content:** Short text and long text are read from their own tables, URLs become hyperlinks, and files get a secure download link.
*   **Document filters:** Parameters for document entity, category, datatype, file name, text content, creation date and creator narrow the list.

### Technical Architecture (High Level)
#### Primary Tables
*   `FND_ATTACHED_DOCUMENTS`: links each document to its entity and primary key values, with the sequence number.
*   `FND_DOCUMENTS`: the document header, with datatype, category, usage, security and creation details.
*   `FND_DOCUMENTS_TL`: the translated title and description of each document.
*   `FND_DOCUMENT_DATATYPES_VL`, `FND_DOCUMENT_CATEGORIES_VL`, `FND_DOCUMENT_ENTITIES_VL`: datatype, category and entity names.
*   `FND_LOBS`: the stored file content and file name for file attachments.
*   `FND_DOCUMENTS_SHORT_TEXT`, `FND_DOCUMENTS_LONG_TEXT`: the inline text of short and long text attachments.
*   `FND_DM_NODES`: the document management node for the storage location.
*   `PO_HEADERS_ALL`, `PO_RELEASES_ALL`, `PO_LINES_ALL`, `PO_LINE_LOCATIONS_ALL`, `PO_REQUISITION_HEADERS_ALL`, `PO_REQUISITION_LINES_ALL`: purchasing entities.
*   `OE_ORDER_HEADERS_ALL`, `OE_ORDER_LINES_ALL`, `WSH_DELIVERY_DETAILS`: order management and shipping entities.
*   `AP_INVOICES_ALL`, `RA_CUSTOMER_TRX_ALL`, `RA_CUSTOMER_TRX_LINES_ALL`, `PA_PROJECTS_ALL`: payables, receivables and projects entities.
*   `HR_ALL_ORGANIZATION_UNITS_VL`, `GL_LEDGERS`, `MO_GLOB_ORG_ACCESS_TMP`: operating unit and ledger names, and the security list.

#### Logical Relationships
1. `FND_DOCUMENTS` is joined to `FND_DOCUMENTS_TL` on document identifier, filtered to the session language.
2. `FND_ATTACHED_DOCUMENTS` is joined to `FND_DOCUMENTS` on document identifier, and limited to the fifteen supported entity names.
3. A `CASE` expression on the entity name returns the operating unit of the attached record, and the result is joined to `HR_ALL_ORGANIZATION_UNITS_VL`.
4. The operating unit is checked against `MO_GLOB_ORG_ACCESS_TMP`, so only permitted units are returned.
5. The entity name is matched to `FND_DOCUMENT_ENTITIES_VL`, and the datatype selects short text, long text, file or URL content.

### Parameters & Filtering
*   **Operating Unit:** Restricts the output to one operating unit within the accessible set.
*   **Sales Order Number, PO Number, Requisition Number:** Return the header and line attachments of one document. Their lists show only documents that have attachments the report can return.
*   **Document Entity, Category, Datatype:** Filter on the entity the attachment belongs to, its category and its type of content.
*   **File Name contains, Short Text contains, Text contains:** Search the file name and the inline text.
*   **Creation Date from/to, Created within days, Created By:** Filter on when and by whom the attachment was created.

### Performance & Optimization
*   Operating unit security is applied as an `IN` subquery on `MO_GLOB_ORG_ACCESS_TMP`, so the report reads only the units the responsibility can access.
*   The attachment list is restricted to the fifteen supported entity names before the operating unit lookups, which keeps the per-entity subqueries small.
*   Download links are generated per row, and they expire after the time set in the FND: Security File Download Time Limit profile option, so the report must be re-run to refresh them.

### FAQ
**Q: Why are items, work orders or journals missing from this report?**
A: The report covers operating unit striped entities only. The description directs users to the FND Attached Documents report for attachments on entities such as items and journals.

**Q: Why does a download link stop working?**
A: The secure file download link expires after the number of minutes set in the FND: Security File Download Time Limit profile option; re-running the report creates fresh links.

**Q: Which purchasing documents can carry attachments in this report?**
A: Purchase order headers, releases, lines and shipments, and requisition headers and lines are all supported, with the purchase order number, release and line shown in the reference column.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-attached-documents-operating-unit-secured)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
