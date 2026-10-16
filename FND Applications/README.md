---
layout: default
last_modified_at: 2026-10-16
title: 'FND Applications | Oracle EBS SQL Report'
description: 'Shows all applications, their installation status, correponding database schema, application top name and audit status'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Applications, fnd_data_group_units, fnd_oracle_userid, xxen_report_license_key'
permalink: /FND%20Applications/
report_name: 'FND Applications'
report_web_name: fnd-applications
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Applications – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-applications/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Shows all applications, their installation status, correponding database schema, application top name and audit status

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Application Short Name, Application Name

## Oracle EBS Tables Used
[fnd_data_group_units](https://www.enginatics.com/library/?pg=1&find=fnd_data_group_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications), [fnd_oracle_userid](https://www.enginatics.com/library/?pg=1&find=fnd_oracle_userid&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications), [xxen_report_license_key](https://www.enginatics.com/library/?pg=1&find=xxen_report_license_key&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications), [fnd_product_installations](https://www.enginatics.com/library/?pg=1&find=fnd_product_installations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications), [dba_users](https://www.enginatics.com/library/?pg=1&find=dba_users&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications), [fnd_audit_schemas](https://www.enginatics.com/library/?pg=1&find=fnd_audit_schemas&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications), [fnd_mo_product_init](https://www.enginatics.com/library/?pg=1&find=fnd_mo_product_init&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications)

## Related Reports
[FND Audit Setup](/FND%20Audit%20Setup/ "FND Audit Setup Oracle EBS SQL Report"), [DBA Users](/DBA%20Users/ "DBA Users Oracle EBS SQL Report"), [FND Lookup Search](/FND%20Lookup%20Search/ "FND Lookup Search Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND Responsibilities](/FND%20Responsibilities/ "FND Responsibilities Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [FND Histogram Columns](/FND%20Histogram%20Columns/ "FND Histogram Columns Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Applications/FND%20Applications.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Applications 20-Dec-2022 093439.xlsx](https://www.enginatics.com/example/fnd-applications/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications) |
| Blitz Report™ XML Import | [FND_Applications.xml](https://www.enginatics.com/xml/fnd-applications/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications) |
| SQL Source | [FND Applications.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Applications/FND%20Applications.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-applications/](https://www.enginatics.com/reports/fnd-applications/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications) |

## Executive Summary
The **FND Applications** report provides a high-level inventory of all registered applications within the Oracle E-Business Suite. It details their installation status, base paths, and audit configurations.

## Business Challenge
*   **License Management:** Identifying which modules are installed and active.
*   **System Auditing:** Verifying which applications have audit trails enabled.
*   **Environment Assessment:** Quickly understanding the footprint of the EBS implementation.

## The Solution
This Blitz Report offers a comprehensive system overview:
*   **Installation Status:** Shows if an app is 'Installed', 'Shared', or 'Inactive'.
*   **Schema Mapping:** Links the application to its Oracle ID (schema name).
*   **Audit Status:** Indicates if the "AuditTrail:Activate" profile is set and if the schema is audited.

## Technical Architecture
The report joins `FND_APPLICATION_VL` with `FND_PRODUCT_INSTALLATIONS` and `FND_ORACLE_USERID`. It also checks `FND_AUDIT_SCHEMAS` to report on audit configurations.

## Parameters & Filtering
*   **Application Name/Short Name:** Filter for specific modules (e.g., 'Payables', 'SQLGL').

## Performance & Optimization
*   **Fast Execution:** This report runs very quickly as it queries small metadata tables.
*   **No Parameters:** Running without parameters gives the full list of 200+ standard modules.

## FAQ
*   **Q: What does "Shared" status mean?**
    *   A: It means the application is available for use, but its data model might be shared with another installed application (common in older EBS versions).
*   **Q: Can I see patch levels here?**
    *   A: No, this report shows registration status. For patch levels, use "AD Applied Patches".

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-applications)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
