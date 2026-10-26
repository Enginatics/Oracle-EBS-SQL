---
layout: default
last_modified_at: 2026-10-26
title: 'PA Cost Audit | Oracle EBS SQL Report'
description: 'Project cost distribution lines transferred to GL showing DR/CR accounts, amounts, transfer status, and GL dates for audit and reconciliation purposes.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Projects, Enginatics, Cost, Audit, pa_cost_distribution_lines_all, pa_expenditure_items_all, pa_expenditures_all'
permalink: /PA%20Cost%20Audit/
report_name: 'PA Cost Audit'
report_web_name: pa-cost-audit
module: 'Projects'
module_url: /modules/projects/
---

# PA Cost Audit – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/pa-cost-audit/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit).
**Oracle EBS module:** [Projects](/modules/projects/ "Oracle EBS Projects reports") · [all Projects reports](/modules/projects/)  

## Overview
Project cost distribution lines transferred to GL showing DR/CR accounts, amounts, transfer status, and GL dates for audit and reconciliation purposes.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Project, GL Date From, GL Date To, Period Name

## Oracle EBS Tables Used
[pa_cost_distribution_lines_all](https://www.enginatics.com/library/?pg=1&find=pa_cost_distribution_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit), [pa_expenditure_items_all](https://www.enginatics.com/library/?pg=1&find=pa_expenditure_items_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit), [pa_expenditures_all](https://www.enginatics.com/library/?pg=1&find=pa_expenditures_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit), [per_people_x](https://www.enginatics.com/library/?pg=1&find=per_people_x&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit)

## Related Reports
[PA Supplier Invoice Audit](/PA%20Supplier%20Invoice%20Audit/ "PA Supplier Invoice Audit Oracle EBS SQL Report"), [WIP Account Distribution](/WIP%20Account%20Distribution/ "WIP Account Distribution Oracle EBS SQL Report"), [AP Expense Report Upload](/AP%20Expense%20Report%20Upload/ "AP Expense Report Upload Oracle EBS SQL Report"), [PA Project Subledger Detail by Expenditure Type](/PA%20Project%20Subledger%20Detail%20by%20Expenditure%20Type/ "PA Project Subledger Detail by Expenditure Type Oracle EBS SQL Report"), [PA Project Expenditure Items with WIP and INV Detail](/PA%20Project%20Expenditure%20Items%20with%20WIP%20and%20INV%20Detail/ "PA Project Expenditure Items with WIP and INV Detail Oracle EBS SQL Report"), [PA Employee Activity By Organization](/PA%20Employee%20Activity%20By%20Organization/ "PA Employee Activity By Organization Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [AP Distribution Set Listing](/AP%20Distribution%20Set%20Listing/ "AP Distribution Set Listing Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Cost%20Audit/PA%20Cost%20Audit.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PA Cost Audit 23-Mar-2026 121933.xlsx](https://www.enginatics.com/example/pa-cost-audit/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit) |
| Blitz Report™ XML Import | [PA_Cost_Audit.xml](https://www.enginatics.com/xml/pa-cost-audit/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit) |
| SQL Source | [PA Cost Audit.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PA%20Cost%20Audit/PA%20Cost%20Audit.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/pa-cost-audit/](https://www.enginatics.com/reports/pa-cost-audit/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit) |

## Case Study & Technical Analysis: PA Cost Audit

### Executive Summary
The PA Cost Audit report lists Oracle Projects cost distribution lines that have been transferred, or are awaiting transfer, to the General Ledger. For each line it shows the debit and credit accounts, the amount, the transfer status, the GL date and the PA period, together with the expenditure item, expenditure and the person who incurred the cost. Project accountants and controllers use it to audit project costs in the ledger and to reconcile project cost totals with GL postings at period close. It is an audit and reconciliation view of the cost side of Projects accounting.

### Business Challenge
*   **Project-to-GL reconciliation:** Project cost totals must agree with the amounts posted to the general ledger, and differences need to be traced to specific distribution lines.
*   **Transfer status control:** Cost lines can be transferred, rejected or still pending, and each state needs a different follow-up.
*   **Accounting audit trail:** Auditors ask which debit and credit accounts a project cost was charged to, and which employee incurred it.
*   **Period alignment:** Project periods and GL dates do not always match, so costs must be reviewed by both.

### The Solution
*   **Distribution-level view:** Each row is one raw cost distribution line, with its debit and credit accounts, amount and line number.
*   **Transfer status and dates:** The transfer status is shown with its meaning, along with the date it was transferred.
*   **Expenditure context:** The expenditure item, its date, quantity, expenditure type and system linkage category explain what the cost is.
*   **Ownership and organization:** Project, task, operating unit and the incurring employee are shown beside the amounts.

### Technical Architecture (High Level)
#### Primary Tables
*   `PA_COST_DISTRIBUTION_LINES_ALL`: the cost distribution lines, with debit and credit accounts, amount, GL date, transfer status and PA period.
*   `PA_EXPENDITURE_ITEMS_ALL`: the expenditure items that the distribution lines belong to.
*   `PA_EXPENDITURES_ALL`: the expenditure header, which holds the person who incurred the cost.
*   `PA_PROJECTS_ALL` and `PA_TASKS`: the project and task of the expenditure item.
*   `GL_CODE_COMBINATIONS_KFV`: the debit and credit accounts, joined twice under different aliases.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit of the project.
*   `PER_PEOPLE_X`: the employee name and number.
*   `MO_GLOB_ORG_ACCESS_TMP` and `DUAL`: the operating units the user can access, with a release check.

#### Logical Relationships
1.  `PA_COST_DISTRIBUTION_LINES_ALL` is restricted to the raw cost line type and joined to `PA_EXPENDITURE_ITEMS_ALL` on the expenditure item ID.
2.  The expenditure item is joined to `PA_EXPENDITURES_ALL` on the expenditure ID, and to `PA_PROJECTS_ALL` and `PA_TASKS` on project and task.
3.  The debit and credit combination IDs of each line are outer joined to `GL_CODE_COMBINATIONS_KFV`, once for each account.
4.  The project's operating unit is joined to `HR_ALL_ORGANIZATION_UNITS_VL`, and the incurring person is outer joined to `PER_PEOPLE_X`.
5.  The result is ordered by operating unit, project number, task number, expenditure item date and distribution line number.

### Parameters & Filtering
*   **Operating Unit:** Limits the output to one operating unit, within the organizations the user can access.
*   **Project:** Limits the output to one project.
*   **GL Date From and GL Date To:** Restrict the lines to a range of GL dates.
*   **Period Name:** Restricts the lines to one Projects accounting period.

### Performance & Optimization
*   **Raw cost lines only:** The query restricts distribution lines to the raw cost line type, so other line types are not returned.
*   **Access-restricted operating units:** The operating unit filter uses the access temporary table and a release check, so the user sees only operating units they are granted.
*   **Outer joins for accounts and people:** Accounts and the incurring person are outer joined, so lines without those values remain in the audit list.
*   **Account lookups by alias:** The same accounts table is joined twice for debit and credit, which avoids a second query for each side.

### FAQ
**Q: How do I see which project costs have not yet been transferred to the GL?**
A: Use the transfer status column in the output. Lines still awaiting transfer carry their pending status, and the GL Date and Period Name parameters narrow the range.
**Q: Which accounts are shown for each cost line?**
A: Each line shows its debit account and its credit account, read from the distribution line's debit and credit code combinations.
**Q: Who incurred a cost shown in this report?**
A: The incurring employee's name and number are shown from the expenditure header, where the person is recorded.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=pa-cost-audit)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
