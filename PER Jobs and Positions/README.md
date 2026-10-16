---
layout: default
last_modified_at: 2026-10-16
title: 'PER Jobs and Positions | Oracle EBS SQL Report'
description: 'Positions valid at the Effective Date with their job, organization, status, valid grades, FTE, maximum persons, headcount and incumbent FTE, plus the jobs…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Human Resources, Enginatics, PER, Jobs, Positions, per_grades_vl, per_valid_grades, hr_all_positions_f_vl'
permalink: /PER%20Jobs%20and%20Positions/
report_name: 'PER Jobs and Positions'
report_web_name: per-jobs-and-positions
module: 'Human Resources'
module_url: /modules/human-resources/
---

# PER Jobs and Positions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/per-jobs-and-positions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions).
**Oracle EBS module:** [Human Resources](/modules/human-resources/ "Oracle EBS Human Resources reports") · [all Human Resources reports](/modules/human-resources/)  

## Overview
Positions valid at the Effective Date with their job, organization, status, valid grades, FTE, maximum persons, headcount and incumbent FTE, plus the jobs that have no position valid at the Effective Date, for enterprises that use jobs only.

Headcount counts the active and suspended employee and contingent worker assignments of the position, or for a job without positions, the assignments of the job without a position. Incumbent FTE sums their FTE assignment budget values. Vacancies is the maximum persons of the position, one if blank, minus its headcount.

Detail Level Incumbents adds one row per incumbent assignment. Detail Level Extra Information lists one row per position or job extra information record, a position row also showing the extra information of its job. Select an Information Type to show its segments as columns.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Effective Date, Business Group, Organization, Job, Position, Record Type, Vacant Only, Detail Level, Information Type

