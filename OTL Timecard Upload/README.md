---
layout: default
title: 'OTL Timecard Upload | Oracle EBS SQL Report'
description: 'OTL Timecard Upload =================== Create, update and delete Oracle Time and Labor (OTL / HXC) timecards via the public TimeStore deposit API…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, OTL, Timecard, hxc_transaction_details, hxc_transactions, hxc_timecard_summary'
permalink: /OTL%20Timecard%20Upload/
---

# OTL Timecard Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/otl-timecard-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

Upload modes
============
Create - empty template for new timecards.
Create, Update - downloads existing timecards (project and payroll element lines) for review, correction, resubmission or deletion.

## Report Parameters
Upload Mode, Employee, Period Start Date From, Period Start Date To, Approval Status

## Oracle EBS Tables Used
[hxc_transaction_details](https://www.enginatics.com/library/?pg=1&find=hxc_transaction_details), [hxc_transactions](https://www.enginatics.com/library/?pg=1&find=hxc_transactions), [hxc_timecard_summary](https://www.enginatics.com/library/?pg=1&find=hxc_timecard_summary), [hxc_time_building_blocks](https://www.enginatics.com/library/?pg=1&find=hxc_time_building_blocks), [hxc_time_attribute_usages](https://www.enginatics.com/library/?pg=1&find=hxc_time_attribute_usages), [hxc_time_attributes](https://www.enginatics.com/library/?pg=1&find=hxc_time_attributes), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks), [pay_element_types_f](https://www.enginatics.com/library/?pg=1&find=pay_element_types_f)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/otl-timecard-upload/) |
| Blitz Report™ XML Import | [OTL_Timecard_Upload.xml](https://www.enginatics.com/xml/otl-timecard-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/otl-timecard-upload/](https://www.enginatics.com/reports/otl-timecard-upload/) |



---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
