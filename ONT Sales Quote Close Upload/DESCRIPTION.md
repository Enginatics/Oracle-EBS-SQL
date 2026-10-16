# Case Study & Technical Analysis: ONT Sales Quote Close Upload

## Executive Summary
This upload closes open sales quotes in Oracle Order Management. It targets quotes in the Negotiation transaction phase that are still open, and it lets a sales operations administrator download them, mark the quotes to close, choose a close reason and upload. Each quote is moved to the Lost terminal through the standard negotiation workflow, and the reason is recorded against the quote. It is used to clean up large volumes of old draft quotes that were never converted, while keeping genuine competitive losses separate from data cleanup. Blitz Report™ provides the spreadsheet for selecting and closing the quotes.

## Business Challenge
*   **Stale draft quotes:** Quotes created for prospects who never ordered remain open, which distorts pipeline reports and quote counts.
*   **Closing one by one:** Closing thousands of quotes through the forms is too slow for a cleanup project.
*   **Keeping win and loss data clean:** Quotes closed as cleanup must not be mixed with genuine losses in win and loss analysis.
*   **Selecting the right quotes:** Quotes need to be chosen by age or by number, and the upload must reject records that cannot be closed.

## The Solution
*   Downloads the open quotes of the chosen operating units, with quote number, order type, customer, ordered date, currency, quote status and creation date.
*   Accepts a Close Reason and Close Comments for each quote, so the reason of each closure is recorded.
*   Closes each quote to the Lost terminal through the negotiation workflow, so the quote leaves the open state.
*   Identifies quotes by quote number and operating unit, so a list of quote numbers can be pasted in place of a download.
*   Reports back quotes that are not open quotes, such as orders or quotes already closed, and leaves them untouched.

## Technical Architecture (High Level)
### Primary Tables
*   `OE_ORDER_HEADERS_ALL`: the sales document header, with its order number, order type, transaction phase, open flag, flow status, sold to customer and creation date.
*   `OE_TRANSACTION_TYPES_TL`: the order type name, in the session language.
*   `HZ_CUST_ACCOUNTS`: the sold to customer account.
*   `HZ_PARTIES`: the customer party name.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit name.

### Logical Relationships
1. `HR_ALL_ORGANIZATION_UNITS_VL` is joined to the order header on the operating unit identifier.
2. The order header is restricted to documents in the Negotiation transaction phase that are open.
3. The order type name is outer joined from `OE_TRANSACTION_TYPES_TL` in the session language.
4. The sold to customer account is outer joined from `HZ_CUST_ACCOUNTS`, and the party name from `HZ_PARTIES`.
5. The flow status is translated through the FLOW_STATUS lookup for display.

## Parameters & Filtering
*   **Upload Mode:** selects the download of open quotes, or the closure of the quotes marked in the file.
*   **Operating Unit:** limits the quotes to one operating unit.
*   **Created Before:** selects the quotes created before a date, to target old drafts.
*   **Quote Number:** selects a single quote.

## Performance & Optimization
*   The report starts from the operating unit and the open negotiation quotes, so the rest of the joins are applied only to the open quotes.
*   The customer lookups are outer joins, so quotes without a resolved customer still appear in the download.
*   The order type name is restricted to the session language, so only one translation row is joined for each order type.
*   Filtering by Created Before and Quote Number at download time keeps the upload file to the quotes that will be closed.

## FAQ
**Q: Why is Lost the status used for closed quotes?**
A: Cancelled and Closed are order fulfilment statuses and do not apply to a quote. Lost is the terminal status for a quote that is no longer being pursued.

**Q: How do I keep cleanup closures separate from real losses?**
A: Add a custom OFFERLOST lookup value, for example Obsolete, and select it as the Close Reason. The closures can then be told apart in win and loss reporting.

**Q: What happens to an order number in the file?**
A: Only open quotes are closed. An order number, or a quote that is already closed, is reported back and left untouched.
