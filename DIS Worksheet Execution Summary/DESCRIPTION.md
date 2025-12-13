# DIS Worksheet Execution Summary

## Description
This report summarizes Discoverer usage statistics to provide a high-level view of system adoption and activity. It aggregates data from `eul5_qpp_stats` to show key metrics such as the number of active users, the variety of workbooks and worksheets being executed, and the diversity of underlying folders being accessed.

This summary is ideal for management reporting and capacity planning, helping administrators understand the scale of Discoverer usage and identify trends in user behavior. It complements detailed execution logs by providing the "big picture" of the reporting environment.

## Parameters
- **Workbook**: Filter statistics by workbook.
- **Submitted by User**: Filter by user.
- **Business Area**: Filter by Business Area.
- **Folder**: Filter by folder.
- **View Name**: Filter by view name.
- **Accessed within Days**: Limit the summary to recent activity.
- **Start Date From/To**: Define the date range for the summary.
- **End User Layer**: Select the EUL to analyze.
- **Show User Details**: Option to break down statistics by individual user.

## Used Tables
- `eul5_qpp_stats`: The primary source for query performance and usage statistics in Discoverer.

## Categories
- **Enginatics**: Management and usage reporting.

## Related Reports
- [DIS Access Privileges](/DIS%20Access%20Privileges/)
- [DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/)
