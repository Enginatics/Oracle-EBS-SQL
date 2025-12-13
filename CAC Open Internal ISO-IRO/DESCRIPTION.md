# Case Study & Technical Analysis: CAC Open Internal ISO-IRO

## Executive Summary
The **CAC Open Internal ISO-IRO** report is a supply chain visibility tool. It tracks the lifecycle of Internal Requisitions (IRO) and their corresponding Internal Sales Orders (ISO). This process, known as "Internal Order" or "Inter-Org Transfer", is complex because it spans two different modules (Purchasing and Order Management).

## Business Challenge
*   **The "Black Hole"**: A user creates a requisition to move stock from Plant A to Plant B. It gets approved, but nothing arrives. Why?
*   **Process Disconnect**: The Requisition might be stuck in the interface, or the Sales Order might be on hold, or the Shipment might be stuck in shipping.
*   **Aging**: Old, open orders reserve inventory and confuse planning.

## Solution
This report bridges the gap.
*   **Linkage**: Joins `po_requisition_lines` to `oe_order_lines` to show the full chain of custody.
*   **Status Visibility**: Shows the status of both the "Demand" (Req) and the "Supply" (Order).
*   **Aging**: Calculates how long the order has been open.

## Technical Architecture
*   **Tables**: `po_requisition_headers/lines`, `oe_order_headers/lines`, `oe_order_sources`.
*   **Join Logic**: Uses the `order_source_id` and `orig_sys_document_ref` to link the OM line back to the PO Req line.
*   **Scope**: Filters for "Open" lines (Quantity Ordered > Quantity Delivered).

## Parameters
*   **Source/Dest Type**: (Optional) Filter by "Source" (Shipping Org) or "Destination" (Receiving Org).
*   **Org Code**: (Optional) Inventory Org.

## Performance
*   **Cross-Module**: Joining PO and OM tables can be slow if not indexed correctly, but this report uses standard keys.

## FAQ
**Q: Why is the Sales Order missing?**
A: If the "Create Internal Sales Orders" concurrent program hasn't run, or if the "Order Import" failed, the Requisition will exist without a Sales Order.

**Q: Does this show Intransit Shipments?**
A: It shows the *Order* status. If the order is "Shipped", the goods are likely in Intransit. To see the value of Intransit, use the "Intransit Value" report.
