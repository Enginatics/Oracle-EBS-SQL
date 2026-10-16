# Case Study & Technical Analysis: CS Service Requests

## Executive Summary
This report lists Oracle Service Requests with their customer, product, owner, status, severity and response and resolution timings, one row per request. It supports service managers and customer support leads who track whether requests are answered and resolved within the agreed obligation dates. Each request is flagged as overdue when its response or resolution fell after the respond-by or resolve-by date. A detail level adds the tasks or notes of each request. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Service level compliance:** Support organizations must show how many requests were answered and resolved by their obligation dates.
*   **Aging of open work:** Open requests need a clear count of days open and a view of which owner or group holds them.
*   **Product and customer context:** Escalations need the customer, the installed product, the serial number and the contract number on one line.
*   **Investigation of delays:** Managers need the tasks or notes of a late request to explain the delay.

## The Solution
*   **Timing measures:** Response and resolution hours are calculated from the reported date to the responded and resolved dates.
*   **Overdue flags:** Response overdue and resolution overdue are set when the responded or resolved date, or the close date, or the current date for an open request, is later than the obligation date.
*   **Days open:** Days open is measured from the reported date to the close date, or to the current date while the request is open.
*   **Ownership and contacts:** The owner, owner group, channel and primary contact are returned with each request.
*   **Detail level:** The tasks or notes of each request are added as separate rows, and private notes are shown only to the user who entered them.

## Technical Architecture (High Level)
### Primary Tables
*   `CS_INCIDENTS_B_SEC`: the service request header, with incident number, dates, obligation dates, owner and product.
*   `CS_INCIDENTS_ALL_TL`: the request summary and resolution summary, in the session language.
*   `CS_INCIDENT_TYPES_VL`, `CS_INCIDENT_STATUSES_VL` and `CS_INCIDENT_SEVERITIES_VL`: the request type, status and severity names.
*   `HZ_PARTIES` and `HZ_CUST_ACCOUNTS`: the customer party and account number.
*   `CS_HZ_SR_CONTACT_POINTS`: the primary contact of each request.
*   `CSI_ITEM_INSTANCES`: the installed product instance and its instance number.
*   `MTL_SYSTEM_ITEMS_VL`: the item and its description.
*   `JTF_RS_RESOURCE_EXTNS_VL` and `JTF_RS_GROUPS_VL`: the owner resource and owner group.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit.

### Logical Relationships
1. `CS_INCIDENTS_B_SEC` joins to `CS_INCIDENTS_ALL_TL` on incident id, restricted to the session language.
2. `CS_INCIDENTS_B_SEC` joins to the request type and status views on their identifiers, and to `HZ_PARTIES` on the customer id as an outer join.
3. The primary contact is taken from the contact point rows flagged as primary, joined on incident id, and resolved to an employee, a relationship person or a party name.
4. The item is joined on inventory item id and inventory organization id as an outer join.
5. The owner and owner group are looked up on the owner id and owner group id from the resource views.

## Parameters & Filtering
*   **Operating Unit:** restricts the requests to one operating unit.
*   **Reported Date From / Reported Date To:** bound the requests by the date they were reported.
*   **Request Number, Request Type, Status, Severity:** select one request or narrow the list by classification.
*   **Open Only:** limits the report to requests that are not yet closed.
*   **Customer Name, Owner Group, Owner, Item and Serial Number:** narrow the requests to a customer, team, person, product or unit.
*   **Detail Level:** adds the tasks or notes of each request, one row per task or note.

## Performance & Optimization
*   The date window on reported date is applied first, so the main request scan is limited to the chosen period.
*   Most descriptive values are scalar subqueries keyed on a single id, which keeps the main query a single pass over the request header.
*   The language filter on the translated summary table prevents duplicate rows from other installed languages.

## FAQ
**Q: How is an overdue service request identified?**
A: A request is overdue when its responded or resolved date, or the close date, is later than its respond-by or resolve-by date. An open request uses the current date.

**Q: How do I see the tasks and notes of a service request?**
A: Set Detail Level to include the detail. Each task or note appears on its own row, and private notes are visible only to the user who entered them.

**Q: Why are response hours blank for some requests?**
A: Response hours need a responded date. Requests without one show no response hours.
