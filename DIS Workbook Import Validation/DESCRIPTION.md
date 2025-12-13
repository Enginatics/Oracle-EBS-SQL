# DIS Workbook Import Validation

## Description
This report is a critical tool for validating the migration of Oracle Discoverer workbooks to Blitz Report. It provides a comprehensive overview of the migration status, highlighting which workbooks have been successfully imported and which are pending.

The report details:
- **Workbook Information**: Names and sheet details of Discoverer workbooks.
- **Usage Statistics**: How often workbooks were accessed within a specified timeframe, helping prioritize migration efforts based on usage.
- **Import Status**: Columns indicating the number of records in various import process tables (`xxen_discoverer_workbooks`, `xxen_discoverer_workbook_xmls`), allowing for tracking of the migration pipeline.
- **Blitz Report Integration**: Information on the created Blitz Report and its associated template, confirming successful conversion.

This validation report ensures that the migration process is transparent and that all critical reporting assets are accounted for in the new system.

## Parameters
- **Workbook**: Filter by specific workbook names.
- **Accessed after**: Filter for workbooks accessed after a certain date to focus on active content.
- **Workbook Owner**: Filter by the owner of the workbook.
- **Not yet imported**: Flag to filter for workbooks that have not yet been imported into Blitz Report.
- **Include Inactive**: Option to include inactive workbooks in the report.
- **End User Layer**: Specify the End User Layer (EUL) to query.

## Used Tables
- `eul5_documents`: Stores Discoverer workbook definitions.
- `eul5_qpp_stats`: Contains query statistics for Discoverer worksheets.
- `xxen_discoverer_workbook_xmls`: Staging table for workbook XML exports during migration.
- `xxen_discoverer_workbooks`: Tracks the status of workbooks being migrated to Blitz Report.
- `xxen_report_templates_v`: View for Blitz Report templates.

## Categories
- **Enginatics**: Part of the Enginatics toolkit for Oracle EBS reporting and migration.

## Related Reports
- [DIS End User Layers](/DIS%20End%20User%20Layers/)
