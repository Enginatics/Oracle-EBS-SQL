# Case Study & Technical Analysis: ONT Blanket Sales Agreements

## Executive Summary
The ONT Blanket Sales Agreements report lists the blanket sales agreements in Oracle Order Management, one row per agreement line. For each agreement it shows the minimum and maximum quantities and amounts, the amounts released, fulfilled and returned, and the remaining balance that Order Management checks new releases against. Sales administrators and customer account teams use it to see how much of each commitment has been drawn down and which agreements are close to their limit or end date. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Commitment tracking:** Customers buy against a negotiated blanket commitment, and the team must know what remains before new releases are entered.
*   **Limit breaches:** A release that exceeds the blanket limit is rejected, so the remaining balance must be visible before the order is taken.
*   **Expiry management:** Agreements near their end date, or on hold, need renewal or release before the commitment lapses.
*   **Commercial terms:** Price list, modifier list and salesperson of each agreement must be checked against the agreed terms.

## The Solution
*   **Agreement and line structure:** The blanket header joins to its lines and to the extension records holding the minimum, maximum, released, fulfilled and returned values.
*   **Remaining balance:** Remaining is the maximum plus the returned, less the released value, the same limit Order Management validates against.
*   **Release counting:** The number of sales orders with a non-cancelled line released against the agreement line is shown as Releases.
*   **Header amounts once:** Agreement level amounts appear only on the first line of each agreement, so they can be summed without double counting.

## Technical Architecture (High Level)
### Primary Tables
*   `OE_BLANKET_HEADERS_ALL` and `OE_BLANKET_HEADERS_EXT`: the agreement header and its amount and status extension.
*   `OE_BLANKET_LINES_ALL` and `OE_BLANKET_LINES_EXT`: the agreement lines and their quantity and amount extension.
*   `OE_ORDER_LINES_ALL`: the sales order lines that reference an agreement line, used for the release count.
*   `OE_TRANSACTION_TYPES_TL`: the agreement type name.
*   `QP_LIST_HEADERS_VL`: the price list and modifier list names.
*   `HZ_CUST_ACCOUNTS` and `HZ_PARTIES`: the customer account number and name.
*   `JTF_RS_SALESREPS` and `JTF_RS_RESOURCE_EXTNS_VL`: the salesperson name.
*   `MTL_SYSTEM_ITEMS_VL`: the item number and description.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units accessible to the current user.

### Logical Relationships
1.  `OE_BLANKET_HEADERS_ALL` joins to `OE_BLANKET_HEADERS_EXT` on the order number, and to `OE_BLANKET_LINES_ALL` on the header ID.
2.  Each agreement line joins to `OE_BLANKET_LINES_EXT` on the line ID, which supplies the quantity and amount balances.
3.  The header joins to the customer account and party, the salesperson resource and the agreement type name.
4.  The line joins to `MTL_SYSTEM_ITEMS_VL` on the inventory item, or on the item identifier for non-item lines.
5.  The release count is a correlated subquery on `OE_ORDER_LINES_ALL` matching the blanket number and line number, excluding cancelled lines.

## Parameters & Filtering
*   **Operating Unit:** limits the agreements to one organization within the accessible set.
*   **Agreement Number** and **Agreement Type:** select one agreement or one agreement type.
*   **Status:** filters on the flow status of the agreement.
*   **Customer Name** and **Account Number:** identify the customer.
*   **End Date From** and **End Date To:** bound the agreement end date.
*   **Expiring Within Days:** shows agreements whose end date falls within the given number of days.
*   **Open Only:** restricts the output to open agreements.

## Performance & Optimization
*   The operating unit restriction is an `IN` subquery on `MO_GLOB_ORG_ACCESS_TMP`, so agreement tables are read only for accessible organizations.
*   The release count is a scalar subquery keyed on the blanket number and line number, so order lines are not joined into the main row set.
*   Agreement-level amounts are computed with a `ROW_NUMBER` over the header, so each agreement contributes its totals once.
*   Item and customer joins are outer joins on primary identifiers, so agreements without an item or account are still returned.

## FAQ
**Q: How much of a blanket agreement is still available for release?**
A: The Remaining column for a line is the maximum quantity plus the returned quantity less the released quantity, and the amount equivalent is shown for the agreement.

**Q: Why are agreement amounts blank on some lines?**
A: Agreement level amounts are shown on the first line of each agreement only, so they are not counted more than once when summed.

**Q: How do I see the orders released against an agreement?**
A: Use ONT Orders and Lines with the Sales Agreement Number parameter, which lists the release order lines.
