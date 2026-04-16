---
layout: default
title: 'DIS Workbook Import Validation | Oracle EBS SQL Report'
description: 'Discoverer workbook migraton validation report showing the workbooks, sheets, how ofthen they were accessed within the given number of days, columns for…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DIS, Workbook, Import, Validation, eul5_documents, eul5_qpp_stats, xxen_discoverer_workbook_xmls'
permalink: /DIS%20Workbook%20Import%20Validation/
---

# DIS Workbook Import Validation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-workbook-import-validation/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Discoverer workbook migraton validation report showing the workbooks, sheets, how ofthen they were accessed within the given number of days, columns for the number of records in the different import process tables, and the created blitz report and template information.

## Report Parameters
Workbook, Accessed after, Workbook Owner, Not yet imported, Include Inactive, End User Layer

## Oracle EBS Tables Used
[eul5_documents](https://www.enginatics.com/library/?pg=1&find=eul5_documents), [eul5_qpp_stats](https://www.enginatics.com/library/?pg=1&find=eul5_qpp_stats), [xxen_discoverer_workbook_xmls](https://www.enginatics.com/library/?pg=1&find=xxen_discoverer_workbook_xmls), [xxen_discoverer_workbooks](https://www.enginatics.com/library/?pg=1&find=xxen_discoverer_workbooks), [xxen_report_templates_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_templates_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DIS End User Layers](/DIS%20End%20User%20Layers/ "DIS End User Layers Oracle EBS SQL Report"), [DIS Worksheet SQLs](/DIS%20Worksheet%20SQLs/ "DIS Worksheet SQLs Oracle EBS SQL Report"), [DIS Access Privileges](/DIS%20Access%20Privileges/ "DIS Access Privileges Oracle EBS SQL Report"), [DIS Discoverer and Blitz Report Users](/DIS%20Discoverer%20and%20Blitz%20Report%20Users/ "DIS Discoverer and Blitz Report Users Oracle EBS SQL Report"), [DIS Migration identify missing EulConditions](/DIS%20Migration%20identify%20missing%20EulConditions/ "DIS Migration identify missing EulConditions Oracle EBS SQL Report"), [DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/ "DIS Workbooks, Folders, Items and LOVs Oracle EBS SQL Report"), [DIS Workbook Export Script](/DIS%20Workbook%20Export%20Script/ "DIS Workbook Export Script Oracle EBS SQL Report"), [DIS Worksheet Execution History](/DIS%20Worksheet%20Execution%20History/ "DIS Worksheet Execution History Oracle EBS SQL Report"), [DIS Workbook Owner Export Script](/DIS%20Workbook%20Owner%20Export%20Script/ "DIS Workbook Owner Export Script Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DIS Workbook Import Validation 23-Jan-2024 205356.xlsx](https://www.enginatics.com/example/dis-workbook-import-validation/) |
| Blitz Report™ XML Import | [DIS_Workbook_Import_Validation.xml](https://www.enginatics.com/xml/dis-workbook-import-validation/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dis-workbook-import-validation/](https://www.enginatics.com/reports/dis-workbook-import-validation/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
