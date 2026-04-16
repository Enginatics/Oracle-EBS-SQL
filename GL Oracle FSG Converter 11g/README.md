---
layout: default
title: 'GL Oracle FSG Converter 11g | Oracle EBS SQL Report'
description: 'This report is used by the GL Financial Statement and Drilldown report, to migrate financial statement reports from Oracle FSG. The GL Oracle FSG…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Oracle, FSG, Converter, 11g, rg_report_calculations, rg_reports_v, rg_report_axes_v'
permalink: /GL%20Oracle%20FSG%20Converter%2011g/
---

# GL Oracle FSG Converter 11g – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-oracle-fsg-converter-11g/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
** This report is used by the GL Financial Statement and Drilldown report, to migrate financial statement reports from Oracle FSG. **

The GL Oracle FSG Converter is used for migration of financial statement reports from Oracle Financial Statement Generator (FSG) into the GL Financial Statement and Drilldown (FSG) report. This converter simplifies the process of transferring the existing Oracle FSG reports, allowing users to leverage advanced reporting and drilldown capabilities with minimal setup.

This version supports DB versions 11g and 12c. To apply the converter, the profile 'Blitz FSG Oracle to Blitz Report Converter' must be updated with the relevant report name based on the db version.

For a quick demonstration of GL Financial Statement and Drilldown (FSG), refer to our YouTube video.
<a href="https://youtu.be/dsRWXT2bem8?si=bA8cAxuXjfrMI-SI" rel="nofollow" target="_blank">https://youtu.be/dsRWXT2bem8?si=bA8cAxuXjfrMI-SI</a>

## Report Parameters
Report Name, Ledger

## Oracle EBS Tables Used
[rg_report_calculations](https://www.enginatics.com/library/?pg=1&find=rg_report_calculations), [rg_reports_v](https://www.enginatics.com/library/?pg=1&find=rg_reports_v), [rg_report_axes_v](https://www.enginatics.com/library/?pg=1&find=rg_report_axes_v), [rg_report_axis_contents](https://www.enginatics.com/library/?pg=1&find=rg_report_axis_contents), [rg_report_axis_sets_v](https://www.enginatics.com/library/?pg=1&find=rg_report_axis_sets_v), [merged_data](https://www.enginatics.com/library/?pg=1&find=merged_data)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/gl-oracle-fsg-converter-11g/) |
| Blitz Report™ XML Import | [GL_Oracle_FSG_Converter_11g.xml](https://www.enginatics.com/xml/gl-oracle-fsg-converter-11g/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-oracle-fsg-converter-11g/](https://www.enginatics.com/reports/gl-oracle-fsg-converter-11g/) |

## GL Oracle FSG Converter 11g - Case Study & Technical Analysis

### Executive Summary
The **GL Oracle FSG Converter 11g** is the counterpart to the standard converter, specifically engineered for Oracle Database 11g environments. It performs the same function—migrating legacy FSG reports to modern Excel formats—but uses SQL syntax and logic compatible with the older 11g database engine. This ensures that customers on older infrastructure can still benefit from reporting modernization tools.

### Business Use Cases
*   **Legacy Infrastructure Support**: Allows organizations still running EBS on Oracle 11g to utilize modern reporting tools without forcing a database upgrade.
*   **Risk Mitigation**: Provides a fallback option if the standard converter (optimized for 12c+) encounters compatibility issues in a specific environment.
*   **Standardization**: Ensures that the migration process is consistent across all environments, regardless of the underlying database version.

### Technical Analysis

#### Core Tables
*   `RG_REPORTS_V`
*   `RG_REPORT_AXIS_SETS_V`
*   `RG_REPORT_AXIS_CONTENTS`
*   `RG_REPORT_CALCULATIONS`

#### Key Joins & Logic
*   **11g Constraints**: The primary difference is in the SQL construction. It likely avoids 12c-specific functions (like `LISTAGG` with certain options, or specific JSON/XML functions) and uses 11g-compatible alternatives (like `WM_CONCAT` or custom PL/SQL aggregations) to generate the output.
*   **Functional Parity**: Despite the syntax differences, it aims to produce the exact same output format as the 12c version, ensuring the resulting Excel reports function identically.

#### Key Parameters
*   **Report Name**: The FSG report to convert.
*   **Ledger**: The context for the conversion.


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
