```markdown
# Case Study & Technical Analysis: CAC Purchase Price Variance

## Executive Summary
The **CAC Purchase Price Variance** report is the definitive source for analyzing one of the most important metrics in a Standard Costing environment: Purchase Price Variance (PPV).
PPV represents the difference between the Standard Cost of an item and the actual price paid to the supplier. This report goes beyond simple GL balances by providing a detailed, transaction-level breakdown of *why* the variance occurred, distinguishing between price negotiation wins/losses and currency exchange rate fluctuations.

## Business Challenge
While the General Ledger shows the total PPV amount, it cannot explain the drivers.
*   **The "Black Box" of PPV:** A $100k unfavorable variance could be due to a supplier price hike, a rush order premium, or a sudden drop in the exchange rate.
*   **Internal vs. External:** PPV isn't just for external suppliers. Inter-company transfers between organizations with different standard costs also generate variance. Tracking this "Transfer PPV" is crucial for eliminating inter-company profit.
*   **Currency Confusion:** For multinational companies, a "price variance" might actually be a "currency variance." If the PO price in Euros didn't change, but the Euro/USD rate did, that's an FX issue, not a procurement performance issue.

## The Solution
This report provides a unified view of all PPV sources, enriched with analytical dimensions.
*   **Unified Architecture:** It combines data from:
    *   **Inventory:** External PO receipts and Internal Transfers (`MTL_TRANSACTION_ACCOUNTS`).
    *   **WIP:** Outside Processing (OSP) variances (`WIP_TRANSACTION_ACCOUNTS`).
*   **FX Separation:** It explicitly calculates two components of variance:
    *   **PPV Cost Amount:** The variance due to the difference in the base price (e.g., PO Price vs. Standard).
    *   **PPV FX Amount:** The variance due to the difference between the PO exchange rate and the daily rate at receipt.
*   **Transfer Logic:** It correctly handles the complex logic of Inter-Org transfers, using the FOB Point (Shipment vs. Receipt) to determine which organization—and which transaction—books the variance.

## Technical Architecture (High Level)
The query uses a Common Table Expression (CTE) approach to normalize data from disparate sources before aggregation.
*   **`mta_id` & `wta_id` CTEs:** These initial steps filter the massive transaction tables down to only those rows with `Accounting_Line_Type = 6` (Purchase Price Variance). This acts as a primary index filter for performance.
*   **`ppv_txns` CTE:** This is the core engine. It unions the Material and WIP transactions, normalizing columns like `Transaction_Id`, `Organization_Id`, and `Item_Id`.
*   **Complex Joins:** The main query joins this normalized transaction set to:
    *   `PO_HEADERS/LINES/DISTRIBUTIONS`: For supplier and price details.
    *   `RCV_TRANSACTIONS`: To link the accounting entry back to the physical receipt.
    *   `GL_DAILY_RATES`: To calculate the "True" daily rate vs. the "Frozen" PO rate for FX analysis.
*   **Logic for "Transfer to Regular":** Special logic handles Consignment inventory, where the PPV is recognized not at receipt, but when the ownership transfers (Consumption).

## Parameters & Filtering
*   **Transaction Date From/To:** The period for the analysis (usually matches the accounting period).
*   **Currency Conversion Type:** Used to calculate the "theoretical" FX impact.
*   **Category Sets:** Allows filtering by Product Line or Inventory Category.
*   **Organization/Operating Unit:** Standard security and filtering.

## Performance & Optimization
*   **Filtered CTEs:** By filtering `MTA` and `WTA` early (in the `WITH` clause) based on date and account type, the query avoids full table scans on these multi-million row tables.
*   **Single Pass:** The rewrite (Version 1.23) consolidated multiple `UNION ALL` blocks into a cleaner structure, reducing the number of times the heavy transaction tables are accessed.

## FAQ
**Q: Why do I see PPV on an Internal Transfer?**
A: If Org A ships to Org B, and Org A's standard cost is $10 but Org B's standard cost is $12, the $2 difference is recorded as variance. This report captures that to ensure the receiving org is valued at its own standard.

**Q: What is "PPV FX Amount"?**
A: This is the portion of the variance caused by exchange rate changes.
*   *Example:* PO Price = €100. Standard Cost = $110.
*   PO Rate ($1.10/€) -> PO Value = $110.
*   Receipt Rate ($1.20/€) -> Receipt Value = $120.
*   Total Variance = $10.
*   The report identifies this $10 as **FX Variance**, not Price Variance, because the €100 price didn't change.

**Q: Does this report match the GL?**
A: Yes, because it sources directly from `MTL_TRANSACTION_ACCOUNTS` and `WIP_TRANSACTION_ACCOUNTS` (or their SLA equivalents in newer versions), which are the source of truth for the GL journals.
```