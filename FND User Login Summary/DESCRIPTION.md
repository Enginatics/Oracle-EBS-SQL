# Executive Summary
The **FND User Login Summary** report provides a high-level statistical view of system usage, specifically showing the count of active user logins per month. It is designed for trend analysis and license management.

# Business Challenge
Organizations need to track adoption and usage trends over time. Are more users logging in this year compared to last year? Is usage declining in certain months? Additionally, some software licensing models are based on "Active Users" per month.

# The Solution
This report aggregates login data to produce a monthly count of unique users. It helps management:
- Monitor system adoption rates.
- Validate licensing compliance (active user counts).
- Identify seasonal trends in system usage.

# Technical Architecture
The report performs a count distinct operation on the `fnd_logins` table, grouped by month.

# Parameters & Filtering
- **Date Range:** Define the period for the summary (e.g., last 12 months).
- **Exclude User Name:** Option to exclude system accounts (like GUEST or SYSADMIN) to get a more accurate count of real human users.

# Performance & Optimization
Aggregating the `fnd_logins` table can be resource-intensive if the table is very large and never purged. Using the Date parameters is recommended to limit the scan range.

# FAQ
**Q: Does this count concurrent users?**
A: No, this counts the total number of unique users who logged in at least once during the month. It does not show peak concurrent usage (users logged in at the exact same second).

**Q: If a user logs in 100 times, are they counted 100 times?**
A: No, the report counts *unique* users per month. One user logging in 100 times counts as 1 active user for that month.
