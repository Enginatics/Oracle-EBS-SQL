# Executive Summary
The **CSI Customer Products Summary** report provides a high-level view of the "Installed Base"—the products that have been sold to and are currently owned by customers. This report is essential for Service and Support organizations to understand the fleet of products they are responsible for maintaining. It summarizes item instances by customer, location, and status, providing a snapshot of the active install base.

# Business Challenge
After a product is shipped, tracking its lifecycle is critical for revenue generation (service contracts) and customer satisfaction.
*   **Asset Visibility**: "What products does Customer X currently have?"
*   **Warranty Management**: Knowing when a product was installed is key to determining warranty eligibility.
*   **Recall/Upgrade Management**: Identifying all customers who own a specific version of a product.

# Solution
This report queries the Oracle Installed Base (CSI) tables to list customer products.

**Key Features:**
*   **Customer-Centric View**: Groups products by Customer Account and Location.
*   **Instance Details**: Shows the Instance Number (Serial Number), Item, and current Status (e.g., "Active", "Expired").
*   **Date Filtering**: Allows filtering by Creation Date to see new installations within a period.

# Architecture
The report is built on `CSI_ITEM_INSTANCES`, the core table of the Installed Base. It joins to `HZ_PARTIES` and `HZ_LOCATIONS` for customer details.

**Key Tables:**
*   `CSI_ITEM_INSTANCES`: The unique record of each specific product unit (instance).
*   `CSI_INSTANCE_STATUSES`: The current state of the instance.
*   `HZ_CUST_ACCOUNTS`: The customer who owns the product.
*   `MTL_SYSTEM_ITEMS`: Product description and details.

# Impact
*   **Revenue Opportunities**: Helps sales teams identify customers with aging products who might be ready for an upgrade.
*   **Service Efficiency**: Allows support agents to quickly verify what equipment a customer has before dispatching a technician.
*   **Data Accuracy**: Serves as a tool to audit the accuracy of the installed base records against shipping history.
