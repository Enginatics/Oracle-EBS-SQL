---
layout: default
title: 'FND Document Categories | Oracle EBS SQL Report'
description: 'Document categories used by document sequence assignments. – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Document, Categories, fnd_application_vl, fnd_doc_sequence_categories'
permalink: /FND%20Document%20Categories/
---

# FND Document Categories – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-document-categories/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Document categories used by document sequence assignments.

## Report Parameters
Application

## Oracle EBS Tables Used
[fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_doc_sequence_categories](https://www.enginatics.com/library/?pg=1&find=fnd_doc_sequence_categories)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[GL Account Analysis 11g](/GL%20Account%20Analysis%2011g/ "GL Account Analysis 11g Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [PO Approved Supplier List Upload](/PO%20Approved%20Supplier%20List%20Upload/ "PO Approved Supplier List Upload Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Document Categories 24-May-2025 134602.xlsx](https://www.enginatics.com/example/fnd-document-categories/) |
| Blitz Report™ XML Import | [FND_Document_Categories.xml](https://www.enginatics.com/xml/fnd-document-categories/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-document-categories/](https://www.enginatics.com/reports/fnd-document-categories/) |

## Executive Summary
The **FND Document Categories** report lists the categories used to classify documents for sequential numbering. In Oracle EBS, a "Category" is the logical bucket that gets assigned a specific sequence.

## Business Challenge
*   **Voucher Numbering:** Verifying that all necessary document types (Invoices, Journals, Payments) have a category defined for sequential numbering.
*   **Audit Compliance:** Ensuring that document categories align with legal reporting requirements (e.g., VAT registers).

## The Solution
This Blitz Report lists the defined categories:
*   **Category Name:** The internal code and user-friendly name.
*   **Table Name:** The table associated with the category (e.g., `AP_INVOICES_ALL`).
*   **Description:** The purpose of the category.

## Technical Architecture
The report queries `FND_DOC_SEQUENCE_CATEGORIES`.

## Parameters & Filtering
*   **Application:** Filter by module (e.g., "Payables", "General Ledger").

## Performance & Optimization
*   **Simple List:** This is a lightweight configuration report.

## FAQ
*   **Q: How do I assign a sequence to a category?**
    *   A: Use the "FND Document Sequence Assignments" report to see the linkage between Categories, Ledgers, and Sequences.


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
