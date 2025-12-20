# JTF Grid Datasources - Case Study & Technical Analysis

## Executive Summary
The **JTF Grid Datasources** report is a technical configuration report for the Oracle CRM Foundation (JTF) framework. It documents the setup of "JTF Grids" (also known as Spreadtables), which are the dynamic, spreadsheet-like tables used in many Oracle CRM web applications (like Sales Online, Service Online).

## Business Challenge
Customizing or debugging Oracle CRM web pages requires understanding the underlying data structures.
-   **UI Customization:** "We want to add a new column to the 'My Opportunities' table. Which datasource controls that grid?"
-   **Performance Tuning:** "The 'Service Request' list is loading slowly. What SQL query is behind it?"
-   **Hidden Columns:** "Is there a 'Profit Margin' column available in the grid that is just hidden by default?"

## Solution
The **JTF Grid Datasources** report lists the definition of these grids. It exposes the SQL query, column definitions, and data types.

**Key Features:**
-   **Datasource Definition:** Shows the underlying SQL or View used by the grid.
-   **Column Metadata:** Lists every available column, its data type, and whether it is sortable or filterable.
-   **Customization Visibility:** Shows if the grid has been customized by the user or administrator.

## Technical Architecture
The report queries the JTF Grid metadata tables.

### Key Tables and Views
-   **`JTF_GRID_DATASOURCES_VL`**: The header definition of the grid datasource.
-   **`JTF_GRID_COLS_VL`**: The definition of columns within the grid.

### Core Logic
1.  **Retrieval:** Selects the datasource definition based on the name.
2.  **Detailing:** Joins to the column table to list all fields.
3.  **Analysis:** Can be used to compare the standard seeded definition against any custom overrides.

## Business Impact
-   **Development Efficiency:** Accelerates the customization of CRM UIs by providing a map of the backend data.
-   **Troubleshooting:** Helps identify why data is not appearing correctly in the web interface.
-   **Upgrade Analysis:** Helps identify customizations that might be overwritten during an upgrade.
