---
layout: default
last_modified_at: 2026-10-26
title: 'AR AutoAccounting Upload | Oracle EBS SQL Report'
description: 'Creates and updates the Receivables AutoAccounting definitions - the Excel equivalent of the Automatic Accounting form (Setup > Transactions >…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, AutoAccounting, fnd_flex_values_vl, ra_account_default_segments, ra_account_defaults_all'
permalink: /AR%20AutoAccounting%20Upload/
report_name: 'AR AutoAccounting Upload'
report_web_name: ar-autoaccounting-upload
---

# AR AutoAccounting Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-autoaccounting-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload).

## Overview
Creates and updates the Receivables AutoAccounting definitions - the Excel equivalent of the Automatic Accounting form (Setup > Transactions > AutoAccounting).

Each row is one segment of the chart of accounts of an AutoAccounting type, with the operating unit and type repeated on every row. Enter either a Table Name, from which AutoAccounting takes the segment value, or a Constant.

Each type is saved as a whole: after the upload, every enabled segment of the chart of accounts must have a table name or constant, and a dependent segment must use the table name of its parent segment or a constant valid for the parent constant. Otherwise none of the type's rows are saved. To define a new type, enter one row per segment. The type's descriptive flexfield values are taken from its first row.

Changing the balancing segment of the Revenue or Receivable type also changes the balancing segment of the Tax, Freight, Unbilled Receivable, Unearned Revenue and AutoInvoice Clearing types, as in the form.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Operating Unit, Type

