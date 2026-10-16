# Blitz Report Column Number Fomat Comparison between environments - Case Study & Technical Analysis

## Executive Summary

**Blitz Report Column Number Fomat Comparison between environments** is a DevOps and migration tool. It compares the column formatting settings (specifically number formats) of Blitz Reports between two different Oracle EBS environments (e.g., Development vs. Production). This ensures that reports look identical to end-users after a migration.

## Business Challenge

*   **Consistency:** A report in UAT might display currency as `$1,000.00`, but after migration to Production, it shows as `1000`. This inconsistency confuses users.
*   **Migration Validation:** When moving reports between environments, subtle settings like Excel number formats can sometimes be missed or overwritten if not managed carefully.
*   **Standardization:** Ensuring that all environments adhere to the corporate standard for number display (e.g., decimal precision).

## Solution

This report connects to a remote database (via a database link) and compares the local report column definitions with the remote ones.

*   **Side-by-Side Comparison:** Lists the local number format and the remote number format for the same report column.
*   **Difference Highlighting:** The "Show Differences only" parameter allows administrators to focus only on the discrepancies.

## Technical Architecture

The report relies on Oracle Database Links to query the remote system's Blitz Report tables.

### Key Tables

*   **`XXEN_REPORT_COLUMNS` (Local):** The column definitions in the current environment.
*   **`XXEN_REPORT_COLUMNS` (Remote):** The column definitions in the target environment (accessed via DB Link).

### Logic

1.  **Match Columns:** It matches columns based on the Report Name and Column Name.
2.  **Compare Formats:** It checks if the `EXCEL_FORMAT_MASK` (or similar formatting column) differs between the two systems.
3.  **Filter:** It applies the "Show Differences only" filter to exclude matching records.

## Parameters

*   **Remote Database:** The name of the database link to the remote environment.
*   **Show Differences only:** Toggle to hide columns where the formats match.
