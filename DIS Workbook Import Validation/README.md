---
layout: default
last_modified_at: 2026-10-16
title: 'DIS Workbook Import Validation | Oracle EBS SQL Report'
description: 'Discoverer workbook migration validation report showing every workbook and worksheet next to its conversion state: whether the workbook xml is uploaded…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Discoverer, Enginatics, DIS, Workbook, Import, Validation, xxen_discoverer_workbook_xmls, xxen_discoverer_sheets, xxen_discoverer_workbooks'
permalink: /DIS%20Workbook%20Import%20Validation/
report_name: 'DIS Workbook Import Validation'
report_web_name: dis-workbook-import-validation
module: 'Discoverer'
module_url: /modules/discoverer/
---

# DIS Workbook Import Validation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-workbook-import-validation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-import-validation) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-import-validation).
**Oracle EBS module:** [Discoverer](/modules/discoverer/ "Oracle EBS Discoverer reports") · [all Discoverer reports](/modules/discoverer/)  

## Overview
Discoverer workbook migration validation report showing every workbook and worksheet next to its conversion state: whether the workbook xml is uploaded, selected for conversion or converted, the object use key derived from the workbook xml, and the migrated Blitz report and template.

Workbooks known only from the end user layer and workbooks whose xml was uploaded after deletion from Discoverer are both listed, so gaps in either direction are visible. The Not yet imported parameter restricts to worksheets without a migrated template.

The Accessed after parameter restricts the output to workbooks with recorded usage since that date, the same scope the DIS Workbook Export Script lists for export; left blank, every workbook is shown including those never accessed. The usage statistics columns show access count, last accessed date and user within the same window.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-import-validation) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Workbook, Accessed after, Workbook Owner, Not yet imported, End User Layer

## Oracle EBS Tables Used
[xxen_discoverer_workbook_xmls](https://www.enginatics.com/library/?pg=1&find=xxen_discoverer_workbook_xmls&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-import-validation), [xxen_discoverer_sheets](https://www.enginatics.com/library/?pg=1&find=xxen_discoverer_sheets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-import-validation), [xxen_discoverer_workbooks](https://www.enginatics.com/library/?pg=1&find=xxen_discoverer_workbooks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-import-validation), [xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-import-validation), [xxen_report_templates_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_templates_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-import-validation)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-import-validation)

## Related Reports
[DIS End User Layers](/DIS%20End%20User%20Layers/ "DIS End User Layers Oracle EBS SQL Report"), [DIS Converter Diagnostic Dump](/DIS%20Converter%20Diagnostic%20Dump/ "DIS Converter Diagnostic Dump Oracle EBS SQL Report"), [DIS Workbook Conversion Selection](/DIS%20Workbook%20Conversion%20Selection/ "DIS Workbook Conversion Selection Oracle EBS SQL Report"), [DIS Migration identify missing EulConditions](/DIS%20Migration%20identify%20missing%20EulConditions/ "DIS Migration identify missing EulConditions Oracle EBS SQL Report"), [DIS Discoverer and Blitz Report Users](/DIS%20Discoverer%20and%20Blitz%20Report%20Users/ "DIS Discoverer and Blitz Report Users Oracle EBS SQL Report"), [DIS Worksheet SQLs](/DIS%20Worksheet%20SQLs/ "DIS Worksheet SQLs Oracle EBS SQL Report"), [DIS Workbook Owner Export Script](/DIS%20Workbook%20Owner%20Export%20Script/ "DIS Workbook Owner Export Script Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [Blitz Report Template Sharing](/Blitz%20Report%20Template%20Sharing/ "Blitz Report Template Sharing Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Workbook%20Import%20Validation/DIS%20Workbook%20Import%20Validation.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-import-validation) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DIS Workbook Import Validation 23-Jan-2024 205356.xlsx](https://www.enginatics.com/example/dis-workbook-import-validation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-import-validation) |
| Blitz Report™ XML Import | [DIS_Workbook_Import_Validation.xml](https://www.enginatics.com/xml/dis-workbook-import-validation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-import-validation) |
| SQL Source | [DIS Workbook Import Validation.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Workbook%20Import%20Validation/DIS%20Workbook%20Import%20Validation.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dis-workbook-import-validation/](https://www.enginatics.com/reports/dis-workbook-import-validation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-import-validation) |

## DIS Workbook Import Validation

### Description
This report is a critical tool for validating the migration of Oracle Discoverer workbooks to Blitz Report. It provides a comprehensive overview of the migration status, highlighting which workbooks have been successfully imported and which are pending.

The report details:
- **Workbook Information**: Names and sheet details of Discoverer workbooks.
- **Usage Statistics**: How often workbooks were accessed within a specified timeframe, helping prioritize migration efforts based on usage.
- **Import Status**: Columns indicating the number of records in various import process tables (`xxen_discoverer_workbooks`, `xxen_discoverer_workbook_xmls`), allowing for tracking of the migration pipeline.
- **Blitz Report Integration**: Information on the created Blitz Report and its associated template, confirming successful conversion.

This validation report ensures that the migration process is transparent and that all critical reporting assets are accounted for in the new system.

### Parameters
- **Workbook**: Filter by specific workbook names.
- **Accessed after**: Filter for workbooks accessed after a certain date to focus on active content.
- **Workbook Owner**: Filter by the owner of the workbook.
- **Not yet imported**: Flag to filter for workbooks that have not yet been imported into Blitz Report.
- **Include Inactive**: Option to include inactive workbooks in the report.
- **End User Layer**: Specify the End User Layer (EUL) to query.

### Used Tables
- `eul5_documents`: Stores Discoverer workbook definitions.
- `eul5_qpp_stats`: Contains query statistics for Discoverer worksheets.
- `xxen_discoverer_workbook_xmls`: Staging table for workbook XML exports during migration.
- `xxen_discoverer_workbooks`: Tracks the status of workbooks being migrated to Blitz Report.
- `xxen_report_templates_v`: View for Blitz Report templates.

### Categories
- **Enginatics**: Part of the Enginatics toolkit for Oracle EBS reporting and migration.

### Related Reports
- [DIS End User Layers](/DIS%20End%20User%20Layers/)

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-import-validation)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-import-validation)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-import-validation)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-import-validation)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-import-validation)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-import-validation)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-import-validation)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
