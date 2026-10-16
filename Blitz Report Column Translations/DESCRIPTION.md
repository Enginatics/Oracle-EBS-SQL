# Blitz Report Column Translations - Case Study & Technical Analysis

## Executive Summary

**Blitz Report Column Translations** is a localization maintenance report. It lists the column headers for Blitz Reports and their translations for enabled languages. This report is essential for translators and administrators managing a multi-language reporting environment.

## Business Challenge

*   **Translation Gaps:** When a developer adds a new column to a report, they often forget to provide translations for other languages used in the company.
*   **Consistency:** Ensuring that common terms (e.g., "Invoice Date") are translated consistently across all reports.
*   **Review:** Providing a list of terms to external translation agencies or internal business users for validation.

## Solution

This report dumps the column headers and their translations.

*   **Audit:** Filter by "Last Updated By" to see recent changes or by "Show obsolete only" to find translations for columns that no longer exist.
*   **Export:** Can be exported to Excel, sent to a translator to fill in the blanks, and then potentially re-uploaded (using a separate upload tool).

## Technical Architecture

### Key Tables

*   **`XXEN_REPORT_COLUMNS`:** The master list of columns.
*   **`XXEN_REPORT_COLUMNS_TL`:** The translation table.
*   **`FND_LANGUAGES_VL`:** To provide human-readable language names.

### Logic

The query joins the columns with their translations. It can filter based on the language code to show specific translations.

## Parameters

*   **Column Name like:** Search for specific terms (e.g., "%Date%").
*   **Language Code:** Filter for a specific language (e.g., 'F').
*   **Language:** Filter by language name (e.g., 'French').
*   **Last Updated By:** Audit changes made by specific users.
*   **Last Update Date From:** See translations changed after a certain date.
*   **Show obsolete only:** Identifies translations that are orphaned (the underlying column was deleted or renamed).
