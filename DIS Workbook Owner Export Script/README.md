---
layout: default
last_modified_at: 2026-10-19
title: 'DIS Workbook Owner Export Script | Oracle EBS SQL Report'
description: 'This export of workbook owners is required to remotely export workbook XMLs on the Enginatics environments for customers requiring support when migrating…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Discoverer, Enginatics, DIS, Workbook, Owner, Export, fnd_user, eul5_documents, eul5_eul_users'
permalink: /DIS%20Workbook%20Owner%20Export%20Script/
report_name: 'DIS Workbook Owner Export Script'
report_web_name: dis-workbook-owner-export-script
module: 'Discoverer'
module_url: /modules/discoverer/
---

# DIS Workbook Owner Export Script – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-workbook-owner-export-script/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-owner-export-script) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-owner-export-script).
**Oracle EBS module:** [Discoverer](/modules/discoverer/ "Oracle EBS Discoverer reports") · [all Discoverer reports](/modules/discoverer/)  

## Overview
This export of workbook owners is required to remotely export workbook XMLs on the Enginatics environments for customers requiring support when migrating from Discoverer to Blitz Report.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-owner-export-script) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
End User Layer

## Oracle EBS Tables Used
[fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-owner-export-script), [eul5_documents](https://www.enginatics.com/library/?pg=1&find=eul5_documents&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-owner-export-script), [eul5_eul_users](https://www.enginatics.com/library/?pg=1&find=eul5_eul_users&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-owner-export-script), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-owner-export-script)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-owner-export-script)

## Related Reports
[DIS Workbook Conversion Selection](/DIS%20Workbook%20Conversion%20Selection/ "DIS Workbook Conversion Selection Oracle EBS SQL Report"), [DIS Access Privileges](/DIS%20Access%20Privileges/ "DIS Access Privileges Oracle EBS SQL Report"), [DIS Workbook Export Script](/DIS%20Workbook%20Export%20Script/ "DIS Workbook Export Script Oracle EBS SQL Report"), [DIS Converter Diagnostic Dump](/DIS%20Converter%20Diagnostic%20Dump/ "DIS Converter Diagnostic Dump Oracle EBS SQL Report"), [DIS Users](/DIS%20Users/ "DIS Users Oracle EBS SQL Report"), [DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/ "DIS Workbooks, Folders, Items and LOVs Oracle EBS SQL Report"), [DIS Worksheet Execution History](/DIS%20Worksheet%20Execution%20History/ "DIS Worksheet Execution History Oracle EBS SQL Report"), [DIS Workbook Import Validation](/DIS%20Workbook%20Import%20Validation/ "DIS Workbook Import Validation Oracle EBS SQL Report"), [DIS End User Layers](/DIS%20End%20User%20Layers/ "DIS End User Layers Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Workbook%20Owner%20Export%20Script/DIS%20Workbook%20Owner%20Export%20Script.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-owner-export-script) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/dis-workbook-owner-export-script/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-owner-export-script) |
| Blitz Report™ XML Import | [DIS_Workbook_Owner_Export_Script.xml](https://www.enginatics.com/xml/dis-workbook-owner-export-script/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-owner-export-script) |
| SQL Source | [DIS Workbook Owner Export Script.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Workbook%20Owner%20Export%20Script/DIS%20Workbook%20Owner%20Export%20Script.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dis-workbook-owner-export-script/](https://www.enginatics.com/reports/dis-workbook-owner-export-script/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-owner-export-script) |

## DIS Workbook Owner Export Script

### Description
This script is a utility designed to facilitate the support and migration process from Oracle Discoverer to Blitz Report. It generates a list of workbook owners, which is required to remotely export workbook XML definitions.

When migrating complex Discoverer environments, it is often necessary to export workbook definitions for analysis or conversion. This script provides the necessary user information to target specific owners' workbooks for export, streamlining the migration workflow and ensuring that support teams have the correct context for troubleshooting or conversion tasks.

### Parameters
- **End User Layer**: The Discoverer End User Layer to query for workbook owners.

### Used Tables
- `fnd_user`: Oracle EBS application users table.

### Categories
- **Enginatics**: Utility script for Enginatics' migration and support services.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-owner-export-script)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-owner-export-script)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-owner-export-script)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-owner-export-script)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-owner-export-script)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-owner-export-script)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-workbook-owner-export-script)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
