# Executive Summary
The **DBA AWR System Time Percentages** report provides a proportional breakdown of how the database spends its time. Instead of raw seconds, it shows percentages (e.g., "80% SQL Execution, 10% Parsing, 5% PL/SQL"). This is crucial for understanding the *nature* of the workload. For example, a system spending 40% of its time on "Hard Parse" indicates a code quality issue (lack of bind variables), whereas 90% "SQL Execution" suggests a need for SQL tuning or more hardware.

# Business Challenge
*   **Workload Characterization**: "Is our system mostly doing calculation (CPU) or waiting for data (I/O)?"
*   **Code Quality Audit**: "Are we wasting resources on overhead tasks like parsing and connection management?"
*   **Tuning Focus**: "Should we focus on optimizing PL/SQL loops or SQL queries?"

# Solution
This report calculates the percentage contribution of each time model statistic to the total DB Time.

**Key Features:**
*   **SQL Execution Time %**: Time spent actually running queries.
*   **Parse Time %**: Time spent compiling SQL (Hard vs. Soft).
*   **PL/SQL Execution Time %**: Time spent in procedural logic.
*   **Connection Management %**: Time spent logging on/off.

# Architecture
The report queries `DBA_HIST_SYS_TIME_MODEL`.

**Key Tables:**
*   `DBA_HIST_SYS_TIME_MODEL`: Historical time model statistics.

# Impact
*   **Strategic Tuning**: Directs tuning efforts to the area with the biggest potential ROI (e.g., fixing parsing issues can double throughput).
*   **Application Profiling**: Helps developers understand the behavior of their application code.
*   **Anomaly Detection**: A sudden spike in "Sequence Load" or "Failed Parse" indicates a specific application bug.
