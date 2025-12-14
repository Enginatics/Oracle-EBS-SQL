# Executive Summary
The **FND User Roles** report details the assignment of User Management (UMX) roles to users. It is a key component for managing Role-Based Access Control (RBAC) in Oracle EBS, providing visibility into who holds which roles.

# Business Challenge
As organizations move towards RBAC, access is increasingly granted via Roles rather than direct Responsibility assignments. Managing these role assignments is critical. Administrators need to ensure that users have the correct roles for their job functions and that roles are not over-provisioned.

# The Solution
This report provides a clear mapping between Users and Roles. It helps security teams:
- Review all roles assigned to a specific user.
- See all users assigned to a specific role (e.g., "Who has the Security Admin role?").
- Identify active vs. inactive role assignments.

# Technical Architecture
The report utilizes the Workflow directory service tables (`wf_local_roles`, `wf_user_role_assignments`) which underpin the UMX security model.

# Parameters & Filtering
- **User Name:** Search for a specific user's roles.
- **Role Name / Role Code:** Search for all users with a specific role.
- **Active only:** Filter to show only current assignments.

# Performance & Optimization
The report joins user and role tables. In systems with very large numbers of users and complex role hierarchies, filtering by User or Role is recommended.

# FAQ
**Q: How is this different from FND User Responsibilities?**
A: **FND User Responsibilities** shows the *result* of access (the responsibilities). **FND User Roles** shows the *mechanism* of access (the roles). A single role might grant multiple responsibilities.

**Q: Can I use this to add roles?**
A: This is a reporting tool. However, the description includes a PL/SQL snippet showing how to grant roles via the backend if needed.
