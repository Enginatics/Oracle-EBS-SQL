---
layout: default
last_modified_at: 2026-10-26
title: 'PER Person Assignment Upload | Oracle EBS SQL Report'
description: 'Upload to create and update employee assignments as in the Assignment window of the People form: organization, job, position, grade, payroll, location…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, PER, Person, Assignment, hr_all_organization_units_vl, pay_people_groups, per_jobs_vl'
permalink: /PER%20Person%20Assignment%20Upload/
report_name: 'PER Person Assignment Upload'
report_web_name: per-person-assignment-upload
---

# PER Person Assignment Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/per-person-assignment-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload).

## Overview
Upload to create and update employee assignments as in the Assignment window of the People form: organization, job, position, grade, payroll, location, status, categories, supervisor, probation and notice periods, standard conditions, statutory information, salary basis, people group and the Additional Assignment Details flexfield.

Changes are made as of the Effective Date. When Datetrack Mode is blank, the assignment is corrected if the Effective Date is its start date, and otherwise a change is inserted from the Effective Date (Update, or Update - Insert when later changes exist).

A new row without an existing Assignment Number creates a secondary assignment with hr_assignment_api.create_secondary_emp_asg. The primary assignment is created when the person is hired with the PER Person Upload.

A Status of another system status suspends, reactivates or terminates the assignment. People Group and Statutory Information take the concatenated segment values and create new combinations as needed.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Business Group, Effective Date, Employee Number, Organization, Job, Location, Payroll, Primary Assignments Only

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload), [pay_people_groups](https://www.enginatics.com/library/?pg=1&find=pay_people_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload), [per_jobs_vl](https://www.enginatics.com/library/?pg=1&find=per_jobs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload), [hr_positions_f](https://www.enginatics.com/library/?pg=1&find=hr_positions_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload), [per_grades_vl](https://www.enginatics.com/library/?pg=1&find=per_grades_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload), [pay_all_payrolls_f](https://www.enginatics.com/library/?pg=1&find=pay_all_payrolls_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload), [hr_locations_all_vl](https://www.enginatics.com/library/?pg=1&find=hr_locations_all_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload), [per_assignment_status_types_v](https://www.enginatics.com/library/?pg=1&find=per_assignment_status_types_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload), [hr_soft_coding_keyflex](https://www.enginatics.com/library/?pg=1&find=hr_soft_coding_keyflex&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload), [per_pay_bases](https://www.enginatics.com/library/?pg=1&find=per_pay_bases&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload), [per_business_groups](https://www.enginatics.com/library/?pg=1&find=per_business_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload), [per_all_assignments_f](https://www.enginatics.com/library/?pg=1&find=per_all_assignments_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload)

## Related Reports
[PAY Hire to Retire Tracker](/PAY%20Hire%20to%20Retire%20Tracker/ "PAY Hire to Retire Tracker Oracle EBS SQL Report"), [PER Payroll Element Link Upload](/PER%20Payroll%20Element%20Link%20Upload/ "PER Payroll Element Link Upload Oracle EBS SQL Report"), [PER Employee Assignments](/PER%20Employee%20Assignments/ "PER Employee Assignments Oracle EBS SQL Report"), [PER New Hires](/PER%20New%20Hires/ "PER New Hires Oracle EBS SQL Report"), [PER Position Upload](/PER%20Position%20Upload/ "PER Position Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Person%20Assignment%20Upload/PER%20Person%20Assignment%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/per-person-assignment-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload) |
| Blitz Report™ XML Import | [PER_Person_Assignment_Upload.xml](https://www.enginatics.com/xml/per-person-assignment-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload) |
| SQL Source | [PER Person Assignment Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PER%20Person%20Assignment%20Upload/PER%20Person%20Assignment%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/per-person-assignment-upload/](https://www.enginatics.com/reports/per-person-assignment-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload) |

## Case Study & Technical Analysis: PER Person Assignment Upload

### Executive Summary
This upload creates and updates employee assignments in Oracle Human Resources, covering the same fields as the Assignment window of the People form. HR administrators and HR operations teams use it to change the organization, job, position, grade, payroll, location, status, supervisor and conditions of many employees as of one effective date, with changes made through the standard assignment APIs. It is an R12 upload that runs in Excel through Blitz Report™.

### Business Challenge
*   **Mass changes:** Reorganizations, grade and pay changes, and relocations affect many assignments at the same time, and entering them one at a time is slow and error-prone.
*   **Effective dating:** Each change takes effect on a date, and it must correctly correct, insert or end the existing assignment record for that date.
*   **Reference data:** Organizations, jobs, positions, grades, payrolls, locations and people groups must all be valid as of the effective date.
*   **Statutory and status data:** Assignment status, statutory information and category codes must be consistent with the employee's current position in the organization.

### The Solution
*   Downloads the current assignments of the business group as of the effective date, with the employee, assignment number, organization, job, position, grade, payroll, location and status of each.
*   Shows the supervisor, probation and notice periods, working hours, frequency, salary basis, bargaining unit and union membership of each assignment.
*   Changes the assignment as of the effective date when Datetrack Mode is blank, correcting the record where the date is its start date and inserting a change otherwise.
*   Creates a secondary assignment when a row has no existing assignment number, using the secondary assignment creation API.

### Technical Architecture (High Level)
#### Primary Tables
*   `PER_ALL_ASSIGNMENTS_F`: the effective-dated assignments, with organization, job, position, grade, payroll, location, status, supervisor and conditions.
*   `PER_ALL_PEOPLE_F`: the employee, with employee number, full name and current employee flag.
*   `PER_BUSINESS_GROUPS`: the business group that restricts the people and assignments.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the organization name.
*   `PER_JOBS_VL` and `PER_GRADES_VL`: the job and grade names.
*   `HR_POSITIONS_F`: the position name, valid on the effective date.
*   `PAY_ALL_PAYROLLS_F`: the payroll name, valid on the effective date.
*   `HR_LOCATIONS_ALL_VL`: the location code.
*   `PAY_PEOPLE_GROUPS`: the people group name.
*   `PER_ASSIGNMENT_STATUS_TYPES_V`: the user status of the assignment.
*   `HR_SOFT_CODING_KEYFLEX`: the statutory information key flexfield combination.
*   `PER_PAY_BASES`: the salary basis name.

#### Logical Relationships
1.  The business group identifier restricts the people, which are joined to their assignments on the person identifier.
2.  Only current employees, and only assignments of type E, are kept, and both the person and the assignment must be effective on the effective date.
3.  Organization, job, grade, people group, location, status and salary basis are each resolved by a lookup on their identifier.
4.  Position and payroll are resolved only where they are effective on the effective date.
5.  Supervisor number and name are taken from the supervisor's person record effective on the effective date.
6.  The additional assignment details flexfield is displayed under the assignment flexfield context, and the upload row is held at zero for each downloaded row.

### Parameters & Filtering
*   **Upload Mode:** sets whether existing assignments are changed or new ones are created.
*   **Business Group:** the business group whose employees are listed.
*   **Effective Date:** the date on which the changes take effect and the date of the reference lookups.
*   **Employee Number:** limits the output to one employee.
*   **Organization**, **Job**, **Location** and **Payroll:** restrict the assignments by those values.
*   **Primary Assignments Only:** restricts the output to primary assignments.

### Performance & Optimization
*   The effective date is a single bound value used in every lookup, so each reference is resolved as of one date.
*   The lookups are scalar subqueries, one per reference per assignment, so the number of assignments in the business group drives the run time.
*   Restricting the business group and effective date keeps the assignment set to the population effective on that date.

### FAQ
**Q: How is a change made as of the effective date?**
A: When Datetrack Mode is blank, an assignment is corrected if the effective date is its start date, otherwise a change is inserted from the effective date.

**Q: How is a secondary assignment created?**
A: A new row without an existing assignment number creates a secondary assignment, and the primary assignment is created at hire with the PER Person Upload.

**Q: What does a Status of another system status do?**
A: A status of another system status suspends, reactivates or terminates the assignment according to that status.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=per-person-assignment-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
