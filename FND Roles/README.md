---
layout: default
last_modified_at: 2026-10-19
title: 'FND Roles | Oracle EBS SQL Report'
description: 'Report of all User Management (UMX) roles, including number of active users for each role to help managing role-based access control (RBAC)'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Roles, wf_user_role_assignments, wf_local_roles, wf_local_roles_tl'
permalink: /FND%20Roles/
report_name: 'FND Roles'
report_web_name: fnd-roles
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Roles – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-roles/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-roles) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-roles).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Report of all User Management (UMX) roles, including number of active users for each role to help managing role-based access control (RBAC)

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-roles) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Role Name, Role Code, Active only

## Oracle EBS Tables Used
[wf_user_role_assignments](https://www.enginatics.com/library/?pg=1&find=wf_user_role_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-roles), [wf_local_roles](https://www.enginatics.com/library/?pg=1&find=wf_local_roles&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-roles), [wf_local_roles_tl](https://www.enginatics.com/library/?pg=1&find=wf_local_roles_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-roles), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-roles)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-roles)

## Related Reports
[FND User Roles](/FND%20User%20Roles/ "FND User Roles Oracle EBS SQL Report"), [OKL Termination Quotes](/OKL%20Termination%20Quotes/ "OKL Termination Quotes Oracle EBS SQL Report"), [FND Role Hierarchy](/FND%20Role%20Hierarchy/ "FND Role Hierarchy Oracle EBS SQL Report"), [Blitz Report Template Sharing](/Blitz%20Report%20Template%20Sharing/ "Blitz Report Template Sharing Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Roles/FND%20Roles.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-roles) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Roles 10-Jan-2021 134007.xlsx](https://www.enginatics.com/example/fnd-roles/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-roles) |
| Blitz Report™ XML Import | [FND_Roles.xml](https://www.enginatics.com/xml/fnd-roles/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-roles) |
| SQL Source | [FND Roles.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Roles/FND%20Roles.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-roles/](https://www.enginatics.com/reports/fnd-roles/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-roles) |

## Executive Summary
The **FND Roles** report provides a directory of all User Management (UMX) roles defined in the system, along with a count of active users assigned to each role. It serves as a high-level inventory for managing Role-Based Access Control (RBAC).

## Business Challenge
As organizations evolve, the number of defined roles can grow significantly. Administrators often struggle to keep track of which roles are active, which are obsolete, and how widely each role is used. "Zombie" roles (roles with no users) clutter the system and confuse security administration.

## The Solution
This report gives a clear inventory of roles. By including the active user count, it immediately highlights:
- **Widely used roles:** Critical roles that affect many users.
- **Unused roles:** Candidates for deprecation or cleanup (roles with 0 active users).
- **Role definitions:** The internal codes and display names for accurate identification.

## Technical Architecture
The report aggregates data from `wf_local_roles` to identify roles and `wf_user_role_assignments` to calculate the count of active user assignments.

## Parameters & Filtering
- **Role Name:** Search for a specific role by its display name.
- **Role Code:** Search by the internal code.
- **Active only:** Option to filter out inactive roles or roles with no active users.

## Performance & Optimization
The report performs an aggregation to count users. On systems with a very large number of users and complex role assignments, this aggregation may take a moment, but it is generally performant.

## FAQ
**Q: Does this report show the permissions inside the role?**
A: No, this is a role inventory. To see the hierarchy of the role, use **FND Role Hierarchy**. To see what responsibilities are in a role, you would need to look at the role assignment details.

**Q: What types of roles are included?**
A: It includes UMX roles and can include other Workflow roles depending on the system configuration, as they share the underlying Workflow directory service tables.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-roles)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-roles)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-roles)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-roles)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-roles)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-roles)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-roles)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
