---
layout: default
title: 'Blitz Report Template Sharing | Oracle EBS SQL Report'
description: 'Lists the sharing records for Blitz Report templates - who each template is shared with at Site, Responsibility or User level. The Owner column shows the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, Template, Sharing, fnd_application, wf_user_role_assignments, fnd_responsibility'
permalink: /Blitz%20Report%20Template%20Sharing/
---

# Blitz Report Template Sharing – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-template-sharing/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Lists the sharing records for Blitz Report templates - who each template is shared with at Site, Responsibility or User level. The Owner column shows the user who owns each template.

For a Responsibility-level share the Shared With column shows the responsibility name and the Application column shows its owning application; for a User-level share it shows the user name; a Site-level share is available to everyone.

For Responsibility-level shares the Menu Name column shows the responsibility's menu and Blitz Report Menu Entries counts the Blitz Report menu functions already on that menu (blank when none). A blank Blitz Report Menu Entries with a shared template flags a responsibility whose menu is still missing the Blitz Report function - run the Update Menu Entries program to add it.

Set the Assigned to EBS User parameter to a user to answer "which templates can this user actually use, and how". The report then shows one row per access path - a Site share (available to everyone), each Responsibility share on a responsibility the user holds, a direct User share, or ownership - but ONLY for reports the user is allowed to run: it applies the same report-access reach as the run screen (Site, Application, Request Group, Responsibility and User assignments), so a template shared with the user whose report is not assigned to the user is not listed (the user could not run it). The Assigned To User Via column names the level for that row (for example "Responsibility (AP Manager)" or "Owner"); the per-share administrative columns are blank in this mode.

Use the Report Name, Category, Template Name, Template Owner and Sharing Level parameters to narrow the list - for example set Category to Discoverer to pull the templates of all Discoverer reports, or Template Owner to list one user's templates. The Template Name list is filtered to the selected Report Name when one is chosen.

## Report Parameters
Report Name, Category, Template Name, Template Owner, Sharing Level, Assigned to User

## Oracle EBS Tables Used
[fnd_application](https://www.enginatics.com/library/?pg=1&find=fnd_application), [wf_user_role_assignments](https://www.enginatics.com/library/?pg=1&find=wf_user_role_assignments), [fnd_responsibility](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility), [fnd_form_functions](https://www.enginatics.com/library/?pg=1&find=fnd_form_functions), [fnd_compiled_menu_functions](https://www.enginatics.com/library/?pg=1&find=fnd_compiled_menu_functions), [fnd_menu_entries](https://www.enginatics.com/library/?pg=1&find=fnd_menu_entries), [xxen_report_template_sharing_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_template_sharing_v), [xxen_report_templates](https://www.enginatics.com/library/?pg=1&find=xxen_report_templates), [xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_menus](https://www.enginatics.com/library/?pg=1&find=fnd_menus), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [fnd_user_resp_groups_direct](https://www.enginatics.com/library/?pg=1&find=fnd_user_resp_groups_direct), [fnd_user_resp_groups_indirect](https://www.enginatics.com/library/?pg=1&find=fnd_user_resp_groups_indirect), [xxen_report_assignments](https://www.enginatics.com/library/?pg=1&find=xxen_report_assignments), [user_resps](https://www.enginatics.com/library/?pg=1&find=user_resps), [xxen_report_assignment_users](https://www.enginatics.com/library/?pg=1&find=xxen_report_assignment_users)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND User Login Page Favorites](/FND%20User%20Login%20Page%20Favorites/ "FND User Login Page Favorites Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [FND Menu Entries](/FND%20Menu%20Entries/ "FND Menu Entries Oracle EBS SQL Report"), [FND Responsibility Upload](/FND%20Responsibility%20Upload/ "FND Responsibility Upload Oracle EBS SQL Report"), [FND Forms Personalizations](/FND%20Forms%20Personalizations/ "FND Forms Personalizations Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/blitz-report-template-sharing/) |
| Blitz Report™ XML Import | [Blitz_Report_Template_Sharing.xml](https://www.enginatics.com/xml/blitz-report-template-sharing/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-report-template-sharing/](https://www.enginatics.com/reports/blitz-report-template-sharing/) |



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
