---
layout: default
last_modified_at: 2026-10-16
title: 'QP GSA Pricing Upload | Oracle EBS SQL Report'
description: 'This upload supports the creation and update of GSA Pricing Setup in Oracle Advanced Pricing. The upload supports creation/update/deletion of the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, GSA, Pricing, qp_secu_list_headers_vl, qp_qualifiers_v, qp_modifier_summary_v'
permalink: /QP%20GSA%20Pricing%20Upload/
report_name: 'QP GSA Pricing Upload'
report_web_name: qp-gsa-pricing-upload
---

# QP GSA Pricing Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/qp-gsa-pricing-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-gsa-pricing-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-gsa-pricing-upload).

## Overview
This upload supports the creation and update of GSA Pricing Setup in Oracle Advanced Pricing.

The upload supports creation/update/deletion of the following entities within a GSA Pricing List:

- GSA Lists (created as a Modifier List)
- GSA List Qualifiers (created as a Modifier List Qualifier)
- GSA List Lines (created as Modifier Lines)

Notes:

When downloading existing GSA Lists into the upload excel; the List level Qualifiers and the List Lines will be downloaded into separate rows in the excel. This is to minimize the duplication of data in the excel.  

However:
When entering List Header qualifiers, these can be added in the same excel row as the List Lines (i.e. You can upload an excel row containing list line details and a list header qualifier). 

Modifier Line Numbering
====================
The Modifier Numbering report parameter determines if you want the system to automatically generate Modifier Numbers when creating new GSA List Lines or if the line number specified in the Line No column in the upload should be retained. If Automatic is specified, any Line Numbers specified in the upload excel for new GSA List Lines will be replaced by a system generated line number on upload.
The Line No column is required when entering list line details. The upload uses the combination of List Number, List Version, and Line No to identify the GSA List Line. If the combination already exists in Oracle the upload will update the existing GSA List Line, otherwise it will create a new GSA List Line.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-gsa-pricing-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, End Date Matching Modifiers?, Modifier Numbering, List Number, List Number Like, List Name, List Name Like, Version Number, Global List, Operating Unit, Product Value (Item), Item Category Set, Item Category, Effective Date, Download Modifier Lines, Download List Qualifiers

