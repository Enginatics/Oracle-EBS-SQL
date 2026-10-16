---
layout: default
last_modified_at: 2026-10-16
title: 'PER Position Hierarchy | Oracle EBS SQL Report'
description: 'Position hierarchy showing the reporting structure of positions with hierarchy level, organization, job, grade, location, budgeted vs actual headcount…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Human Resources, BI Publisher, Enginatics, PER, Position, Hierarchy, per_all_assignments_f, per_assignment_status_types, per_all_people_f'
permalink: /PER%20Position%20Hierarchy/
report_name: 'PER Position Hierarchy'
report_web_name: per-position-hierarchy
module: 'Human Resources'
module_url: /modules/human-resources/
---

# PER Position Hierarchy – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/per-position-hierarchy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy).
**Oracle EBS module:** [Human Resources](/modules/human-resources/ "Oracle EBS Human Resources reports") · [all Human Resources reports](/modules/human-resources/)  

## Overview
Position hierarchy showing the reporting structure of positions with hierarchy level, organization, job, grade, location, budgeted vs actual headcount, vacancy count, and current incumbent names. Useful for position control, staffing analysis, and org chart construction.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Business Group, Hierarchy Name

## Oracle EBS Tables Used
[per_all_assignments_f](https://www.enginatics.com/library/?pg=1&find=per_all_assignments_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy), [per_assignment_status_types](https://www.enginatics.com/library/?pg=1&find=per_assignment_status_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy), [per_pos_structure_versions](https://www.enginatics.com/library/?pg=1&find=per_pos_structure_versions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy), [per_pos_structure_elements](https://www.enginatics.com/library/?pg=1&find=per_pos_structure_elements&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy), [hr_all_positions_f](https://www.enginatics.com/library/?pg=1&find=hr_all_positions_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy), [hr_all_positions_f_tl](https://www.enginatics.com/library/?pg=1&find=hr_all_positions_f_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy), [per_jobs_vl](https://www.enginatics.com/library/?pg=1&find=per_jobs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy), [per_grades_vl](https://www.enginatics.com/library/?pg=1&find=per_grades_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy), [per_position_structures](https://www.enginatics.com/library/?pg=1&find=per_position_structures&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy)

## Report Categories
[BI Publisher](https://www.enginatics.com/library/?pg=1&category%5B%5D=BI%20Publisher&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy), [Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy)

## Related Reports
[GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Position%20Hierarchy/PER%20Position%20Hierarchy.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PER Position Hierarchy 07-Apr-2018 164044.xlsx](https://www.enginatics.com/example/per-position-hierarchy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy) |
| Blitz Report™ XML Import | [PER_Position_Hierarchy.xml](https://www.enginatics.com/xml/per-position-hierarchy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy) |
| SQL Source | [PER Position Hierarchy.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Position%20Hierarchy/PER%20Position%20Hierarchy.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/per-position-hierarchy/](https://www.enginatics.com/reports/per-position-hierarchy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy) |

## Case Study & Technical Analysis: PER Position Hierarchy

### Executive Summary
This report shows the reporting structure of positions in an Oracle Human Resources position hierarchy, with each position's level, organization, job, grade, location, budgeted and actual headcount, vacancy count and current incumbents. HR position-control teams, staffing analysts and organization designers use it to review the structure, check how many approved positions are filled and build organization charts. It is a BI Publisher and Enginatics report that runs in Excel through Blitz Report™.

### Business Challenge
*   **Position control:** Each position has a budgeted headcount, and HR must know where the approved headcount is exceeded or left vacant.
*   **Structure review:** Reporting lines between positions must be visible as a tree, not as a flat list, to check that the hierarchy is correct.
*   **Vacancy management:** Vacant positions need to be identified with their job, grade and location so that recruitment can be planned.
*   **Org chart construction:** Charts and structure reviews need the incumbents of each position, shown beside the position itself.

### The Solution
*   Walks the position structure version of a hierarchy from its top positions downwards, showing each position indented by its level.
*   Shows the organization, job, grade, location and full-time equivalent of each position, with its budgeted headcount.
*   Counts the active primary assignments in each position as the actual headcount, and subtracts that count from the budgeted headcount to give the vacancy count.
*   Lists the names of the current incumbents of each position, and the position's start date, end date and status.

### Technical Architecture (High Level)
#### Primary Tables
*   `PER_POS_STRUCTURE_VERSIONS` and `PER_POSITION_STRUCTURES`: the hierarchy definition and the version in effect.
*   `PER_POS_STRUCTURE_ELEMENTS`: the parent and subordinate position links of each version.
*   `HR_ALL_POSITIONS_F` and `HR_ALL_POSITIONS_F_TL`: the positions, with their effective dates, budgeted headcount, FTE and status, and the position names.
*   `PER_ALL_ASSIGNMENTS_F`: the assignments that occupy each position, with primary flag, assignment type and status.
*   `PER_ASSIGNMENT_STATUS_TYPES`: the system status of each assignment, used to count active assignments.
*   `PER_ALL_PEOPLE_F`: the incumbents' names, valid on the current date.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the business group and the position organization.
*   `PER_JOBS_VL` and `PER_GRADES_VL`: the job and grade of the position.
*   `HR_LOCATIONS_ALL`: the location of the position.

#### Logical Relationships
1.  The hierarchy structure is restricted to the version whose date range includes the current date, and to the business group.
2.  Positions are limited to those whose effective dates include the current date, and each position is joined to its structure element.
3.  The hierarchy is walked by connecting each subordinate position to its parent within the same structure version, starting from the positions that have no parent in that version.
4.  The level of each position is the depth of the walk, which the report uses to indent the position name.
5.  Actual headcount and incumbents are counted from primary, active employee assignments that are effective on the current date.
6.  Siblings are ordered by position name at each level.

### Parameters & Filtering
*   **Business Group:** the business group whose hierarchies are reported.
*   **Hierarchy Name:** the position hierarchy to report on.

### Performance & Optimization
*   The hierarchy walk uses the connect-by structure of the position elements, so the query follows the reporting lines directly rather than through repeated self-joins.
*   The actual headcount, vacancy count and incumbent subqueries repeat the same assignment filter, so each position is checked against its own assignments only.
*   The counts and the incumbent names are correlated subqueries, so the cost grows with the number of positions in the hierarchy.
*   Restricting the report to one hierarchy and one business group limits the walk to a single structure version.

### FAQ
**Q: How is the vacancy count calculated?**
A: The vacancy count is the budgeted headcount, which defaults to one when no maximum is set, less the number of active primary employee assignments in the position.

**Q: Who is shown as an incumbent?**
A: Incumbents are the people with a primary, active employee assignment in the position that is effective on the current date, listed in name order.

**Q: How are the levels of the hierarchy shown?**
A: The level is the depth of the position in the walk from the top of the hierarchy, and the position name is indented by three spaces for each level below the first.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-position-hierarchy)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
