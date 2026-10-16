---
layout: default
last_modified_at: 2026-10-16
title: 'FND Profile Options | Oracle EBS SQL Report'
description: 'FND profile option definition – Oracle EBS Application Object Library SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Profile, Options, fnd_profile_options_vl, fnd_application_vl'
permalink: /FND%20Profile%20Options/
report_name: 'FND Profile Options'
report_web_name: fnd-profile-options
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Profile Options – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-profile-options/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-options) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-options).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
FND profile option definition

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-options) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
User Profile Name starts with, System Profile Name starts with, Application, Creation Date From, Show active only, Show Display Value

## Oracle EBS Tables Used
[fnd_profile_options_vl](https://www.enginatics.com/library/?pg=1&find=fnd_profile_options_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-options), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-options)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-options)

## Related Reports
[CAC Inventory Accounts Setup](/CAC%20Inventory%20Accounts%20Setup/ "CAC Inventory Accounts Setup Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND Debug and Trace Settings](/FND%20Debug%20and%20Trace%20Settings/ "FND Debug and Trace Settings Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [FND Responsibilities](/FND%20Responsibilities/ "FND Responsibilities Oracle EBS SQL Report"), [FND Profile Option Value Upload](/FND%20Profile%20Option%20Value%20Upload/ "FND Profile Option Value Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Profile%20Options/FND%20Profile%20Options.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-options) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Profile Options 03-Apr-2018 105618.xlsx](https://www.enginatics.com/example/fnd-profile-options/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-options) |
| Blitz Report™ XML Import | [FND_Profile_Options.xml](https://www.enginatics.com/xml/fnd-profile-options/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-options) |
| SQL Source | [FND Profile Options.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Profile%20Options/FND%20Profile%20Options.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-profile-options/](https://www.enginatics.com/reports/fnd-profile-options/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-options) |

## Executive Summary
The **FND Profile Options** report documents the *definition* of profile options, not their values. It shows the metadata about the profile itself.

## Business Challenge
*   **Custom Development:** Checking if a custom profile option is defined correctly (e.g., valid at User level).
*   **System Discovery:** Finding all profile options related to a specific module (e.g., all "INV%" profiles).

## The Solution
This Blitz Report lists the profile definition:
*   **Profile Name:** The internal code and user name.
*   **Hierarchy:** Which levels (Site, App, Resp, User) are enabled and updateable.
*   **SQL Validation:** The SQL statement used to validate the values entered by the admin.

## Technical Architecture
The report queries `FND_PROFILE_OPTIONS_VL`.

## Parameters & Filtering
*   **User Profile Name:** Search by name.
*   **Application:** Filter by owning module.

## Performance & Optimization
*   **Fast Execution:** Runs quickly against the metadata tables.

## FAQ
*   **Q: Can I see the values here?**
    *   A: No, use "FND Profile Option Values" to see the actual settings. This report just shows the rules for the profile.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-options)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-options)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-options)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-options)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-options)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-options)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-profile-options)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
