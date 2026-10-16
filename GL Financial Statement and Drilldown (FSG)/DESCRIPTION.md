# GL Financial Statement and Drilldown (FSG) - Case Study & Technical Analysis

## Executive Summary
The **GL Financial Statement and Drilldown (FSG)** report is a powerful financial reporting tool designed to bridge the gap between static Oracle FSG reports and dynamic Excel-based analysis. It allows finance teams to generate comprehensive financial statements (Balance Sheets, Income Statements) directly in Excel with the ability to drill down from high-level balances to individual journal lines and subledger details. This tool often serves as a modern alternative to the traditional Financial Statement Generator (FSG) or third-party tools like GL Wand, offering real-time data integration.

## Business Use Cases
*   **Financial Reporting Package**: Automates the creation of monthly board packs and management accounts by linking Excel templates directly to live Oracle GL data.
*   **Ad-Hoc Analysis**: Enables financial analysts to quickly query account balances and investigate variances without running multiple static concurrent requests.
*   **Reconciliation**: Facilitates the reconciliation of GL balances to subledger transactions by providing an immediate drill-down path to the source data.
*   **Migration Strategy**: Acts as a destination format for migrating legacy FSG reports or reports from other Excel-based tools (Spreadsheet Server, GL Wand) into a unified reporting platform.
*   **Audit Support**: Provides auditors with a transparent view of financial figures, allowing them to trace reported numbers back to the underlying transactions efficiently.

## Technical Analysis

### Core Tables
*   `GL_BALANCES`: The primary source for account balance information.
*   `GL_JE_LINES`: Accessed during the drill-down process to show transaction details.
*   `GL_CODE_COMBINATIONS`: Used to resolve account segments.
*   `GL_LEDGERS`: Defines the ledger context for the report.
*   *(Note: The report logic is likely encapsulated in a PL/SQL package or complex view to handle the dynamic nature of FSG row/column definitions, hence the reference to `dual` in some documentation).*

### Key Joins & Logic
*   **Dynamic Row/Column Construction**: Unlike standard SQL reports, this tool likely interprets FSG row and column set definitions to construct the grid dynamically in Excel.
*   **Balance Aggregation**: It aggregates data from `GL_BALANCES` based on the period, currency, and actual_flag parameters.
*   **Drill-down Mechanism**: The "drill-down" capability is typically implemented via hyperlinks or connected queries that pass the context (Period, Account, Ledger) of the selected cell to a secondary query that fetches the journal lines (`GL_JE_LINES`) and subledger details.

### Key Parameters
*   **Ledger**: The financial entity to report on.
*   **Period**: The accounting period for the report.
*   **Currency**: The currency view (Entered, Accounted, or Translated).
*   **Content Set**: (Optional) Used to override segment values or expand the report across segment ranges.
