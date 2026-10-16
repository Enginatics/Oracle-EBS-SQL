---
layout: default
last_modified_at: 2026-10-16
title: 'EAM Failure Codes Upload | Oracle EBS SQL Report'
description: 'Create, update, and delete EAM failure codes, cause codes, and resolution codes. Upload Mode =========== Create ------ Opens an empty spreadsheet to…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, EAM, Failure, Codes, eam_failure_codes, eam_cause_codes, eam_resolution_codes'
permalink: /EAM%20Failure%20Codes%20Upload/
report_name: 'EAM Failure Codes Upload'
report_web_name: eam-failure-codes-upload
---

# EAM Failure Codes Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/eam-failure-codes-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-codes-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-codes-upload).

## Overview
Create, update, and delete EAM failure codes, cause codes, and resolution codes.

Upload Mode
===========

Create
------
Opens an empty spreadsheet to define new codes.

Create, Update
--------------
Downloads existing codes for review and modification, and allows adding new rows.

Code Type
=========
Determines which of the three code tables is affected:
- Failure Code   (stored in eam_failure_codes)
- Cause Code     (stored in eam_cause_codes)
- Resolution Code (stored in eam_resolution_codes)

Codes are global - not scoped to any operating unit.

Fields
======
- Code Type: Required. Failure Code, Cause Code, or Resolution Code.
- Code: Required. Unique within its code type.
- Description: Optional.
- Effective End Date: Optional. Blank to keep the code active; set to reactivate an end-dated code.
- Delete Record: Optional. Set to Yes to delete an existing code.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-codes-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Code Type

## Oracle EBS Tables Used
[eam_failure_codes](https://www.enginatics.com/library/?pg=1&find=eam_failure_codes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-codes-upload), [eam_cause_codes](https://www.enginatics.com/library/?pg=1&find=eam_cause_codes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-codes-upload), [eam_resolution_codes](https://www.enginatics.com/library/?pg=1&find=eam_resolution_codes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-codes-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-codes-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-codes-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-codes-upload)

## Related Reports
[EAM Work Orders 11i](/EAM%20Work%20Orders%2011i/ "EAM Work Orders 11i Oracle EBS SQL Report"), [EAM Work Orders](/EAM%20Work%20Orders/ "EAM Work Orders Oracle EBS SQL Report"), [EAM Failure Sets Upload](/EAM%20Failure%20Sets%20Upload/ "EAM Failure Sets Upload Oracle EBS SQL Report"), [EAM Assets](/EAM%20Assets/ "EAM Assets Oracle EBS SQL Report"), [BOM Standard Operations Upload](/BOM%20Standard%20Operations%20Upload/ "BOM Standard Operations Upload Oracle EBS SQL Report"), [EAM Weekly Schedule](/EAM%20Weekly%20Schedule/ "EAM Weekly Schedule Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/EAM%20Failure%20Codes%20Upload/EAM%20Failure%20Codes%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-codes-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/eam-failure-codes-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-codes-upload) |
| Blitz Report™ XML Import | [EAM_Failure_Codes_Upload.xml](https://www.enginatics.com/xml/eam-failure-codes-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-codes-upload) |
| SQL Source | [EAM Failure Codes Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/EAM%20Failure%20Codes%20Upload/EAM%20Failure%20Codes%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/eam-failure-codes-upload/](https://www.enginatics.com/reports/eam-failure-codes-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-codes-upload) |

## Case Study & Technical Analysis: EAM Failure Codes Upload

### Executive Summary
The EAM Failure Codes Upload creates, updates and end-dates the failure, cause and resolution codes used in Oracle Enterprise Asset Management. Maintenance planners and reliability engineers use it to build the code library that work orders are closed against, so that failure analysis can be reported consistently across asset maintenance. The report runs in Excel via Blitz Report, and all three code types are read from their own tables, with the Code Type parameter selecting which table is affected.

### Business Challenge
*   **Consistent failure coding:** Work order completion depends on a shared set of failure, cause and resolution codes, and inconsistent coding weakens later reliability analysis.
*   **Bulk code maintenance:** Adding or revising many codes through the EAM setup forms is slow when a new maintenance taxonomy is introduced.
*   **Retiring obsolete codes:** Codes that are no longer used need an effective end date rather than deletion from history, and reactivating them should be a simple edit.
*   **Global scope:** The codes are not tied to any operating unit or organization, so an error affects every maintenance organization that uses them.

### The Solution
*   **Three code types in one layout:** Failure Code, Cause Code and Resolution Code are presented on one spreadsheet, with the Code Type column identifying each row.
*   **Current codes for editing:** In Create, Update mode the existing codes are downloaded with their description and effective end date, ready for amendment.
*   **Lifecycle control:** The Effective End Date column ends a code or, when cleared, reactivates it.
*   **Explicit deletion:** The Delete Record column removes an existing code when set to Yes.

### Technical Architecture (High Level)
#### Primary Tables
*   `EAM_FAILURE_CODES`: the failure code definitions, with the code, description and effective end date.
*   `EAM_CAUSE_CODES`: the cause code definitions, with the same columns.
*   `EAM_RESOLUTION_CODES`: the resolution code definitions, read for the third code type, with the same columns.

#### Logical Relationships
1. The three code tables are read separately and combined with `UNION ALL` into one inline result set.
2. Each branch assigns a fixed code type value: '10' for failure codes, '20' for cause codes and '30' for resolution codes.
3. Each branch returns the code, description and effective end date, and a `ROWNUM` as the upload row identifier.
4. The outer query translates the code type through `xxen_util.meaning` with the EAM_FAILURE_CODE_TYPE lookup, and returns the delete record column as empty for the upload.

### Parameters & Filtering
*   **Upload Mode:** The SQL includes a branch only when the mode contains the update action, so Create mode opens an empty spreadsheet and Create, Update mode downloads the existing codes.
*   **Code Type:** When set to Failure Code, Cause Code or Resolution Code, only the matching branch is returned. When left empty, all three code types are returned on the same spreadsheet.

### Performance & Optimization
*   The mode and code type conditions are evaluated against bind variables inside each `UNION ALL` branch, so a branch that is excluded does not return rows.
*   The three code tables are read directly with no joins, so the query cost is proportional to the number of codes in each table.
*   The outer query adds one lookup, the code type meaning translation, and no aggregation or analytic functions are used.
*   Because the codes are global, no organization or operating unit filter is applied, and the report does not read any organization security views.

### FAQ
**Q: How do I end-date an EAM failure code without deleting it?**
A: Enter an Effective End Date for the code in the Failure Code rows and upload; clearing the date later reactivates it.

**Q: Are EAM failure codes scoped to an organization?**
A: No. The description states that codes are global and not scoped to any operating unit, so a change applies wherever the codes are used.

**Q: How do I delete an EAM cause code?**
A: Set the Delete Record column to Yes on the Cause Code row; the code is removed from the cause code table.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-codes-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-codes-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-codes-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-codes-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-codes-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-codes-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=eam-failure-codes-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
