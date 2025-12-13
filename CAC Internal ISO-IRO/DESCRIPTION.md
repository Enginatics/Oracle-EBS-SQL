# Case Study & Technical Analysis: CAC Internal ISO-IRO

## Executive Summary
The **CAC Internal ISO-IRO** report provides a comprehensive operational view of open Internal Sales Orders (ISO) and Internal Requisitions (IRO). It is designed to bridge the visibility gap between supply chain planning and execution by linking requisition data with sales order fulfillment status. This report is critical for supply chain managers and inventory controllers to monitor internal stock transfers, identify aging orders, and ensure timely fulfillment of internal demand across the organization.

## Business Challenge
Organizations managing complex internal supply chains often face challenges in tracking stock transfers between inventory organizations. Common pain points include:
*   **Lack of End-to-End Visibility:** Difficulty in linking the internal requisition (demand side) with the internal sales order (supply side).
*   **Aging Transfers:** Inability to easily identify old or stalled transfers that are tying up inventory or delaying downstream processes.
*   **Reconciliation Issues:** Challenges in reconciling internal orders with general ledger entries and inventory balances.
*   **Manual Tracking:** Reliance on disjointed standard reports or manual Excel spreadsheets to track the status of internal moves.

## The Solution
The **CAC Internal ISO-IRO** report solves these challenges by providing a unified view of the internal order lifecycle.
*   **Operational View:** It joins `PO_REQUISITION_HEADERS_ALL` and `OE_ORDER_HEADERS_ALL` to show the complete flow from request to order.
*   **Aging Analysis:** Includes aging dates to highlight orders that have been open for extended periods, allowing for proactive management.
*   **Cross-Functional Data:** Displays relevant details such as Item, Quantity, UOM, Status, and Organization information in a single row, facilitating quick decision-making.
*   **Flexibility:** Supports filtering by various parameters like Organization, Operating Unit, and Item Categories to tailor the output to specific user needs.

## Technical Architecture (High Level)
The report is built on a robust SQL query that integrates data from multiple modules including Purchasing, Order Management, and Inventory.

**Primary Tables Involved:**
*   `PO_REQUISITION_HEADERS_ALL` / `PO_REQUISITION_LINES_ALL`: Source of the internal requisition data.
*   `OE_ORDER_HEADERS_ALL` / `OE_ORDER_LINES_ALL`: Source of the internal sales order data.
*   `MTL_SYSTEM_ITEMS_VL`: Provides item master details including descriptions and status.
*   `HR_ALL_ORGANIZATION_UNITS_VL` / `ORG_ORGANIZATION_DEFINITIONS`: Defines the source and destination organizations.
*   `GL_LEDGERS`: Links the transaction to the financial ledger.

**Logical Relationships:**
*   The core logic links Requisition Lines to Sales Order Lines to establish the demand-supply relationship.
*   Item details are retrieved by joining with the Item Master based on the Item ID and Organization ID.
*   Organization and Location details are resolved by joining with HR and Party tables to provide readable names instead of IDs.

## Parameters & Filtering
The report offers a set of parameters to refine the data output:
*   **Category Sets (1-3):** Allows filtering by specific item categories (e.g., Product Line, Inventory Category) to focus on relevant material groups.
*   **Item Number:** Enables searching for a specific item to track its internal movement.
*   **Organization Code:** Filters the report for a specific inventory organization (Source or Destination).
*   **Organization Type:** Can be used to filter by the type of organization if applicable.
*   **Operating Unit:** Limits the scope to a specific Operating Unit for multi-org environments.
*   **Ledger:** Filters data based on the associated General Ledger.

## Performance & Optimization
This report is optimized for performance in large EBS environments:
*   **Efficient Joins:** Uses standard indexed columns for joining major transaction tables (PO and OE), ensuring fast retrieval even with high transaction volumes.
*   **Direct Database Access:** By bypassing the XML parsing layer often used in standard BI Publisher reports, it delivers data directly to Excel, significantly reducing processing time.
*   **Selective Retrieval:** The use of parameters allows the database to filter records early in the execution plan, minimizing the data set processed.

## FAQ
**Q: Can this report show closed or cancelled orders?**
A: The report is primarily designed to show *open* internal sales orders and requisitions to help manage active supply chain tasks.

**Q: How does it link the Requisition to the Sales Order?**
A: The link is established through the internal system references that Oracle EBS maintains when an Internal Sales Order is created from an approved Internal Requisition.

**Q: Does it support multi-currency environments?**
A: Yes, the report includes Ledger and Operating Unit context, making it suitable for multi-national implementations.
