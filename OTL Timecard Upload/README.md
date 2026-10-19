---
layout: default
last_modified_at: 2026-10-19
title: 'OTL Timecard Upload | Oracle EBS SQL Report'
description: 'OTL Timecard Upload =================== Create, update and delete Oracle Time and Labor (OTL / HXC) timecards via the public TimeStore deposit API…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, OTL, Timecard, hxc_transaction_details, hxc_transactions, hxc_timecard_summary'
permalink: /OTL%20Timecard%20Upload/
report_name: 'OTL Timecard Upload'
report_web_name: otl-timecard-upload
---

# OTL Timecard Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/otl-timecard-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload).

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Employee, Period Start Date From, Period Start Date To, Approval Status, Organization

## Oracle EBS Tables Used
[hxc_transaction_details](https://www.enginatics.com/library/?pg=1&find=hxc_transaction_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload), [hxc_transactions](https://www.enginatics.com/library/?pg=1&find=hxc_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload), [hxc_timecard_summary](https://www.enginatics.com/library/?pg=1&find=hxc_timecard_summary&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload), [hxc_time_building_blocks](https://www.enginatics.com/library/?pg=1&find=hxc_time_building_blocks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload), [hxc_time_attribute_usages](https://www.enginatics.com/library/?pg=1&find=hxc_time_attribute_usages&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload), [hxc_time_attributes](https://www.enginatics.com/library/?pg=1&find=hxc_time_attributes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload), [pay_element_types_f](https://www.enginatics.com/library/?pg=1&find=pay_element_types_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload)

## Related Reports
[OTL Timecard Upload 11i](/OTL%20Timecard%20Upload%2011i/ "OTL Timecard Upload 11i Oracle EBS SQL Report"), [PA Missing Timecards](/PA%20Missing%20Timecards/ "PA Missing Timecards Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OTL%20Timecard%20Upload/OTL%20Timecard%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/otl-timecard-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload) |
| Blitz Report™ XML Import | [OTL_Timecard_Upload.xml](https://www.enginatics.com/xml/otl-timecard-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload) |
| SQL Source | [OTL Timecard Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OTL%20Timecard%20Upload/OTL%20Timecard%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/otl-timecard-upload/](https://www.enginatics.com/reports/otl-timecard-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload) |

## Case Study & Technical Analysis: OTL Timecard Upload

### Executive Summary
This upload creates, updates, submits and deletes Oracle Time and Labor (OTL) timecards. It is an Excel-based alternative to employee self-service time entry: a timekeeper or project administrator downloads the timecards of employees, enters or corrects hours by day and classification, and uploads them. Each line is charged either to a project, task and expenditure type, or to a payroll element. The upload calls the public TimeStore deposit API, so the rules of self-service time entry, including approval routing, apply to every timecard. It is used for timecard catch-up at period end, for bulk corrections after a project reclassification, and for resubmitting timecards that were rejected. Blitz Report™ provides the spreadsheet layout used for these corrections.

### Business Challenge
*   **Late or missing time entry:** Employees who do not enter their time on schedule delay project costing and payroll, and the timekeeper must catch up on their behalf.
*   **Reclassifying time:** Hours charged to the wrong project, task or expenditure type must be corrected across many days and employees.
*   **Approval routing:** Corrected timecards must go back through the approval workflow, and the approval status of each timecard must be visible.

### The Solution
*   Downloads timecards by employee and timecard period, with one row for each timecard line and day, showing the classification, hours and comments.
*   Shows the approval status, the submission date and whether the timecard has been transferred to a recipient application.
*   Derives the period starting date from the employee's Oracle Time and Labor preferences, so rows are grouped into the correct timecard.
*   Accepts a Submit flag on any row of a timecard to start the approval workflow, and it re-submits timecards that are already Submitted or Approved when they are updated.
*   Accepts a Delete Line flag, and deleting all lines of a timecard deletes the whole timecard.

### Technical Architecture (High Level)
#### Primary Tables
*   `HXC_TIMECARD_SUMMARY`: the timecard header, with the resource, approval status, submission date and start time.
*   `HXC_TIME_BUILDING_BLOCKS`: the timecard, day and detail building blocks, with the scope, date range and measure.
*   `HXC_TIME_ATTRIBUTES` and `HXC_TIME_ATTRIBUTE_USAGES`: the classification attributes of each detail, such as project, task and expenditure type, or the element.
*   `HXC_TRANSACTIONS` and `HXC_TRANSACTION_DETAILS`: the deposit history, used to decide whether a line has been transferred.
*   `PER_ALL_PEOPLE_F`: the employee name and number, effective on the timecard date.
*   `PA_PROJECTS_ALL` and `PA_TASKS`: the project number and task number.
*   `PAY_ELEMENT_TYPES_F`: the payroll element name of a payroll classification.

#### Logical Relationships
1. `HXC_TIMECARD_SUMMARY` is joined to the employee in `PER_ALL_PEOPLE_F` on the resource identifier, with the employee effective on the start of the timecard.
2. The day building block is a child of the timecard, and the detail building block is a child of the day.
3. Each detail links to its attributes through `HXC_TIME_ATTRIBUTE_USAGES`, and to `HXC_TIME_ATTRIBUTES` for the values.
4. A project classification is taken from the project and task identifiers in the attribute values, and an element classification from the element identifier in the attribute category.
5. The project, task and element are outer joined, so payroll and project lines are both returned.
6. A detail is marked as transferred when a successful retrieval transaction exists for its building block.

### Parameters & Filtering
*   **Upload Mode:** selects create with an empty template, or create and update with existing timecards downloaded.
*   **Employee:** limits the download to one employee.
*   **Period Start Date From** and **Period Start Date To:** bound the start date of the timecard periods.
*   **Approval Status:** limits the timecards to one approval status.
*   **Organization:** limits the employees to those whose primary assignment is in the organization at the start of the period.

### Performance & Optimization
*   The day and detail building blocks are selected by scope and by an open-ended date, so only current versions of each building block are read.
*   The transfer check is an EXISTS test on the deposit history, so it returns one answer for each detail without a separate join.
*   Attribute values are read only for the project and element classifications, which reduces the rows read from the attribute tables.

### FAQ
**Q: How do I resubmit a rejected timecard?**
A: Download the timecard, correct the lines, and set Submit to Yes on any row of that timecard. Upload with Create, Update.

**Q: Why can I not change a timecard?**
A: Timecards already transferred to Projects, Payroll or Purchasing are protected, and the upload cannot modify them.

**Q: Which responsibility should run the upload?**
A: Run it under a responsibility whose operating unit matches the projects being charged, such as the OTL or Projects responsibility that the employees use.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=otl-timecard-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
