# Case Study & Technical Analysis: CST Uninvoiced Receipts

## 1. Executive Summary
The **CST Uninvoiced Receipts** report is a standard Oracle Cost Management report used to support the **Period End Accrual** process. It provides a detailed listing of all Purchase Order receipts that have been accrued (received) but not yet fully invoiced as of a specific period end.

Unlike the "Accrual Reconciliation" reports which are based on a snapshot table (`CST_RECONCILIATION_SUMMARY`) populated by a load program, this report is often run directly against the transactional tables (or a temporary table `CST_PER_END_ACCRUALS_TEMP` depending on the version/mode) to validate the General Ledger accrual balance. It is the primary audit report for the "Received Not Invoiced" liability.

## 2. Business Context & Usage
### 2.1. Purpose
*   **Period End Validation:** To substantiate the balance in the Accrual Account at the end of a financial period.
*   **Liability Estimation:** To determine the company's outstanding liability to suppliers for goods received.
*   **Audit Compliance:** Auditors use this report to verify that the liability recorded in the GL matches the detailed subledger transactions.
*   **Aging Analysis:** Helps identify old receipts that haven't been invoiced, which might indicate process failures or lost invoices.

### 2.2. Key Stakeholders
*   **General Ledger (GL) Team:** To book period-end accrual entries (if using On-Receipt Accrual) or to reverse/book entries (if using Period-End Accrual).
*   **Accounts Payable (AP):** To investigate why receipts haven't been invoiced.
*   **Purchasing:** To close out old POs that will never be invoiced.

### 2.3. Process Flow
1.  **Receipt:** Goods are received.
    *   *On-Receipt Accrual (Inventory):* Liability is booked immediately.
    *   *Period-End Accrual (Expense):* Liability is not booked until period end.
2.  **Period Close:** The "Uninvoiced Receipts Report" is run.
3.  **GL Posting:**
    *   For Expense items, the report output is used to create a manual or automated reversing journal entry for the liability.
    *   For Inventory items, the report serves as the subledger detail for the existing GL balance.
4.  **Reconciliation:** The report total is compared to the GL Accrual Account balance.

## 3. Technical Analysis
### 3.1. Data Sources & Tables
The report logic depends on whether it's running for "On-Receipt" or "Period-End" accruals, but generally involves:

*   **Core Transaction Tables:**
    *   `RCV_TRANSACTIONS` (`RT`): The source of truth for receipts.
    *   `RCV_SHIPMENT_HEADERS` (`RSH`): Receipt header details (Receipt Number, Date).
    *   `CST_PER_END_ACCRUALS_TEMP` (`CPEA`): A temporary table often populated by the "Accrual Load" or "Period End Accrual" concurrent program to store the calculated accrual values for the report.

*   **Purchasing Tables:**
    *   `PO_HEADERS_ALL`, `PO_LINES_ALL`, `PO_LINE_LOCATIONS_ALL`, `PO_DISTRIBUTIONS_ALL`, `PO_RELEASES_ALL`.
    *   `PO_VENDORS`.

*   **GL/Org:**
    *   `GL_CODE_COMBINATIONS`, `GL_SETS_OF_BOOKS`.

### 3.2. Key Logic & Calculations
*   **Accrual Amount:**
    *   Calculated as `(Quantity Received - Quantity Billed) * PO Price`.
    *   If `Quantity Billed` > `Quantity Received`, the accrual is zero (or negative depending on specific logic/bugs, but typically this report focuses on positive liability).
*   **Currency Conversion:**
    *   The report handles both PO currency and Functional currency.
    *   `Accrual Amount` (PO Currency) vs `Functional Accrual Amount` (Ledger Currency).
*   **Aging:**
    *   `Age in Days` = `Report Date` - `Receipt Date`.
*   **Precision:**
    *   The SQL includes logic for `Dynamic Precision Option` to handle rounding differences between the PO definition and the currency definition.

### 3.3. Parameters
*   **Accrued Receipts:** Choose to report on "On Receipt" (Inventory) or "Period End" (Expense) accruals.
*   **Include Online Accruals:** Whether to include receipts that accrue immediately.
*   **Include Closed POs:** Critical for finding "stuck" accruals on closed orders.
*   **Period Name:** The target financial period for the snapshot.
*   **Minimum Accrual Amount:** Filters out negligible balances.
*   **Category/Vendor:** For targeted analysis.

## 4. Common Issues & Troubleshooting
*   **Report vs. GL Mismatch:**
    *   Manual journal entries in GL.
    *   Transactions occurring after the report snapshot was taken.
    *   Exchange rate variances.
*   **Negative Balances:** Can occur if an invoice was matched to a receipt that was later returned (RTV) without a credit memo, or over-invoicing.
*   **Performance:** The report can be slow if `CST_PER_END_ACCRUALS_TEMP` is large or if the query runs directly against `RCV_TRANSACTIONS` without proper indexing.
*   **"Ghost" Receipts:** Receipts on cancelled lines or closed POs that still show up.

## 5. SQL Query Structure
The provided SQL is a direct extraction query, likely designed to replace the standard Oracle RDF report with a Blitz Report Excel extract.
1.  **Inner Query (Aggregation):**
    *   Selects from `CST_PER_END_ACCRUALS_TEMP` (aliased as `x` or implied in the source).
    *   Joins to PO and RCV tables.
    *   Calculates `line_qty_accrued`, `ship_qty_accrued` using window functions (`SUM OVER PARTITION`) to allow drilling down from Summary to Detail.
2.  **Outer Query (Formatting):**
    *   Formats the unit prices and amounts based on the precision parameters.
    *   Handles the `Pivot Sort Value` logic to allow dynamic grouping in the Excel output.
    *   Constructs user-friendly columns like `PO (Release) Number`.

This structure allows the report to serve multiple purposes: a high-level summary for the Controller and a detailed transaction list for the AP Clerk.
