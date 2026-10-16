# Case Study & Technical Analysis: GL Account Distribution Analysis

## Executive Summary
The GL Account Distribution Analysis report produces a detailed General Ledger listing with one line per journal distribution. Each line carries every account segment, the subledger document that created it, and the amounts in transaction currency and ledger currency. For AR and AP transactions it also shows the VAT tax rate code and rate. Financial controllers, period-close teams and auditors use it to trace a ledger balance back to its originating invoice, receipt, payment or inventory transaction. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Period-end tracing:** Accountants need to see which subledger documents make up an account balance, which the standard journal views do not link directly.
*   **Audit evidence:** Auditors ask for every distribution behind an account, including the source, batch, journal and accounting event.
*   **Multi-currency reporting:** Foreign currency transactions must be reported in transaction currency and functional currency, optionally revalued at a chosen rate.
*   **VAT reporting:** Tax rate codes and rates on AR and AP lines must be visible beside the accounted amounts.

## The Solution
*   **Journal detail:** Journal headers, lines, batches and sources are combined with subledger accounting lines, so every posted line shows its subledger origin.
*   **Subledger attribution:** Invoice, payment, receipt, purchase order, receiving, inventory, work in process, project and payroll references are resolved through accounting event links.
*   **Balance lines:** When balances are requested, opening and closing balance rows are added per account and period, so the listing reconciles to the ledger.
*   **Hierarchy selection:** Accounts can be selected through a value hierarchy on one segment, and segments can be shown with their descriptions.

## Technical Architecture (High Level)
### Primary Tables
*   `GL_LEDGERS`, `GL_PERIODS`, `GL_JE_BATCHES`, `GL_JE_HEADERS`, `GL_JE_LINES` and `GL_JE_SOURCES_VL`: the ledger, periods and the journal hierarchy with its source.
*   `GL_CODE_COMBINATIONS_KFV`: the account combination and its concatenated segments.
*   `GL_BALANCES`: the opening and closing balances used for balance rows.
*   `XLA_AE_HEADERS`, `XLA_AE_LINES`, `XLA_EVENTS`, `XLA_TRANSACTION_ENTITIES` and `XLA_DISTRIBUTION_LINKS`: the subledger accounting events and their distribution links.
*   `GL_IMPORT_REFERENCES`: the link from journal lines to subledger accounting lines.
*   `AP_INVOICES_ALL`, `AP_INVOICE_DISTRIBUTIONS_ALL`, `AP_INVOICE_PAYMENTS_ALL`, `AP_CHECKS_ALL` and `AP_SUPPLIERS`: AP invoice, payment and supplier data.
*   `RA_CUSTOMER_TRX_ALL`, `RA_CUSTOMER_TRX_LINES_ALL`, `RA_CUST_TRX_LINE_GL_DIST_ALL` and `AR_CASH_RECEIPTS_ALL`: AR transactions, lines, receivable distributions and receipts.
*   `ZX_LINES` and `ZX_RATES_B`: tax lines and rates.
*   `PO_HEADERS_ALL`, `PO_LINES_ALL`, `PO_DISTRIBUTIONS_ALL` and `RCV_TRANSACTIONS`: purchasing and receiving sources.
*   `MTL_MATERIAL_TRANSACTIONS` and `WIP_TRANSACTIONS`: inventory and work in process sources.
*   `GL_DAILY_RATES` and `GL_DAILY_CONVERSION_TYPES`: rates used for the revaluation currency.

### Logical Relationships
1.  `GL_LEDGERS` joins to `GL_PERIODS` by period set, then to `GL_JE_HEADERS` by ledger and period name, and `GL_JE_LINES` joins to its header and batch.
2.  Each journal line joins to `GL_CODE_COMBINATIONS_KFV`, and through `GL_IMPORT_REFERENCES` to the `XLA_AE_LINES` rows it created.
3.  The accounting lines join to their headers and events, and `XLA_DISTRIBUTION_LINKS` connects them to the source distribution.
4.  The source distribution is matched to subledger tables by application ID, so each source is resolved only for its own application.
5.  The result is combined with opening and closing balance rows, and ordered by ledger, account, period, batch, journal and line.

## Parameters & Filtering
*   **Ledger** and **Period** (or **Period From** and **Period To**): choose the ledger and accounting periods.
*   **Posted Date From** and **Posted Date To:** bound the posting date of the journal.
*   **Journal Source**, **Journal Category**, **Batch**, **Journal** and **Journal Line:** narrow the listing to one source, category or journal.
*   **GL_SEGMENT1** to **GL_SEGMENT10** with their From and To values: filter each account segment by value or range.
*   **Hierarchy Segment** and **Hierarchy Name:** restrict accounts to a value hierarchy on one segment.
*   **Balance Type**, **Budget Name** and **Encumbrance Type:** choose actual, budget or encumbrance data.
*   **Revaluation Currency** and **Revaluation Conversion Type:** revalue amounts at a chosen rate on the conversion date.

## Performance & Optimization
*   The hierarchy is expanded with a hierarchical `CONNECT BY` limited to leaf nodes, so the segment range is built once and reused.
*   The code combinations are materialized in a common table expression, which avoids repeated lookups from each journal line.
*   The subledger joins use `DECODE` and `COALESCE` on application ID and distribution type, so each source is joined only for the matching record type.
*   The period joins restrict the journal rows before the subledger joins are evaluated.

## FAQ
**Q: How can I trace a journal line to its invoice or receipt?**
A: The line links through the accounting event to the subledger, and the invoice, customer transaction, cash receipt, purchase order and receiving columns show the source document.

**Q: Why does the report show opening and closing balance rows?**
A: When balances are requested, the report adds opening and closing balance rows per account and period, taken from the balances table, so the listing ties to the ledger.

**Q: Which VAT information is included for AR and AP lines?**
A: The tax rate code and tax rate of each line are shown, taken from the tax lines of the transaction or from the AP invoice line.
