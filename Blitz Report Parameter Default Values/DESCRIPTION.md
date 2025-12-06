# Case Study: Blitz Report Parameter Default Values

## Executive Summary
The **Blitz Report Parameter Default Values** report is an administrative utility that provides visibility into the configuration of default parameter values across the Blitz Report system. It details how defaults are applied at different levels—global report definitions, specific templates, and user-level preferences—ensuring transparency in report execution behavior.

## Business Challenge
Blitz Report offers a flexible parameter system where default values can be layered. A report might have a standard default date range (e.g., "Current Month"), but a specific user might have overridden this to "Last Month," or a shared template might enforce a specific "Department" filter.
- **Complexity**: When a user complains that a report "defaults to the wrong data," it can be hard to determine if the issue lies in the report definition, a template they are using, or a personal preference they set months ago and forgot.
- **Auditing**: Administrators need a way to audit these settings to ensure standard operating procedures are followed (e.g., ensuring all financial reports default to the correct ledger).

## Solution
This report generates a detailed listing of all configured parameter default values.
- **Comprehensive View**: It displays defaults set at the **Report Level** (base definition), **Template Level** (saved layouts), and **User Level** (personalizations).
- **Troubleshooting**: Quickly identifies conflicting or outdated defaults that may be causing user confusion.
- **Cleanup**: Helps identifying unused or invalid default value configurations that should be removed.

## Technical Architecture
The report queries the Blitz Report metadata repository, specifically joining the parameter definitions with the default value storage tables.

### Key Views and Tables
- **`xxen_report_parameters_v`**: Contains the base parameter definitions.
- **`xxen_report_param_default_vals`**: Stores the specific default values assigned to parameters for templates or users.
- **`xxen_report_templates_v`**: Provides context for template-specific defaults.

## Parameters
- **Category**: Filter by report category (e.g., "Human Resources").
- **Anchor**: Allows filtering by the specific context or "anchor" to which the default value is attached.
- **Report Name**: Search for defaults associated with a specific report.

## Performance
The report is highly efficient, querying indexed metadata tables to provide immediate results.

## FAQ
**Q: Can I use this report to bulk-update default values?**
A: No, this is a reporting tool. To update values, you would use the Blitz Report setup forms or API.

**Q: Does it show system-level defaults like 'sysdate'?**
A: Yes, it shows the literal values or SQL expressions used as defaults.
