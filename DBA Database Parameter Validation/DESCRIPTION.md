# Case Study & Technical Analysis: DBA Database Parameter Validation

## Executive Summary
DBA Database Parameter Validation checks the initialization parameters of an Oracle database instance against the values Oracle requires for an E-Business Suite installation. It reproduces the validation performed by the Oracle EBS Database Performance and Statistics Analyzer, so a DBA can confirm EBS parameter compliance from a spreadsheet without downloading and running that analyzer. The report is intended for database administrators and EBS technical consultants preparing a new instance, reviewing an upgrade, or auditing a production database against Oracle's guidance in My Oracle Support note 396009.1.

## Business Challenge
*   **Compliance Verification:** Oracle publishes a list of mandatory and recommended database parameters for EBS, and each database release changes the list.
*   **Obsolete Settings:** Parameters that were required in an earlier release can cause problems after an upgrade, and they remain set unless someone identifies them.
*   **Undocumented Changes:** Non-default and hidden parameters set by earlier administrators are hard to find without a complete comparison.
*   **Analyzer Overhead:** Running the separate Oracle analyzer requires download, installation and execution, which slows routine checks.

## The Solution
*   **Reference Data Set:** The report holds the required values as a built-in reference, grouped by database version and EBS release, and selects only the rows that apply to the running release.
*   **Three Check Sections:** Mandatory parameters are compared with their required values, parameters to be removed are flagged when they are explicitly set, and other non-default parameters are listed.
*   **Readable Sizes:** Byte values are converted to M and G notation, so memory settings can be compared directly with the reference values.
*   **Actionable View:** The Only show errors parameter is Yes by default, so only rows that need action are displayed.

## Technical Architecture (High Level)
### Primary Tables
*   `V$SYSTEM_PARAMETER2`: the view of current instance parameters, with the value, the default flag and the modifiability flags.
*   `V$SYSTEM_PARAMETER`: used to read the CPU count for the parallel server calculation.
*   `V$INSTANCE`: supplies the database version and instance name used to select the reference rows.
*   `FND_PRODUCT_GROUPS`: supplies the EBS release name used to filter the reference rows.
*   `DUAL`: the source for the inline reference rows.

### Logical Relationships
1.  The reference rows are generated in a common table expression from literal selects against `DUAL`, each carrying a parameter name, a category, the statement scope and the required value.
2.  A second common table expression reads the database version from `V$INSTANCE` and the EBS release from `FND_PRODUCT_GROUPS`.
3.  The reference rows are filtered to the running database version and EBS release.
4.  Each section of the output is a union of outer joins from the reference rows to `V$SYSTEM_PARAMETER2`, so parameters that are not set still appear.
5.  The final result is ordered by section, check result and parameter name.

## Parameters & Filtering
*   **Only show errors:** When Yes, the report returns rows with an ERROR check, parameters to be removed and hidden parameters that should not be set. When cleared, every checked parameter is listed.

## Performance & Optimization
*   **Small Driving Sets:** The reference rows are a fixed in-memory list, so each join is against a small set and the instance parameter view is read only a few times.
*   **Filtering Before Joining:** The version and release filters are applied to the reference rows before they are joined to the parameter view.
*   **Single Pass Per Section:** Each section is a separate branch of a union, so no section depends on another section's result.
*   **Prerequisite Grant:** APPS must be able to select from the parameter view. The description gives the synonym and grant statements needed where that access is missing.

## FAQ
**Q: Which database parameters does this report check?**
A: It checks the mandatory parameters for the running database version and EBS release, the parameters that should be removed, and any other non-default parameters on the instance.

**Q: Why does the report show a row with NOT FOUND:OK?**
A: The parameter is not set on the instance, but its default value matches the required value, so the check passes.

**Q: What does the report need to run?**
A: APPS needs SELECT on the V$SYSTEM_PARAMETER2 view. The report description gives the synonym and grant statements to run as SYSDBA when that access is not already in place.
