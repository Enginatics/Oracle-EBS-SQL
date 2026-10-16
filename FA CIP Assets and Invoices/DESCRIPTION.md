# Case Study & Technical Analysis: FA CIP Assets and Invoices

## Executive Summary
The FA CIP Assets and Invoices report lists Construction in Progress (CIP) assets from Oracle Fixed Assets together with the Accounts Payable invoice lines that feed each asset. For each asset it shows the master details, including category, location, tag number and cost, beside the invoice number, date, cost, supplier and purchase order that built up the cost. Fixed asset accountants use it for the monthly CIP review, to support capital expenditure reporting, and to trace how each CIP balance was formed. The report runs at invoice-line level, and it can be pivoted in Excel to give an asset-level summary.

## Business Challenge
*   **Monthly CIP close:** Each month, CIP balances must be explained by the invoices that were capitalised into them, and this trace is hard to build from the forms.
*   **Capital expenditure support:** Capital projects need a list of costs by asset, with the supplier and purchase order behind each cost.
*   **Invoice-to-asset traceability:** Auditors ask how a CIP asset was built, and the answer needs the invoice numbers, dates and batch details in one place.
*   **Location and category reporting:** CIP balances are often reviewed by category and location, so these attributes must sit next to the cost.

## The Solution
*   **Asset master with invoice detail:** Each CIP asset is shown with its cost, placed-in-service date and tag number, and with every invoice line linked to it.
*   **Supplier and PO trace:** The supplier name, invoice number, invoice date and purchase order number are returned for each line.
*   **Feeder and batch information:** The feeder system name and the Payables batch name show where each invoice came from.
*   **Book and period selection:** The report is run for a chosen asset book and a range of invoice dates, and it includes the ledger and currency of the book.

## Technical Architecture (High Level)
### Primary Tables
*   `FA_BOOK_CONTROLS`: the book, which is linked to its ledger.
*   `GL_LEDGERS`: the ledger name and currency for the book.
*   `FA_ADDITIONS_B` and `FA_ADDITIONS_TL`: the asset master and its description, restricted to assets of type CIP.
*   `FA_ASSET_KEYWORDS_KFV`: the asset key.
*   `FA_BOOKS`: the book-level cost and the placed-in-service date for each asset.
*   `FA_DISTRIBUTION_HISTORY`: the current distribution, which supplies the code combination and location.
*   `GL_CODE_COMBINATIONS`: the accounting combination of the distribution.
*   `FA_CATEGORIES_B_KFV` and `FA_LOCATIONS_KFV`: the category and location descriptions.
*   `FA_ASSET_INVOICES`: the invoice lines that feed each asset.
*   `AP_SUPPLIERS`: the supplier on each invoice.

### Logical Relationships
1.  `FA_BOOK_CONTROLS` is joined to `GL_LEDGERS` on the set of books ID, and filtered to the selected book type code.
2.  `FA_ADDITIONS_B` is restricted to CIP assets and joined to its description in `FA_ADDITIONS_TL` in the user's language.
3.  `FA_BOOKS` is joined to the asset and book, and only the open book record, with no transaction header out, is kept.
4.  `FA_DISTRIBUTION_HISTORY` is joined to the asset and book, using only current distributions, which supply the code combination and location.
5.  `FA_ASSET_INVOICES` is outer joined to the asset, so CIP assets without invoices still appear, and `AP_SUPPLIERS` is outer joined on the PO vendor ID.
6.  The result is ordered by asset number and invoice number.

## Parameters & Filtering
*   **Book:** Selects the corporate book whose CIP assets are reported. Ledger and currency come from this book.
*   **Asset Number and Asset Category:** Restrict the assets to one asset or one category.
*   **Invoice Date From and Invoice Date To:** Restrict the invoice lines to a date range, which supports a monthly review.
*   **DFF Display:** Controls how the descriptive flexfield columns are displayed.

## Performance & Optimization
*   **Book-first filter:** The book control join is the first restriction, so the asset and book rows are limited to one book before the invoice join.
*   **Current-record filters:** Only the open book record and current distribution are kept, which avoids returning retired cost and location history.
*   **Outer join for invoices:** Invoice lines are outer joined, so assets with no invoice lines still appear and are not dropped.
*   **Flexfield display:** The DFF Display parameter controls whether the descriptive flexfield columns are shown, so the default output stays narrower.

## FAQ
**Q: How do I see every invoice that built up a CIP asset?**
A: Run the report with the book and the asset number. Each invoice line for the asset appears on its own row, with the invoice number, date, cost and supplier.
**Q: How do I reproduce the monthly CIP figures?**
A: Set Invoice Date From and Invoice Date To to the month, then pivot the output in Excel by asset and sum the invoice cost. The description notes that the Asset Summary template covers the monthly CIP use cases.
**Q: Can I limit the report to one asset category?**
A: Yes. Use the Asset Category parameter, which restricts the assets to that category.
