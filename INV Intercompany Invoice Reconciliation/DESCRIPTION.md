# INV Intercompany Invoice Reconciliation - Case Study & Technical Analysis

## Executive Summary
The **INV Intercompany Invoice Reconciliation** report is a complex financial reconciliation tool designed to align the three legs of an intercompany transaction:
1.  **Inventory**: The physical shipment from Org A to Org B.
2.  **Receivables (AR)**: The invoice Org A sends to Org B.
3.  **Payables (AP)**: The invoice Org B receives from Org A.

Discrepancies between these three can lead to significant accounting issues and intercompany elimination problems during financial consolidation.

## Business Use Cases
*   **Month-End Reconciliation**: The primary tool for ensuring that Intercompany AR matches Intercompany AP.
*   **Transfer Pricing Validation**: Verifies that the price charged on the AR invoice matches the expected transfer price calculated by the shipping engine.
*   **Accrual Auditing**: Ensures that goods received (Inventory) have been invoiced (AP), preventing "Received Not Invoiced" (RNI) accrual errors.

## Technical Analysis

### Core Tables
*   `MTL_MATERIAL_TRANSACTIONS`: The source of truth for the physical movement (Transfer Type = Intercompany).
*   `RA_CUSTOMER_TRX_ALL` / `RA_CUSTOMER_TRX_LINES_ALL`: The AR invoice data.
*   `AP_INVOICES_ALL` / `AP_INVOICE_LINES_ALL`: The AP invoice data.
*   `MTL_SYSTEM_ITEMS_B`: Item details.

### Key Joins & Logic
*   **The "Logical" Link**: Linking these transactions is notoriously difficult in Oracle EBS. The report typically uses a combination of:
    *   `TRX_SOURCE_LINE_ID` (linking AR to Inventory).
    *   Purchase Order references (linking AP to Inventory/PO).
    *   Global Intercompany System (GIS) references if used.
*   **Variance Calculation**: Compares Quantity and Amount across the three sources (Inv vs AR, AR vs AP).

### Key Parameters
*   **Shipping/Receiving Org**: The pair of organizations to analyze.
*   **Date Range**: Shipment or Invoice date.
*   **Variance Only**: Filters to show only problem records.
