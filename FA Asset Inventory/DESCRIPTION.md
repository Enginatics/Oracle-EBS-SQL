# Executive Summary
The **FA Asset Inventory** report is a direct import of the standard Oracle "Asset Inventory Report" (FAS410_XML). It generates a comprehensive list of assets for physical inventory verification, ensuring that the system records match the physical reality of asset holdings.

# Business Challenge
*   **Physical Verification:** The need to periodically verify the existence and condition of fixed assets.
*   **Ghost Assets:** Identifying assets that are recorded in the system but no longer exist physically.
*   **Location Tracking:** Ensuring assets are located where the system says they are.

# The Solution
This Blitz Report provides the standard Oracle functionality with the added benefit of direct Excel output:
*   **Standard Compliance:** Uses the certified Oracle logic (`FA_FAS410_XMLP_PKG`) for inventory reporting.
*   **Location & Custodian:** Displays key physical attributes like Location, Employee, and Tag Number.
*   **Cost Center Analysis:** Allows grouping by cost center for departmental sign-offs.

# Technical Architecture
This report is based on the Oracle standard XML Publisher report `FAS410_XML`. It utilizes standard views and tables such as `FA_ADDITIONS`, `FA_BOOKS`, `FA_LOCATIONS`, and `FA_DISTRIBUTION_HISTORY`. It calculates current cost and net book value as of the run date.

# Parameters & Filtering
*   **Book:** The depreciation book (Required).
*   **From/To Cost Center:** Range of cost centers to limit the inventory list.
*   **From/To Date Placed in Service:** Filter assets based on their capitalization date.

# Performance & Optimization
*   **Cost Center Batching:** For large organizations, run the report by ranges of Cost Centers to distribute the verification workload.
*   **Active Assets:** The report typically filters for active assets; ensure retired assets are not expected unless specified.

# FAQ
*   **Q: Is this different from the standard Oracle PDF report?**
    *   A: The data source is the same, but Blitz Report renders it directly into Excel, making it easier to filter, sort, and use as a checklist.
*   **Q: Can I see retired assets?**
    *   A: This report is primarily for existing inventory. Use "FA Asset Retirements" for retired assets.
