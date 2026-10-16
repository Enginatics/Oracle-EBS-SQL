# Executive Summary
The **FND Tables and Columns** report serves as a dynamic data dictionary for the Oracle EBS application. It lists registered tables, their columns, primary keys, and associated descriptive flexfields. This is an invaluable resource for developers, report writers, and data analysts.

# Business Challenge
Oracle EBS has thousands of tables. Finding the correct table name, column name, or understanding the primary key structure for a specific entity can be challenging. Documentation is not always up to date with custom extensions or specific patch levels.

# The Solution
This report provides an "as-built" view of the database schema as registered in the Application Object Library (AOL). It helps users:
- Search for tables by name or pattern.
- Find specific columns across the entire schema.
- Identify primary keys for joining tables.
- See which tables have Descriptive Flexfields (DFFs) enabled.

# Technical Architecture
The report queries the AOL dictionary tables: `fnd_tables`, `fnd_columns`, `fnd_primary_keys`, and `fnd_descriptive_flexs`. This ensures the information matches exactly what the application "knows" about the database.

# Parameters & Filtering
- **Table Name:** Search for a specific table (e.g., `PO_HEADERS_ALL`).
- **Column Name like:** Find tables containing a specific column (e.g., `%VENDOR_ID%`).
- **Key Columns only:** Restrict the output to only show primary key columns, useful for understanding join conditions.

# Performance & Optimization
The report is optimized for metadata querying. Searching by `Column Name like` with a leading wildcard (e.g., `%ID`) may be slower than searching by Table Name.

# FAQ
**Q: Does this include custom tables?**
A: It includes any custom tables that have been registered in EBS using the `AD_DD` package or the "Register Table" form. It will not show custom tables that exist in the database but are not registered in AOL.

**Q: Why don't I see a specific view?**
A: This report focuses on *Tables*. While some views are registered in `fnd_tables`, many are not.
