# Executive Summary
This report validates the SQL syntax of Blitz Reports, ensuring that the queries are syntactically correct and executable.

# Business Challenge
When migrating reports from legacy systems like Discoverer or other third-party tools to Blitz Report, there is a risk that the SQL syntax might not be fully compatible or may contain errors. Manually testing each migrated report is time-consuming and prone to oversight, potentially leading to runtime errors for end-users.

# Solution
The Blitz Report SQL Validation tool automates the verification process. It parses the SQL code of each report and checks for syntax validity. This is particularly valuable after bulk migrations, allowing administrators to quickly identify and fix broken reports before they are released to users.

# Key Features
- Validates SQL syntax for multiple reports in bulk.
- Filters by report name and category to target specific sets of reports.
- Provides a "Validation Result" to easily filter for failed validations.
- Includes an option to "Remove &lexicals" during validation to handle dynamic SQL components that might otherwise cause syntax errors during static analysis.

# Technical Details
The report queries the `xxen_reports_v` view to retrieve the SQL definition of each report. It then likely uses a dynamic SQL execution or parsing mechanism to test the validity of the SQL statement.
