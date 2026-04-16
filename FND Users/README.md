---
layout: default
title: 'FND Users | Oracle EBS SQL Report'
description: 'Listing of all EBS users, their status, responsibility count, and if they were using blitz reports'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Users, fnd_user_resp_groups, fnd_responsibility, fnd_user'
permalink: /FND%20Users/
---

# FND Users – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-users/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Listing of all EBS users, their status, responsibility count, and if they were using blitz reports

## Report Parameters
User Name, Has Access to Responsibility, Has Access to Application, Active only, Creation Date From, Creation Date To, Created within days

## Oracle EBS Tables Used
[fnd_user_resp_groups](https://www.enginatics.com/library/?pg=1&find=fnd_user_resp_groups), [fnd_responsibility](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f), [xxen_report_runs](https://www.enginatics.com/library/?pg=1&find=xxen_report_runs)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Responsibility Access 11i](/FND%20Responsibility%20Access%2011i/ "FND Responsibility Access 11i Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND User Upload](/FND%20User%20Upload/ "FND User Upload Oracle EBS SQL Report"), [Blitz Report User History](/Blitz%20Report%20User%20History/ "Blitz Report User History Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Users 02-Mar-2021 114505.xlsx](https://www.enginatics.com/example/fnd-users/) |
| Blitz Report™ XML Import | [FND_Users.xml](https://www.enginatics.com/xml/fnd-users/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-users/](https://www.enginatics.com/reports/fnd-users/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
