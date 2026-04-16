---
layout: default
title: 'Blitz Report LOV Comparison between environments | Oracle EBS SQL Report'
description: 'Requires following view to be created on the remote environment to avoid ORA-64202: remote temporary or abstract LOB locator is encountered create or…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, LOV, Comparison, fnd_user, xxen_report_parameters, xxen_reports_v'
permalink: /Blitz%20Report%20LOV%20Comparison%20between%20environments/
---

# Blitz Report LOV Comparison between environments – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-lov-comparison-between-environments/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Requires following view to be created on the remote environment to avoid ORA-64202: remote temporary or abstract LOB locator is encountered

create or replace view xxen_report_parameter_lovs_v_ as
select
xrplv.*,
dbms_lob.substr(xxen_util.clob_substrb(xrplv.lov_query,4000,1)) lov_query_short
from
xxen_report_parameter_lovs_v xrplv;

## Report Parameters
Remote Database

## Oracle EBS Tables Used
[fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [xxen_report_parameters](https://www.enginatics.com/library/?pg=1&find=xxen_report_parameters), [xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v), [xxen_report_parameter_lovs_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_parameter_lovs_v), [xxen_report_parameter_lovs_v_](https://www.enginatics.com/library/?pg=1&find=xxen_report_parameter_lovs_v_)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DIS End User Layers](/DIS%20End%20User%20Layers/ "DIS End User Layers Oracle EBS SQL Report"), [Blitz Report Text Search](/Blitz%20Report%20Text%20Search/ "Blitz Report Text Search Oracle EBS SQL Report"), [Blitz Report LOVs](/Blitz%20Report%20LOVs/ "Blitz Report LOVs Oracle EBS SQL Report"), [Blitz Report LOV SQL Validation](/Blitz%20Report%20LOV%20SQL%20Validation/ "Blitz Report LOV SQL Validation Oracle EBS SQL Report"), [Blitz Report Comparison between environments](/Blitz%20Report%20Comparison%20between%20environments/ "Blitz Report Comparison between environments Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [Blitz Upload Dependencies](/Blitz%20Upload%20Dependencies/ "Blitz Upload Dependencies Oracle EBS SQL Report"), [Blitz Report Parameter Table Alias Validation](/Blitz%20Report%20Parameter%20Table%20Alias%20Validation/ "Blitz Report Parameter Table Alias Validation Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/blitz-report-lov-comparison-between-environments/) |
| Blitz Report™ XML Import | [Blitz_Report_LOV_Comparison_between_environments.xml](https://www.enginatics.com/xml/blitz-report-lov-comparison-between-environments/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-report-lov-comparison-between-environments/](https://www.enginatics.com/reports/blitz-report-lov-comparison-between-environments/) |

## Blitz Report LOV Comparison between environments - Case Study & Technical Analysis

### Executive Summary

**Blitz Report LOV Comparison between environments** is a technical validation tool for List of Values (LOV) definitions. It compares the SQL queries behind the parameter dropdowns between two environments. This ensures that the parameters available to users (e.g., the list of "Cost Centers" or "Suppliers") behave identically after a migration.

### Business Challenge

*   **Broken Parameters:** A report works in Dev, but in Prod, the "Department" dropdown is empty because the underlying LOV SQL references a table that doesn't exist or has different permissions.
*   **Inconsistent Data:** The LOV in Dev filters out inactive suppliers, but the Prod version doesn't, leading to users selecting invalid options.

### Solution

This report compares the `XXEN_REPORT_PARAMETER_LOVS_V` view across a database link.

*   **SQL Comparison:** It compares the `LOV_QUERY` text.
*   **CLOB Handling:** Like the report comparison, it requires a special view on the remote side to handle the potentially long SQL text of the LOV definition.

### Technical Architecture

#### Key Tables

*   **`XXEN_REPORT_PARAMETER_LOVS_V`:** The definition of the LOVs.
*   **Remote View (`XXEN_REPORT_PARAMETER_LOVS_V_`):** The helper view for DB Link access.

#### Logic

1.  **Match LOVs:** Matches based on LOV Name.
2.  **Compare SQL:** Checks if the query text differs.

### Parameters

*   **Remote Database:** The target environment.


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
