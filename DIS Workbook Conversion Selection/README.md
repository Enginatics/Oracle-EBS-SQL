---
layout: default
last_modified_at: 2026-10-19
title: 'DIS Workbook Conversion Selection | Oracle EBS SQL Report'
description: 'Lists the Discoverer workbook xmls uploaded to Blitz Report (Setup>Tools>Import>XML Upload), enriched with information supporting the decision which…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, DIS, Workbook, Conversion, Selection, xxen_discoverer_workbook_xmls, xxen_discoverer_sheets, xxen_reports_v'
permalink: /DIS%20Workbook%20Conversion%20Selection/
report_name: 'DIS Workbook Conversion Selection'
report_web_name: dis-workbook-conversion-selection
---

# DIS Workbook Conversion Selection – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-workbook-conversion-selection/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-conversion-selection) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-conversion-selection).

## Overview
Lists the Discoverer workbook xmls uploaded to Blitz Report (Setup>Tools>Import>XML Upload), enriched with information supporting the decision which workbooks to convert: latest run date, run count and distinct users from the end user layer's usage statistics, last update and creation date from the workbook definition, owner, description and sheet count.

Set Convert Workbook to Yes for each workbook that should be converted to Blitz Report and upload the file. The selection is stored on the staged workbook xml, and the 'Blitz Report Discoverer Import' concurrent program converts the selected workbooks.

With the Submit Import parameter set to Yes, the upload submits the 'Blitz Report Discoverer Import' itself after storing the selection, waits for it to complete, and reports per workbook how many Blitz reports and templates exist for its worksheets. A workbook whose worksheet folder sets could not all be converted is reported as an error row.

The usage statistics are informational only: workbooks without any usage history are listed as well, with an empty run count and last run date.

The migration process is described in the following link: <a href="https://www.enginatics.com/blog/discoverer-replacement-with-blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-conversion-selection" rel="nofollow" target="_blank">https://www.enginatics.com/blog/discoverer-replacement-with-blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-conversion-selection</a>

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-conversion-selection) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, End User Layer, Workbook, Workbook Id, Submit Import, Report Name Prefix

