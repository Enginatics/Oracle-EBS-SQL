---
layout: default
last_modified_at: 2026-10-16
title: 'DIS Access Privileges | Oracle EBS SQL Report'
description: 'Discoverer access privileges – Oracle EBS Discoverer SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Discoverer, Enginatics, DIS, Access, Privileges, eul5_access_privs, eul5_documents, eul5_bas'
permalink: /DIS%20Access%20Privileges/
report_name: 'DIS Access Privileges'
report_web_name: dis-access-privileges
module: 'Discoverer'
module_url: /modules/discoverer/
---

# DIS Access Privileges – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-access-privileges/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-access-privileges) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-access-privileges).
**Oracle EBS module:** [Discoverer](/modules/discoverer/ "Oracle EBS Discoverer reports") · [all Discoverer reports](/modules/discoverer/)  

## Overview
Discoverer access privileges

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-access-privileges) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Access Type, Access Count within x Days, Show Active Objects only, Show Active Users/Roles only, End User Layer

## Oracle EBS Tables Used
[eul5_access_privs](https://www.enginatics.com/library/?pg=1&find=eul5_access_privs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-access-privileges), [eul5_documents](https://www.enginatics.com/library/?pg=1&find=eul5_documents&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-access-privileges), [eul5_bas](https://www.enginatics.com/library/?pg=1&find=eul5_bas&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-access-privileges), [eul5_qpp_stats](https://www.enginatics.com/library/?pg=1&find=eul5_qpp_stats&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-access-privileges), [eul5_ba_obj_links](https://www.enginatics.com/library/?pg=1&find=eul5_ba_obj_links&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-access-privileges), [fnd_user_resp_groups](https://www.enginatics.com/library/?pg=1&find=fnd_user_resp_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-access-privileges)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-access-privileges)

## Related Reports
[DIS Business Areas](/DIS%20Business%20Areas/ "DIS Business Areas Oracle EBS SQL Report"), [DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/ "DIS Workbooks, Folders, Items and LOVs Oracle EBS SQL Report"), [DIS Converter Diagnostic Dump](/DIS%20Converter%20Diagnostic%20Dump/ "DIS Converter Diagnostic Dump Oracle EBS SQL Report"), [DIS Worksheet Execution History](/DIS%20Worksheet%20Execution%20History/ "DIS Worksheet Execution History Oracle EBS SQL Report"), [DIS Workbook Export Script](/DIS%20Workbook%20Export%20Script/ "DIS Workbook Export Script Oracle EBS SQL Report"), [DIS Folders, Business Areas, Items and LOVs](/DIS%20Folders-%20Business%20Areas-%20Items%20and%20LOVs/ "DIS Folders, Business Areas, Items and LOVs Oracle EBS SQL Report"), [DIS Workbook Import Validation](/DIS%20Workbook%20Import%20Validation/ "DIS Workbook Import Validation Oracle EBS SQL Report"), [DIS Workbook Conversion Selection](/DIS%20Workbook%20Conversion%20Selection/ "DIS Workbook Conversion Selection Oracle EBS SQL Report"), [DIS Users](/DIS%20Users/ "DIS Users Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Access%20Privileges/DIS%20Access%20Privileges.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-access-privileges) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DIS Access Privileges 04-Jan-2019 134602.xlsx](https://www.enginatics.com/example/dis-access-privileges/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-access-privileges) |
| Blitz Report™ XML Import | [DIS_Access_Privileges.xml](https://www.enginatics.com/xml/dis-access-privileges/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-access-privileges) |
| SQL Source | [DIS Access Privileges.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Access%20Privileges/DIS%20Access%20Privileges.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dis-access-privileges/](https://www.enginatics.com/reports/dis-access-privileges/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-access-privileges) |

## Case Study & Technical Analysis

### Abstract
The **DIS Access Privileges** report is a security auditing tool for Oracle Discoverer. It maps the complex web of permissions within the End User Layer (EUL), showing which users or responsibilities have access to specific Business Areas and Workbooks. This report is essential for compliance audits and for cleaning up access rights during a migration project.

### Technical Analysis

#### Core Relationships
*   **Users/Roles**: Discoverer privileges can be granted to individual Oracle Users or to Responsibilities (Roles).
*   **Business Areas**: The primary container for data access. If a user has access to a Business Area, they can query any folder within it.
*   **Workbooks**: Specific reports shared with users.

#### Key Tables
*   `EUL5_ACCESS_PRIVS`: The central table linking users/roles (`AP_EU_ID`) to objects (`AP_ELEMENT_ID`).
*   `EUL5_DOCUMENTS`: Stores workbook definitions.
*   `EUL5_BAS`: Stores Business Area definitions.

#### Operational Use Cases
*   **Security Audit**: "Who has access to the 'HR Confidential' Business Area?"
*   **License Management**: Identifying inactive users who still hold Discoverer privileges.
*   **Migration Planning**: Determining which users need to be trained on the new reporting tool based on their current access.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-access-privileges)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-access-privileges)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-access-privileges)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-access-privileges)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-access-privileges)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-access-privileges)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-access-privileges)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
