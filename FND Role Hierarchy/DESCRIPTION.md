# Executive Summary
The **FND Role Hierarchy** report visualizes the structure of User Management (UMX) roles, specifically focusing on role inheritance. It allows administrators to understand how roles are nested and how permissions flow from child roles to parent roles within the Role-Based Access Control (RBAC) model.

# Business Challenge
In complex RBAC implementations, roles often inherit permissions from other roles. As these hierarchies grow deep, it becomes difficult to trace exactly why a user has a certain permission or to predict the impact of changing a child role. Lack of visibility into this hierarchy can lead to unintended privilege escalation or redundant role definitions.

# The Solution
This report unravels the role hierarchy. When run for a specific role, it shows all the hierarchies that contain or lead to inheriting that role. This provides a clear lineage of access, helping administrators:
- Validate the design of their role hierarchy.
- Ensure that role inheritance is working as intended.
- Clean up unused or redundant hierarchy paths.

# Technical Architecture
The report utilizes the Workflow directory service tables, specifically `wf_role_hierarchies` and `wf_roles`, which underpin the UMX security model in Oracle EBS.

# Parameters & Filtering
- **Role Name:** The display name of the role to analyze.
- **Role Code:** The internal system name of the role.

# Performance & Optimization
The report is efficient for analyzing specific roles. Querying the entire hierarchy of a large system without filters may produce a large dataset due to the many-to-many nature of role relationships.

# FAQ
**Q: Is this related to Responsibilities?**
A: Yes, in the UMX model, responsibilities can be assigned to roles, and roles can be assigned to users. This report focuses on the relationship between the roles themselves.

**Q: Can I see which users are assigned to these roles?**
A: This report focuses on the role structure. Use the **FND Roles** or **FND User Roles** reports to see user assignments.
