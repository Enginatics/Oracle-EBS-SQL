---
layout: default
last_modified_at: 2026-10-16
title: 'AP Distribution Set Upload | Oracle EBS SQL Report'
description: 'Creates and updates Payables distribution sets and their lines - the Excel equivalent of the Distribution Sets form (Setup > Invoice > Distribution Sets)…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Distribution, Set, ap_lookup_codes, ap_distribution_sets_all, hr_all_organization_units_vl'
permalink: /AP%20Distribution%20Set%20Upload/
report_name: 'AP Distribution Set Upload'
report_web_name: ap-distribution-set-upload
---

# AP Distribution Set Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-distribution-set-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload).

## Overview
Creates and updates Payables distribution sets and their lines - the Excel equivalent of the Distribution Sets form (Setup > Invoice > Distribution Sets).

Each row is one distribution set line, with the distribution set header columns repeated on every line. The header values are taken from the first row of each distribution set. Leave the line columns blank to create or update a distribution set header only.

Each distribution set is processed as a whole: the percentages of all its lines, including existing lines not in the upload file, must add up to 100 (Full) or to 0 (Skeleton), otherwise none of its rows are saved. The same applies when any other line of the set fails validation.

Line Number identifies the line within the distribution set. Set Delete Line to Yes to delete a line. A distribution set cannot be deleted, as in the form - enter an Inactive On date instead.

For project related lines, enter Project, Task, Expenditure Type and Expenditure Organization. The account is then derived by the Projects account generator, exactly as in the form.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Operating Unit, Distribution Set

## Oracle EBS Tables Used
[ap_lookup_codes](https://www.enginatics.com/library/?pg=1&find=ap_lookup_codes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload), [ap_distribution_sets_all](https://www.enginatics.com/library/?pg=1&find=ap_distribution_sets_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload), [ap_distribution_set_lines_all](https://www.enginatics.com/library/?pg=1&find=ap_distribution_set_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload)

## Related Reports
[AP Distribution Set Listing](/AP%20Distribution%20Set%20Listing/ "AP Distribution Set Listing Oracle EBS SQL Report"), [PA Supplier Invoice Audit](/PA%20Supplier%20Invoice%20Audit/ "PA Supplier Invoice Audit Oracle EBS SQL Report"), [CAC Open Purchase Orders](/CAC%20Open%20Purchase%20Orders/ "CAC Open Purchase Orders Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Distribution%20Set%20Upload/AP%20Distribution%20Set%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ap-distribution-set-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload) |
| Blitz Report™ XML Import | [AP_Distribution_Set_Upload.xml](https://www.enginatics.com/xml/ap-distribution-set-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload) |
| SQL Source | [AP Distribution Set Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Distribution%20Set%20Upload/AP%20Distribution%20Set%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ap-distribution-set-upload/](https://www.enginatics.com/reports/ap-distribution-set-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload) |

## Case Study & Technical Analysis: AP Distribution Set Upload

### Executive Summary
The AP Distribution Set Upload report is a spreadsheet-based maintenance tool for Oracle Payables distribution sets. It is the Excel equivalent of the Distribution Sets form (Setup > Invoice > Distribution Sets). Accounts payable setup teams use it to create new distribution sets, change their lines and percentages, and retire sets by entering an inactive date, without keying each set through the form one line at a time. Because it is an upload, the same file carries the header and line data for many sets, which makes it practical for initial setup of a new operating unit or for a large clean-up of allocation rules.

### Business Challenge
*   **Form-by-form keying:** Each distribution set must be built line by line in the Distribution Sets form, which is slow when an organization maintains dozens of allocation sets.
*   **Percentage integrity:** A distribution set only works when its line percentages total 100 (Full) or 0 (Skeleton). Errors are easy to make when lines are typed one at a time.
*   **Set lifecycle:** A distribution set cannot be deleted in the form. Teams need a controlled way to stop using a set while keeping its history.

### The Solution
*   **One row per line:** Each row is one distribution set line, and the header columns (set name, description, set type, inactive date, attribute values) repeat on every line. The header values are read from the first row of each set.
*   **Whole-set validation:** Each set is processed as a unit. The percentages of all its lines, including existing lines not in the file, must total 100 or 0, otherwise none of its rows are saved.
*   **Line deletion and retirement:** Setting Delete Line to Yes removes a single line. Entering an Inactive On date retires the set, mirroring the form, since the set itself is never deleted.
*   **Projects account generation:** For project-related lines the account is derived by the Projects account generator, so the upload produces the same accounting result as the form.

### Technical Architecture (High Level)
#### Primary Tables
*   `AP_DISTRIBUTION_SETS_ALL`: the distribution set header, including the set name, total percent distribution, inactive date and the set-level descriptive flexfield attributes.
*   `AP_DISTRIBUTION_SET_LINES_ALL`: the lines of each set, with line number, percentage, distribution code combination, project, task, expenditure details and line-level attributes.
*   `GL_CODE_COMBINATIONS_KFV`: the accounting flexfield combination that holds the account string and its description.
*   `PA_PROJECTS_ALL` and `PA_TASKS`: the project and task referenced by project-related lines.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit of the set and the expenditure organization of each line.
*   `AP_LOOKUP_CODES`: translated labels for the set type, derived from the total percent distribution.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units the current user is allowed to see.

#### Logical Relationships
1.  The header table `AP_DISTRIBUTION_SETS_ALL` is restricted to operating units in `MO_GLOB_ORG_ACCESS_TMP` and joined to its operating unit in `HR_ALL_ORGANIZATION_UNITS_VL`.
2.  Each header is outer joined to its lines in `AP_DISTRIBUTION_SET_LINES_ALL` on the distribution set ID, so sets without lines still appear.
3.  Each line is outer joined to `GL_CODE_COMBINATIONS_KFV` for the account, to `PA_PROJECTS_ALL` and `PA_TASKS` for project data, and to `HR_ALL_ORGANIZATION_UNITS_VL` for the expenditure organization.
4.  The set type label is looked up in `AP_LOOKUP_CODES` using the set's total percent distribution.

### Parameters & Filtering
*   **Upload Mode:** Selects the Full or Skeleton rule, which decides whether the lines of each set must total 100 or 0 percent.
*   **Operating Unit:** Limits the sets to one operating unit, which is where each distribution set is owned.
*   **Distribution Set:** Narrows the extract to a named set, so one set can be reviewed or re-uploaded.

### Performance & Optimization
*   **Access-restricted driving rows:** The main filter is an `IN` subquery on `MO_GLOB_ORG_ACCESS_TMP`, so only operating units granted to the user drive the extract.
*   **Outer joins to optional data:** Lines, projects, tasks and expenditure organizations are outer joined, so header-only sets and non-project lines are returned without separate passes.
*   **Flexfield display functions:** Descriptive flexfield values are resolved through `xxen_util` display functions, which keeps the SELECT list readable but adds per-row function calls on wide sets.

### FAQ
**Q: How do I add a new line to an existing AP distribution set without changing the others?**
A: Enter a row with the set name and a new Line Number, and the line percentages must still total 100 or 0 across all lines of the set, including the existing ones.

**Q: Why was my whole distribution set rejected when only one line had an error?**
A: Each set is processed as a whole, so if any line of the set fails validation, none of its rows are saved.

**Q: Can I delete a distribution set with this upload?**
A: No. As in the Distribution Sets form, a set cannot be deleted; enter an Inactive On date to retire it, and set Delete Line to Yes only to remove individual lines.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
