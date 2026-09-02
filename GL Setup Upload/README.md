---
layout: default
title: 'GL Setup Upload | Oracle EBS SQL Report'
description: 'Create and update the General Ledger setup entities that the GL Setup menu maintains, replicating the Calendars (GLXSTCAL), Period Types (GLXSTPTY)…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Setup, gl_period_types, gl_period_sets, gl_periods'
permalink: /GL%20Setup%20Upload/
---

# GL Setup Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-setup-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Create and update the General Ledger setup entities that the GL Setup menu maintains, replicating the Calendars (GLXSTCAL), Period Types (GLXSTPTY), Journal Sources (GLXSTSRC), Journal Categories (GLXSTCAT), Encumbrance Types (GLXSTENC), Statistical Units of Measure (GLXSTUOM), Ledger Sets (GLXSTLST), Data Access Sets (GLXSTACC), Journal Reversal Criteria (GLXSTARV) and AutoPost Criteria (GLXSTAPO) forms, plus ledger options.

Each row is one of fifteen entity types, chosen in the Row Type column. Only the columns belonging to that entity are read; all other columns are ignored. A template is supplied for every entity, which shows only that entity's columns and sets the Row Type automatically.

- Period Type: creates or updates a period type. Periods Per Year and Year Type In Name are required to create one and cannot be changed afterwards.

- Calendar Period: creates or updates one period of a calendar. The calendar itself is created together with its first period, so a new calendar name can be entered. Enter either a Period Name or a Period Prefix; a prefix is expanded to prefix-YY. Periods that have already been used can only have their description and flexfield changed. Set Delete Period to Yes to remove an unused period.

- Journal Source: creates or updates a journal source, including Import Journal References, Require Journal Approval, Import Using Key, Freeze Journals and the Effective Date Rule.

- Journal Category: creates or updates a journal category. Creating one also seeds its document sequence category and its autoreverse options for every ledger.

- Encumbrance Type: creates or updates an encumbrance type and its Enabled flag.

- Statistical Unit of Measure: assigns a unit of measure to a natural account segment value of a chart of accounts. Set Delete Stat UOM to Yes to remove the assignment.

- Ledger: updates the options of an existing ledger. Ledgers cannot be created, because only the Accounting Setup Manager can create the accounting setup around one.

- Ledger Set and Data Access Set: creates or updates the set. The chart of accounts, calendar, period type and short name are fixed once the set exists. Neither can be deleted by the upload.

- Ledger Set Assignment and Data Access Set Assignment: adds a member ledger, or removes one with Delete Assignment. Assignments are staged, so the General Ledger Accounting Setup Program is submitted automatically, once per chart of accounts, and its request id is reported in the row message.

- AutoReverse Criteria Set: creates a reversal criteria set. An existing set cannot be updated or deleted; change its options instead.

- AutoReverse Option: creates or updates the reversal option of one journal category within a criteria set.

- AutoPost Set: creates or updates an AutoPost criteria set. Its chart of accounts, calendar and period type are fixed once it exists.

- AutoPost Option: creates or updates a priority within an AutoPost set. Set Delete Option to Yes to remove one.

An entity is created when it does not yet exist and updated otherwise; the Upload Mode parameter only decides whether existing records are downloaded for review. Rows that change nothing report No change and are not written.

After a Calendar Period upload the calendar is checked for gaps and overlaps between its periods, which are reported as a warning. Run the Calendar Validation Report for full details.


## Report Parameters
Upload Mode, Row Type, Calendar, Period Type, Chart of Accounts

## Oracle EBS Tables Used
[gl_period_types](https://www.enginatics.com/library/?pg=1&find=gl_period_types), [gl_period_sets](https://www.enginatics.com/library/?pg=1&find=gl_period_sets), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/gl-setup-upload/) |
| Blitz Report™ XML Import | [GL_Setup_Upload.xml](https://www.enginatics.com/xml/gl-setup-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-setup-upload/](https://www.enginatics.com/reports/gl-setup-upload/) |



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
