# Case Study & Technical Analysis: CAC Intransit Value (Real-Time)

## Executive Summary
The **CAC Intransit Value (Real-Time)** report is a critical inventory management tool that provides a snapshot of the value of goods currently in transit between inventory organizations. Unlike period-end reports, this report offers "real-time" visibility, enabling logistics and finance teams to understand their immediate financial exposure and stock availability within the supply chain network.

## Business Challenge
In complex supply chains, a significant amount of inventory can be "on the water" or "on the road" at any given time.
*   **Financial Blind Spots:** Organizations often struggle to get an accurate, up-to-the-minute valuation of this floating inventory.
*   **Stockout Risks:** Without knowing what is in transit, planners may over-order or face unexpected stockouts.
*   **Period-End Surprises:** Waiting for month-end close processes to see intransit values can lead to surprises in financial reporting.
*   **FOB Confusion:** Determining ownership (and thus financial liability) based on FOB points (Shipment vs. Receipt) is often manual and error-prone.

## The Solution
The **CAC Intransit Value (Real-Time)** report solves these problems by querying the current state of supply and shipment tables.
*   **Real-Time Valuation:** Calculates the value of intransit stock based on current quantities and current costs, providing an immediate financial picture.
*   **Global Visibility:** Spans across all ledgers and operating units, offering a consolidated view for the entire enterprise.
*   **Ownership Logic:** Correctly handles FOB logic to determine which organization "owns" the inventory and should report it on their balance sheet.
*   **Simplified Design:** Leverages standard Oracle views (like `CST_INTRANSIT_VALUE_VIEW` logic) to ensure consistency with standard Oracle costing.

## Technical Architecture (High Level)
The report is built to extract data from the receiving and supply subsystems of Oracle Inventory.

**Primary Tables Involved:**
*   `RCV_SHIPMENT_HEADERS` / `RCV_SHIPMENT_LINES`: Stores details of the shipments that are currently active.
*   `MTL_SUPPLY`: The central table for tracking supply availability, including intransit stock.
*   `MTL_SYSTEM_ITEMS_VL`: Provides item definitions and attributes.
*   `CST_ITEM_COSTS`: Used to retrieve the current cost of items to calculate valuation.
*   `MTL_INTERORG_PARAMETERS`: Defines the shipping network rules, including FOB points and transfer types.

**Logical Relationships:**
*   **Supply to Shipment:** The report links `MTL_SUPPLY` records (where `supply_type_code` indicates intransit) to `RCV_SHIPMENT_LINES` to get specific shipment details.
*   **Cost Application:** It applies the current item cost from `CST_ITEM_COSTS` to the quantity derived from the supply/shipment tables.
*   **Ownership Determination:** Logic checks the FOB point defined in the shipping network (`MTL_INTERORG_PARAMETERS`) or the shipment itself to assign the value to the correct owning organization.

## Parameters & Filtering
*   **Category Sets:** Allows filtering by item categories to focus on specific segments of inventory (e.g., Raw Materials vs. Finished Goods).
*   **Item Number:** Enables tracking of specific high-value items.
*   **Organization Context:** Parameters for `Organization Code`, `Operating Unit`, and `Ledger` allow for scoping the report from a single warehouse to the entire enterprise.
*   **Minimum Absolute Intransit Qty:** A useful filter to exclude negligible or "dust" quantities, focusing the report on material variances.

## Performance & Optimization
*   **View Utilization:** By basing logic on or similar to `CST_INTRANSIT_VALUE_VIEW`, the report leverages Oracle's pre-optimized logic for intransit calculations.
*   **Current State Query:** As a real-time report, it queries current balance tables rather than aggregating millions of historical transaction records, making it generally faster than retrospective period-end reports.
*   **Efficient Filtering:** Parameters are applied early in the query execution to limit the dataset to relevant organizations or items.

## FAQ
**Q: How does this differ from the Period-End Intransit Value report?**
A: This report shows the *current* status at the moment of execution. The Period-End report reconstructs the value as of a specific past date, which is required for reconciliation but more computationally intensive.

**Q: Does it handle both Discrete and OPM inventory?**
A: The description suggests it is designed for standard discrete inventory costing. OPM (Process Manufacturing) often has separate valuation logic, though the principles of intransit tracking are similar.

**Q: What determines if inventory is "Intransit"?**
A: Inventory is considered intransit if it has been shipped from the source organization but not yet received (delivered) at the destination, and the shipment transaction is complete.
