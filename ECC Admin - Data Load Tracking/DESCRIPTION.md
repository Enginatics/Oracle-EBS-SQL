# ECC Admin - Data Load Tracking

## Description
This report provides a detailed history of Enterprise Command Center (ECC) data load runs. It is a crucial tool for administrators to monitor the health and status of data synchronization processes.

Key features include:
- **Execution Status**: Tracks the success, failure, or progress of data loads.
- **Error Analysis**: Captures error messages and SQL queries associated with failed loads, facilitating rapid troubleshooting.
- **Load Details**: Displays the specific dataset, application, and load type (Full vs. Incremental).

By using this report, administrators can ensure that the ECC dashboards are displaying the most current and accurate data.

## Parameters
- **Run Id**: Filter by specific load run ID.
- **Application**: Filter by ECC application.
- **Data Set**: Filter by specific dataset.
- **Load Type**: Filter by load type (e.g., FULL_LOAD, INCREMENTAL_LOAD).
- **Status**: Filter by execution status (e.g., SUCCESS, ERROR).
- **Running within past x Days**: Filter for recent activity.
- **Start Date From/To**: Define a custom date range.
- **Show Load Rules**: Toggle display of load rules.
- **Show SQLs**: Toggle display of the underlying SQL executed during the load.

## Used Tables
- `ecc_application_tl`: ECC application translations.
- `ecc_dataset_b`: ECC dataset base definitions.
- `ecc_audit_request`: Audit log for load requests.
- `ecc_audit_dataset`: Audit log for dataset loads.
- `ecc_dataset_tl`: ECC dataset translations.
- `ecc_audit_load_rule`: Audit log for load rules.
- `ecc_audit_load_details`: Detailed audit logs.

## Categories
- **Enginatics**: ECC administration and monitoring.

## Related Reports
- [ECC Admin - Data Sets](/ECC%20Admin%20-%20Data%20Sets/)
- [ECC Admin - Metadata Attributes](/ECC%20Admin%20-%20Metadata%20Attributes/)
