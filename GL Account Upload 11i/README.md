---
layout: default
last_modified_at: 2026-10-16
title: 'GL Account Upload 11i | Oracle EBS SQL Report'
description: 'This upload allows creation of new GL code combinations and update of existing ones. For creation of new code combinations, the upload requires the setup…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Account, 11i, gl_code_combinations_kfv, fnd_flex_values_vl, fnd_flex_value_sets'
permalink: /GL%20Account%20Upload%2011i/
report_name: 'GL Account Upload 11i'
report_web_name: gl-account-upload-11i
---

# GL Account Upload 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-account-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-upload-11i) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-upload-11i).

## Overview
This upload allows creation of new GL code combinations and update of existing ones. For creation of new code combinations, the upload requires the setup to allow dynamic inserts for code combinations.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-upload-11i) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Upload Mode, Active Accounts Only, GL_SEGMENT1, GL_SEGMENT1 From, GL_SEGMENT1 To, GL_SEGMENT2, GL_SEGMENT2 From, GL_SEGMENT2 To, GL_SEGMENT3, GL_SEGMENT3 From, GL_SEGMENT3 To, GL_SEGMENT4, GL_SEGMENT4 From, GL_SEGMENT4 To, GL_SEGMENT5, GL_SEGMENT5 From, GL_SEGMENT5 To, GL_SEGMENT6, GL_SEGMENT6 From, GL_SEGMENT6 To, GL_SEGMENT7, GL_SEGMENT7 From, GL_SEGMENT7 To, GL_SEGMENT8, GL_SEGMENT8 From, GL_SEGMENT8 To, GL_SEGMENT9, GL_SEGMENT9 From, GL_SEGMENT9 To, GL_SEGMENT10, GL_SEGMENT10 From, GL_SEGMENT10 To, GL_SEGMENT11 From, GL_SEGMENT11 To

## Oracle EBS Tables Used
[gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-upload-11i), [fnd_flex_values_vl](https://www.enginatics.com/library/?pg=1&find=fnd_flex_values_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-upload-11i), [fnd_flex_value_sets](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-upload-11i), [fnd_id_flex_structures_tl](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_structures_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-upload-11i), [xxen_gl_ledgers_v](https://www.enginatics.com/library/?pg=1&find=xxen_gl_ledgers_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-upload-11i)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-upload-11i), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-upload-11i)

## Related Reports
[GL Account Upload](/GL%20Account%20Upload/ "GL Account Upload Oracle EBS SQL Report"), [GL Setup Upload](/GL%20Setup%20Upload/ "GL Setup Upload Oracle EBS SQL Report"), [AR Transaction Upload](/AR%20Transaction%20Upload/ "AR Transaction Upload Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Account%20Upload%2011i/GL%20Account%20Upload%2011i.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-upload-11i) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/gl-account-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-upload-11i) |
| Blitz Report™ XML Import | [GL_Account_Upload_11i.xml](https://www.enginatics.com/xml/gl-account-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-upload-11i) |
| SQL Source | [GL Account Upload 11i.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Account%20Upload%2011i/GL%20Account%20Upload%2011i.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/gl-account-upload-11i/](https://www.enginatics.com/reports/gl-account-upload-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-upload-11i) |

## Case Study & Technical Analysis: GL Account Upload 11i

### Executive Summary
The GL Account Upload 11i report creates new General Ledger code combinations and updates existing ones from an Excel file. It is used by GL administrators and chart of accounts maintainers who need to add accounts in bulk, to change their status and posting controls, or to review the accounts of a ledger in one table. The upload is designed for Oracle E-Business Suite 11i and works on the code combinations of a ledger's accounting flexfield. The description states that the upload needs the chart of accounts set up to allow dynamic inserts, which is the condition for creating new combinations from a spreadsheet.

### Business Challenge
*   **Bulk account creation:** New cost centres, product lines or natural accounts are often added in batches, and keying each combination in the Accounting Flexfield window is slow.
*   **Account status control:** Accounts must be enabled, disabled, summarised or opened for posting and budgeting, and these settings must be reviewed together.
*   **Consistent segment values:** The segments of a combination must match the chart of accounts, and a spreadsheet makes the segment layout easy to check before upload.
*   **Account type classification:** Reporting depends on each account's type, so the type must be visible next to the segments.

### The Solution
*   **Create and update by segments:** The upload can create new code combinations and update existing ones, identified by the concatenated account.
*   **All segments exposed:** Each of the fifteen segments of the account is shown in its own column, with the full concatenated string and a description.
*   **Status and control flags:** Summary, enabled, budgeting-allowed and posting-allowed flags are shown with their meanings, along with the active start and end dates.
*   **Account type and flexfield values:** The account type from the GL account type value set and the account's descriptive flexfield values are included.

### Technical Architecture (High Level)
#### Primary Tables
*   `GL_CODE_COMBINATIONS_KFV`: the code combinations, with their segments, flags, dates and descriptive flexfield attributes.
*   `FND_FLEX_VALUES_VL`: the flex values, which supply the account type description.
*   `FND_FLEX_VALUE_SETS`: the value set, filtered to the GL account type value set.
*   `FND_ID_FLEX_STRUCTURES_TL`: the accounting flexfield structure, filtered to the GL accounting flexfield for the application.
*   `XXEN_GL_LEDGERS_V`: the ledger view, which supplies the ledger name and chart of accounts ID.

#### Logical Relationships
1.  `XXEN_GL_LEDGERS_V` is joined to `GL_CODE_COMBINATIONS_KFV` on the chart of accounts ID.
2.  The account type of each combination (its GL account type segment) is matched to `FND_FLEX_VALUES_VL`, which is restricted to the value set named GL_SRS_ACCOUNT_TYPE through `FND_FLEX_VALUE_SETS`.
3.  `FND_ID_FLEX_STRUCTURES_TL` is joined on the chart of accounts ID, the application ID 101 and the GL accounting flexfield code, in the session language.
4.  Summary accounts are excluded, so only detail combinations are returned.

### Parameters & Filtering
*   **Ledger:** Selects the ledger whose chart of accounts is used.
*   **Upload Mode:** Chooses between creating and updating code combinations.
*   **Active Accounts Only:** Restricts the output to accounts that are active.
*   **GL_SEGMENT1 to GL_SEGMENT10, with From and To:** Each of these segments has a value parameter and a From and To range, so a segment can be filtered by a value or a range. GL_SEGMENT11 has only the From and To range parameters.

### Performance & Optimization
*   **Ledger-first scope:** The ledger view is the first join, so the combinations are limited to the chart of accounts of one ledger.
*   **Value set restriction:** The account type lookup is limited to one named value set, which keeps the flex value join small.
*   **Summary accounts excluded:** Summary combinations are removed from the output, so the file contains only detail accounts.
*   **Segment-level filters:** The segment parameters narrow the combinations before they are returned, so large charts are managed by segment range.

### FAQ
**Q: Why can I not create a new account in this upload?**
A: The description states that creating new code combinations requires the setup to allow dynamic inserts, so the chart of accounts must be enabled for dynamic inserts before the create step works.
**Q: Does the report show summary accounts?**
A: No. Summary combinations are excluded, so only detail accounts appear.
**Q: How do I see the accounts of one cost centre in a ledger?**
A: Select the ledger and enter the value in the GL_SEGMENT parameter for the segment concerned, which limits the combinations to that value.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-upload-11i)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-upload-11i)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-upload-11i)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-upload-11i)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-upload-11i)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-upload-11i)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-account-upload-11i)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
