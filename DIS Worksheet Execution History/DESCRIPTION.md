# DIS Worksheet Execution History

## Description
This report provides a historical log of Discoverer worksheet executions, offering detailed insights into user activity and system usage. It queries the `eul5_qpp_stats` table to retrieve access statistics, including which folders and objects were utilized during execution.

Features include:
- **Execution Log**: A chronological record of who ran which workbook and when.
- **Folder Usage**: Identifies the specific EUL folders accessed by each execution, useful for understanding data consumption patterns.
- **Drill-Down Capability**: The 'Show Folder Details' parameter allows users to switch between an aggregate view and a detailed list of used folder objects.

This history is valuable for auditing, performance tuning, and identifying obsolete or heavily used reports during a migration project.

## Parameters
- **Workbook**: Filter by workbook name.
- **Submitted by User**: Filter by the user who executed the report.
- **Business Area**: Filter by Discoverer Business Area.
- **Folder**: Filter by specific folder usage.
- **View Name**: Filter by underlying view name.
- **Object Use Key**: Filter by object key.
- **Object Id**: Filter by object ID.
- **Accessed within Days**: Limit history to a recent time window.
- **Start Date From/To**: Define a specific date range for the history.
- **Latest Workbook only**: Restrict results to the most recent version of workbooks.
- **Show Folder Details**: Toggle detailed folder usage information.
- **End User Layer**: Select the EUL to query.

## Used Tables
- `eul5_objs`: EUL objects (folders).
- `eul5_documents`: Discoverer workbook definitions.
- `eul5_qpp_stats`: Query execution statistics.

## Categories
- **Enginatics**: Usage analysis and auditing tool.

## Related Reports
- [DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/)
