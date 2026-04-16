---
layout: default
title: 'FND Role Hierarchy | Oracle EBS SQL Report'
description: 'User Management (UMX) role hierarchy to manage role-based access control (RBAC). When run for a specified role, the report shows all hierarchies that…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Role, Hierarchy, umx_role_categories_v, wf_role_hierarchies, wf_roles'
permalink: /FND%20Role%20Hierarchy/
---

# FND Role Hierarchy – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-role-hierarchy/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
User Management (UMX) role hierarchy to manage role-based access control (RBAC).
When run for a specified role, the report shows all hierarchies that contain or lead to inheriting that role.

## Report Parameters
Role Name, Role Code

## Oracle EBS Tables Used
[umx_role_categories_v](https://www.enginatics.com/library/?pg=1&find=umx_role_categories_v), [wf_role_hierarchies](https://www.enginatics.com/library/?pg=1&find=wf_role_hierarchies), [wf_roles](https://www.enginatics.com/library/?pg=1&find=wf_roles), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND User Roles 11i](/FND%20User%20Roles%2011i/ "FND User Roles 11i Oracle EBS SQL Report"), [FND User Roles](/FND%20User%20Roles/ "FND User Roles Oracle EBS SQL Report"), [FND Roles](/FND%20Roles/ "FND Roles Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Role Hierarchy 10-Jan-2021 133945.xlsx](https://www.enginatics.com/example/fnd-role-hierarchy/) |
| Blitz Report™ XML Import | [FND_Role_Hierarchy.xml](https://www.enginatics.com/xml/fnd-role-hierarchy/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-role-hierarchy/](https://www.enginatics.com/reports/fnd-role-hierarchy/) |

## Executive Summary
The **FND Role Hierarchy** report visualizes the structure of User Management (UMX) roles, specifically focusing on role inheritance. It allows administrators to understand how roles are nested and how permissions flow from child roles to parent roles within the Role-Based Access Control (RBAC) model.

## Business Challenge
In complex RBAC implementations, roles often inherit permissions from other roles. As these hierarchies grow deep, it becomes difficult to trace exactly why a user has a certain permission or to predict the impact of changing a child role. Lack of visibility into this hierarchy can lead to unintended privilege escalation or redundant role definitions.

## The Solution
This report unravels the role hierarchy. When run for a specific role, it shows all the hierarchies that contain or lead to inheriting that role. This provides a clear lineage of access, helping administrators:
- Validate the design of their role hierarchy.
- Ensure that role inheritance is working as intended.
- Clean up unused or redundant hierarchy paths.

## Technical Architecture
The report utilizes the Workflow directory service tables, specifically `wf_role_hierarchies` and `wf_roles`, which underpin the UMX security model in Oracle EBS.

## Parameters & Filtering
- **Role Name:** The display name of the role to analyze.
- **Role Code:** The internal system name of the role.

## Performance & Optimization
The report is efficient for analyzing specific roles. Querying the entire hierarchy of a large system without filters may produce a large dataset due to the many-to-many nature of role relationships.

## FAQ
**Q: Is this related to Responsibilities?**
A: Yes, in the UMX model, responsibilities can be assigned to roles, and roles can be assigned to users. This report focuses on the relationship between the roles themselves.

**Q: Can I see which users are assigned to these roles?**
A: This report focuses on the role structure. Use the **FND Roles** or **FND User Roles** reports to see user assignments.


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
