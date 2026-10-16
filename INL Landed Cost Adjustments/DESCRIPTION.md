# Case Study & Technical Analysis: INL Landed Cost Adjustments

## Executive Summary
The INL Landed Cost Adjustments report lists the landed cost adjustments that Oracle Cost Management has processed for receipts, together with the receiving accounting that each adjustment generated. It has one row per accounting line of each adjustment. Cost accountants use it to see how a change in landed cost, such as a late freight or duty invoice, changed the value of received inventory, and to confirm which accounts were debited and credited. It supports the Landed Cost Management reconciliation of receiving accruals and inventory value. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Inventory valuation:** When landed costs change after receipt, the value of the received inventory changes, and the accountant must show by how much and in which accounts.
*   **Receiving accounting:** Each adjustment creates receiving accounting lines that must be traced to the receipt, the shipment and the purchase order.
*   **Standard cost variances:** In a standard cost organization, the delivered portion of the adjustment must be booked to purchase price variance, not to inventory.
*   **Pending adjustments:** Adjustments still pending or in error in the interface must be found separately, as they have no accounting yet.

## The Solution
*   Lists each landed cost adjustment with its transaction date, item, receipt number, receipt quantity and unit of measure.
*   Shows the prior and new unit landed cost, the unit change, and the adjustment value, which is the unit change multiplied by the receipt quantity.
*   Shows the receiving accounting event type, the accounting date, the period, the accounting line type and the account with its description.
*   Shows the debit, credit and net accounted amounts of each line, so the lines can be summed by account.

## Technical Architecture (High Level)
### Primary Tables
*   `CST_LC_ADJ_TRANSACTIONS`: the landed cost adjustment, with its prior and new landed cost, transaction date and organization.
*   `RCV_TRANSACTIONS` and `RCV_SHIPMENT_HEADERS`: the receipt transaction and its shipment header.
*   `INL_SHIP_LINES_ALL` and `INL_SHIP_HEADERS_ALL`: the Landed Cost Management shipment line and header.
*   `PO_LINES_ALL` and `PO_HEADERS_ALL`: the purchase order line and header of the receipt.
*   `RCV_ACCOUNTING_EVENTS` and `RCV_RECEIVING_SUB_LEDGER`: the receiving accounting events and their sub-ledger lines.
*   `RCV_ACCOUNTING_EVENT_TYPES` and `XLA_EVENT_TYPES_VL`: the receiving event type names.
*   `GL_CODE_COMBINATIONS_KFV`, `GL_LEDGERS`, `MTL_PARAMETERS`, `ORG_ORGANIZATION_DEFINITIONS` and `HR_ALL_ORGANIZATION_UNITS_VL`: the account, ledger, organization and operating unit.
*   `ORG_ACCESS_VIEW`: the organizations that the responsibility can access.

### Logical Relationships
1.  `CST_LC_ADJ_TRANSACTIONS` is joined to `RCV_TRANSACTIONS` on the receipt transaction id, and the receipt is joined to its shipment header and to the purchase order.
2.  The Landed Cost Management shipment line and header are outer joined from the receipt through the LCM shipment line id.
3.  `CST_LC_ADJ_TRANSACTIONS` is joined to `RCV_ACCOUNTING_EVENTS` where the event source is LC_ADJUSTMENTS and the source id is the adjustment transaction id.
4.  Each accounting event is joined to `RCV_RECEIVING_SUB_LEDGER`, which holds the accounting lines, and each line to its account in `GL_CODE_COMBINATIONS_KFV`.
5.  The operating unit comes from the organization's set of books through `ORG_ORGANIZATION_DEFINITIONS` and `GL_LEDGERS`.

## Parameters & Filtering
*   **Operating Unit** and **Organization Code:** restrict the adjustments to one operating unit or inventory organization.
*   **Transaction Date From** and **Transaction Date To:** bound the transaction dates of the adjustments.
*   **Shipment Number**, **PO Number** and **Item:** select the adjustments of one shipment, purchase order or item.

## Performance & Optimization
*   The organization restriction is a subquery on `ORG_ACCESS_VIEW`, so the adjustments read are limited to the responsibility's organizations.
*   The adjustment value is calculated with an analytic ROW_NUMBER over the transaction, so it is shown once per adjustment and can be summed without repetition.
*   The outer joins to the LCM shipment tables are used only where a receipt has a landed cost shipment, so receipts without one are not dropped.
*   Filtering by Organization Code and Transaction Date limits the adjustment rows before the accounting joins, which is the largest part of the query.

## FAQ
**Q: How do I see the value that a landed cost adjustment added to a receipt?**
A: Sum the Adjustment Value column. It is shown on the first accounting row of each adjustment only, so the total is not multiplied by the number of accounting lines.

**Q: Why are some adjustments not listed?**
A: Adjustments that are still pending or in error in the interface have no receiving accounting yet. They are listed in the CAC Interface Error Summary report, as the description states.

**Q: Which account receives the adjustment in a standard cost organization?**
A: For delivered quantities the adjustment goes to Purchase Price Variance. Otherwise, the account is the inventory or expense account of the receiving accounting line.
