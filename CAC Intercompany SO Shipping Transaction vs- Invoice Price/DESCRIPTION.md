# Case Study & Technical Analysis: CAC Intercompany SO Shipping Transaction vs. Invoice Price

## Executive Summary
The **CAC Intercompany SO Shipping Transaction vs. Invoice Price** report is a transactional audit tool that verifies the financial accuracy of intercompany shipments. It compares the cost of the item at the time of shipment (from the selling organization) against the actual invoice price charged to the receiving organization. This report is vital for detecting revenue leakage and ensuring that intercompany billing aligns with transfer pricing policies.

## Business Challenge
In day-to-day operations, discrepancies can arise between the expected transfer price and the actual invoiced amount.
*   **Timing Issues**: Price list changes between the time of order entry and shipment/invoicing can lead to incorrect billing.
*   **Cost Variances**: If the item cost changes (e.g., standard cost update) but the price list is not updated, the intercompany margin may be eroded.
*   **Audit Gaps**: Identifying specific shipment lines where the price charged does not match the expected cost-plus model is tedious without transaction-level matching.

## Solution
This report provides a line-level reconciliation of shipping transactions.
*   **Transaction Matching**: Links the physical inventory transaction (`mtl_material_transactions`) with the financial invoice line (`ra_customer_trx_lines_all`).
*   **Variance Analysis**: Allows users to compare the Unit Cost at shipment with the Unit Selling Price on the invoice.
*   **Scope**: Covers a specific date range, making it ideal for month-end validation routines.

## Technical Architecture
The report bridges the gap between Supply Chain and Finance:
*   **Linkage**: Joins `oe_order_lines_all` (Order Management) to `mtl_material_transactions` (Inventory) and `ra_customer_trx_lines_all` (Receivables).
*   **Cost Retrieval**: Fetches the transaction cost directly from the material transaction record, ensuring it reflects the cost *at the moment of shipment*.
*   **Org Context**: Resolves Operating Unit and Ledger details to support multi-org reporting.

## Parameters
*   **Transaction Date From/To**: (Mandatory) The date range of the shipping transactions to audit.
*   **Category Set**: (Optional) Filter by item categories.
*   **Ledger/Operating Unit**: (Optional) Scope the report to specific financial entities.

## Performance
*   **Indexed Access**: Relies on date-based indexes on `mtl_material_transactions` for efficient retrieval of shipment records.
*   **Data Volume**: Performance depends on the volume of shipments in the selected date range. Narrower date ranges yield faster results.

## FAQ
**Q: Why would the invoice price differ from the price list?**
A: Manual overrides on the sales order, modifiers/discounts applied inadvertently, or price list changes between order booking and invoicing can cause discrepancies.

**Q: Does this report show the receiving side?**
A: This report focuses on the *selling* side (Shipment and AR Invoice). The receiving side (Receipt and AP Invoice) is typically handled by separate reconciliation reports.

**Q: Can I use this for external customers?**
A: While the logic is similar, this report is tailored for Intercompany flows where the relationship between Cost and Price is strictly governed by policy.
