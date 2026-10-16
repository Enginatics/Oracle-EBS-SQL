# Case Study & Technical Analysis: AP Matched and Modified Receipts

## 1. Executive Summary

### Business Problem
In a high-volume Accounts Payable environment, the "Three-Way Match" (PO, Receipt, Invoice) is the gold standard for control. However, operational reality often complicates this: warehouse staff may adjust a receipt (e.g., correct a quantity error or process a return) *after* the AP team has already matched an invoice to that receipt. This sequence of events creates "Matched and Modified" exceptions, leading to:
*   **Invoice Holds:** Invoices suddenly reverting to "Quantity Variance" holds.
*   **Accrual Imbalances:** The General Ledger accrual account remaining open because the receipt and invoice no longer net to zero.
*   **Overpayment Risk:** Paying for goods that were subsequently returned or adjusted down.

### Solution Overview
The **AP Matched and Modified Receipts** report is a specialized audit tool designed to detect these specific timing conflicts. It identifies receipts that have been matched to an AP invoice but were subsequently modified within a specified date range. This allows the AP and Purchasing departments to proactively identify discrepancies before they become month-end reconciliation nightmares.

### Key Benefits
*   **Proactive Variance Detection:** Catch receipt changes that impact already-processed invoices.
*   **Hold Resolution:** Quickly identify the root cause of "Qty Rec" holds that appear on previously valid invoices.
*   **Vendor Compliance:** Monitor suppliers or internal processes that frequently require retroactive receipt adjustments.

## 2. Technical Analysis

### Core Tables and Views
The report relies on the intersection of Payables and Receiving history:
*   **`AP_INVOICES_ALL` / `AP_INVOICE_LINES_ALL`**: Identifies the invoice and the specific line matched to a receipt (`MATCH_TYPE` = 'ITEM_TO_RECEIPT').
*   **`RCV_TRANSACTIONS`**: The source of truth for receipt history. It tracks the original receipt (`TRANSACTION_TYPE` = 'RECEIVE') and any subsequent corrections or returns (`CORRECT`, `RETURN TO VENDOR`).
*   **`RCV_SHIPMENT_HEADERS` / `RCV_SHIPMENT_LINES`**: Provides context about the shipment and receipt numbers.
*   **`PO_VENDORS`**: Supplier master data.

### SQL Logic and Data Flow
The logic focuses on the temporal relationship between the Invoice Match and the Receipt Modification.
*   **Match Identification:** The query selects invoice lines where `RCV_TRANSACTION_ID` is populated, establishing the link to Receiving.
*   **Modification Filter:** It filters for `RCV_TRANSACTIONS` (or related history tables) where the `LAST_UPDATE_DATE` falls within the user-specified "Receipt Modify Date" range.
*   **Status Check:** It often includes logic to check the current status of the invoice (`AP_INVOICES_ALL.STATUS`) to prioritize those that are currently blocked or require re-validation.

### Integration Points
*   **Inventory/Receiving:** This report is essentially a quality control check on the Receiving process.
*   **Payables:** It directly impacts the "Invoice Validation" workflow.

## 3. Functional Capabilities

### Parameters & Filtering
*   **Receipt Modify Date From/To:** The primary filter. Users should run this for the current period to catch recent changes.
*   **Supplier Name:** Filter for specific vendors known for shipping errors or returns.
*   **Invoice Status:** Allows users to focus on 'Validated' invoices (which might need to be cancelled/adjusted) or 'Needs Revalidation' invoices (which are already on hold).

### Performance & Optimization
*   **Date-Driven:** By filtering on modification dates, the report limits the dataset to active operational windows, ensuring fast execution even in databases with millions of historical receipts.

## 4. FAQ

**Q: What constitutes a "Modified" receipt?**
A: A modification includes any transaction that alters the net quantity received, such as a "Correction" (positive or negative) or a "Return to Vendor" transaction that occurs after the initial receipt.

**Q: Why does the report show invoices that are already paid?**
A: If a receipt is modified *after* payment (e.g., a late return), the invoice will still appear. This is critical, as it indicates a potential overpayment that requires a Debit Memo to recover funds.

**Q: Does this report fix the data?**
A: No, it is a reporting tool only. Correcting the issue usually involves issuing a Credit/Debit memo in AP or correcting the receipt in Inventory, depending on the physical reality of the goods.
