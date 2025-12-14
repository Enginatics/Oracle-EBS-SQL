# Executive Summary
The **FND User Roles 11i** report is the Oracle EBS 11i specific version of the User Roles report. It details the assignment of roles to users, supporting the management of Role-Based Access Control (RBAC) in older EBS environments.

# Business Challenge
Even in 11i, RBAC concepts (via Workflow roles) were used for various approvals and access controls. Administrators need visibility into these assignments to ensure security policies are being followed and to troubleshoot workflow routing issues.

# The Solution
This report lists users and their assigned roles, allowing administrators to:
- Audit role assignments in the 11i environment.
- Verify workflow role participants.
- Clean up obsolete role assignments.

# Technical Architecture
The report queries the 11i versions of the Workflow directory service tables (`wf_local_roles`, `wf_user_role_assignments`).

# Parameters & Filtering
- **User Name:** Filter by user.
- **Role Name / Role Code:** Filter by role.
- **Active only:** Show only active assignments.

# Performance & Optimization
Similar to the R12 version, this report is generally performant but benefits from filtering in large environments.

# FAQ
**Q: Is RBAC fully supported in 11i?**
A: While R12 introduced more comprehensive UMX features, 11i uses Workflow roles heavily for business process routing and some access control. This report covers those Workflow role assignments.
