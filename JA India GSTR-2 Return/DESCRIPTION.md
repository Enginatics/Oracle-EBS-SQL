# JA India GSTR-2 Return - Case Study & Technical Analysis

## Executive Summary
The **JA India GSTR-2 Return** report is designed to facilitate the reconciliation of inward supplies (purchases). While the GSTR-2 filing itself has been largely suspended/replaced by auto-populated statements (GSTR-2A/2B), this report remains essential for internal reconciliation to claim Input Tax Credit (ITC).

## Business Challenge
To claim ITC, a business must prove that it paid tax to its vendors.
-   **Reconciliation:** "The vendor says they filed their return, but it's not showing in our GSTR-2A."
-   **ITC Claim:** "How much tax credit are we eligible for this month?"
-   **Vendor Compliance:** Identifying vendors who consistently fail to file their returns.

## Solution
The **JA India GSTR-2 Return** report extracts purchase data from Oracle Payables and Receiving, showing the tax paid on procurements.

**Key Features:**
-   **Purchase Register:** Lists all GST-bearing invoices received from vendors.
-   **ITC Eligibility:** Flags whether the tax paid is eligible for credit (e.g., ineligible for personal use items).
-   **Import Details:** Includes details of imports (Bill of Entry) which are also part of inward supplies.

## Technical Architecture
The report queries the Payables and India Localization tax tables.

### Key Tables and Views
-   **`JAI_GST_REP_TRX_DETAIL_T`**: Staging table for report data.
-   **`JAI_PARTY_REGS_V`**: Vendor GST registration details.
-   **`AP_INVOICES_ALL`**: Base AP invoice data.

### Core Logic
1.  **Extraction:** The `JAI_GSTR2_EXTRACT_PKG` pulls data from AP Invoices and RCV Transactions.
2.  **Tax Analysis:** Breaks down the tax into CGST, SGST, and IGST components.
3.  **Reconciliation:** Designed to be compared against the government-generated GSTR-2A/2B.

## Business Impact
-   **Financial Savings:** Maximizes the claim of Input Tax Credit, directly reducing cash tax liability.
-   **Compliance:** Ensures that only eligible credits are taken, avoiding interest and penalties.
-   **Vendor Management:** Provides data to hold vendors accountable for their tax compliance.
