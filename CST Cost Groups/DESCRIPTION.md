# Executive Summary
The **CST Cost Groups** report is a master data configuration report that details the setup of Cost Groups within the organization. In Project Manufacturing or Weighted Average Costing environments, Cost Groups are used to segregate inventory costs for different projects or purposes within the same inventory organization. This report provides a clear view of the account mappings associated with each group.

# Business Challenge
Cost Groups allow for the same item to have different costs depending on who owns it (e.g., Project A vs. Project B).
*   **Account Mapping**: Each Cost Group has its own set of valuation accounts (Material, Material Overhead, WIP, etc.). Incorrect mapping leads to financial misstatements.
*   **Complexity Management**: As the number of projects or cost groups grows, maintaining visibility into the underlying account structure becomes difficult.
*   **Audit**: Verifying that specific projects are pointing to the correct GL accounts.

# Solution
This report lists all defined Cost Groups and their associated General Ledger accounts.

**Key Features:**
*   **Account Detail**: Shows the full GL account string for each cost element (Material, Resource, Overhead, etc.).
*   **Description**: Includes the description of the Cost Group for context.

# Architecture
The report queries `CST_COST_GROUPS` and `CST_COST_GROUP_ACCOUNTS`.

**Key Tables:**
*   `CST_COST_GROUPS`: Defines the cost group name and type.
*   `CST_COST_GROUP_ACCOUNTS`: Stores the GL account assignments for the group.

# Impact
*   **Configuration Validation**: Ensures that new Cost Groups are set up with the correct accounting rules.
*   **Troubleshooting**: Helps explain why inventory transactions for a specific project are hitting unexpected GL accounts.
*   **System Documentation**: Provides a reference for the financial structure of the manufacturing organization.
