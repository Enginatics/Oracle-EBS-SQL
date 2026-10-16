# Case Study & Technical Analysis: PO Supplier Scheduling On-Time Delivery

## Executive Summary
The PO Supplier Scheduling On-Time Delivery report measures supplier on-time delivery against the Oracle Supplier Scheduling (CHV) module rather than against the purchase order form. For each firm scheduled release it compares the requested delivery date held in Supplier Scheduling with the first goods receipt date, and it reports the delivery delay, the ordered and received quantities, and a partial delivery flag. It is intended for environments in which the blanket purchase order holds only a skeleton with placeholder dates, and the real call-off dates arrive by EDI into Supplier Scheduling. Supplier quality and purchasing teams use it to score suppliers on delivery performance. The description labels the report a first-pass draft, and the report runs in Excel via Blitz Report.

## Business Challenge
*   **Placeholder dates on blankets:** Blanket purchase orders often carry skeleton promise dates, which makes standard on-time measures meaningless.
*   **Real call-off dates in Supplier Scheduling:** The dates that matter are the scheduled releases received by EDI, which sit in the Supplier Scheduling tables.
*   **Supplier scorecards:** Purchasing needs a consistent measure of how early or late each supplier delivers against its schedule.
*   **Partial deliveries:** Shipments that arrive in parts must be identified, because a single receipt can hide an incomplete delivery.

## The Solution
*   **Scheduling-based requested date:** The requested delivery date is the first scheduled date of each release in Supplier Scheduling, rather than the purchase order promise date.
*   **Receipt-based actual date:** The first goods receipt is the earliest receive transaction against the shipment.
*   **Delay and on-time flag:** The delivery delay is the difference in whole days between the two dates, and a delivery is on time when the delay is within the tolerance entered.
*   **Quantity and partial flag:** Ordered, received and open quantities are shown, and a partial delivery is flagged when some but not all of the quantity has been received.

## Technical Architecture (High Level)
### Primary Tables
*   `CHV_SCHEDULE_HEADERS`: the Supplier Scheduling header, with the schedule number, type and last EDI date.
*   `CHV_ITEM_ORDERS`: the scheduled items, with due dates and the document shipment link to the purchase order shipment.
*   `PO_LINE_LOCATIONS_ALL`: the purchase order shipments, with promise and need-by dates, quantities and terms.
*   `PO_LINES_ALL`, `PO_HEADERS_ALL`: the purchase order lines and headers.
*   `PO_VENDORS`, `PO_VENDOR_SITES_ALL`: the supplier and supplier site.
*   `RCV_TRANSACTIONS`: the receive transactions, used for the first and last goods receipt dates.
*   `RCV_SHIPMENT_HEADERS`, `RCV_SHIPMENT_LINES`: the shipment notices, used for the ASN date.
*   `MTL_SYSTEM_ITEMS_B_KFV`, `MTL_PARAMETERS`, `HR_LOCATIONS_ALL`, `HR_ALL_ORGANIZATION_UNITS_VL`: item, ship-to organization, location and operating unit.
*   `PER_ALL_PEOPLE_F`: the buyer, valid on the current date.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating unit access list for the session.

### Logical Relationships
1. `CHV_ITEM_ORDERS` is joined to `CHV_SCHEDULE_HEADERS` for release documents, and summarized per shipment and schedule number.
2. The summaries are aggregated per purchase order shipment, giving the first and last scheduled date, the list of schedule numbers and the last EDI date.
3. The aggregated schedule block is joined to `PO_LINE_LOCATIONS_ALL` on the line location identifier, then to `PO_LINES_ALL`, `PO_HEADERS_ALL`, `PO_VENDORS` and `PO_VENDOR_SITES_ALL`.
4. Receive transactions give the minimum and maximum transaction dates for each shipment, and ASN shipment headers give the ASN date.
5. Item and ship-to organization are taken from the purchase order line and shipment, and the operating unit is restricted by the access list.

## Parameters & Filtering
*   **Operating Unit:** Restricts the report to one operating unit within the accessible set.
*   **Supplier:** Restricts the output to one supplier.
*   **Requested Date From and To:** Restrict the scheduled delivery dates considered.
*   **Received Date From and To:** Restrict the goods receipt dates considered.
*   **On Time Tolerance Days:** The number of days a delivery can be late and still count as on time; when blank, zero is used.

## Performance & Optimization
*   Scheduled releases are summarized in nested inline views before the join to the purchase order, so each shipment is read once for its schedule.
*   Receipt and ASN lookups are correlated scalar subqueries on the shipment line location, so they run once for each returned shipment.
*   The operating unit restriction is an `IN` subquery on `MO_GLOB_ORG_ACCESS_TMP`.
*   The description notes that the report is a first-pass draft with open scoping items, so the performance profile should be checked against a production volume before scheduled use.

## FAQ
**Q: Why is the requested date not the purchase order promise date?**
A: The report is built for blanket orders whose promise dates are placeholders, so the requested date is the first scheduled date in Supplier Scheduling.

**Q: How is an on-time delivery determined?**
A: A delivery is on time when its first goods receipt is within the number of days in On Time Tolerance Days after the requested delivery date.

**Q: What does the partial delivery flag mean?**
A: It is set when some quantity has been received on the shipment but the received quantity is less than the ordered quantity.
