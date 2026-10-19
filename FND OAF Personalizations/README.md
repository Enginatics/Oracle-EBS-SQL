---
layout: default
last_modified_at: 2026-10-19
title: 'FND OAF Personalizations | Oracle EBS SQL Report'
description: 'Oracle Application Framework (OAF) page personalizations stored in the MDS repository (JDR tables), with the personalization level and the page or region…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, OAF, Personalizations, fnd_responsibility_vl, fnd_user, hr_all_organization_units_vl'
permalink: /FND%20OAF%20Personalizations/
report_name: 'FND OAF Personalizations'
report_web_name: fnd-oaf-personalizations
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND OAF Personalizations – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-oaf-personalizations/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Oracle Application Framework (OAF) page personalizations stored in the MDS repository (JDR tables), with the personalization level and the page or region they apply to.

Level Name shows the responsibility, user, operating unit or function, or the stored level value where it is not an id, for example for localization or portlet.

A personalization document can be exported with the JDR_UTILS.printDocument procedure or the XMLExporter utility for migration to another instance.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Level, Document contains, Last Update Date From

## Oracle EBS Tables Used
[fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations), [fnd_form_functions_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_functions_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations), [jdr_attributes](https://www.enginatics.com/library/?pg=1&find=jdr_attributes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations), [jdr_paths](https://www.enginatics.com/library/?pg=1&find=jdr_paths&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations), [jdr_components](https://www.enginatics.com/library/?pg=1&find=jdr_components&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations)

## Related Reports
[INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [FND User Login History](/FND%20User%20Login%20History/ "FND User Login History Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [PO Approved Supplier List](/PO%20Approved%20Supplier%20List/ "PO Approved Supplier List Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20OAF%20Personalizations/FND%20OAF%20Personalizations.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND OAF Personalizations 12-Oct-2026 061642.xlsx](https://www.enginatics.com/example/fnd-oaf-personalizations/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations) |
| Blitz Report™ XML Import | [FND_OAF_Personalizations.xml](https://www.enginatics.com/xml/fnd-oaf-personalizations/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations) |
| SQL Source | [FND OAF Personalizations.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20OAF%20Personalizations/FND%20OAF%20Personalizations.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-oaf-personalizations/](https://www.enginatics.com/reports/fnd-oaf-personalizations/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations) |

## Case Study & Technical Analysis: FND OAF Personalizations

### Executive Summary
This report lists Oracle Application Framework (OAF) page personalizations stored in the Metadata Services (MDS) repository, with the level at which each one applies and the page it customizes. Application developers, technical consultants and upgrade teams use it to see which pages are personalized, by whom and at which level, before an upgrade or a migration to another instance. It runs in Excel through Blitz Report™.

### Business Challenge
*   **Hidden customization:** OAF personalizations change how pages look and behave for a responsibility, user, operating unit or function, but they are stored in the repository and not visible in the forms.
*   **Upgrade impact:** Before a patch or upgrade, the personalizations of each page must be known so that they can be retested.
*   **Migration:** Personalizations are moved between instances as documents, and the team needs a list of the documents to export.
*   **Governance:** Administrators need to know who created or last changed a personalization and when.

### The Solution
*   Lists each personalization document with its path, the base document it customizes and the personalization level.
*   Resolves the level value to a readable name, such as the responsibility name, user name, operating unit name or function name.
*   Shows the creator, creation date, last updater and last update date of each document, with user identifiers converted to user names where possible.
*   Filters by level, by text contained in the document and by the last update date, so that recent or specific personalizations can be reviewed.

### Technical Architecture (High Level)
#### Primary Tables
*   `JDR_PATHS`: the repository path tree, where each document is a path of type DOCUMENT with its name and owner.
*   `JDR_COMPONENTS`: the components that make up each document, identified here by the customization element.
*   `JDR_ATTRIBUTES`: the attributes of each path, including the base document a customization applies to.
*   `FND_RESPONSIBILITY_VL`, `FND_USER`, `HR_ALL_ORGANIZATION_UNITS_VL` and `FND_FORM_FUNCTIONS_VL`: the names of the responsibility, user, operating unit and function that a level value identifies.
*   `DUAL`: used to obtain the root document identifier.

#### Logical Relationships
1.  The path tree is walked from the top path named customizations, following the parent-child links of `JDR_PATHS`.
2.  The full document name is built by joining the root document name to the path of each document.
3.  Documents are kept only where the path is a document and its identifier is a customization component of sequence zero in `JDR_COMPONENTS`.
4.  The base document of each personalization is read from its customizes attribute in `JDR_ATTRIBUTES`.
5.  The personalization level and level value are extracted from the document path, and the level value is matched to the responsibility, user, organization or function that it identifies.
6.  Creator and last updater identifiers are converted to user names where they are numeric, and the results are ordered by base document, level and level name.

### Parameters & Filtering
*   **Level:** restricts the output to one personalization level, such as responsibility, user, organization or function.
*   **Document contains:** restricts the output to personalization documents whose content matches the text entered.
*   **Last Update Date From:** restricts the output to personalizations updated on or after the date given.

### Performance & Optimization
*   The hierarchical query over `JDR_PATHS` starts at the customizations path and follows the parent links, so it reads only the subtree of personalizations rather than the whole repository.
*   The document filter on `JDR_COMPONENTS` is a semi-join on the component identifier, which avoids repeating the path walk for each component.
*   The level name is resolved by a correlated subquery against the matching table for each row, so the cost grows with the number of personalizations listed.
*   Filtering by level and date before the export keeps the list manageable on instances with many personalized pages.

### FAQ
**Q: How can an OAF personalization be exported for migration?**
A: The document can be exported with the JDRUTILS.printDocument procedure or with the XMLExporter utility, using the document path shown in the report.

**Q: What does the Level Name column show?**
A: It shows the responsibility name, user name, operating unit name or function name that the level value identifies, or the stored level value itself where it is not an identifier, for example for localization or portlet levels.

**Q: Which pages does a personalization apply to?**
A: The Base Document column shows the page or region that the personalization customizes, taken from the customizes attribute of the document.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-oaf-personalizations)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
