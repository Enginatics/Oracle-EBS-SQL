# Case Study & Technical Analysis: OPM Detailed Subledger

## Executive Summary
The OPM Detailed Subledger report is the Oracle Process Manufacturing (OPM) Financials Detailed Subledger Report. It shows the transaction headers of the OPM subledger, the extract lines with their debit and credit amounts, and the General Ledger account each amount was distributed to. It is based on the Oracle standard report GMFDSUR. Process manufacturing cost accountants use it to reconcile inventory and production transactions with the General Ledger for a period, and to trace a journal line back to the batch, receipt, order or cost adjustment that produced it. It runs in Excel through Blitz Report.

## Business Challenge
*   **Subledger reconciliation:** The OPM subledger must agree with the General Ledger for each period, and each difference must be traced to its transaction.
*   **Batch and formula traceability:** Production amounts must be traced to the batch, formula, routing and recipe that produced them.
*   **Cost component accounting:** Material, resource and overhead amounts post to different accounts, and the accountant needs each cost component line.
*   **Legal entity reporting:** Results must be presented by legal entity, ledger and cost type for statutory and management reporting.

## The Solution
*   Lists each OPM subledger transaction with its reference number, entity, event class and event type, transaction date, item and quantity.
*   Shows the debit and credit amounts in base and transaction currency for each extract line, with the entered and accounted amounts.
*   Shows the General Ledger account and its description, the period name and the organization of the transaction.
*   Adds the process manufacturing references, including batch number and status, formula, routing and recipe, and the purchase and sales order references.

## Technical Architecture (High Level)
### Primary Tables
*   `GMF_SUBLEDGER_REP_V`: the OPM subledger report view holding the transaction headers, with entity, event, item, batch and order references.
*   `GL_SUBR_STA`: the subledger reference, with the fiscal year and period of each run.
*   `GMF_XLA_EXTRACT_LINES`: the extract lines of each transaction, with cost component, base and transaction amounts and entered and accounted amounts.
*   `XLA_DISTRIBUTION_LINKS` and `XLA_AE_LINES`: the Subledger Accounting links from each extract line to the accounting lines.
*   `GL_CODE_COMBINATIONS_KFV`: the General Ledger account of each accounting line.
*   `XLE_ENTITY_PROFILES`, `GL_LEDGERS` and `GL_PERIODS`: the legal entity, ledger and period name.
*   `MTL_PARAMETERS`, `HR_ALL_ORGANIZATION_UNITS` and `MTL_SYSTEM_ITEMS_B_KFV`: the organization and item.
*   `XLA_ENTITY_TYPES_VL`, `XLA_EVENT_CLASSES_VL` and `XLA_EVENT_TYPES_VL`: the names of the entity, class and type of the event.

### Logical Relationships
1.  `GMF_SUBLEDGER_REP_V` is joined to `GL_SUBR_STA` on the reference number, which gives the fiscal year and period.
2.  The subledger view is joined to `GMF_XLA_EXTRACT_LINES` on the header id, so each transaction returns one row per extract line.
3.  Extract lines are linked to `XLA_DISTRIBUTION_LINKS` on the event id and line id, and from there to `XLA_AE_LINES` on the accounting header and line number.
4.  The accounting line gives the account in `GL_CODE_COMBINATIONS_KFV`, and the legal entity is joined on the legal entity id of the subledger row.
5.  Entity, event class and event type names are read from the Subledger Accounting translation views for application 555.

## Parameters & Filtering
*   **Reference No:** selects one subledger run by its reference number.
*   **Legal Entity**, **Ledger**, **Cost Type**, **Fiscal Year** and **Period:** select the legal entity, ledger, cost type and period of the run.
*   **Organization:** limits the transactions to one OPM organization.
*   **Start Date** and **End Date:** bound the transaction dates.
*   **Entity Code**, **Event Class** and **Event Type:** select the Subledger Accounting entity, class and type of the transactions.
*   **Include Zero Amount Lines:** when set to Y, keeps extract lines whose base and transaction amounts are zero; otherwise lines below half a cent are excluded.

## Performance & Optimization
*   The subledger view is restricted by reference number and period, so the extract lines read are those of one run.
*   The distribution links are outer joined on the event id and application id 555, so the join uses the event key rather than a scan of all Subledger Accounting lines.
*   The zero amount test sits in the WHERE clause, and its default excludes amounts below half a cent so that rounding lines do not appear.
*   Using Reference No, or Ledger together with Period, is the most effective way to run the report, because the extract tables are large.

## FAQ
**Q: How do I reconcile the OPM subledger with the General Ledger for a period?**
A: Run the report for the ledger, cost type, fiscal year and period. The Account column gives the general ledger account of each extract line, and the debit and credit columns can be summed by account.

**Q: Why are some extract lines with zero amounts missing?**
A: By default, lines whose base and transaction amounts are below half a cent are excluded. Set Include Zero Amount Lines to Y to show them.