## Oracle EBS Tables Used
[qp_secu_list_headers_vl](https://www.enginatics.com/library/?pg=1&find=qp_secu_list_headers_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-gsa-pricing-upload), [qp_qualifiers_v](https://www.enginatics.com/library/?pg=1&find=qp_qualifiers_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-gsa-pricing-upload), [qp_modifier_summary_v](https://www.enginatics.com/library/?pg=1&find=qp_modifier_summary_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-gsa-pricing-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-gsa-pricing-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-gsa-pricing-upload)

## Related Reports
[QP Modifier Upload](/QP%20Modifier%20Upload/ "QP Modifier Upload Oracle EBS SQL Report"), [QP Modifier Details](/QP%20Modifier%20Details/ "QP Modifier Details Oracle EBS SQL Report"), [QP Customer Pricing Engine Request](/QP%20Customer%20Pricing%20Engine%20Request/ "QP Customer Pricing Engine Request Oracle EBS SQL Report"), [QP Price List Upload](/QP%20Price%20List%20Upload/ "QP Price List Upload Oracle EBS SQL Report"), [ONT Order Upload](/ONT%20Order%20Upload/ "ONT Order Upload Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [QP Pricing Agreements](/QP%20Pricing%20Agreements/ "QP Pricing Agreements Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QP%20GSA%20Pricing%20Upload/QP%20GSA%20Pricing%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-gsa-pricing-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/qp-gsa-pricing-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-gsa-pricing-upload) |
| Blitz Report™ XML Import | [QP_GSA_Pricing_Upload.xml](https://www.enginatics.com/xml/qp-gsa-pricing-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-gsa-pricing-upload) |
| SQL Source | [QP GSA Pricing Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/QP%20GSA%20Pricing%20Upload/QP%20GSA%20Pricing%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/qp-gsa-pricing-upload/](https://www.enginatics.com/reports/qp-gsa-pricing-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-gsa-pricing-upload) |

## Case Study & Technical Analysis: QP GSA Pricing Upload

### Executive Summary
This upload creates, updates and deletes GSA pricing setups in Oracle Advanced Pricing. GSA lists are stored as modifier lists, and the upload maintains their list headers, list qualifiers and list lines. It is used by pricing administrators for U.S. government contracts, where the General Services Administration schedule prices must be loaded and revised for each operating unit and product set. The template runs in Excel through Blitz Report, and it covers the same entities as the Oracle pricing forms in one spreadsheet.

### Business Challenge
*   **Schedule maintenance:** GSA price schedules change often, and each line must be updated against the current contract.
*   **Qualifier complexity:** A GSA list is restricted by qualifiers such as product category or item, and the qualifiers must be kept consistent with the lines.
*   **Line numbering:** New lines must receive numbers that do not clash with existing lines of the same list.
*   **Effective dating:** Lists and lines have effective dates and must be ended or renewed without losing their history.

### The Solution
*   **Three entities:** GSA lists, their list-level qualifiers and their list lines can each be created, updated or deleted in one file.
*   **Qualifiers on the list row:** A list header qualifier can be entered on the same row as a list line.
*   **Identification by key:** The list number, list version and line number together identify a list line, so an existing line is updated and a new key creates a line.
*   **Automatic numbering:** The Modifier Numbering parameter can replace uploaded line numbers with system-generated numbers.
*   **Effective dates:** List start and end dates and line effective dates are carried on each row.

### Technical Architecture (High Level)
#### Primary Tables
*   `QP_SECU_LIST_HEADERS_VL`: the modifier list headers, including the GSA indicator, list type, currency and effective dates.
*   `QP_MODIFIER_SUMMARY_V`: the modifier lines of each list, with the line identifiers and pricing attribute context.
*   `QP_QUALIFIERS_V`: the qualifiers attached to a list header or a list line.
*   `QP_UTIL` and `MO_GLOBAL` functions: the operating unit name of each list and the access check on its operating unit.
*   `MTL_CATEGORY_SETS_VL`, `MTL_ITEM_CATEGORIES` and `MTL_CATEGORIES_KFV`: the item category restrictions, when an item category is used as a qualifier.

#### Logical Relationships
1. `QP_SECU_LIST_HEADERS_VL` joins to `QP_MODIFIER_SUMMARY_V` on list header id, so each list row carries its lines.
2. `QP_QUALIFIERS_V` supplies the list level qualifiers, which are downloaded on their own rows rather than repeated on each line.
3. Each modifier line row is limited to the pricing attribute contexts of volume or none, and to lines that are not excluders.
4. Lists are restricted to GSA lists by the GSA indicator, with the list type of discount list and an active flag, when GSA pricing is on.
5. The upload action is compared with update to decide whether the existing modifier rows are included in the download.

### Parameters & Filtering
*   **Upload Mode:** selects Create, or Create, Update to download existing GSA lists.
*   **End Date Matching Modifiers and Modifier Numbering:** control end dating of matching modifiers, and whether line numbers are generated by the system.
*   **List Number, List Number Like, List Name and List Name Like:** select one list or a pattern of lists.
*   **Version Number:** selects one version of a list.
*   **Global List:** restricts the lists to global or operating-unit lists.
*   **Operating Unit:** restricts the lists to one operating unit.
*   **Product Value, Item Category Set and Item Category:** restrict the lines to one product or item category.
*   **Effective Date:** tests the lists and lines as at this date.
*   **Download Modifier Lines and Download List Qualifiers:** control which parts of each list are included in the download.

### Performance & Optimization
*   The list header is restricted by its status, source system and GSA indicator before the modifier line join, so the summary view is read only for the lists that qualify.
*   The organization check uses the global flag or the access check on the list's operating unit, so lists the user cannot access are excluded early.
*   The modifier summary is restricted to volume and non-pricing contexts and excludes excluder rows, which removes rows that are not GSA price lines.

### FAQ
**Q: How does the upload decide whether to update or create a GSA line?**
A: It uses the list number, list version and line number. An existing combination is updated, and a new combination creates a new line.

**Q: Where do list qualifiers go in the spreadsheet?**
A: They are downloaded on their own rows. A list header qualifier can be entered on the same row as a list line when uploading.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-gsa-pricing-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-gsa-pricing-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-gsa-pricing-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-gsa-pricing-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-gsa-pricing-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-gsa-pricing-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=qp-gsa-pricing-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
