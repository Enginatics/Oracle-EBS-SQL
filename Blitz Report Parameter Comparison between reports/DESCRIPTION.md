# Case Study: Blitz Report Parameter Comparison between reports

## Executive Summary
The **Blitz Report Parameter Comparison between reports** is a developer utility designed to analyze and compare the parameter definitions of two distinct Blitz Reports within the same Oracle E-Business Suite environment. This tool is particularly useful for version control, debugging, and standardizing report definitions across the application.

## Business Challenge
In complex Oracle EBS environments, report developers often create new reports by cloning existing ones or maintaining multiple versions of similar reports (e.g., "Sales Report Summary" vs. "Sales Report Detail"). Over time, these reports can diverge in subtle ways:
- **Inconsistent Logic**: Parameter validation logic (LOVs) might be updated in one report but missed in the other.
- **Version Control**: Tracking changes between a "Draft" version and a "Final" version of a report can be difficult without a direct comparison tool.
- **Debugging**: If two seemingly identical reports produce different results, the root cause is often a minor discrepancy in parameter default values or bind variables.

## Solution
This report provides a side-by-side comparison of all parameters for two selected reports.
- **Direct Comparison**: Users simply select "Report Name1" and "Report Name2" to generate a detailed matrix of their parameters.
- **Attribute Analysis**: The report compares critical attributes such as Parameter Name, Display Sequence, SQL Text (for LOVs), Default Values, and Validation logic.
- **Difference Highlighting**: The "Show Differences only" option filters out identical parameters, allowing developers to focus exclusively on what has changed or what is different.

## Technical Architecture
The report utilizes the Blitz Report metadata repository, specifically the `xxen_report_parameters_v` view. It executes a comparison query that aligns parameters from both source reports based on their sequence or name, flagging any discrepancies in their definitions.

### Key Views
- **`xxen_report_parameters_v`**: The primary view containing all parameter definitions for Blitz Reports.

## Parameters
- **Report Name1**: The name of the first report to be compared (Source A).
- **Report Name2**: The name of the second report to be compared (Source B).
- **Show Differences only**: A flag to suppress matching rows. When set to 'Yes', the output will only display parameters that exist in one report but not the other, or parameters where attributes (like the LOV query) differ.

## Performance
This report runs instantaneously as it queries the local metadata tables. It is highly optimized for quick developer feedback loops.

## FAQ
**Q: Can I compare a Blitz Report with a standard Oracle Concurrent Program?**
A: No, this tool is designed to compare two Blitz Reports.

**Q: Does it compare the main report SQL as well?**
A: This specific report focuses on **Parameters**. For comparing the main report SQL or columns, other tools in the "Blitz Report" category (like "Blitz Report SQL Validation" or "Blitz Report Comparison") may be more appropriate.
