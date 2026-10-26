---
layout: default
last_modified_at: 2026-10-26
title: 'FND User Login Summary | Oracle EBS SQL Report'
description: 'Active application user count per month – Oracle EBS Application Object Library SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, User, Login, Summary, fnd_logins'
permalink: /FND%20User%20Login%20Summary/
report_name: 'FND User Login Summary'
report_web_name: fnd-user-login-summary
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND User Login Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-user-login-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-login-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-login-summary).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Active application user count per month

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-login-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Logged in within Days, Date From, Date To, Exclude User Name

## Oracle EBS Tables Used
[fnd_logins](https://www.enginatics.com/library/?pg=1&find=fnd_logins&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-login-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-login-summary)

## Related Reports
[FND User Login History](/FND%20User%20Login%20History/ "FND User Login History Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20User%20Login%20Summary/FND%20User%20Login%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-login-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/fnd-user-login-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-login-summary) |
| Blitz Report™ XML Import | [FND_User_Login_Summary.xml](https://www.enginatics.com/xml/fnd-user-login-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-login-summary) |
| SQL Source | [FND User Login Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20User%20Login%20Summary/FND%20User%20Login%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-user-login-summary/](https://www.enginatics.com/reports/fnd-user-login-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-login-summary) |

## Executive Summary
The **FND User Login Summary** report provides a high-level statistical view of system usage, specifically showing the count of active user logins per month. It is designed for trend analysis and license management.

## Business Challenge
Organizations need to track adoption and usage trends over time. Are more users logging in this year compared to last year? Is usage declining in certain months? Additionally, some software licensing models are based on "Active Users" per month.

## The Solution
This report aggregates login data to produce a monthly count of unique users. It helps management:
- Monitor system adoption rates.
- Validate licensing compliance (active user counts).
- Identify seasonal trends in system usage.

## Technical Architecture
The report performs a count distinct operation on the `fnd_logins` table, grouped by month.

## Parameters & Filtering
- **Date Range:** Define the period for the summary (e.g., last 12 months).
- **Exclude User Name:** Option to exclude system accounts (like GUEST or SYSADMIN) to get a more accurate count of real human users.

## Performance & Optimization
Aggregating the `fnd_logins` table can be resource-intensive if the table is very large and never purged. Using the Date parameters is recommended to limit the scan range.

## FAQ
**Q: Does this count concurrent users?**
A: No, this counts the total number of unique users who logged in at least once during the month. It does not show peak concurrent usage (users logged in at the exact same second).

**Q: If a user logs in 100 times, are they counted 100 times?**
A: No, the report counts *unique* users per month. One user logging in 100 times counts as 1 active user for that month.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-login-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-login-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-login-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-login-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-login-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-login-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-login-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
