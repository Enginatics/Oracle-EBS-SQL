# MSC Sourcing Rule Assignment Upload - Case Study & Technical Analysis

## Executive Summary
The **MSC Sourcing Rule Assignment Upload** is a configuration tool for the ASCP environment. Similar to the MRP version, it allows for the mass maintenance of Sourcing Rule Assignments. However, this tool is specifically designed for the **MSC** (ASCP) schema, which is often separate from the transactional (MRP/ERP) schema.

## Business Challenge
In distributed environments, sourcing rules might need to be maintained directly in the planning instance or synchronized from the source.
-   **Simulation:** "We want to test a new sourcing strategy in a simulation plan without changing the production system. We need to upload these assignments to the planning instance only."
-   **Volume:** "We have 50,000 assignments to update. The forms are too slow."

## Solution
The **MSC Sourcing Rule Assignment Upload** allows bulk updates to the ASCP assignment sets.

**Key Features:**
-   **Direct ASCP Update:** Updates the tables in the planning schema (`MSC_`).
-   **Hierarchy Support:** Supports Item, Category, Organization, and Global levels.
-   **Validation:** Ensures referential integrity with ASCP master data.

## Technical Architecture
The tool interfaces with the MSC assignment tables.

### Key Tables and Views
-   **`MSC_ASSIGNMENT_SETS`**: Defines the assignment set.
-   **`MSC_SR_ASSIGNMENTS`**: The table linking rules to items/orgs.
-   **`MSC_SOURCING_RULES`**: The rule definitions.

### Core Logic
1.  **Context:** Operates within the context of a specific Planning Instance.
2.  **Processing:** Inserts or updates records in `MSC_SR_ASSIGNMENTS`.
3.  **Collection Flag:** Can optionally include collected data or only local (simulation) data.

## Business Impact
-   **Simulation Capability:** Enables powerful "what-if" analysis by allowing planners to rapidly change sourcing logic in a test plan.
-   **Efficiency:** Drastically reduces the time required to set up or modify large supply chain networks.