## Oracle EBS Tables Used
[fnd_flex_values_vl](https://www.enginatics.com/library/?pg=1&find=fnd_flex_values_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload), [ra_account_default_segments](https://www.enginatics.com/library/?pg=1&find=ra_account_default_segments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload), [ra_account_defaults_all](https://www.enginatics.com/library/?pg=1&find=ra_account_defaults_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload), [ar_system_parameters_all](https://www.enginatics.com/library/?pg=1&find=ar_system_parameters_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload), [fnd_id_flex_segments_vl](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_segments_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload)

## Related Reports
[AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [AR Autoinvoice Interface](/AR%20Autoinvoice%20Interface/ "AR Autoinvoice Interface Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [ONT Orders and Lines 11i](/ONT%20Orders%20and%20Lines%2011i/ "ONT Orders and Lines 11i Oracle EBS SQL Report"), [ONT Orders and Lines](/ONT%20Orders%20and%20Lines/ "ONT Orders and Lines Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [PO Expense Account Rules Upload](/PO%20Expense%20Account%20Rules%20Upload/ "PO Expense Account Rules Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20AutoAccounting%20Upload/AR%20AutoAccounting%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ar-autoaccounting-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload) |
| Blitz Report™ XML Import | [AR_AutoAccounting_Upload.xml](https://www.enginatics.com/xml/ar-autoaccounting-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload) |
| SQL Source | [AR AutoAccounting Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20AutoAccounting%20Upload/AR%20AutoAccounting%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ar-autoaccounting-upload/](https://www.enginatics.com/reports/ar-autoaccounting-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload) |

## Case Study & Technical Analysis: AR AutoAccounting Upload

### Executive Summary
The AR AutoAccounting Upload is a spreadsheet-based maintenance tool for the Receivables AutoAccounting definitions that the Automatic Accounting form (Setup > Transactions > AutoAccounting) normally controls. For each operating unit it lists every AutoAccounting type, such as Revenue, Receivable, Tax, Freight, Unbilled Receivable, Unearned Revenue and AutoInvoice Clearing, together with one row per enabled segment of the general ledger chart of accounts and the table name or constant that supplies that segment. Receivables configuration specialists and finance systems teams use it to review, replicate and maintenance-update account generation rules across operating units. The report runs in Excel via Blitz Report.

### Business Challenge
*   **Form-by-form maintenance:** The Automatic Accounting form is edited one type and one segment at a time, which makes multi-operating-unit configuration slow and error-prone.
*   **Cross-type dependencies:** Changing the balancing segment of the Revenue or Receivable type also changes the balancing segment of the Tax, Freight, Unbilled Receivable, Unearned Revenue and AutoInvoice Clearing types, and this propagation is easy to overlook.
*   **All-or-nothing saves:** Each type is saved as a whole. If an enabled segment has no table name or constant, or a dependent segment does not follow its parent, none of the type's rows are saved.
*   **Audit before go-live:** Teams need a readable extract of which table or constant drives each account segment.

### The Solution
*   **Operating unit scoping:** Rows are restricted to the operating units held in `MO_GLOB_ORG_ACCESS_TMP`, so only units the user can access appear in the spreadsheet.
*   **Segment-level expansion:** Each AutoAccounting default is expanded into one row per accounting flexfield segment, matched by segment column name to the chart of accounts definition.
*   **Readable values:** Type and table codes are translated through `xxen_util.meaning` (AUTOGL_TYPE and AUTOGL_TABLES lookups), and the descriptive flexfield attributes of both the type and the segment are rendered with their segment labels.
*   **Constant descriptions:** For constant segments the value's description is resolved from `FND_FLEX_VALUES_VL`, so the reader sees what the constant represents, not only its code.

### Technical Architecture (High Level)
#### Primary Tables
*   `RA_ACCOUNT_DEFAULTS_ALL`: one row per AutoAccounting type and operating unit, holding the type code, its descriptive flexfield values and the GL default identifier.
*   `RA_ACCOUNT_DEFAULT_SEGMENTS`: one row per segment of each type, holding the table name or constant and the segment number.
*   `HR_OPERATING_UNITS`: the operating unit name for each row.
*   `AR_SYSTEM_PARAMETERS_ALL`: links each operating unit to its set of books.
*   `GL_LEDGERS`: supplies the chart of accounts identifier of the ledger.
*   `FND_ID_FLEX_SEGMENTS_VL`: accounting flexfield segment definitions (application 101, id flex code GL#).
*   `FND_FLEX_VALUES_VL`: value descriptions for constant segments.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating unit access list for the current session.

#### Logical Relationships
1. `RA_ACCOUNT_DEFAULTS_ALL` is filtered by org_id against `MO_GLOB_ORG_ACCESS_TMP` and joined to `HR_OPERATING_UNITS` on organization_id.
2. `AR_SYSTEM_PARAMETERS_ALL` is joined on org_id, and `GL_LEDGERS` on set_of_books_id equal to ledger_id, to obtain the chart_of_accounts_id.
3. `RA_ACCOUNT_DEFAULTS_ALL` is joined to `RA_ACCOUNT_DEFAULT_SEGMENTS` on gl_default_id.
4. The chart of accounts identifier is matched to `FND_ID_FLEX_SEGMENTS_VL` (application 101, GL#), and the segment name is matched to the segment column of the default segment row.
5. For constant segments, a correlated subquery on `FND_FLEX_VALUES_VL` returns the value description within the same flex value set.

### Parameters & Filtering
*   **Upload Mode:** Selects whether new AutoAccounting definitions are created or existing ones are amended.
*   **Operating Unit:** Identifies the operating unit whose AutoAccounting definitions are being maintained.
*   **Type:** Selects the AutoAccounting type (for example Revenue or Receivable). To define a new type, one row is entered per segment; the descriptive flexfield values of the type are taken from its first row.

The SQL text does not reference these three parameters through bind variables. Row selection is determined by the operating unit access list and the join conditions described above.

### Performance & Optimization
*   Operating unit access is applied as an `IN` subquery on `MO_GLOB_ORG_ACCESS_TMP`.
*   The segment join is restricted to application 101 and the GL# id flex code, so only accounting flexfield segments are read from `FND_ID_FLEX_SEGMENTS_VL`.
*   The constant description is a scalar subquery with `min()` that runs once for each segment row.

### FAQ
**Q: How do I bulk-review AutoAccounting table names and constants across operating units?**
A: Run the report with the operating units in scope; each row lists one AutoAccounting type segment with its table name or constant and the operating unit it belongs to.

**Q: Why does an AutoAccounting type fail to save after an upload?**
A: Every enabled chart of accounts segment must have a table name or constant, and a dependent segment must use its parent's table name or a constant valid for the parent constant; otherwise none of that type's rows are saved.

**Q: Which upload changes the balancing segment for Tax and Freight AutoAccounting?**
A: Changing the balancing segment of the Revenue or Receivable type also updates the balancing segment of the Tax, Freight, Unbilled Receivable, Unearned Revenue and AutoInvoice Clearing types, as in the Automatic Accounting form.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-autoaccounting-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
