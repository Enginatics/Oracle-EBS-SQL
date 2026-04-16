---
layout: default
title: 'DIS Folders, Business Areas, Items and LOVs | Oracle EBS SQL Report'
description: 'Discoverer folders, business areas and items. Columns ''Access Count'' and ''Last Accessed'' shows how many times a folder was accessed by a worksheet within…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DIS, Folders,, Business, Areas,, dba_views, "_CURRENT_EDITION_OBJ", view$'
permalink: /DIS%20Folders-%20Business%20Areas-%20Items%20and%20LOVs/
---

# DIS Folders, Business Areas, Items and LOVs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-folders-business-areas-items-and-lovs/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Discoverer folders, business areas and items.
Columns 'Access Count' and 'Last Accessed' shows how many times a folder was accessed by a worksheet within the past x days.
Parameter 'Show Active Only' restricts to folders which have been accessed by worksheet executions within the past x days.

## Report Parameters
Business Area, Folder, Folder Identifier, Folder Type, View Name, Object Id, Used by Workbook, Item, Item Type, Access Count within x Days, Show Active only, Show Items, Show Object SQL, End User Layer

## Oracle EBS Tables Used
[dba_views](https://www.enginatics.com/library/?pg=1&find=dba_views), ["_CURRENT_EDITION_OBJ"](https://www.enginatics.com/library/?pg=1&find="_CURRENT_EDITION_OBJ"), [view$](https://www.enginatics.com/library/?pg=1&find=view$), [user$](https://www.enginatics.com/library/?pg=1&find=user$), [eul5_objs](https://www.enginatics.com/library/?pg=1&find=eul5_objs), [eul5_expressions](https://www.enginatics.com/library/?pg=1&find=eul5_expressions), [eul5_domains](https://www.enginatics.com/library/?pg=1&find=eul5_domains), [eul5_qpp_stats](https://www.enginatics.com/library/?pg=1&find=eul5_qpp_stats), [table](https://www.enginatics.com/library/?pg=1&find=table)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/ "DIS Workbooks, Folders, Items and LOVs Oracle EBS SQL Report"), [DIS Items, Folders and Formulas](/DIS%20Items-%20Folders%20and%20Formulas/ "DIS Items, Folders and Formulas Oracle EBS SQL Report"), [DIS Worksheet Execution History](/DIS%20Worksheet%20Execution%20History/ "DIS Worksheet Execution History Oracle EBS SQL Report"), [DIS Access Privileges](/DIS%20Access%20Privileges/ "DIS Access Privileges Oracle EBS SQL Report"), [DIS Business Areas](/DIS%20Business%20Areas/ "DIS Business Areas Oracle EBS SQL Report"), [DIS End User Layers](/DIS%20End%20User%20Layers/ "DIS End User Layers Oracle EBS SQL Report"), [DIS Workbook Export Script](/DIS%20Workbook%20Export%20Script/ "DIS Workbook Export Script Oracle EBS SQL Report"), [DIS Worksheet Execution Summary](/DIS%20Worksheet%20Execution%20Summary/ "DIS Worksheet Execution Summary Oracle EBS SQL Report"), [DIS Workbook Import Validation](/DIS%20Workbook%20Import%20Validation/ "DIS Workbook Import Validation Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DIS Folders, Business Areas, Items and LOVs 29-Jul-2020 141156.xlsx](https://www.enginatics.com/example/dis-folders-business-areas-items-and-lovs/) |
| Blitz Report™ XML Import | [DIS_Folders_Business_Areas_Items_and_LOVs.xml](https://www.enginatics.com/xml/dis-folders-business-areas-items-and-lovs/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dis-folders-business-areas-items-and-lovs/](https://www.enginatics.com/reports/dis-folders-business-areas-items-and-lovs/) |

## Case Study & Technical Analysis

### Abstract
The **DIS Folders, Business Areas, Items and LOVs** report is a comprehensive reverse-engineering tool for Oracle Discoverer. It extracts the detailed definition of every folder (which maps to a table or view) and every item (column or calculation) within the EUL. This level of detail is indispensable when migrating complex Discoverer logic to SQL, Blitz Report, or BI Publisher.

### Technical Analysis

#### Core Components
*   **Folder Definition**: Shows the underlying database object (Table/View) or the Custom SQL used to define the folder.
*   **Item Definition**: Shows the formula for calculated items (e.g., `SUM(Sales) * 1.1`) and the mapping to database columns.
*   **Lists of Values (LOVs)**: Identifies which items have attached LOVs, which is critical for recreating parameter logic.

#### Key Tables
*   `EUL5_OBJS`: Stores folder definitions.
*   `EUL5_EXPRESSIONS`: Stores item formulas and calculations.
*   `EUL5_DOMAINS`: Stores LOV definitions.

#### Operational Use Cases
*   **Migration**: "I need to recreate the 'Monthly Sales' workbook in SQL. What is the exact formula for the 'Gross Margin' item?"
*   **Dependency Analysis**: "Which folders are based on the view `PO_HEADERS_V`?"
*   **Optimization**: Identifying folders based on inefficient Custom SQL that should be converted to database views.


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
