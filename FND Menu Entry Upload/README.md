---
layout: default
title: 'FND Menu Entry Upload | Oracle EBS SQL Report'
description: 'Upload to create, update and delete menu entries in FND Menus. Useful for adding entries to existing menus, e.g. during Supply Chain Hub installation…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, FND, Menu, Entry, fnd_menus_vl, fnd_menu_entries, fnd_menu_entries_tl'
permalink: /FND%20Menu%20Entry%20Upload/
---

# FND Menu Entry Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-menu-entry-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
Upload Mode, User Menu Name, Menu Name, Function Name, User Function Name, Responsibility

## Oracle EBS Tables Used
[fnd_menus_vl](https://www.enginatics.com/library/?pg=1&find=fnd_menus_vl), [fnd_menu_entries](https://www.enginatics.com/library/?pg=1&find=fnd_menu_entries), [fnd_menu_entries_tl](https://www.enginatics.com/library/?pg=1&find=fnd_menu_entries_tl), [fnd_form_functions_vl](https://www.enginatics.com/library/?pg=1&find=fnd_form_functions_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[FND Responsibility Access 11i](/FND%20Responsibility%20Access%2011i/ "FND Responsibility Access 11i Oracle EBS SQL Report"), [FND Menu Entries](/FND%20Menu%20Entries/ "FND Menu Entries Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND User Login Page Favorites](/FND%20User%20Login%20Page%20Favorites/ "FND User Login Page Favorites Oracle EBS SQL Report"), [FND Responsibility Menu Exclusions](/FND%20Responsibility%20Menu%20Exclusions/ "FND Responsibility Menu Exclusions Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [FND Forms Personalizations](/FND%20Forms%20Personalizations/ "FND Forms Personalizations Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/fnd-menu-entry-upload/) |
| Blitz Report™ XML Import | [FND_Menu_Entry_Upload.xml](https://www.enginatics.com/xml/fnd-menu-entry-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-menu-entry-upload/](https://www.enginatics.com/reports/fnd-menu-entry-upload/) |



---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
