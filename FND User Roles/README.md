---
layout: default
title: 'FND User Roles | Oracle EBS SQL Report'
description: 'Report for User Management (UMX) roles and their assigned users to manage role-based access control (RBAC). User uoles are maintained from the User…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, FND, User, Roles, wf_local_roles, wf_local_roles_tl, fnd_responsibility_vl'
permalink: /FND%20User%20Roles/
---

# FND User Roles – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-user-roles/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
User Name, Role Name, Role Code, Active only

## Oracle EBS Tables Used
[wf_local_roles](https://www.enginatics.com/library/?pg=1&find=wf_local_roles), [wf_local_roles_tl](https://www.enginatics.com/library/?pg=1&find=wf_local_roles_tl), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl), [wf_local_user_roles](https://www.enginatics.com/library/?pg=1&find=wf_local_user_roles), [wf_user_role_assignments](https://www.enginatics.com/library/?pg=1&find=wf_user_role_assignments)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[FND User Roles 11i](/FND%20User%20Roles%2011i/ "FND User Roles 11i Oracle EBS SQL Report"), [FND Roles](/FND%20Roles/ "FND Roles Oracle EBS SQL Report"), [OKL Termination Quotes](/OKL%20Termination%20Quotes/ "OKL Termination Quotes Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND User Roles 10-Jan-2021 130904.xlsx](https://www.enginatics.com/example/fnd-user-roles/) |
| Blitz Report™ XML Import | [FND_User_Roles.xml](https://www.enginatics.com/xml/fnd-user-roles/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-user-roles/](https://www.enginatics.com/reports/fnd-user-roles/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
