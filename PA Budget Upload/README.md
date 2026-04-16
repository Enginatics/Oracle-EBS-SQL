---
layout: default
title: 'PA Budget Upload | Oracle EBS SQL Report'
description: 'The PA Budget Upload supports the creation/update of standard project budgets. At this stage it does not support the creation/update of Financial Plan…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Budget, hr_all_organization_units_vl, pa_projects_all, pa_budget_versions'
permalink: /PA%20Budget%20Upload/
---

# PA Budget Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-budget-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
The PA Budget Upload supports the creation/update of standard project budgets. 

At this stage it does not support the creation/update of Financial Plan Budgets.

The PA Budget Upload allows users to:

- Create new working budgets.

When creating a new working budget, any existing working budget for the specified Project and Budget Type will be overwritten.

The upload allows the user to create a working budget either by entering the data directly into an empty upload excel file, or by copying a prior version of the budget and modifying this in the upload excel file.

- Update existing working budgets.

This option allows for the update of an existing working budget. In this mode the existing budget is retained, and the update mode allows for individual budget lines to be added, updated, and/or deleted from the existing working budget.

- Additionally, the upload allows users to Baseline a Working Budget.

Working Budgets can be uploaded against the Projects belonging to the Operating Units accessible to the responsibility in which the PA Budget Upload process is run.


## Report Parameters
Upload Mode, Product Source, Copy Existing Budget, Operating Unit, Project Number, Project Name, Budget Type, Budget Version, Task Number, Task Name, Resource Alias, Period From, Period To, Budget Line Start Date, Budget Line End Date, Budget Line Active On Date, Sort Precedence 1, Sort Precedence 2, Sort Precedence 3

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all), [pa_budget_versions](https://www.enginatics.com/library/?pg=1&find=pa_budget_versions), [pa_budget_types](https://www.enginatics.com/library/?pg=1&find=pa_budget_types), [pa_budget_entry_methods](https://www.enginatics.com/library/?pg=1&find=pa_budget_entry_methods), [pa_resource_lists](https://www.enginatics.com/library/?pg=1&find=pa_resource_lists), [pa_resource_assignments](https://www.enginatics.com/library/?pg=1&find=pa_resource_assignments), [pa_budget_lines](https://www.enginatics.com/library/?pg=1&find=pa_budget_lines), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks), [pa_resource_list_members](https://www.enginatics.com/library/?pg=1&find=pa_resource_list_members), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[PA Project Budget Upload](/PA%20Project%20Budget%20Upload/ "PA Project Budget Upload Oracle EBS SQL Report"), [PA Project Budget](/PA%20Project%20Budget/ "PA Project Budget Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/pa-budget-upload/) |
| Blitz Report™ XML Import | [PA_Budget_Upload.xml](https://www.enginatics.com/xml/pa-budget-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/pa-budget-upload/](https://www.enginatics.com/reports/pa-budget-upload/) |



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
