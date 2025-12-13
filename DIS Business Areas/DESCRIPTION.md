# Case Study & Technical Analysis

## Abstract
The **DIS Business Areas** report provides a high-level inventory of the semantic layer in Oracle Discoverer. It lists all defined Business Areas and, crucially, correlates them with usage statistics. This allows administrators to distinguish between active, critical data models and obsolete "zombie" areas that haven't been queried in years.

## Technical Analysis

### Core Metrics
*   **Business Area**: The logical grouping of folders (tables/views).
*   **Access Count**: Derived from `EUL5_QPP_STATS`, this metric shows how many times queries have been executed against this Business Area within a configurable time window.
*   **Last Accessed**: The timestamp of the most recent query.

### Key Tables
*   `EUL5_BAS`: The Business Area definitions.
*   `EUL5_BA_OBJ_LINKS`: The many-to-many link between Business Areas and Folders (Objects).
*   `EUL5_QPP_STATS`: The Query Prediction and Performance statistics table, which acts as an audit log for Discoverer execution.

### Operational Use Cases
*   **Cleanup**: Safely deleting Business Areas that show zero access count in the last 365 days.
*   **Impact Analysis**: "If I modify the 'Order Management' Business Area, how many users are potentially affected?"
*   **Documentation**: Generating a catalog of available data domains for end users.
