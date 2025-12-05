# AP Accounted Invoice Aging - Case Study

## Executive Summary
The **AP Accounted Invoice Aging** report is a vital financial instrument for managing accounts payable liabilities. Unlike standard aging reports that may rely on transactional data, this report focuses on *accounted* data, ensuring that the aging ties directly to the General Ledger (GL) balances. It provides Finance Managers and Controllers with an accurate picture of outstanding obligations, categorized by time buckets (e.g., 0-30, 31-60 days), facilitating effective cash flow planning and financial reporting.

## Business Challenge
Accurate liability reporting is crucial for financial health, but organizations often face discrepancies:
*   **GL Reconciliation:** Transactional aging reports often differ from the GL balance due to unaccounted invoices or manual journal entries.
*   **Cash Flow Forecasting:** Without a reliable view of when payments are due, treasury teams cannot optimize cash positions.
*   **Supplier Management:** Identifying overdue invoices is necessary to maintain good supplier relationships and avoid credit holds.
*   **Period-End Close:** Validating the Accounts Payable trial balance against the General Ledger is a mandatory step in the month-end close process.

## Solution
The **AP Accounted Invoice Aging** report bridges the gap between Payables operations and Financial accounting.

**Key Features:**
*   **Reconciliation Ready:** Built on the Subledger Accounting (SLA) architecture, ensuring data consistency with the General Ledger.
*   **Flexible Bucketing:** Allows users to define aging buckets (e.g., Current, 30+, 60+, 90+) to match internal reporting standards.
*   **Drill-Down Capability:** Provides summary balances by supplier while allowing drill-down to individual invoices for detailed analysis.
*   **As-Of Reporting:** Can be run for any historical date, allowing for retrospective analysis and audit support.

## Technical Architecture
This report utilizes the Subledger Accounting (XLA) tables, which serve as the source of truth for accounting entries.

**Key Tables:**
*   `XLA_TRIAL_BALANCES`: The primary source for the report, maintained by the Open Account Balances Data Manager. It stores the accounted balance for each liability.
*   `AP_INVOICES_ALL`: Provides transactional details like invoice number, date, and supplier.
*   `AP_PAYMENT_SCHEDULES_ALL`: Tracks the due dates and remaining amounts for invoices.
*   `AP_SUPPLIERS` & `AP_SUPPLIER_SITES_ALL`: Contains vendor master data.

## Frequently Asked Questions
**Q: Why does this report require the "Open Account Balances Data Manager" to be run?**
A: The report relies on the `XLA_TRIAL_BALANCES` table, which is populated and refreshed by the Open Account Balances Data Manager program. This ensures performance and data accuracy.

**Q: How does this differ from the "AP Trial Balance"?**
A: While similar, the Aging report specifically categorizes the outstanding amounts by time periods (buckets), whereas a standard Trial Balance typically lists the total liability per account or supplier.

**Q: Can it handle foreign currency invoices?**
A: Yes, the report can display amounts in the entered currency as well as the accounted (functional) currency, often with revaluation options for accurate reporting.
