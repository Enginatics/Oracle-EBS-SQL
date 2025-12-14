# Executive Summary
The **FND Concurrent Requests Summary** report provides a performance profile of your concurrent processing system. It aggregates historical execution data to highlight the most resource-intensive programs.

# Business Challenge
*   **Performance Tuning:** Identifying the "Top 10" programs that consume the most system time.
*   **Trend Analysis:** Seeing if specific jobs are taking longer to run over time.
*   **Housekeeping:** Finding programs that run frequently but generate no output or are cancelled often.

# The Solution
This Blitz Report aggregates data from `FND_CONCURRENT_REQUESTS`:
*   **Total Runtime:** Sums up the execution time for each program.
*   **Average Runtime:** Calculates the mean duration to establish a baseline.
*   **Execution Count:** Shows how often the program is run.

# Technical Architecture
The report groups data by `PROGRAM_APPLICATION_ID` and `CONCURRENT_PROGRAM_ID`. It calculates metrics like `SUM(ACTUAL_COMPLETION_DATE - ACTUAL_START_DATE)`.

# Parameters & Filtering
*   **Date Range:** "Started within Days" or specific dates to define the analysis period.
*   **Program Name:** Filter for specific jobs.

# Performance & Optimization
*   **Purge Impact:** The report can only analyze data currently in the request history table. If you purge requests weekly, you can only analyze the last week.
*   **Summary Level:** This is an aggregate report, so it runs fast even with large history tables.

# FAQ
*   **Q: Can I drill down to specific requests?**
    *   A: This report gives the summary. Use "FND Concurrent Requests" (Detail) to see the individual runs.
*   **Q: Does "Execution Time" include wait time?**
    *   A: No, it typically measures the time from "Actual Start" to "Actual Completion", excluding time spent in the queue.
