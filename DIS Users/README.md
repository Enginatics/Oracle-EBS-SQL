---
layout: default
title: 'DIS Users | Oracle EBS SQL Report'
description: 'Discoverer end user layer users of different types (application user, responsibility, database user)'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DIS, Users, eul5_eul_users, eul5_qpp_stats'
permalink: /DIS%20Users/
---

# DIS Users – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-users/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Discoverer end user layer users of different types (application user, responsibility, database user)

## Report Parameters
Access Count within x Days, Show Active only, End User Layer

## Oracle EBS Tables Used
[eul5_eul_users](https://www.enginatics.com/library/?pg=1&find=eul5_eul_users), [eul5_qpp_stats](https://www.enginatics.com/library/?pg=1&find=eul5_qpp_stats)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DIS Access Privileges](/DIS%20Access%20Privileges/ "DIS Access Privileges Oracle EBS SQL Report"), [DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/ "DIS Workbooks, Folders, Items and LOVs Oracle EBS SQL Report"), [DIS Folders, Business Areas, Items and LOVs](/DIS%20Folders-%20Business%20Areas-%20Items%20and%20LOVs/ "DIS Folders, Business Areas, Items and LOVs Oracle EBS SQL Report"), [DIS Workbook Import Validation](/DIS%20Workbook%20Import%20Validation/ "DIS Workbook Import Validation Oracle EBS SQL Report"), [DIS Workbook Export Script](/DIS%20Workbook%20Export%20Script/ "DIS Workbook Export Script Oracle EBS SQL Report"), [DIS Business Areas](/DIS%20Business%20Areas/ "DIS Business Areas Oracle EBS SQL Report"), [DIS Worksheet Execution History](/DIS%20Worksheet%20Execution%20History/ "DIS Worksheet Execution History Oracle EBS SQL Report"), [DIS Worksheet Execution Summary](/DIS%20Worksheet%20Execution%20Summary/ "DIS Worksheet Execution Summary Oracle EBS SQL Report"), [DIS Worksheet SQLs](/DIS%20Worksheet%20SQLs/ "DIS Worksheet SQLs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DIS Users 04-Jan-2019 135320.xlsx](https://www.enginatics.com/example/dis-users/) |
| Blitz Report™ XML Import | [DIS_Users.xml](https://www.enginatics.com/xml/dis-users/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dis-users/](https://www.enginatics.com/reports/dis-users/) |

## Case Study & Technical Analysis

### Abstract
The **DIS Users** report provides a comprehensive directory of all entities granted access to the Discoverer End User Layer (EUL). Unlike standard database user lists, this report distinguishes between Oracle Applications users (`FND_USER`), Responsibilities, and raw Database Schemas, all of which can be granted EUL privileges.

### Technical Analysis

#### Core Components
*   **User Type**: Identifies if the grantee is a User, Responsibility, or Group.
*   **EUL Access**: Confirms that the user has the `EUL5_ACCESS_USER` role (or equivalent) allowing them to connect to Discoverer.
*   **Activity**: Correlates the user definition with `EUL5_QPP_STATS` to show the last time they actually ran a report.

#### Key Tables
*   `EUL5_EUL_USERS`: The EUL's internal user registry.
*   `EUL5_QPP_STATS`: Usage history.

#### Operational Use Cases
*   **License Compliance**: Identifying how many unique users have active Discoverer privileges.
*   **Security Cleanup**: Revoking access for users who haven't logged in for 180 days.
*   **Migration Planning**: Generating a mailing list of active Discoverer users to communicate the migration schedule.


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
