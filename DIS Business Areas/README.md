---
layout: default
title: 'DIS Business Areas | Oracle EBS SQL Report'
description: 'Summary report showing Discoverer business areas, with an access account showing how many times a business area''s folder was used within the past x number…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Draft, Enginatics, DIS, Business, Areas, eul5_ba_obj_links, eul5_bas, eul5_qpp_stats'
permalink: /DIS%20Business%20Areas/
---

# DIS Business Areas – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-business-areas/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Summary report showing Discoverer business areas, with an access account showing how many times a business area's folder was used within the past x number of days.

## Report Parameters
Business Area, Access Count within x Days, Show Active only, End User Layer

## Oracle EBS Tables Used
[eul5_ba_obj_links](https://www.enginatics.com/library/?pg=1&find=eul5_ba_obj_links), [eul5_bas](https://www.enginatics.com/library/?pg=1&find=eul5_bas), [eul5_qpp_stats](https://www.enginatics.com/library/?pg=1&find=eul5_qpp_stats), [table](https://www.enginatics.com/library/?pg=1&find=table)

## Report Categories
[Draft](https://www.enginatics.com/library/?pg=1&category[]=Draft), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DIS Access Privileges](/DIS%20Access%20Privileges/ "DIS Access Privileges Oracle EBS SQL Report"), [DIS Worksheet Execution History](/DIS%20Worksheet%20Execution%20History/ "DIS Worksheet Execution History Oracle EBS SQL Report"), [DIS Folders, Business Areas, Items and LOVs](/DIS%20Folders-%20Business%20Areas-%20Items%20and%20LOVs/ "DIS Folders, Business Areas, Items and LOVs Oracle EBS SQL Report"), [DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/ "DIS Workbooks, Folders, Items and LOVs Oracle EBS SQL Report"), [DIS Workbook Export Script](/DIS%20Workbook%20Export%20Script/ "DIS Workbook Export Script Oracle EBS SQL Report"), [DIS Users](/DIS%20Users/ "DIS Users Oracle EBS SQL Report"), [DIS Worksheet SQLs](/DIS%20Worksheet%20SQLs/ "DIS Worksheet SQLs Oracle EBS SQL Report"), [DIS Worksheet Execution Summary](/DIS%20Worksheet%20Execution%20Summary/ "DIS Worksheet Execution Summary Oracle EBS SQL Report"), [DIS Workbook Import Validation](/DIS%20Workbook%20Import%20Validation/ "DIS Workbook Import Validation Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DIS Business Areas 29-Jul-2020 131756.xlsx](https://www.enginatics.com/example/dis-business-areas/) |
| Blitz Report™ XML Import | [DIS_Business_Areas.xml](https://www.enginatics.com/xml/dis-business-areas/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dis-business-areas/](https://www.enginatics.com/reports/dis-business-areas/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
