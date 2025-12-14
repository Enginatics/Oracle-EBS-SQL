# Executive Summary
The **FA Depreciation Projection** report forecasts future depreciation expenses for a specified number of periods. It is a strategic tool for budgeting and financial planning, allowing organizations to anticipate future capital consumption costs.

# Business Challenge
*   **Budgeting:** Accurately estimating future depreciation expense for the annual budget.
*   **Scenario Planning:** Understanding the impact of new asset acquisitions on future P&L.
*   **Cash Flow Management:** While depreciation is non-cash, it impacts tax liabilities and net income projections.

# The Solution
This Blitz Report leverages Oracle's standard projection logic but presents it in a usable format:
*   **Multi-Book Support:** Can project for up to 4 books simultaneously for comparative analysis (e.g., Corporate vs. Tax).
*   **Flexible Horizon:** Allows projection for any number of future periods.
*   **Granularity:** Can show projections at the asset level or summarized by cost center.

# Technical Architecture
The report uses a wrapper (`XXEN_FA_FAS_XMLP`) to launch the standard Oracle concurrent program `FAPROJ`. This program populates temporary tables (`FA_PROJ_INTERIM_V`) which the Blitz Report then queries to present the results.

# Parameters & Filtering
*   **Ledger/Calendar:** Defines the accounting context.
*   **Number of Periods:** How far into the future to project.
*   **Run Depreciation Projection:** Set to 'Yes' to trigger the calculation engine; 'No' to view previously generated results.

# Performance & Optimization
*   **Calculation Time:** The projection calculation can be resource-intensive. Run it during off-peak hours for large asset books.
*   **Previous Request ID:** If you have already run the projection, you can simply query the results by passing the Request ID, avoiding re-calculation.

# FAQ
*   **Q: Does this include CIP assets?**
    *   A: Generally, no. It projects depreciation for assets currently in service.
*   **Q: Why do I need to run the projection first?**
    *   A: Depreciation is a complex calculation based on methods and lives; the system must simulate the depreciation run to generate the data.
