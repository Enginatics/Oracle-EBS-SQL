# FA Additions By Source

## Description
This report provides a detailed analysis of asset additions, categorized by their source. It is based on the standard Oracle "Additions By Source Report" and helps financial analysts track where new assets are originating from (e.g., Accounts Payable invoices, manual entries, or project capitalization).

Key features:
- **Source Tracking**: Identifies the origin of each asset addition.
- **Financial Details**: Includes cost, depreciation, and transaction details.
- **Audit Trail**: Links assets back to their source transactions, such as AP invoices (`fa_asset_invoices`, `po_vendors`).

This report is essential for reconciling asset subledgers with general ledger accounts and verifying the accuracy of capital expenditures.

## Parameters
- **Book**: The depreciation book to report on.
- **From Period**: Start period for the report.
- **To Period**: End period for the report.

## Used Tables
- `fa_lookups_vl`, `fa_lookups`: Lookup values for codes.
- `fa_distribution_history`: Asset distribution history.
- `fa_asset_history`: Asset history changes.
- `fa_category_books`: Asset category configurations.
- `fa_additions`: Asset master information.
- `gl_code_combinations`: General Ledger account codes.
- `fa_transaction_headers`: Transaction history.
- `fa_deprn_detail`, `fa_deprn_periods`: Depreciation details.
- `fa_adjustments`: Financial adjustments.
- `fa_asset_invoices`: Links to AP invoices.
- `fa_invoice_transactions`: Invoice transaction details.
- `po_vendors`: Supplier information.

## Categories
- **Enginatics**: Fixed Assets reporting and reconciliation.
