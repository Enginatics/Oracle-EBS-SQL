# Case Study & Technical Analysis: ONT Order to Cash Tracker

## Executive Summary
This report gives one row per sales order or quote line, with the date of each step from quotation to payment: order booking, hold, request and ship dates, invoice, due date, payment and the accounting and general ledger posting of the invoice. Order-to-cash managers and finance controllers use it to find where an order has stalled, to measure cycle time and to confirm that shipped orders have been invoiced, accounted and posted. It is a Release 12 report that runs in Excel through Blitz Report™.

## Business Challenge
*   **Stalled orders:** An order can stop at a hold, an unshipped line or an uninvoiced shipment, and the cause must be visible per line.
*   **Cycle time:** Managers need the elapsed steps from quote and booking through to shipment, invoice and payment to measure the process.
*   **Invoice completeness:** Shipped lines must have an invoice, and the invoice must be accounted and posted to the general ledger before period close.
*   **Cash visibility:** The receipt that paid an invoice and the date it was paid must be traceable from the order line.

## The Solution
*   Lists quote and order dates, booked date, order status, line status and the hold name and hold date that currently block each line.
*   Shows the request, schedule and ship dates and the shipped quantity of each line, next to the invoice number, invoice date and due date.
*   Adds the invoiced amount of all invoice lines for the order line, the amount remaining due, the paid date and the latest receipt applied to the invoice.
*   Shows the accounting date and the GL posted date of the invoice's journal, so that accounting and posting status can be checked.

## Technical Architecture (High Level)
### Primary Tables
*   `OE_ORDER_HEADERS_ALL` and `OE_ORDER_LINES_ALL`: the order and quote headers and lines, with the quote number, dates, status and quantities.
*   `OE_ORDER_HOLDS_ALL`, `OE_HOLD_SOURCES_ALL` and `OE_HOLD_DEFINITIONS`: the unreleased holds on each order or line and the hold names.
*   `RA_CUSTOMER_TRX_LINES_ALL` and `RA_CUSTOMER_TRX_ALL`: the invoice lines raised from order lines, and the invoice header.
*   `AR_PAYMENT_SCHEDULES_ALL`: the installments of each invoice, with due date, amount remaining, closure date and status.
*   `AR_RECEIVABLE_APPLICATIONS_ALL` and `AR_CASH_RECEIPTS_ALL`: the receipt applications and the receipt number.
*   `XLA_TRANSACTION_ENTITIES`, `XLA_AE_HEADERS` and `XLA_AE_LINES`: the subledger accounting entities, headers and lines of the invoice.
*   `GL_IMPORT_REFERENCES` and `GL_JE_HEADERS`: the link from subledger lines to the general ledger journal and its posting date.
*   `HR_ALL_ORGANIZATION_UNITS_VL`, `HZ_CUST_ACCOUNTS`, `HZ_PARTIES`, `OE_TRANSACTION_TYPES_TL`, `MTL_SYSTEM_ITEMS_VL`, `JTF_RS_SALESREPS` and `JTF_RS_RESOURCE_EXTNS_VL`: the operating unit, customer, order type, item and salesperson.

### Logical Relationships
1.  Each header joins to its operating unit, customer, order type and salesperson, and to its lines.
2.  Each line is outer-joined to the invoice lines raised from it, by the order line identifier held as the interface line attribute on the invoice line.
3.  The invoice header is joined to the invoice lines, and its installments provide the due date, amount remaining, and paid date.
4.  The receipt number is the latest receipt applied to the invoice, ordered by application date.
5.  Subledger entities link to the invoice by transaction identifier, and to journals through GL import references.

## Parameters & Filtering
*   **Operating Unit:** restricts the orders to one operating unit within those the user can access.
*   **Order Number**, **Quote Number**, **Customer Name**, **Account Number** and **Order Type:** select the orders by identity.
*   **Phase:** selects quote or order phase.
*   **Ordered Date From** and **To**, **Creation Date From** and **To:** select orders by date.
*   **Incomplete Only:** a switch that restricts the output to orders and lines that are not yet complete through the order-to-cash steps.

## Performance & Optimization
*   The invoice amount, invoice number and receipt lookups are correlated subqueries per order line, so the number of lines in scope is the main factor in run time.
*   Operating unit restriction through `MO_GLOB_ORG_ACCESS_TMP` is applied in the inline view before the joins to the order tables.
*   The receipt number uses an analytic last-value function over the application date, which picks the latest application without a second pass.
*   Accounting and posting dates are read only where an invoice exists.

## FAQ
**Q: Why is the amount remaining shown on only one line per invoice?**
A: The amount due remaining is shown on the first order line of each invoice, so that the column can be summed without counting the same invoice more than once.

**Q: What does the Invoiced Amount column add up?**
A: It sums all the invoice lines raised from the order line, so partial and multiple invoices are reflected in the total.

**Q: How can I tell whether an invoice has been posted to the general ledger?**
A: The GL Posted Date column shows the date of the journal posting for the invoice, and it is blank until the journal is posted.
