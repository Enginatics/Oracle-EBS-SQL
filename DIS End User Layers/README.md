---
layout: default
title: 'DIS End User Layers | Oracle EBS SQL Report'
description: 'Discoverer end user layers – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DIS, End, User, Layers, xxen_report_parameter_lovs, dba_synonyms, dba_tables'
permalink: /DIS%20End%20User%20Layers/
---

# DIS End User Layers – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-end-user-layers/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Discoverer end user layers

## Report Parameters
End User Layer, History days

## Oracle EBS Tables Used
[xxen_report_parameter_lovs](https://www.enginatics.com/library/?pg=1&find=xxen_report_parameter_lovs), [dba_synonyms](https://www.enginatics.com/library/?pg=1&find=dba_synonyms), [dba_tables](https://www.enginatics.com/library/?pg=1&find=dba_tables), [dba_objects](https://www.enginatics.com/library/?pg=1&find=dba_objects), [&eul_object_counts](https://www.enginatics.com/library/?pg=1&find=&eul_object_counts), [xxen_discoverer_workbook_xmls](https://www.enginatics.com/library/?pg=1&find=xxen_discoverer_workbook_xmls), [xxen_discoverer_workbooks](https://www.enginatics.com/library/?pg=1&find=xxen_discoverer_workbooks), [xxen_discoverer_sheets](https://www.enginatics.com/library/?pg=1&find=xxen_discoverer_sheets), [xxen_report_templates_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_templates_v), [xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DIS Workbook Import Validation](/DIS%20Workbook%20Import%20Validation/ "DIS Workbook Import Validation Oracle EBS SQL Report"), [DIS Migration identify missing EulConditions](/DIS%20Migration%20identify%20missing%20EulConditions/ "DIS Migration identify missing EulConditions Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA Blitz Report ORDS Configuration](/DBA%20Blitz%20Report%20ORDS%20Configuration/ "DBA Blitz Report ORDS Configuration Oracle EBS SQL Report"), [DIS Discoverer and Blitz Report Users](/DIS%20Discoverer%20and%20Blitz%20Report%20Users/ "DIS Discoverer and Blitz Report Users Oracle EBS SQL Report"), [Blitz Report Security](/Blitz%20Report%20Security/ "Blitz Report Security Oracle EBS SQL Report"), [DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/ "DIS Workbooks, Folders, Items and LOVs Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DIS End User Layers 28-Mar-2026 080435.xlsx](https://www.enginatics.com/example/dis-end-user-layers/) |
| Blitz Report™ XML Import | [DIS_End_User_Layers.xml](https://www.enginatics.com/xml/dis-end-user-layers/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dis-end-user-layers/](https://www.enginatics.com/reports/dis-end-user-layers/) |

## Case Study & Technical Analysis

### Abstract
The **DIS End User Layers** report provides technical metadata about the Discoverer End User Layers (EULs) installed in the database. An EUL is the schema that holds all Discoverer metadata (Business Areas, Folders, Workbooks). Large organizations often have multiple EULs (e.g., `EUL_US`, `EUL_EU`) to segregate reporting content.

### Technical Analysis

#### Core Components
*   **EUL Owner**: The database schema that owns the EUL tables (typically `EUL5_US` or similar).
*   **Version**: The version of the EUL (e.g., 5.1.1), which is critical for compatibility.
*   **Object Counts**: Summaries of how many workbooks, folders, and items exist in each EUL.

#### Key Tables
*   `DBA_USERS`: To identify EUL schemas.
*   `XXEN_DISCOVERER_WORKBOOKS`: Custom views used to analyze the EUL content.

#### Operational Use Cases
*   **Environment Assessment**: Quickly understanding the reporting landscape of a new EBS instance.
*   **Consolidation**: Planning the merge of multiple regional EULs into a single global EUL.
*   **Backup/Restore**: Verifying that all EUL schemas are included in backup strategies.


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
