---
layout: default
title: 'FND User Roles 11i | Oracle EBS SQL Report'
description: 'Report for User Management (UMX) roles and their assigned users to manage role-based access control (RBAC)'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, User, Roles, 11i, wf_local_roles, wf_local_roles_tl, fnd_responsibility_vl'
permalink: /FND%20User%20Roles%2011i/
---

# FND User Roles 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-user-roles-11i/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report for User Management (UMX) roles and their assigned users to manage role-based access control (RBAC)

## Report Parameters
User Name, Role Name, Role Code, Active only

## Oracle EBS Tables Used
[wf_local_roles](https://www.enginatics.com/library/?pg=1&find=wf_local_roles), [wf_local_roles_tl](https://www.enginatics.com/library/?pg=1&find=wf_local_roles_tl), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl), [wf_local_user_roles](https://www.enginatics.com/library/?pg=1&find=wf_local_user_roles), [wf_user_role_assignments](https://www.enginatics.com/library/?pg=1&find=wf_user_role_assignments)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND User Roles](/FND%20User%20Roles/ "FND User Roles Oracle EBS SQL Report"), [FND Roles](/FND%20Roles/ "FND Roles Oracle EBS SQL Report"), [OKL Termination Quotes](/OKL%20Termination%20Quotes/ "OKL Termination Quotes Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/fnd-user-roles-11i/) |
| Blitz Report™ XML Import | [FND_User_Roles_11i.xml](https://www.enginatics.com/xml/fnd-user-roles-11i/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-user-roles-11i/](https://www.enginatics.com/reports/fnd-user-roles-11i/) |

## Executive Summary
The **FND User Roles 11i** report is the Oracle EBS 11i specific version of the User Roles report. It details the assignment of roles to users, supporting the management of Role-Based Access Control (RBAC) in older EBS environments.

## Business Challenge
Even in 11i, RBAC concepts (via Workflow roles) were used for various approvals and access controls. Administrators need visibility into these assignments to ensure security policies are being followed and to troubleshoot workflow routing issues.

## The Solution
This report lists users and their assigned roles, allowing administrators to:
- Audit role assignments in the 11i environment.
- Verify workflow role participants.
- Clean up obsolete role assignments.

## Technical Architecture
The report queries the 11i versions of the Workflow directory service tables (`wf_local_roles`, `wf_user_role_assignments`).

## Parameters & Filtering
- **User Name:** Filter by user.
- **Role Name / Role Code:** Filter by role.
- **Active only:** Show only active assignments.

## Performance & Optimization
Similar to the R12 version, this report is generally performant but benefits from filtering in large environments.

## FAQ
**Q: Is RBAC fully supported in 11i?**
A: While R12 introduced more comprehensive UMX features, 11i uses Workflow roles heavily for business process routing and some access control. This report covers those Workflow role assignments.


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
