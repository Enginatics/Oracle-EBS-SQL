---
layout: default
last_modified_at: 2026-10-16
title: 'Blitz Report Template Sharing Upload | Oracle EBS SQL Report'
description: 'Upload to maintain Blitz Report template sharing - which users, responsibilities, or the whole site can see and use a report template (Excel layout). The…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Blitz, Report, Template, Sharing, xxen_report_templates_v, xxen_report_template_sharing_v, fnd_application_vl'
permalink: /Blitz%20Report%20Template%20Sharing%20Upload/
report_name: 'Blitz Report Template Sharing Upload'
report_web_name: blitz-report-template-sharing-upload
---

# Blitz Report Template Sharing Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-template-sharing-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing-upload).

## Overview
Upload to maintain Blitz Report template sharing - which users, responsibilities, or the whole site can see and use a report template (Excel layout).

The upload can be run in the following modes:

-Create with 'Create Empty File'=Yes:
Opens an empty Excel file to enter new template shares.

-Create with 'Create Empty File'=blank:
Query the templates you want to share, filtered by report name, category or sharing level.

-Create, Update:
Query existing template shares, which can be deleted or copied to a different sharing level.

Sharing levels:
-Site shares the template with the whole system (all responsibilities and users).
-Responsibility shares it with one responsibility - enter the responsibility name in Shared With and its owning application in Description.
-User shares it with one named user.

Note: Site sharing is mutually exclusive with specific shares. Sharing a template at Site level removes any existing Responsibility or User shares for that template, and adding a Responsibility or User share removes any existing Site share - mirroring the Blitz Report template setup form.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Create Empty File, Report Name starts with, Report Category, Sharing Level, Sharing Creation Date From, Sharing Creation Date To

## Oracle EBS Tables Used
[xxen_report_templates_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_templates_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing-upload), [xxen_report_template_sharing_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_template_sharing_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing-upload), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing-upload)

## Related Reports
[Blitz Report Template Sharing](/Blitz%20Report%20Template%20Sharing/ "Blitz Report Template Sharing Oracle EBS SQL Report"), [Blitz Report Templates](/Blitz%20Report%20Templates/ "Blitz Report Templates Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [DIS Migration identify missing EulConditions](/DIS%20Migration%20identify%20missing%20EulConditions/ "DIS Migration identify missing EulConditions Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DIS End User Layers](/DIS%20End%20User%20Layers/ "DIS End User Layers Oracle EBS SQL Report"), [GL Balance by Account Hierarchy](/GL%20Balance%20by%20Account%20Hierarchy/ "GL Balance by Account Hierarchy Oracle EBS SQL Report"), [INV Item Templates](/INV%20Item%20Templates/ "INV Item Templates Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Template%20Sharing%20Upload/Blitz%20Report%20Template%20Sharing%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/blitz-report-template-sharing-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing-upload) |
| Blitz Report™ XML Import | [Blitz_Report_Template_Sharing_Upload.xml](https://www.enginatics.com/xml/blitz-report-template-sharing-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing-upload) |
| SQL Source | [Blitz Report Template Sharing Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Template%20Sharing%20Upload/Blitz%20Report%20Template%20Sharing%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/blitz-report-template-sharing-upload/](https://www.enginatics.com/reports/blitz-report-template-sharing-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing-upload) |

## Case Study & Technical Analysis: Blitz Report Template Sharing Upload

### Executive Summary
This upload manages who can see and use Blitz Report™ templates, the Excel layouts that run Oracle E-Business Suite reports. It lists each template with its owner and its sharing entries, and lets an administrator share a template with the whole site, with one responsibility, or with one named user, or remove an existing share. It is intended for the administrators who maintain a shared template library for finance, supply chain and HR users. Instead of opening the template setup form for each template, the administrator can review and change the sharing of many templates in one spreadsheet.

### Business Challenge
*   **Template sprawl:** Organizations build many report templates, and without sharing they stay visible only to their owners, so the same layouts are rebuilt by different teams.
*   **Scope of visibility:** A template is needed by one responsibility, by a single user or by everyone, and each level must be set deliberately.
*   **Consistent rules:** The site-wide share and the specific shares exclude each other, and changing one by hand can leave a template with conflicting entries.
*   **Audit of who shared what:** Administrators need to know when a share was created and by whom.

### The Solution
*   Lists every template from `XXEN_REPORT_TEMPLATES_V` with its report name, template name and owner, and joins each to its sharing entries from `XXEN_REPORT_TEMPLATE_SHARING_V`.
*   Shows the Sharing Level, the Shared With value and the owning application of a responsibility share, using the application name from `FND_APPLICATION_VL`.
*   Shows who created each share and when, with the user name and client time.
*   Supports creating new shares through an empty file, deleting existing shares, and copying a share to a different sharing level, with the upload applying the same rules as the template setup form.

### Technical Architecture (High Level)
#### Primary Tables
*   `XXEN_REPORT_TEMPLATES_V`: the Blitz Report templates, with report name, template name, owner and template identifier.
*   `XXEN_REPORT_TEMPLATE_SHARING_V`: the sharing entries of each template, with the sharing level, the level value and the creation details.
*   `FND_APPLICATION_VL`: the application that owns a responsibility, used to describe a responsibility share.

#### Logical Relationships
1. `XXEN_REPORT_TEMPLATES_V` is outer joined to the sharing view on TEMPLATE_ID, so templates without any share still appear.
2. The sharing view's ID2 column is joined to `FND_APPLICATION_VL` on APPLICATION_ID, which supplies the Description column for responsibility shares.
3. When Create Empty File is Yes, the template branch returns no rows, so only a blank upload file is produced.
4. The upload writes the changed shares back by template and sharing level, and the site, responsibility and user levels are mutually exclusive for each template.

### Parameters & Filtering
*   **Upload Mode:** selects create with an empty file, or query and update of existing shares.
*   **Create Empty File:** when set to Yes, opens an empty file for entering new shares.
*   **Report Name starts with:** limits the templates to report names with the given prefix.
*   **Report Category:** limits the templates to one category.
*   **Sharing Level:** selects Site, Responsibility or User shares.
*   **Sharing Creation Date From** and **Sharing Creation Date To:** bound the date a share was created.

### Performance & Optimization
*   The template and sharing views are combined on TEMPLATE_ID with an outer join, so one query returns each template with all of its shares.
*   The application lookup is an outer join on the application identifier, so responsibility shares are described in the same query without a separate lookup.
*   The Create Empty File switch is part of the WHERE clause, so when it is Yes the report returns no existing template rows.
*   The sharing level and creation date parameters narrow the sharing entries that the report returns.

### FAQ
**Q: How do I share a Blitz Report template with one responsibility?**
A: Create a share with the Sharing Level set to Responsibility, enter the responsibility name in Shared With, and enter its owning application in Description.

**Q: What happens when I share a template with the whole site?**
A: The site share replaces any existing Responsibility or User shares of that template, because site sharing is mutually exclusive with specific shares.

**Q: Who created an existing share?**
A: The Created By and Creation Date columns show the user and the client time when the share was made.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
