# Executive Summary
The Blitz Report Text Search tool is a powerful utility designed to search for specific SQL text strings across reports, parameters, and Lists of Values (LOVs) within the Oracle E-Business Suite environment. It is particularly useful for identifying dependencies and usage of specific code snippets or LOVs, and for previewing records that would be affected by mass change operations.

# Business Challenge
Managing a large repository of reports and their associated components in Oracle EBS can be challenging. Developers and administrators often need to find where specific SQL logic or LOVs are used to assess the impact of changes, debug issues, or ensure consistency. Manually searching through each report definition is time-consuming and prone to error. Additionally, performing mass updates requires a safe way to preview affected records before committing changes.

# Solution
The Blitz Report Text Search provides a centralized search mechanism that scans the definitions of reports, parameters, and LOVs for a specified text string. It allows users to filter by category, record type, and report name, and supports case-sensitive and regex-based searches. This tool streamlines impact analysis and facilitates safe mass updates by offering a preview capability.

# Key Features
*   **Comprehensive Search:** Searches across reports, parameters, and LOVs for a given SQL text string.
*   **Impact Analysis:** Identifies which reports use a specific LOV or contain specific SQL logic.
*   **Mass Change Preview:** Used to preview records that would be modified by the Blitz Report mass change functionality.
*   **Advanced Filtering:** Supports filtering by category, record type, and report name.
*   **Flexible Search Options:** Includes options for case matching and regular expression (regex) mode.
*   **Exclusion Criteria:** Allows specifying text strings to exclude from the search results.

# Technical Details
The report queries several internal Blitz Report views and tables, including `xxen_reports_v`, `xxen_report_parameters_v`, `xxen_report_parameter_lovs`, `xxen_upload_columns_v`, and `xxen_upload_sqls_v`. It leverages these views to inspect the underlying SQL definitions and configuration details of the reporting environment.
