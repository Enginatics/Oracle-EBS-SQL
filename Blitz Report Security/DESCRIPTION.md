# Executive Summary
This report provides a comprehensive overview of the security configurations for Blitz Reports, detailing parameter and SQL restrictions applied to each report.

# Business Challenge
Managing security in a reporting environment is critical to ensure that sensitive data is only accessible to authorized users. Administrators need a way to audit and verify that reports have the correct security restrictions in place, such as limiting data by operating unit or ledger, without having to check each report definition individually.

# Solution
The Blitz Report Security report aggregates security settings for all reports into a single view. It allows administrators to filter by category or report name and specifically identify reports that might be missing expected security constraints.

# Key Features
- Lists all Blitz Reports along with their security settings.
- Highlights parameter-level restrictions and SQL-based security clauses.
- Includes a "Missing security" parameter to quickly identify potential vulnerabilities.
- Filters by report category and name for targeted auditing.

# Technical Details
The report queries the `xxen_reports_v` and `xxen_report_parameters_v` views to extract report definitions and their associated parameters. It analyzes these definitions to present a clear picture of the security logic embedded within each report.
