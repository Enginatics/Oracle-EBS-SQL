# PO Cancelled Purchase Orders - Case Study

## Executive Summary
The **PO Cancelled Purchase Orders** report provides Procurement Managers and Financial Controllers with critical visibility into cancelled spending commitments. By aggregating data on cancelled headers and lines, this report helps organizations analyze patterns in order cancellations, manage supplier relationships, and ensure that financial liabilities are properly de-obligated in the system.

## Business Challenge
Cancelled orders, if not monitored, can lead to several business issues:
*   **Lost Visibility:** Understanding *why* orders are cancelled is key to improving demand planning.
*   **Supplier Performance:** Frequent cancellations by a supplier (or due to supplier issues) can indicate reliability problems.
*   **Financial Liability:** Ensuring that cancelled POs are fully closed and funds are unencumbered (in encumbrance accounting environments) is vital for accurate budget reporting.
*   **Audit Trails:** Auditors often look for cancelled large-value orders to ensure proper authorization and process adherence.

## The Solution
The **PO Cancelled Purchase Orders** report offers a clear "Operational View" of the cancellation history.

**Key Features:**
*   **Granular Detail:** Can report at both the PO Header level (entire order cancelled) and the Line level (partial cancellation).
*   **Audit Data:** Includes details on *who* cancelled the order and *when*, providing a robust audit trail.
*   **Supplier Focus:** Allows filtering by specific vendors to analyze cancellation trends per supplier.
*   **Buyer Analysis:** Enables performance review by grouping cancellations by the buyer responsible.

## Technical Architecture
The report queries the Purchasing tables, focusing on status flags and action history.

**Primary Tables:**
*   `PO_HEADERS_ALL`: The main table for Purchase Order documents. Contains the `CANCEL_FLAG` and `CANCEL_DATE`.
*   `PO_LINES_ALL`: Contains line-level details. Also has `CANCEL_FLAG` for individual line cancellations.
*   `PO_VENDORS` (AP_SUPPLIERS): Provides supplier names and details.
*   `PO_ACTION_HISTORY`: Used to trace the specific actions taken on the document, identifying the user who performed the cancellation.

**Logical Relationships:**
The report filters `PO_HEADERS_ALL` (and optionally `PO_LINES_ALL`) where the `CANCEL_FLAG` is set to 'Y'. It joins to `PO_VENDORS` to retrieve supplier names and `PER_ALL_PEOPLE_F` to identify the buyer.

## Parameters & Filtering
Key parameters allow for targeted analysis:
*   **Operating Unit:** Restricts data to a specific business entity.
*   **Show Order Lines:** A toggle to determine if the report should list every cancelled line or just cancelled headers.
*   **Vendor From/To:** Filters for a specific supplier or range of suppliers.
*   **Cancelled Date From/To:** The most critical filter, allowing users to see cancellations within a specific reporting period (e.g., last month).
*   **Buyer Name:** Filters by the purchasing agent.

## Performance & Optimization
*   **Date-Based Indexing:** The report is designed to filter efficiently on `CANCEL_DATE` or `CREATION_DATE`, which are typically indexed columns, ensuring fast retrieval even with large historical datasets.
*   **Selective Joins:** The join to `PO_LINES_ALL` is conditional or optimized to only occur when line-level detail is requested, reducing processing overhead for header-level summaries.

## Frequently Asked Questions
**Q: Does this report include orders that were "Finally Closed"?**
A: "Finally Closed" and "Cancelled" are distinct statuses in Oracle EBS. This report specifically targets orders where the Cancel action was performed. Finally Closed orders are typically handled by the "PO Final Close" process.

**Q: Can I see who cancelled the order?**
A: Yes, by linking to the `PO_ACTION_HISTORY` or checking the `LAST_UPDATED_BY` fields on the cancellation action, the report can identify the user responsible.

**Q: Does it show the value of the cancelled funds?**
A: Yes, the report typically calculates the cancelled amount based on the quantity cancelled and the unit price, helping Finance understand the value of de-obligated funds.
