# Case Study & Technical Analysis: AR Transaction Update Upload

## Executive Summary
The AR Transaction Update Upload is a Blitz Report upload for the Receivables transaction header fields that are maintained after an invoice, debit memo or credit memo is completed. Billing and collections administrators use it to correct comments, special instructions, purchase order details, salesperson, remit-to address, ship-via, FOB, waybill and descriptive flexfield values across many transactions at once. The upload changes only the header fields that the Transactions workbench allows to be edited after completion, so financial amounts, dates, customers and accounting remain untouched. The workflow runs in Excel through Blitz Report.

## Business Challenge
*   **Post-completion corrections:** Once a transaction is complete, its header data cannot be changed in the standard workbench one record at a time, which makes bulk corrections of purchase order references or remit-to addresses slow.
*   **Collection and dunning accuracy:** Remit-to addresses, salesperson assignments and late-charge exemptions drive customer correspondence and commission reporting, so errors in them cause collection and dispute problems.
*   **Shipping and tax documentation:** Ship-via, FOB and waybill values are printed on documents and must match the physical shipment.
*   **Flexfield consistency:** Transaction descriptive flexfield values need to be kept consistent across a set of related invoices.

## The Solution
*   **Transaction identification:** Each row is identified by Operating Unit and Transaction Number. A hidden customer transaction ID links downloaded rows exactly, while pasted rows are resolved by number, and a number that exists under more than one transaction source is rejected.
*   **Workbench handler:** Updates are applied through the Transactions workbench header handler, so the validations of the form also apply to the upload.
*   **Changed-cell processing:** Only cells that differ from the database are processed, and a row without changes reports No change.
*   **Scope control:** Deposits and guarantees are excluded by transaction type, and the operating unit list is limited to the organizations the user can access through `MO_GLOB_ORG_ACCESS_TMP`.

## Technical Architecture (High Level)
### Primary Tables
*   `RA_CUSTOMER_TRX_ALL`: the transaction header, holding the header fields the upload updates, including the transaction flexfield attributes.
*   `RA_CUST_TRX_TYPES_ALL`: the transaction type, which supplies the class and the deposit and guarantee exclusion.
*   `RA_BATCH_SOURCES_ALL`: the transaction source name.
*   `HZ_CUST_ACCOUNTS` and `HZ_PARTIES`: the bill-to customer account and party name.
*   `RA_SALESREPS_ALL`: the primary salesperson name and number.
*   `AR_ACTIVE_REMIT_TO_ADDRESSES_V`: the active remit-to address and its concatenated address.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit name.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units accessible to the current user.

### Logical Relationships
1.  `RA_CUSTOMER_TRX_ALL` is filtered to the accessible operating units and joins to its transaction type on the transaction type ID and operating unit.
2.  The transaction joins to `HZ_CUST_ACCOUNTS` on the bill-to customer ID, and that account joins to `HZ_PARTIES` on the party ID.
3.  The transaction joins to `RA_BATCH_SOURCES_ALL` on the batch source ID and operating unit, and to `HR_ALL_ORGANIZATION_UNITS_VL` on the operating unit.
4.  The salesperson and remit-to address are resolved by correlated lookups on the transaction's primary salesperson ID and remit-to address ID.
5.  Descriptive flexfield values are displayed through the `XXEN_UTIL` flexfield helper functions, using the transaction's attribute category.

## Parameters & Filtering
*   **Upload Mode:** sets whether the report is run as a download of transactions or as an upload of changed rows.
*   **Operating Unit:** restricts the transactions to one organization within the accessible set.
*   **Transaction Number:** identifies the transaction to update, the key used when rows are pasted.
*   **Transaction Date From** and **Transaction Date To:** bound the transaction date of the candidate rows.
*   **Transaction Type:** limits the rows to one transaction type.
*   **Bill To Customer:** limits the rows to one bill-to customer.

## Performance & Optimization
*   The operating unit restriction is an `IN` subquery on the temporary security table `MO_GLOB_ORG_ACCESS_TMP`, so the query reads only the organizations the user is allowed to see.
*   Customer, party and batch source joins are outer joins to the header, so transactions without a customer or source are still returned.
*   Salesperson and remit-to values are fetched with scalar subqueries keyed on primary keys, which avoids repeating a join for every flexfield column.
*   Deposits and guarantees are removed by a filter on the transaction type code, which keeps commitments out of the upload before the header is loaded.

## FAQ
**Q: Can the upload change the amount or the completion status of an invoice?**
A: No. The description states that completion status, transaction status, amounts, dates, customers and accounting are not changed by this upload.

**Q: Why is a transaction number rejected during upload?**
A: The number exists under more than one transaction source, so the upload cannot identify the row by number and asks for the transaction to be downloaded so the hidden transaction ID is used.

**Q: Which AR fields can be updated in bulk?**
A: Comments, special instructions, print option, purchase order details, salesperson, remit-to address, late charge exemption, ship-via, FOB, waybill, cross reference and the transaction descriptive flexfield.
