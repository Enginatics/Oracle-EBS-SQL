---
layout: default
last_modified_at: 2026-10-26
title: 'FND User Responsibilities | Oracle EBS SQL Report'
description: 'Similar to report FND Responsibility Access, but also shows inactive / end dated user responsibilities while FND Access Control shows currently active…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, User, Responsibilities, fnd_user_resp_groups_direct, fnd_user_resp_groups_indirect, fnd_user'
permalink: /FND%20User%20Responsibilities/
report_name: 'FND User Responsibilities'
report_web_name: fnd-user-responsibilities
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND User Responsibilities – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-user-responsibilities/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-responsibilities) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-responsibilities).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Similar to report FND Responsibility Access, but also shows inactive / end dated user responsibilities while FND Access Control shows currently active assigned responsibilities only.
Same as Oracle's 'Active Users' report.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-responsibilities) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
User Name, Responsibility Name, Application, Active only, End Dated from

## Oracle EBS Tables Used
[fnd_user_resp_groups_direct](https://www.enginatics.com/library/?pg=1&find=fnd_user_resp_groups_direct&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-responsibilities), [fnd_user_resp_groups_indirect](https://www.enginatics.com/library/?pg=1&find=fnd_user_resp_groups_indirect&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-responsibilities), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-responsibilities), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-responsibilities), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-responsibilities)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-responsibilities)

## Related Reports
[Blitz Report Template Sharing](/Blitz%20Report%20Template%20Sharing/ "Blitz Report Template Sharing Oracle EBS SQL Report"), [AP Suppliers](/AP%20Suppliers/ "AP Suppliers Oracle EBS SQL Report"), [FND User Upload](/FND%20User%20Upload/ "FND User Upload Oracle EBS SQL Report"), [FND User Roles](/FND%20User%20Roles/ "FND User Roles Oracle EBS SQL Report"), [INV Cycle count listing](/INV%20Cycle%20count%20listing/ "INV Cycle count listing Oracle EBS SQL Report"), [Blitz Report User History](/Blitz%20Report%20User%20History/ "Blitz Report User History Oracle EBS SQL Report"), [INV Cycle count entries and adjustments](/INV%20Cycle%20count%20entries%20and%20adjustments/ "INV Cycle count entries and adjustments Oracle EBS SQL Report"), [INV Cycle counts pending approval](/INV%20Cycle%20counts%20pending%20approval/ "INV Cycle counts pending approval Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20User%20Responsibilities/FND%20User%20Responsibilities.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-responsibilities) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND User Responsibilities 30-Sep-2018 174651.xlsx](https://www.enginatics.com/example/fnd-user-responsibilities/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-responsibilities) |
| Blitz Report™ XML Import | [FND_User_Responsibilities.xml](https://www.enginatics.com/xml/fnd-user-responsibilities/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-responsibilities) |
| SQL Source | [FND User Responsibilities.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20User%20Responsibilities/FND%20User%20Responsibilities.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-user-responsibilities/](https://www.enginatics.com/reports/fnd-user-responsibilities/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-responsibilities) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-responsibilities)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-responsibilities)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-responsibilities)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-responsibilities)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-responsibilities)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-responsibilities)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-responsibilities)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
