# Blitz Report License User History - Case Study & Technical Analysis

## Executive Summary

**Blitz Report License User History** is a compliance and usage tracking report. It tracks the number of active Blitz Report users over time, typically providing a snapshot at each month-end. This is used to monitor license compliance (if the license is user-based) and to understand adoption trends.

## Business Challenge

*   **License Compliance:** Ensuring the organization is within its purchased user limit.
*   **Trend Analysis:** Is usage growing? Do we need to purchase more licenses next year?
*   **Cost Allocation:** Potentially charging back costs to departments based on their active user count.

## Solution

This report calculates the "Active Users" metric historically.

*   **Lookback:** The description mentions "looking back the past 60 days," suggesting it counts users who have run at least one report in that window as "active."
*   **Monthly Snapshots:** It provides a trend line rather than just a current snapshot.

## Technical Architecture

### Key Tables

*   **`XXEN_REPORT_RUNS`:** The source of activity data.
*   **`FND_USER`:** To identify the users.
*   **`DUAL`:** Likely used to generate the timeline (months).

### Logic

The query likely generates a series of dates (month ends) and for each date, counts the distinct users who appeared in `XXEN_REPORT_RUNS` in the preceding period (e.g., 60 days).

## Parameters

*   (None listed, likely runs automatically for the system history).
