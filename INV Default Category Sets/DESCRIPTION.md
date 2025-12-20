# INV Default Category Sets - Case Study & Technical Analysis

## Executive Summary
The **INV Default Category Sets** report is a configuration audit document. In Oracle EBS, different functional areas (Inventory, Purchasing, Costing, Order Management, etc.) can use different "Category Sets" to classify items. This report lists which Category Set is the "Default" for each functional area. It is essential for understanding how items are grouped for reporting and processing across the suite.

## Business Use Cases
*   **Implementation Audit**: Verifies that the system is configured correctly (e.g., "Is the 'Purchasing' functional area using the 'Purchasing Categories' set?").
*   **Reporting Context**: Helps analysts understand why an item might have a category of "Hardware" in an Inventory report but "IT Equipment" in a Purchasing report (different category sets).
*   **Master Data Governance**: Ensures consistency in how items are classified across the enterprise.

## Technical Analysis

### Core Tables
*   `MTL_DEFAULT_CATEGORY_SETS`: The mapping table between functional areas and category sets.
*   `MTL_CATEGORY_SETS_V`: Details of the category sets.
*   `FND_LOOKUP_VALUES`: Used to decode the `FUNCTIONAL_AREA_ID` (e.g., 1=Inventory, 2=Purchasing).

### Key Joins & Logic
*   **Functional Area Mapping**: Joins the internal ID of the functional area to its readable name.
*   **Structure Definition**: Shows the Flexfield Structure associated with the category set.

### Key Parameters
*   *(None)*: Typically runs for the entire installation or filtered by organization if applicable (though default category sets are usually site/installation level).
