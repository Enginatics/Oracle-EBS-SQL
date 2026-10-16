# MRP Item Forecast Upload - Case Study & Technical Analysis

## Executive Summary
The **MRP Item Forecast Upload** is a data management tool designed to streamline the maintenance of demand forecasts. Instead of manually entering forecast quantities line-by-line in the Oracle forms, planners can use this tool to upload, update, or delete forecast entries in bulk via Excel.

## Business Challenge
Managing forecasts for thousands of items is tedious and error-prone when done manually.
-   **Data Entry Volume:** "We have 5,000 items with monthly forecasts for the next 2 years. I can't type all that in."
-   **Scenario Planning:** "We want to create a 'Best Case' forecast scenario by copying the 'Base' forecast and increasing it by 10%. How do we do that quickly?"
-   **Integration:** "Our sales team does their forecasting in a separate tool. We need to import those numbers into Oracle MRP."

## Solution
The **MRP Item Forecast Upload** provides a bi-directional interface for forecast data.

**Key Features:**
-   **Bulk Creation:** Upload new forecast entries for multiple items and organizations at once.
-   **Mass Updates:** Download existing forecasts, modify quantities or dates in Excel, and upload the changes.
-   **Copy Functionality:** Download data from one forecast set and upload it to another (e.g., Copy '2023_BUDGET' to '2023_REVISED').
-   **Deletion:** Allows deleting entries by setting the quantity to zero.

## Technical Architecture
The tool uses a WebADI-style approach (Blitz Report Upload) to interface with the MRP forecast tables.

### Key Tables and Views
-   **`MRP_FORECAST_ITEMS`**: The underlying table where forecast entries are stored.
-   **`MRP_FORECAST_DESIGNATORS`**: Validates the forecast names and sets.
-   **`MRP_FORECAST_DATES`**: Stores the specific date and quantity buckets.

### Core Logic
1.  **Download (Optional):** Retrieves existing forecast data based on parameters (Organization, Forecast Set).
2.  **Validation:** Checks that the Item, Organization, and Forecast Name exist and are valid.
3.  **Processing:**
    -   **Insert:** Creates new records in `MRP_FORECAST_DATES`.
    -   **Update:** Modifies existing records matching the primary key (Forecast, Item, Date, Bucket).
    -   **Delete:** Removes records where the uploaded quantity is 0.

## Business Impact
-   **Efficiency:** Reduces forecast entry time from days to minutes.
-   **Agility:** Enables rapid scenario planning and "what-if" analysis.
-   **Accuracy:** Eliminates manual data entry errors by allowing copy-paste from external sources.
