---
layout: default
last_modified_at: 2026-10-16
title: 'FND User Roles | Oracle EBS SQL Report'
description: 'Report for User Management (UMX) roles and their assigned users to manage role-based access control (RBAC). User uoles are maintained from the User…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, User, Roles, wf_local_roles, wf_local_roles_tl, fnd_responsibility_vl'
permalink: /FND%20User%20Roles/
report_name: 'FND User Roles'
report_web_name: fnd-user-roles
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND User Roles – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-user-roles/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-roles) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-roles).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Report for User Management (UMX) roles and their assigned users to manage role-based access control (RBAC).
User uoles are maintained from the User Management responsibility, but you would require the UMX|SECURITY_ADMIN role for this. If you do not have this role but apps DB access, you can add it from the backend:

begin
  wf_local_synch.propagateuserrole(
  p_user_name=>'ANDY.HAACK',
  p_role_name=>'UMX|SECURITY_ADMIN'
  );
  commit;
end;

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-roles) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
User Name, Role Name, Role Code, Active only

## Oracle EBS Tables Used
[wf_local_roles](https://www.enginatics.com/library/?pg=1&find=wf_local_roles&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-roles), [wf_local_roles_tl](https://www.enginatics.com/library/?pg=1&find=wf_local_roles_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-roles), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-roles), [wf_local_user_roles](https://www.enginatics.com/library/?pg=1&find=wf_local_user_roles&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-roles), [wf_user_role_assignments](https://www.enginatics.com/library/?pg=1&find=wf_user_role_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-roles)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-roles)

## Related Reports
[FND Roles](/FND%20Roles/ "FND Roles Oracle EBS SQL Report"), [OKL Termination Quotes](/OKL%20Termination%20Quotes/ "OKL Termination Quotes Oracle EBS SQL Report"), [FND Role Hierarchy](/FND%20Role%20Hierarchy/ "FND Role Hierarchy Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20User%20Roles/FND%20User%20Roles.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-roles) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND User Roles 10-Jan-2021 130904.xlsx](https://www.enginatics.com/example/fnd-user-roles/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-roles) |
| Blitz Report™ XML Import | [FND_User_Roles.xml](https://www.enginatics.com/xml/fnd-user-roles/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-roles) |
| SQL Source | [FND User Roles.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20User%20Roles/FND%20User%20Roles.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-user-roles/](https://www.enginatics.com/reports/fnd-user-roles/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-roles) |

## Executive Summary
The **FND User Roles** report details the assignment of User Management (UMX) roles to users. It is a key component for managing Role-Based Access Control (RBAC) in Oracle EBS, providing visibility into who holds which roles.

## Business Challenge
As organizations move towards RBAC, access is increasingly granted via Roles rather than direct Responsibility assignments. Managing these role assignments is critical. Administrators need to ensure that users have the correct roles for their job functions and that roles are not over-provisioned.

## The Solution
This report provides a clear mapping between Users and Roles. It helps security teams:
- Review all roles assigned to a specific user.
- See all users assigned to a specific role (e.g., "Who has the Security Admin role?").
- Identify active vs. inactive role assignments.

## Technical Architecture
The report utilizes the Workflow directory service tables (`wf_local_roles`, `wf_user_role_assignments`) which underpin the UMX security model.

## Parameters & Filtering
- **User Name:** Search for a specific user's roles.
- **Role Name / Role Code:** Search for all users with a specific role.
- **Active only:** Filter to show only current assignments.

## Performance & Optimization
The report joins user and role tables. In systems with very large numbers of users and complex role hierarchies, filtering by User or Role is recommended.

## FAQ
**Q: How is this different from FND User Responsibilities?**
A: **FND User Responsibilities** shows the *result* of access (the responsibilities). **FND User Roles** shows the *mechanism* of access (the roles). A single role might grant multiple responsibilities.

**Q: Can I use this to add roles?**
A: This is a reporting tool. However, the description includes a PL/SQL snippet showing how to grant roles via the backend if needed.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-roles)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-roles)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-roles)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-roles)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-roles)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-roles)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-user-roles)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
