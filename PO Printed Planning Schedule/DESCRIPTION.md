# Case Study & Technical Analysis: PO Printed Planning Schedule

## Executive Summary
The PO Printed Planning Schedule report reproduces the time-phased demand schedule that Oracle Purchasing sends to a supplier under Supplier Scheduling. It is a migration of the standard concurrent program Printed Planning Schedule (XML). Each row is one bucket of one item on one confirmed planning or shipping schedule, with the forecast, released, total and cumulative (CUM) quantities of that bucket. Buyers and supplier planners use it to check the demand that was communicated to a supplier, to compare the released quantity with the forecast, and to analyze the schedule in Excel rather than in the printed XML document. The report runs through Blitz Report.

## Business Challenge
*   **Supplier demand visibility:** Buyers need to see what was sent to each supplier, by item and time bucket, without opening the printed schedule for each supplier site.
*   **Forecast against release:** Supplier planners must compare the forecast and released quantities by bucket to see where the release has diverged from the plan.
*   **Cumulative tracking:** Where cumulative quantity control applies, the CUM quantity, starting CUM and last receipt must be checked against the bucket quantities.
*   **Authorization control:** The authorizations issued against each schedule item must be visible to confirm the commitment given to the supplier.

## The Solution
*   **Schedule header and item context:** Each schedule carries its number, type, subtype, status, revision, horizon, MRP, MPS and DRP plan designators, supplier and supplier site.
*   **Bucket un-pivoting:** The horizontal schedule grid, which stores up to sixty bucket columns per row type, is un-pivoted into one row per bucket using a row generator.
*   **CUM context:** The CUM period, starting cumulative quantity, enable CUM flag and last receipt number and quantity are shown beside each item.
*   **Authorizations:** Up to four authorizations per schedule item are shown with their type and schedule quantity.

## Technical Architecture (High Level)
### Primary Tables
*   `CHV_SCHEDULE_HEADERS`: the schedule header, with number, type, status, horizon, plan designators, vendor and site.
*   `CHV_SCHEDULE_ITEMS`: the item on the schedule, with its purchasing unit of measure, CUM quantity, last receipt and purchase order.
*   `CHV_HORIZONTAL_SCHEDULES`: the horizontal schedule grid, with one row per row type and schedule item, holding up to sixty bucket cells.
*   `CHV_BUCKET_PATTERNS`: the bucket pattern name of the schedule.
*   `CHV_AUTHORIZATIONS`: the authorization type and quantity of each schedule item.
*   `CHV_CUM_PERIODS`: the CUM period of the organization.
*   `CHV_ORG_OPTIONS`: the CUM enablement flag of the organization.
*   `PO_VENDORS` and `PO_VENDOR_SITES_ALL`: the supplier and supplier site.
*   `PO_HEADERS_ALL`: the supply agreement number.
*   `PO_ASL_ATTRIBUTES`: the approved supplier list attributes, used to find the scheduler.
*   `RCV_TRANSACTIONS` and `RCV_SHIPMENT_HEADERS`: the last receipt and shipment number.
*   `MTL_SYSTEM_ITEMS_B_KFV`: the item, its description and buyer.
*   `PER_ALL_PEOPLE_F`: the buyer and scheduler names.
*   `ORG_ORGANIZATION_DEFINITIONS`: the organization code.

### Logical Relationships
1.  `CHV_HORIZONTAL_SCHEDULES` is joined to a row generator of sixty positions, and each position selects the matching cell from the bucket columns by bucket sequence.
2.  The cells are grouped by schedule, schedule item and bucket sequence, so each bucket has one value per row type, and buckets without a descriptor are dropped.
3.  The bucket rows join to `CHV_SCHEDULE_ITEMS` and then to `CHV_SCHEDULE_HEADERS`, which joins to the bucket pattern, the vendor and the vendor site.
4.  `CHV_SCHEDULE_ITEMS` joins to the item, the organization, the CUM options and the supply agreement.
5.  Output is ordered by schedule number, item and bucket sequence.

## Parameters & Filtering
*   **Organization:** selects the organization that issued the schedule.
*   **Supplier** and **Supplier Site:** select the supplier and the site that received it.
*   **Schedule Type:** selects planning or shipping schedules.
*   **Schedule Number:** selects one schedule.
*   **Schedule Status:** restricts the output to schedules in one status.
*   **Horizon From** and **Horizon To:** bound the schedule horizon.
*   **Exclude Zero Quantity Buckets:** when set, buckets with no quantity are removed from the output.

## Performance & Optimization
*   The bucket un-pivot uses a row generator, so the sixty bucket columns are read once and folded into rows without a union of sixty queries.
*   Buckets without a descriptor are removed by a `HAVING` filter in the grouped inline view, so empty columns do not reach the main query.
*   Authorizations and the last receipt are scalar subqueries keyed on the schedule item, each restricted by sequence or ID.
*   Purged items are excluded, and the organization restriction is applied through `ORG_ACCESS_VIEW`, with a fallback that returns all rows when the responsibility has no org access rows.

## FAQ
**Q: What do the forecast, released, total and CUM columns show?**
A: For each bucket they show the forecast quantity, the released quantity, the total quantity and the cumulative quantity sent to the supplier.

**Q: Why are there several authorization columns?**
A: The schedule item can carry up to four authorizations, and the report shows the type and schedule quantity of each one in its own column pair.

**Q: How do I see only the buckets that carry demand?**
A: Set Exclude Zero Quantity Buckets to remove buckets with no quantity.
