---
layout: default
last_modified_at: 2026-10-26
title: 'FA Mass Additions Upload 11i | Oracle EBS SQL Report'
description: 'Maintains Oracle Assets Prepare Mass Additions queue lines. Use the Operation column to choose what each row does: Update (change fields and/or Queue)…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Mass, Additions, 11i, fa_lookups, fa_categories_b_kfv, gl_code_combinations_kfv'
permalink: /FA%20Mass%20Additions%20Upload%2011i/
report_name: 'FA Mass Additions Upload 11i'
report_web_name: fa-mass-additions-upload-11i
---

# FA Mass Additions Upload 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-mass-additions-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i).

## Overview
Maintains Oracle Assets Prepare Mass Additions queue lines.

Use the Operation column to choose what each row does: Update (change fields and/or Queue), Create (add a new mass addition line), Merge, Split, Unsplit, Add to Asset or Undo Add to Asset.

Queue (Post, On Hold, Delete, On-Review) sets the posting status of the line on an Update.

Merge combines the lines that share a Merge Group label into the one row marked Primary Line = Yes; that line is kept as the asset and accumulates the cost of the other lines (and their units when Sum Units = Yes), and is set to On Hold.

The Attribute columns are the asset descriptive flexfield. Its context is the asset category, as in Oracle Assets, so the context column follows Category and only the attributes of that category can be entered.

After uploading, run the standard Post Mass Additions program to create the assets, exactly as today. Existing lines are matched on Book plus Invoice Number, Distribution Line and Invoice Line.

Supplier, PO Number, Project, Task, Creation Date and Created By show the source of a line and are not uploaded.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Book, Queue, Invoice Date From, Invoice Date To, Creation Date From, Creation Date To, Supplier

