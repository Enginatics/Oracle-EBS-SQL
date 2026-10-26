---
layout: default
last_modified_at: 2026-10-26
title: 'PA Project Upload | Oracle EBS SQL Report'
description: 'PA Project Upload =================== Create and update Projects in Oracle Projects using the paprojectpub API. Create Mode: - Select a Template to…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Project, pa_projects_all, pa_lookups, fnd_lookup_values_vl'
permalink: /PA%20Project%20Upload/
report_name: 'PA Project Upload'
report_web_name: pa-project-upload
---

# PA Project Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-project-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload).

## Overview
PA Project Upload
===================
Create and update Projects in Oracle Projects using the pa_project_pub API.

Create Mode:
- Select a Template to populate default values (project type, organization, billing setup, etc.)
- Template-specific required fields (customer, organization, completion date, etc.) are validated in Excel before upload
- Project Manager can differ from the template PM — the template PM is replaced post-creation
- PM Product Code determines which external PM system owns the project (default: Primavera). Do NOT use Microsoft Project — it blocks date updates due to Oracle bug 12954344.

Update Mode:
- Use "Create, Update" upload mode to download existing projects, modify fields, and re-upload
- Only changed fields are updated — unchanged fields are preserved
- Project Manager changes: the current active PM is end-dated and the new PM is assigned from today
- If no active PM exists (all end-dated), the new PM is simply assigned
- Start Date and Completion Date can be changed, cleared, or added
- Customer and PM Product Code are set on creation only and not changed on update

Field Length Limits:
- Project Number: 25 characters
- Project Name: 30 characters
- Long Name: 240 characters
- Description: 250 characters

Supported Fields:
Project identifiers, dates, billing setup (labor/non-labor schedules, bill rate schedules, burden schedules), billing currency settings, flags (baseline funding, multi-currency billing, cross charge, retention, capital interest, etc.), transfer price schedules, work type, calendar, location, role list, probability, priority, job groups, security level, invoice format, asset/capital settings, tax codes, DFF attributes (1-10), customer, and PM product code.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Operating Unit, Project Number, Project Name, Project Type, Project Status

