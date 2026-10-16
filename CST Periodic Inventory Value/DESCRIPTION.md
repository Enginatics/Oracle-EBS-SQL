# Executive Summary
The **CST Periodic Inventory Value** report is specifically designed for organizations using **Periodic Average Costing (PAC)**. In PAC, costs are calculated for a specific period (e.g., a month) rather than perpetually. This report provides the inventory valuation based on these periodic costs. It is the PAC equivalent of the standard "Inventory Value Report".

# Business Challenge
*   **PAC Valuation**: Standard inventory reports often use the Perpetual cost (Frozen/Average). PAC users need reports that reflect the specific periodic cost calculated by the PAC engine.
*   **Acquisition Costs**: PAC often includes complex acquisition cost adders (freight, duty) that need to be visualized.
*   **Period-Specific**: The value of an item changes from period to period in PAC; this report captures the value for a specific PAC period.

# Solution
This report lists inventory quantities and values based on the Periodic Average Cost.

**Key Features:**
*   **PAC Period**: Parameters allow selection of the specific Costing Period.
*   **Cost Group**: PAC is often driven by Cost Groups; this report supports that structure.
*   **Receiving Value**: Can also report on the value of goods in Receiving (using `CST_PAC_RECEIVING_VALUES_V`).

# Architecture
The report queries the PAC-specific tables, which are distinct from the perpetual costing tables.

**Key Tables:**
*   `CST_PAC_ITEM_COSTS`: Stores the calculated periodic item costs.
*   `CST_PAC_PERIODS`: Defines the PAC periods.
*   `CST_COST_GROUPS`: Cost groups used in PAC.
*   `CST_PAC_RECEIVING_VALUES_V`: View for receiving value in PAC.

# Impact
*   **Regulatory Compliance**: Essential for companies in jurisdictions that require Periodic Average Costing (e.g., parts of Latin America).
*   **True Costing**: Provides a valuation that smooths out short-term fluctuations and incorporates full acquisition costs.
*   **Financial Accuracy**: Ensures the inventory value reported matches the specific methodology (PAC) used for the ledger.
