---
layout: default
last_modified_at: 2026-10-19
title: 'FND Responsibility Upload | Oracle EBS SQL Report'
description: 'Create and update Oracle E-Business Suite responsibilities, and maintain their menu/function exclusions, replicating the System Administrator…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, FND, Responsibility, fnd_responsibility, fnd_responsibility_tl, fnd_application_vl'
permalink: /FND%20Responsibility%20Upload/
report_name: 'FND Responsibility Upload'
report_web_name: fnd-responsibility-upload
---

# FND Responsibility Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-responsibility-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload).

## Overview
Create and update Oracle E-Business Suite responsibilities, and maintain their menu/function exclusions, replicating the System Administrator Responsibilities form (FNDSCRSP).

Each row is one of two entity types, chosen in the Row Type column:

- Responsibility: creates or updates the responsibility definition (Name, Application, Key, Description, Effective Dates, Available From, Data Group, Menu, Request Group, Web Host/Agent Name). Responsibilities are identified by Application + Responsibility Key. A responsibility is created when that combination does not yet exist, otherwise it is updated. The Responsibility Key is the stable identifier and is not editable once created - to rename a responsibility change its Name, not its Key.

- Menu/Function Exclusion: adds (or, with Exclude = Yes, removes) a menu or function exclusion for the responsibility identified by Application + Responsibility Key. Exclusion Type selects Function or Menu; Exclusion Name selects the item to exclude. When adding a new responsibility and its exclusions in the same upload, place the Responsibility row before its exclusion rows.

Upload Modes:
- Create opens an empty template.
- Create, Update downloads existing responsibilities (and their exclusions) matching the Application / Responsibility filters for review and update.

Responsibilities are not deleted by this upload; set an Effective Date To to disable one, matching Oracle best practice.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Application, Responsibility Name

## Oracle EBS Tables Used
[fnd_responsibility](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload), [fnd_responsibility_tl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload), [fnd_data_groups_standard_view](https://www.enginatics.com/library/?pg=1&find=fnd_data_groups_standard_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload), [fnd_menus_vl](https://www.enginatics.com/library/?pg=1&find=fnd_menus_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload), [fnd_request_groups](https://www.enginatics.com/library/?pg=1&find=fnd_request_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload), [fnd_form_functions_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_functions_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload), [fnd_resp_functions](https://www.enginatics.com/library/?pg=1&find=fnd_resp_functions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload)

## Related Reports
[FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [Blitz Report Template Sharing](/Blitz%20Report%20Template%20Sharing/ "Blitz Report Template Sharing Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [FND Responsibilities](/FND%20Responsibilities/ "FND Responsibilities Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Responsibility%20Upload/FND%20Responsibility%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/fnd-responsibility-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload) |
| Blitz Report™ XML Import | [FND_Responsibility_Upload.xml](https://www.enginatics.com/xml/fnd-responsibility-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload) |
| SQL Source | [FND Responsibility Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Responsibility%20Upload/FND%20Responsibility%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-responsibility-upload/](https://www.enginatics.com/reports/fnd-responsibility-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload) |

## Case Study & Technical Analysis: FND Responsibility Upload

### Executive Summary
The FND Responsibility Upload report creates and updates Oracle E-Business Suite responsibilities, and maintains their menu and function exclusions. It replicates the System Administrator Responsibilities form (FNDSCRSP) in a spreadsheet. System administrators and security administrators use it when a new responsibility must be set up for many users or applications, when a responsibility's data group, menu or request group must change, or when exclusions must be applied. Because each row is either a responsibility definition or an exclusion, one file can carry an entire responsibility set-up, provided the rows are ordered correctly.

### Business Challenge
*   **Responsibility sprawl:** Large implementations need many responsibilities across applications, and defining each one in the form is slow and error-prone.
*   **Consistent access design:** Responsibilities must carry the right data group, menu, request group and effective dates, and a spreadsheet makes these attributes reviewable before they are loaded.
*   **Restricting menus and functions:** Exclusions remove functions or menus from a responsibility's menu, and many exclusions often apply across several responsibilities.
*   **Controlled retirement:** Responsibilities should not be deleted, since this affects audit history, so teams need a documented way to retire them.

### The Solution
*   **Two row types in one file:** Each row is either a Responsibility definition or a Menu/Function Exclusion, selected in the Row Type column.
*   **Create or update by key:** A responsibility is identified by application and responsibility key. It is created when that combination does not exist, and otherwise updated.
*   **Exclusion management:** Exclusion rows add a function or menu exclusion to a responsibility, and an Exclude flag removes one.
*   **Safe retirement:** Responsibilities are never deleted by the upload. Setting an Effective Date To disables a responsibility, which matches Oracle best practice.

### Technical Architecture (High Level)
#### Primary Tables
*   `FND_RESPONSIBILITY`: the responsibility definition, with its key, data group, menu, request group, dates and web host and agent names.
*   `FND_RESPONSIBILITY_TL`: the translated responsibility name and description, read in the session language.
*   `FND_APPLICATION_VL`: the owning application, used for the responsibility and for the data group and request group applications.
*   `FND_DATA_GROUPS_STANDARD_VIEW`: the data group assigned to the responsibility.
*   `FND_MENUS_VL`: the menu assigned to the responsibility, and the menu name used for menu exclusions.
*   `FND_REQUEST_GROUPS`: the request group assigned to the responsibility.
*   `FND_RESP_FUNCTIONS`: the exclusion rules for each responsibility, with rule type and action ID.
*   `FND_FORM_FUNCTIONS_VL`: the function name used for function exclusions.

#### Logical Relationships
1.  The Responsibility branch joins `FND_RESPONSIBILITY` to its translation, its application, its data group, its menu and its application for the data group.
2.  The request group is outer joined to `FND_REQUEST_GROUPS`, with its application outer joined to `FND_APPLICATION_VL`, so responsibilities without a request group still appear.
3.  The Exclusion branch joins `FND_RESP_FUNCTIONS` to the responsibility on application and responsibility ID, and to the responsibility's translation and application.
4.  The exclusion name is resolved by a CASE expression: a function name for function rules and a menu name for menu rules.
5.  The two branches are combined with UNION ALL, and a row number orders the output so that Responsibility rows come before their exclusion rows.

### Parameters & Filtering
*   **Upload Mode:** Create returns an empty template. Create, Update returns existing responsibilities and their exclusions for review.
*   **Application:** Restricts the responsibilities to one owning application.
*   **Responsibility Name:** Narrows the list to a responsibility by name.

### Performance & Optimization
*   **Language filter on translations:** Responsibility names and descriptions are read in the session language, which keeps one translation per responsibility.
*   **Outer joins for optional attributes:** Request groups and their applications are outer joined, so responsibilities without a request group are not removed.
*   **Scalar name resolution:** Exclusion names are resolved with scalar subqueries against the function and menu views, so each exclusion row reads one name.
*   **Ordered row numbering:** The row number is generated over the combined result, which gives the upload its sequence, with Responsibility rows placed first.

### FAQ
**Q: How do I rename a responsibility in the upload?**
A: Change its Name. The Responsibility Key is the stable identifier and cannot be edited once the responsibility is created.
**Q: How do I add exclusions to a new responsibility in the same file?**
A: Place the Responsibility row before its exclusion rows, so the responsibility exists when the exclusions are applied.
**Q: Can this upload delete a responsibility?**
A: No. Set an Effective Date To to disable the responsibility, as the description recommends.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-responsibility-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
