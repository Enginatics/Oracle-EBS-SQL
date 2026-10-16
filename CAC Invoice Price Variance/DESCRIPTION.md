# Case Study & Technical Analysis: CAC Invoice Price Variance

## Executive Summary
The **CAC Invoice Price Variance** report is a procurement performance and financial analysis tool. It details the differences between the Purchase Order (PO) price and the actual Accounts Payable (AP) Invoice price. It captures both the **Invoice Price Variance (IPV)** (operational price difference) and the **Exchange Rate Variance (ERV)** (currency fluctuation difference), providing a complete picture of purchase cost performance.

## Business Challenge
Standard Costing relies on the PO price being an accurate reflection of cost. When the Invoice differs:
*   **Margin Erosion**: Higher than expected material costs eat into product margins.
*   **Vendor Performance**: Frequent IPV suggests that a vendor is changing prices after the PO is cut, or that the PO pricing maintenance is poor.
*   **Currency Risk**: Large ERV indicates that currency volatility is impacting the cost of goods sold.

## Solution
This report provides line-level visibility into these variances.
*   **Dual Variance**: Separates IPV and ERV into distinct columns, allowing users to distinguish between "Vendor raised price" (IPV) and "Dollar got weaker" (ERV).
*   **Write-Offs**: Includes AP Accrual Write-Offs, ensuring that all adjustments to the inventory value are captured.
*   **Drill Down**: Provides PO Number, Invoice Number, Vendor, and Item details for every variance line.

## Technical Architecture
The report bridges Purchasing and Payables:
*   **Source Data**: `ap_invoice_distributions_all` (where the variance is booked).
*   **Linkage**: Joins to `po_headers_all` and `po_lines_all` to retrieve the original commitment details.
*   **Accounting**: Identifies the specific IPV and ERV accounts charged.

## Parameters
*   **Transaction Date From/To**: (Mandatory) The date range for the AP Invoices.
*   **Category Set**: (Optional) To analyze variances by commodity (e.g., "Steel", "Plastics").
*   **Vendor**: (Optional) To audit a specific supplier.

## Performance
*   **Transaction Volume**: Performance depends on the number of invoice lines in the selected date range.
*   **Indexed**: Uses standard date indexes on AP tables.

## FAQ
**Q: What is the difference between IPV and PPV?**
A: PPV (Purchase Price Variance) is the difference between Standard Cost and PO Price. IPV is the difference between PO Price and Invoice Price.

**Q: Does this report show PPV?**
A: No, this report focuses strictly on the AP side (IPV/ERV). Use the "Purchase Price Variance" report for PPV.

**Q: Why is IPV important for Standard Costing?**
A: IPV is expensed immediately (usually). It represents a "leak" in the standard cost model that needs to be monitored.
