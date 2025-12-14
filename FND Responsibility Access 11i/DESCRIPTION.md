# Executive Summary
This report provides a comprehensive view of system access for Oracle EBS 11i environments. It details the relationships between users, responsibilities, menus, functions, forms, and data access sets (including ledgers and operating units). It is designed to answer critical security questions regarding "who has access to what" at a granular level.

# Business Challenge
In Oracle EBS 11i, security is defined across multiple layers: users are assigned responsibilities, responsibilities are assigned menus, and menus contain functions and forms. Additionally, data access is controlled via security profiles and operating unit assignments. Auditing this complex web of permissions to ensure compliance (e.g., SOX) or to troubleshoot access issues is difficult and time-consuming when relying on standard screens or disparate reports.

# The Solution
The **FND Responsibility Access 11i** report consolidates all access information into a single view. It allows security administrators and auditors to:
- Identify which users have access to specific critical functions or forms.
- Review the full menu navigation path for responsibilities.
- Verify operating unit access for users and responsibilities.
- Audit concurrent program access.

# Technical Architecture
The report joins core FND security tables including `fnd_user`, `fnd_responsibility`, `fnd_menus`, `fnd_form_functions`, and `fnd_request_groups`. It also incorporates HR security tables like `per_security_profiles` and `hr_operating_units` to determine data access.
*Note: The current SQL does not fully account for menu exclusions, so excluded functions may still appear in the output.*

# Parameters & Filtering
The report supports flexible filtering to target specific access queries:
- **User Name:** Filter by specific users or use `%` for all.
- **Responsibility Name:** Focus on specific responsibilities.
- **Form/Function Name:** Find who can access specific system capabilities.
- **Concurrent Program:** Audit access to specific reports or processes.
- **Operating Unit:** Check access to specific business entities.

# Performance & Optimization
The report is optimized for reporting but involves complex joins across the security model. For best performance, it is recommended to provide at least one high-level filter (e.g., User Name or Responsibility Name) rather than running it wide open for the entire system.

# FAQ
**Q: Does this report show 11i specific data?**
A: Yes, this version is specifically tailored for the 11i data model.

**Q: Does it show if a user is end-dated?**
A: Yes, user and responsibility effective dates are considered.

**Q: Why might a function show up even if I excluded it?**
A: As noted in the description, the current SQL logic does not filter out menu exclusions.
