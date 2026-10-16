---
layout: default
last_modified_at: 2026-10-16
title: 'Blitz Report Custom Reports Converter | Oracle EBS SQL Report'
description: 'Lists Oracle EBS concurrent programs that are candidates for conversion to Blitz Report - RDF reports, BI Publisher reports, and other data-extract…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Blitz, Report, Custom, Reports, xdo_ds_definitions_b, fnd_application_vl, fnd_concurrent_programs_vl'
permalink: /Blitz%20Report%20Custom%20Reports%20Converter/
report_name: 'Blitz Report Custom Reports Converter'
report_web_name: blitz-report-custom-reports-converter
---

# Blitz Report Custom Reports Converter – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-custom-reports-converter/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter).

## Overview
Lists Oracle EBS concurrent programs that are candidates for conversion to Blitz Report - RDF reports, BI Publisher reports, and other data-extract concurrent programs - with usage statistics. Select the programs to convert with the Convert Program column, then upload the file. The upload submits a host concurrent program that gathers each selected program's source artifacts (.rdf, .ldt, data definition, template, related packages and custom dependencies) into a single zip file for analysis by Enginatics.

With Select All Programs set to Yes, every listed row is downloaded with Convert Program set to Yes and already flagged for upload, so after filtering the list you only need to set Convert Program to No on the programs you do not want and upload the file.

With Include Custom Views set to Yes, the list additionally shows custom database views whose name starts with the Custom Object Prefix. Selecting a view gathers its definition and its custom dependency closure into the same zip - use this to extract the views that Discoverer-migrated or other custom reports are based on.

With Include Noetix Views set to Yes on an instance running NoetixViews, the NOETIX_SYS query views are listed as program type Noetix View. Selecting one gathers the complete view definition closure - the view, its NOETIX_SYS helper views and packages, and the security wrapper views - into a noetix subfolder of the zip, as input for migrating Noetix based reporting to Blitz Report. Excel4apps Reports Wand programs show as program type Excel4apps and gather their report SQL.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Customer Abbreviation, Custom Object Prefix, Select All Programs, Application, Program Type, Execution Method, User Concurrent Program Name, User Concurrent Program Name (contains), Concurrent Program Short Name, Concurrent Program Short Name (contains), Custom Programs Only, Execution File Name (contains), Request Group, Responsibility, Minimum Run Count, Minimum Distinct Users, Last Run Date From, Last Run Date To, Include Custom Views, Custom View prefix, Include Noetix Views

