---
layout: default
last_modified_at: 2026-10-26
title: 'PER Employee Length of Service | Oracle EBS SQL Report'
description: 'Active employees with calculated length of service in years and months, based on the adjusted service date (or hire date if not set). Shows milestone…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Human Resources, Enginatics, PER, Employee, Length, Service, hr_all_organization_units_vl, per_all_people_f, per_periods_of_service'
permalink: /PER%20Employee%20Length%20of%20Service/
report_name: 'PER Employee Length of Service'
report_web_name: per-employee-length-of-service
module: 'Human Resources'
module_url: /modules/human-resources/
---

# PER Employee Length of Service – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/per-employee-length-of-service/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service).
**Oracle EBS module:** [Human Resources](/modules/human-resources/ "Oracle EBS Human Resources reports") · [all Human Resources reports](/modules/human-resources/)  

## Overview
Active employees with calculated length of service in years and months, based on the adjusted service date (or hire date if not set). Shows milestone years (multiples of 5), next service anniversary, age, and current assignment details. Useful for recognition programs, benefits eligibility, and workforce tenure analysis.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Business Group, Organization, Minimum Service Years, Location

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service), [per_periods_of_service](https://www.enginatics.com/library/?pg=1&find=per_periods_of_service&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service), [per_all_assignments_f](https://www.enginatics.com/library/?pg=1&find=per_all_assignments_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service), [per_assignment_status_types_v](https://www.enginatics.com/library/?pg=1&find=per_assignment_status_types_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service), [per_jobs_vl](https://www.enginatics.com/library/?pg=1&find=per_jobs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service), [hr_all_positions_f_tl](https://www.enginatics.com/library/?pg=1&find=hr_all_positions_f_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service), [per_grades_vl](https://www.enginatics.com/library/?pg=1&find=per_grades_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service)

## Related Reports
[PER New Hires](/PER%20New%20Hires/ "PER New Hires Oracle EBS SQL Report"), [PER Employee Assignments](/PER%20Employee%20Assignments/ "PER Employee Assignments Oracle EBS SQL Report"), [PER Terminations and Separations](/PER%20Terminations%20and%20Separations/ "PER Terminations and Separations Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [PER Person Assignment Upload](/PER%20Person%20Assignment%20Upload/ "PER Person Assignment Upload Oracle EBS SQL Report"), [PAY Hire to Retire Tracker](/PAY%20Hire%20to%20Retire%20Tracker/ "PAY Hire to Retire Tracker Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Employee%20Length%20of%20Service/PER%20Employee%20Length%20of%20Service.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/per-employee-length-of-service/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service) |
| Blitz Report™ XML Import | [PER_Employee_Length_of_Service.xml](https://www.enginatics.com/xml/per-employee-length-of-service/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service) |
| SQL Source | [PER Employee Length of Service.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Employee%20Length%20of%20Service/PER%20Employee%20Length%20of%20Service.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/per-employee-length-of-service/](https://www.enginatics.com/reports/per-employee-length-of-service/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service) |

## Case Study & Technical Analysis: PER Employee Length of Service

### Executive Summary
The PER Employee Length of Service report lists the active employees of an Oracle HRMS business group with their calculated length of service in years and months. It is based on the adjusted service date, or the original hire date when no adjusted date is set, and it shows the milestone years, the next service anniversary, the age and the current assignment. Human resources teams use it for recognition programs, for benefits and leave eligibility that depend on tenure, and for workforce tenure analysis. The report runs in Excel through Blitz Report, where the rows can be sorted and filtered further.

### Business Challenge
*   **Recognition programs:** Service awards are given at fixed milestone years, and HR needs the list of employees who reach each milestone.
*   **Benefit eligibility:** Entitlements such as leave accrual or pension vesting depend on service years, and the adjusted service date must be used rather than the hire date when a prior service adjustment exists.
*   **Workforce planning:** Tenure distribution by organization, location and grade shows where experience is concentrated and where succession risk sits.
*   **Accurate dates:** A service calculation that ignores a break in service or an adjusted date gives the wrong entitlement, so the report starts from the periods of service.

### The Solution
*   Calculates service years and service months from the adjusted service date, or the original date of hire where no adjustment is recorded.
*   Shows the milestone years, which are the completed service years that are multiples of five, and the next service anniversary date.
*   Shows the age from the date of birth, the hire date and the adjusted service date.
*   Shows the current assignment: organization, job, position, grade, location, supervisor and assignment status, with the employment category.

### Technical Architecture (High Level)
#### Primary Tables
*   `PER_ALL_PEOPLE_F`: the employee record, with the employee number, name, date of birth, sex and original date of hire.
*   `PER_PERIODS_OF_SERVICE`: the period of service, with the adjusted service date and the actual termination date.
*   `PER_ALL_ASSIGNMENTS_F`: the primary employee assignment, with its organization, job, position, grade, location, supervisor and status.
*   `PER_ASSIGNMENT_STATUS_TYPES_V`: the user status of the assignment.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the business group and the assignment organization.
*   `PER_JOBS_VL`, `HR_ALL_POSITIONS_F_TL`, `PER_GRADES_VL` and `HR_LOCATIONS_ALL`: the job, position, grade and location names.

#### Logical Relationships
1.  `PER_ALL_PEOPLE_F` is restricted to the rows valid today, and joined to `PER_PERIODS_OF_SERVICE` on the person id, where the actual termination date is empty.
2.  `PER_ALL_ASSIGNMENTS_F` is restricted to the rows valid today, and the primary assignment of type E is taken for each person.
3.  The business group comes from `HR_ALL_ORGANIZATION_UNITS_VL` on the person's business group id, and the assignment organization from a second organization join.
4.  The supervisor is an outer join to a second copy of the people view valid today, and the job, position, grade and location are outer joins to their reference views.
5.  Service years and months are computed from the months between the current date and the adjusted or hire date.

### Parameters & Filtering
*   **Business Group:** the business group whose employees are listed.
*   **Organization:** limits the employees to one assignment organization.
*   **Minimum Service Years:** keeps the employees whose service years are at least the value entered.
*   **Location:** limits the employees to one work location.

### Performance & Optimization
*   The people and assignment tables are filtered to their current effective rows in inline views, so each person has one row for the current date.
*   The supervisor is read through a second copy of the current people view, joined by an outer join, so it does not add rows for employees without a supervisor.
*   The service calculation is performed once in the select list, and the ordering reuses the same expression, so the sort does not change the result.
*   Business Group and Organization are the most selective parameters, and should be set on a large workforce.

### FAQ
**Q: How is length of service calculated?**
A: Service years are the whole number of years between the adjusted service date, or the original hire date if none is set, and today. Service months are the remaining months.

**Q: Which employees are listed?**
A: Active employees with a primary employee assignment of type E and no actual termination date on their period of service.

**Q: How is the milestone year determined?**
A: A milestone year is shown when the service years are a multiple of five and greater than zero. Otherwise the column is blank.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-employee-length-of-service)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
