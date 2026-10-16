# Case Study & Technical Analysis: PO Vendor Service Performance Analysis

## Executive Summary
This report measures how well suppliers meet the promised delivery dates of their purchase order shipments. For each open or received purchase order shipment it compares the quantities received early, on time and late against the promised date, with the receipt window allowed on the shipment, and shows the quantities past due and received at the wrong location. Procurement managers and buyers use it to rate supplier delivery performance and to decide where to escalate. The report is imported from the Oracle Purchasing BI Publisher report POXSERPRXML and is run in Excel through Blitz Report™.

## Business Challenge
*   **Supplier rating:** Procurement needs an objective on-time delivery measure per supplier and item, based on receipt history.
*   **Receipt windows:** Each shipment allows a number of days early and late for receipt, and the window determines whether a receipt counts as on time.
*   **Past-due exposure:** Shipments that are not fully received after their late window has closed need to be found and chased.
*   **Receiving accuracy:** Goods received at a location other than the shipment's ship-to location are a receiving quality issue that the buyer must see.

## The Solution
*   Lists each standard, blanket or scheduled shipment that has a receipt, with the supplier, item, purchase order number, shipment number and buyer.
*   Shows the promised date, the early and late receipt cut-off dates derived from the allowed windows, and the quantities ordered, received, rejected and open.
*   Splits received quantity into early, on-time, late and wrong-location quantities, in units and percentages.
*   Reports the days early and days late, weighted by the quantity received, so that the timeliness of each shipment can be compared.

## Technical Architecture (High Level)
### Primary Tables
*   `PO_HEADERS_ALL`: the purchase order header, with its type and agent.
*   `PO_RELEASES_ALL`: the blanket release, which supplies the release number of a release shipment.
*   `PO_LINES_ALL`: the purchase order line, with the item, description and order type.
*   `PO_LINE_LOCATIONS_ALL`: the shipments, with the promised and need-by dates, the receipt windows, quantities, cancellation and ship-to location.
*   `RCV_TRANSACTIONS` and `RCV_SHIPMENT_LINES`: the receipts, with their date, unit of measure, conversion and quantity received.
*   `AP_SUPPLIERS`: the supplier name and number.
*   `MTL_SYSTEM_ITEMS_VL` and `MTL_CATEGORIES_B_KFV`: the item and the purchasing category.
*   `GL_SETS_OF_BOOKS`, `FINANCIALS_SYSTEM_PARAMS_ALL` and `HR_OPERATING_UNITS`: the set of books, the inventory organization and the operating unit.
*   `PER_ALL_PEOPLE_F` and `HR_LOCATIONS_ALL`: the buyer and the ship-to location.
*   `MO_GLOB_ORG_ACCESS_TMP` and `DUAL`: the operating units accessible to the user.

### Logical Relationships
1.  Each purchase order header joins to its supplier, operating unit and financial system parameters.
2.  Each shipment is joined to its order line, its header, and its release where it is a release shipment, and the line's category is taken from the purchasing category.
3.  The early receipt date is the promised or need-by date less the allowed early days, and the late cut-off is that date plus the allowed late days, each capped at 3,650 days.
4.  Each receipt quantity is taken from the receipts of the shipment with transaction type RECEIVE, converted to the primary unit of measure.
5.  Early, on-time and late quantities and days are computed against the two cut-off dates.
6.  The shipment is included only when it has at least one receipt, and results are ordered by supplier, item, purchase order number and shipment number.

## Parameters & Filtering
*   **Operating Unit:** restricts the purchase orders to one operating unit.
*   **Vendor** and **Buyer:** select the supplier and the buyer.
*   **Creation Date From** and **To:** restrict the purchase orders by creation date.
*   **Item:** selects one item.
*   **Category From** and **To:** restrict the purchasing categories.
*   **Quantity Precision:** sets the number of decimal places used in every quantity and percentage.

## Performance & Optimization
*   Most measures are correlated subqueries on the shipment's receipts, so run time grows with receipt volume.
*   The percentages repeat the receipt aggregation, so narrowing the selection by supplier, operating unit and creation date is the main lever.
*   The operating unit restriction uses the list of accessible operating units, which limits the purchase orders that are measured.
*   The supplier, buyer and item parameters reduce the shipments that the receipt subqueries are evaluated for.

## FAQ
**Q: How is an on-time receipt defined in this report?**
A: A receipt is on time when its transaction date falls between the promised or need-by date less the allowed early receipt days and the same date plus the allowed late receipt days.

**Q: Why are early and late receipts expressed as quantities and days?**
A: The report gives both the quantity and the quantity-weighted days, so the size and the timeliness of the deviation are both visible.

**Q: Which shipments are included?**
A: Only standard, blanket and scheduled shipments that are not cancelled, with a promised or need-by date and at least one receipt, are included.