## Oracle EBS Tables Used
[xdo_ds_definitions_b](https://www.enginatics.com/library/?pg=1&find=xdo_ds_definitions_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter), [fnd_executables_vl](https://www.enginatics.com/library/?pg=1&find=fnd_executables_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter), [fnd_concurrent_requests](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_requests&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter), [dba_views](https://www.enginatics.com/library/?pg=1&find=dba_views&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter), [dba_objects](https://www.enginatics.com/library/?pg=1&find=dba_objects&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter)

## Related Reports
[XDO Publisher Data Definitions](/XDO%20Publisher%20Data%20Definitions/ "XDO Publisher Data Definitions Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [Blitz Report RDF Import Validation](/Blitz%20Report%20RDF%20Import%20Validation/ "Blitz Report RDF Import Validation Oracle EBS SQL Report"), [ECC Admin - Concurrent Programs](/ECC%20Admin%20-%20Concurrent%20Programs/ "ECC Admin - Concurrent Programs Oracle EBS SQL Report"), [FND Concurrent Requests Summary](/FND%20Concurrent%20Requests%20Summary/ "FND Concurrent Requests Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Custom%20Reports%20Converter/Blitz%20Report%20Custom%20Reports%20Converter.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/blitz-report-custom-reports-converter/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter) |
| Blitz Report™ XML Import | [Blitz_Report_Custom_Reports_Converter.xml](https://www.enginatics.com/xml/blitz-report-custom-reports-converter/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter) |
| SQL Source | [Blitz Report Custom Reports Converter.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Custom%20Reports%20Converter/Blitz%20Report%20Custom%20Reports%20Converter.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/blitz-report-custom-reports-converter/](https://www.enginatics.com/reports/blitz-report-custom-reports-converter/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter) |

## Case Study & Technical Analysis: Blitz Report Custom Reports Converter

### Executive Summary
The Blitz Report Custom Reports Converter is a discovery and collection report for organizations that want to move older Oracle EBS reporting into Blitz Report™. It lists concurrent programs that are candidates for conversion, including RDF reports, BI Publisher reports and data-extract programs, together with their run statistics. The user selects the programs to convert and uploads the file, which starts a host concurrent program that gathers each program's source artifacts into one zip file for analysis by Enginatics. Migration leads and reporting teams use it to decide which custom reports are worth converting, based on how often they run and how many users run them.

### Business Challenge
*   **Unclear conversion scope:** Custom RDF, BI Publisher and extract programs accumulate over years, and nobody holds a current list of which ones still matter.
*   **Usage-based prioritisation:** Programs that run rarely or are used by one person are poor candidates, and this needs run counts, distinct users and last-run dates.
*   **Collecting source artifacts:** Converting a report needs its executable, data definition, template, related packages and custom dependencies gathered in one place.

### The Solution
*   **Program inventory with statistics:** The report lists enabled concurrent programs with their application, executable, execution method, output format and run statistics.
*   **Program type classification:** Each program is classified as Excel4apps, BI Publisher, RDF or Data Extract, based on its executable and data source, and custom views and Noetix views are listed as their own types.
*   **Select and upload:** The Convert Program column selects which rows are collected. Uploading the file submits a host concurrent program that builds the zip.
*   **Dependency collection for views:** Selecting a custom view gathers its definition and its custom dependency closure into the same zip.

### Technical Architecture (High Level)
#### Primary Tables
*   `FND_APPLICATION_VL`: the owning application of each program.
*   `FND_CONCURRENT_PROGRAMS_VL`: the concurrent program definitions, including user name, short name, output file type and enabled flag.
*   `FND_EXECUTABLES_VL`: the executable for each program, with its execution method and file name.
*   `FND_CONCURRENT_REQUESTS`: the request history, aggregated into run counts, distinct users and first and last run dates.
*   `XDO_DS_DEFINITIONS_B`: BI Publisher data source definitions, used to recognise BI Publisher programs.
*   `DBA_VIEWS` and `DBA_OBJECTS`: custom and Noetix views, and their creation dates.

#### Logical Relationships
1.  `FND_APPLICATION_VL` is joined to `FND_CONCURRENT_PROGRAMS_VL` on application ID.
2.  `FND_CONCURRENT_PROGRAMS_VL` is joined to `FND_EXECUTABLES_VL` on the executable application ID and executable ID.
3.  An inline view summarises `FND_CONCURRENT_REQUESTS` by program ID and program application ID, and is outer joined so programs that never ran still appear with zero counts.
4.  A CASE expression classifies each program as Excel4apps, BI Publisher, RDF or Data Extract.
5.  Two further branches, unioned to the program list, return custom views and Noetix views from `DBA_VIEWS` joined to `DBA_OBJECTS` on owner and name.

### Parameters & Filtering
*   **Select All Programs:** When Yes, every listed row starts with Convert Program set to Yes, so the user only clears the programs to exclude.
*   **Application, Program Type and Execution Method:** Narrow the program list by owning application, classification or execution method.
*   **User Concurrent Program Name and Concurrent Program Short Name (with the contains variants):** Find programs by display name or short name.
*   **Custom Programs Only:** Limits the list to custom programs.
*   **Minimum Run Count, Minimum Distinct Users, Last Run Date From and Last Run Date To:** Select programs by usage, which is the main prioritisation tool.
*   **Include Custom Views and Custom View prefix:** Add custom database views whose names match the custom object prefix to the list.
*   **Include Noetix Views:** Adds the NOETIX_SYS query views to the list on instances running NoetixViews.

### Performance & Optimization
*   **Usage aggregated once:** Request history is summarised in a single grouped inline view, so run statistics come from one pass over `FND_CONCURRENT_REQUESTS` rather than one query per program.
*   **Enabled programs only:** The program list keeps only programs whose enabled flag is Y or null, so retired programs are excluded early.
*   **Dictionary reads for views:** Custom and Noetix views are found through the data dictionary views, and Noetix views are filtered by naming patterns to exclude helper and base views.

### FAQ
**Q: How do I find custom RDF reports that ran at least ten times in the last year?**
A: Set Program Type to RDF, Custom Programs Only to Yes, Minimum Run Count to 10 and Last Run Date From to a date one year back.

**Q: What does the converter zip contain?**
A: For each selected program it gathers the executable, data definition, template, related packages and custom dependencies, and for a selected view it gathers the view definition and its custom dependency closure.

**Q: Which programs does Select All Programs include?**
A: Every row the filters return. Set Convert Program to No on any row you do not want collected before uploading.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-custom-reports-converter)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
