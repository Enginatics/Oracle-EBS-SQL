# MRP Sourcing Rules and Bills of Distribution - Case Study & Technical Analysis

## Executive Summary
The **MRP Sourcing Rules and Bills of Distribution** report provides a comprehensive listing of the defined sourcing logic. It documents the supply chain network, showing how items are sourced (Make, Buy, Transfer) and from where.

## Business Challenge
Understanding the supply chain network requires visibility into the sourcing rules.
-   **Network Visualization:** "What is our current strategy for sourcing 'Electronics'? Are we single-sourced or dual-sourced?"
-   **Audit:** "Show me all rules where we are sourcing from 'Supplier X' so we can assess the impact of their bankruptcy."
-   **Validation:** "Do we have any rules where the allocation percentages don't add up to 100%?"

## Solution
The **MRP Sourcing Rules and Bills of Distribution** report lists the rules and their details.

**Key Features:**
-   **Rule Details:** Shows the name, description, and type (Sourcing Rule vs. Bill of Distribution).
-   **Source Logic:** Lists the sources (Supplier, Org), Ranks, and Allocation Percentages.
-   **Assignments (Optional):** Can optionally show which items or categories are assigned to these rules.

## Technical Architecture
The report queries the sourcing rule definition tables.

### Key Tables and Views
-   **`MRP_SOURCING_RULES`**: The rule header.
-   **`MRP_SR_SOURCE_ORG_V`**: The details of the sources (Suppliers/Orgs).
-   **`MRP_SR_RECEIPT_ORG_V`**: The receiving organizations.
-   **`MRP_ASSIGNMENT_SETS`**: (If joined) shows where the rules are used.

### Core Logic
1.  **Retrieval:** Selects rules based on parameters (Name, Organization).
2.  **Expansion:** Joins to the source details to show the specific suppliers or transfer origins.
3.  **Formatting:** Presents the data in a hierarchical or flat format for analysis.

## Business Impact
-   **Supply Chain Visibility:** Provides a clear map of the physical flow of goods through the supply chain.
-   **Risk Management:** Helps identify single points of failure (single-sourced items).
-   **Compliance:** Ensures that sourcing strategies are being implemented as designed in the system.
