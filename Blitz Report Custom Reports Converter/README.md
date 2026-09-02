---
layout: default
title: 'Blitz Report Custom Reports Converter | Oracle EBS SQL Report'
description: 'Lists Oracle EBS concurrent programs that are candidates for conversion to Blitz Report - RDF reports, BI Publisher reports, and other data-extract…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Blitz, Report, Custom, Reports, xdo_ds_definitions_b, fnd_application_vl, fnd_concurrent_programs_vl'
permalink: /Blitz%20Report%20Custom%20Reports%20Converter/
---

# Blitz Report Custom Reports Converter – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-custom-reports-converter/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Lists Oracle EBS concurrent programs that are candidates for conversion to Blitz Report - RDF reports, BI Publisher reports, and other data-extract concurrent programs - with usage statistics. Select the programs to convert with the Convert Program column, then upload the file. The upload submits a host concurrent program that gathers each selected program's source artifacts (.rdf, .ldt, data definition, template, related packages and custom dependencies) into a single zip file for analysis by Enginatics.

With Include Custom Views set to Yes, the list additionally shows custom database views whose name starts with the Custom Object Prefix. Selecting a view gathers its definition and its custom dependency closure into the same zip - use this to extract the views that Discoverer-migrated or other custom reports are based on.

On instances running NoetixViews, the NOETIX_SYS query views are listed as program type Noetix View. Selecting one gathers the complete view definition closure - the view, its NOETIX_SYS helper views and packages, and the security wrapper views - into a noetix subfolder of the zip, as input for migrating Noetix based reporting to Blitz Report. Excel4apps Reports Wand programs show as program type Excel4apps and gather their report SQL.

## Report Parameters
Customer Abbreviation, Custom Object Prefix, Upload Mode, Application, Program Type, Execution Method, User Concurrent Program Name, User Concurrent Program Name (contains), Concurrent Program Short Name, Concurrent Program Short Name (contains), Custom Programs Only, Execution File Name (contains), Request Group, Responsibility, Minimum Run Count, Minimum Distinct Users, Last Run Date From, Last Run Date To, Include Custom Views, Custom View prefix

## Oracle EBS Tables Used
[xdo_ds_definitions_b](https://www.enginatics.com/library/?pg=1&find=xdo_ds_definitions_b), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl), [fnd_executables_vl](https://www.enginatics.com/library/?pg=1&find=fnd_executables_vl), [fnd_concurrent_requests](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_requests), [dba_views](https://www.enginatics.com/library/?pg=1&find=dba_views), [dba_objects](https://www.enginatics.com/library/?pg=1&find=dba_objects)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[XDO Publisher Data Definitions](/XDO%20Publisher%20Data%20Definitions/ "XDO Publisher Data Definitions Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [Blitz Report RDF Import Validation](/Blitz%20Report%20RDF%20Import%20Validation/ "Blitz Report RDF Import Validation Oracle EBS SQL Report"), [ECC Admin - Concurrent Programs](/ECC%20Admin%20-%20Concurrent%20Programs/ "ECC Admin - Concurrent Programs Oracle EBS SQL Report"), [FND Concurrent Requests Summary](/FND%20Concurrent%20Requests%20Summary/ "FND Concurrent Requests Summary Oracle EBS SQL Report"), [FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND Concurrent Programs and Executables](/FND%20Concurrent%20Programs%20and%20Executables/ "FND Concurrent Programs and Executables Oracle EBS SQL Report"), [FND Concurrent Managers](/FND%20Concurrent%20Managers/ "FND Concurrent Managers Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/blitz-report-custom-reports-converter/) |
| Blitz Report™ XML Import | [Blitz_Report_Custom_Reports_Converter.xml](https://www.enginatics.com/xml/blitz-report-custom-reports-converter/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-report-custom-reports-converter/](https://www.enginatics.com/reports/blitz-report-custom-reports-converter/) |



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
