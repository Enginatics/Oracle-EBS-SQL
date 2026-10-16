---
layout: default
last_modified_at: 2026-10-16
title: 'GL Setup Upload | Oracle EBS SQL Report'
description: 'Create and update the General Ledger setup entities that the GL Setup menu maintains, replicating the Calendars (GLXSTCAL), Period Types (GLXSTPTY)…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Setup, gl_period_types, gl_periods, gl_period_sets'
permalink: /GL%20Setup%20Upload/
report_name: 'GL Setup Upload'
report_web_name: gl-setup-upload
---

# GL Setup Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-setup-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload).

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Row Type, Calendar, Period Type, Chart of Accounts

## Oracle EBS Tables Used
[gl_period_types](https://www.enginatics.com/library/?pg=1&find=gl_period_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload), [gl_period_sets](https://www.enginatics.com/library/?pg=1&find=gl_period_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload), [gl_je_sources_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_sources_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload), [gl_je_categories_vl](https://www.enginatics.com/library/?pg=1&find=gl_je_categories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload), [gl_encumbrance_types](https://www.enginatics.com/library/?pg=1&find=gl_encumbrance_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload), [gl_stat_account_uom](https://www.enginatics.com/library/?pg=1&find=gl_stat_account_uom&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload), [fnd_id_flex_structures_vl](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_structures_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload), [gl_access_sets](https://www.enginatics.com/library/?pg=1&find=gl_access_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload), [gl_ledger_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload), [gl_transaction_calendar](https://www.enginatics.com/library/?pg=1&find=gl_transaction_calendar&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload), [gl_autorev_criteria_sets](https://www.enginatics.com/library/?pg=1&find=gl_autorev_criteria_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload), [gl_autoreverse_options](https://www.enginatics.com/library/?pg=1&find=gl_autoreverse_options&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload), [gl_automatic_posting_sets](https://www.enginatics.com/library/?pg=1&find=gl_automatic_posting_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload), [fnd_lookup_values_vl](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload), [gl_automatic_posting_options](https://www.enginatics.com/library/?pg=1&find=gl_automatic_posting_options&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload)

## Related Reports
[GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Balance Drilldown](/GL%20Balance%20Drilldown/ "GL Balance Drilldown Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Setup%20Upload/GL%20Setup%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/gl-setup-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload) |
| Blitz Report™ XML Import | [GL_Setup_Upload.xml](https://www.enginatics.com/xml/gl-setup-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload) |
| SQL Source | [GL Setup Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Setup%20Upload/GL%20Setup%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/gl-setup-upload/](https://www.enginatics.com/reports/gl-setup-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload) |

## Case Study & Technical Analysis: GL Setup Upload

### Executive Summary
The GL Setup Upload report creates and updates the General Ledger setup entities that the GL Setup menu maintains, in a single Excel file. It covers calendars and their periods, period types, journal sources and categories, encumbrance types, statistical units of measure, ledger sets, data access sets, AutoReverse criteria and AutoPost criteria, together with the options of existing ledgers. Each row belongs to one of fifteen entity types, chosen in the Row Type column, and a template is supplied for each entity. Implementation teams and GL administrators use it to build or change the accounting setup for a new instance, or to copy setup changes between environments.

### Business Challenge
*   **Large setup footprint:** A new GL configuration involves many forms across calendars, sources, categories and criteria sets, and each one is slow to key in by hand.
*   **Setup consistency:** Calendar periods, journal sources and categories must agree with each other and with the ledgers that use them, and mismatches cause posting and close problems.
*   **Controlled change:** Some attributes, such as a period type's periods per year or a ledger set's chart of accounts, cannot be changed once set, so teams need to see the existing values before making changes.

### The Solution
*   **One file, fifteen entity types:** Each row carries a Row Type, and only the columns for that entity are read, so one workbook can hold the whole setup.
*   **Create or update by identity:** Each entity is created when it does not exist and updated otherwise, and rows that change nothing are reported as No change and are not written.
*   **Calendar gap checks:** After a Calendar Period upload the calendar is checked for gaps and overlaps, and any problem is reported as a warning.
*   **Staged assignments:** Ledger set and data access set assignments are staged, and the General Ledger Accounting Setup Program is submitted automatically, once per chart of accounts, with its request ID shown in the row message.

### Technical Architecture (High Level)
#### Primary Tables
*   `GL_PERIOD_TYPES`: the period types, with periods per fiscal year and year type in the name.
*   `GL_PERIOD_SETS` and `GL_PERIODS`: the calendars and their periods, with start and end dates, quarter, period number and adjustment flag.
*   `GL_JE_SOURCES_VL` and `GL_JE_CATEGORIES_VL`: the journal sources and categories.
*   `GL_ENCUMBRANCE_TYPES`: the encumbrance types.
*   `GL_STAT_ACCOUNT_UOM`: the statistical unit of measure assigned to an account segment value.
*   `GL_LEDGERS`: the ledgers, used for ledger options, ledger sets and assignments.
*   `GL_LEDGER_SET_NORM_ASSIGN` and `GL_ACCESS_SET_NORM_ASSIGN`: the member ledgers of ledger sets and data access sets.
*   `GL_ACCESS_SETS`: the ledger sets and data access sets.
*   `GL_AUTOREV_CRITERIA_SETS` and `GL_AUTOREVERSE_OPTIONS`: the AutoReverse criteria sets and their category options.
*   `GL_AUTOMATIC_POSTING_SETS` and `GL_AUTOMATIC_POSTING_OPTIONS`: the AutoPost sets and their priorities.
*   `FND_ID_FLEX_STRUCTURES_VL`: the accounting flexfield structure for each chart of accounts.
*   `GL_CODE_COMBINATIONS_KFV`: the accounts used for ledger options such as retained earnings, rounding, CTA and net income.

#### Logical Relationships
1.  Each of the fifteen entity types is built as its own branch, and the branches are combined with UNION ALL. A row number orders the result by row type and the entity's key columns.
2.  Each branch joins its entity table to its period type, chart of accounts or flexfield structure, so that the chart of accounts ID and application 101 are matched on the accounting flexfield code.
3.  Calendar Period joins `GL_PERIOD_SETS` to `GL_PERIODS` and then to `GL_PERIOD_TYPES`.
4.  Ledger Set and Data Access Set Assignment branches join the member assignment tables to the set and to the ledger, excluding deleted assignments.

### Parameters & Filtering
*   **Upload Mode:** Decides whether existing records are downloaded for review. Creation and update are decided by the entity keys, not by this parameter.
*   **Row Type:** Limits the download to one of the fifteen entity types.
*   **Calendar:** Selects the calendar for Calendar Period rows.
*   **Period Type:** Selects the period type for period type rows.
*   **Chart of Accounts:** Selects the chart of accounts for Statistical Unit of Measure and for the related set and criteria rows.

### Performance & Optimization
*   **Branch-per-entity design:** Each entity is read by its own branch with its own key filters, so a download with one row type reads only the tables for that entity.
*   **Outer joins for optional accounts:** Ledger option accounts are outer joined, so a ledger with some accounts unset is still returned.

### FAQ
**Q: Why can I not change the periods per year of an existing period type?**
A: The description states that Periods Per Year and Year Type In Name are required to create a period type and cannot be changed afterwards.
**Q: Can this upload create a ledger?**
A: No. Ledgers cannot be created here, because only the Accounting Setup Manager can create the accounting setup around one. The upload updates the options of an existing ledger.
**Q: Does a calendar period upload check the calendar?**
A: Yes. After the upload the calendar is checked for gaps and overlaps between its periods, and any issue is reported as a warning. The Calendar Validation Report gives the full detail.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-setup-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
