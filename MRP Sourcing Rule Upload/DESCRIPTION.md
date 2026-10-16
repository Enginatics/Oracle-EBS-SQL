# MRP Sourcing Rule Upload - Case Study & Technical Analysis

## Executive Summary
The **MRP Sourcing Rule Upload** is a tool for creating and maintaining the Sourcing Rules themselves (the "How" and "Where"). While the *Assignment Upload* determines *which* items use a rule, this tool defines *what* the rule actually does (e.g., "Buy from Supplier A with 60% allocation and Supplier B with 40%").

## Business Challenge
Defining complex sourcing logic manually is slow.
-   **Multi-Sourcing:** "We want to split our volume for this commodity: 50% to Vendor A, 30% to Vendor B, and 20% to Vendor C."
-   **Inter-Org Transfers:** "We need to define transfer rules for 50 different distribution centers."
-   **Updates:** "Vendor A is changing their name/site. We need to update 200 sourcing rules to reflect the new site."

## Solution
The **MRP Sourcing Rule Upload** allows bulk definition of these rules.

**Key Features:**
-   **Rule Definition:** Create new rules or update existing ones.
-   **Source Types:** Supports "Buy From" (Supplier), "Transfer From" (Org), and "Make At" (Org).
-   **Allocations:** Allows defining split percentages and rankings (Rank 1 vs. Rank 2).

## Technical Architecture
The tool interfaces with the Sourcing Rule definition tables.

### Key Tables and Views
-   **`MRP_SOURCING_RULES`**: The header table for the rule.
-   **`MRP_SR_RECEIPT_ORG`**: Defines the receiving organization (for local rules).
-   **`MRP_SR_SOURCE_ORG`**: Defines the source (Supplier, Org) and allocation %.

### Core Logic
1.  **Header Creation:** Creates the rule header in `MRP_SOURCING_RULES`.
2.  **Detail Creation:** Creates the source details (Supplier/Org, Allocation %, Rank) in `MRP_SR_SOURCE_ORG`.
3.  **Validation:** Checks that allocations sum to 100% (if required) and that suppliers/orgs are valid.

## Business Impact
-   **Procurement Strategy:** Enables the rapid implementation of strategic sourcing decisions (e.g., dual-sourcing initiatives).
-   **Network Optimization:** Facilitates the setup of complex distribution networks (Hub-and-Spoke).
-   **Data Integrity:** Ensures that sourcing rules are defined consistently and accurately.
