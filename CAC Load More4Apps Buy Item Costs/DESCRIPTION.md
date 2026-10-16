# Case Study & Technical Analysis: CAC Load More4Apps Buy Item Costs

## Executive Summary
The **CAC Load More4Apps Buy Item Costs** report is a data migration and maintenance utility. It is specifically designed to support the "More4Apps Item Cost Wizard", a popular third-party tool for mass-updating Oracle data. This report extracts existing "Buy" item costs into the exact format required for re-upload, streamlining the standard cost update process.

## Business Challenge
Updating Standard Costs for thousands of purchased items is a massive manual effort.
*   **Data Entry**: Manually typing new costs into Oracle forms is slow and error-prone.
*   **Formatting**: Extracting data from Oracle and re-formatting it for upload tools often involves complex VLOOKUPs and data cleansing.
*   **Scope**: Users need to filter for only "Buy" items (where the cost is manually maintained) and ignore "Make" items (where the cost is rolled up).

## Solution
This report automates the "Extract" phase of the ETL (Extract-Transform-Load) process.
*   **Targeted Scope**: Filters for `Based on Rollup = No` to isolate Buy items.
*   **Tool-Ready**: The column layout (Org, Item, Cost Type, Element, Rate) matches the More4Apps template.
*   **Context**: Includes current costs to serve as a baseline for the new year's pricing.

## Technical Architecture
The report queries the cost details table:
*   **Table**: `cst_item_cost_details`.
*   **Logic**: It flattens the cost structure to show the specific rates and amounts for Material and Material Overhead.
*   **Filter**: Excludes rolled-up items to prevent overwriting calculated costs.

## Parameters
*   **From Cost Type**: (Mandatory) The source data (e.g., Frozen).
*   **To Cost Type**: (Mandatory) The target cost type for the upload (e.g., Pending).
*   **Make or Buy**: (Optional) Defaults to 'Buy'.

## Performance
*   **Fast**: Optimized for bulk data extraction.
*   **Volume**: Can handle tens of thousands of rows easily.

## FAQ
**Q: Can I use this without More4Apps?**
A: Yes, it produces a clean CSV/Excel file that can be used as a source for Oracle WebADI or the standard Interface Table (`cst_item_cst_dtls_interface`).

**Q: Why exclude "Make" items?**
A: "Make" items usually have their costs calculated via the Cost Rollup routine based on their BOM and Routing. Manually uploading a cost for a Make item overrides this calculation, which is usually not desired.

**Q: Does it handle OSP?**
A: Yes, if the OSP cost is maintained as a static value (not rolled up), it will be included.
