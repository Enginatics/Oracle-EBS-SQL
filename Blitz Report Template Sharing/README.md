---
layout: default
last_modified_at: 2026-10-16
title: 'Blitz Report Template Sharing | Oracle EBS SQL Report'
description: 'Lists the sharing records for Blitz Report templates - who each template is shared with at Site, Responsibility or User level. The Owner column shows the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, Template, Sharing, fnd_application, wf_user_role_assignments, fnd_responsibility'
permalink: /Blitz%20Report%20Template%20Sharing/
report_name: 'Blitz Report Template Sharing'
report_web_name: blitz-report-template-sharing
module: 'Blitz Report'
module_url: /modules/blitz-report/
---

# Blitz Report Template Sharing – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-template-sharing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing).
**Oracle EBS module:** [Blitz Report](/modules/blitz-report/ "Oracle EBS Blitz Report reports") · [all Blitz Report reports](/modules/blitz-report/)  

## Overview
Lists the sharing records for Blitz Report templates - who each template is shared with at Site, Responsibility or User level. The Owner column shows the user who owns each template.

For a Responsibility-level share the Shared With column shows the responsibility name and the Application column shows its owning application; for a User-level share it shows the user name; a Site-level share is available to everyone.

For Responsibility-level shares the Menu Name column shows the responsibility's menu and Blitz Report Menu Entries counts the Blitz Report menu functions already on that menu (blank when none). A blank Blitz Report Menu Entries with a shared template flags a responsibility whose menu is still missing the Blitz Report function - run the Update Menu Entries program to add it.

Set the Assigned to EBS User parameter to a user to answer "which templates can this user actually use, and how". The report then shows one row per access path - a Site share (available to everyone), each Responsibility share on a responsibility the user holds, a direct User share, or ownership - but ONLY for reports the user is allowed to run: it applies the same report-access reach as the run screen (Site, Application, Request Group, Responsibility and User assignments), so a template shared with the user whose report is not assigned to the user is not listed (the user could not run it). The Assigned To User Via column names the level for that row (for example "Responsibility (AP Manager)" or "Owner"); the per-share administrative columns are blank in this mode.

Use the Report Name, Category, Template Name, Template Owner and Sharing Level parameters to narrow the list - for example set Category to Discoverer to pull the templates of all Discoverer reports, or Template Owner to list one user's templates. The Template Name list is filtered to the selected Report Name when one is chosen.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Report Name, Category, Template Name, Template Owner, Sharing Level, Assigned to User