## Oracle EBS Tables Used
[xxen_discoverer_workbook_xmls](https://www.enginatics.com/library/?pg=1&find=xxen_discoverer_workbook_xmls&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-conversion-selection), [xxen_discoverer_sheets](https://www.enginatics.com/library/?pg=1&find=xxen_discoverer_sheets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-conversion-selection), [xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-conversion-selection)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-conversion-selection), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-conversion-selection)

## Related Reports
[DIS Workbook Import Validation](/DIS%20Workbook%20Import%20Validation/ "DIS Workbook Import Validation Oracle EBS SQL Report"), [DIS Converter Diagnostic Dump](/DIS%20Converter%20Diagnostic%20Dump/ "DIS Converter Diagnostic Dump Oracle EBS SQL Report"), [DIS End User Layers](/DIS%20End%20User%20Layers/ "DIS End User Layers Oracle EBS SQL Report"), [DIS Migration identify missing EulConditions](/DIS%20Migration%20identify%20missing%20EulConditions/ "DIS Migration identify missing EulConditions Oracle EBS SQL Report"), [DIS Worksheet SQLs](/DIS%20Worksheet%20SQLs/ "DIS Worksheet SQLs Oracle EBS SQL Report"), [DIS Discoverer and Blitz Report Users](/DIS%20Discoverer%20and%20Blitz%20Report%20Users/ "DIS Discoverer and Blitz Report Users Oracle EBS SQL Report"), [DIS Workbook Owner Export Script](/DIS%20Workbook%20Owner%20Export%20Script/ "DIS Workbook Owner Export Script Oracle EBS SQL Report"), [DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/ "DIS Workbooks, Folders, Items and LOVs Oracle EBS SQL Report"), [Blitz Report Text Search](/Blitz%20Report%20Text%20Search/ "Blitz Report Text Search Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Workbook%20Conversion%20Selection/DIS%20Workbook%20Conversion%20Selection.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-conversion-selection) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/dis-workbook-conversion-selection/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-conversion-selection) |
| Blitz Report™ XML Import | [DIS_Workbook_Conversion_Selection.xml](https://www.enginatics.com/xml/dis-workbook-conversion-selection/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-conversion-selection) |
| SQL Source | [DIS Workbook Conversion Selection.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Workbook%20Conversion%20Selection/DIS%20Workbook%20Conversion%20Selection.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dis-workbook-conversion-selection/](https://www.enginatics.com/reports/dis-workbook-conversion-selection/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-conversion-selection) |

## Case Study & Technical Analysis: DIS Workbook Conversion Selection

### Executive Summary
The DIS Workbook Conversion Selection report supports the migration of Oracle Discoverer workbooks to Blitz Report. It lists the Discoverer workbook XML files that have been uploaded into Blitz Report and enriches each with the information needed to decide which workbooks to convert: the latest run date, run count and distinct users from the end user layer's usage statistics, the last update and creation dates of the workbook, its owner, description and sheet count. It is written for the project teams and reporting administrators who are replacing Discoverer in an Oracle EBS environment.
### Business Challenge
*   **Too many workbooks to convert:** Discoverer environments often hold a large number of workbooks, and not all are still in use, so converting everything wastes effort.
*   **Evidence-based selection:** The team needs usage evidence, such as the last run date and number of users, to decide which workbooks justify conversion.
*   **Ownership and currency:** The owner and last update date of each workbook help the team to contact the right people and to spot abandoned work.

### The Solution
*   **Usage enrichment:** The workbook list is joined to the end user layer's query statistics, so each workbook shows its last run date, run count and distinct users.
*   **Workbook metadata:** Owner, description, creation and update dates are taken from the end user layer document where it exists, falling back to the values in the uploaded XML.
*   **Selection stored on the file:** Setting Convert Workbook to Yes stores the selection on the staged workbook XML for the import program to act on.
*   **Optional immediate import:** With Submit Import set to Yes, the upload submits the import, waits for it to complete and reports the Blitz reports and templates created for each workbook.

### Technical Architecture (High Level)
#### Primary Tables
*   `XXEN_DISCOVERER_WORKBOOK_XMLS`: the uploaded Discoverer workbook XML files, with their identifiers, end user layer and upload dates.
*   `XXEN_DISCOVERER_SHEETS`: the worksheets in each uploaded workbook, used to match Blitz reports to sheets.
*   `XXEN_REPORTS_V`: the Blitz reports, with their names, descriptions and creation dates, used to find the reports created from each workbook.
*   The end user layer tables `EUL5_DOCUMENTS` and `EUL5_QPP_STATS`, referenced through the `&eul` schema prefix: the document definitions and the query usage statistics.

#### Logical Relationships
1. The uploaded workbook XML records are joined to `EUL5_DOCUMENTS` on the document identifier, as an outer join, so workbooks missing from the end user layer are listed.
2. The workbook name, with its `.dis` suffix removed and the text converted to upper case, is matched to the usage statistics in `EUL5_QPP_STATS`.
3. Worksheets are matched to Blitz reports through an object identifier key stored in the report description, which links each sheet to the report created from it.
4. Each workbook's converted reports are aggregated into one row, with the names concatenated and the earliest creation and latest update dates.
5. The three result sets are joined on the workbook identifier and the upper-cased workbook name.

### Parameters & Filtering
*   **Upload Mode:** Selects whether the selection is being recorded for conversion.
*   **End User Layer:** Identifies the Discoverer end user layer whose documents and statistics are used.
*   **Workbook and Workbook Id:** Restrict the list to one workbook by name or by identifier.
*   **Submit Import:** When Yes, the upload submits the Blitz Report Discoverer Import program after storing the selection.

### Performance & Optimization
*   **Stats aggregated first:** The usage statistics are grouped by normalised workbook name before the join, so each workbook joins to one statistics row.
*   **Inline views without merge:** The sheet selection and report mapping are placed in `no_merge` inline views, which keeps the matching logic evaluated once.
*   **Distinct sheets:** Sheets are selected with `distinct` before the object key is computed, so duplicate sheet rows do not multiply the report matches.
*   **Import is separate:** The conversion itself runs in the concurrent program, so the report's cost is limited to the listing and to the optional wait for the import.

### FAQ
**Q: How do I decide which Discoverer workbooks to convert to Blitz Report?**
A: Review the run count, last run date and distinct users for each workbook, set Convert Workbook to Yes for those to keep, and upload the file.

**Q: Why does a workbook show no run count or last run date?**
A: The usage statistics are informational only, and a workbook without any usage history is still listed with an empty run count and last run date.

**Q: Where can I find the migration process for Discoverer workbooks?**
A: The report description links to the Enginatics blog post on Discoverer replacement with Blitz Report.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-conversion-selection)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-conversion-selection)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-conversion-selection)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-conversion-selection)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-conversion-selection)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-conversion-selection)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-conversion-selection)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
