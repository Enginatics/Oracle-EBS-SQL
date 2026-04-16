---
layout: default
title: 'Blitz Reports | Oracle EBS SQL Report'
description: 'Blitz Reports with parameters and assignments. If you are using the free version of Blitz Report, you can use the parameter ''Sort by Free 30 Reports'' to…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Reports, xxen_reports_v, table, xxen_reports_h'
permalink: /Blitz%20Reports/
---

# Blitz Reports – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-reports/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Blitz Reports with parameters and assignments.
If you are using the free version of Blitz Report, you can use the parameter 'Sort by Free 30 Reports' to show your free reports in column 'Free 30 Reports'.

## Report Parameters
Category, Not in Category, Type, Report Name, Report name <>, Report Name like, Parameter Name, Parameter Type, Show Parameters, Show Upload Parameters, Show Upload Columns, Show Assignments, Show executions within x days, Enabled, DB Package exists, Sort by Free 30 Reports, Include Anchors and Binds, Parameter SQL Text contains, Using LOV, Matching Value contains, Default Value contains, Modified Date From, Created By, Not Created By, Creation Date From, Last Update Date From, Last Updated By, Not Last Updated By, Updated By (Report or Param), Update Date From (Report or Param), SQL Last Update Date From, Non merged copied reports, Not assigned to level

## Oracle EBS Tables Used
[xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v), [table](https://www.enginatics.com/library/?pg=1&find=table), [xxen_reports_h](https://www.enginatics.com/library/?pg=1&find=xxen_reports_h), [xxen_report_assignments](https://www.enginatics.com/library/?pg=1&find=xxen_report_assignments), [xxen_report_parameters](https://www.enginatics.com/library/?pg=1&find=xxen_report_parameters), [xxen_report_templates](https://www.enginatics.com/library/?pg=1&find=xxen_report_templates), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [xxen_report_parameters_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_parameters_v), [xxen_report_assignments_v](https://www.enginatics.com/library/?pg=1&find=xxen_report_assignments_v), [xxen_report_runs](https://www.enginatics.com/library/?pg=1&find=xxen_report_runs), [xxen_upload_parameters_v](https://www.enginatics.com/library/?pg=1&find=xxen_upload_parameters_v), [xxen_upload_columns_v](https://www.enginatics.com/library/?pg=1&find=xxen_upload_columns_v), [anchors](https://www.enginatics.com/library/?pg=1&find=anchors), [lexicals](https://www.enginatics.com/library/?pg=1&find=lexicals), [binds](https://www.enginatics.com/library/?pg=1&find=binds)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [ZX US Sales Tax](/ZX%20US%20Sales%20Tax/ "ZX US Sales Tax Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [Blitz Report Assignment Upload](/Blitz%20Report%20Assignment%20Upload/ "Blitz Report Assignment Upload Oracle EBS SQL Report"), [Blitz Report Assignments](/Blitz%20Report%20Assignments/ "Blitz Report Assignments Oracle EBS SQL Report"), [DIS End User Layers](/DIS%20End%20User%20Layers/ "DIS End User Layers Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Reports 10-Aug-2020 140427.xlsx](https://www.enginatics.com/example/blitz-reports/) |
| Blitz Report™ XML Import | [Blitz_Reports.xml](https://www.enginatics.com/xml/blitz-reports/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-reports/](https://www.enginatics.com/reports/blitz-reports/) |

## Executive Summary
The Blitz Reports report is a comprehensive administrative tool that provides a detailed inventory of all Blitz Reports defined in the system. It lists reports along with their parameters, assignments, and other configuration details, serving as a master catalog for the reporting environment.

## Business Challenge
As the number of reports in an Oracle EBS environment grows, managing them becomes increasingly difficult. Administrators need a way to audit report definitions, check for consistency in parameters, and review user assignments. Without a centralized view, it is challenging to maintain standards, identify redundant reports, or ensure that reports are correctly configured and secured.

## Solution
The Blitz Reports report solves this by offering a holistic view of the reporting landscape. It allows users to query reports based on a wide range of criteria, including category, type, parameter usage, and creation/update dates. This visibility enables efficient management, easier troubleshooting, and better governance of the reporting solution.

## Key Features
*   **Comprehensive Inventory:** Lists all Blitz Reports with their key attributes.
*   **Detailed Filtering:** Supports extensive parameters for filtering by category, report name, parameter type, and more.
*   **Configuration Audit:** Shows details about parameters, upload columns, and assignments.
*   **Usage & History:** Includes options to show execution counts and filter by creation or update history.
*   **Free Report Identification:** Can sort and identify reports that count towards the free usage tier.

## Technical Details
The report queries a multitude of Blitz Report views and tables, including `xxen_reports_v`, `xxen_report_parameters_v`, `xxen_report_assignments_v`, and `xxen_report_runs`. It also joins with standard Oracle tables like `fnd_user` to provide user-related information. This complex query structure ensures that all aspects of a report's definition and usage are captured.


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
