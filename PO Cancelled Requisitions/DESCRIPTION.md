# Case Study & Technical Analysis: PO Cancelled Requisitions Report

## Executive Summary

The PO Cancelled Requisitions report is a crucial procurement analysis tool within Oracle Purchasing, providing a detailed view of all purchase requisitions (PRs) that have been cancelled. It offers insights into who initiated the cancellation, when it occurred, and the impact on purchasing plans. This report is indispensable for procurement managers, departmental requestors, and financial analysts to understand the reasons for requisition cancellations, identify trends, and take corrective actions to improve the efficiency and accuracy of the procure-to-pay process.

## Business Challenge

Cancelled purchase requisitions represent wasted effort in the procure-to-pay cycle and can indicate underlying issues in planning or demand. Organizations often struggle with:

-   **Lack of Visibility into Cancellations:** Without a dedicated report, it's difficult to track which requisitions are being cancelled, by whom, and for what reasons, making it hard to identify recurring problems.
-   **Impact on Planning and Budgeting:** Cancelled PRs can disrupt planning efforts if the demand is still valid, or lead to inaccurate budget utilization tracking if the cancellation is not properly analyzed.
-   **Process Inefficiencies:** A high volume of cancellations might indicate issues upstream (e.g., incorrect demand forecasts, wrong item selection by requestors) or in the approval process, leading to unnecessary administrative work.
-   **Compliance and Audit Trail:** For audit purposes, it's important to have a clear record of all cancelled requisitions, including who initiated the cancellation and the date it was performed.

## The Solution

This report offers a streamlined and analytical solution for monitoring and understanding cancelled purchase requisitions, turning raw data into actionable insights for procurement optimization.

-   **Comprehensive Cancellation Details:** It provides a detailed list of all cancelled requisitions, including header and line-level information, the preparer, requestor, and key dates such as creation and cancellation dates.
-   **Root Cause Analysis:** By consolidating cancellation data, the report helps procurement teams investigate the underlying reasons for cancellations (though the reason code itself might need to be explicitly configured and captured in Oracle's `po_action_history` table for full benefit).
-   **Improved Procurement Planning:** Understanding cancellation trends allows for better demand forecasting and procurement planning, reducing waste and improving efficiency.
-   **Enhanced Accountability:** Parameters for `Preparer` and `Requestor` enable managers to identify patterns in cancellations related to specific individuals or departments, fostering accountability and targeted training.

## Technical Architecture (High Level)

The report queries core Oracle Purchasing tables to retrieve details about cancelled requisitions. Originally a BI Publisher report, its Blitz Report implementation offers improved performance.

-   **Primary Tables Involved:**
    -   `po_requisition_headers_all` (for requisition header information).
    -   `po_requisition_lines_all` (for detailed requisition line items).
    -   `po_action_history` (a crucial table for tracking workflow actions, including cancellations, on purchasing documents).
    -   `fnd_user` and `per_all_people_f` (to get names of preparers and requestors).
    -   `mtl_system_items_vl` and `mtl_categories_kfv` (for item and category details).
-   **Logical Relationships:** The report links `po_requisition_headers_all` to `po_requisition_lines_all` to retrieve all requisition details. It then queries `po_action_history` to identify requisitions that have a cancellation action recorded against them, and joins to HR tables to get the user-friendly names of the preparers and requestors.

## Parameters & Filtering

The report offers flexible parameters for targeted analysis of cancelled requisitions:

-   **Show Requisition Lines:** A crucial parameter that allows users to choose between a header-level summary or a detailed line-item view of cancelled requisitions.
-   **Organizational Context:** `Operating Unit` filters the report to a specific business unit.
-   **Personnel Filters:** `Preparer From/To` and `Requestor From/To` allow for filtering by specific individuals or ranges of employees who created or requested the requisitions.
-   **Date Ranges:** `Cancelled Date From/To` and `Creation Date From/To` are essential for analyzing cancellation trends over specific periods.

## Performance & Optimization

As a transactional report, it is optimized by its ability to filter on key dates and leverage underlying table structures.

-   **Date-Driven Filtering:** The `Cancelled Date` and `Creation Date` parameters are critical for performance, allowing the database to efficiently narrow down the large volume of requisition data to the relevant timeframe using existing indexes.
-   **Leveraging Action History:** By directly querying `po_action_history`, the report efficiently identifies cancelled documents without requiring complex status derivations.
-   **Efficient Joins:** Queries leverage standard Oracle indexes on `requisition_header_id`, `requisition_line_id`, and `agent_id` for efficient joins across purchasing and HR tables.

## FAQ

**1. What is the difference between cancelling a requisition line and cancelling a requisition header?**
   Cancelling a requisition *line* means that only that specific item or service request is no longer needed. The rest of the requisition (other lines) can still proceed. Cancelling a requisition *header* means the entire requisition, including all its lines, is no longer valid or required.

**2. Does this report show the financial impact of cancelled requisitions?**
   While the report provides the original amounts of the cancelled lines, it primarily focuses on the operational aspect of cancellation. To understand the precise financial impact (e.g., impact on budget or commitment tracking), further analysis would be needed, potentially involving custom calculations on the exported data.

**3. Can I use this report to see if a cancelled requisition was ever converted into a Purchase Order?**
   This report specifically focuses on *cancelled requisitions*. If a requisition was converted into a PO *before* being cancelled, that PO would appear in a different set of reports (e.g., `PO Cancelled Purchase Orders`). The act of cancellation typically prevents further processing of the requisition itself.
