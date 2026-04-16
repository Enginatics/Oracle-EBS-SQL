---
layout: default
title: 'ONT System Parameters | Oracle EBS SQL Report'
description: ' – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, ONT, System, Parameters, fnd_flex_value_sets, oe_sys_parameter_def_vl, oe_sys_parameters_all'
permalink: /ONT%20System%20Parameters/
---

# ONT System Parameters – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ont-system-parameters/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
None

## Report Parameters
Operating Unit, Parameter Name, Parameter Code, Enabled Only

## Oracle EBS Tables Used
[fnd_flex_value_sets](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_sets), [oe_sys_parameter_def_vl](https://www.enginatics.com/library/?pg=1&find=oe_sys_parameter_def_vl), [oe_sys_parameters_all](https://www.enginatics.com/library/?pg=1&find=oe_sys_parameters_all), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [AR Transactions and Lines](/AR%20Transactions%20and%20Lines/ "AR Transactions and Lines Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [PPF_WP3_OM_DETAILS](/PPF_WP3_OM_DETAILS/ "PPF_WP3_OM_DETAILS Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [ONT System Parameters 08-Dec-2024 133111.xlsx](https://www.enginatics.com/example/ont-system-parameters/) |
| Blitz Report™ XML Import | [ONT_System_Parameters.xml](https://www.enginatics.com/xml/ont-system-parameters/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ont-system-parameters/](https://www.enginatics.com/reports/ont-system-parameters/) |

## Case Study & Technical Analysis: ONT System Parameters Report

### Executive Summary

The ONT System Parameters report is a vital audit and configuration tool that provides a comprehensive listing of all system-level parameters for the Oracle Order Management (ONT) module. It displays the active values for these parameters for any given operating unit. This report is indispensable for functional consultants, system administrators, and support analysts for troubleshooting, comparing environments, and maintaining configuration documentation.

### Business Challenge

The Oracle Order Management module's behavior is governed by a complex set of underlying system parameters. Managing and auditing these settings is a significant challenge for any organization.

-   **Configuration Complexity:** The sheer number of parameters makes it difficult to maintain a holistic view of the system's configuration. Settings are often distributed across multiple setup screens in the application.
-   **Environment Inconsistency:** One of the most common causes of issues after a production deployment is a missed or incorrect parameter setting that differs from the Test or UAT environment. Manually comparing these settings screen-by-screen is impractical and error-prone.
-   **Difficult Troubleshooting:** When users report unexpected behavior in order entry or processing, the root cause is often a system parameter. Identifying the relevant parameter and checking its value can be a time-consuming step in the diagnostic process.
-   **Audit and Documentation:** Creating and maintaining accurate documentation of all Order Management settings for internal audits or project blueprints is a significant manual effort.

### The Solution

The ONT System Parameters report provides a simple, direct, and powerful solution to these challenges by extracting all relevant configuration data into a single, easy-to-read report.

-   **Centralized Configuration View:** It consolidates all Order Management system parameters and their values for a selected operating unit into one place, providing a complete configuration snapshot.
-   **Effortless Environment Comparison:** By running the report in two different instances (e.g., Test and Production) and exporting to Excel, administrators can use simple comparison tools to instantly identify any discrepancies in setup, dramatically reducing the risk of deployment-related issues.
-   **Accelerated Troubleshooting:** Support analysts can use this report to quickly review all active parameter settings when troubleshooting an issue, rather than navigating through multiple application forms.
-   **Automated Documentation:** The report serves as on-demand, accurate documentation of the system setup, which can be archived for audit purposes or used as a baseline for future projects.

### Technical Architecture (High Level)

The report queries the core setup tables for Oracle Order Management to present a clear view of the module's configuration.

-   **Primary Tables Involved:**
    -   `oe_sys_parameters_all` (This table stores the specific value of each parameter for each operating unit).
    -   `oe_sys_parameter_def_vl` (This is the definition table, containing the name, description, and default value for every available parameter).
    -   `hr_all_organization_units_vl` (Used to select and display the Operating Unit name).
-   **Logical Relationships:** The report's core logic is to join the parameter value table (`oe_sys_parameters_all`) with the parameter definition table (`oe_sys_parameter_def_vl`) to present the parameter's code, its user-friendly name, its descriptive help text, and its currently set value for the specified operating unit.

### Parameters & Filtering

The report's parameters allow for both broad and specific queries:

-   **Operating Unit:** The primary filter to select the organization whose parameters you wish to view.
-   **Parameter Name / Parameter Code:** Allows users to query for a single, specific parameter to see its value across one or all operating units.
-   **Enabled Only:** Filters the list to show only parameters that are currently active or enabled.

### Performance & Optimization

This is a high-performance report that runs very quickly.

-   **Small Data Volume:** The underlying parameter tables contain a very small number of rows compared to transactional tables, so the query executes almost instantaneously.
-   **Indexed Lookups:** The query uses the primary key indexes on the setup tables (`org_id`, `parameter_code`) for efficient data retrieval.

### FAQ

**1. What is the difference between a parameter's value in this report and its default value?**
   The report shows the currently active *value* for the parameter in a specific operating unit. The underlying definition table (`oe_sys_parameter_def_vl`) holds the system's *default* value. If a value has never been explicitly set for an operating unit, the system uses the default. This report shows the outcome of that logic.

**2. Can I use this report to see who changed a parameter and when?**
   The standard `oe_sys_parameters_all` table does not store an audit trail of changes (who/when). That level of tracking would typically require enabling Oracle's audit trail functionality on the table. This report shows the *current* state of the configuration.

**3. Why do some parameters appear for every operating unit?**
   The Order Management system parameters are defined at the operating unit level. This allows a single Oracle instance to have multiple operating units that behave differently (e.g., one OU might have credit check enabled, while another does not). This report correctly shows the specific value for each parameter within each OU.


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