## Oracle EBS Tables Used
[fa_lookups](https://www.enginatics.com/library/?pg=1&find=fa_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i), [fa_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=fa_categories_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i), [fa_locations_kfv](https://www.enginatics.com/library/?pg=1&find=fa_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i), [fa_additions_b](https://www.enginatics.com/library/?pg=1&find=fa_additions_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i), [fnd_descr_flex_contexts_vl](https://www.enginatics.com/library/?pg=1&find=fnd_descr_flex_contexts_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i), [fa_mass_additions](https://www.enginatics.com/library/?pg=1&find=fa_mass_additions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i)

## Related Reports
[FA Mass Additions Upload](/FA%20Mass%20Additions%20Upload/ "FA Mass Additions Upload Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis 11g](/GL%20Account%20Analysis%2011g/ "GL Account Analysis 11g Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Analysis (Drilldown)](/GL%20Account%20Analysis%20%28Drilldown%29/ "GL Account Analysis (Drilldown) Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [PA Project Asset Upload](/PA%20Project%20Asset%20Upload/ "PA Project Asset Upload Oracle EBS SQL Report"), [FA Asset Register](/FA%20Asset%20Register/ "FA Asset Register Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FA%20Mass%20Additions%20Upload%2011i/FA%20Mass%20Additions%20Upload%2011i.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/fa-mass-additions-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i) |
| Blitz Report™ XML Import | [FA_Mass_Additions_Upload_11i.xml](https://www.enginatics.com/xml/fa-mass-additions-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i) |
| SQL Source | [FA Mass Additions Upload 11i.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FA%20Mass%20Additions%20Upload%2011i/FA%20Mass%20Additions%20Upload%2011i.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fa-mass-additions-upload-11i/](https://www.enginatics.com/reports/fa-mass-additions-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i) |

## Case Study & Technical Analysis: FA Mass Additions Upload 11i

### Executive Summary
The FA Mass Additions Upload 11i is an Excel upload that maintains the Oracle Assets Prepare Mass Additions queue. It lets an accountant update, create, merge, split, add to an existing asset or undo an add to asset for each queued line, and set the posting status of the line. Asset accountants use it to correct the cost, location, category or descriptive flexfield of invoice-based additions before they are posted, and to combine several invoice lines into one asset. After the upload, the standard Post Mass Additions program creates the assets as before. Blitz Report downloads the queue lines of the selected book, and the upload writes the changes back to the mass additions table.

### Business Challenge
*   **Queue correction:** Invoice lines that reach the mass additions queue often carry the wrong category, location, employee or cost, and correcting them one at a time is slow.
*   **Asset consolidation:** Several invoice lines for one physical asset must be merged into a single asset with the cost accumulated, and the merged lines held so they are not posted twice.
*   **Descriptive data:** Asset attributes must be entered in the context of the asset category, so each category needs its own set of values.
*   **Traceability:** Each queue line must stay linked to its invoice, distribution and supplier.

### The Solution
*   Downloads the queued mass additions for the selected book, with invoice number, distribution line, queue, cost, units, category, location and employee.
*   Uses an Operation column so each row can update, create, merge, split, unsplit, add to asset or undo an add to asset.
*   Merges the lines that share a Merge Group label into the row marked Primary Line = Yes, which accumulates the cost and is set to On Hold.
*   Sets the Queue column to Post, On Hold, Delete or On-Review on an update, and shows the asset descriptive flexfield values in the context of the category.

### Technical Architecture (High Level)
#### Primary Tables
*   `FA_MASS_ADDITIONS`: the queue lines, with the book, invoice data, posting status and asset values.
*   `FA_ADDITIONS_B`: the asset master, used to find the asset number of an asset that a line is added to.
*   `FA_CATEGORIES_B_KFV` and `FND_DESCR_FLEX_CONTEXTS_VL`: the asset category and the descriptive flexfield context that the category defines.
*   `GL_CODE_COMBINATIONS_KFV`, `FA_LOCATIONS_KFV` and `PER_ALL_PEOPLE_F`: the expense account, location and assigned employee.
*   `PO_VENDORS`, `PA_PROJECTS_ALL` and `PA_TASKS`: the source supplier, project and task, which are shown and not uploaded.
*   `FA_LOOKUPS`: the queue, asset type and yes/no labels.

#### Logical Relationships
1.  Each line is read from `FA_MASS_ADDITIONS` and filtered to posting statuses other than POSTED, MERGED and SPLIT.
2.  The category joins to the descriptive flexfield context, and the attribute columns are decoded through the flexfield value function using the category as context.
3.  The expense account, location and employee are scalar lookups on their code combination, location and person ids, with the employee valid on the current date.
4.  The supplier comes from `PO_VENDORS`, and the project and task from `PA_PROJECTS_ALL` and `PA_TASKS`, on their ids.
5.  The add to asset number is a lookup of `FA_ADDITIONS_B` on the asset id the line references.

### Parameters & Filtering
*   **Upload Mode:** selects the rows to download for update, create or both.
*   **Book** and **Queue:** select the asset book and the queue status of the lines.
*   **Invoice Date From** and **Invoice Date To:** bound the invoice dates of the lines.
*   **Creation Date From** and **Creation Date To:** bound the dates on which the lines were created.
*   **Supplier:** limits the lines to one supplier.

### Performance & Optimization
*   Every lookup in the select list is a scalar subquery on a primary key, so each mass addition line reads one row per lookup.
*   The posting status filter removes lines already posted, merged or split before any lookup runs.
*   The employee subquery is limited to the current date through the effective dates, so each assignment resolves to one person row.
*   Restricting Book and Queue keeps the number of lines small, since the attribute decoding runs for every row.

### FAQ
**Q: How do I merge two mass addition lines into one asset?**
A: Give both lines the same Merge Group label, mark one of them Primary Line = Yes, and upload. The primary line accumulates the cost of the others and is set to On Hold.

**Q: Do I need to run a standard program after the upload?**
A: Yes. Run the standard Post Mass Additions program to create the assets, as before.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-mass-additions-upload-11i)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
