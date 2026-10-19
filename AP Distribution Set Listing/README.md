---
layout: default
last_modified_at: 2026-10-19
title: 'AP Distribution Set Listing | Oracle EBS SQL Report'
description: 'Payables distribution sets and their lines with account, percentage, income tax type, tax classification and project details, one row per distribution set…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Payables, Enginatics, Distribution, Set, Listing, ap_distribution_sets_all, ap_distribution_set_lines_all, hr_all_organization_units_vl'
permalink: /AP%20Distribution%20Set%20Listing/
report_name: 'AP Distribution Set Listing'
report_web_name: ap-distribution-set-listing
module: 'Payables'
module_url: /modules/payables/
---

# AP Distribution Set Listing – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-distribution-set-listing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing).
**Oracle EBS module:** [Payables](/modules/payables/ "Oracle EBS Payables reports") · [all Payables reports](/modules/payables/)  

## Overview
Payables distribution sets and their lines with account, percentage, income tax type, tax classification and project details, one row per distribution set line.

Equivalent to the Oracle standard Distribution Set Listing (APXGDGDL). The Status parameter evaluates active or inactive as of the Effective Date.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Distribution Set, Effective Date, Status

## Oracle EBS Tables Used
[ap_distribution_sets_all](https://www.enginatics.com/library/?pg=1&find=ap_distribution_sets_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing), [ap_distribution_set_lines_all](https://www.enginatics.com/library/?pg=1&find=ap_distribution_set_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing)

## Related Reports
[AP Distribution Set Upload](/AP%20Distribution%20Set%20Upload/ "AP Distribution Set Upload Oracle EBS SQL Report"), [PA Supplier Invoice Audit](/PA%20Supplier%20Invoice%20Audit/ "PA Supplier Invoice Audit Oracle EBS SQL Report"), [CAC Open Purchase Orders](/CAC%20Open%20Purchase%20Orders/ "CAC Open Purchase Orders Oracle EBS SQL Report"), [PA Cost Audit](/PA%20Cost%20Audit/ "PA Cost Audit Oracle EBS SQL Report"), [PA Project Subledger Detail by Expenditure Type](/PA%20Project%20Subledger%20Detail%20by%20Expenditure%20Type/ "PA Project Subledger Detail by Expenditure Type Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [WIP Account Distribution](/WIP%20Account%20Distribution/ "WIP Account Distribution Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Distribution%20Set%20Listing/AP%20Distribution%20Set%20Listing.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ap-distribution-set-listing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing) |
| Blitz Report™ XML Import | [AP_Distribution_Set_Listing.xml](https://www.enginatics.com/xml/ap-distribution-set-listing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing) |
| SQL Source | [AP Distribution Set Listing.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Distribution%20Set%20Listing/AP%20Distribution%20Set%20Listing.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ap-distribution-set-listing/](https://www.enginatics.com/reports/ap-distribution-set-listing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing) |

## Case Study & Technical Analysis: AP Distribution Set Listing

### Executive Summary
The AP Distribution Set Listing report documents the Oracle Payables distribution sets of an operating unit and their lines, with the account, percentage, income tax type, tax classification and project details of each line. Accounts Payable supervisors and finance systems teams use it to review which distribution sets exist, whether they are still active on a given date and how each invoice line will be coded when a distribution set is applied. It follows the logic of the standard Distribution Set Listing (APXGDGDL), and runs in Excel through Blitz Report.

### Business Challenge
*   **Coding control:** A distribution set codes every line of an invoice it is applied to, so an error in a set's accounts or percentages spreads to all invoices that use it.
*   **Active status:** Sets are retired by an inactive date, and the team must confirm which sets were usable on the date an invoice is entered.
*   **Tax and project coding:** Income tax types, tax classifications, projects, tasks and expenditure types on the lines must match the purpose of the set.
*   **Audit trail:** Reviewers need to see who created or last changed each set and each line.

### The Solution
*   Lists each distribution set of the operating unit with its description and inactive date, and each of its lines in the order of the distribution set line number.
*   Shows the account of each line as a concatenated segment string and adds the account description from the segment values.
*   Adds the project, task and expenditure organization for lines that charge a project, and the 1099 income tax type and VAT tax classification.
*   Resolves the created by and last updated by users of both the set and the line into user names.

### Technical Architecture (High Level)
#### Primary Tables
*   `AP_DISTRIBUTION_SETS_ALL`: the distribution set header, with its name, description and inactive date.
*   `AP_DISTRIBUTION_SET_LINES_ALL`: one row per distribution set line, with the code combination, percentage, tax and project fields.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit and the expenditure organization of a line.
*   `GL_CODE_COMBINATIONS_KFV`: the accounting flexfield of the line.
*   `PA_PROJECTS_ALL` and `PA_TASKS`: the project and task charged by the line.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units the user may access.

#### Logical Relationships
1.  `AP_DISTRIBUTION_SETS_ALL` is joined to `AP_DISTRIBUTION_SET_LINES_ALL` on the distribution set id, so each set returns one row per line.
2.  The set is restricted to the operating units in `MO_GLOB_ORG_ACCESS_TMP`, and the operating unit name comes from `HR_ALL_ORGANIZATION_UNITS_VL`.
3.  The distribution code combination is read from `GL_CODE_COMBINATIONS_KFV` through an outer join, so lines without an account still appear.
4.  Project, task and expenditure organization are outer joined to `PA_PROJECTS_ALL`, `PA_TASKS` and `HR_ALL_ORGANIZATION_UNITS_VL`.

### Parameters & Filtering
*   **Operating Unit:** limits the listing to one operating unit.
*   **Distribution Set:** limits the listing to one distribution set by name.
*   **Effective Date:** the date against which the Status parameter is evaluated.
*   **Status:** selects distribution sets that are active or inactive as of the Effective Date, as the description states.

### Performance & Optimization
*   The operating unit filter uses the `MO_GLOB_ORG_ACCESS_TMP` table, so the query reads only the organizations granted to the user's responsibility.
*   Account, project and task lookups are outer joins on primary keys, so each line requires one row from each reference table and no aggregation is performed.
*   The report contains no aggregate functions; every row is a set line, so the output stays at line level and can be summed in Excel by the user.
*   Filtering by Distribution Set or Operating Unit at run time reduces the driving rows before the joins to the reference tables.

### FAQ
**Q: How do I list the lines of an Oracle Payables distribution set?**
A: Run the report with the Operating Unit and Distribution Set parameters. Each row is one distribution set line with its account, percentage and tax details.

**Q: How do I check which distribution sets were inactive on a given date?**
A: Enter the date in the Effective Date parameter and set Status. The report evaluates active and inactive status as of that date.

**Q: Which accounts are shown for a distribution set line?**
A: The account is the code combination of the line, displayed as concatenated segments, and the account description is built from the segment values.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-distribution-set-listing)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
