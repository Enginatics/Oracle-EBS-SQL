---
layout: default
last_modified_at: 2026-10-26
title: 'FND User Preferences | Oracle EBS SQL Report'
description: 'User preferences from table fnduserpreferences – Oracle EBS Application Object Library SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, User, Preferences, fnd_user_preferences'
permalink: /FND%20User%20Preferences/
report_name: 'FND User Preferences'
report_web_name: fnd-user-preferences
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND User Preferences – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-user-preferences/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-preferences) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-preferences).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
User preferences from table fnd_user_preferences

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-preferences) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
User Name, Module Name, Preference Name

## Oracle EBS Tables Used
[fnd_user_preferences](https://www.enginatics.com/library/?pg=1&find=fnd_user_preferences&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-preferences)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-preferences)

## Related Reports
[GL Journals (Drilldown)](/GL%20Journals%20%28Drilldown%29/ "GL Journals (Drilldown) Oracle EBS SQL Report"), [FND User Roles](/FND%20User%20Roles/ "FND User Roles Oracle EBS SQL Report"), [AP Invoice Approval Status](/AP%20Invoice%20Approval%20Status/ "AP Invoice Approval Status Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20User%20Preferences/FND%20User%20Preferences.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-preferences) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND User Preferences 13-Apr-2026 184435.xlsx](https://www.enginatics.com/example/fnd-user-preferences/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-preferences) |
| Blitz Report™ XML Import | [FND_User_Preferences.xml](https://www.enginatics.com/xml/fnd-user-preferences/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-preferences) |
| SQL Source | [FND User Preferences.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20User%20Preferences/FND%20User%20Preferences.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-user-preferences/](https://www.enginatics.com/reports/fnd-user-preferences/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-preferences) |

## Case Study & Technical Analysis: FND User Preferences

### Executive Summary
This report lists the user preferences stored in the Application Object Library, one row per user, module and preference name, with the value each user has set. System administrators and support analysts use it to see what preference values users hold and to compare them across accounts when a user reports that a screen or default behaves differently from others. It runs in Excel through Blitz Report™ and can be limited to one user, one module or one preference name.

### Business Challenge
*   **Support investigations:** When a user reports an unexpected default or display setting, the support team needs to see the stored preference rather than rely on the user's description.
*   **Comparing accounts:** Differences between two users with the same role are easiest to explain when their preference values can be listed side by side.
*   **Module-level review:** Preferences are kept per module, so an administrator reviewing one application needs the values for that module only.
*   **Clean-up:** Obsolete preference names and values can be identified once they are listed by user and module.

### The Solution
*   Returns the user name, module name, preference name and preference value for every stored preference.
*   Sorts the output by user name, module name and preference name, so that all the preferences of one user appear together.
*   Lets the user name, module name and preference name be entered as filters, so the list can be focused on one person, one module or one setting.

### Technical Architecture (High Level)
#### Primary Tables
*   `FND_USER_PREFERENCES`: the table that stores each preference as a row with the user name, module name, preference name and preference value.

#### Logical Relationships
1.  The report reads a single table, so there are no joins and no derived columns.
2.  Each row is one preference of one user for one module, identified by the preference name.
3.  The output is ordered by user name, then module name, then preference name.

### Parameters & Filtering
*   **User Name:** lists the preferences of one user.
*   **Module Name:** lists the preferences stored for one module.
*   **Preference Name:** lists one named preference across users and modules.

### Performance & Optimization
*   With a single table and no joins, the report's cost depends only on how many preference rows match the filters.
*   Filtering on user name or module name before the sort keeps the sorted set small, which matters for systems where many users have stored preferences.
*   The report returns the stored values as they are and performs no conversion, so the results match the table exactly.

### FAQ
**Q: Which table holds the user preferences in the Application Object Library?**
A: The report reads the `FND_USER_PREFERENCES` table, which holds one row for each preference of each user in each module.

**Q: How do I see the preferences of one user for one module?**
A: Enter the user name in User Name and the module name in Module Name, and the report returns the preference names and values stored for that combination.

**Q: Are the preference values converted to readable text?**
A: No, the report shows the preference value exactly as it is stored in the table.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-preferences)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-preferences)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-preferences)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-preferences)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-preferences)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-preferences)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-preferences)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
