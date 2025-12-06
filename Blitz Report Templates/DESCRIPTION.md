# Executive Summary
This report provides a detailed inventory of Blitz Report templates, including column layouts and pivot aggregation settings.

# Business Challenge
As the number of reports and custom layouts grows, managing and auditing report templates becomes challenging. Administrators need visibility into which templates exist, who created them, and how they are configured (e.g., which columns are included, if they use Excel templates) to ensure consistency and remove obsolete layouts.

# Solution
The Blitz Report Templates report offers a centralized view of all report templates. It allows users to search by report name, template name, owner, and creation date. It also provides details on whether a template includes a custom Excel file and can optionally show the specific columns included in each template.

# Key Features
- Lists all report templates with metadata like owner and creation date.
- Identifies templates that use custom Excel layouts ("Has Excel Template").
- Can display detailed column configurations for each template ("Show Columns").
- Filters by date ranges to help identify recently created or old templates.

# Technical Details
The report joins several Enginatics views and tables (`xxen_report_templates_v`, `xxen_report_template_files`, `xxen_report_template_pivot`, `xxen_report_template_columns`) to assemble a complete picture of the template definitions, including their file attachments and column-level settings.
