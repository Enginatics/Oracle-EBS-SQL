# Blitz Report Deletion History - Case Study & Technical Analysis

## Executive Summary

**Blitz Report Deletion History** is an audit and recovery tool. It tracks reports that have been deleted from the system. Crucially, it can be used to recover accidentally deleted reports because Blitz Report often performs a "soft delete" or archives the definition before removal.

## Business Challenge

*   **Accidental Deletion:** A developer intends to delete a test report but accidentally deletes the production version.
*   **Audit Trail:** Security requires a log of who deleted a critical financial report and when.
*   **Recovery:** Restoring the SQL logic of a deleted report without having to rewrite it from scratch.

## Solution

This report queries the history tables (`XXEN_REPORTS_H`) to find records where the report status indicates deletion.

*   **Recovery:** The SQL text and parameters are preserved in the history table, allowing them to be copied back into a new report definition.
*   **Purge:** The description notes that this history can be permanently purged using the 'Blitz Report Monitor' concurrent program.

## Technical Architecture

### Key Tables

*   **`XXEN_REPORTS`:** The active report table.
*   **`XXEN_REPORTS_H`:** The history table that stores version changes and deleted records.

### Logic

The report filters the history table for records that represent a deletion event.

## Parameters

*   (None listed in the README, but likely supports standard filters like Date or User if customized).
