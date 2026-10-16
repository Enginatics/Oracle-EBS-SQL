---
layout: default
last_modified_at: 2026-10-16
title: 'FND Users | Oracle EBS SQL Report'
description: 'Listing of all EBS users, their status, responsibility count, and if they were using blitz reports'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Users, fnd_user_resp_groups, fnd_responsibility, fnd_user'
permalink: /FND%20Users/
report_name: 'FND Users'
report_web_name: fnd-users
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Users – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-users/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-users) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-users).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Listing of all EBS users, their status, responsibility count, and if they were using blitz reports

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-users) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
User Name, Has Access to Responsibility, Has Access to Application, Active only, Creation Date From, Creation Date To, Created within days

## Oracle EBS Tables Used
[fnd_user_resp_groups](https://www.enginatics.com/library/?pg=1&find=fnd_user_resp_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-users), [fnd_responsibility](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-users), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-users), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-users), [xxen_report_runs](https://www.enginatics.com/library/?pg=1&find=xxen_report_runs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-users)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-users)

## Related Reports
[AP Suppliers](/AP%20Suppliers/ "AP Suppliers Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND User Upload](/FND%20User%20Upload/ "FND User Upload Oracle EBS SQL Report"), [Blitz Report User History](/Blitz%20Report%20User%20History/ "Blitz Report User History Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Users/FND%20Users.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-users) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Users 02-Mar-2021 114505.xlsx](https://www.enginatics.com/example/fnd-users/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-users) |
| Blitz Report™ XML Import | [FND_Users.xml](https://www.enginatics.com/xml/fnd-users/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-users) |
| SQL Source | [FND Users.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Users/FND%20Users.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-users/](https://www.enginatics.com/reports/fnd-users/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-users) |

## Executive Summary
The **FND Users** report provides a master inventory of all users defined in the Oracle EBS system. It includes status information, creation details, and a count of assigned responsibilities, offering a high-level view of the user base.

## Business Challenge
System administrators need a quick way to answer basic questions about the user population: "How many active users do we have?", "Who are the new users created this week?", or "Which users have no responsibilities assigned?".

## The Solution
This report provides a flat listing of users with key attributes. It helps with:
- **License Auditing:** Identifying active vs. inactive users.
- **Security Hygiene:** Finding users with no responsibilities (potential cleanup targets).
- **Onboarding Verification:** Checking if new users were created correctly.

## Technical Architecture
The report queries the `fnd_user` table and aggregates data from `fnd_user_resp_groups` to provide the responsibility count. It also links to `per_all_people_f` to show the associated employee record.

## Parameters & Filtering
- **User Name:** Filter for a specific user.
- **Active only:** Hide end-dated users.
- **Creation Date From/To:** Find users created within a specific period.
- **Created within days:** Quick filter for recently created users.

## Performance & Optimization
The report is very fast as it primarily queries the user master table.

## FAQ
**Q: Does this show the last login time?**
A: This report focuses on user *definition*. For login activity, use the **FND User Login History** or **FND User Login Summary** reports.

**Q: What does "Responsibility Count" tell me?**
A: It indicates the number of responsibilities assigned to the user. A count of 0 might indicate a service account or a user that has been effectively disabled by removing all access.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-users)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-users)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-users)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-users)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-users)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-users)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-users)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
