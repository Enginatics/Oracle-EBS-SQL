# Case Study & Technical Analysis: CE Bank Statement Upload

## Executive Summary
This upload loads bank statement headers and lines into Oracle Cash Management through the bank statement open interface, then runs Oracle's Bank Statement Import automatically. It can also run AutoReconciliation in the same step, matching imported lines against AR receipts, AP payments and GL journal lines according to the bank account's transaction codes and matching rules. Treasury and cash management teams use it to load statements exported from bank portals without keying each line, and to reconcile the day's cash in one pass. The template runs in Excel through Blitz Report.

## Business Challenge
*   **Manual statement entry:** Keying bank lines into Cash Management is slow when accounts produce daily statements with many transactions.
*   **Unreconciled cash:** Statement lines that stay unmatched delay bank reconciliation and hide differences between the bank and the ledger.
*   **Import failures:** Lines that fail import must be found, corrected and loaded again without losing the statement.
*   **Duplicate loads:** A statement number must not be loaded twice into the same bank account.

## The Solution
*   **Header and line rows:** Each row is one statement line, and the header fields repeat on every row of the same statement.
*   **Automatic line numbers:** Line numbers are assigned per statement when left blank.
*   **Control totals:** Credit and debit control totals are computed from the entered lines and their transaction code types.
*   **Import and reconcile:** Bank Statement Import runs after upload, and AutoReconciliation is optional through the AutoReconciliation parameter.
*   **Correct and resubmit:** In Create, Update mode, lines still held in the interface are returned for correction, and corrected lines replace the staged records.

## Technical Architecture (High Level)
### Primary Tables
*   `CE_STATEMENT_HEADERS_INT`: the statement header interface, holding the bank account number, statement number, date, currency and control balances.
*   `CE_STATEMENT_LINES_INTERFACE`: the statement line interface, holding the line number, transaction date and code, amount, bank transaction number, text fields and value date.

### Logical Relationships
1. `CE_STATEMENT_HEADERS_INT` is the driving table, and `CE_STATEMENT_LINES_INTERFACE` is joined to it on bank account number and statement number as an outer join, so a header without lines still appears.
2. The GL date and the auto-reconcile flag are passed in as bind values and returned on each row.
3. A row number ordered by bank account, statement number and line number is produced as the upload row reference.
4. Rows whose header record status is T, meaning already transferred, are excluded by the filter on record status.

## Parameters & Filtering
*   **Upload Mode:** selects Create, or Create, Update to return lines that did not import.
*   **AutoReconciliation:** when set, the import runs AutoReconciliation against AR, AP and GL records.
*   **GL Date:** the accounting date applied to the imported lines.
*   **Account Number:** restricts the returned statements to one bank account.
*   **Statement Number:** restricts the returned statements to one statement number.

## Performance & Optimization
*   The filter on record status excludes statements already transferred, so the interface scan is limited to pending and new records.
*   The outer join on bank account and statement number keeps headers without lines in the result without a second query.
*   The row number is computed with an analytic function over the account, statement and line keys, which gives a stable upload row reference for the file.

## FAQ
**Q: Can I load a statement number that was already imported?**
A: No. Statements already imported into Cash Management cannot be loaded again under the same statement number.

**Q: Where do I see why a line failed to import?**
A: Failed rows show the Cash Management interface error messages in the result file. The standard Bank Statement Import Execution Report gives the same detail.

**Q: How do I fix a line that did not import?**
A: Download with Create, Update, correct the returned line, and upload it again. The corrected line replaces the staged interface record and is imported again.