## Oracle EBS Tables Used
[pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [pa_lookups](https://www.enginatics.com/library/?pg=1&find=pa_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [fnd_lookup_values_vl](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [pa_project_customers](https://www.enginatics.com/library/?pg=1&find=pa_project_customers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [pa_project_statuses](https://www.enginatics.com/library/?pg=1&find=pa_project_statuses&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [pa_distribution_rules](https://www.enginatics.com/library/?pg=1&find=pa_distribution_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [pa_project_parties](https://www.enginatics.com/library/?pg=1&find=pa_project_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [pa_std_bill_rate_schedules_all](https://www.enginatics.com/library/?pg=1&find=pa_std_bill_rate_schedules_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [pa_ind_rate_schedules_all_bg](https://www.enginatics.com/library/?pg=1&find=pa_ind_rate_schedules_all_bg&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [pa_cc_tp_schedules_bg](https://www.enginatics.com/library/?pg=1&find=pa_cc_tp_schedules_bg&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [pa_work_types_vl](https://www.enginatics.com/library/?pg=1&find=pa_work_types_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [jtf_calendars_vl](https://www.enginatics.com/library/?pg=1&find=jtf_calendars_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [pa_role_lists](https://www.enginatics.com/library/?pg=1&find=pa_role_lists&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [pa_probability_members](https://www.enginatics.com/library/?pg=1&find=pa_probability_members&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [per_job_groups_v](https://www.enginatics.com/library/?pg=1&find=per_job_groups_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [pa_invoice_formats](https://www.enginatics.com/library/?pg=1&find=pa_invoice_formats&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [GL Account Analysis 11g](/GL%20Account%20Analysis%2011g/ "GL Account Analysis 11g Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Project%20Upload/PA%20Project%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/pa-project-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload) |
| Blitz Report™ XML Import | [PA_Project_Upload.xml](https://www.enginatics.com/xml/pa-project-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload) |
| SQL Source | [PA Project Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Project%20Upload/PA%20Project%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pa-project-upload/](https://www.enginatics.com/reports/pa-project-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload) |

## Case Study & Technical Analysis: PA Project Upload

### Executive Summary
The PA Project Upload is a Blitz Report upload that creates and updates projects in Oracle Projects. It covers project identifiers, dates, billing setup, currency and burden schedules, cross-charge and transfer price settings, work types, calendars, role lists, job groups and flexfield attributes. Project accountants and project managers use it to set up new projects from a template in bulk, and to maintain existing projects such as their dates, project manager and billing flags. The upload calls the Oracle project public API, so the validations of the Projects forms apply to every row. The workflow runs in Excel through Blitz Report.

### Business Challenge
*   **Bulk project setup:** New projects are often created in batches from a standard template, and each one needs many interdependent billing and accounting fields.
*   **Project manager changes:** When a project manager changes, the current assignment must be closed and the new one started, without losing the history of the project.
*   **Consistent billing setup:** Labor and non-labor schedules, bill rate schedules, burden schedules and currency settings must be applied consistently across projects of the same type.
*   **Controlled updates:** Only the fields that change should be sent to the system, so that unchanged values are not overwritten by a spreadsheet re-upload.

### The Solution
*   **Template-driven creation:** A template project supplies default values such as project type, organization and billing setup, and the template project manager can be replaced after creation.
*   **Changed-field updates:** Using the Create, Update upload mode, the project is downloaded with its current values, and only modified fields are sent back.
*   **Manager assignment rules:** A project manager change end-dates the current active manager assignment and assigns the new manager from the current date, or simply assigns the new manager when no active one exists.
*   **Creation-only fields:** Customer and PM product code are set when the project is created and are not changed by a later update.

### Technical Architecture (High Level)
#### Primary Tables
*   `PA_PROJECTS_ALL`: the project header, with number, name, long name, dates, type, status, currencies, billing and burden schedule references and flags.
*   `PA_PROJECT_STATUSES`: the project status, restricted to status type PROJECT.
*   `PA_PROJECT_PARTIES`: the project role assignments, including the project manager.
*   `PER_ALL_PEOPLE_F`: the project manager's name.
*   `PA_PROJECT_CUSTOMERS`, `HZ_CUST_ACCOUNTS` and `HZ_PARTIES`: the customer linked to the project.
*   `PA_STD_BILL_RATE_SCHEDULES_ALL` and `PA_IND_RATE_SCHEDULES_ALL_BG`: the standard bill rate schedules and the individual rate schedules used for revenue, invoice and capital interest.
*   `PA_CC_TP_SCHEDULES_BG`: the cross-charge transfer price schedules.
*   `PA_DISTRIBUTION_RULES`, `PA_WORK_TYPES_VL`, `PA_ROLE_LISTS`, `PA_PROBABILITY_MEMBERS` and `PA_INVOICE_FORMATS`: the distribution rule, work type, role list, probability and invoice format.
*   `GL_DAILY_CONVERSION_TYPES`: the currency conversion types for project, functional and billing rates.
*   `JTF_CALENDARS_VL`, `HR_LOCATIONS_ALL` and `PER_JOB_GROUPS_V`: the calendar, location and job groups.
*   `HR_ALL_ORGANIZATION_UNITS_VL` and `MO_GLOB_ORG_ACCESS_TMP`: the operating unit, carrying-out organization and accessible organizations.

#### Logical Relationships
1.  `PA_PROJECTS_ALL` joins to `PA_PROJECT_STATUSES` on the status code, and to the operating unit and carrying-out organization in `HR_ALL_ORGANIZATION_UNITS_VL`.
2.  The project manager is found by joining `PA_PROJECT_PARTIES` with role type 1 and an active end date, then `PER_ALL_PEOPLE_F` on the resource person ID.
3.  Each currency conversion type ID joins to `GL_DAILY_CONVERSION_TYPES`, and each schedule ID joins to its bill rate or burden schedule.
4.  Work type, calendar, location, role list, probability and job group join on their identifiers as outer joins.
5.  The customer is a correlated lookup on `PA_PROJECT_CUSTOMERS`, and templates are excluded by the template flag.

### Parameters & Filtering
*   **Upload Mode:** selects the download or the create and update action.
*   **Operating Unit:** limits the projects to one organization within the accessible set.
*   **Project Number** and **Project Name:** identify the project to download or update.
*   **Project Type:** restricts the output to one project type.
*   **Project Status:** restricts the output to one project status.

### Performance & Optimization
*   The operating unit restriction is an `IN` subquery on `MO_GLOB_ORG_ACCESS_TMP`, so only projects of accessible organizations are read.
*   The template project name is a scalar subquery on the template project ID, so each row costs one lookup.
*   Lookup meanings are produced by the `XXEN_UTIL` helpers, so the lookup tables are read through one shared function rather than repeated joins in each column.
*   Project manager and customer lookups are restricted by their active date and by `ROWNUM`, which returns one value per project.

### FAQ
**Q: What happens to the old project manager when a new one is assigned?**
A: The current active project manager assignment is end-dated, and the new manager is assigned from today. If no active manager exists, the new one is simply assigned.

**Q: Which fields can be changed after a project is created?**
A: Most fields can be changed, including dates, billing setup, flags and flexfield attributes. Customer and PM product code are set on creation only.

**Q: Why should Microsoft Project not be used as the PM product?**
A: The description states that Microsoft Project blocks date updates because of Oracle bug 12954344, so Primavera is the default PM product code.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
