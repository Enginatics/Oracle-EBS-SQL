# Case Study & Technical Analysis: DBA Object Access Privileges

## Executive Summary
DBA Object Access Privileges shows every object, system and role privilege that a database user holds, including privileges inherited through chains of granted roles, and records how each one was obtained. It supports database security audits in Oracle E-Business Suite environments, where a single account may reach table data through several layers of roles. Security administrators and DBAs use it to answer which objects a given user can access and through which grant path.

## Business Challenge
*   **Audit Scope:** Auditors need the full set of database rights of an application or support account, not only the rights granted directly to it.
*   **Role Chains:** Privileges are often granted to a role, and the role is granted to another role, so the effective access is hidden in several dictionary tables.
*   **Least Privilege Review:** Before removing a grant, the administrator must know whether the user reaches the object directly or through a particular role.
*   **Access Remediation:** Findings must name the source of each privilege so the right grant can be revoked.

## The Solution
*   **Recursive Role Resolution:** The report walks the role hierarchy from the chosen grantee downward, so every inherited role is included.
*   **Three Privilege Types:** Object privileges, system privileges and roles are each reported in their own block, so the output shows the complete picture.
*   **Source Attribution:** Each row states whether the privilege is Direct or names the role that supplies it.
*   **Grant Detail:** Object rows carry the owner, the object type, the object name, the grantor, whether the grant is grantable and the hierarchy flag.

## Technical Architecture (High Level)
### Primary Tables
*   `DBA_ROLE_PRIVS`: the role grants, used both to walk the role hierarchy and to report role privileges.
*   `DBA_TAB_PRIVS`: the object privileges granted to users and roles.
*   `DBA_SYS_PRIVS`: the system privileges granted to users and roles.
*   `DUAL`: supplies the starting grantee row for the hierarchy.

### Logical Relationships
1.  A hierarchical query on `DBA_ROLE_PRIVS` starts at the chosen grantee and connects each granted role to its parent, producing the set of roles held.
2.  The grantee itself is added to that set from `DUAL`, so direct grants are included with inherited ones.
3.  Object privileges are read from `DBA_TAB_PRIVS` for every grantee in the set.
4.  System privileges are read from `DBA_SYS_PRIVS` for the same set.
5.  Role rows are read from `DBA_ROLE_PRIVS` for the same set.
6.  The three blocks are combined with UNION ALL and ordered by privilege type, source, owner, object type, object name and privilege.

## Parameters & Filtering
*   **Grantee:** The user or role whose effective privileges are reported. It drives the hierarchy walk and is required for the report to return meaningful rows.
*   **Privilege Type:** Restricts the output to Object, System or Role rows.
*   **Object Owner:** Limits object privileges to objects owned by the named schema.
*   **Object Type:** Limits object privileges to one object type, such as table or view.
*   **Privilege:** Restricts the output to one named privilege, such as SELECT.

## Performance & Optimization
*   **Driving Hierarchy:** The walk starts from a single grantee, so only that account's role tree is expanded before the privilege views are read.
*   **Set Membership Joins:** Each privilege block joins the role set to the privilege view on grantee, so the privilege views are read by grantee rather than in full.
*   **Parameter Filters at the Outer Level:** Object Owner, Object Type and Privilege filter the combined result, which keeps the logic in a single statement.
*   **Report Scope:** The report is classified as R12 only, and it reads dictionary views rather than EBS transaction tables.

## FAQ
**Q: How do I find out which role gives a user SELECT access to a table?**
A: Run the report for the user and set the Privilege parameter to SELECT. The Privilege Source column names the role that supplies each grant, and Direct marks grants made to the user.

**Q: Does the report include privileges inherited through several roles?**
A: Yes. The role hierarchy is walked to every level, so privileges reached through a chain of granted roles are returned.

**Q: What does the Grantable column show?**
A: It shows whether the privilege or role can be passed on to other grantees, taken from the admin option or grantable flag of the grant.
