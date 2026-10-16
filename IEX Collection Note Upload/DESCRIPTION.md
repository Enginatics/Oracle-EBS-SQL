# Case Study & Technical Analysis: IEX Collection Note Upload

## Executive Summary
The IEX Collection Note Upload creates and updates Collection Notes in Oracle Collections, the same notes that appear in the Collections work area. Each note is attached to one of four note levels: the customer party, the account, the bill-to site or a collections transaction. Credit and collections teams use the upload to load call notes, promise-to-pay records and dispute comments in bulk, to correct note types and statuses, and to set up delinquencies on transactions. Blitz Report downloads existing notes so they can be reclassified, and the upload writes the changes back through the JTF notes and Collections tables.

## Business Challenge
*   **Bulk note loading:** Collection activity recorded outside Oracle, or migrated from a legacy system, must be entered against the right customer, account, site or transaction without retyping each note.
*   **Note level accuracy:** A note is attached to exactly one level, and each level needs different identifying fields, so the wrong level makes the note unreachable from the right work item.
*   **Delinquency status:** The unpaid reason and delinquency status belong to the transaction, so they must be set consistently with the notes on it.
*   **Reclassification:** Existing notes often need a new note type or status once a dispute or payment plan is resolved.

## The Solution
*   Creates notes at the party, account, bill-to or transaction level, with the Note Level column deciding which identifying fields are required.
*   Accepts note text of up to 2,000 characters, and a note detail that is truncated at 4,000 characters.
*   Sets the unpaid reason, and creates a delinquency with status Current when Create Delinquency is Yes.
*   Downloads existing notes in Create, Update mode, where only the note type, note status and descriptive flexfield attributes can be changed.

## Technical Architecture (High Level)
### Primary Tables
*   `JTF_NOTES_VL`: the collection notes, with source object code and id, note type, status, text and flexfield columns.
*   `HZ_PARTIES`, `HZ_CUST_ACCOUNTS`, `HZ_CUST_ACCT_SITES_ALL`, `HZ_CUST_SITE_USES_ALL` and `HZ_PARTY_SITES`: the customer party, account, account site, bill-to site use and address.
*   `AR_PAYMENT_SCHEDULES_ALL` and `RA_CUSTOMER_TRX_ALL`: the transaction installments and transactions that a transaction-level note is attached to.
*   `IEX_DELINQUENCIES_ALL`: the delinquency of a transaction, with its status and unpaid reason.
*   `JTF_OBJECTS_VL`: the source object for each note level.
*   `HR_ALL_ORGANIZATION_UNITS_VL` and `MO_GLOB_ORG_ACCESS_TMP`: the operating unit and organization access.

### Logical Relationships
1.  Notes are read from `JTF_NOTES_VL` where the source object code is PARTY, IEX_ACCOUNT, IEX_BILLTO or IEX_INVOICES.
2.  Each note's party, account, bill-to site and payment schedule are derived from its source object by a CASE expression on the source object code.
3.  The derived party, account and site are joined to `HZ_PARTIES`, `HZ_CUST_ACCOUNTS` and the site tables, which supply the party name, party number, account number and bill-to location.
4.  For transaction notes, the payment schedule joins to `RA_CUSTOMER_TRX_ALL` for the transaction number, and `IEX_DELINQUENCIES_ALL` is joined on the payment schedule id.
5.  The note level name comes from `JTF_OBJECTS_VL`, and the operating unit is limited to the organizations in `MO_GLOB_ORG_ACCESS_TMP`.

## Parameters & Filtering
*   **Upload Mode:** selects the rows to download for update, create or both.
*   **Party** and **Party Number:** select the customer party.
*   **Account Number:** selects one customer account.
*   **Operating Unit** and **Bill To Site:** select the operating unit and bill-to site of site-level or transaction-level notes.
*   **Transaction Number:** selects a transaction for transaction-level notes.
*   **Note Level:** selects one of the four levels: party, account, bill-to or transaction.
*   **Note Date From** and **Note Date To:** bound the entered dates of the notes.

## Performance & Optimization
*   The note source is decided in the inner query by the source object code, so each note is resolved once to its party, account and site.
*   Joins to the customer tables are outer joins on primary keys, so each note reads at most one row from each table.
*   The operating unit condition checks for a null operating unit first, so party-level notes skip the access list.
*   The delinquency and transaction joins apply only to transaction-level notes, which keeps the other levels fast.

## FAQ
**Q: How do I add a collection note to a customer account in Oracle Collections?**
A: Set the Note Level to the account level, enter the Party Name and Account Number, and add the note text. The note is created against the account and appears in the Collections work area.

**Q: Can I change the text of an existing collection note through the upload?**
A: No. Only the note type, note status and descriptive flexfield attributes can be changed on an existing note. The note text and its target are read only.
