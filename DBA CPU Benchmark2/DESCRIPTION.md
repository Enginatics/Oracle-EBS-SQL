# Executive Summary
The **DBA CPU Benchmark2** report is a simplified version of the CPU benchmark. Instead of joining tables, it generates 200,000 rows directly from `DUAL` using a `CONNECT BY` clause. This isolates the performance of the SQL and PL/SQL engines even further, removing any potential dependency on table statistics or data distribution.

# Business Challenge
*   **Pure CPU Testing**: "I want to test raw CPU speed without any table I/O interference."
*   **Quick Check**: "I need a fast test to see if the server is performing normally."
*   **Comparison**: Comparing results with Benchmark1 to see if table access overhead is a factor.

# Solution
This report generates a fixed number of rows using a hierarchical query on `DUAL`.

**Key Features:**
*   **Zero Dependencies**: Does not rely on any application tables, only the Oracle data dictionary.
*   **High Speed**: Completes very quickly, allowing for rapid iteration.
*   **Reference Data**: Includes benchmark results for various CPU architectures.

# Architecture
The report queries `DUAL`.

**Key Tables:**
*   `DUAL`: The standard Oracle dummy table.

# Impact
*   **Infrastructure Verification**: Quickly validates CPU performance after maintenance or migration.
*   **Environment Comparison**: consistently compares performance across Dev, Test, and Prod environments.
*   **PL/SQL Efficiency**: Measures the raw speed of the PL/SQL output generation process.
