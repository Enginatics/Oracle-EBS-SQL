# Case Study & Technical Analysis: ONT Audit History

## Executive Summary
This report is the Order Management audit history. It lists every recorded change to order lines, sales credits and price adjustments, with the entity and attribute that changed, the old and new values, the change reason and comments, and the user and responsibility that made the change. It is based on Oracle's standard Audit History Report (OEXAUDHRXML). Order management supervisors, revenue assurance teams and auditors use it to answer questions such as who changed a price, when a requested date was moved, or why a line was cancelled. It can be run for an operating unit and a date range, or narrowed to a range of order numbers.

## Business Challenge
*   **Explaining order changes:** Customers and internal teams ask why an order changed after it was booked, and the answer must come from a record of the change.
*   **Pricing control:** Manual price adjustments and changes to the price of a line must be visible to the people who review discounts.
*   **Accountability:** The user and responsibility behind each change must be recorded, so that sensitive changes can be traced.
*   **Audit evidence:** Internal and external auditors need a complete history of changes for a period, grouped by operating unit.

## The Solution
*   Reads the audit history view for the operating units the user can access, and shows the operating unit and order number of each change.
*   Identifies the order line for each change, including its line, shipment, option, component and service numbers, even when the change was made to a sales credit or a price adjustment.
*   Shows the entity and attribute display names, the old and new display values, the reason, the comments and the history date.
*   Shows the user name and responsibility that made each change, so changes can be attributed.
*   Orders the output by history date, newest first, and then by entity.

## Technical Architecture (High Level)
### Primary Tables
*   `OE_AUDIT_ATTR_DESC_V`: the Order Management audit history, with the entity, attribute, old and new display values, reason, user, responsibility and history date.
*   `OE_ORDER_LINES_ALL`: the order line, with its line, shipment, option, component and service numbers.
*   `OE_SALES_CREDITS`: the sales credit records, which link to the order line.
*   `OE_PRICE_ADJUSTMENTS`: the price adjustments, which link to the order line.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit name.
*   `MO_GLOB_ORG_ACCESS_TMP` and `DUAL`: the operating unit access list, extended with the current org for release 11.

### Logical Relationships
1. `OE_AUDIT_ATTR_DESC_V` is joined to the operating unit on the organization identifier.
2. The operating unit is restricted to those the user can access through `MO_GLOB_ORG_ACCESS_TMP`.
3. For an audit row whose entity is an order line, the line is the entity number itself.
4. For a sales credit, the order line is found from the sales credit record, and for a price adjustment from the price adjustment record.
5. The order line's line, shipment, option, component and service numbers are combined into one dotted line number.

## Parameters & Filtering
*   **Operating Unit:** limits the history to one operating unit.
*   **History Date From** and **History Date To:** bound the date of the change.
*   **Entity** and **Attribute:** select the kind of record and the field that changed.
*   **Order Number From** and **Order Number To:** limit the history to a range of orders.
*   **User Name** and **Responsibility:** show the changes made by one user or through one responsibility.

## Performance & Optimization
*   The history is restricted to the operating units the user can access before the audit rows are read.
*   The line number lookup is a correlated subquery that runs only for the entities that refer to order lines, and it is limited to one row.
*   The order by history date, newest first, is applied after the filters, so the most recent changes appear first.
*   The date and entity parameters should be set for large histories, since the audit table grows with every change.

## FAQ
**Q: How do I see who changed the price of an order line?**
A: Run the report with the Entity set to the order line or price adjustment and the Attribute set to the price field, for the order number and date range in question. The User Name and Responsibility columns show who made the change.

**Q: What does a dotted line number such as 1.1.2 mean?**
A: It is the line number, followed by the shipment, option and component or service numbers of the order line. Each part is shown only when it is present on the line.

**Q: Can I see the reason for a change?**
A: Yes. The Reason and Comments columns show the reason and comments that were recorded with the change.
