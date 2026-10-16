# DIS Workbooks, Folders, Items and LOVs

## Description
This report provides a deep dive into the structural dependencies of Oracle Discoverer workbooks. It maps workbooks to their underlying folders, items, and List of Values (LOV) item classes, derived from the dependency table `eul5_elem_xrefs`.

Key insights provided by this report include:
- **Workbook Dependencies**: Identifies which database views and folders are used by specific workbooks.
- **Item Usage**: Lists the specific items (columns) used within workbooks, helping to identify critical data elements.
- **LOV Analysis**: Shows item class LOVs associated with workbook items.
- **Usage Metrics**: Includes access counts to help determine the relevance and activity level of workbooks.

This detailed dependency mapping is essential for impact analysis when changing database objects or EUL definitions, as well as for planning the migration of complex reports to Blitz Report.

## Parameters
- **Workbook**: Filter by workbook name.
- **Folder**: Filter by EUL folder name.
- **View Name**: Filter by the underlying database view name.
- **Workbook Id**: Filter by specific workbook ID.
- **Access Count within x Days**: Filter workbooks based on recent usage activity.
- **Show Active only**: Toggle to show only active workbooks.
- **Display Level**: Control the granularity of the report output.
- **End User Layer**: Select the EUL to analyze.

## Used Tables
- `dba_views`: Database views metadata.
- `eul5_documents`: Discoverer workbook definitions.
- `eul5_elem_xrefs`: Cross-references between EUL elements.
- `eul5_objs`: EUL objects (folders).
- `eul5_qpp_stats`: Query statistics.
- `eul5_expressions`: EUL expressions (calculations).
- `eul5_domains`: EUL domains (LOVs).
- `eul5_key_cons`: Key constraints (joins).
- `eul5_functions`: EUL functions.

## Categories
- **Enginatics**: Technical analysis tool for Discoverer environments.

## Related Reports
- [DIS Folders, Business Areas, Items and LOVs](/DIS%20Folders-%20Business%20Areas-%20Items%20and%20LOVs/)
- [DIS Items, Folders and Formulas](/DIS%20Items-%20Folders%20and%20Formulas/)