## Oracle EBS Tables Used
[fnd_application](https://www.enginatics.com/library/?pg=1&find=fnd_application&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing), [wf_user_role_assignments](https://www.enginatics.com/library/?pg=1&find=wf_user_role_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing), [fnd_responsibility](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing), [fnd_form_functions](https://www.enginatics.com/library/?pg=1&find=fnd_form_functions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing), [fnd_compiled_menu_functions](https://www.enginatics.com/library/?pg=1&find=fnd_compiled_menu_functions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing), [fnd_menu_entries](https://www.enginatics.com/library/?pg=1&find=fnd_menu_entries&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing), [xxen_report_template_sharing_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_template_sharing_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing), [xxen_report_templates](https://www.enginatics.com/library/?pg=1&find=xxen_report_templates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing), [xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing), [fnd_menus](https://www.enginatics.com/library/?pg=1&find=fnd_menus&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing), [fnd_user_resp_groups_direct](https://www.enginatics.com/library/?pg=1&find=fnd_user_resp_groups_direct&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing), [fnd_user_resp_groups_indirect](https://www.enginatics.com/library/?pg=1&find=fnd_user_resp_groups_indirect&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing), [xxen_report_assignments](https://www.enginatics.com/library/?pg=1&find=xxen_report_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing), [xxen_report_assignment_users](https://www.enginatics.com/library/?pg=1&find=xxen_report_assignment_users&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing)

## Related Reports
[Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND User Login Page Favorites](/FND%20User%20Login%20Page%20Favorites/ "FND User Login Page Favorites Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [FND Menu Entries](/FND%20Menu%20Entries/ "FND Menu Entries Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Template%20Sharing/Blitz%20Report%20Template%20Sharing.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/blitz-report-template-sharing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing) |
| Blitz Report™ XML Import | [Blitz_Report_Template_Sharing.xml](https://www.enginatics.com/xml/blitz-report-template-sharing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing) |
| SQL Source | [Blitz Report Template Sharing.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Template%20Sharing/Blitz%20Report%20Template%20Sharing.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/blitz-report-template-sharing/](https://www.enginatics.com/reports/blitz-report-template-sharing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing) |

## Case Study & Technical Analysis: Blitz Report Template Sharing

### Executive Summary
The Blitz Report Template Sharing report lists who each Blitz Report™ template is shared with, at Site, Responsibility or User level, and who owns it. It serves two audiences. Administrators use the default view to review sharing across the template library and to find responsibilities whose menus lack the Blitz Report function. Support staff use the user view to answer one question: which templates can this EBS user actually run, and through which access path. The report reflects the same report-access rules as the run screen, so a template is not shown as usable if its underlying report is not assigned to that user.

### Business Challenge
*   **Sharing sprawl:** Templates are created by individual users and shared to sites, responsibilities or named users, and the resulting sharing picture is hard to review in the application.
*   **Menu gaps:** A responsibility can hold shared templates while its menu is missing the Blitz Report function, so the templates cannot be opened from that responsibility.
*   **Access troubleshooting:** When a user says a template is missing, support needs to see whether the template is shared to a responsibility the user holds, shared directly, or simply owned by the user.

### The Solution
*   **Sharing register:** One row per template share, showing the sharing level, the shared-with target, the owner and the creation and update details.
*   **Responsibility context:** For responsibility shares, the report shows the application, the responsibility menu and the count of Blitz Report menu entries on that menu.
*   **User access view:** With an EBS user chosen, the report lists one row per access path, covering site shares, responsibility shares the user holds, direct user shares and ownership.
*   **Report-access filter:** In user mode, rows are kept only where the underlying report is assigned to the user through site, application, request group, responsibility or user assignments.

### Technical Architecture (High Level)
#### Primary Tables
*   `XXEN_REPORT_TEMPLATE_SHARING_V`: the sharing records for each template, with sharing level and target identifiers.
*   `XXEN_REPORT_TEMPLATES`: the templates, with their owner and their report.
*   `XXEN_REPORTS_V`: the report catalogue, supplying report name, type and category.
*   `XXEN_REPORT_ASSIGNMENTS` and `XXEN_REPORT_ASSIGNMENT_USERS`: the report assignments and the user lists that restrict them.
*   `FND_RESPONSIBILITY`, `FND_MENUS`, `FND_APPLICATION_VL` and `FND_APPLICATION`: the responsibility, its menu and owning application.
*   `FND_FORM_FUNCTIONS`, `FND_COMPILED_MENU_FUNCTIONS` and `FND_MENU_ENTRIES`: the Blitz Report functions and their presence on a menu.
*   `FND_USER`, `FND_USER_RESP_GROUPS_DIRECT` and `FND_USER_RESP_GROUPS_INDIRECT`: the user and the responsibilities granted to the user.
*   `WF_USER_ROLE_ASSIGNMENTS`: the responsibility roles held by the user, used to find the responsibilities of the selected user.

#### Logical Relationships
1.  A common table expression lists the responsibilities of the selected user, from role assignments matched to responsibilities whose menus carry the Blitz Report function.
2.  Each sharing row is joined to its template, the template's report, and the report's catalogue entry.
3.  For responsibility shares, the responsibility, its application and its menu are outer joined, and the Blitz Report menu entry count is taken from `FND_MENU_ENTRIES`.
4.  In user mode, the rows are limited to shares the user can use: site shares, responsibility shares held directly or indirectly, user shares, and templates the user owns with no share reaching them.
5.  Each row is then kept only if a matching include assignment exists and no exclude assignment applies to the user.

### Parameters & Filtering
*   **Report Name, Category and Template Name:** Narrow the register to one report, one category or one template. Choosing a report also filters the template list.
*   **Template Owner:** Lists the templates owned by one user.
*   **Sharing Level:** Limits the output to Site, Responsibility or User shares.
*   **Assigned to User:** Switches the report to user mode and lists the templates that user can use, with the access path in the Assigned To User Via column.

### Performance & Optimization
*   **Responsibility list computed once:** The user's responsibilities are gathered in a common table expression, which is referenced by the assignment checks rather than recalculated in each one.
*   **Exists-based checks:** Access and exclusion tests are written as EXISTS subqueries, so each template row stops at the first matching assignment.

### FAQ
**Q: How do I find which templates a specific user can use?**
A: Enter the user name in Assigned to User. The report lists one row per access path, and the Assigned To User Via column names the level for each row.

**Q: Why does a responsibility show a blank Blitz Report Menu Entries count?**
A: A blank count on a responsibility with a shared template means its menu has no Blitz Report menu function, and the Update Menu Entries program should be run to add it.

**Q: Can a user see a template that is shared with them if the report is not assigned to them?**
A: No. In user mode the report applies the same report-access rules as the run screen, so such a template is not listed.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-template-sharing)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
