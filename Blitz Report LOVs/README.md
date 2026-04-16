---
layout: default
title: 'Blitz Report LOVs | Oracle EBS SQL Report'
description: 'Blitz Report list of values – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, LOVs, xxen_report_parameter_lovs_h, xxen_report_parameters, xxen_report_parameter_lovs_v'
permalink: /Blitz%20Report%20LOVs/
---

# Blitz Report LOVs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-lovs/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Blitz Report list of values

## Report Parameters
LOV Name starts with, SQL Text contains, Based on Table, Used by Parameter, Updated within x Days, Last Update Date From, Last Updated By, Used by a Parameter, Not Used by any Parameter

## Oracle EBS Tables Used
[xxen_report_parameter_lovs_h](https://www.enginatics.com/library/?pg=1&find=xxen_report_parameter_lovs_h), [xxen_report_parameters](https://www.enginatics.com/library/?pg=1&find=xxen_report_parameters), [xxen_report_parameter_lovs_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_parameter_lovs_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[Blitz Report LOV SQL Validation](/Blitz%20Report%20LOV%20SQL%20Validation/ "Blitz Report LOV SQL Validation Oracle EBS SQL Report"), [Blitz Report Text Search](/Blitz%20Report%20Text%20Search/ "Blitz Report Text Search Oracle EBS SQL Report"), [DIS End User Layers](/DIS%20End%20User%20Layers/ "DIS End User Layers Oracle EBS SQL Report"), [Blitz Report LOV Comparison between environments](/Blitz%20Report%20LOV%20Comparison%20between%20environments/ "Blitz Report LOV Comparison between environments Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [Blitz Upload Dependencies](/Blitz%20Upload%20Dependencies/ "Blitz Upload Dependencies Oracle EBS SQL Report"), [Blitz Report Parameter Comparison between reports](/Blitz%20Report%20Parameter%20Comparison%20between%20reports/ "Blitz Report Parameter Comparison between reports Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Report LOVs 27-Jul-2018 212033.xlsx](https://www.enginatics.com/example/blitz-report-lovs/) |
| Blitz Report™ XML Import | [Blitz_Report_LOVs.xml](https://www.enginatics.com/xml/blitz-report-lovs/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-report-lovs/](https://www.enginatics.com/reports/blitz-report-lovs/) |

## Blitz Report LOVs - Case Study & Technical Analysis

### Executive Summary

**Blitz Report LOVs** is a dictionary of all List of Values definitions in the system. It allows developers to search for existing LOVs to reuse, rather than creating duplicates. It also helps in impact analysis (e.g., "If I change this LOV, which reports will be affected?").

### Business Challenge

*   **Reusability:** A developer needs a "Supplier List" parameter. Instead of writing a new SQL query, they can search this report to find an existing, tested LOV.
*   **Impact Analysis:** The "Active Employees" view is being renamed. Which LOVs use this view, and which reports use those LOVs?
*   **Cleanup:** Identifying LOVs that are defined but not used by any parameter (`Not Used by any Parameter`).

### Solution

This report lists the LOV definitions, their SQL text, and usage statistics.

*   **Search:** Search by SQL text (`SQL Text contains`) or Table Name (`Based on Table`).
*   **Usage:** Shows which parameters use the LOV.

### Technical Architecture

#### Key Tables

*   **`XXEN_REPORT_PARAMETER_LOVS_V`:** The LOV definition.
*   **`XXEN_REPORT_PARAMETERS`:** The link to reports.

#### Logic

The query lists LOVs and joins to the parameter table to count usages or list specific reports.

### Parameters

*   **LOV Name starts with:** Search by name.
*   **SQL Text contains:** Search the code.
*   **Based on Table:** Find LOVs querying a specific table.
*   **Used by Parameter:** Find where a specific LOV is used.
*   **Updated within x Days / Last Updated By:** Audit changes.
*   **Not Used by any Parameter:** Find candidates for deletion.


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
