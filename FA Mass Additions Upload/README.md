---
layout: default
last_modified_at: 2026-10-19
title: 'FA Mass Additions Upload | Oracle EBS SQL Report'
description: 'Maintains Oracle Assets Prepare Mass Additions queue lines. Use the Operation column to choose what each row does: Update (change fields and/or Queue)…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Mass, Additions, fa_lookups, fa_categories_b_kfv, gl_code_combinations_kfv'
permalink: /FA%20Mass%20Additions%20Upload/
report_name: 'FA Mass Additions Upload'
report_web_name: fa-mass-additions-upload
---

# FA Mass Additions Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-mass-additions-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload).

## Overview
Maintains Oracle Assets Prepare Mass Additions queue lines.

Use the Operation column to choose what each row does: Update (change fields and/or Queue), Create (add a new mass addition line), Merge, Split, Unsplit, Add to Asset or Undo Add to Asset.

Queue (Post, On Hold, Delete, On-Review) sets the posting status of the line on an Update.

Merge combines the lines that share a Merge Group label into the one row marked Primary Line = Yes; that line is kept as the asset and accumulates the cost of the other lines (and their units when Sum Units = Yes), and is set to On Hold.

The Attribute columns are the asset descriptive flexfield. Its context is the asset category, as in Oracle Assets, so the context column follows Category and only the attributes of that category can be entered.

After uploading, run the standard Post Mass Additions program to create the assets, exactly as today. Existing lines are matched on Book plus Invoice Number, Distribution Line and Invoice Line.

Supplier, PO Number, Project, Task, Creation Date and Created By show the source of a line and are not uploaded.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Book, Queue, Invoice Date From, Invoice Date To, Creation Date From, Creation Date To, Supplier

