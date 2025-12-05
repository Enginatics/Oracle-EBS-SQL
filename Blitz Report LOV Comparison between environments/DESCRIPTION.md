# Blitz Report LOV Comparison between environments - Case Study & Technical Analysis

## Executive Summary

**Blitz Report LOV Comparison between environments** is a technical validation tool for List of Values (LOV) definitions. It compares the SQL queries behind the parameter dropdowns between two environments. This ensures that the parameters available to users (e.g., the list of "Cost Centers" or "Suppliers") behave identically after a migration.

## Business Challenge

*   **Broken Parameters:** A report works in Dev, but in Prod, the "Department" dropdown is empty because the underlying LOV SQL references a table that doesn't exist or has different permissions.
*   **Inconsistent Data:** The LOV in Dev filters out inactive suppliers, but the Prod version doesn't, leading to users selecting invalid options.

## Solution

This report compares the `XXEN_REPORT_PARAMETER_LOVS_V` view across a database link.

*   **SQL Comparison:** It compares the `LOV_QUERY` text.
*   **CLOB Handling:** Like the report comparison, it requires a special view on the remote side to handle the potentially long SQL text of the LOV definition.

## Technical Architecture

### Key Tables

*   **`XXEN_REPORT_PARAMETER_LOVS_V`:** The definition of the LOVs.
*   **Remote View (`XXEN_REPORT_PARAMETER_LOVS_V_`):** The helper view for DB Link access.

### Logic

1.  **Match LOVs:** Matches based on LOV Name.
2.  **Compare SQL:** Checks if the query text differs.

## Parameters

*   **Remote Database:** The target environment.
