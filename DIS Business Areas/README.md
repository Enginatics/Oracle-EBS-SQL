---
layout: default
last_modified_at: 2026-10-16
title: 'DIS Business Areas | Oracle EBS SQL Report'
description: 'Summary report showing Discoverer business areas, with an access account showing how many times a business area''s folder was used within the past x number…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Discoverer, Enginatics, DIS, Business, Areas, eul5_ba_obj_links, eul5_bas, eul5_qpp_stats'
permalink: /DIS%20Business%20Areas/
report_name: 'DIS Business Areas'
report_web_name: dis-business-areas
module: 'Discoverer'
module_url: /modules/discoverer/
---

# DIS Business Areas – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-business-areas/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-business-areas) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-business-areas).
**Oracle EBS module:** [Discoverer](/modules/discoverer/ "Oracle EBS Discoverer reports") · [all Discoverer reports](/modules/discoverer/)  

## Overview
Summary report showing Discoverer business areas, with an access account showing how many times a business area's folder was used within the past x number of days.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-business-areas) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Business Area, Access Count within x Days, Show Active only, End User Layer

## Oracle EBS Tables Used
[eul5_ba_obj_links](https://www.enginatics.com/library/?pg=1&find=eul5_ba_obj_links&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-business-areas), [eul5_bas](https://www.enginatics.com/library/?pg=1&find=eul5_bas&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-business-areas), [eul5_qpp_stats](https://www.enginatics.com/library/?pg=1&find=eul5_qpp_stats&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-business-areas)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-business-areas)

## Related Reports
[DIS Access Privileges](/DIS%20Access%20Privileges/ "DIS Access Privileges Oracle EBS SQL Report"), [DIS Worksheet Execution History](/DIS%20Worksheet%20Execution%20History/ "DIS Worksheet Execution History Oracle EBS SQL Report"), [DIS Folders, Business Areas, Items and LOVs](/DIS%20Folders-%20Business%20Areas-%20Items%20and%20LOVs/ "DIS Folders, Business Areas, Items and LOVs Oracle EBS SQL Report"), [DIS Converter Diagnostic Dump](/DIS%20Converter%20Diagnostic%20Dump/ "DIS Converter Diagnostic Dump Oracle EBS SQL Report"), [DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/ "DIS Workbooks, Folders, Items and LOVs Oracle EBS SQL Report"), [DIS Workbook Export Script](/DIS%20Workbook%20Export%20Script/ "DIS Workbook Export Script Oracle EBS SQL Report"), [DIS Worksheet SQLs](/DIS%20Worksheet%20SQLs/ "DIS Worksheet SQLs Oracle EBS SQL Report"), [DIS Worksheet Execution Summary](/DIS%20Worksheet%20Execution%20Summary/ "DIS Worksheet Execution Summary Oracle EBS SQL Report"), [DIS Workbook Import Validation](/DIS%20Workbook%20Import%20Validation/ "DIS Workbook Import Validation Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Business%20Areas/DIS%20Business%20Areas.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-business-areas) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DIS Business Areas 29-Jul-2020 131756.xlsx](https://www.enginatics.com/example/dis-business-areas/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-business-areas) |
| Blitz Report™ XML Import | [DIS_Business_Areas.xml](https://www.enginatics.com/xml/dis-business-areas/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-business-areas) |
| SQL Source | [DIS Business Areas.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Business%20Areas/DIS%20Business%20Areas.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dis-business-areas/](https://www.enginatics.com/reports/dis-business-areas/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-business-areas) |

## Case Study & Technical Analysis

### Abstract
The **DIS Business Areas** report provides a high-level inventory of the semantic layer in Oracle Discoverer. It lists all defined Business Areas and, crucially, correlates them with usage statistics. This allows administrators to distinguish between active, critical data models and obsolete "zombie" areas that haven't been queried in years.

### Technical Analysis

#### Core Metrics
*   **Business Area**: The logical grouping of folders (tables/views).
*   **Access Count**: Derived from `EUL5_QPP_STATS`, this metric shows how many times queries have been executed against this Business Area within a configurable time window.
*   **Last Accessed**: The timestamp of the most recent query.

#### Key Tables
*   `EUL5_BAS`: The Business Area definitions.
*   `EUL5_BA_OBJ_LINKS`: The many-to-many link between Business Areas and Folders (Objects).
*   `EUL5_QPP_STATS`: The Query Prediction and Performance statistics table, which acts as an audit log for Discoverer execution.

#### Operational Use Cases
*   **Cleanup**: Safely deleting Business Areas that show zero access count in the last 365 days.
*   **Impact Analysis**: "If I modify the 'Order Management' Business Area, how many users are potentially affected?"
*   **Documentation**: Generating a catalog of available data domains for end users.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-business-areas)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-business-areas)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-business-areas)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-business-areas)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-business-areas)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-business-areas)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-business-areas)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
