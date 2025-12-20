# MSC Pegging Hierarchy 11i - Case Study & Technical Analysis

## Executive Summary
The **MSC Pegging Hierarchy 11i** report is the version of the pegging report designed specifically for Oracle E-Business Suite Release 11i. While the core concept is the same as the R12 version, the underlying data structures and query logic are optimized for the 11i schema.

## Business Challenge
(Same as MSC Pegging Hierarchy)
-   **Traceability:** Linking supply to demand.
-   **Impact Analysis:** Understanding the downstream effect of delays.

## Solution
(Same as MSC Pegging Hierarchy)
-   **End-to-End Trace:** Full BOM and network traversal.
-   **Multi-Org:** Cross-organization visibility.

## Technical Architecture
The report is tailored for the 11i ASCP schema.

### Key Tables and Views
-   **`MSC_FULL_PEGGING`**: The core pegging table.
-   **`MSC_DEMANDS`** / **`MSC_SUPPLIES`**: Transaction details.
-   **`MSC_BOMS`**: Bill of Materials definitions within ASCP.

### Core Logic
1.  **Recursive Query:** Uses Oracle's hierarchical query syntax (`CONNECT BY`) to navigate the pegging tree.
2.  **11i Specifics:** Handles specific column names and table relationships that differ from R12 (e.g., how Projects or End Assemblies are linked).

## Business Impact
-   **Legacy Support:** Ensures that organizations running on 11i still have critical visibility into their supply chain plans.
-   **Continuity:** Provides a consistent reporting experience for users who may be in the process of upgrading.
