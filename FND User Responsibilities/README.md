---
layout: default
title: 'FND User Responsibilities | Oracle EBS SQL Report'
description: 'Similar to report FND Responsibility Access, but also shows inactive / end dated user responsibilities while FND Access Control shows currently active…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, User, Responsibilities, fnd_user_resp_groups_direct, fnd_user_resp_groups_indirect, fnd_user'
permalink: /FND%20User%20Responsibilities/
---

# FND User Responsibilities – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-user-responsibilities/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Similar to report FND Responsibility Access, but also shows inactive / end dated user responsibilities while FND Access Control shows currently active assigned responsibilities only.
Same as Oracle's 'Active Users' report.

## Report Parameters
User Name, Responsibility Name, Application, Active only, End Dated from

## Oracle EBS Tables Used
[fnd_user_resp_groups_direct](https://www.enginatics.com/library/?pg=1&find=fnd_user_resp_groups_direct), [fnd_user_resp_groups_indirect](https://www.enginatics.com/library/?pg=1&find=fnd_user_resp_groups_indirect), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND User Upload](/FND%20User%20Upload/ "FND User Upload Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment](/CAC%20Inventory%20Pending%20Cost%20Adjustment/ "CAC Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [FND User Roles 11i](/FND%20User%20Roles%2011i/ "FND User Roles 11i Oracle EBS SQL Report"), [FND User Roles](/FND%20User%20Roles/ "FND User Roles Oracle EBS SQL Report"), [INV Cycle count listing](/INV%20Cycle%20count%20listing/ "INV Cycle count listing Oracle EBS SQL Report"), [INV Cycle counts pending approval](/INV%20Cycle%20counts%20pending%20approval/ "INV Cycle counts pending approval Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND User Responsibilities 30-Sep-2018 174651.xlsx](https://www.enginatics.com/example/fnd-user-responsibilities/) |
| Blitz Report™ XML Import | [FND_User_Responsibilities.xml](https://www.enginatics.com/xml/fnd-user-responsibilities/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-user-responsibilities/](https://www.enginatics.com/reports/fnd-user-responsibilities/) |

## Executive Summary
The **FND User Responsibilities** report provides a comprehensive view of responsibility assignments to users. Unlike standard active-only reports, this report can include inactive and end-dated assignments, making it a powerful tool for historical auditing and access troubleshooting.

## Business Challenge
Standard Oracle forms often hide end-dated records, making it difficult to answer questions like "Did this user have access to the General Ledger last month?" or "When was this user's access revoked?". Auditors often require proof not just of current access, but of the history of access changes.

## The Solution
This report lists user responsibility assignments with their effective start and end dates. It allows administrators to:
- Audit historical access for compliance reviews.
- Verify when a user's access was terminated.
- Compare direct responsibility assignments vs. indirect assignments (inherited via roles).

## Technical Architecture
The report queries `fnd_user_resp_groups_direct` and `fnd_user_resp_groups_indirect` to capture all assignment types. It joins with `fnd_user` and `fnd_responsibility_vl` for descriptive names.

## Parameters & Filtering
- **User Name:** Filter for a specific user.
- **Responsibility Name:** Filter for a specific responsibility.
- **Active only:** Toggle to show only currently active assignments or include historical ones.
- **End Dated from:** Filter to find assignments that expired after a certain date.

## Performance & Optimization
The report is efficient. Using the **Active only** parameter can reduce the dataset size significantly in older systems with many historical records.

## FAQ
**Q: What is the difference between direct and indirect responsibility?**
A: A direct responsibility is assigned explicitly to the user. An indirect responsibility is inherited because the user was assigned a Role (e.g., via User Management) that contains the responsibility.

**Q: Does this show which user granted the access?**
A: It shows the `CREATED_BY` and `LAST_UPDATED_BY` columns, which indicate who performed the assignment (or if it was done by a system process like `AUTOINSTALL`).


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
