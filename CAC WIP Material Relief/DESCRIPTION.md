# Executive Summary
The **CAC WIP Material Relief** report provides a detailed analysis of material variances for closed Work in Process (WIP) jobs. It focuses specifically on the "relief" side of the equation—how much material cost was relieved from WIP upon job completion—and compares it to the standard cost of the assembly. Unlike other variance reports that might re-calculate based on current conditions, this report uses the historical material issue quantities stored on the job definition, ensuring alignment with the actual transactions that occurred. It is a key tool for analyzing the Material Usage Variance component of manufacturing costs.

# Business Challenge
In a standard costing environment, Material Usage Variance (MUV) occurs when the quantity of components actually issued to a job differs from the standard quantity required. Understanding this variance is crucial for:
*   **BOM Accuracy**: Identifying if the Bill of Materials (BOM) standards are incorrect.
*   **Production Efficiency**: Detecting waste, scrap, or theft on the shop floor.
*   **Cost Control**: Monitoring the largest component of manufacturing cost (material).

However, analyzing MUV on closed jobs can be complex because it requires comparing the *actual* issues against the *standard* requirements at the time of completion, while also accounting for any Profit in Inventory (PII) if applicable.

# Solution
This report generates a summary of material relief and variances by Inventory Organization and WIP Class. It provides a granular view of the material costs relieved from WIP, allowing cost accountants to audit the specific components driving the variance.

**Key Features:**
*   **Closed Job Focus**: specifically targets jobs that have been closed, where the final variance has been recognized.
*   **Historical Accuracy**: Uses the component issue quantities as they were recorded on the job, preserving the historical context of the variance.
*   **Profit in Inventory (PII)**: Includes logic to report on PII amounts, which is critical for inter-company transfers and global manufacturing supply chains.
*   **Yield Factor Support**: Accounts for component yield factors in the requirement calculations.

# Architecture
The report joins `WIP_DISCRETE_JOBS` with `WIP_REQUIREMENT_OPERATIONS` to get the component details. It calculates the standard requirements based on the assembly completion quantity and compares this to the quantity actually issued.

**Key Tables:**
*   `WIP_DISCRETE_JOBS`: Job header and status.
*   `WIP_REQUIREMENT_OPERATIONS`: Component requirements and quantities issued.
*   `MTL_SYSTEM_ITEMS`: Item master for costs and descriptions.
*   `CST_ITEM_COSTS`: Standard costs for the components.
*   `ORG_ACCT_PERIODS`: To filter jobs closed within a specific accounting period.

# Impact
*   **Variance Explanation**: Provides the detailed data needed to explain material usage variances to management.
*   **Standard Cost Refinement**: Highlights consistent variances that suggest a need to update BOM standards.
*   **Inventory Valuation**: Ensures that the relief of inventory value from WIP is understood and accurate.
