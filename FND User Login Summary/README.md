---
layout: default
title: 'FND User Login Summary | Oracle EBS SQL Report'
description: 'Active application user count per month – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, User, Login, Summary, fnd_logins'
permalink: /FND%20User%20Login%20Summary/
---

# FND User Login Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-user-login-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Active application user count per month

## Report Parameters
Logged in within Days, Date From, Date To, Exclude User Name

## Oracle EBS Tables Used
[fnd_logins](https://www.enginatics.com/library/?pg=1&find=fnd_logins)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND User Login History](/FND%20User%20Login%20History/ "FND User Login History Oracle EBS SQL Report"), [AR Unaccounted Transaction Sweep](/AR%20Unaccounted%20Transaction%20Sweep/ "AR Unaccounted Transaction Sweep Oracle EBS SQL Report"), [CAC Subinventory Accounts Setup](/CAC%20Subinventory%20Accounts%20Setup/ "CAC Subinventory Accounts Setup Oracle EBS SQL Report"), [FA Additions By Source](/FA%20Additions%20By%20Source/ "FA Additions By Source Oracle EBS SQL Report"), [CAC Cost Group Accounts Setup](/CAC%20Cost%20Group%20Accounts%20Setup/ "CAC Cost Group Accounts Setup Oracle EBS SQL Report"), [CAC Shipping Network (Inter-Org) Accounts Setup](/CAC%20Shipping%20Network%20%28Inter-Org%29%20Accounts%20Setup/ "CAC Shipping Network (Inter-Org) Accounts Setup Oracle EBS SQL Report"), [FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/ "FND Concurrent Requests 11i Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/fnd-user-login-summary/) |
| Blitz Report™ XML Import | [FND_User_Login_Summary.xml](https://www.enginatics.com/xml/fnd-user-login-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-user-login-summary/](https://www.enginatics.com/reports/fnd-user-login-summary/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
