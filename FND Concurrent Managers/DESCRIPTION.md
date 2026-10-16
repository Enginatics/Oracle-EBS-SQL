# Executive Summary
The **FND Concurrent Managers** report provides a real-time dashboard of the concurrent processing system. It details the configuration and current status of all concurrent managers, including their workload and specialization rules.

# Business Challenge
*   **Bottleneck Detection:** Identifying managers that have a backlog of pending requests.
*   **Capacity Planning:** Determining if more processes (workers) need to be assigned to a specific manager.
*   **Troubleshooting:** Checking if a manager is actually running or if it has deactivated due to errors.

# The Solution
This Blitz Report replicates and enhances the "Administer Concurrent Managers" form:
*   **Comprehensive Status:** Shows Target vs. Actual processes, Running Requests, and Pending Requests.
*   **Specialization Visibility:** Details the "Include/Exclude" rules that determine which programs a manager can run.
*   **Queue Analysis:** Provides insight into the depth of the queue for each manager.

# Technical Architecture
The report queries `FND_CONCURRENT_QUEUES` (Managers) and joins with `FND_CONCURRENT_PROCESSES` (Workers) and `FND_CONCURRENT_REQUESTS` (Workload). It calculates the "Pending" and "Running" counts dynamically.

# Parameters & Filtering
*   **Manager Name:** Filter for a specific manager (e.g., "Standard Manager").
*   **Show Specialization Rules:** Toggle to list the programs included/excluded for the manager.

# Performance & Optimization
*   **Real-Time Data:** This report queries active transaction tables. It is generally fast but reflects the system state at the exact moment of execution.

# FAQ
*   **Q: What is the "Standard Manager"?**
    *   A: It is the default manager that picks up any request not routed to a specialized manager.
*   **Q: Why is "Actual" less than "Target"?**
    *   A: The Internal Manager Manager (ICM) might still be starting up processes, or the manager might have encountered an error and scaled down.
