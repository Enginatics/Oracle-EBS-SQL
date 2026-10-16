---
layout: default
last_modified_at: 2026-10-16
title: 'Blitz Report Column Translation Upload | Oracle EBS SQL Report'
description: 'Upload to maintain the Blitz Report column translations and number formats, which control how a report column heading is displayed in each language and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Blitz, Report, Column, Translation, fnd_languages_vl, xxen_report_columns, xxen_report_columns_tl'
permalink: /Blitz%20Report%20Column%20Translation%20Upload/
report_name: 'Blitz Report Column Translation Upload'
report_web_name: blitz-report-column-translation-upload
---

# Blitz Report Column Translation Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-column-translation-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-column-translation-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-column-translation-upload).

## Overview
Upload to maintain the Blitz Report column translations and number formats, which control how a report column heading is displayed in each language and how its values are formatted in Excel.

Translations are matched to reports by column name at run time, so one row here applies to every report producing a column of that name.

The Language parameter is required, because a single language already covers around twenty thousand column names.

Run modes:

- Create, Update: downloads the existing translations of the chosen language for editing. Set Delete to Yes to remove a translation.

- Create with 'Missing Translations Only' = Yes: downloads only the column names that have no translation yet in the chosen language, ready to be filled in.

- Create with 'Create Empty File' = Yes: opens an empty file to enter new column names.

The Number Format is an Excel format mask held once per column name, not per language. It repeats on every language row of the same column and is only written when it differs from the stored value, so editing it on any one row is enough.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-column-translation-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Language, Create Empty File, Missing Translations Only, Column Name starts with

## Oracle EBS Tables Used
[fnd_languages_vl](https://www.enginatics.com/library/?pg=1&find=fnd_languages_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-column-translation-upload), [xxen_report_columns](https://www.enginatics.com/library/?pg=1&find=xxen_report_columns&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-column-translation-upload), [xxen_report_columns_tl](https://www.enginatics.com/library/?pg=1&find=xxen_report_columns_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-column-translation-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-column-translation-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-column-translation-upload)

## Related Reports
[Blitz Report Column Translations](/Blitz%20Report%20Column%20Translations/ "Blitz Report Column Translations Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [CST Item Standard Cost Upload](/CST%20Item%20Standard%20Cost%20Upload/ "CST Item Standard Cost Upload Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Column%20Translation%20Upload/Blitz%20Report%20Column%20Translation%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-column-translation-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/blitz-report-column-translation-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-column-translation-upload) |
| Blitz Report™ XML Import | [Blitz_Report_Column_Translation_Upload.xml](https://www.enginatics.com/xml/blitz-report-column-translation-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-column-translation-upload) |
| SQL Source | [Blitz Report Column Translation Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Column%20Translation%20Upload/Blitz%20Report%20Column%20Translation%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/blitz-report-column-translation-upload/](https://www.enginatics.com/reports/blitz-report-column-translation-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-column-translation-upload) |

## Case Study & Technical Analysis: Blitz Report Column Translation Upload

### Executive Summary
The Blitz Report Column Translation Upload is a maintenance report for the translated column headings and number formats used by Blitz Report™. It lets a support or implementation team edit, in Excel, how a report column heading appears in each language and how its values are formatted. Because translations are matched to reports by column name at run time, one row applies to every report that produces a column of that name. The report is useful when a multilingual EBS user base needs consistent headings across the whole report library, and when new or renamed columns need translations added without editing each report.

### Business Challenge
*   **Large translation volume:** The Blitz Report column library holds around twenty thousand column names, so translating them by hand in a form is impractical.
*   **Missing translations:** Users in a non-base language see English headings wherever a translation is absent, and gaps are hard to find without a list.
*   **Inconsistent number formats:** Values such as amounts, quantities and dates need one Excel format mask per column, and that mask must not drift between languages.
*   **Keeping new columns covered:** When new columns are introduced, someone needs a controlled way to enter their translations for each language.

### The Solution
*   **Language-driven download:** The language parameter is required, and the extract returns the column names and their existing translations for that language.
*   **Missing-only and empty-file modes:** A missing-translations mode returns only column names without a translation in the chosen language, and an empty-file mode allows new column names to be entered.
*   **Single number format per column:** The number format is stored once per column name and repeated on every language row, so editing it on one row is enough.
*   **Delete and audit fields:** A delete flag removes a translation, and the creator and last-update columns show who changed each entry and when.

### Technical Architecture (High Level)
#### Primary Tables
*   `XXEN_REPORT_COLUMNS`: the master list of column names, the column ID and the number format.
*   `XXEN_REPORT_COLUMNS_TL`: the translations, keyed by column ID and language, with the translated heading text.
*   `FND_LANGUAGES_VL`: the installed languages, used to select the language and show its description.

#### Logical Relationships
1.  `FND_LANGUAGES_VL` is filtered to the selected language code.
2.  `XXEN_REPORT_COLUMNS` is outer joined to the translation rows on column ID.
3.  The translation rows are outer joined on the language code, so every column can appear with a blank translation for the language.
4.  The translation table is read only when the upload mode is not Create, so Create runs start from an empty translation set.

### Parameters & Filtering
*   **Upload Mode:** Chooses between Create and Update behaviour. Create runs do not read existing translations, and Update runs download the current ones for editing.
*   **Language:** Required. It selects the language whose translations are downloaded.
*   **Create Empty File:** When set to Yes, the file is returned with no column rows, so new column names can be entered.
*   **Missing Translations Only:** When set to Yes, only the column names that have no translation in the chosen language are returned.
*   **Column Name starts with:** Narrows the list to column names with the given prefix, which is useful for editing one family of columns.

### Performance & Optimization
*   **Language-first filter:** The language is the first restriction, so the extract is limited to one language before translations are attached.
*   **Conditional translation read:** The translation table is only read when the upload mode is not Create, which avoids a full read of translations when a clean set is wanted.
*   **Outer join for gaps:** The column list is outer joined to the translations, so columns with no translation still appear, which is what makes the missing-only mode possible.
*   **Prefix filter:** The Column Name starts with parameter narrows the column master early, which keeps the work proportional to the names being edited.

### FAQ
**Q: How do I list the Blitz Report columns that still need a French translation?**
A: Choose French as the Language and set Missing Translations Only to Yes. Only columns without a translation in that language are returned.

**Q: If I change a number format on one language row, do I need to change the others?**
A: No. The number format belongs to the column name, so it repeats on every language row and only needs to be edited on one row.

**Q: How do I remove a translation I no longer want?**
A: Set the Delete flag to Yes on that row in an Update run, and upload the file.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-column-translation-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-column-translation-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-column-translation-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-column-translation-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-column-translation-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-column-translation-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-column-translation-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
