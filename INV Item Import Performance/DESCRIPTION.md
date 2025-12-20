# INV Item Import Performance - Case Study & Technical Analysis

## Executive Summary
The **INV Item Import Performance** report is a technical diagnostic tool used by DBAs and Developers. It analyzes the throughput of the Item Import Interface (`INCOIN`) to identify performance degradation. If the "Items Processed Per Second" metric drops as the volume increases, it typically indicates a missing index or a non-selective index on the interface tables.

## Business Use Cases
*   **Performance Tuning**: Used during data migration or large catalog updates to ensure the system can handle the load.
*   **SLA Monitoring**: Verifies that the nightly item feed from the PLM system is completing within the batch window.
*   **Root Cause Analysis**: Helps pinpoint why the "Item Import" concurrent request is taking 5 hours instead of 5 minutes.

## Technical Analysis

### Core Tables
*   `MTL_SYSTEM_ITEMS_INTERFACE`: The interface table (implied source of the metrics).
*   `FND_CONCURRENT_REQUESTS`: Used to track the start/end time and status of the import jobs.
*   `MTL_SYSTEM_ITEMS_B`: The target table.

### Key Joins & Logic
*   **Throughput Calculation**: `Items Per Second` = `Total Items Processed` / (`Request End Time` - `Request Start Time`).
*   **Trend Analysis**: The report looks for a negative correlation between volume and speed.

### Key Parameters
*   **Past Days**: How far back to analyze the concurrent request history.
*   **Min Total Item Count**: Filter out small test batches to focus on bulk loads.
