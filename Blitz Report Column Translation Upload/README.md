---
layout: default
title: 'Blitz Report Column Translation Upload | Oracle EBS SQL Report'
description: 'Upload to maintain the Blitz Report column translations and number formats, which control how a report column heading is displayed in each language and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Blitz, Report, Column, Translation, fnd_languages_vl, xxen_report_columns, xxen_report_columns_tl'
permalink: /Blitz%20Report%20Column%20Translation%20Upload/
---

# Blitz Report Column Translation Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-column-translation-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Upload to maintain the Blitz Report column translations and number formats, which control how a report column heading is displayed in each language and how its values are formatted in Excel.

Translations are matched to reports by column name at run time, so one row here applies to every report producing a column of that name.

The Language parameter is required, because a single language already covers around twenty thousand column names.

Run modes:

- Create, Update: downloads the existing translations of the chosen language for editing. Set Delete to Yes to remove a translation.

- Create with 'Missing Translations Only' = Yes: downloads only the column names that have no translation yet in the chosen language, ready to be filled in.

- Create with 'Create Empty File' = Yes: opens an empty file to enter new column names.

The Number Format is an Excel format mask held once per column name, not per language. It repeats on every language row of the same column and is only written when it differs from the stored value, so editing it on any one row is enough.

## Report Parameters
Upload Mode, Language, Create Empty File, Missing Translations Only, Column Name starts with

## Oracle EBS Tables Used
[fnd_languages_vl](https://www.enginatics.com/library/?pg=1&find=fnd_languages_vl), [xxen_report_columns](https://www.enginatics.com/library/?pg=1&find=xxen_report_columns), [xxen_report_columns_tl](https://www.enginatics.com/library/?pg=1&find=xxen_report_columns_tl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[Blitz Report Column Translations](/Blitz%20Report%20Column%20Translations/ "Blitz Report Column Translations Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [CST Item Standard Cost Upload](/CST%20Item%20Standard%20Cost%20Upload/ "CST Item Standard Cost Upload Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/blitz-report-column-translation-upload/) |
| Blitz Report™ XML Import | [Blitz_Report_Column_Translation_Upload.xml](https://www.enginatics.com/xml/blitz-report-column-translation-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-report-column-translation-upload/](https://www.enginatics.com/reports/blitz-report-column-translation-upload/) |



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
