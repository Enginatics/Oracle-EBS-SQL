# Executive Summary
This utility report generates the SQL syntax required to include standard Oracle EBS record history columns (Who columns) in a query, based on a provided table alias.

# Business Challenge
When developing custom SQL reports in Oracle EBS, developers frequently need to include the standard "Who" columns (Created By, Creation Date, Last Updated By, Last Update Date, Last Update Login) to track record history. Manually typing these columns for every table alias is repetitive and prone to typos.

# Solution
The Blitz Report Record History SQL Text Creation tool automates this process. By simply inputting the table alias and an optional prefix, it generates the exact SQL code snippet needed to select these columns, formatted correctly with the specified alias.

# Key Features
- Generates SQL for standard record history columns: `creation_date`, `created_by`, `last_update_date`, `last_updated_by`, `last_update_login`.
- Accepts a user-defined table alias to prefix the columns.
- Allows for an optional prefix to be added to the column aliases, useful when joining multiple tables with history columns.

# Technical Details
The report uses a simple query against the `dual` table to concatenate the input parameters into the required SQL string format. It outputs a text string that can be directly copied and pasted into a SQL editor or report definition.
