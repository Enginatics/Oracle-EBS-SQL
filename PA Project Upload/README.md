---
layout: default
title: 'PA Project Upload | Oracle EBS SQL Report'
description: 'PA Project Upload =================== Create and update Projects in Oracle Projects using the paprojectpub API. Create Mode: - Select a Template to…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Project, pa_projects_all, pa_lookups, fnd_lookup_values_vl'
permalink: /PA%20Project%20Upload/
---

# PA Project Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-project-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
Upload Mode, Operating Unit, Project Number, Project Name, Project Type, Project Status

## Oracle EBS Tables Used
[pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all), [pa_lookups](https://www.enginatics.com/library/?pg=1&find=pa_lookups), [fnd_lookup_values_vl](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values_vl), [pa_project_customers](https://www.enginatics.com/library/?pg=1&find=pa_project_customers), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [pa_project_statuses](https://www.enginatics.com/library/?pg=1&find=pa_project_statuses), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [pa_distribution_rules](https://www.enginatics.com/library/?pg=1&find=pa_distribution_rules), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f), [pa_project_parties](https://www.enginatics.com/library/?pg=1&find=pa_project_parties), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [pa_std_bill_rate_schedules_all](https://www.enginatics.com/library/?pg=1&find=pa_std_bill_rate_schedules_all), [pa_ind_rate_schedules_all_bg](https://www.enginatics.com/library/?pg=1&find=pa_ind_rate_schedules_all_bg), [pa_cc_tp_schedules_bg](https://www.enginatics.com/library/?pg=1&find=pa_cc_tp_schedules_bg), [pa_work_types_vl](https://www.enginatics.com/library/?pg=1&find=pa_work_types_vl), [jtf_calendars_vl](https://www.enginatics.com/library/?pg=1&find=jtf_calendars_vl), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all), [pa_role_lists](https://www.enginatics.com/library/?pg=1&find=pa_role_lists), [pa_probability_members](https://www.enginatics.com/library/?pg=1&find=pa_probability_members), [per_job_groups_v](https://www.enginatics.com/library/?pg=1&find=per_job_groups_v), [pa_invoice_formats](https://www.enginatics.com/library/?pg=1&find=pa_invoice_formats), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[INV Material Transactions Summary](/INV%20Material%20Transactions%20Summary/ "INV Material Transactions Summary Oracle EBS SQL Report"), [INV Material Transactions](/INV%20Material%20Transactions/ "INV Material Transactions Oracle EBS SQL Report"), [PPF_WP3_OM_DETAILS](/PPF_WP3_OM_DETAILS/ "PPF_WP3_OM_DETAILS Oracle EBS SQL Report"), [INV Onhand Quantities](/INV%20Onhand%20Quantities/ "INV Onhand Quantities Oracle EBS SQL Report"), [INV Safety Stocks](/INV%20Safety%20Stocks/ "INV Safety Stocks Oracle EBS SQL Report"), [MRP Item Forecast](/MRP%20Item%20Forecast/ "MRP Item Forecast Oracle EBS SQL Report"), [EAM Work Orders](/EAM%20Work%20Orders/ "EAM Work Orders Oracle EBS SQL Report"), [FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/pa-project-upload/) |
| Blitz Report™ XML Import | [PA_Project_Upload.xml](https://www.enginatics.com/xml/pa-project-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/pa-project-upload/](https://www.enginatics.com/reports/pa-project-upload/) |



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
