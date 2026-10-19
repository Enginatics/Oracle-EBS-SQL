---
layout: default
last_modified_at: 2026-10-19
title: 'FND Menu Entries | Oracle EBS SQL Report'
description: 'Oracle EBS Application Object Library SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Menu, Entries, fnd_menus_vl, fnd_menu_entries_vl, fnd_menus_tl'
permalink: /FND%20Menu%20Entries/
report_name: 'FND Menu Entries'
report_web_name: fnd-menu-entries
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Menu Entries – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-menu-entries/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entries) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entries).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview


> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entries) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
User Menu Name, User Menu Name like, Menu Name, Prompt, Submenu, Menu Entry, User Function Name, Function Name, User Form Name, Form Name, Assigned To Responsibility, Created By, Creation Date From, Creation Date To, Last Update Date From, Last Update Date To

## Oracle EBS Tables Used
[fnd_menus_vl](https://www.enginatics.com/library/?pg=1&find=fnd_menus_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entries), [fnd_menu_entries_vl](https://www.enginatics.com/library/?pg=1&find=fnd_menu_entries_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entries), [fnd_menus_tl](https://www.enginatics.com/library/?pg=1&find=fnd_menus_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entries), [fnd_form_functions_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_functions_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entries), [fnd_form_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entries)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entries)

## Related Reports
[FND Menu Entry Upload](/FND%20Menu%20Entry%20Upload/ "FND Menu Entry Upload Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [Blitz Report Template Sharing](/Blitz%20Report%20Template%20Sharing/ "Blitz Report Template Sharing Oracle EBS SQL Report"), [FND Responsibility Upload](/FND%20Responsibility%20Upload/ "FND Responsibility Upload Oracle EBS SQL Report"), [FND Responsibility Menu Exclusions](/FND%20Responsibility%20Menu%20Exclusions/ "FND Responsibility Menu Exclusions Oracle EBS SQL Report"), [FND User Login Page Favorites](/FND%20User%20Login%20Page%20Favorites/ "FND User Login Page Favorites Oracle EBS SQL Report"), [FND Forms Personalizations](/FND%20Forms%20Personalizations/ "FND Forms Personalizations Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Menu%20Entries/FND%20Menu%20Entries.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entries) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Menu Entries 21-Jul-2017 172713.xlsx](https://www.enginatics.com/example/fnd-menu-entries/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entries) |
| Blitz Report™ XML Import | [FND_Menu_Entries.xml](https://www.enginatics.com/xml/fnd-menu-entries/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entries) |
| SQL Source | [FND Menu Entries.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Menu%20Entries/FND%20Menu%20Entries.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-menu-entries/](https://www.enginatics.com/reports/fnd-menu-entries/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entries) |

## Executive Summary
The **FND Menu Entries** report documents the menu hierarchy in Oracle EBS. It shows which functions and sub-menus are attached to a parent menu, effectively mapping out the navigation structure.

## Business Challenge
*   **Security Audit:** Verifying which functions are accessible from a specific Responsibility's menu.
*   **Navigation Design:** Documenting the current menu structure before redesigning the user navigation.
*   **Troubleshooting:** Finding where a specific function (e.g., "Enter Journals") is located in the menu tree.

## The Solution
This Blitz Report explodes the menu structure:
*   **Menu:** The parent menu name.
*   **Entry:** The prompt (label) seen by the user.
*   **Function/Submenu:** The actual function or child menu attached to that entry.
*   **Grant:** Shows if the function is "Grant" only (not visible, but authorized).

## Technical Architecture
The report queries `FND_MENUS_VL` and `FND_MENU_ENTRIES_VL`. It can recursively traverse the tree if needed, but typically shows direct assignments.

## Parameters & Filtering
*   **User Menu Name:** Filter by the top-level menu (e.g., "GL_SUPERUSER").
*   **Function Name:** Find all menus that contain a specific function.
*   **Prompt:** Search by the user-visible label.

## Performance & Optimization
*   **Recursion:** Menu structures can be deep. The report is optimized to show direct relationships.

## FAQ
*   **Q: Does this show Exclusions?**
    *   A: No, this shows the *definition* of the menu. To see what a user can actually access (net of exclusions), use the "FND Responsibility Access" report.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entries)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entries)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entries)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entries)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entries)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entries)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entries)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
