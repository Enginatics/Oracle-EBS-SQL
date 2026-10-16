# Executive Summary
The **DBA CPU Benchmark1** report is a synthetic benchmark designed to measure the single-threaded CPU performance of the database server. It generates a large dataset (500,000 rows) by creating a Cartesian product of standard Oracle EBS tables (`FND_LANGUAGES`, `FND_CURRENCIES`, `FND_APPLICATION`). The execution time is dominated by the PL/SQL engine's ability to process these rows and generate the output, making it a good proxy for PL/SQL performance.

# Business Challenge
*   **Hardware Validation**: "We migrated to new servers. Are the CPUs actually faster?"
*   **Cloud Migration**: "How does the performance of an AWS r5.xlarge compare to our on-premise Exadata?"
*   **Baseline Creation**: Establishing a performance baseline before applying OS patches or upgrades.

# Solution
This report runs a query that forces the database to do significant work (generating rows) and measures the elapsed time.

**Key Features:**
*   **Standardized Workload**: Uses standard FND tables present in every EBS instance, ensuring comparability.
*   **CPU Bound**: Designed to be CPU-intensive (assuming the data is in the buffer cache), minimizing I/O noise.
*   **Comparative Data**: The description includes reference timings for various processors (e.g., AMD Ryzen, Intel Xeon).

# Architecture
The report queries `FND_LANGUAGES`, `FND_CURRENCIES`, and `FND_APPLICATION`.

**Key Tables:**
*   `FND_LANGUAGES`, `FND_CURRENCIES`, `FND_APPLICATION`: Used as data sources for the Cartesian product.

# Impact
*   **Vendor Accountability**: Verifies that the cloud provider or hardware vendor is delivering the promised performance.
*   **Sizing Decisions**: Helps determine the correct CPU SKU for a new deployment.
*   **Performance Troubleshooting**: Rules out (or confirms) "slow CPU" as a cause of general system sluggishness.
