# MRP Sourcing Rule Assignment Upload - Case Study & Technical Analysis

## Executive Summary
The **MRP Sourcing Rule Assignment Upload** is a configuration tool used to mass-maintain the "Assignment Sets" that determine how the planning engine sources material. It allows users to assign Sourcing Rules to Items, Categories, or Organizations in bulk.

## Business Challenge
Sourcing rules control the supply chain network (e.g., "Buy Item X from Supplier Y" or "Transfer Item Z from Warehouse A to Warehouse B").
-   **Network Redesign:** "We are closing a warehouse and need to repoint 10,000 items to source from a new distribution center."
-   **New Product Introduction:** "We just launched a new product line (Category 'NEW_TECH') and need to assign the standard sourcing rule to all 50 items in that category."
-   **Maintenance:** "We need to switch the sourcing for all 'Steel' items from 'Global' to 'Local' rules."

## Solution
The **MRP Sourcing Rule Assignment Upload** automates the assignment process.

**Key Features:**
-   **Hierarchy Support:** Supports assignments at all levels: Item-Org, Item, Category-Org, Category, Organization, and Global.
-   **Bulk Processing:** Can upload thousands of assignments in a single run.
-   **Validation:** Ensures that the Sourcing Rules and Items exist before creating the assignment.

## Technical Architecture
The tool interfaces with the Sourcing Rule Assignment tables.

### Key Tables and Views
-   **`MRP_ASSIGNMENT_SETS`**: Defines the set of assignments (e.g., "Supplier Scheduling Set").
-   **`MRP_SR_ASSIGNMENTS`**: The table linking the Sourcing Rule to the assignment level (Item, Category, etc.).
-   **`MRP_SOURCING_RULES`**: The definition of the rule itself.

### Core Logic
1.  **Parameter Check:** Validates the Assignment Set name.
2.  **Level Determination:** Determines the assignment level (e.g., Item vs. Category) based on the provided columns.
3.  **Execution:** Inserts or updates records in `MRP_SR_ASSIGNMENTS`.

## Business Impact
-   **Strategic Agility:** Allows companies to rapidly reconfigure their supply chain network in response to business changes.
-   **Accuracy:** Ensures consistent sourcing logic across large groups of items.
-   **Time Savings:** Eliminates days of manual clicking in the Sourcing Rule Assignment form.
