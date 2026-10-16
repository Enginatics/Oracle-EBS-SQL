# Blitz Report Assignments and Responsibilities - Case Study & Technical Analysis

## Executive Summary

**Blitz Report Assignments and Responsibilities** is a security matrix report. Unlike the standard "Assignments" report which lists the rules defined in the system, this report explodes those rules to show the effective access for every user. It answers the question: "Which users can run which reports, and through which responsibilities?"

## Business Challenge

*   **Effective Access:** A report might be assigned to the "General Ledger Super User" responsibility. To know exactly *who* can run it, you need to know everyone who has that responsibility.
*   **SoD (Segregation of Duties):** Ensuring that no single user has access to conflicting reports (e.g., "Vendor Master Maintenance" and "Payment Run") across different responsibilities.
*   **License Compliance:** Determining the total count of unique users who have access to Blitz Report functionality.

## Solution

This report joins the Blitz Report assignment rules with the Oracle EBS User and Responsibility tables (`FND_USER`, `FND_USER_RESP_GROUPS`). It provides a flattened view of access rights.

*   **User-Centric View:** Select a user to see every report they can run across all their responsibilities.
*   **Report-Centric View:** Select a report to see every user who can run it.
*   **Responsibility Analysis:** Audit the report content of specific responsibilities.

## Technical Architecture

This report performs a complex join between the Blitz Report security model and the Oracle FND security model.

### Key Tables & Joins

*   **`XXEN_REPORT_ASSIGNMENTS`:** The rules defining which report belongs to which responsibility/user.
*   **`FND_USER` & `FND_RESPONSIBILITY`:** Standard Oracle security tables.
*   **`FND_USER_RESP_GROUPS`:** The link between users and responsibilities (including effective dates).
*   **`FND_PROFILE_OPTION_VALUES`:** Checks the `Blitz Report Access` profile option to ensure the user actually has the UI access to run reports.

### Logic

1.  **Identify Assignments:** Finds all active report assignments.
2.  **Expand Responsibilities:** For responsibility-level assignments, it finds all valid users who hold that responsibility within the active date range.
3.  **Profile Check:** It verifies that the user has the necessary profile options enabled to access the Blitz Report form.

## Parameters

*   **Responsibility Name:** Filter by a specific responsibility.
*   **Report Name:** Filter for a specific report.
*   **Category:** Filter by report category.
*   **User Name:** Filter for a specific user.
*   **Show Users:** Toggle to expand the output to list individual users (if 'No', it might just show the responsibility linkage).

## FAQ

**Q: Why does a user appear in this report but cannot see the report in Oracle?**
A: Check the "Effective Dates" on their responsibility assignment. Also, ensure the `Blitz Report Access` profile option is set correctly for that user or responsibility.

**Q: Does this include "Site" level assignments?**
A: Yes, if a report is assigned at the Site level, it is technically available to all users, and this report should reflect that breadth of access.
