---
layout: default
last_modified_at: 2026-10-19
title: 'PA Project Subledger Detail by Expenditure Type | Oracle EBS SQL Report'
description: 'Cost distribution lines summarized by project, task, expenditure type, and GL account showing raw cost, burden cost, and total cost for transferred and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Projects, Enginatics, Project, Subledger, Detail, Expenditure, pa_cost_distribution_lines_all, pa_expenditure_items_all, pa_projects_all'
permalink: /PA%20Project%20Subledger%20Detail%20by%20Expenditure%20Type/
report_name: 'PA Project Subledger Detail by Expenditure Type'
report_web_name: pa-project-subledger-detail-by-expenditure-type(1)
module: 'Projects'
module_url: /modules/projects/
---

# PA Project Subledger Detail by Expenditure Type – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-project-subledger-detail-by-expenditure-type(1?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29)/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29).
**Oracle EBS module:** [Projects](/modules/projects/ "Oracle EBS Projects reports") · [all Projects reports](/modules/projects/)  

## Overview
Cost distribution lines summarized by project, task, expenditure type, and GL account showing raw cost, burden cost, and total cost for transferred and accepted lines.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Project, GL Date From, GL Date To, Expenditure Type, Account

## Oracle EBS Tables Used
[pa_cost_distribution_lines_all](https://www.enginatics.com/library/?pg=1&find=pa_cost_distribution_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29), [pa_expenditure_items_all](https://www.enginatics.com/library/?pg=1&find=pa_expenditure_items_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29), [pa_expenditure_types](https://www.enginatics.com/library/?pg=1&find=pa_expenditure_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29)

## Related Reports
[PA Supplier Invoice Audit](/PA%20Supplier%20Invoice%20Audit/ "PA Supplier Invoice Audit Oracle EBS SQL Report"), [PA Cost Audit](/PA%20Cost%20Audit/ "PA Cost Audit Oracle EBS SQL Report"), [AP Distribution Set Listing](/AP%20Distribution%20Set%20Listing/ "AP Distribution Set Listing Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report"), [AP Distribution Set Upload](/AP%20Distribution%20Set%20Upload/ "AP Distribution Set Upload Oracle EBS SQL Report"), [WIP Account Distribution](/WIP%20Account%20Distribution/ "WIP Account Distribution Oracle EBS SQL Report"), [PA Project Expenditure Items with WIP and INV Detail](/PA%20Project%20Expenditure%20Items%20with%20WIP%20and%20INV%20Detail/ "PA Project Expenditure Items with WIP and INV Detail Oracle EBS SQL Report"), [CAC Open Purchase Orders](/CAC%20Open%20Purchase%20Orders/ "CAC Open Purchase Orders Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Project%20Subledger%20Detail%20by%20Expenditure%20Type/PA%20Project%20Subledger%20Detail%20by%20Expenditure%20Type.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PA Project Subledger Detail by Expenditure Type 04-Apr-2026 023352.xlsx](https://www.enginatics.com/example/pa-project-subledger-detail-by-expenditure-type(1?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29)/) |
| Blitz Report™ XML Import | [PA_Project_Subledger_Detail_by_Expenditure_Type.xml](https://www.enginatics.com/xml/pa-project-subledger-detail-by-expenditure-type(1?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29)/) |
| SQL Source | [PA Project Subledger Detail by Expenditure Type.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Project%20Subledger%20Detail%20by%20Expenditure%20Type/PA%20Project%20Subledger%20Detail%20by%20Expenditure%20Type.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pa-project-subledger-detail-by-expenditure-type(1)/](https://www.enginatics.com/reports/pa-project-subledger-detail-by-expenditure-type(1?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29)/) |

## Case Study & Technical Analysis: PA Project Subledger Detail by Expenditure Type

### Executive Summary
The PA Project Subledger Detail by Expenditure Type report summarizes the project cost distribution lines of Oracle Projects by project, task, expenditure type and General Ledger account. For each group it shows the raw cost, the burden cost and the total cost of the lines that have been transferred or accepted. Project accountants use it to reconcile the costs held in Projects with the GL account balances they have been posted to, and to explain the burden applied to each expenditure type. The report runs in Excel through Blitz Report, so the reconciliation can be filtered by GL date and account.

### Business Challenge
*   **Projects to GL reconciliation:** Project cost must agree with the General Ledger, and the reconciliation needs the cost grouped by account as well as by project and task.
*   **Burden analysis:** The difference between raw cost and burdened cost, which comes from overhead and burden rules, must be visible by expenditure type.
*   **Transfer status control:** Only lines that have been transferred to the GL or accepted should be counted in the subledger view, so that unposted or rejected lines do not distort the totals.
*   **Expenditure type reporting:** Costs must be reported by expenditure category and system linkage, for management reporting on labor, material and other cost types.

### The Solution
*   **Raw and burden cost:** Raw cost is the amount of each distribution line, and burden cost is the burdened amount, summed by group.
*   **Total cost:** Total cost is the raw cost plus the burden adjustment, which is the burdened cost less the raw amount of each line.
*   **Transfer status filter:** Only distribution lines with a transfer status of accepted or transferred are included.
*   **Account grouping:** The debit account of each distribution line is resolved to its concatenated GL segments and description, so the output reconciles to the GL by account.

### Technical Architecture (High Level)
#### Primary Tables
*   `PA_COST_DISTRIBUTION_LINES_ALL`: the cost distribution lines, with the amount, burdened cost, transfer status and debit code combination.
*   `PA_EXPENDITURE_ITEMS_ALL`: the expenditure item that the distribution line came from, with its expenditure type and system linkage function.
*   `PA_PROJECTS_ALL`: the project number and name.
*   `PA_TASKS`: the task number and name.
*   `PA_EXPENDITURE_TYPES`: the expenditure type category.
*   `GL_CODE_COMBINATIONS_KFV`: the GL account concatenated segments and description.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit name.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units accessible to the current user.

#### Logical Relationships
1.  `PA_COST_DISTRIBUTION_LINES_ALL` joins to `PA_EXPENDITURE_ITEMS_ALL` on the expenditure item ID.
2.  The expenditure item joins to `PA_PROJECTS_ALL` on the project ID, to `PA_TASKS` on the task ID, and to `PA_EXPENDITURE_TYPES` on the expenditure type.
3.  The distribution line joins to `GL_CODE_COMBINATIONS_KFV` on the debit code combination ID, as an outer join so that lines without an account are kept.
4.  The project joins to `HR_ALL_ORGANIZATION_UNITS_VL` on the organization ID, which is the operating unit.
5.  The rows are grouped by operating unit, project, task, expenditure type, category, system linkage, GL account and account description, and ordered by the same keys.

### Parameters & Filtering
*   **Operating Unit:** limits the output to one organization within the accessible set.
*   **Project:** restricts the output to one project.
*   **GL Date From** and **GL Date To:** bound the GL date of the cost lines.
*   **Expenditure Type:** restricts the output to one expenditure type.
*   **Account:** restricts the output to one GL account.

### Performance & Optimization
*   Only distribution lines of line type R are read, and only lines with an accepted or transferred status are summed.
*   The operating unit restriction is an `IN` subquery on `MO_GLOB_ORG_ACCESS_TMP`, which limits the project set before the cost aggregation.
*   The aggregation is a single `GROUP BY` over the distribution lines, so the database returns one row per project, task, expenditure type and account.
*   The account lookup is an outer join on the code combination ID, so the GL table is read only for the grouped output.

### FAQ
**Q: Which cost lines are included in this report?**
A: Cost distribution lines of line type R whose transfer status is A (accepted) or V (transferred).

**Q: How is total cost calculated?**
A: Total cost is the raw cost plus the difference between the burdened cost and the raw amount, so it equals the burdened cost where a burden is applied.

**Q: How can I reconcile this report to the General Ledger?**
A: Compare the total cost for each GL account with the project cost in the GL account balance for the same period, using the GL Date From and GL Date To parameters.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-project-subledger-detail-by-expenditure-type%281%29)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
