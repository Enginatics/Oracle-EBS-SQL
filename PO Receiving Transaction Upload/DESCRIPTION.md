# Case Study & Technical Analysis: PO Receiving Transaction Upload

## Executive Summary
The PO Receiving Transaction Upload creates receiving transactions, or receipts, against approved standard, blanket and scheduled purchase orders in Oracle Purchasing and Receiving. The download lists the open purchase order shipment lines that still have quantity to receive in the selected receiving organization, and the user enters the quantity and transaction date for each line to receive. Receiving clerks and warehouse supervisors use it to record deliveries in bulk, for example when a supplier delivers many lines on one day or when receipts are captured from a paper delivery log. The report runs in Excel via Blitz Report.

## Business Challenge
*   **High receipt volume:** Receiving a large delivery line by line in the Receiving form is slow and creates a backlog in the receiving system.
*   **Open quantity visibility:** Receivers need to see the quantity ordered, received and remaining for each shipment before entering a receipt.
*   **Destination control:** Each receipt must go to the correct destination type, subinventory, locator and deliver-to location as defined on the purchase order distribution.
*   **Trade and lot information:** Country of origin and vendor lot numbers are needed for trade compliance and lot traceability at receipt.

## The Solution
*   **Open shipment download:** The download returns shipments that are approved, not cancelled or closed, and still have quantity remaining to receive.
*   **Pre-filled defaults:** Destination type, subinventory and deliver-to location are taken from the purchase order distribution, and can be overridden on the row.
*   **Quantity remaining:** Quantity ordered, quantity received and quantity remaining are shown beside the receipt entry columns.
*   **Trade fields:** Country of origin and vendor lot number columns are included for receipts that require them.

## Technical Architecture (High Level)
### Primary Tables
*   `PO_HEADERS_ALL`: the purchase order header, with the document number, supplier and supplier site.
*   `PO_LINES_ALL`: the purchase order lines, with line number, item revision, description and unit of measure.
*   `PO_LINE_LOCATIONS_ALL`: the shipments, with ship-to organization, quantities, approval, cancel and closed codes, and country of origin.
*   `PO_DISTRIBUTIONS_ALL`: the distributions of each shipment, with destination type, subinventory and deliver-to location.
*   `AP_SUPPLIERS`, `AP_SUPPLIER_SITES_ALL`: the supplier name and site code.
*   `MTL_PARAMETERS`: the receiving inventory organization.
*   `MTL_SYSTEM_ITEMS_B_KFV`: the item for the shipment's ship-to organization.
*   `HR_LOCATIONS_ALL`, `FND_TERRITORIES_VL`: the deliver-to location and the country of origin name.

### Logical Relationships
1. `PO_HEADERS_ALL` is joined to `PO_LINES_ALL` on the purchase order identifier, and `PO_LINES_ALL` to `PO_LINE_LOCATIONS_ALL` on the line identifier.
2. `PO_HEADERS_ALL` is joined to `AP_SUPPLIERS` on vendor, and outer joined to `AP_SUPPLIER_SITES_ALL` on vendor site.
3. `PO_LINE_LOCATIONS_ALL` is joined to `MTL_PARAMETERS` on the ship-to organization.
4. `PO_LINES_ALL` is outer joined to `MTL_SYSTEM_ITEMS_B_KFV` on item and organization.
5. Destination type, subinventory and deliver-to location are scalar subqueries on `PO_DISTRIBUTIONS_ALL` for the shipment, with the first distribution returned.

## Parameters & Filtering
*   **Upload Mode:** Create opens an empty spreadsheet for manually entered receipts; Create, Update downloads the open shipment lines for editing.
*   **Organization:** Restricts the download to the selected receiving inventory organization.
*   **PO Number:** Restricts the download to one purchase order.

The description states the prerequisites for a receipt: the purchase order must be approved and not cancelled or closed, the shipment must have remaining quantity, and the transaction date must be in an open receiving period.

## Performance & Optimization
*   The download predicates filter on shipment type, approval, cancellation, closed status and remaining quantity in the main query, so closed or fully received lines are not read.
*   The destination lookups are scalar subqueries that return the first distribution, so each shipment yields one value per column.
*   Supplier site and item joins are outer joins on keyed identifiers, so they do not change the number of shipment rows.
*   The query uses no aggregation or analytic functions.

## FAQ
**Q: Why is a purchase order line missing from the download?**
A: A line is only downloaded when its shipment is approved, not cancelled or closed, and has quantity remaining to receive, so fully received or closed lines are excluded.

**Q: Where do the destination type and subinventory come from?**
A: They are taken from the purchase order distribution of the shipment, and they can be overridden on the row before upload.

**Q: What is required for a receipt to be accepted?**
A: The quantity must be greater than zero, and the transaction date must fall in an open inventory receiving period.
