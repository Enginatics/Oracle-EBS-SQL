---
layout: default
last_modified_at: 2026-10-19
title: 'OTL Timecard Upload 11i | Oracle EBS SQL Report'
description: 'OTL Timecard Upload =================== Create, update and delete Oracle Time and Labor (OTL / HXC) timecards via the public TimeStore deposit API…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, OTL, Timecard, 11i, hxc_transaction_details, hxc_transactions, pay_element_types_f'
permalink: /OTL%20Timecard%20Upload%2011i/
report_name: 'OTL Timecard Upload 11i'
report_web_name: otl-timecard-upload-11i
---

# OTL Timecard Upload 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/otl-timecard-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i).

## Overview
OTL Timecard Upload
===================
Create, update and delete Oracle Time and Labor (OTL / HXC) timecards via the public TimeStore deposit API hxc_timestore_deposit, as an Excel-based alternative to self-service time entry.

Row model
=========
One spreadsheet row per timecard line and day: Employee, Date, classification and Hours. Rows are grouped into timecards by employee and the OTL timecard period (e.g. the weekly period from the employee's OTL preferences) containing the Date. Rows of the same employee and period must be contiguous and are deposited together as one timecard. The Period Starting column fills automatically once Employee and Date are entered.

Classification
==============
Each line is classified either for Projects (Project, Task and Expenditure Type - straight time) or for Payroll (Hours Type = payroll element). The deposit derives the employee's application set, approval style and security context from the OTL preferences, exactly like self-service time entry.

Run the upload under a responsibility whose operating unit context matches the projects being charged (e.g. the OTL or Projects responsibility the employees use) - the deposit validates the project, task, expenditure type and expenditure organization under the session's operating unit, exactly like self-service time entry.

Save and submit
===============
Leave Submit blank to save the timecard in Working status. Set Submit to Yes on any row of a timecard to submit it for approval (the OTL approval workflow starts, e.g. HR supervisor approval). Updating a timecard that is already Submitted or Approved re-submits it for approval automatically.

Updates and deletes
===================
Downloaded lines carry hidden building block ids and are updated through the OTL deposit API, which creates a new timecard version and re-routes approval. Set Delete Line to Yes to remove a line; deleting all lines of a timecard deletes the whole timecard. Timecards already transferred to a recipient application (Projects, Payroll/BEE or Purchasing) are protected and cannot be modified by the upload.

Download
========
Submission Date is the date the timecard was last submitted for approval. Organization restricts the download to employees whose primary assignment belongs to the organization at the start of the timecard period.

Upload modes
============
Create - empty template for new timecards.
Create, Update - downloads existing timecards (project and payroll element lines) for review, correction, resubmission or deletion.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Employee, Period Start Date From, Period Start Date To, Approval Status, Organization

## Oracle EBS Tables Used
[hxc_transaction_details](https://www.enginatics.com/library/?pg=1&find=hxc_transaction_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i), [hxc_transactions](https://www.enginatics.com/library/?pg=1&find=hxc_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i), [pay_element_types_f](https://www.enginatics.com/library/?pg=1&find=pay_element_types_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i), [hxc_timecard_summary](https://www.enginatics.com/library/?pg=1&find=hxc_timecard_summary&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i), [hxc_time_building_blocks](https://www.enginatics.com/library/?pg=1&find=hxc_time_building_blocks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i), [hxc_time_attribute_usages](https://www.enginatics.com/library/?pg=1&find=hxc_time_attribute_usages&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i), [hxc_time_attributes](https://www.enginatics.com/library/?pg=1&find=hxc_time_attributes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i)

## Related Reports
[OTL Timecard Upload](/OTL%20Timecard%20Upload/ "OTL Timecard Upload Oracle EBS SQL Report"), [PA Missing Timecards](/PA%20Missing%20Timecards/ "PA Missing Timecards Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OTL%20Timecard%20Upload%2011i/OTL%20Timecard%20Upload%2011i.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/otl-timecard-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i) |
| Blitz Report™ XML Import | [OTL_Timecard_Upload_11i.xml](https://www.enginatics.com/xml/otl-timecard-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i) |
| SQL Source | [OTL Timecard Upload 11i.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OTL%20Timecard%20Upload%2011i/OTL%20Timecard%20Upload%2011i.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/otl-timecard-upload-11i/](https://www.enginatics.com/reports/otl-timecard-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i) |

## Case Study & Technical Analysis: OTL Timecard Upload 11i

### Executive Summary
The OTL Timecard Upload 11i report creates, updates and deletes Oracle Time and Labor (OTL, also known as HXC) timecards from a spreadsheet. It uses the public TimeStore deposit API, so the timecards follow the same rules as self-service time entry. It is an Excel-based alternative for timekeepers and payroll or projects administrators who must enter or correct timecards for many employees, and it supports both project charging and payroll element hours. Each row is one timecard line for one day, and the upload groups lines into timecards by employee and timecard period.

### Business Challenge
*   **Bulk time entry:** Timekeepers entering corrections or late time for many employees cannot do it efficiently in self-service screens one timecard at a time.
*   **Project charging accuracy:** Hours charged to projects must reference a valid project, task and expenditure type under the right operating unit, and errors are costly to correct later.
*   **Approval control:** Timecards must be saved, submitted and routed for approval in a controlled way, and resubmission after a change needs to happen automatically.
*   **Protected records:** Timecards already transferred to Projects, Payroll or Purchasing must not be changed, and users need to see which timecards are protected before they try.

### The Solution
*   **Row per day and classification:** Each row carries the employee, date, classification and hours. Rows of the same employee and period are deposited as one timecard.
*   **Project or payroll classification:** A line is either a project line, with project, task and expenditure type, or a payroll line, with an hours type that is a payroll element.
*   **Save or submit per row:** Leaving Submit blank saves the timecard in Working status, and setting Submit to Yes on any row starts the approval workflow for the timecard.
*   **Update and delete handling:** Downloaded lines carry the building block IDs needed to update through the deposit API, and deleting every line of a timecard removes the timecard.

### Technical Architecture (High Level)
#### Primary Tables
*   `HXC_TIMECARD_SUMMARY`: the timecard header, with its approval status, submission date, start time and resource.
*   `HXC_TIME_BUILDING_BLOCKS`: the timecard, day and detail building blocks that hold the time entries.
*   `HXC_TIME_ATTRIBUTE_USAGES` and `HXC_TIME_ATTRIBUTES`: the attributes attached to each detail, which carry the project, task, expenditure type or element.
*   `HXC_TRANSACTIONS` and `HXC_TRANSACTION_DETAILS`: the transfer history, used to flag timecards already transferred.
*   `PER_ALL_PEOPLE_F`: the employee, with name and employee number, effective on the timecard start date.
*   `PAY_ELEMENT_TYPES_F`: the payroll element name for payroll lines.
*   `PA_PROJECTS_ALL` and `PA_TASKS`: the project and task of project lines.

#### Logical Relationships
1.  `HXC_TIMECARD_SUMMARY` is joined to the employee in `PER_ALL_PEOPLE_F` on the resource ID, with the employee record effective on the timecard start date.
2.  The day building block is joined to the timecard on the timecard ID and version, and restricted to the day scope and an open-ended date.
3.  The detail building block is joined to the day building block, restricted to the detail scope.
4.  Attribute usages link the detail to its attributes. Only PROJECTS and element attribute categories are kept.
5.  Project and task are outer joined from the PROJECTS attribute values, and the payroll element name is looked up by the element type ID and the day's date.
6.  A subquery checks the transfer history, so a timecard with a successful retrieval transaction is flagged as transferred.

### Parameters & Filtering
*   **Upload Mode:** Create returns an empty template, and Create, Update downloads existing timecards for review, correction or deletion.
*   **Employee:** Limits the download to one employee.
*   **Period Start Date From and Period Start Date To:** Restrict the timecards to a range of period start dates.
*   **Approval Status:** Limits the download to timecards in one approval status.
*   **Organization:** Restricts the download to employees whose primary assignment belongs to the organization at the start of the timecard period.

### Performance & Optimization
*   **Scope-specific joins:** The day and detail scopes are filtered on their scope values and open-ended dates, so only current building blocks are read.
*   **Attribute category filter:** Only PROJECTS and element attribute categories are joined, so other attributes do not multiply the rows.
*   **Transfer check as a subquery:** Transfer status is tested with an EXISTS subquery, so each detail is checked once and the main rows are not multiplied.

### FAQ
**Q: How do I submit a timecard for approval through the upload?**
A: Set Submit to Yes on any row of the timecard. The OTL approval workflow then starts for the timecard.
**Q: What happens if I change a timecard that is already approved?**
A: The upload resubmits it for approval automatically, and the update creates a new timecard version that re-routes approval.
**Q: Why can I not change some downloaded timecards?**
A: Timecards already transferred to Projects, Payroll or Purchasing are protected, and the report flags them as transferred.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload-11i)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
