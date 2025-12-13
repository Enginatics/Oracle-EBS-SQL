# DIS Worksheet SQLs

## Description
This report extracts the underlying SQL queries for Oracle Discoverer worksheets. Since Discoverer stores workbook definitions in a binary format within `eul5_documents`, extracting the SQL directly is difficult. This report relies on a trigger-based mechanism (using `eul_trigger$post_save_document`) that captures the SQL query at the time of saving and stores it in a custom table `ams_discoverer_sql`.

This tool is invaluable for:
- **Documentation**: Automatically documenting the logic behind legacy reports.
- **Migration**: Extracting SQL to migrate reports to other platforms like Blitz Report or BI Publisher.
- **Auditing**: Reviewing the complexity and efficiency of user-generated queries.

## Parameters
- **Workbook**: Filter by workbook name.
- **Worksheet**: Filter by worksheet name.
- **Access Count within x Days**: Filter based on recent usage.
- **Show Active only**: Toggle to show only active worksheets.
- **End User Layer**: Select the EUL to query.

## Used Tables
- `ams_discoverer_sql`: Custom table storing captured Discoverer SQL queries.
- `eul5_qpp_stats`: Query performance statistics.

## Categories
- **Enginatics**: Technical utility for Discoverer management and migration.

## Related Reports
- [DIS Workbook Import Validation](/DIS%20Workbook%20Import%20Validation/)
