# Executive Summary
The **FND User Responsibilities** report provides a comprehensive view of responsibility assignments to users. Unlike standard active-only reports, this report can include inactive and end-dated assignments, making it a powerful tool for historical auditing and access troubleshooting.

# Business Challenge
Standard Oracle forms often hide end-dated records, making it difficult to answer questions like "Did this user have access to the General Ledger last month?" or "When was this user's access revoked?". Auditors often require proof not just of current access, but of the history of access changes.

# The Solution
This report lists user responsibility assignments with their effective start and end dates. It allows administrators to:
- Audit historical access for compliance reviews.
- Verify when a user's access was terminated.
- Compare direct responsibility assignments vs. indirect assignments (inherited via roles).

# Technical Architecture
The report queries `fnd_user_resp_groups_direct` and `fnd_user_resp_groups_indirect` to capture all assignment types. It joins with `fnd_user` and `fnd_responsibility_vl` for descriptive names.

# Parameters & Filtering
- **User Name:** Filter for a specific user.
- **Responsibility Name:** Filter for a specific responsibility.
- **Active only:** Toggle to show only currently active assignments or include historical ones.
- **End Dated from:** Filter to find assignments that expired after a certain date.

# Performance & Optimization
The report is efficient. Using the **Active only** parameter can reduce the dataset size significantly in older systems with many historical records.

# FAQ
**Q: What is the difference between direct and indirect responsibility?**
A: A direct responsibility is assigned explicitly to the user. An indirect responsibility is inherited because the user was assigned a Role (e.g., via User Management) that contains the responsibility.

**Q: Does this show which user granted the access?**
A: It shows the `CREATED_BY` and `LAST_UPDATED_BY` columns, which indicate who performed the assignment (or if it was done by a system process like `AUTOINSTALL`).