## Oracle EBS Tables Used
[fa_lookups](https://www.enginatics.com/library/?pg=1&find=fa_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload), [fa_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=fa_categories_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload), [fa_locations_kfv](https://www.enginatics.com/library/?pg=1&find=fa_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload), [fa_additions_b](https://www.enginatics.com/library/?pg=1&find=fa_additions_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload), [fnd_descr_flex_contexts_vl](https://www.enginatics.com/library/?pg=1&find=fnd_descr_flex_contexts_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload), [fa_mass_additions](https://www.enginatics.com/library/?pg=1&find=fa_mass_additions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload)

## Related Reports
[FA Mass Additions Upload 11i](/FA%20Mass%20Additions%20Upload%2011i/ "FA Mass Additions Upload 11i Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis 11g](/GL%20Account%20Analysis%2011g/ "GL Account Analysis 11g Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Analysis (Drilldown)](/GL%20Account%20Analysis%20%28Drilldown%29/ "GL Account Analysis (Drilldown) Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [PA Project Asset Upload](/PA%20Project%20Asset%20Upload/ "PA Project Asset Upload Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FA%20Mass%20Additions%20Upload/FA%20Mass%20Additions%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/fa-mass-additions-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload) |
| Blitz Report™ XML Import | [FA_Mass_Additions_Upload.xml](https://www.enginatics.com/xml/fa-mass-additions-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload) |
| SQL Source | [FA Mass Additions Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FA%20Mass%20Additions%20Upload/FA%20Mass%20Additions%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fa-mass-additions-upload/](https://www.enginatics.com/reports/fa-mass-additions-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload) |

## Case Study & Technical Analysis: FA Mass Additions Upload

### Executive Summary
This upload maintains the Oracle Assets Prepare Mass Additions queue, the staging lines from which Oracle Assets creates new asset records. Fixed asset accountants use it to correct, group, split, post or hold many mass addition lines in one spreadsheet before the standard Post Mass Additions program creates the assets. The file is worked in Excel through Blitz Report™, and the source of each line is shown read-only.

### Business Challenge
*   **Queue clean-up:** Invoice lines that flow into the mass additions queue often need the category, location, asset number, tag or depreciation settings corrected before they become assets.
*   **Grouping of cost:** Several invoice lines that belong to one physical asset must be merged into one asset line, and their cost and units combined.
*   **Splitting cost:** A single invoice line sometimes has to be split into several assets, and the operations must be recorded consistently.
*   **Posting control:** Lines must be placed on hold, released for posting or deleted in bulk, so that only reviewed lines create assets.

### The Solution
*   Downloads the queue lines of a book that are not yet posted, merged or split, with their operation, queue status, cost, units, category and location.
*   Lets each row perform one operation: Update, Create, Merge, Split, Unsplit, Add to Asset or Undo Add to Asset.
*   Combines the lines that share a Merge Group label into the one row marked Primary Line, which carries the accumulated cost and, when Sum Units is Yes, the accumulated units, and is set to On Hold.
*   Uses the asset descriptive flexfield with the context of the asset category, so only the attributes of that category can be entered.

### Technical Architecture (High Level)
#### Primary Tables
*   `FA_MASS_ADDITIONS`: the mass addition queue lines, with book, invoice, distribution and invoice line references, cost, units, posting status and the descriptive flexfield columns.
*   `FA_CATEGORIES_B_KFV`: the asset categories and their concatenated segments.
*   `FA_LOCATIONS_KFV`: the asset locations.
*   `GL_CODE_COMBINATIONS_KFV`: the expense account of each line.
*   `FA_ADDITIONS_B`: the existing asset that a line is added to.
*   `FA_LOOKUPS`: the queue name, asset type and Yes/No meanings.
*   `FND_DESCR_FLEX_CONTEXTS_VL`: the asset descriptive flexfield contexts, used when the category context is missing.
*   `PER_ALL_PEOPLE_F`: the employee to whom the asset is assigned.
*   `AP_SUPPLIERS`, `PA_PROJECTS_ALL` and `PA_TASKS`: the supplier, project and task that are shown as the source of each line.

#### Logical Relationships
1.  The base set is `FA_MASS_ADDITIONS` lines whose posting status is not POSTED, MERGED or SPLIT.
2.  Category, location, expense account and assigned employee are each resolved by a lookup on their identifier, the employee only where the person is effective on the current date.
3.  The queue and asset type meanings come from `FA_LOOKUPS`.
4.  The supplier is found from the purchase order vendor identifier, and the project and task from their identifiers on the line.
5.  Each attribute column is resolved with the flexfield value display function under the asset descriptive flexfield, identified by application 140.
6.  Lines are identified for upload by book, invoice number, distribution line and invoice line, which are the keys the upload matches on.

### Parameters & Filtering
*   **Upload Mode:** selects whether the file is used to update existing lines or to create new ones.
*   **Book:** the asset book whose queue is maintained.
*   **Queue:** the queue action (Post, On Hold, Delete or On-Review) that is set on the lines when an Update is uploaded.
*   **Invoice Date From** and **Invoice Date To:** restrict the lines by invoice date.
*   **Creation Date From** and **Creation Date To:** restrict the lines by the date they were created in the queue.
*   **Supplier:** limits the lines to those from one supplier.

### Performance & Optimization
*   The base filter on posting status keeps posted, merged and split lines out of the queue before any lookups are performed.
*   Category, expense account, location and employee are resolved by scalar subqueries, one lookup per line for each of them.
*   Attribute value display is performed per attribute column, so limiting the selection to one book and one queue keeps the number of flexfield resolutions small.
*   Merge, split and add-to-asset are applied when the file is uploaded, not when it is downloaded.

### FAQ
**Q: What happens after the mass additions are uploaded?**
A: Run the standard Post Mass Additions program as before, which creates the assets from the lines that are in the queue for posting.

**Q: How are lines merged into one asset?**
A: Lines that share a Merge Group label are combined into the row marked Primary Line = Yes, which keeps the asset, accumulates the cost of the other lines and is set to On Hold.

**Q: Are supplier and purchase order details uploaded?**
A: No, Supplier, PO Number, Project, Task, Creation Date and Created By show the source of each line and are not uploaded.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
