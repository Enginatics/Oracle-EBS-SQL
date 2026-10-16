---
layout: default
last_modified_at: 2026-10-16
title: 'DIS Migration identify missing EulConditions | Oracle EBS SQL Report'
description: 'This report identifies the missing EUL conditions defined at the folder level. – Oracle EBS Discoverer SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Discoverer, Enginatics, DIS, Migration, identify, missing, xxen_discoverer_workbook_xmls, fnd_user, xxen_report_templates_v'
permalink: /DIS%20Migration%20identify%20missing%20EulConditions/
report_name: 'DIS Migration identify missing EulConditions'
report_web_name: dis-migration-identify-missing-eulconditions
module: 'Discoverer'
module_url: /modules/discoverer/
---

# DIS Migration identify missing EulConditions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-migration-identify-missing-eulconditions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-migration-identify-missing-eulconditions) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-migration-identify-missing-eulconditions).
**Oracle EBS module:** [Discoverer](/modules/discoverer/ "Oracle EBS Discoverer reports") · [all Discoverer reports](/modules/discoverer/)  

## Overview
This report identifies the missing EUL conditions defined at the folder level.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-migration-identify-missing-eulconditions) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Document Id

## Oracle EBS Tables Used
[xxen_discoverer_workbook_xmls](https://www.enginatics.com/library/?pg=1&find=xxen_discoverer_workbook_xmls&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-migration-identify-missing-eulconditions), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-migration-identify-missing-eulconditions), [xxen_report_templates_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_templates_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-migration-identify-missing-eulconditions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-migration-identify-missing-eulconditions)

## Related Reports
[DIS End User Layers](/DIS%20End%20User%20Layers/ "DIS End User Layers Oracle EBS SQL Report"), [DIS Workbook Import Validation](/DIS%20Workbook%20Import%20Validation/ "DIS Workbook Import Validation Oracle EBS SQL Report"), [DIS Workbook Conversion Selection](/DIS%20Workbook%20Conversion%20Selection/ "DIS Workbook Conversion Selection Oracle EBS SQL Report"), [DIS Converter Diagnostic Dump](/DIS%20Converter%20Diagnostic%20Dump/ "DIS Converter Diagnostic Dump Oracle EBS SQL Report"), [Blitz Report Template Sharing Upload](/Blitz%20Report%20Template%20Sharing%20Upload/ "Blitz Report Template Sharing Upload Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [Blitz Report Template Sharing](/Blitz%20Report%20Template%20Sharing/ "Blitz Report Template Sharing Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DIS Discoverer and Blitz Report Users](/DIS%20Discoverer%20and%20Blitz%20Report%20Users/ "DIS Discoverer and Blitz Report Users Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Migration%20identify%20missing%20EulConditions/DIS%20Migration%20identify%20missing%20EulConditions.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-migration-identify-missing-eulconditions) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/dis-migration-identify-missing-eulconditions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-migration-identify-missing-eulconditions) |
| Blitz Report™ XML Import | [DIS_Migration_identify_missing_EulConditions.xml](https://www.enginatics.com/xml/dis-migration-identify-missing-eulconditions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-migration-identify-missing-eulconditions) |
| SQL Source | [DIS Migration identify missing EulConditions.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Migration%20identify%20missing%20EulConditions/DIS%20Migration%20identify%20missing%20EulConditions.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dis-migration-identify-missing-eulconditions/](https://www.enginatics.com/reports/dis-migration-identify-missing-eulconditions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-migration-identify-missing-eulconditions) |

## Case Study & Technical Analysis

### Abstract
The **DIS Migration identify missing EulConditions** report is a specialized quality assurance tool for the Discoverer-to-Blitz Report migration process. In Discoverer, administrators can define "mandatory conditions" at the folder level (e.g., `ORG_ID = 101`) that are silently appended to every query using that folder. If these conditions are lost during migration, users might inadvertently access data they shouldn't see.

### Technical Analysis

#### Core Logic
*   **XML Parsing**: The report parses the exported Discoverer XML (`.eex` files) stored in `XXEN_DISCOVERER_WORKBOOK_XMLS`.
*   **Gap Analysis**: It compares the conditions found in the XML against the converted SQL in Blitz Report to ensure that folder-level filters were correctly carried over.

#### Key Tables
*   `XXEN_DISCOVERER_WORKBOOK_XMLS`: A staging table holding the raw XML export of Discoverer workbooks.
*   `XMLTABLE`: Used to query the XML structure directly within the database.

#### Operational Use Cases
*   **Security Validation**: Ensuring that mandatory security filters (like Multi-Org access control) are preserved.
*   **Data Integrity**: Preventing "cartesian product" reports caused by missing join conditions that were defined as folder conditions.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-migration-identify-missing-eulconditions)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-migration-identify-missing-eulconditions)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-migration-identify-missing-eulconditions)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-migration-identify-missing-eulconditions)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-migration-identify-missing-eulconditions)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-migration-identify-missing-eulconditions)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-migration-identify-missing-eulconditions)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
