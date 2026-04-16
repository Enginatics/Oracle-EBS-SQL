---
layout: default
title: 'XDO Publisher Data Definitions | Oracle EBS SQL Report'
description: 'XML Publisher data definitions or sources, associated concurrent programs, executables and templates. To include complete template information, enter a…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, XDO, Publisher, Data, Definitions, xdo_lobs, fnd_request_group_units, xdo_ds_definitions_vl'
permalink: /XDO%20Publisher%20Data%20Definitions/
---

# XDO Publisher Data Definitions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/xdo-publisher-data-definitions/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
XML Publisher data definitions or sources, associated concurrent programs, executables and templates.
To include complete template information, enter a template name or wildcard % in the template name parameter field.

This report also includes the source data SQL statement extracted from the publisher data template XML file which is quite useful to quickly access and review the SQL from Oracle standard XML reports and use them as templates for new blitz report creations.

Parameter 'Data Definition Search Text' performs a full text search through the data template file so that you could for example enter a particular table name to list all XML publisher reports and their SQLs selecting from that table.

## Report Parameters
Datasource Name, Datasource Code, Exclude Datasource Codes like, Concurrent Program Name, Creation Date From, Creation Date To, Show Templates, Template Name, Data Definition Search Text, Show enabled concurrents only, Show Active only, Show Datasource SQLs

