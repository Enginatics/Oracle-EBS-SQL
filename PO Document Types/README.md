---
layout: default
last_modified_at: 2026-10-26
title: 'PO Document Types | Oracle EBS SQL Report'
description: 'PO document types setup – Oracle EBS Purchasing SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Purchasing, Enginatics, Document, Types, hr_all_organization_units_vl, po_document_types_all_vl, fnd_lookup_values'
permalink: /PO%20Document%20Types/
report_name: 'PO Document Types'
report_web_name: po-document-types
module: 'Purchasing'
module_url: /modules/purchasing/
---

# PO Document Types – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/po-document-types/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-document-types) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-document-types).
**Oracle EBS module:** [Purchasing](/modules/purchasing/ "Oracle EBS Purchasing reports") · [all Purchasing reports](/modules/purchasing/)  

## Overview
PO document types setup

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-document-types) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-document-types), [po_document_types_all_vl](https://www.enginatics.com/library/?pg=1&find=po_document_types_all_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-document-types), [fnd_lookup_values](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-document-types), [xdo_templates_vl](https://www.enginatics.com/library/?pg=1&find=xdo_templates_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-document-types)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-document-types)

## Related Reports
[AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Document%20Types/PO%20Document%20Types.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-document-types) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PO Document Types 24-Jul-2017 150359.xlsx](https://www.enginatics.com/example/po-document-types/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-document-types) |
| Blitz Report™ XML Import | [PO_Document_Types.xml](https://www.enginatics.com/xml/po-document-types/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-document-types) |
| SQL Source | [PO Document Types.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Document%20Types/PO%20Document%20Types.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/po-document-types/](https://www.enginatics.com/reports/po-document-types/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-document-types) |

## Case Study & Technical Analysis: PO Document Types Report

### Executive Summary

The PO Document Types report is a crucial configuration and audit tool for Oracle Purchasing. It provides a comprehensive listing of all defined purchasing document types (e.g., Standard Purchase Order, Blanket Purchase Agreement, Requisition), along with their key attributes and associated controls. This report is indispensable for procurement administrators, system configurators, and auditors to manage the foundational setup that governs the entire procure-to-pay process, ensuring consistency, compliance, and efficient document processing.

### Business Challenge

Oracle Purchasing offers significant flexibility in defining various document types to cater to different procurement needs. However, managing and auditing these definitions can be challenging:

-   **Configuration Complexity:** Each document type has numerous associated controls, such as numbering sequences, approval workflows, encumbrance settings, and security attributes. Understanding the complete setup for each type requires navigating through multiple forms in the application.
-   **Ensuring Consistent Processes:** Inconsistent document type configurations can lead to variations in procurement processes, causing confusion for buyers, delays in approvals, and discrepancies in financial reporting.
-   **Auditing Controls and Compliance:** Regularly auditing document type setups is critical to ensure that internal controls (e.g., matching rules, encumbrance flags) are correctly enforced and that procurement processes comply with financial regulations and company policy.
-   **Troubleshooting Document Behavior:** When a purchasing document behaves unexpectedly (e.g., does not route for approval correctly or is not encumbered), the root cause often lies in its document type setup. Diagnosing these issues requires precise information on the active configurations.

### The Solution

This report offers a consolidated, detailed, and easily auditable view of PO document type configurations, transforming how procurement teams manage their purchasing infrastructure.

-   **Centralized Setup Overview:** It presents a detailed list of all purchasing document types, including their names, descriptions, and critical control attributes. This provides a clear, at-a-glance understanding of how each document type is defined.
-   **Simplified Configuration Audit:** Procurement administrators and auditors can use this report to quickly review and verify document type setups, ensuring they are correctly configured and align with internal control requirements and purchasing policies.
-   **Accelerated Troubleshooting:** When a purchasing document issue arises, this report provides immediate insight into the active document type settings, helping to quickly pinpoint and resolve misconfigurations that cause operational problems.
-   **Enhanced Governance and Documentation:** By providing transparent documentation of document type setups, the report strengthens financial governance and makes it easier to demonstrate compliance during internal and external audits.

### Technical Architecture (High Level)

The report queries core Oracle Purchasing setup tables that define purchasing document types and their attributes.

-   **Primary Tables Involved:**
    -   `po_document_types_all_vl` (the central view for purchasing document type definitions, including names, descriptions, and various control flags).
    -   `fnd_lookup_values` (for translating various lookup codes into user-friendly descriptions, enhancing report readability).
    -   `hr_all_organization_units_vl` (for operating unit context, as document types can be specific to an OU).
    -   `xdo_templates_vl` (if specific XML publisher templates are associated with document types).
-   **Logical Relationships:** The report selects document type definitions from `po_document_types_all_vl`. It then joins to `fnd_lookup_values` to decode various status flags or options into human-readable text, providing a comprehensive and understandable view of each document type's configuration for the specified operating unit.

### Parameters & Filtering

The report offers a simple, yet effective, parameter for targeted analysis:

-   **Operating Unit:** Allows users to filter the report to a specific business unit. If left blank, it typically displays document types accessible across all operating units for which the user has access.

### Performance & Optimization

As a configuration report, it is optimized for efficient retrieval of setup data.

-   **Low Data Volume:** The underlying tables (`po_document_types_all_vl`) contain configuration data, which is typically a much smaller volume than transactional data, ensuring fast query execution.
-   **Indexed Lookups:** The queries leverage standard Oracle indexes on `document_type_code` and `org_id` for efficient data retrieval.

### FAQ

**1. What is a 'Purchasing Document Type' and why is it important?**
   A 'Purchasing Document Type' defines the characteristics and controls for different types of purchasing documents in Oracle EBS, such as purchase requisitions, standard purchase orders, blanket purchase agreements, and releases. It dictates critical aspects like numbering, approval workflows, encumbrance behavior, and matching rules, thereby shaping the entire procure-to-pay process.

**2. Can this report show which approval workflow is associated with each document type?**
   While this report details many control attributes, the specific approval workflow (if using Oracle Workflow) is often defined through different setup screens and stored in separate workflow-related tables. This report provides the foundational document type details, but might need to be joined with workflow-specific reports for a complete picture of approval processes.

**3. How does the 'Operating Unit' parameter affect the output?**
   Purchasing document types can be global (available to all operating units) or specific to a particular operating unit. Filtering by `Operating Unit` will restrict the report to only show the document types that are either global or specifically defined for that selected operating unit, ensuring contextually relevant results.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-document-types)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-document-types)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-document-types)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-document-types)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-document-types)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-document-types)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-document-types)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
