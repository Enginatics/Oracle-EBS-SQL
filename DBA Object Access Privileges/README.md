---
layout: default
last_modified_at: 2026-10-19
title: 'DBA Object Access Privileges | Oracle EBS SQL Report'
description: 'Database object privileges for a specific user, including privileges inherited through role grants. Useful for DB access security audits to understand…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, R12 only, DBA, Object, Access, Privileges, dual, dba_role_privs, dba_tab_privs'
permalink: /DBA%20Object%20Access%20Privileges/
report_name: 'DBA Object Access Privileges'
report_web_name: dba-object-access-privileges
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Object Access Privileges – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-object-access-privileges/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-object-access-privileges) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-object-access-privileges).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Database object privileges for a specific user, including privileges inherited through role grants. Useful for DB access security audits to understand exactly what objects a user can access and how the access was granted (directly or through which role chain).

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-object-access-privileges) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Grantee, Privilege Type, Object Owner, Object Type, Privilege

## Oracle EBS Tables Used
[dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-object-access-privileges), [dba_role_privs](https://www.enginatics.com/library/?pg=1&find=dba_role_privs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-object-access-privileges), [dba_tab_privs](https://www.enginatics.com/library/?pg=1&find=dba_tab_privs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-object-access-privileges), [dba_sys_privs](https://www.enginatics.com/library/?pg=1&find=dba_sys_privs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-object-access-privileges)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-object-access-privileges), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-object-access-privileges)

## Related Reports
[DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA Directories](/DBA%20Directories/ "DBA Directories Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/ "DBA SGA Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA Table Modifications](/DBA%20Table%20Modifications/ "DBA Table Modifications Oracle EBS SQL Report"), [Blitz Report VPD Policy Setup](/Blitz%20Report%20VPD%20Policy%20Setup/ "Blitz Report VPD Policy Setup Oracle EBS SQL Report"), [DIS Access Privileges](/DIS%20Access%20Privileges/ "DIS Access Privileges Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Object%20Access%20Privileges/DBA%20Object%20Access%20Privileges.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-object-access-privileges) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Object Access Privileges 10-Apr-2026 092105.xlsx](https://www.enginatics.com/example/dba-object-access-privileges/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-object-access-privileges) |
| Blitz Report™ XML Import | [DBA_Object_Access_Privileges.xml](https://www.enginatics.com/xml/dba-object-access-privileges/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-object-access-privileges) |
| SQL Source | [DBA Object Access Privileges.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Object%20Access%20Privileges/DBA%20Object%20Access%20Privileges.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-object-access-privileges/](https://www.enginatics.com/reports/dba-object-access-privileges/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-object-access-privileges) |

## Case Study & Technical Analysis: DBA Object Access Privileges

### Executive Summary
DBA Object Access Privileges shows every object, system and role privilege that a database user holds, including privileges inherited through chains of granted roles, and records how each one was obtained. It supports database security audits in Oracle E-Business Suite environments, where a single account may reach table data through several layers of roles. Security administrators and DBAs use it to answer which objects a given user can access and through which grant path.

### Business Challenge
*   **Audit Scope:** Auditors need the full set of database rights of an application or support account, not only the rights granted directly to it.
*   **Role Chains:** Privileges are often granted to a role, and the role is granted to another role, so the effective access is hidden in several dictionary tables.
*   **Least Privilege Review:** Before removing a grant, the administrator must know whether the user reaches the object directly or through a particular role.
*   **Access Remediation:** Findings must name the source of each privilege so the right grant can be revoked.

### The Solution
*   **Recursive Role Resolution:** The report walks the role hierarchy from the chosen grantee downward, so every inherited role is included.
*   **Three Privilege Types:** Object privileges, system privileges and roles are each reported in their own block, so the output shows the complete picture.
*   **Source Attribution:** Each row states whether the privilege is Direct or names the role that supplies it.
*   **Grant Detail:** Object rows carry the owner, the object type, the object name, the grantor, whether the grant is grantable and the hierarchy flag.

### Technical Architecture (High Level)
#### Primary Tables
*   `DBA_ROLE_PRIVS`: the role grants, used both to walk the role hierarchy and to report role privileges.
*   `DBA_TAB_PRIVS`: the object privileges granted to users and roles.
*   `DBA_SYS_PRIVS`: the system privileges granted to users and roles.
*   `DUAL`: supplies the starting grantee row for the hierarchy.

#### Logical Relationships
1.  A hierarchical query on `DBA_ROLE_PRIVS` starts at the chosen grantee and connects each granted role to its parent, producing the set of roles held.
2.  The grantee itself is added to that set from `DUAL`, so direct grants are included with inherited ones.
3.  Object privileges are read from `DBA_TAB_PRIVS` for every grantee in the set.
4.  System privileges are read from `DBA_SYS_PRIVS` for the same set.
5.  Role rows are read from `DBA_ROLE_PRIVS` for the same set.
6.  The three blocks are combined with UNION ALL and ordered by privilege type, source, owner, object type, object name and privilege.

### Parameters & Filtering
*   **Grantee:** The user or role whose effective privileges are reported. It drives the hierarchy walk and is required for the report to return meaningful rows.
*   **Privilege Type:** Restricts the output to Object, System or Role rows.
*   **Object Owner:** Limits object privileges to objects owned by the named schema.
*   **Object Type:** Limits object privileges to one object type, such as table or view.
*   **Privilege:** Restricts the output to one named privilege, such as SELECT.

### Performance & Optimization
*   **Driving Hierarchy:** The walk starts from a single grantee, so only that account's role tree is expanded before the privilege views are read.
*   **Set Membership Joins:** Each privilege block joins the role set to the privilege view on grantee, so the privilege views are read by grantee rather than in full.
*   **Parameter Filters at the Outer Level:** Object Owner, Object Type and Privilege filter the combined result, which keeps the logic in a single statement.
*   **Report Scope:** The report is classified as R12 only, and it reads dictionary views rather than EBS transaction tables.

### FAQ
**Q: How do I find out which role gives a user SELECT access to a table?**
A: Run the report for the user and set the Privilege parameter to SELECT. The Privilege Source column names the role that supplies each grant, and Direct marks grants made to the user.

**Q: Does the report include privileges inherited through several roles?**
A: Yes. The role hierarchy is walked to every level, so privileges reached through a chain of granted roles are returned.

**Q: What does the Grantable column show?**
A: It shows whether the privilege or role can be passed on to other grantees, taken from the admin option or grantable flag of the grant.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-object-access-privileges)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-object-access-privileges)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-object-access-privileges)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-object-access-privileges)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-object-access-privileges)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-object-access-privileges)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-object-access-privileges)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
