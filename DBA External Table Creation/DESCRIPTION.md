# Executive Summary
The **DBA External Table Creation** report is a productivity tool for developers and DBAs. Instead of manually writing the complex syntax for `CREATE TABLE ... ORGANIZATION EXTERNAL`, this report generates the DDL statement for you. It allows you to point to a file on the server (or upload one) and immediately treat it as a SQL table.

# Business Challenge
*   **Data Loading**: "I have a 5GB CSV file. SQL*Loader is too slow/complex. I just want to query it."
*   **Log Analysis**: "I need to query the Apache access logs using SQL to find errors."
*   **Integration**: "We receive a nightly feed from a 3rd party. How can we join it with our internal tables?"

# Solution
This report accepts parameters (directory, filename, table name) and outputs the DDL to create the external table.

**Key Features:**
*   **DDL Generation**: Automates the syntax for `ACCESS PARAMETERS`, `LOCATION`, and `DIRECTORY`.
*   **Log/Bad File Handling**: Configures where rejected records should go.
*   **Immediate Access**: Once created, the file can be queried, joined, and indexed (virtually) just like a regular table.

# Architecture
The report generates DDL based on user inputs.

**Key Tables:**
*   `N/A`: This is a code generation tool.

# Impact
*   **Developer Productivity**: Saves hours of reading documentation to get the syntax right.
*   **Agility**: Allows for rapid ad-hoc analysis of external data sources.
*   **Performance**: External tables are often the fastest way to load large datasets into Oracle (using `INSERT AS SELECT`).
