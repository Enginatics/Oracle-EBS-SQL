# MRP Item Forecast - Case Study & Technical Analysis

## Executive Summary
The **MRP Item Forecast** report details the independent demand (forecasts) that drives the planning process. It allows planners to review the specific forecast entries for an item, including the source of the forecast, quantities, and dates. This is crucial for validating the "input" side of the MRP equation.

## Business Challenge
If the forecast is wrong, the plan will be wrong ("Garbage In, Garbage Out"). Planners need to validate the forecast data before running the plan.
-   **Forecast Accuracy:** "Why is the system planning for 10,000 units? Did someone enter an extra zero?"
-   **Source Identification:** "Is this demand coming from the Sales Forecast or the Marketing Promo Forecast?"
-   **Consumption:** "Has this forecast been 'consumed' by actual sales orders, or is it still driving additional production?"

## Solution
The **MRP Item Forecast** report lists the detailed forecast entries.

**Key Features:**
-   **Forecast Sets:** Identifies which forecast set (scenario) the data belongs to.
-   **Granularity:** Shows individual forecast entries with dates and quantities.
-   **Project Association:** Can link forecasts to specific projects (for Project Manufacturing).

## Technical Architecture
The report queries the Master Scheduling/MRP forecast tables.

### Key Tables and Views
-   **`MRP_FORECAST_ITEMS_V`**: The primary view for forecast entries.
-   **`MRP_FORECAST_DESIGNATORS`**: Defines the forecast names and sets.
-   **`MRP_FORECAST_DATES`**: Stores the specific dates and quantities for each forecast entry.

### Core Logic
1.  **Selection:** Filters forecasts based on the Forecast Set and Item.
2.  **Details:** Retrieves the quantity, date, and bucket type (Day/Week/Period) for each entry.
3.  **Consumption Logic:** (Depending on the view used) may show the original forecast quantity versus the current (unconsumed) quantity.

## Business Impact
-   **Plan Accuracy:** Ensures that the manufacturing plan is based on valid and verified demand signals.
-   **Collaboration:** Facilitates discussions between Sales (who generate the forecast) and Operations (who execute it).
-   **Inventory Management:** Prevents over-production caused by obsolete or duplicate forecast entries.
