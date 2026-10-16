# Case Study & Technical Analysis: PO Receipts/Deliveries Discrepancy

## Executive Summary
The PO Receipts/Deliveries Discrepancy report finds purchase order lines and releases where the quantity and cost received into receiving differ from the quantity and cost delivered to the final destination. It is written for receiving managers, inventory accountants and purchasing teams who must clear the in-transit and receiving balances that build up when goods are received but not delivered, or delivered without a matching receipt. ## Business Challenge
*   **Goods received but not delivered:** Material accepted into receiving but never delivered to its destination leaves a balance that inflates inventory and accruals.
*   **Corrections obscure the position:** Receipt and delivery corrections change the quantities after the original transactions, so the true position must net them.
*   **Cost variance from purchase price:** Received and delivered value must be compared at the purchase price of each transaction, so that price differences are visible.

## The Solution
*   **Net outstanding position:** For each line, all receiving transactions to date are netted, so the variance reflects the current outstanding position rather than only the activity in the chosen window.
*   **Original and corrected quantities:** Receipt and delivery quantities are shown as recorded, alongside the net correction impact, and the corrected totals are then shown.
*   **Variance columns:** Quantity variance and cost variance compare the corrected totals, with amounts valued at each receiving transaction's purchase price.

## Technical Architecture (High Level)
### Primary Tables
*   `RCV_TRANSACTIONS`: the receiving transactions of type RECEIVE, DELIVER, CORRECT, RETURN TO VENDOR and RETURN TO RECEIVING, the core of the report.
*   `RCV_SHIPMENT_HEADERS`: the shipment headers that carry the receipt number.
*   `PO_HEADERS_ALL`, `PO_LINES_ALL` and `PO_RELEASES_ALL`: the purchase order header, line and release.
*   `PO_LINE_LOCATIONS_ALL`: the shipments, used for the quantity requested.
*   `AP_SUPPLIERS` and `AP_SUPPLIER_SITES_ALL`: the supplier and supplier site.
*   `MTL_SYSTEM_ITEMS_VL`: the item and item description.
*   `HR_OPERATING_UNITS`: the operating unit.
*   `ORG_ACCESS_VIEW` and `MO_GLOB_ORG_ACCESS_TMP`: the organisations accessible to the current user.

### Logical Relationships
1. A distinct list of purchase order lines and organisations with a RECEIVE transaction forms the driving set, and receiving transactions are joined to it on line and organisation.
2. Each correction transaction is joined to its parent transaction through `PARENT_TRANSACTION_ID`, so the correction can be classed as a receipt or delivery correction.
3. Receiving transactions join to `RCV_SHIPMENT_HEADERS` for the receipt number, and to `PO_HEADERS_ALL`, `PO_RELEASES_ALL` and `PO_LINES_ALL` for the purchase order.
4. Transactions join to the supplier through the purchase order header and to the supplier site as an outer join.
5. Items join to `MTL_SYSTEM_ITEMS_VL` on the item and organisation, as an outer join.
6. The result is grouped to one row per operating unit, organisation, purchase order, release and line, and then wrapped in an outer query that returns the final columns.

## Parameters & Filtering
*   **Operating Unit and Organization Code:** Restrict the output to one operating unit or inventory organisation.
*   **Supplier and PO Number:** Restrict the lines to one supplier or purchase order.
*   **Item:** Restricts the lines to one item.
*   **Last Receipt Date From and Last Receipt Date To:** Required. They select the lines that had a receipt within the range, while all receiving transactions of those lines are still netted.
*   **Discrepancies Only:** When Yes, the default, only lines with a non-zero quantity or cost variance are shown. When No, all receiving activity for the selected lines is listed.

## Performance & Optimization
*   **Driving line set:** A distinct list of lines with receipts forms the driving set, so the transaction table is read only for lines that have been received.
*   **Single aggregation pass:** Quantities and amounts for each transaction type are computed with conditional aggregation in one `group by`, rather than in separate subqueries.
*   **Range requirement:** The required receipt date range is the main control on the size of the result, and the description recommends narrowing it, with a purchase order, supplier or item filter, for large organisations.

## FAQ
**Q: How do I find purchase order lines where received and delivered quantities do not match in Oracle Purchasing?**
A: Run PO Receipts/Deliveries Discrepancy with a last receipt date range and read the quantity variance and cost variance columns, which are non-zero for discrepancies.

**Q: Why does the variance not include returns to vendor?**
A: Returns to vendor and returns to receiving are shown for reference, and the description states that they are not netted into the variance columns.

**Q: Why are older receipts included when I enter a narrow date range?**
A: The date range selects the lines that had a receipt within it, but all receiving transactions of those lines are netted to date, so the variance is the current outstanding position.
