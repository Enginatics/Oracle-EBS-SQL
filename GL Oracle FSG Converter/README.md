---
layout: default
last_modified_at: 2026-10-16
title: 'GL Oracle FSG Converter | Oracle EBS SQL Report'
description: 'This report is used by the GL Financial Statement and Drilldown report, to migrate financial statement reports from Oracle FSG. The GL Oracle FSG…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, General Ledger, Enginatics, Oracle, FSG, Converter, rg_report_calculations, rg_reports_v, rg_report_axes_v'
permalink: /GL%20Oracle%20FSG%20Converter/
report_name: 'GL Oracle FSG Converter'
report_web_name: gl-oracle-fsg-converter
module: 'General Ledger'
module_url: /modules/general-ledger/
---

# GL Oracle FSG Converter – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-oracle-fsg-converter/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-oracle-fsg-converter) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-oracle-fsg-converter).
**Oracle EBS module:** [General Ledger](/modules/general-ledger/ "Oracle EBS General Ledger reports") · [all General Ledger reports](/modules/general-ledger/)  

## Overview
** This report is used by the GL Financial Statement and Drilldown report, to migrate financial statement reports from Oracle FSG. **

The GL Oracle FSG Converter is used for migration of financial statement reports from Oracle Financial Statement Generator (FSG) into the GL Financial Statement and Drilldown (FSG) report. This converter simplifies the process of transferring the existing Oracle FSG reports, allowing users to leverage advanced reporting and drilldown capabilities with minimal setup.

This version supports DB versions above 12c. To apply the converter, the profile 'Blitz FSG Oracle to Blitz Report Converter' must be updated with the relevant report name based on the db version.

For a quick demonstration of GL Financial Statement and Drilldown (FSG), refer to our YouTube video.
<a href="https://youtu.be/dsRWXT2bem8?si=bA8cAxuXjfrMI-SI" rel="nofollow" target="_blank">https://youtu.be/dsRWXT2bem8?si=bA8cAxuXjfrMI-SI</a>

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-oracle-fsg-converter) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Report Name

## Oracle EBS Tables Used
[rg_report_calculations](https://www.enginatics.com/library/?pg=1&find=rg_report_calculations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-oracle-fsg-converter), [rg_reports_v](https://www.enginatics.com/library/?pg=1&find=rg_reports_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-oracle-fsg-converter), [rg_report_axes_v](https://www.enginatics.com/library/?pg=1&find=rg_report_axes_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-oracle-fsg-converter), [rg_report_axis_contents](https://www.enginatics.com/library/?pg=1&find=rg_report_axis_contents&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-oracle-fsg-converter), [rg_report_axis_sets_v](https://www.enginatics.com/library/?pg=1&find=rg_report_axis_sets_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-oracle-fsg-converter), [rg_report_content_overrides](https://www.enginatics.com/library/?pg=1&find=rg_report_content_overrides&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-oracle-fsg-converter)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-oracle-fsg-converter)

## Related Reports
[GL Oracle FSG Converter 11g](/GL%20Oracle%20FSG%20Converter%2011g/ "GL Oracle FSG Converter 11g Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Oracle%20FSG%20Converter/GL%20Oracle%20FSG%20Converter.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-oracle-fsg-converter) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL Oracle FSG Converter 04-Nov-2025 235558.xlsx](https://www.enginatics.com/example/gl-oracle-fsg-converter/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-oracle-fsg-converter) |
| Blitz Report™ XML Import | [GL_Oracle_FSG_Converter.xml](https://www.enginatics.com/xml/gl-oracle-fsg-converter/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-oracle-fsg-converter) |
| SQL Source | [GL Oracle FSG Converter.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Oracle%20FSG%20Converter/GL%20Oracle%20FSG%20Converter.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/gl-oracle-fsg-converter/](https://www.enginatics.com/reports/gl-oracle-fsg-converter/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-oracle-fsg-converter) |

## GL Oracle FSG Converter - Case Study & Technical Analysis

### Executive Summary
The **GL Oracle FSG Converter** is a specialized migration utility designed to transform legacy Oracle Financial Statement Generator (FSG) reports into the modern "GL Financial Statement and Drilldown" format. It automates the extraction of Row Sets, Column Sets, and Content Sets from the Oracle FSG definitions and converts them into the XML/Excel-based format required by the new reporting tool. This significantly reduces the manual effort required to modernize financial reporting.

### Business Use Cases
*   **Reporting Modernization**: Accelerates the move away from static, text-based FSG reports to dynamic, Excel-based financial statements.
*   **Upgrade Projects**: Essential during R12 upgrades or platform migrations where legacy reports need to be preserved and enhanced.
*   **Effort Reduction**: Eliminates the need to manually re-create complex P&L and Balance Sheet layouts in Excel, saving days or weeks of development time.
*   **Consistency**: Ensures that the logic (account ranges, calculations) in the new reports exactly matches the legacy FSG definitions, reducing the risk of reporting errors.

### Technical Analysis

#### Core Tables
*   `RG_REPORTS_V`: The FSG report header definition.
*   `RG_REPORT_AXIS_SETS_V`: Definitions of Row and Column sets.
*   `RG_REPORT_AXIS_CONTENTS`: The detailed account assignments and calculations within each row/column.
*   `RG_REPORT_CALCULATIONS`: Stores the mathematical formulas defined in the FSG.

#### Key Joins & Logic
*   **Definition Extraction**: The query extracts the complete metadata of an FSG report. It joins the Report Header -> Axis Sets -> Axis Contents.
*   **Logic Translation**: The complex part of this tool is translating FSG-specific logic (like "Row 10 + Row 20" or "Enter -2 to flip sign") into Excel formulas or the specific syntax required by the destination tool.
*   **Version Compatibility**: This specific version is optimized for Oracle Database 12c and above, likely utilizing newer SQL features for XML generation or string manipulation.

#### Key Parameters
*   **Report Name**: The specific FSG report to convert.
*   **Ledger**: The context for the conversion (though FSG definitions are often Chart of Accounts specific rather than Ledger specific).

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-oracle-fsg-converter)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-oracle-fsg-converter)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-oracle-fsg-converter)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-oracle-fsg-converter)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-oracle-fsg-converter)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-oracle-fsg-converter)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-oracle-fsg-converter)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
