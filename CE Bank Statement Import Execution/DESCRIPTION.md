# Executive Summary
The **CE Bank Statement Import Execution** report is a technical and operational log of the bank statement import process. When bank statements (BAI2, MT940, etc.) are loaded into Oracle, this report tracks the success or failure of that interface process. It highlights specific errors (e.g., "Invalid Account Number", "Duplicate Statement"), allowing the technical team or cash users to troubleshoot and correct the data before attempting to re-import.

# Business Challenge
Automated bank statement import is critical for daily cash visibility. However, file format changes, invalid characters, or configuration mismatches can cause imports to fail.
*   **Silent Failures**: Without a clear report, a missing statement might go unnoticed until month-end.
*   **Troubleshooting**: Error messages in the standard log file can be cryptic or hard to parse.
*   **Data Integrity**: Ensuring that the file was loaded completely (header and all lines) is essential before starting reconciliation.

# Solution
This report queries the interface and error tables to provide a readable summary of the import execution.

**Key Features:**
*   **Error Filtering**: Option to "Show Warnings/Errors Only" to focus immediately on problems.
*   **Interface Visibility**: Shows data sitting in the interface tables (`CE_STATEMENT_HEADERS_INT`) that failed to load into the main tables.
*   **Detailed Messages**: Displays the specific error message (e.g., "Bank Account not defined") associated with each failed line or header.

# Architecture
The report checks `CE_HEADER_INTERFACE_ERRORS` and `CE_RECONCILIATION_ERRORS` linked to the statement interface tables.

**Key Tables:**
*   `CE_STATEMENT_HEADERS_INT`: The staging table for incoming statements.
*   `CE_HEADER_INTERFACE_ERRORS`: Stores validation errors for the statement header.
*   `CE_RECONCILIATION_ERRORS`: Stores errors related to the auto-reconciliation process (if triggered during import).
*   `CE_BANK_ACCOUNTS`: To validate the account number in the file.

# Impact
*   **System Reliability**: Ensures that bank data feeds are monitoring and maintained.
*   **Rapid Resolution**: Helps IT and Treasury quickly identify why a file failed (e.g., "New bank branch code in file") and fix the setup.
*   **Process Assurance**: Confirms that the daily cash data has been successfully loaded and is ready for reconciliation.
