---
layout: default
last_modified_at: 2026-10-16
title: 'FND Debug and Trace Settings | Oracle EBS SQL Report'
description: 'Profile option values that switch on debug logging, SQL trace or a custom initialization SQL statement, at any level, and concurrent programs with SQL…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Debug, Trace, Settings, fnd_profile_options_vl, fnd_profile_option_values, fnd_application_vl'
permalink: /FND%20Debug%20and%20Trace%20Settings/
report_name: 'FND Debug and Trace Settings'
report_web_name: fnd-debug-and-trace-settings
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Debug and Trace Settings – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-debug-and-trace-settings/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-debug-and-trace-settings) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-debug-and-trace-settings).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Profile option values that switch on debug logging, SQL trace or a custom initialization SQL statement, at any level, and concurrent programs with SQL trace enabled.

Debug and trace settings left on in production slow down processing and fill the FND_LOG_MESSAGES table and the database trace directory.

Profile options are selected by internal names containing DEBUG or TRACE, excluding file, directory and module settings, plus FND: Debug Log Enabled and Initialization SQL Statement - Custom. Values N, No, F, 0, Off and None are not shown.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-debug-and-trace-settings) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Setting Type, Level

## Oracle EBS Tables Used
[fnd_profile_options_vl](https://www.enginatics.com/library/?pg=1&find=fnd_profile_options_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-debug-and-trace-settings), [fnd_profile_option_values](https://www.enginatics.com/library/?pg=1&find=fnd_profile_option_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-debug-and-trace-settings), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-debug-and-trace-settings), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-debug-and-trace-settings), [fnd_nodes](https://www.enginatics.com/library/?pg=1&find=fnd_nodes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-debug-and-trace-settings), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-debug-and-trace-settings), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-debug-and-trace-settings)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-debug-and-trace-settings)

## Related Reports
[FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [FND Profile Option Value Upload](/FND%20Profile%20Option%20Value%20Upload/ "FND Profile Option Value Upload Oracle EBS SQL Report"), [FND Profile Option Values](/FND%20Profile%20Option%20Values/ "FND Profile Option Values Oracle EBS SQL Report"), [FND User Login History](/FND%20User%20Login%20History/ "FND User Login History Oracle EBS SQL Report"), [FND Responsibilities](/FND%20Responsibilities/ "FND Responsibilities Oracle EBS SQL Report"), [FND FNDLOAD Object Transfer](/FND%20FNDLOAD%20Object%20Transfer/ "FND FNDLOAD Object Transfer Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Debug%20and%20Trace%20Settings/FND%20Debug%20and%20Trace%20Settings.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-debug-and-trace-settings) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Debug and Trace Settings 12-Oct-2026 061640.xlsx](https://www.enginatics.com/example/fnd-debug-and-trace-settings/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-debug-and-trace-settings) |
| Blitz Report™ XML Import | [FND_Debug_and_Trace_Settings.xml](https://www.enginatics.com/xml/fnd-debug-and-trace-settings/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-debug-and-trace-settings) |
| SQL Source | [FND Debug and Trace Settings.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Debug%20and%20Trace%20Settings/FND%20Debug%20and%20Trace%20Settings.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-debug-and-trace-settings/](https://www.enginatics.com/reports/fnd-debug-and-trace-settings/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-debug-and-trace-settings) |

## Case Study & Technical Analysis: FND Debug and Trace Settings

### Executive Summary
The FND Debug and Trace Settings report lists the Oracle E-Business Suite profile option values that switch on debug logging, SQL trace or a custom initialization SQL statement, at every level where they can be set. It also lists concurrent programs that have SQL trace enabled. System administrators and DBAs use it to find debug and trace settings that were left on after an investigation, because these settings slow down processing and fill the FNDLOGMESSAGES table and the database trace directory. The report runs in Excel via Blitz Report, and each row shows who last changed the setting and when.

### Business Challenge
*   **Forgotten diagnostic settings:** Debug and trace profile options are often switched on during a support case and never reset, which degrades performance for all users.
*   **Log table growth:** Debug logging writes to FNDLOGMESSAGES, which can grow quickly and affect maintenance and backup windows.
*   **Multi-level configuration:** A profile option can be set at site, application, responsibility, user, server, operating unit or combined server and responsibility levels, so the active value is not always visible at the site level.
*   **Traceable changes:** An administrator needs to know who changed a setting and when before reverting it.

### The Solution
*   **Broad name detection:** Profile options whose internal names contain DEBUG or TRACE are selected, excluding file, directory, path, URL, location and module settings that do not switch logging on.
*   **Named exceptions:** The debug log enabled option and the custom initialization SQL statement are included by their internal names.
*   **Noise suppression:** Values of N, No, F, 0, Off and None are excluded, so only active settings appear.
*   **Level resolution:** Each setting is shown with its level name, such as the application, responsibility, user, node, or operating unit, and with the last update details.
*   **Trace-enabled programs:** Concurrent programs with SQL trace enabled are listed as a separate setting type.

### Technical Architecture (High Level)
#### Primary Tables
*   `FND_PROFILE_OPTIONS_VL`: the profile option definitions, with internal and user names.
*   `FND_PROFILE_OPTION_VALUES`: the values set at each level, with level identifiers and last update details.
*   `FND_APPLICATION_VL`: application names for application-level and concurrent program settings.
*   `FND_RESPONSIBILITY_VL`: responsibility names for responsibility-level and operating unit settings.
*   `FND_NODES`: server node names for server-level settings.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: operating unit names for operating unit-level settings.
*   `FND_CONCURRENT_PROGRAMS_VL`: concurrent programs with SQL trace enabled.

#### Logical Relationships
1. `FND_PROFILE_OPTIONS_VL` is joined to `FND_PROFILE_OPTION_VALUES` on application and profile option identifiers.
2. The level identifier decides which lookup supplies the level name: `FND_APPLICATION_VL` for application level, `FND_RESPONSIBILITY_VL` for responsibility and operating unit responsibility levels, `FND_NODES` for server level and `HR_ALL_ORGANIZATION_UNITS_VL` for operating unit level. User level uses the user name function.
3. The result is unioned with concurrent programs that have trace enabled, joined to `FND_APPLICATION_VL`.
4. The final output is ordered by setting type, name, level and level name.

### Parameters & Filtering
*   **Setting Type:** Limits the output to profile option settings or to concurrent programs with SQL trace enabled.
*   **Level:** Limits the output to one profile option level, such as Site, Application, Responsibility, User, Server, Operating Unit or Server+Responsibility.

The SQL text does not reference these two parameters through bind variables, so the rows listed are the full set of matching settings described above.

### Performance & Optimization
*   The profile option name filter uses regular expressions on `FND_PROFILE_OPTIONS_VL`, which is a small definition table, so the main cost is in the value join.
*   Values of N, No, F, 0, Off and None are removed in the value filter before the level lookups, so only active settings reach the outer joins.
*   Level lookups are outer joins with decode or case expressions, so each setting resolves to at most one row in each lookup table.
*   The query does not use aggregation or analytic functions.

### FAQ
**Q: How do I find debug or SQL trace settings that are still switched on?**
A: Run the report; every row is an active debug or trace setting, with its level, level name and last updated by and date.

**Q: Why does a setting appear for a responsibility rather than the site?**
A: Profile option values are stored per level, so a value set for one responsibility appears on its own row with the responsibility name as the level name.

**Q: Which concurrent programs are running with SQL trace enabled?**
A: Rows with the setting type Concurrent Program show the programs whose SQL trace flag is set, with the application name as the level name.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-debug-and-trace-settings)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-debug-and-trace-settings)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-debug-and-trace-settings)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-debug-and-trace-settings)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-debug-and-trace-settings)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-debug-and-trace-settings)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-debug-and-trace-settings)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
