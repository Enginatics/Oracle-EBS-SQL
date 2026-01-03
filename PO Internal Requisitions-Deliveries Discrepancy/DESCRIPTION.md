# Case Study & Technical Analysis: PO Internal Requisitions-Deliveries Discrepancy Report

## Executive Summary

The PO Internal Requisitions-Deliveries Discrepancy report is a critical internal supply chain reconciliation tool within Oracle E-Business Suite. It is specifically designed to highlight mismatches between internal requisitions (demand from one internal organization) and the actual delivery of goods against the corresponding internal sales orders. This report is indispensable for procurement, inventory, and order management teams to identify and investigate operational breakdowns, resolve discrepancies, and ensure the efficient and accurate flow of materials between internal entities, thereby optimizing the internal supply chain.

## Business Challenge

Efficient internal material transfers are vital for manufacturing continuity and inter-departmental service levels. However, discrepancies between what was requested and what was delivered internally are common and can lead to significant operational issues:

-   **Lack of Reconciliation:** It is often challenging to reconcile the quantity or items requested on an internal requisition with what was actually shipped and received against the internal sales order. This lack of visibility can lead to material shortages or overstocks.
-   **Operational Bottlenecks:** Discrepancies often indicate a breakdown in the internal transfer process, such as partial shipments, incorrect items being sent, or receiving errors. Identifying these specific issues is crucial for corrective action.
-   **Impact on Production and Projects:** Delays or errors in internal deliveries directly impact production schedules, project timelines, and the availability of materials for various internal stakeholders.
-   **Manual Investigation:** Without a specialized report, investigating these discrepancies requires time-consuming manual comparisons across multiple Oracle modules (Purchasing, Order Management, Inventory), leading to prolonged resolution times.

## The Solution

This report offers a powerful and focused solution for identifying and managing discrepancies in internal requisitions and deliveries, enhancing internal supply chain transparency.

-   **Highlights Discrepancies:** The report specifically flags and details instances where there is a mismatch between the internal requisition details and the corresponding delivery/receipt information on the internal sales order, making anomalies immediately visible.
-   **Consolidated Data View:** It brings together relevant information from internal requisitions, internal sales orders, and inventory receipt transactions into a single, comprehensive report, providing an end-to-end view of the internal transfer process.
-   **Accelerated Problem Resolution:** By pinpointing the exact discrepancies (e.g., quantity variance, item mismatch), the report empowers procurement and inventory teams to quickly investigate the root cause and implement corrective actions.
-   **Improved Internal Customer Service:** Proactively addressing discrepancies ensures that internal customers receive their requested materials accurately and on time, improving satisfaction and operational flow.

## Technical Architecture (High Level)

The report queries core Oracle Purchasing, Order Management, and Inventory tables, specifically designed to identify discrepancies between the internal requisition and sales order fulfillment.

-   **Primary Tables Involved:**
    -   `po_requisition_headers` and `po_requisition_lines` (for internal requisition details).
    -   `oe_order_headers_all` and `oe_order_lines_all` (for corresponding internal sales order details).
    -   `mtl_system_items_vl` (for item master details).
    -   `per_all_people_f` (for requester information).
    -   `org_organization_definitions` and `hr_operating_units` (for organizational context).
    -   `rcv_transactions` (for actual receipt data against internal sales orders).
-   **Logical Relationships:** The report establishes a link between `po_requisition_lines` and `oe_order_lines_all` (as internal sales orders are generated from internal requisitions). It then compares the requested quantities on the requisition line with the quantities shipped/received against the sales order, utilizing `rcv_transactions` for delivery details, to highlight any variances or mismatches.

## Parameters & Filtering

The report offers flexible parameters for targeted analysis of internal requisition and delivery discrepancies:

-   **Organizational Context:** `Operating Unit` and `Destination Organization` allow for filtering by specific business units and the receiving inventory organization.
-   **Requisition Identification:** `Requisition Number From/To` and `Requester` enable focusing on specific internal demand requests or those from particular individuals.
-   **Date Ranges:** `Requisition Date From/To` allows for analyzing discrepancies that occurred within specific periods.
-   **Sort By:** Provides flexibility in organizing the report output for easier analysis (e.g., by Requisition Number, Item, or Discrepancy Type).

## Performance & Optimization

As a transactional reconciliation report integrating data across multiple modules, it is optimized through strong filtering and efficient joining strategies.

-   **Parameter-Driven Efficiency:** The use of specific `Requisition Number` ranges and `Requisition Date` ranges is critical for performance, allowing the database to efficiently narrow down the large transactional datasets to relevant internal orders.
-   **Targeted Discrepancy Logic:** The report's SQL is specifically designed to perform comparisons and identify variances efficiently, avoiding full table scans of all requisition and sales order lines unless necessary.
-   **Indexed Lookups:** Queries leverage standard Oracle indexes on `requisition_header_id`, `requisition_line_id`, `order_header_id`, `order_line_id`, and `item_id` for efficient data retrieval across Purchasing, Order Management, and Inventory tables.

## FAQ

**1. What types of discrepancies does this report typically identify?**
   This report commonly identifies quantity discrepancies (e.g., requested 10, delivered 8), item mismatches (e.g., wrong item sent), or open requisitions for which no corresponding delivery has been recorded. It helps pinpoint situations where the internal supply chain has not fully met the internal demand.

**2. How should an organization resolve discrepancies found in this report?**
   Resolution depends on the nature of the discrepancy. It might involve: coordinating with the shipping/receiving organizations to correct receipt quantities, processing returns for incorrect items, or expediting outstanding internal sales orders. The detailed information in the report provides the starting point for investigation.

**3. Can this report also show pricing discrepancies between the requisition and the sales order?**
   While the report focuses on quantities and items, it could potentially be extended to compare pricing (e.g., internal transfer price vs. requisition estimated price) if the relevant pricing attributes are stored and can be joined from the `oe_order_lines_all` and `po_requisition_lines_all` tables.