## Oracle EBS Tables Used
[xdo_lobs](https://www.enginatics.com/library/?pg=1&find=xdo_lobs), [fnd_request_group_units](https://www.enginatics.com/library/?pg=1&find=fnd_request_group_units), [xdo_ds_definitions_vl](https://www.enginatics.com/library/?pg=1&find=xdo_ds_definitions_vl), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl), [fnd_executables_vl](https://www.enginatics.com/library/?pg=1&find=fnd_executables_vl), [xdo_templates_vl](https://www.enginatics.com/library/?pg=1&find=xdo_templates_vl), [xmltable](https://www.enginatics.com/library/?pg=1&find=xmltable)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[PO Document Types](/PO%20Document%20Types/ "PO Document Types Oracle EBS SQL Report"), [WIP Required Components](/WIP%20Required%20Components/ "WIP Required Components Oracle EBS SQL Report"), [FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/ "FND Concurrent Requests 11i Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report"), [AD Applied Patches 11i](/AD%20Applied%20Patches%2011i/ "AD Applied Patches 11i Oracle EBS SQL Report"), [ECC Admin - Concurrent Programs](/ECC%20Admin%20-%20Concurrent%20Programs/ "ECC Admin - Concurrent Programs Oracle EBS SQL Report"), [FND Concurrent Programs and Executables 11i](/FND%20Concurrent%20Programs%20and%20Executables%2011i/ "FND Concurrent Programs and Executables 11i Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [XDO Publisher Data Definitions 29-Apr-2020 114115.xlsx](https://www.enginatics.com/example/xdo-publisher-data-definitions/) |
| Blitz Report™ XML Import | [XDO_Publisher_Data_Definitions.xml](https://www.enginatics.com/xml/xdo-publisher-data-definitions/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/xdo-publisher-data-definitions/](https://www.enginatics.com/reports/xdo-publisher-data-definitions/) |

## Case Study & Technical Analysis: XDO Publisher Data Definitions Report

### Executive Summary

The XDO Publisher Data Definitions report is a crucial development and audit tool for Oracle XML Publisher (now Oracle BI Publisher). It provides a comprehensive listing of all data definitions (data sources) used by XML Publisher, detailing their associated concurrent programs, executables, and templates. Crucially, this report offers the unique ability to extract and display the underlying SQL statement embedded within the data template XML file. This report is indispensable for developers, functional analysts, and support teams to understand the data extraction logic of standard and custom XML Publisher reports, audit their configurations, troubleshoot data issues, and facilitate the creation of new reports, especially when migrating to or developing with Blitz Report.

### Business Challenge

Oracle XML Publisher is widely used for generating various business documents and reports. However, understanding and managing its data definitions can be complex and time-consuming:

-   **Opaque Data Extraction Logic:** The underlying SQL queries that extract data for XML Publisher reports are embedded within XML data template files (CLOBs), making it difficult to quickly view and understand the exact data being retrieved without specialized tools or manual extraction.
-   **Troubleshooting Data Discrepancies:** When an XML Publisher report produces incorrect data, diagnosing the issue requires examining the source SQL. Accessing this SQL in a production environment, especially for standard Oracle reports, is often challenging.
-   **Configuration Auditing:** Auditing data definitions, their associated concurrent programs, and templates to ensure they are correctly linked and active is a critical but often manual and fragmented process.
-   **Report Migration and Development:** When creating new reports or migrating from XML Publisher to other reporting tools (like Blitz Report), having direct access to the source SQL of existing reports is invaluable for understanding data models and replicating logic.
-   **Identifying Table Usage:** Determining which XML Publisher reports select data from a specific table (e.g., when planning a table change or investigating performance) is nearly impossible without full-text search capabilities across the SQL.

### The Solution

This report offers a powerful, configurable, and transparent solution for managing and analyzing Oracle XML Publisher data definitions, transforming report development and troubleshooting.

-   **Extracts Source SQL:** The most significant feature is its ability to extract and display the actual SQL statement embedded within the XML data template. This provides immediate, clear insight into how data is being fetched for any XML Publisher report.
-   **Comprehensive Data Definition Overview:** It lists all data definitions, their names, codes, associated concurrent programs, executables, and linked templates, providing a holistic view of the XML Publisher reporting landscape.
-   **Full-Text Search in SQL:** The `Data Definition Search Text` parameter enables a powerful full-text search directly within the extracted SQL, allowing users to find all XML Publisher reports that query a particular table, column, or specific condition.
-   **Streamlined Troubleshooting:** By providing direct access to the source SQL, the report dramatically accelerates the diagnosis of data issues in XML Publisher reports, eliminating the need for manual file downloads and parsing.
-   **Facilitates Report Development:** Developers can use the extracted SQL as a template or reference for building new reports (including Blitz Reports), understanding complex joins, and reusing proven data extraction logic.

### Technical Architecture (High Level)

The report queries core Oracle XML Publisher (XDO) and Concurrent Program tables, with custom logic to extract embedded SQL.

-   **Primary Tables Involved:**
    -   `xdo_ds_definitions_vl` (the central view for XML Publisher data source definitions).
    -   `fnd_concurrent_programs_vl` (for linking to concurrent programs).
    -   `fnd_executables_vl` (for linking to program executables).
    -   `xdo_templates_vl` (for associated report templates).
    -   `xdo_lobs` (stores the actual XML data template file, often as a CLOB, from which SQL is extracted).
    -   `xmltable` (a SQL function used to parse XML content within the database, critical for extracting the embedded SQL from the XML data templates).
-   **Logical Relationships:** The report selects data definition details from `xdo_ds_definitions_vl`. It then joins to `fnd_concurrent_programs_vl` and `fnd_executables_vl` to identify the associated concurrent program. When the `Show Datasource SQLs` parameter is enabled, the report accesses the CLOB data in `xdo_lobs` for the relevant data definition, and uses `xmltable` to parse the XML structure and extract the `SQL` tag's content, presenting the underlying query.

### Parameters & Filtering

The report offers an extensive set of parameters for precise filtering and detailed data inclusion:

-   **Datasource Identification:** `Datasource Name`, `Datasource Code`, `Exclude Datasource Codes like` allow for targeting specific data definitions.
-   **Concurrent Program Filters:** `Concurrent Program Name` and `Show enabled concurrents only` link data definitions to specific runnable programs.
-   **Date Range:** `Creation Date From/To` allows for analyzing data definitions created within specific periods.
-   **Template Inclusion:** `Show Templates` and `Template Name` (with wildcard support) are crucial for linking data definitions to their presentation layers.
-   **SQL Content Search:** `Data Definition Search Text` provides a powerful full-text search capability within the extracted SQL statements.
-   **Display Flags:** `Show Active only` and `Show Datasource SQLs` dynamically control the data presented.

### Performance & Optimization

As a configuration and meta-data report, it is optimized through strong filtering and specialized XML parsing capabilities.

-   **Parameter-Driven Efficiency:** The extensive filtering capabilities (by name, code, concurrent program, dates) are critical for performance, allowing the database to efficiently narrow down the set of data definitions to process.
-   **Conditional SQL Extraction:** The `Show Datasource SQLs` parameter is crucial. The potentially resource-intensive XML parsing using `xmltable` is only performed when explicitly requested, preventing unnecessary processing for simpler metadata queries.
-   **Full-Text Search:** While `Data Definition Search Text` performs a scan of XML content, it is optimized to quickly find matching SQL patterns without needing to extract and process all SQL for every data definition initially.

### FAQ

**1. What is the relationship between a 'Data Definition' and an 'XML Template' in XML Publisher?**
   A 'Data Definition' (or Data Source) defines *what data* to retrieve from Oracle EBS and *how* to structure it (typically as XML). An 'XML Template' defines *how that XML data should be formatted* for presentation (e.g., as a PDF, Excel, HTML). This report helps you see both sides of this equation, ensuring they are correctly linked.

**2. How can I use the 'Data Definition Search Text' to identify reports using a specific table?**
   You would enter the table name (e.g., `PO_HEADERS_ALL`) into the `Data Definition Search Text` parameter. The report will then search within the embedded SQL of all data definitions and return those reports whose SQL contains a reference to that specific table. This is invaluable for impact analysis during upgrades or schema changes.

**3. Why is it useful to extract the underlying SQL from standard Oracle XML Publisher reports?**
   Oracle often uses complex SQL in its standard XML Publisher reports. Extracting this SQL provides invaluable insight into Oracle's data models and business logic. Developers can use this as a learning tool, a starting point for custom reports, or a reference when troubleshooting standard report behavior, without needing to delve into Oracle's underlying source code.


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
