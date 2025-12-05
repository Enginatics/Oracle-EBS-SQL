# Case Study: End-to-End Order Fulfillment Visibility in Oracle Order Management

## Executive Summary
The **ONT Orders and Lines** report is a comprehensive operational dashboard for the Order-to-Cash (O2C) cycle. It breaks down silos between sales, shipping, and finance by providing a single, flattened view of a sales order—from the initial booking of the header to the status of individual lines, shipping deliveries, and final invoicing.

## Business Challenge
Managing the order lifecycle in Oracle EBS often requires navigating multiple screens (Order Organizer, Shipping Transactions, Invoice Status). This fragmentation leads to:
*   **Customer Service Delays:** Agents cannot quickly answer "Where is my order?" without checking multiple modules.
*   **Revenue Leakage:** Shipped lines that fail to interface to AR for invoicing ("Unbilled Receivables") can go unnoticed.
*   **Backlog Management:** Difficulty in distinguishing between "Booked" orders that are awaiting stock and "Awaiting Shipping" orders that are stuck in the warehouse.
*   **Performance Tracking:** Challenges in measuring On-Time Delivery (OTD) or DIFOT (Delivery In Full, On Time) metrics.

## The Solution
This report consolidates the entire lifecycle of a sales order line into a single row of data. It is designed to be the "one version of the truth" for Sales Operations, Logistics, and Accounts Receivable.

### Key Features
*   **Granular Status Tracking:** Displays the flow status of the line (e.g., `AWAITING_SHIPPING`, `SHIPPED`, `CLOSED`, `CANCELLED`).
*   **Shipping Details:** Includes Delivery Name, Waybill, Carrier, and Actual Ship Date for logistics tracking.
*   **Financial Integration:** Shows the Invoice Number and Invoice Date if the line has been billed, linking OM to AR.
*   **Holds Visibility:** Identifies any credit holds or process holds preventing the order from progressing.

## Technical Architecture
The report queries the core Order Management tables and joins them to Shipping (WSH) and Receivables (RA) to build the complete picture.

### Critical Tables
*   `OE_ORDER_HEADERS_ALL`: Contains order-level info (Customer, Order Type, Currency).
*   `OE_ORDER_LINES_ALL`: The heart of the report, containing item, quantity, price, and flow status.
*   `WSH_DELIVERY_DETAILS`: Provides the link to the shipping execution system (Pick Release, Ship Confirm).
*   `RA_CUSTOMER_TRX_LINES_ALL`: Links the order line to the generated AR invoice line.
*   `MTL_SYSTEM_ITEMS_B`: Provides item descriptions and attributes (e.g., weight, volume).

### Key Parameters
*   **Order Number:** Search for a specific sales order.
*   **Customer Name:** Analyze the backlog or history for a specific client.
*   **Line Status:** Filter for `AWAITING_SHIPPING` to generate a pick list or `SHIPPED` to verify revenue recognition.
*   **Date Ranges:** Filter by Ordered Date, Request Date, or Actual Ship Date for period-based reporting.

## Functional Analysis
### Use Cases
1.  **Backlog Analysis:** Sales managers run the report filtering for "Open" lines to understand the value of the current order book.
2.  **Revenue Assurance:** Finance users filter for lines where `Flow Status = CLOSED` but `Invoice Number` is NULL to find unbilled shipments.
3.  **Logistics Planning:** Warehouse managers use the report to see upcoming `Request Dates` to plan labor and carrier capacity.

### FAQ
**Q: Does this report include cancelled lines?**
A: Yes, the report typically includes a parameter to `Exclude Cancelled` lines, but they can be included to analyze lost demand.

**Q: Can I see the tracking number?**
A: Yes, if the Waybill/Tracking number is entered in the Shipping Transactions form, it will appear in the report output.

**Q: How does it handle split lines?**
A: Split lines (e.g., Line 1.1, 1.2) are treated as individual rows, allowing for accurate tracking of partial shipments.
