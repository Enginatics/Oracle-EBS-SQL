# Case Study & Technical Analysis: AP Preliminary Payment Register 11i

## Executive Summary
The **AP Preliminary Payment Register 11i** is a critical financial control report designed for Oracle Payables (11i). It provides Accounts Payable managers and payment administrators with a detailed preview of proposed payments before the final payment batch is confirmed and printed. By enabling a pre-disbursement review, this report mitigates the risk of erroneous payments, fraud, and cash flow mismanagement, ensuring that only verified and approved invoices are processed for payment.

## Business Challenge
In high-volume accounts payable environments, payment batches can contain hundreds or thousands of invoices. Without a preliminary review mechanism, organizations face significant risks:
*   **Erroneous Payments:** Paying incorrect amounts, duplicate invoices, or the wrong vendors.
*   **Cash Flow Visibility:** Lack of foresight into the exact cash outflow required for a specific payment batch.
*   **Compliance & Control:** Inability to verify that all selected invoices meet internal approval and hold criteria before funds are committed.
*   **Operational Inefficiency:** The manual effort required to reverse or void payments after they have been printed or transmitted to the bank is costly and time-consuming.

## The Solution: Operational View
The **AP Preliminary Payment Register 11i** solves these challenges by offering a comprehensive "Operational View" of the payment batch lifecycle.
*   **Pre-Payment Verification:** Allows users to review every invoice selected for payment in the current batch, including amounts, discounts taken, and supplier details.
*   **Hold Identification:** Highlights invoices that may have issues or holds, ensuring they are addressed before the final print run.
*   **Cash Requirement Planning:** Provides a total batch amount, enabling Treasury teams to ensure sufficient funds are available in the disbursement bank account.
*   **Audit Trail:** Serves as a supporting document for payment approval workflows, providing a snapshot of what was intended to be paid at a specific point in time.

## Technical Architecture (High Level)
This report leverages the core Oracle Payables data model to reconstruct the proposed payment batch details.

*   **Primary Tables:**
    *   `AP_INVOICE_SELECTION_CRITERIA`: Stores the parameters and criteria used to initiate the payment batch.
    *   `AP_SELECTED_INVOICES`: Contains the specific invoices selected for payment within the batch.
    *   `AP_SELECTED_INVOICE_CHECKS`: Links the selected invoices to the proposed payment documents (checks/wires).
    *   `AP_BANK_ACCOUNTS`: Provides details on the disbursement bank account.
    *   `AP_INVOICES`: Source table for invoice header information.
    *   `AP_CHECKS`: (Referenced for context, though primarily for final payments) Stores payment document details.

*   **Logical Relationships:**
    *   The report starts by identifying the **Payment Batch** from `AP_INVOICE_SELECTION_CRITERIA`.
    *   It joins to `AP_SELECTED_INVOICES` to retrieve the list of invoices included in the run.
    *   It further joins to `AP_SELECTED_INVOICE_CHECKS` to group these invoices by the proposed payment document, calculating the total payment amount per supplier and per check.
    *   Supplier details are retrieved by joining to `PO_VENDORS` (implied via views or direct links in 11i).

## Parameters & Filtering
The report accepts specific parameters to isolate the relevant payment batch data:
*   **Payment Batch:** The specific name of the payment batch to be reviewed. This is the primary filter.
*   **Payment Date From / To:** Allows filtering by the proposed payment date range, useful for reviewing multiple batches or specific periods.

## Performance & Optimization
This report is optimized for performance during the critical payment processing window:
*   **Targeted Data Extraction:** By querying the `AP_SELECTED_*` tables, the report focuses only on the temporary data relevant to the open payment batch, avoiding the overhead of querying the massive historical `AP_INVOICE_PAYMENTS_ALL` table.
*   **Indexed Retrieval:** The query utilizes standard indexes on `BATCH_NAME` and `CHECKRUN_NAME` to ensure rapid execution, even for large batches.
*   **Direct Database Output:** As a Blitz Report, it bypasses the XML parsing layer often used in standard Oracle reports, delivering data directly to Excel for immediate analysis and filtering.

## FAQ
**Q: Can this report be run after the payment batch is confirmed?**
A: This report is primarily designed for the *preliminary* stage. Once a batch is confirmed, data moves from the `AP_SELECTED_*` tables to the permanent `AP_CHECKS` and `AP_INVOICE_PAYMENTS` tables. For confirmed payments, use the "AP Final Payment Register" or "AP Payment Register".

**Q: Does this report show invoices that were rejected from the batch?**
A: No, this report lists the invoices that *were* successfully selected. Rejected invoices would typically be reviewed in a separate exception report or the batch log file.

**Q: Why is the check number missing or showing as a placeholder?**
A: Since this is a *preliminary* register, the final check numbers may not yet be assigned (especially for pre-numbered stock). The report shows the internal identifier or a temporary sequence until the print/confirm process assigns the legal document number.
