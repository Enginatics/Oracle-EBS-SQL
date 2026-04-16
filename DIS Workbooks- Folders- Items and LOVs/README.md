---
layout: default
title: 'DIS Workbooks, Folders, Items and LOVs | Oracle EBS SQL Report'
description: 'Discoverer workbooks, their owners, folders, items and item class LOVs, derived from dependency table eul5elemxrefs.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DIS, Workbooks,, Folders,, Items, dba_views, eul5_documents, eul5_elem_xrefs'
permalink: /DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/
---

# DIS Workbooks, Folders, Items and LOVs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-workbooks-folders-items-and-lovs/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Discoverer workbooks, their owners, folders, items and item class LOVs, derived from dependency table eul5_elem_xrefs.

## Report Parameters
Workbook, Folder, View Name, Workbook Id, Access Count within x Days, Show Active only, Display Level, End User Layer

## Oracle EBS Tables Used
[dba_views](https://www.enginatics.com/library/?pg=1&find=dba_views), [eul5_documents](https://www.enginatics.com/library/?pg=1&find=eul5_documents), [eul5_elem_xrefs](https://www.enginatics.com/library/?pg=1&find=eul5_elem_xrefs), ["_CURRENT_EDITION_OBJ"](https://www.enginatics.com/library/?pg=1&find="_CURRENT_EDITION_OBJ"), [view$](https://www.enginatics.com/library/?pg=1&find=view$), [user$](https://www.enginatics.com/library/?pg=1&find=user$), [eul5_objs](https://www.enginatics.com/library/?pg=1&find=eul5_objs), [eul5_qpp_stats](https://www.enginatics.com/library/?pg=1&find=eul5_qpp_stats), [eul5_expressions](https://www.enginatics.com/library/?pg=1&find=eul5_expressions), [eul5_domains](https://www.enginatics.com/library/?pg=1&find=eul5_domains), [eul5_key_cons](https://www.enginatics.com/library/?pg=1&find=eul5_key_cons), [eul5_functions](https://www.enginatics.com/library/?pg=1&find=eul5_functions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DIS Folders, Business Areas, Items and LOVs](/DIS%20Folders-%20Business%20Areas-%20Items%20and%20LOVs/ "DIS Folders, Business Areas, Items and LOVs Oracle EBS SQL Report"), [DIS Items, Folders and Formulas](/DIS%20Items-%20Folders%20and%20Formulas/ "DIS Items, Folders and Formulas Oracle EBS SQL Report"), [DIS Worksheet Execution History](/DIS%20Worksheet%20Execution%20History/ "DIS Worksheet Execution History Oracle EBS SQL Report"), [DIS Access Privileges](/DIS%20Access%20Privileges/ "DIS Access Privileges Oracle EBS SQL Report"), [DIS Workbook Export Script](/DIS%20Workbook%20Export%20Script/ "DIS Workbook Export Script Oracle EBS SQL Report"), [DIS Business Areas](/DIS%20Business%20Areas/ "DIS Business Areas Oracle EBS SQL Report"), [DIS Workbook Import Validation](/DIS%20Workbook%20Import%20Validation/ "DIS Workbook Import Validation Oracle EBS SQL Report"), [DIS Worksheet Execution Summary](/DIS%20Worksheet%20Execution%20Summary/ "DIS Worksheet Execution Summary Oracle EBS SQL Report"), [DIS Worksheet SQLs](/DIS%20Worksheet%20SQLs/ "DIS Worksheet SQLs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DIS Workbooks, Folders, Items and LOVs 28-Mar-2026 080822.xlsx](https://www.enginatics.com/example/dis-workbooks-folders-items-and-lovs/) |
| Blitz Report™ XML Import | [DIS_Workbooks_Folders_Items_and_LOVs.xml](https://www.enginatics.com/xml/dis-workbooks-folders-items-and-lovs/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dis-workbooks-folders-items-and-lovs/](https://www.enginatics.com/reports/dis-workbooks-folders-items-and-lovs/) |

## DIS Workbooks, Folders, Items and LOVs

### Description
This report provides a deep dive into the structural dependencies of Oracle Discoverer workbooks. It maps workbooks to their underlying folders, items, and List of Values (LOV) item classes, derived from the dependency table `eul5_elem_xrefs`.

Key insights provided by this report include:
- **Workbook Dependencies**: Identifies which database views and folders are used by specific workbooks.
- **Item Usage**: Lists the specific items (columns) used within workbooks, helping to identify critical data elements.
- **LOV Analysis**: Shows item class LOVs associated with workbook items.
- **Usage Metrics**: Includes access counts to help determine the relevance and activity level of workbooks.

This detailed dependency mapping is essential for impact analysis when changing database objects or EUL definitions, as well as for planning the migration of complex reports to Blitz Report.

### Parameters
- **Workbook**: Filter by workbook name.
- **Folder**: Filter by EUL folder name.
- **View Name**: Filter by the underlying database view name.
- **Workbook Id**: Filter by specific workbook ID.
- **Access Count within x Days**: Filter workbooks based on recent usage activity.
- **Show Active only**: Toggle to show only active workbooks.
- **Display Level**: Control the granularity of the report output.
- **End User Layer**: Select the EUL to analyze.

### Used Tables
- `dba_views`: Database views metadata.
- `eul5_documents`: Discoverer workbook definitions.
- `eul5_elem_xrefs`: Cross-references between EUL elements.
- `eul5_objs`: EUL objects (folders).
- `eul5_qpp_stats`: Query statistics.
- `eul5_expressions`: EUL expressions (calculations).
- `eul5_domains`: EUL domains (LOVs).
- `eul5_key_cons`: Key constraints (joins).
- `eul5_functions`: EUL functions.

### Categories
- **Enginatics**: Technical analysis tool for Discoverer environments.

### Related Reports
- [DIS Folders, Business Areas, Items and LOVs](/DIS%20Folders-%20Business%20Areas-%20Items%20and%20LOVs/)
- [DIS Items, Folders and Formulas](/DIS%20Items-%20Folders%20and%20Formulas/)


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
