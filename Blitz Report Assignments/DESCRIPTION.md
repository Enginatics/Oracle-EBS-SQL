# Blitz Report Assignments - Case Study & Technical Analysis

## Executive Summary

**Blitz Report Assignments** is a system administration report that provides a comprehensive view of how Blitz Reports are distributed across the organization. It details which reports are assigned to which Users, Responsibilities, Applications, or Operating Units. This visibility is crucial for security auditing, license management, and ensuring that users have access to the necessary reporting tools.

## Business Challenge

As the number of custom reports grows, tracking who has access to what becomes complex.
*   **Security Audits:** Auditors need to verify that sensitive financial reports are only accessible to authorized personnel.
*   **Troubleshooting:** A user complains they cannot see a specific report. Is it assigned to their responsibility? Is the assignment active?
*   **Cleanup:** Identifying reports that are assigned but no longer used or assigned to obsolete responsibilities.

## Solution

The **Blitz Report Assignments** report solves these challenges by listing all active assignments. It allows administrators to:
*   **Filter by User or Responsibility:** Quickly see all reports available to a specific entity.
*   **Filter by Report:** See everyone who has access to a specific sensitive report.
*   **Verify Parameters:** Check if specific assignments have forced default parameters (e.g., restricting a report to a specific Operating Unit).

## Technical Architecture

The report queries the core Blitz Report security tables.

### Key Tables

*   **`XXEN_REPORTS_V`:** The definition of the report itself.
*   **`XXEN_REPORT_ASSIGNMENTS_V`:** The intersection table linking reports to security levels (User, Responsibility, etc.).
*   **`XXEN_REPORT_ZOOM_PARAM_VALS_V`:** Stores parameter defaults that are specific to an assignment (e.g., "When run from the 'UK General Ledger' responsibility, default the Ledger parameter to 'UK Primary Ledger'").

### Logic

The query joins the report definitions with the assignment table. It decodes the assignment level (Site, Application, Responsibility, User, Organization, etc.) to provide a human-readable context for each access rule.

## Parameters

*   **Type:** Filter by report type (e.g., SQL, PL/SQL, BI Publisher).
*   **Category:** Filter by report category (e.g., Finance, Supply Chain).
*   **Assignment Level:** Filter by the level of assignment (e.g., show only User-level assignments).
*   **Level Value:** Specific value for the level (e.g., a specific User Name or Responsibility Name).
*   **Show Form Parameter Defaults:** Toggle to display if specific parameter values are enforced for the assignment.
