# Case Study & Technical Analysis: XLA OPM Event Type Summary

## Executive Summary
This report links Oracle Subledger Accounting events for the Process Manufacturing application to the OPM extract records that produced them. For each event, it shows the transaction entity code, the event type, the OPM event class, the transaction source and type, the ledger and the cost type. Process manufacturing accountants and implementation consultants use it to confirm which OPM transactions generated subledger events, and under which ledger and cost type, when they investigate accounting differences between OPM and the general ledger. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Tracing OPM accounting:** Process manufacturing transactions reach the general ledger through subledger events, and the link between the two is not shown in one place.
*   **Multi-ledger costing:** Each event belongs to a ledger and a cost type, and differences between cost types must be traced to their events.
*   **Event classification:** OPM event classes and types must match the subledger event types for the accounting rules to apply correctly.
*   **Transaction source tracing:** Accountants need the transaction source and transaction type of each event to find the original OPM document.

## The Solution
*   **Event to extract link:** Each subledger event is matched to its OPM extract header on the event id, so the OPM classification is shown alongside the subledger type.
*   **Source identifiers:** The source identifiers of the entity are returned, so each event can be traced to its OPM document.
*   **Ledger and cost type names:** The ledger name and cost type name are looked up from the identifiers held on the event entity.
*   **Transaction source and type names:** The names of the inventory transaction source and transaction type are shown with each event.

## Technical Architecture (High Level)
### Primary Tables
*   `XLA_AE_HEADERS`: the accounting entry header of each event, with the event id and event type code.
*   `XLA_TRANSACTION_ENTITIES`: the transaction entity of each event, with the entity code and the source identifiers.
*   `GMF_XLA_EXTRACT_HEADERS`: the OPM extract header, with the OPM entity code, event class, event type, transaction source type and transaction type.
*   `GL_LEDGERS`: the ledger name.
*   `CST_COST_TYPES`: the cost type name.
*   `MTL_TXN_SOURCE_TYPES`: the transaction source type name.
*   `MTL_TRANSACTION_TYPES`: the transaction type name.

### Logical Relationships
1. `XLA_AE_HEADERS` joins to `XLA_TRANSACTION_ENTITIES` on entity id and application id.
2. `XLA_AE_HEADERS` joins to `GMF_XLA_EXTRACT_HEADERS` on event id.
3. The transaction entity's second integer source identifier is the ledger id, which joins to `GL_LEDGERS`.
4. The transaction entity's third integer source identifier is the cost type id, which joins to `CST_COST_TYPES`.
5. The extract's transaction source type and transaction type join to `MTL_TXN_SOURCE_TYPES` and `MTL_TRANSACTION_TYPES` as outer joins.

## Parameters & Filtering
The report has no user parameters. Its rows are fixed by the application identifier, which is the Process Manufacturing application, so every event in that application is listed.

## Performance & Optimization
*   The application identifier filter on the transaction entity is applied directly, so the query reads only process manufacturing events.
*   The ledger and cost type joins are equality joins on identifiers, so each event is resolved to one ledger and one cost type.
*   The transaction source and type joins are outer joins, so events without a source type are still listed.

## FAQ
**Q: Which application does this report cover?**
A: It covers events of the Process Manufacturing application, identified by application id 555.

**Q: How do I find the ledger for an OPM event?**
A: The ledger name is returned on each row, taken from the second integer source identifier of the transaction entity.

**Q: Why is the transaction type blank for some events?**
A: The transaction type comes from the OPM extract header, and an event without a transaction type shows a blank value.
