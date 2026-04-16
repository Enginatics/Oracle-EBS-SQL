---
layout: default
title: 'DIS Items, Folders and Formulas | Oracle EBS SQL Report'
description: 'Discoverer items (expressions) and folders (objects), including join conditions and formulas (calculated items)'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DIS, Items,, Folders, Formulas, eul5_expressions, eul5_key_cons, "_CURRENT_EDITION_OBJ"'
permalink: /DIS%20Items-%20Folders%20and%20Formulas/
---

# DIS Items, Folders and Formulas – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-items-folders-and-formulas/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Discoverer items (expressions) and folders (objects), including join conditions and formulas (calculated items)

## Report Parameters
Folder, Folder Identifier, Folder Type, View Name, Item Id, Object Id, Used by Workbook, Item, Item Type, Show Object SQL, Validate LOV SQL, End User Layer

## Oracle EBS Tables Used
[eul5_expressions](https://www.enginatics.com/library/?pg=1&find=eul5_expressions), [eul5_key_cons](https://www.enginatics.com/library/?pg=1&find=eul5_key_cons), ["_CURRENT_EDITION_OBJ"](https://www.enginatics.com/library/?pg=1&find="_CURRENT_EDITION_OBJ"), [view$](https://www.enginatics.com/library/?pg=1&find=view$), [user$](https://www.enginatics.com/library/?pg=1&find=user$), [eul5_objs](https://www.enginatics.com/library/?pg=1&find=eul5_objs), [user_views](https://www.enginatics.com/library/?pg=1&find=user_views), [eul5_domains](https://www.enginatics.com/library/?pg=1&find=eul5_domains)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/ "DIS Workbooks, Folders, Items and LOVs Oracle EBS SQL Report"), [DIS Folders, Business Areas, Items and LOVs](/DIS%20Folders-%20Business%20Areas-%20Items%20and%20LOVs/ "DIS Folders, Business Areas, Items and LOVs Oracle EBS SQL Report"), [DIS Worksheet Execution History](/DIS%20Worksheet%20Execution%20History/ "DIS Worksheet Execution History Oracle EBS SQL Report"), [DIS Access Privileges](/DIS%20Access%20Privileges/ "DIS Access Privileges Oracle EBS SQL Report"), [DIS Business Areas](/DIS%20Business%20Areas/ "DIS Business Areas Oracle EBS SQL Report"), [DIS Workbook Import Validation](/DIS%20Workbook%20Import%20Validation/ "DIS Workbook Import Validation Oracle EBS SQL Report"), [DIS Worksheet Execution Summary](/DIS%20Worksheet%20Execution%20Summary/ "DIS Worksheet Execution Summary Oracle EBS SQL Report"), [DIS End User Layers](/DIS%20End%20User%20Layers/ "DIS End User Layers Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DIS Items, Folders and Formulas 28-Mar-2026 080606.xlsx](https://www.enginatics.com/example/dis-items-folders-and-formulas/) |
| Blitz Report™ XML Import | [DIS_Items_Folders_and_Formulas.xml](https://www.enginatics.com/xml/dis-items-folders-and-formulas/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dis-items-folders-and-formulas/](https://www.enginatics.com/reports/dis-items-folders-and-formulas/) |

## Case Study & Technical Analysis

### Abstract
The **DIS Items, Folders and Formulas** report provides a granular technical breakdown of the Discoverer End User Layer (EUL). It focuses specifically on the *logic* embedded within the EUL: calculated items (formulas), complex joins, and folder definitions. This report is a critical reference for developers tasked with re-implementing Discoverer logic in SQL or other reporting tools.

### Technical Analysis

#### Core Components
*   **Formulas**: Extracts the exact PL/SQL expression used for calculated items (e.g., `CASE WHEN x > 10 THEN 'High' ELSE 'Low' END`).
*   **Joins**: Displays the join conditions defined between folders, which often contain critical business logic that isn't present in the database foreign keys.
*   **LOV Validation**: Checks if the SQL backing a List of Values is valid and performant.

#### Key Tables
*   `EUL5_EXPRESSIONS`: The repository of all item formulas.
*   `EUL5_KEY_CONS`: Defines the joins (key constraints) between folders.

#### Operational Use Cases
*   **Reverse Engineering**: "The 'Net Revenue' item in Discoverer doesn't match the General Ledger. What is the formula?"
*   **Migration**: Copy-pasting complex `CASE` statements from Discoverer directly into new SQL reports.
*   **Cleanup**: Identifying broken formulas that reference non-existent columns.


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
