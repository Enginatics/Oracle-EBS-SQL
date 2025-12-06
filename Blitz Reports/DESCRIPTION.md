# Executive Summary
The Blitz Reports report is a comprehensive administrative tool that provides a detailed inventory of all Blitz Reports defined in the system. It lists reports along with their parameters, assignments, and other configuration details, serving as a master catalog for the reporting environment.

# Business Challenge
As the number of reports in an Oracle EBS environment grows, managing them becomes increasingly difficult. Administrators need a way to audit report definitions, check for consistency in parameters, and review user assignments. Without a centralized view, it is challenging to maintain standards, identify redundant reports, or ensure that reports are correctly configured and secured.

# Solution
The Blitz Reports report solves this by offering a holistic view of the reporting landscape. It allows users to query reports based on a wide range of criteria, including category, type, parameter usage, and creation/update dates. This visibility enables efficient management, easier troubleshooting, and better governance of the reporting solution.

# Key Features
*   **Comprehensive Inventory:** Lists all Blitz Reports with their key attributes.
*   **Detailed Filtering:** Supports extensive parameters for filtering by category, report name, parameter type, and more.
*   **Configuration Audit:** Shows details about parameters, upload columns, and assignments.
*   **Usage & History:** Includes options to show execution counts and filter by creation or update history.
*   **Free Report Identification:** Can sort and identify reports that count towards the free usage tier.

# Technical Details
The report queries a multitude of Blitz Report views and tables, including `xxen_reports_v`, `xxen_report_parameters_v`, `xxen_report_assignments_v`, and `xxen_report_runs`. It also joins with standard Oracle tables like `fnd_user` to provide user-related information. This complex query structure ensures that all aspects of a report's definition and usage are captured.
