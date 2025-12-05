# Blitz Report Comparison between environments - Case Study & Technical Analysis

## Executive Summary

**Blitz Report Comparison between environments** is the ultimate configuration management tool for Blitz Reports. It compares the full definition of reports—including SQL code, parameters, and assignments—between two environments. This is the primary tool used to validate a release or migration.

## Business Challenge

*   **Code Drift:** A developer makes a "quick fix" in Production but forgets to apply it to Development. Over time, the environments diverge.
*   **Release Validation:** Confirming that the SQL code in Production exactly matches the approved version in UAT.
*   **Parameter Mismatches:** Ensuring that default parameter values (e.g., "Period-End") are consistent.

## Solution

This report performs a deep comparison of the report definitions.

*   **SQL Comparison:** It compares the SQL text (often handling CLOBs) to detect changes in the logic.
*   **Parameter Check:** It verifies that the parameter lists and their attributes (mandatory, default values, LOVs) match.
*   **Version Control:** It helps maintain a synchronized landscape.

## Technical Architecture

### Key Tables

*   **`XXEN_REPORTS_V`:** The main report definition view.
*   **`XXEN_REPORT_PARAMETERS`:** The parameter definitions.
*   **Remote View (`XXEN_REPORTS_V_`):** The README notes a requirement to create a specific view on the remote environment to handle CLOBs (Large Objects) over a database link, as standard DB links can struggle with large SQL text fields.

### Logic

1.  **Remote Access:** Connects via DB Link.
2.  **SQL Normalization:** It often compares a "short" version or a hash of the SQL to detect changes efficiently, or uses the special view to pull the CLOB data.
3.  **Diffing:** It flags records where the local definition does not match the remote definition.

## Parameters

*   **Remote Database:** The target environment for comparison.
*   **Category:** Filter comparison by report category.
*   **Report Name like:** Compare a specific report or set of reports.
*   **Show Differences only:** The most common mode, hiding all the reports that are in sync.
