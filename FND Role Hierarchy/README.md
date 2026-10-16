---
layout: default
last_modified_at: 2026-10-16
title: 'FND Role Hierarchy | Oracle EBS SQL Report'
description: 'User Management (UMX) role hierarchy to manage role-based access control (RBAC). When run for a specified role, the report shows all hierarchies that…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Role, Hierarchy, umx_role_categories_v, wf_role_hierarchies, wf_roles'
permalink: /FND%20Role%20Hierarchy/
report_name: 'FND Role Hierarchy'
report_web_name: fnd-role-hierarchy
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Role Hierarchy – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-role-hierarchy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-role-hierarchy) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-role-hierarchy).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
User Management (UMX) role hierarchy to manage role-based access control (RBAC).
When run for a specified role, the report shows all hierarchies that contain or lead to inheriting that role.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-role-hierarchy) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Role Name, Role Code

## Oracle EBS Tables Used
[umx_role_categories_v](https://www.enginatics.com/library/?pg=1&find=umx_role_categories_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-role-hierarchy), [wf_role_hierarchies](https://www.enginatics.com/library/?pg=1&find=wf_role_hierarchies&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-role-hierarchy), [wf_roles](https://www.enginatics.com/library/?pg=1&find=wf_roles&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-role-hierarchy), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-role-hierarchy)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-role-hierarchy)

## Related Reports
[FND Roles](/FND%20Roles/ "FND Roles Oracle EBS SQL Report"), [FND User Roles](/FND%20User%20Roles/ "FND User Roles Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [Blitz Report Template Sharing](/Blitz%20Report%20Template%20Sharing/ "Blitz Report Template Sharing Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Role%20Hierarchy/FND%20Role%20Hierarchy.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-role-hierarchy) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Role Hierarchy 10-Jan-2021 133945.xlsx](https://www.enginatics.com/example/fnd-role-hierarchy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-role-hierarchy) |
| Blitz Report™ XML Import | [FND_Role_Hierarchy.xml](https://www.enginatics.com/xml/fnd-role-hierarchy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-role-hierarchy) |
| SQL Source | [FND Role Hierarchy.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Role%20Hierarchy/FND%20Role%20Hierarchy.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-role-hierarchy/](https://www.enginatics.com/reports/fnd-role-hierarchy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-role-hierarchy) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-role-hierarchy)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-role-hierarchy)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-role-hierarchy)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-role-hierarchy)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-role-hierarchy)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-role-hierarchy)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-role-hierarchy)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
