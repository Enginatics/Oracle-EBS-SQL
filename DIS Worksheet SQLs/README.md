---
layout: default
last_modified_at: 2026-10-16
title: 'DIS Worksheet SQLs | Oracle EBS SQL Report'
description: 'Discoverer worksheet SQL queries. While the workbook documents are stored in a binary format in eul5documents.docdocument and it''s difficult extract their…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Discoverer, Enginatics, DIS, Worksheet, SQLs, ams_discoverer_sql, eul5_qpp_stats'
permalink: /DIS%20Worksheet%20SQLs/
report_name: 'DIS Worksheet SQLs'
report_web_name: dis-worksheet-sqls
module: 'Discoverer'
module_url: /modules/discoverer/
---

# DIS Worksheet SQLs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-worksheet-sqls/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-sqls) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-sqls).
**Oracle EBS module:** [Discoverer](/modules/discoverer/ "Oracle EBS Discoverer reports") · [all Discoverer reports](/modules/discoverer/)  

## Overview
Discoverer worksheet SQL queries.
While the workbook documents are stored in a binary format in eul5_documents.doc_document and it's difficult extract their content (<a href="https://community.oracle.com/thread/2494216" rel="nofollow" target="_blank">https://community.oracle.com/thread/2494216</a>), there is an active trigger function
select ef.* from eul_us.eul5_functions ef where ef.fun_name='eul_trigger$post_save_document'
writing each worksheets' SQL query to table ams_discoverer_sql

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-sqls) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Workbook, Worksheet, Access Count within x Days, Show Active only, End User Layer

## Oracle EBS Tables Used
[ams_discoverer_sql](https://www.enginatics.com/library/?pg=1&find=ams_discoverer_sql&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-sqls), [eul5_qpp_stats](https://www.enginatics.com/library/?pg=1&find=eul5_qpp_stats&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-sqls)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-sqls)

## Related Reports
[DIS Converter Diagnostic Dump](/DIS%20Converter%20Diagnostic%20Dump/ "DIS Converter Diagnostic Dump Oracle EBS SQL Report"), [DIS Workbook Import Validation](/DIS%20Workbook%20Import%20Validation/ "DIS Workbook Import Validation Oracle EBS SQL Report"), [DIS Discoverer and Blitz Report Users](/DIS%20Discoverer%20and%20Blitz%20Report%20Users/ "DIS Discoverer and Blitz Report Users Oracle EBS SQL Report"), [DIS Workbook Conversion Selection](/DIS%20Workbook%20Conversion%20Selection/ "DIS Workbook Conversion Selection Oracle EBS SQL Report"), [DIS End User Layers](/DIS%20End%20User%20Layers/ "DIS End User Layers Oracle EBS SQL Report"), [DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/ "DIS Workbooks, Folders, Items and LOVs Oracle EBS SQL Report"), [DIS Folders, Business Areas, Items and LOVs](/DIS%20Folders-%20Business%20Areas-%20Items%20and%20LOVs/ "DIS Folders, Business Areas, Items and LOVs Oracle EBS SQL Report"), [DIS Workbook Export Script](/DIS%20Workbook%20Export%20Script/ "DIS Workbook Export Script Oracle EBS SQL Report"), [DIS Worksheet Execution History](/DIS%20Worksheet%20Execution%20History/ "DIS Worksheet Execution History Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Worksheet%20SQLs/DIS%20Worksheet%20SQLs.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-sqls) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DIS Worksheet SQLs 04-Jan-2019 135604.xlsx](https://www.enginatics.com/example/dis-worksheet-sqls/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-sqls) |
| Blitz Report™ XML Import | [DIS_Worksheet_SQLs.xml](https://www.enginatics.com/xml/dis-worksheet-sqls/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-sqls) |
| SQL Source | [DIS Worksheet SQLs.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Worksheet%20SQLs/DIS%20Worksheet%20SQLs.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dis-worksheet-sqls/](https://www.enginatics.com/reports/dis-worksheet-sqls/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-sqls) |

## DIS Worksheet SQLs

### Description
This report extracts the underlying SQL queries for Oracle Discoverer worksheets. Since Discoverer stores workbook definitions in a binary format within `eul5_documents`, extracting the SQL directly is difficult. This report relies on a trigger-based mechanism (using `eul_trigger$post_save_document`) that captures the SQL query at the time of saving and stores it in a custom table `ams_discoverer_sql`.

This tool is invaluable for:
- **Documentation**: Automatically documenting the logic behind legacy reports.
- **Migration**: Extracting SQL to migrate reports to other platforms like Blitz Report or BI Publisher.
- **Auditing**: Reviewing the complexity and efficiency of user-generated queries.

### Parameters
- **Workbook**: Filter by workbook name.
- **Worksheet**: Filter by worksheet name.
- **Access Count within x Days**: Filter based on recent usage.
- **Show Active only**: Toggle to show only active worksheets.
- **End User Layer**: Select the EUL to query.

### Used Tables
- `ams_discoverer_sql`: Custom table storing captured Discoverer SQL queries.
- `eul5_qpp_stats`: Query performance statistics.

### Categories
- **Enginatics**: Technical utility for Discoverer management and migration.

### Related Reports
- [DIS Workbook Import Validation](/DIS%20Workbook%20Import%20Validation/)

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-sqls)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-sqls)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-sqls)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-sqls)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-sqls)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-sqls)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-sqls)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
