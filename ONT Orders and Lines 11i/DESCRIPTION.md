# Case Study & Technical Analysis: ONT Orders and Lines 11i

## Executive Summary
The ONT Orders and Lines 11i report is a detailed listing of Oracle Order Management sales orders and quotes, with the header, each line, its status, cost, project and shipping information. It can also show the sales credits of each line and the order-to-cash position of each line, from booking through invoice payment. Sales operations, order managers and finance teams use it to track backlog, delivery performance and the invoicing and collection of orders. It runs in Excel through Blitz Report, where rows can be summed by salesperson, warehouse or item.

## Business Challenge
*   **Backlog and status:** Open orders must be followed line by line, with the flow status, the schedule ship date and the open holds that block shipment.
*   **Delivery performance:** Deliver in full and on time measures need the ordered and shipped quantities of each line and the promise and actual shipment dates.
*   **Invoicing and collection:** An order is complete only when its invoice is paid, so the team needs the invoice, the amount still due and the receipt applied to each line.
*   **Sales credit:** Sales credits must be split by salesperson, with the credited amount of each line.

## The Solution
*   Lists each order header and line with the customer, ship-to and bill-to details, addresses, tax references and payment terms.
*   Shows the ordered, shipped, invoiced and cancelled quantities, the unit prices, discounts and freight charges, and the extended price of each line.
*   Shows the delivery, release status and next step of each shipped line, with the warehouse, carrier, shipping method and freight terms.
*   Adds the sales credit rows and the order-to-cash details, the booked date, open holds and invoice position, when the parameters for these are set.

## Technical Architecture (High Level)
### Primary Tables
*   `OE_ORDER_HEADERS_ALL` and `OE_ORDER_LINES_ALL`: the order header and line, with status, pricing, quantities and dates.
*   `OE_ORDER_LINES_HISTORY` and `OE_REASONS`: the cancellation history and the cancel reason of a line.
*   `OE_PRICE_ADJUSTMENTS`: the discounts and freight charges applied to a line.
*   `RA_CUSTOMER_TRX_ALL`, `RA_CUSTOMER_TRX_LINES_ALL` and `RA_CUST_TRX_LINE_GL_DIST_ALL`: the invoice an order line was interfaced to, its lines and accounting distributions.
*   `WSH_DELIVERY_DETAILS`, `WSH_DELIVERY_ASSIGNMENTS` and `WSH_NEW_DELIVERIES`: the shipping delivery of each line.
*   `HZ_CUST_ACCOUNTS`, `HZ_PARTIES`, `HZ_CUST_SITE_USES_ALL`, `HZ_CUST_ACCT_SITES_ALL`, `HZ_PARTY_SITES` and `HZ_LOCATIONS`: the customer and its addresses.
*   `MTL_SYSTEM_ITEMS_VL`, `PA_PROJECTS_ALL`, `PA_TASKS`, `JTF_RS_SALESREPS` and `JTF_RS_RESOURCE_EXTNS_VL`: the item, project, task and salesperson.

### Logical Relationships
1.  `OE_ORDER_HEADERS_ALL` is joined to `OE_ORDER_LINES_ALL` on the header id, and the lines are restricted to the operating units in `MO_GLOB_ORG_ACCESS_TMP`.
2.  Each line is linked to its invoice through the interface line attribute 6, which holds the order line id, on `RA_CUSTOMER_TRX_LINES_ALL`, then to the transaction header and type.
3.  Each line is linked to its delivery through `WSH_DELIVERY_DETAILS` on the source line id, with the assignment and new delivery joined from there.
4.  Ship-to and bill-to are reached through the site uses, account sites, party sites and locations of each address.
5.  Cancellation rows from `OE_ORDER_LINES_HISTORY` are joined to each line, and price adjustments are summed per line in inline views.

## Parameters & Filtering
*   **Operating Unit**, **Order Number**, **Quote Number**, **Customer Name** and **Account Number** select the orders by organization, document and customer.
*   **Type**, **Order Category**, **Line Category**, **Order Type** and **Line Type** select the document type and the category of the lines.
*   **Open only:** restricts the output to open lines. Leave it empty to follow closed orders with unpaid invoices.
*   **Order Status**, **Line Status** and **Exclude Line Status** filter the status of the header and lines.
*   **Item** and **Category Set 1** to **3** filter by item and item category.
*   **Schedule Ship Date**, **Request Date** and **Creation Date** ranges bound the dates.

## Performance & Optimization
*   The main query uses DISTINCT with push-predicate hints on the cancellation, delivery and line history joins, so the filters apply before the joins are processed.
*   Price adjustments are summed per line in inline views with a filter on the applied flag, so only applied discounts and charges are included.
*   Invoice data is taken with analytic functions over the interface line attribute, which returns the last invoice of each line without a second query.
*   Setting Operating Unit and Open only narrows the order population early. Leaving Open only empty reads closed orders as well, so it is best combined with a date range.

## FAQ
**Q: How do I see the sales credit of each salesperson on an order?**
A: Set Show Sales Credits. Each sales credit has its own row, with the credited amount equal to the line extended price times the credit percent, so the amounts can be summed by salesperson.

**Q: How do I track an order until its invoice is paid?**
A: Set Show Order to Cash Details and leave Open only empty. The report then includes closed orders with unpaid invoices, and shows the amount due, the payment date and the receipt applied.