## Oracle EBS Tables Used
[per_grades_vl](https://www.enginatics.com/library/?pg=1&find=per_grades_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions), [per_valid_grades](https://www.enginatics.com/library/?pg=1&find=per_valid_grades&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions), [hr_all_positions_f_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_positions_f_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions), [per_jobs_vl](https://www.enginatics.com/library/?pg=1&find=per_jobs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions), [per_shared_types_vl](https://www.enginatics.com/library/?pg=1&find=per_shared_types_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions), [hr_all_positions_f](https://www.enginatics.com/library/?pg=1&find=hr_all_positions_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions), [per_assignment_budget_values_f](https://www.enginatics.com/library/?pg=1&find=per_assignment_budget_values_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions), [per_all_assignments_f](https://www.enginatics.com/library/?pg=1&find=per_all_assignments_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions), [per_assignment_status_types](https://www.enginatics.com/library/?pg=1&find=per_assignment_status_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions)

## Related Reports
[PER Person Assignment Upload](/PER%20Person%20Assignment%20Upload/ "PER Person Assignment Upload Oracle EBS SQL Report"), [PER New Hires](/PER%20New%20Hires/ "PER New Hires Oracle EBS SQL Report"), [PER Position Hierarchy](/PER%20Position%20Hierarchy/ "PER Position Hierarchy Oracle EBS SQL Report"), [PER Employee Assignments](/PER%20Employee%20Assignments/ "PER Employee Assignments Oracle EBS SQL Report"), [PER Employee Length of Service](/PER%20Employee%20Length%20of%20Service/ "PER Employee Length of Service Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Jobs%20and%20Positions/PER%20Jobs%20and%20Positions.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PER Jobs and Positions 15-Oct-2026 022629.xlsx](https://www.enginatics.com/example/per-jobs-and-positions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions) |
| Blitz Report™ XML Import | [PER_Jobs_and_Positions.xml](https://www.enginatics.com/xml/per-jobs-and-positions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions) |
| SQL Source | [PER Jobs and Positions.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Jobs%20and%20Positions/PER%20Jobs%20and%20Positions.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/per-jobs-and-positions/](https://www.enginatics.com/reports/per-jobs-and-positions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions) |

## Case Study & Technical Analysis: PER Jobs and Positions

### Executive Summary
This report shows the jobs and positions of an Oracle Human Resources business group as they stand on an effective date. For each position it gives the job, organization, location, status, entry grade and valid grades, FTE, maximum persons, headcount, incumbent FTE and vacancies. It also lists jobs that have no position valid on that date, for enterprises that use jobs without positions. HR planning and workforce management teams use it to see where vacancies exist, how full each position is, and which grades can be filled, and HR analysts use the extra information option to see the additional position and job data that the business group records. Blitz Report™ runs the report in Excel, where the headcount figures can be sorted and summed.

### Business Challenge
*   **Vacancy control:** Managers need to know how many places in a position are still open, and that count must reflect the people currently assigned to it.
*   **Headcount and FTE:** Budgeted headcount, FTE and the FTE that is actually filled must be compared position by position.
*   **Grade eligibility:** A vacancy can be filled only by a grade that is valid for the position, so the valid grades must be visible.

### The Solution
*   Lists each position valid on the effective date, with its job, organization, location, position type and status, entry grade and valid grades.
*   Counts the headcount of each position as the active and suspended employee and contingent worker assignments, and sums the FTE assignment budget of those assignments as the incumbent FTE.
*   Calculates Vacancies as the maximum persons of the position, treated as one if blank, minus the headcount, and not allowed below zero.
*   Adds the jobs that have no position on the effective date, with their valid grades, and counts their assignments in the same way.
*   Optionally adds one row per incumbent assignment, or one row per position or job extra information record, with the information type segments shown as columns.

### Technical Architecture (High Level)
#### Primary Tables
*   `HR_ALL_POSITIONS_F_VL` and `HR_ALL_POSITIONS_F`: the position record for the effective date, with job, organization, FTE, maximum persons, hire dates and supervisor position.
*   `PER_JOBS_VL`: the job name and the job dates.
*   `PER_SHARED_TYPES_VL`: the position status, from the availability status.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the business group and the organization of the position.
*   `HR_LOCATIONS_ALL`: the location of the position.
*   `PER_GRADES_VL` and `PER_VALID_GRADES`: the grades that are valid for a position or a job.
*   `PER_ALL_ASSIGNMENTS_F` and `PER_ASSIGNMENT_STATUS_TYPES`: the assignments and their system status, used for the headcount.
*   `PER_ASSIGNMENT_BUDGET_VALUES_F`: the FTE budget value of each assignment.

#### Logical Relationships
1. The position record is selected for the effective date and joined to the business group, the job, the status and the organization.
2. The valid grades of a position are aggregated into one text value, and grades longer than the limit are left out.
3. An inline view counts the active assignments and sums their FTE by position key, which is the position identifier or the job identifier.
4. The position and the assignment counts are joined on that key, so a position with no assignments still appears with zero headcount.
5. Jobs with no position on the date are added with a UNION ALL, so every job appears either through a position or on its own.

### Parameters & Filtering
*   **Effective Date:** the date on which positions and jobs are valid and assignments are counted.
*   **Business Group**, **Organization**, **Job** and **Position:** limit the list to one business group, organization, job or position.
*   **Record Type:** selects positions, jobs without positions, or both.
*   **Vacant Only:** shows only positions with vacancies.
*   **Detail Level:** adds one row per incumbent assignment, or one row per extra information record.
*   **Information Type:** selects an extra information type whose segments are shown as columns.

### Performance & Optimization
*   Headcount and incumbent FTE are computed once per position key in an inline view, rather than for each position row.
*   The jobs without positions are found with a NOT IN test on the effective date, so the job list does not repeat the positions.

### FAQ
**Q: How are vacancies calculated?**
A: Vacancies is the maximum persons of the position, or one if that is blank, minus its headcount. It is zero where the headcount is above the maximum.

**Q: Which assignments count as headcount?**
A: Employee and contingent worker assignments with an active or suspended status are counted, as well as the job-level assignments of a job without a position.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-jobs-and-positions)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
