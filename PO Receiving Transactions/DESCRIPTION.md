# Case Study & Technical Analysis: PO Receiving Transactions

## Executive Summary
PO Receiving Transactions is a register of Oracle Purchasing receiving activity, with one row for each receiving transaction. It covers receipts, acceptances, rejections, transfers, deliveries, returns to supplier or receiving, and corrections, for purchase orders, internal requisitions, RMA returns and inter-organization shipments. Receiving supervisors, inventory accountants and procurement analysts use it to trace what was received against each purchase order line, to find material that has been sitting in receiving too long, and to reconcile receipts with the purchase price.

## Business Challenge
*   **Receipt Traceability:** A supplier invoice cannot be matched until the receipt is confirmed, so the team needs to trace each receipt to its source document.
*   **Material In Receiving:** Goods left in the receiving area for long periods tie up stock and can be missed by planning.
*   **Price Exposure:** Receipt value at the PO price must be known for accrual and matching.
*   **Lot and Serial Visibility:** Controlled items need their lot and serial numbers shown against each receiving transaction.

## The Solution
*   **Transaction Register:** Each receiving transaction is listed with its type, parent transaction, source document, supplier, item, quantity and destination.
*   **Current Receiving Position:** For receive, accept, reject or transfer transactions whose quantity is still in receiving, the quantity in receiving and the days in receiving are shown.
*   **Value At PO Price:** The amount is the quantity multiplied by the PO unit price, and is blank where no PO price exists.
*   **Optional Lot and Serial Detail:** Lot and serial transactions can be included, so each controlled unit appears with its number and expiration date.

## Technical Architecture (High Level)
### Primary Tables
*   `RCV_TRANSACTIONS`: the receiving transactions, with type, source document, quantities, PO price, destination and dates.
*   `RCV_SHIPMENT_HEADERS` and `RCV_SHIPMENT_LINES`: the receipt headers and lines, with receipt number, source and item.
*   `RCV_SUPPLY`: the material currently held in receiving.
*   `RCV_LOT_TRANSACTIONS` and `RCV_SERIAL_TRANSACTIONS`: the lot and serial detail of each transaction.
*   `PO_HEADERS_ALL`, `PO_LINES_ALL`, `PO_LINE_LOCATIONS_ALL` and `PO_RELEASES_ALL`: the purchase order, line, shipment and release records.
*   `PO_REQUISITION_HEADERS_ALL` and `PO_REQUISITION_LINES_ALL`: the internal requisition sources.
*   `OE_ORDER_HEADERS_ALL` and `OE_ORDER_LINES_ALL`: the RMA sources.
*   `AP_SUPPLIERS` and `AP_SUPPLIER_SITES_ALL`: the supplier and supplier site.
*   `MTL_SYSTEM_ITEMS_VL`, `MTL_PARAMETERS`, `MTL_ITEM_LOCATIONS_KFV` and `MTL_TRANSACTION_REASONS`: the item, organization, locator and reason.
*   `HR_OPERATING_UNITS`, `HR_ORGANIZATION_INFORMATION`, `HR_LOCATIONS_ALL` and `PER_ALL_PEOPLE_F`: the operating unit, the locations and the people.
*   `HZ_CUST_ACCOUNTS` and `HZ_PARTIES`: the customer for RMA sources.
*   `ORG_ACCESS_VIEW`: the organizations the user can access.

### Logical Relationships
1.  Each receiving transaction in `RCV_TRANSACTIONS` is joined to its organization in `MTL_PARAMETERS` and to the accounting organization information in `HR_ORGANIZATION_INFORMATION`.
2.  Transactions are joined to their shipment header and line in `RCV_SHIPMENT_HEADERS` and `RCV_SHIPMENT_LINES`.
3.  Purchase order and shipment references are outer joined to `PO_HEADERS_ALL` and `PO_LINE_LOCATIONS_ALL`.
4.  Supplier and item references are outer joined to `AP_SUPPLIERS` and `MTL_SYSTEM_ITEMS_VL`.
5.  Each transaction is outer joined to `RCV_SUPPLY` for the quantity still in receiving.
6.  Lot and serial transactions are unioned into a single inline view and joined on the transaction identifier when the lot and serial option is set.

## Parameters & Filtering
*   **Operating Unit and Organization Code:** Restrict the transactions to an operating unit or an organization.
*   **Transaction Date From and Transaction Date To:** Limit the transactions to a date window.
*   **Transaction Type and Source Document:** Restrict the output to one receiving transaction type or one source.
*   **Receipt Number, PO Number, Supplier and Item:** Select the receipt, the purchase order, the supplier or the item.
*   **Routing:** Restricts the output to one receiving routing.
*   **In Receiving Only:** Limits the output to transactions whose quantity is still in receiving.
*   **Show Lot and Serial:** Adds lot and serial rows to the output.

## Performance & Optimization
*   **Organization Access Filter:** Transactions are restricted to organizations the responsibility can access before the detail joins are evaluated.
*   **Lot and Serial Branch Switch:** The lot and serial inline view contains a switch that makes it empty when the option is not set, so no lot data is read by default.
*   **Outer Joins For Optional Sources:** Purchase order, requisition, RMA and inventory sources are optional, so outer joins avoid dropping transactions from other sources.
*   **Keep Dense Rank for People:** Names of people are fetched with keep-dense-rank aggregates that return the latest name for each person.

## FAQ
**Q: How do I find receipts that have been in receiving for more than a week?**
A: Set In Receiving Only to Yes and review the Days In Receiving column. The value counts from the receipt date.

**Q: Why is the Amount column blank on some rows?**
A: The amount is quantity times the PO unit price, so it is blank for sources that have no PO price, such as some inventory transfers.

**Q: Can I see the lot and serial numbers of a receipt?**
A: Set Show Lot and Serial to Yes. Each controlled lot or serial unit is then listed against its receiving transaction.
