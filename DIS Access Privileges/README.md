---
layout: default
title: 'DIS Access Privileges | Oracle EBS SQL Report'
description: 'Discoverer access privileges – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DIS, Access, Privileges, eul5_access_privs, eul5_documents, eul5_bas'
permalink: /DIS%20Access%20Privileges/
---

# DIS Access Privileges – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-access-privileges/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Discoverer access privileges

## Report Parameters
Access Type, Access Count within x Days, Show Active Objects only, Show Active Users/Roles only, End User Layer

## Oracle EBS Tables Used
[eul5_access_privs](https://www.enginatics.com/library/?pg=1&find=eul5_access_privs), [eul5_documents](https://www.enginatics.com/library/?pg=1&find=eul5_documents), [eul5_bas](https://www.enginatics.com/library/?pg=1&find=eul5_bas), [eul5_qpp_stats](https://www.enginatics.com/library/?pg=1&find=eul5_qpp_stats), [table](https://www.enginatics.com/library/?pg=1&find=table), [eul5_ba_obj_links](https://www.enginatics.com/library/?pg=1&find=eul5_ba_obj_links), [fnd_user_resp_groups](https://www.enginatics.com/library/?pg=1&find=fnd_user_resp_groups)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DIS Business Areas](/DIS%20Business%20Areas/ "DIS Business Areas Oracle EBS SQL Report"), [DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/ "DIS Workbooks, Folders, Items and LOVs Oracle EBS SQL Report"), [DIS Worksheet Execution History](/DIS%20Worksheet%20Execution%20History/ "DIS Worksheet Execution History Oracle EBS SQL Report"), [DIS Folders, Business Areas, Items and LOVs](/DIS%20Folders-%20Business%20Areas-%20Items%20and%20LOVs/ "DIS Folders, Business Areas, Items and LOVs Oracle EBS SQL Report"), [DIS Workbook Import Validation](/DIS%20Workbook%20Import%20Validation/ "DIS Workbook Import Validation Oracle EBS SQL Report"), [DIS Workbook Export Script](/DIS%20Workbook%20Export%20Script/ "DIS Workbook Export Script Oracle EBS SQL Report"), [DIS Worksheet SQLs](/DIS%20Worksheet%20SQLs/ "DIS Worksheet SQLs Oracle EBS SQL Report"), [DIS Users](/DIS%20Users/ "DIS Users Oracle EBS SQL Report"), [DIS Discoverer and Blitz Report Users](/DIS%20Discoverer%20and%20Blitz%20Report%20Users/ "DIS Discoverer and Blitz Report Users Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DIS Access Privileges 04-Jan-2019 134602.xlsx](https://www.enginatics.com/example/dis-access-privileges/) |
| Blitz Report™ XML Import | [DIS_Access_Privileges.xml](https://www.enginatics.com/xml/dis-access-privileges/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dis-access-privileges/](https://www.enginatics.com/reports/dis-access-privileges/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
