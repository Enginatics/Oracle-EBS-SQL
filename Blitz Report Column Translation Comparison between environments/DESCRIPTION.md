# Blitz Report Column Translation Comparison between environments - Case Study & Technical Analysis

## Executive Summary

**Blitz Report Column Translation Comparison between environments** is a localization and migration quality assurance tool. It compares the translated column headers of Blitz Reports between two environments (e.g., Test vs. Production). This is critical for multi-national organizations ensuring that language translations are correctly promoted.

## Business Challenge

*   **Localization Integrity:** A report might have perfect French column headers in the Test environment, but they revert to English or old translations after migration to Production.
*   **Missing Translations:** Identifying columns that have been added to a report but lack translations in the target environment.
*   **Version Control:** Verifying that the latest terminology updates approved by the business have been successfully deployed.

## Solution

This report compares the `XXEN_REPORT_COLUMNS_TL` table (Translation table) across a database link.

*   **Language Specific:** Focuses on a specific language code (e.g., 'F' for French, 'D' for German).
*   **Discrepancy Detection:** Highlights where the translation text differs between the source and destination.

## Technical Architecture

### Key Tables

*   **`XXEN_REPORT_COLUMNS`:** Base column definitions.
*   **`XXEN_REPORT_COLUMNS_TL` (Local & Remote):** Stores the translated names of the columns for each installed language.

### Logic

1.  **Link:** Connects to the remote database.
2.  **Join:** Joins local and remote translation tables on Report Name, Column Name, and Language.
3.  **Compare:** Checks if the `TRANSLATED_COLUMN_NAME` differs.

## Parameters

*   **Remote Database:** The database link to the comparison environment.
*   **Language:** The specific language code to compare (e.g., 'US', 'F', 'ESA').
*   **Show Differences only:** Toggle to filter the output to only show mismatches.
