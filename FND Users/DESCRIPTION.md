# Executive Summary
The **FND Users** report provides a master inventory of all users defined in the Oracle EBS system. It includes status information, creation details, and a count of assigned responsibilities, offering a high-level view of the user base.

# Business Challenge
System administrators need a quick way to answer basic questions about the user population: "How many active users do we have?", "Who are the new users created this week?", or "Which users have no responsibilities assigned?".

# The Solution
This report provides a flat listing of users with key attributes. It helps with:
- **License Auditing:** Identifying active vs. inactive users.
- **Security Hygiene:** Finding users with no responsibilities (potential cleanup targets).
- **Onboarding Verification:** Checking if new users were created correctly.

# Technical Architecture
The report queries the `fnd_user` table and aggregates data from `fnd_user_resp_groups` to provide the responsibility count. It also links to `per_all_people_f` to show the associated employee record.

# Parameters & Filtering
- **User Name:** Filter for a specific user.
- **Active only:** Hide end-dated users.
- **Creation Date From/To:** Find users created within a specific period.
- **Created within days:** Quick filter for recently created users.

# Performance & Optimization
The report is very fast as it primarily queries the user master table.

# FAQ
**Q: Does this show the last login time?**
A: This report focuses on user *definition*. For login activity, use the **FND User Login History** or **FND User Login Summary** reports.

**Q: What does "Responsibility Count" tell me?**
A: It indicates the number of responsibilities assigned to the user. A count of 0 might indicate a service account or a user that has been effectively disabled by removing all access.
