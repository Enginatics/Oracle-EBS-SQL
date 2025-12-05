# Blitz Report License Users - Case Study & Technical Analysis

## Executive Summary

**Blitz Report License Users** is a current-state compliance report. It lists the specific users who are currently considered "active" for licensing purposes (typically defined as having run a report in the last 60 days). It also provides insight into their usage patterns by showing their most frequently executed reports.

## Business Challenge

*   **License Management:** Identifying exactly *who* is consuming a license.
*   **Cost Optimization:** Finding users who have a license but barely use it (e.g., ran one report 59 days ago).
*   **User Profiling:** Understanding what the "Power Users" are actually doing.

## Solution

This report joins the user table with the execution logs and the license definition logic.

*   **Active List:** Provides the names of all active users.
*   **Top Reports:** Shows what each user is running most often.

## Technical Architecture

### Key Tables

*   **`XXEN_REPORT_LICENSE_USERS`:** A view or table that encapsulates the logic for determining who counts as a licensed user.
*   **`XXEN_REPORT_RUNS`:** Execution history.

### Logic

The query filters for users with activity in the defined window (e.g., `sysdate - 60`) and aggregates their run history to find the top reports.

## Parameters

*   (None listed, likely a system snapshot).
