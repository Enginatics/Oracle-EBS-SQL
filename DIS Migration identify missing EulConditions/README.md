---
layout: default
title: 'DIS Migration identify missing EulConditions | Oracle EBS SQL Report'
description: 'This report identifies the missing EUL conditions defined at the folder level. – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DIS, Migration, identify, missing, xxen_discoverer_workbook_xmls, fnd_user, xmltable'
permalink: /DIS%20Migration%20identify%20missing%20EulConditions/
---

# DIS Migration identify missing EulConditions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-migration-identify-missing-eulconditions/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
This report identifies the missing EUL conditions defined at the folder level.

## Report Parameters
Document Id

## Oracle EBS Tables Used
[xxen_discoverer_workbook_xmls](https://www.enginatics.com/library/?pg=1&find=xxen_discoverer_workbook_xmls), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [xmltable](https://www.enginatics.com/library/?pg=1&find=xmltable), [xxen_report_templates_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_templates_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DIS End User Layers](/DIS%20End%20User%20Layers/ "DIS End User Layers Oracle EBS SQL Report"), [DIS Workbook Import Validation](/DIS%20Workbook%20Import%20Validation/ "DIS Workbook Import Validation Oracle EBS SQL Report"), [XDO Publisher Data Definitions](/XDO%20Publisher%20Data%20Definitions/ "XDO Publisher Data Definitions Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [DIS Discoverer and Blitz Report Users](/DIS%20Discoverer%20and%20Blitz%20Report%20Users/ "DIS Discoverer and Blitz Report Users Oracle EBS SQL Report"), [DIS Worksheet SQLs](/DIS%20Worksheet%20SQLs/ "DIS Worksheet SQLs Oracle EBS SQL Report"), [QP Customer Pricing Engine Request](/QP%20Customer%20Pricing%20Engine%20Request/ "QP Customer Pricing Engine Request Oracle EBS SQL Report"), [Blitz Report Default Templates](/Blitz%20Report%20Default%20Templates/ "Blitz Report Default Templates Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/dis-migration-identify-missing-eulconditions/) |
| Blitz Report™ XML Import | [DIS_Migration_identify_missing_EulConditions.xml](https://www.enginatics.com/xml/dis-migration-identify-missing-eulconditions/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dis-migration-identify-missing-eulconditions/](https://www.enginatics.com/reports/dis-migration-identify-missing-eulconditions/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
