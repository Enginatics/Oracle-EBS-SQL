---
layout: default
title: 'FND Roles | Oracle EBS SQL Report'
description: 'Report of all User Management (UMX) roles, including number of active users for each role to help managing role-based access control (RBAC)'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Roles, wf_user_role_assignments, wf_local_roles, wf_local_roles_tl'
permalink: /FND%20Roles/
---

# FND Roles – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-roles/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report of all User Management (UMX) roles, including number of active users for each role to help managing role-based access control (RBAC)

## Report Parameters
Role Name, Role Code, Active only

## Oracle EBS Tables Used
[wf_user_role_assignments](https://www.enginatics.com/library/?pg=1&find=wf_user_role_assignments), [wf_local_roles](https://www.enginatics.com/library/?pg=1&find=wf_local_roles), [wf_local_roles_tl](https://www.enginatics.com/library/?pg=1&find=wf_local_roles_tl), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND User Roles 11i](/FND%20User%20Roles%2011i/ "FND User Roles 11i Oracle EBS SQL Report"), [FND User Roles](/FND%20User%20Roles/ "FND User Roles Oracle EBS SQL Report"), [OKL Termination Quotes](/OKL%20Termination%20Quotes/ "OKL Termination Quotes Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Roles 10-Jan-2021 134007.xlsx](https://www.enginatics.com/example/fnd-roles/) |
| Blitz Report™ XML Import | [FND_Roles.xml](https://www.enginatics.com/xml/fnd-roles/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-roles/](https://www.enginatics.com/reports/fnd-roles/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
