---
layout: default
last_modified_at: 2026-10-19
title: 'FND Menu Entry Upload | Oracle EBS SQL Report'
description: 'Upload to create, update and delete menu entries in FND Menus. Useful for adding entries to existing menus, e.g. during Supply Chain Hub installation…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, FND, Menu, Entry, fnd_menus_vl, fnd_menu_entries, fnd_menu_entries_tl'
permalink: /FND%20Menu%20Entry%20Upload/
report_name: 'FND Menu Entry Upload'
report_web_name: fnd-menu-entry-upload
---

# FND Menu Entry Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-menu-entry-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entry-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entry-upload).

## Overview
Upload to create, update and delete menu entries in FND Menus.
Useful for adding entries to existing menus, e.g. during Supply Chain Hub installation.

Upload Modes
============

Create
------
Opens an empty spreadsheet where the user can enter new menu entries.

Create, Update
--------------
Downloads existing menu entries matching the Menu Name filter for review and update.
New rows can be added to create additional entries in the same upload.

Fields
======
- User Menu Name: Display-only. Shows the translatable menu name.
- Menu Name: Required. The internal menu name (e.g. INV_NAVIGATE).
- Entry Sequence: The sequence number for the entry within the menu. Auto-assigned if not provided for new entries.
- Prompt: The display text shown in the menu for this entry.
- Entry Description: Optional description of the menu entry.
- Sub Menu: The sub-menu to navigate to. Either Sub Menu or Function Name must be specified.
- Function Name: The form function to launch. Either Sub Menu or Function Name must be specified.
- Grant Flag: Y (default) = entry is grantable via security, N = not grantable.
- Delete Record: Set to Y to delete an existing menu entry.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entry-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, User Menu Name, Menu Name, Function Name, User Function Name, Responsibility

## Oracle EBS Tables Used
[fnd_menus_vl](https://www.enginatics.com/library/?pg=1&find=fnd_menus_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entry-upload), [fnd_menu_entries](https://www.enginatics.com/library/?pg=1&find=fnd_menu_entries&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entry-upload), [fnd_menu_entries_tl](https://www.enginatics.com/library/?pg=1&find=fnd_menu_entries_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entry-upload), [fnd_form_functions_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_functions_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entry-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entry-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entry-upload)

## Related Reports
[FND Menu Entries](/FND%20Menu%20Entries/ "FND Menu Entries Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [Blitz Report Template Sharing](/Blitz%20Report%20Template%20Sharing/ "Blitz Report Template Sharing Oracle EBS SQL Report"), [FND User Login Page Favorites](/FND%20User%20Login%20Page%20Favorites/ "FND User Login Page Favorites Oracle EBS SQL Report"), [FND Responsibility Upload](/FND%20Responsibility%20Upload/ "FND Responsibility Upload Oracle EBS SQL Report"), [FND Responsibility Menu Exclusions](/FND%20Responsibility%20Menu%20Exclusions/ "FND Responsibility Menu Exclusions Oracle EBS SQL Report"), [FND Forms Personalizations](/FND%20Forms%20Personalizations/ "FND Forms Personalizations Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Menu%20Entry%20Upload/FND%20Menu%20Entry%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entry-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/fnd-menu-entry-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entry-upload) |
| Blitz Report™ XML Import | [FND_Menu_Entry_Upload.xml](https://www.enginatics.com/xml/fnd-menu-entry-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entry-upload) |
| SQL Source | [FND Menu Entry Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Menu%20Entry%20Upload/FND%20Menu%20Entry%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-menu-entry-upload/](https://www.enginatics.com/reports/fnd-menu-entry-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entry-upload) |

## Case Study & Technical Analysis: FND Menu Entry Upload

### Executive Summary
FND Menu Entry Upload creates, updates and deletes the entries of Oracle Application Object Library menus, the navigation structures that connect responsibilities to forms and sub-menus. It is designed for EBS implementation and security teams who must add many menu entries at once, for example when a module such as Supply Chain Hub is installed and new functions need to appear on existing menus. The template downloads the entries of matching menus, lets the user add or change rows in Excel, and applies the changes through the menu entry API.

### Business Challenge
*   **Manual Menu Configuration:** Adding a set of functions to a menu through the Menus form requires one entry at a time, with the sequence and prompt set by hand.
*   **Consistent Navigation:** Users of the same responsibility need the same entries in the same order, and inconsistent sequences make navigation confusing.
*   **Installation Projects:** Module installations often require a defined list of entries to be added to seeded menus, and that list must be reproducible across environments.
*   **Clean Up:** Obsolete entries must be removed in a controlled way, without editing the menu record by hand.

### The Solution
*   **Menu Entry Extract:** The template downloads each menu entry with its menu name, user menu name, sequence, prompt and description, so existing entries can be reviewed before changes.
*   **Sub Menu or Function Choice:** Each row names either a sub-menu or a form function, which the upload uses to attach the entry to the menu.
*   **Grant Control:** The grant flag decides whether the entry is available to security grants, with Y as the default.
*   **Deletion Flag:** A delete column removes an existing entry when set to Y, so cleanup uses the same template as creation.

### Technical Architecture (High Level)
#### Primary Tables
*   `FND_MENUS_VL`: the menu definitions, including the menu name, user menu name and menu type. It is read for both the parent menu and the referenced sub-menu.
*   `FND_MENU_ENTRIES`: the entries of each menu, with the sequence, the function or sub-menu reference and the grant flag.
*   `FND_MENU_ENTRIES_TL`: the translated prompt and description of each entry.
*   `FND_FORM_FUNCTIONS_VL`: the form functions that an entry can launch, with their user function names.

#### Logical Relationships
1.  Each row of `FND_MENUS_VL` is joined to its entries in `FND_MENU_ENTRIES` on the menu identifier.
2.  Each entry is joined to `FND_MENU_ENTRIES_TL` on the menu identifier and entry sequence, restricted to the session language.
3.  The sub-menu reference is outer joined back to `FND_MENUS_VL`, so the user menu name of the sub-menu is returned.
4.  The function reference is outer joined to `FND_FORM_FUNCTIONS_VL`, so the user function name is returned for function entries.
5.  Rows are numbered by menu name and entry sequence to give each row a stable position in the template.

### Parameters & Filtering
*   **Upload Mode:** Selects Create, or Create and Update. In Create and Update mode the existing entries of the selected menus are downloaded.
*   **User Menu Name:** Filters the menus by their translated name.
*   **Menu Name:** Filters the menus by their internal name, such as the seeded navigation menu code.
*   **Function Name and User Function Name:** Restrict the entries to those launching a given form function.
*   **Responsibility:** Selects the menu attached to a responsibility, so the entries of that responsibility can be maintained.

### Performance & Optimization
*   **Menu Scoped Extract:** The menu filters are applied to the menu view first, so only entries of the chosen menus are read.
*   **Language Restriction:** The translation join is limited to the session language, which keeps one prompt per entry.
*   **Outer Joins for Entries:** Sub-menu and function references are outer joined, because an entry has one or the other and not both.
*   **Create Mode Template:** In Create mode the download is suppressed, so the sheet is empty and no existing entries are read.

### FAQ
**Q: Which fields are required for a new menu entry?**
A: A menu name, an entry sequence if you want to control order, a prompt, and either a sub-menu or a function name.

**Q: Can I remove an entry with this template?**
A: Yes. Set the Delete Record column to Y on the downloaded row of the entry.

**Q: What does the Grant Flag control?**
A: It controls whether the entry is grantable through security. Y is the default, and N makes the entry not grantable.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entry-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entry-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entry-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entry-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entry-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entry-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-menu-entry-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
