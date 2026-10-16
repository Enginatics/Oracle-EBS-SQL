# Blitz Report LOVs - Case Study & Technical Analysis

## Executive Summary

**Blitz Report LOVs** is a dictionary of all List of Values definitions in the system. It allows developers to search for existing LOVs to reuse, rather than creating duplicates. It also helps in impact analysis (e.g., "If I change this LOV, which reports will be affected?").

## Business Challenge

*   **Reusability:** A developer needs a "Supplier List" parameter. Instead of writing a new SQL query, they can search this report to find an existing, tested LOV.
*   **Impact Analysis:** The "Active Employees" view is being renamed. Which LOVs use this view, and which reports use those LOVs?
*   **Cleanup:** Identifying LOVs that are defined but not used by any parameter (`Not Used by any Parameter`).

## Solution

This report lists the LOV definitions, their SQL text, and usage statistics.

*   **Search:** Search by SQL text (`SQL Text contains`) or Table Name (`Based on Table`).
*   **Usage:** Shows which parameters use the LOV.

## Technical Architecture

### Key Tables

*   **`XXEN_REPORT_PARAMETER_LOVS_V`:** The LOV definition.
*   **`XXEN_REPORT_PARAMETERS`:** The link to reports.

### Logic

The query lists LOVs and joins to the parameter table to count usages or list specific reports.

## Parameters

*   **LOV Name starts with:** Search by name.
*   **SQL Text contains:** Search the code.
*   **Based on Table:** Find LOVs querying a specific table.
*   **Used by Parameter:** Find where a specific LOV is used.
*   **Updated within x Days / Last Updated By:** Audit changes.
*   **Not Used by any Parameter:** Find candidates for deletion.
