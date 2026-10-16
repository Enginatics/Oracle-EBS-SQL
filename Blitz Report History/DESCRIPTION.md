# Blitz Report History - Case Study & Technical Analysis

## Executive Summary

**Blitz Report History** is the detailed transaction log of the Blitz Report system. Unlike the "Execution Summary" which aggregates data, this report lists individual execution records. It is the primary tool for troubleshooting specific failed runs, auditing user activity, and analyzing performance at a granular level.

## Business Challenge

*   **Troubleshooting:** "My report failed yesterday at 2 PM." The admin uses this report to find that specific run, see the error message, and view the parameters used.
*   **Security Audit:** "Who ran the 'Salary Detail' report last week?"
*   **Performance Analysis:** Identifying exactly which run of a report took 2 hours instead of the usual 2 minutes (e.g., due to a specific parameter combination).

## Solution

This report provides a comprehensive view of the `XXEN_REPORT_RUNS` table, often joined with Oracle's standard concurrent request tables.

*   **Status:** Shows if a report is Running, Completed, or Errored.
*   **Parameters:** Can optionally show the specific parameters used for each run (`Show Parameters`).
*   **SQL Snapshot:** Some versions might link to the specific SQL used at runtime.

## Technical Architecture

### Key Tables

*   **`XXEN_REPORT_RUNS`:** The core execution log.
*   **`FND_CONCURRENT_REQUESTS`:** Links the Blitz Report run to the standard Oracle Concurrent Manager request ID.
*   **`XXEN_REPORT_RUN_PARAM_VALUES`:** Stores the parameter values entered by the user for that specific run.

### Logic

The query lists execution records, sorted by start date. It includes logic to decode the status and link to the user and responsibility context.

## Parameters

*   **Report Name / Category / Type:** Standard filters.
*   **Submitted by User:** Audit specific users.
*   **Started within Days / Date Range:** Time window.
*   **Show Parameters:** A toggle to include the parameter string in the output (can make the report wider/slower but essential for debugging).
*   **Running or Errored:** Filter to focus on problem areas.
*   **Request Id / Run Id:** Search for a specific transaction.
