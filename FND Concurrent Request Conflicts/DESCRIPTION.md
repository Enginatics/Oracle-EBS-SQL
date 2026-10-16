# Executive Summary
The **FND Concurrent Request Conflicts** report analyzes the "Conflict Resolution Manager" (CRM) activity. It identifies requests that were delayed because they were incompatible with currently running jobs.

# Business Challenge
*   **Wait Time Analysis:** Understanding why a request stayed in "Pending" status for a long time.
*   **Incompatibility Tuning:** Identifying if incompatibility rules are too aggressive and causing unnecessary bottlenecks.
*   **SLA Monitoring:** Explaining delays in critical report delivery to business users.

# The Solution
This Blitz Report reconstructs the conflict scenario:
*   **Blocked Request:** Identifies the request that was held.
*   **Blocking Request:** Identifies the specific request ID that was running and caused the conflict.
*   **Time Impact:** Shows the duration of the delay caused by the conflict.

# Technical Architecture
The report logic looks at requests where the `PHASE_CODE` was 'P' (Pending) and analyzes the CRM logs or infers conflicts based on the `FND_CONCURRENT_PROGRAM_SERIAL` rules and execution timestamps of overlapping requests.

# Parameters & Filtering
*   **Program Name:** Filter for the program that was blocked.
*   **Date Range:** Analyze conflicts within a specific window.

# Performance & Optimization
*   **Complex Logic:** Determining conflicts retrospectively is complex. The report uses heuristic logic to match blocked requests with potential blockers.
*   **History:** Only works for requests that are still in the `FND_CONCURRENT_REQUESTS` table (not purged).

# FAQ
*   **Q: Does it show Request Set conflicts?**
    *   A: As noted in the description, it focuses on individual program conflicts and may not fully capture complex Request Set incompatibilities.
