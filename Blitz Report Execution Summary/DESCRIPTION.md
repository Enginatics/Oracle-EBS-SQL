# Blitz Report Execution Summary - Case Study & Technical Analysis

## Executive Summary

**Blitz Report Execution Summary** is a performance and usage analytics report. It provides high-level statistics on how often reports are run and how they perform. This is essential for identifying the most popular reports (candidates for optimization) and the most resource-intensive reports (candidates for tuning).

## Business Challenge

*   **Performance Tuning:** Which reports are consuming the most database resources?
*   **Adoption Tracking:** Are users actually using the new "Inventory Aging" report we built?
*   **Cleanup:** Which reports have not been run in the last year and can be retired?

## Solution

This report aggregates execution data from the `XXEN_REPORT_RUNS` table.

*   **Counts:** Shows the total number of executions per report.
*   **Performance:** Likely shows average run times or total duration.
*   **User Activity:** Can be filtered to see who is submitting the most reports.

## Technical Architecture

### Key Tables

*   **`XXEN_REPORTS_V`:** Report definitions.
*   **`XXEN_REPORT_RUNS`:** The log table recording every execution of a Blitz Report.

### Logic

The query groups by Report Name (and potentially User) and calculates counts and averages.

## Parameters

*   **Report Name:** Filter for a specific report.
*   **Submitted By:** Filter by user.
*   **Submitted within Days:** Time window for the analysis (e.g., last 30 days).
*   **Exclude System Reports:** Hide internal Blitz Report maintenance jobs.
*   **Exclude own Submissions:** Filter out the administrator's own tests.
