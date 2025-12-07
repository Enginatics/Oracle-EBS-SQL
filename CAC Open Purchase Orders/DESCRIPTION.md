```markdown
# Case Study & Technical Analysis: CAC Open Purchase Orders

## Executive Summary
The **CAC Open Purchase Orders** report is a forward-looking financial control tool. While most variance reports analyze what *has* happened (historical PPV), this report analyzes what *is about to* happen.
It lists all open Purchase Orders (POs) and compares the negotiated PO price against the current Standard Cost of the item. This allows Finance and Procurement teams to:
1.  **Forecast PPV:** Predict the Purchase Price Variance that will hit the P&L when these goods are received.
2.  **Audit Procurement Performance:** Identify significant deviations from standard cost before the liability is incurred.
3.  **Manage Currency Risk:** Simulate the impact of exchange rate fluctuations on open foreign currency orders.

## Business Challenge
In a standard costing environment, the difference between the PO Price and the Standard Cost is recorded as Purchase Price Variance (PPV) at the moment of receipt.
*   **The "Surprise" Factor:** Often, Finance only sees PPV after the month-end close. If a buyer negotiated a price 20% higher than standard, that variance is "locked in" once the receipt occurs.
*   **Currency Volatility:** For imported goods, the final cost depends on the exchange rate at the time of receipt. A PO cut 3 months ago might be profitable then but loss-making now due to currency shifts.
*   **OSP Blind Spots:** Outside Processing (OSP) orders often have complex pricing structures that are hard to compare against the standard resource rates.

## The Solution
This report acts as a "PPV Radar," scanning the horizon of open orders.
*   **Proactive Variance Calculation:** It calculates `(PO Price - Standard Cost) * Open Quantity` to show the *potential* variance.
*   **Currency Simulation:**
    *   It doesn't just use the exchange rate on the PO (which might be old).
    *   It allows the user to input a *current* `Currency Conversion Date` and `Type`. This re-values all open foreign currency POs at today's rates, giving a mark-to-market view of the liability.
*   **Unified View:** It merges standard material POs with OSP (Outside Processing) orders, providing a single view of all external manufacturing spend.

## Technical Architecture (High Level)
The query is built on the Purchasing (`PO`) schema but heavily enriched with Costing (`CST`) and Inventory (`MTL`) data.
*   **Core Join Structure:**
    *   `PO_HEADERS_ALL`, `PO_LINES_ALL`, `PO_LINE_LOCATIONS_ALL` (Shipments), `PO_DISTRIBUTIONS_ALL`.
    *   These are joined to `MTL_SYSTEM_ITEMS_VL` for item details and `AP_SUPPLIERS` for vendor info.
*   **Cost Comparison Logic:**
    *   It joins to `CST_ITEM_COSTS` (aliased as `cic`) based on the `Comparison Cost Type` parameter.
    *   For OSP items, it links the PO line to the `BOM_RESOURCES` to compare the PO service price against the standard resource rate.
*   **Currency Logic:**
    *   If `Match Option` is 'P' (Purchase Order), it uses the rate on the PO.
    *   Otherwise, it joins to `GL_DAILY_RATES` (`gdr`) using the user-supplied `Currency Conversion Date` to get the latest rate.
*   **Supply Visibility:** A subquery against `MTL_SUPPLY` fetches the `Expected Receipt Date`, which is often more accurate than the PO Promise Date as it reflects the latest shipping status.

## Parameters & Filtering
*   **Comparison Cost Type:** The standard to measure against (usually "Frozen").
*   **Currency Conversion Date/Type:** Critical for the "Mark-to-Market" analysis of foreign orders.
*   **Transaction Date From/To:** Used to calculate average receipt costs (if the report logic includes historical averaging, though the primary focus is open orders).
*   **Minimum Cost Difference:** A filter to hide "noise" (e.g., ignore variances less than $0.01).

## Performance & Optimization
*   **View Usage:** Uses `xxen_util.meaning` to decode lookups efficiently.
*   **Outer Joins:** Uses outer joins for Project (`PPA`) and OSP Resource (`CIC`) data to ensure that standard material POs are not dropped if they lack project or OSP details.

## FAQ
**Q: Why is the "Converted PO Unit Price" different from the price on the PO?**
A: If you entered a `Currency Conversion Date` for today, the report re-calculates the value of foreign POs using today's exchange rate. This shows you the cost *if you received it today*, which may differ from the rate when the PO was created.

**Q: Does this report show received items?**
A: No, it focuses on *Open* orders (where `Closed Code` is not 'CLOSED' or 'FINALLY CLOSED'). For received items, use the "Purchase Price Variance" report.

**Q: How does it handle OSP (Outside Processing)?**
A: For OSP items, the report looks at the "Resource" linked to the item. It compares the PO Price (service charge) against the Standard Rate of that Resource.
```