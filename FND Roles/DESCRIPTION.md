# Executive Summary
The **FND Roles** report provides a directory of all User Management (UMX) roles defined in the system, along with a count of active users assigned to each role. It serves as a high-level inventory for managing Role-Based Access Control (RBAC).

# Business Challenge
As organizations evolve, the number of defined roles can grow significantly. Administrators often struggle to keep track of which roles are active, which are obsolete, and how widely each role is used. "Zombie" roles (roles with no users) clutter the system and confuse security administration.

# The Solution
This report gives a clear inventory of roles. By including the active user count, it immediately highlights:
- **Widely used roles:** Critical roles that affect many users.
- **Unused roles:** Candidates for deprecation or cleanup (roles with 0 active users).
- **Role definitions:** The internal codes and display names for accurate identification.

# Technical Architecture
The report aggregates data from `wf_local_roles` to identify roles and `wf_user_role_assignments` to calculate the count of active user assignments.

# Parameters & Filtering
- **Role Name:** Search for a specific role by its display name.
- **Role Code:** Search by the internal code.
- **Active only:** Option to filter out inactive roles or roles with no active users.

# Performance & Optimization
The report performs an aggregation to count users. On systems with a very large number of users and complex role assignments, this aggregation may take a moment, but it is generally performant.

# FAQ
**Q: Does this report show the permissions inside the role?**
A: No, this is a role inventory. To see the hierarchy of the role, use **FND Role Hierarchy**. To see what responsibilities are in a role, you would need to look at the role assignment details.

**Q: What types of roles are included?**
A: It includes UMX roles and can include other Workflow roles depending on the system configuration, as they share the underlying Workflow directory service tables.
