# Case Study & Technical Analysis: PO Internal Requisitions and Sales Orders Report

## Executive Summary

The PO Internal Requisitions and Sales Orders report is a crucial intercompany and internal supply chain visibility tool within Oracle E-Business Suite. It provides a consolidated view of internal requisitions (demand from one internal organization) and their corresponding internal sales orders (supply from another internal organization). This report is indispensable for procurement, inventory, and order management teams to track the entire internal order fulfillment cycle, monitor aging requests, identify bottlenecks, and ensure the seamless transfer of goods and services between internal entities.

## Business Challenge

Many large organizations operate with multiple internal operating units or inventory organizations that frequently transact with each other. Managing this internal demand and supply chain can be as complex as external procurement. Key challenges include:

-   **Lack of End-to-End Visibility:** It's difficult to get a single, consolidated view that links an internal requisition to its corresponding internal sales order, shipment, and receipt. This fragmentation hinders efficient internal order fulfillment.
-   **Tracking Aging Requests:** Internal requisitions can become stagnant, leading to delays in internal supply. Proactively identifying and expediting these aging requests is challenging without a dedicated report.
-   **Bottlenecks in Internal Transfers:** Pinpointing where delays occur in the internal order cycle (e.g., requisition stuck, sales order unbooked, awaiting shipment) impacts internal customer satisfaction and operational efficiency.
-   **Reconciliation Between Modules:** Reconciling data between Purchasing (for requisitions), Order Management (for internal sales orders), and Inventory (for shipments/receipts) is a critical but often complex task.

## The Solution

This report offers a flexible, consolidated, and actionable solution for managing the entire internal procure-to-pay cycle, directly addressing the challenges of fragmented visibility and reconciliation.

-   **Unified Internal Order View:** It integrates internal requisition header and line details with corresponding internal sales order headers and lines, providing an end-to-end view of the internal demand and supply chain.
-   **Aging and Status Monitoring:** The report displays aging dates and other useful information, allowing users to quickly identify internal requisitions or sales orders that are open or delayed, enabling proactive follow-up and expediting.
-   **Cross-Module Reconciliation:** By linking data from Purchasing, Order Management, and Inventory, the report facilitates reconciliation between these modules, ensuring consistency and accuracy of internal transfer data.
-   **Enhanced Operational Efficiency:** With clear visibility into the internal order lifecycle, teams can identify and resolve bottlenecks more quickly, improving internal customer service and overall operational efficiency.

## Technical Architecture (High Level)

The report queries core Oracle Purchasing, Order Management, and Inventory tables to consolidate internal order data.

-   **Primary Tables Involved:**
    -   `po_requisition_headers_all` and `po_requisition_lines_all` (for internal requisition details).
    -   `oe_order_headers_all` and `oe_order_lines_all` (for internal sales order details).
    -   `mtl_parameters` and `org_organization_definitions` (for organizational context).
    -   `gl_ledgers` (for ledger context).
    -   `mtl_system_items_vl` (for item details).
    -   `rcv_transactions` (for receiving details of internal transfers).
-   **Logical Relationships:** The report establishes a direct link between internal requisition lines and internal sales order lines (typically via `po_requisition_lines_all.requisition_line_id` linking to `oe_order_lines_all.source_document_line_id`). It then joins to header tables for both requisitions and sales orders, and to various inventory and organizational tables to provide comprehensive details and aging information.

## Parameters & Filtering

The report offers an extensive set of parameters for precise filtering and analysis of internal orders:

-   **Requisition Creation Date From/To:** Allows for analyzing internal demand created within specific periods.
-   **Item and Category Filters:** `Item Number` and `Category Set` parameters enable focused analysis on specific products or product groupings.
-   **Organizational Context:** `Organization Code`, `Organization Type`, `Operating Unit`, and `Ledger` provide comprehensive filtering across the enterprise.
-   **Open Flag:** The `Open` parameter is crucial for focusing on active internal orders that are still in process and require attention.

## Performance & Optimization

As a transactional report integrating data across multiple modules, it is optimized through strong filtering and efficient joining strategies.

-   **Date and Status-Driven Filtering:** The `Requisition Creation Date` range and the `Open` status parameter are critical for performance, allowing the database to efficiently narrow down the large transactional datasets to relevant open internal orders.
-   **Indexed Joins:** Queries leverage standard Oracle indexes on `requisition_header_id`, `requisition_line_id`, `order_header_id`, `order_line_id`, `organization_id`, and `item_id` for efficient data retrieval across Purchasing, Order Management, and Inventory tables.

## FAQ

**1. What is an 'Internal Requisition' and how does it differ from a standard requisition?**
   An 'Internal Requisition' is a request for goods or services that is fulfilled by another internal organization within the same company (e.g., a manufacturing plant requesting components from an internal distribution center). A standard requisition is a request for goods or services from an external supplier. Internal requisitions trigger internal sales orders, not external purchase orders.

**2. How does this report help manage the 'aging' of internal orders?**
   By showing creation dates and indicating if an internal order is still `Open`, the report allows procurement and inventory teams to quickly identify internal requisitions or sales orders that have been pending for an extended period. This enables proactive follow-up to resolve any issues and keep the internal supply chain moving.

**3. Can this report also show the actual shipment and receipt details for internal transfers?**
   Yes, the report includes the `rcv_transactions` table, which means it can be configured to display detailed information about the shipment (from the supplying organization) and receipt (at the demanding organization) of goods against the internal sales order, providing full visibility into the physical movement of inventory.
