---
layout: default
last_modified_at: 2026-10-16
title: 'FND Menus | Oracle EBS SQL Report'
description: 'Lists all Oracle E-Business Suite menus (FNDMENUS) together with the number of responsibilities that reference each menu. The Responsibility Count column…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Menus, fnd_menus_vl, fnd_responsibility'
permalink: /FND%20Menus/
report_name: 'FND Menus'
report_web_name: fnd-menus
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Menus – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-menus/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menus) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menus).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Lists all Oracle E-Business Suite menus (FND_MENUS) together with the number of responsibilities that reference each menu.

The Responsibility Count column shows the total number of responsibilities pointing at the menu; Active Responsibility Count excludes end-dated responsibilities.

Use the Assigned To Responsibility parameter to find the menu behind a specific responsibility, or Menus With Responsibilities Only to hide unused menus. Results are ordered by responsibility count so the most widely used menus appear first.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menus) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
User Menu Name, Menu Name, Menu Type, Assigned To Responsibility, Menus With Responsibilities Only

## Oracle EBS Tables Used
[fnd_menus_vl](https://www.enginatics.com/library/?pg=1&find=fnd_menus_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menus), [fnd_responsibility](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menus)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menus)

## Related Reports
[FND Responsibility Menu Exclusions](/FND%20Responsibility%20Menu%20Exclusions/ "FND Responsibility Menu Exclusions Oracle EBS SQL Report"), [FND Responsibility Upload](/FND%20Responsibility%20Upload/ "FND Responsibility Upload Oracle EBS SQL Report"), [Blitz Report Template Sharing](/Blitz%20Report%20Template%20Sharing/ "Blitz Report Template Sharing Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND Responsibilities](/FND%20Responsibilities/ "FND Responsibilities Oracle EBS SQL Report"), [FND Menu Entry Upload](/FND%20Menu%20Entry%20Upload/ "FND Menu Entry Upload Oracle EBS SQL Report"), [FND Menu Entries](/FND%20Menu%20Entries/ "FND Menu Entries Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Menus/FND%20Menus.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menus) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/fnd-menus/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menus) |
| Blitz Report™ XML Import | [FND_Menus.xml](https://www.enginatics.com/xml/fnd-menus/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menus) |
| SQL Source | [FND Menus.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Menus/FND%20Menus.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-menus/](https://www.enginatics.com/reports/fnd-menus/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menus) |

## Case Study & Technical Analysis: FND Menus

### Executive Summary
FND Menus lists every Oracle E-Business Suite menu from the Application Object Library, with its type, its description, the number of responsibilities that reference it and the number of those responsibilities that are still active. It is written for EBS security administrators, functional leads and technical consultants who need to understand which navigation menus are in use, which menu sits behind a responsibility, and which menus can be retired. The output supports menu rationalization projects and access reviews before a responsibility is changed.

### Business Challenge
*   **Menu Sprawl:** Long-running instances accumulate menus that were created for projects and are no longer attached to any responsibility.
*   **Responsibility Mapping:** When a user reports a missing function, the administrator must find the menu behind the responsibility and check its contents.
*   **Usage Insight:** Teams need to know which menus are widely shared, because changing a heavily used menu affects many users.
*   **Active Versus Expired Access:** Responsibilities with an end date still reference their menu, and these must be separated from live usage.

### The Solution
*   **Usage Counts:** Each menu shows the total number of responsibilities that point to it and the number that have not passed their end date.
*   **Zero Suppression:** The count columns return blank rather than zero for unused menus, so unused menus are easy to spot.
*   **Responsibility Lookup:** A parameter finds the menu attached to a named responsibility, which answers the question directly.
*   **Usage Ordering:** Results are sorted by responsibility count, so the most widely used menus appear first.

### Technical Architecture (High Level)
#### Primary Tables
*   `FND_MENUS_VL`: the menu definitions, with the user menu name, menu name, menu type, description and the creation and update audit columns.
*   `FND_RESPONSIBILITY`: the responsibilities, each of which references one menu and has a start and an end date.

#### Logical Relationships
1.  The responsibilities are summarized in an inline view that groups `FND_RESPONSIBILITY` by menu identifier.
2.  Within that view, one count returns all responsibilities and a second count returns those whose end date is empty or later than the current date.
3.  The inline view is outer joined to `FND_MENUS_VL` on the menu identifier, so menus with no responsibilities are kept.
4.  The menu type, creator and last updater are resolved through the Blitz Report™ meaning, user name and client time functions.
5.  Rows are ordered by the responsibility count in descending order, then by user menu name.

### Parameters & Filtering
*   **User Menu Name:** Filters the menus by their translated display name.
*   **Menu Name:** Filters the menus by their internal name.
*   **Menu Type:** Restricts the output to one menu type code.
*   **Assigned To Responsibility:** Returns only the menu that is attached to the named responsibility.
*   **Menus With Responsibilities Only:** When set, excludes menus that no responsibility references.

### Performance & Optimization
*   **Pre-Aggregated Responsibilities:** Counting is done once per menu in the inline view, so the responsibility table is scanned a single time.
*   **Outer Join to the Menu View:** The aggregated counts are joined to the menu list, which keeps every menu in the result when required.
*   **Simple Ordering Key:** The sort uses the count with nulls treated as zero, so unused menus fall to the bottom without extra processing.

### FAQ
**Q: How do I find the menu behind a responsibility?**
A: Enter the responsibility name in the Assigned To Responsibility parameter. The matching menu is returned with its counts.

**Q: What is the difference between Responsibility Count and Active Responsibility Count?**
A: Responsibility Count includes every responsibility that references the menu. Active Responsibility Count excludes responsibilities whose end date has passed.

**Q: How can I list only menus that are in use?**
A: Set Menus With Responsibilities Only to Yes, and only menus referenced by at least one responsibility are returned.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menus)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menus)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menus)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menus)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menus)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menus)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menus)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
