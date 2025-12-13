# Executive Summary
The **DBA AWR PGA History** report tracks the usage of the Program Global Area (PGA) over time. The PGA is the memory region reserved for each server process to perform non-shared operations, primarily sorting and hashing. Unlike the SGA (which is fixed), the PGA grows and shrinks dynamically. This report helps DBAs understand if the `PGA_AGGREGATE_TARGET` is sized correctly.

# Business Challenge
*   **Memory Leaks**: "Why does the database server run out of RAM every Friday?"
*   **Performance Tuning**: "Are we doing too many disk sorts because the PGA is too small?"
*   **Sizing**: "How much memory do we need to allocate to PGA to support 500 concurrent users?"

# Solution
This report displays historical PGA statistics from AWR.

**Key Features:**
*   **Total PGA Allocated**: The total amount of memory currently used by all processes.
*   **Cache Hit %**: The percentage of work areas (sorts/hashes) that ran entirely in memory (Optimal) vs. spilling to disk (One-pass/Multipass).
*   **Over-allocation Count**: Number of times the system failed to honor the target limit.

# Architecture
The report queries `DBA_HIST_PGASTAT`.

**Key Tables:**
*   `DBA_HIST_PGASTAT`: Historical PGA statistics.
*   `DBA_HIST_SNAPSHOT`: Snapshot timing.

# Impact
*   **Stability**: Prevents ORA-4030 (out of process memory) errors.
*   **Performance**: Maximizes in-memory sorting, which is orders of magnitude faster than disk sorting.
*   **Cost Efficiency**: Ensures RAM is allocated where it's needed most (SGA vs. PGA).
