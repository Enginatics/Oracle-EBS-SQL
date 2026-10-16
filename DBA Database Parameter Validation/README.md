---
layout: default
last_modified_at: 2026-10-16
title: 'DBA Database Parameter Validation | Oracle EBS SQL Report'
description: 'Replicates the database initialization-parameter validation performed by Oracle''s EBS Database Performance and Statistics Analyzer (My Oracle Support Doc…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, Database, Parameter, Validation, ref0, dual, v$instance'
permalink: /DBA%20Database%20Parameter%20Validation/
report_name: 'DBA Database Parameter Validation'
report_web_name: dba-database-parameter-validation
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Database Parameter Validation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-database-parameter-validation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-parameter-validation) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-parameter-validation).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Replicates the database initialization-parameter validation performed by Oracle's EBS Database Performance and Statistics Analyzer (My Oracle Support Doc 2126712.1 / KB627702), so DBAs no longer need to download, install and run that analyzer to check EBS parameter compliance.

Reference: <a href="https://support.oracle.com/rs?type=doc&id=2126712.1" rel="nofollow" target="_blank">https://support.oracle.com/rs?type=doc&id=2126712.1</a>

It compares the current instance settings in v$system_parameter2 against Oracle's required values for the running RDBMS version (11.1 / 11.2 / 12.1 / 19c) and EBS release, per My Oracle Support Doc 396009.1 / KA1002 ("Database Initialization Parameters for Oracle E-Business Suite").
<a href="https://support.oracle.com/support/?kmContentId=11158187" rel="nofollow" target="_blank">https://support.oracle.com/support/?kmContentId=11158187</a>

Three sections:
1. Mandatory Database Parameters - current vs required value, with a Check of OK / NOT FOUND:OK / ERROR.
2. Database Parameters to be Removed - parameters (and events) that are explicitly set but should be removed for the running RDBMS version.
3. Database Additional Parameters - other non-default parameters set on the instance, flagging hidden (underscore) parameters that should not be set.

By default the "Only show errors" parameter is Yes, so only actionable rows are shown (Check = ERROR, parameters to be removed, and hidden parameters that should not be set). Clear the parameter to list every checked parameter. Memory sizes are shown in M / G (e.g. 600M, 2G).

Prerequisite: APPS requires SELECT on v$system_parameter2 (v_$system_parameter2). On most EBS instances this grant already exists; if not, as SYSDBA run:
create or replace public synonym V$SYSTEM_PARAMETER2 for SYS.V_$SYSTEM_PARAMETER2;
grant select on sys.V_$SYSTEM_PARAMETER2 to apps;

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-parameter-validation) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Only show errors

## Oracle EBS Tables Used
[ref0](https://www.enginatics.com/library/?pg=1&find=ref0&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-parameter-validation), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-parameter-validation), [v$instance](https://www.enginatics.com/library/?pg=1&find=v%24instance&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-parameter-validation), [v$system_parameter](https://www.enginatics.com/library/?pg=1&find=v%24system_parameter&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-parameter-validation), [v$system_parameter2](https://www.enginatics.com/library/?pg=1&find=v%24system_parameter2&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-parameter-validation)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-parameter-validation)

## Related Reports
[DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Item Cost & Routing](/CAC%20Item%20Cost%20-%20Routing/ "CAC Item Cost & Routing Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Database%20Parameter%20Validation/DBA%20Database%20Parameter%20Validation.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-parameter-validation) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Database Parameter Validation 16-Jun-2026 163655.xlsx](https://www.enginatics.com/example/dba-database-parameter-validation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-parameter-validation) |
| Blitz Report™ XML Import | [DBA_Database_Parameter_Validation.xml](https://www.enginatics.com/xml/dba-database-parameter-validation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-parameter-validation) |
| SQL Source | [DBA Database Parameter Validation.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Database%20Parameter%20Validation/DBA%20Database%20Parameter%20Validation.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-database-parameter-validation/](https://www.enginatics.com/reports/dba-database-parameter-validation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-parameter-validation) |

## Case Study & Technical Analysis: DBA Database Parameter Validation

### Executive Summary
DBA Database Parameter Validation checks the initialization parameters of an Oracle database instance against the values Oracle requires for an E-Business Suite installation. It reproduces the validation performed by the Oracle EBS Database Performance and Statistics Analyzer, so a DBA can confirm EBS parameter compliance from a spreadsheet without downloading and running that analyzer. The report is intended for database administrators and EBS technical consultants preparing a new instance, reviewing an upgrade, or auditing a production database against Oracle's guidance in My Oracle Support note 396009.1.

### Business Challenge
*   **Compliance Verification:** Oracle publishes a list of mandatory and recommended database parameters for EBS, and each database release changes the list.
*   **Obsolete Settings:** Parameters that were required in an earlier release can cause problems after an upgrade, and they remain set unless someone identifies them.
*   **Undocumented Changes:** Non-default and hidden parameters set by earlier administrators are hard to find without a complete comparison.
*   **Analyzer Overhead:** Running the separate Oracle analyzer requires download, installation and execution, which slows routine checks.

### The Solution
*   **Reference Data Set:** The report holds the required values as a built-in reference, grouped by database version and EBS release, and selects only the rows that apply to the running release.
*   **Three Check Sections:** Mandatory parameters are compared with their required values, parameters to be removed are flagged when they are explicitly set, and other non-default parameters are listed.
*   **Readable Sizes:** Byte values are converted to M and G notation, so memory settings can be compared directly with the reference values.
*   **Actionable View:** The Only show errors parameter is Yes by default, so only rows that need action are displayed.

### Technical Architecture (High Level)
#### Primary Tables
*   `V$SYSTEM_PARAMETER2`: the view of current instance parameters, with the value, the default flag and the modifiability flags.
*   `V$SYSTEM_PARAMETER`: used to read the CPU count for the parallel server calculation.
*   `V$INSTANCE`: supplies the database version and instance name used to select the reference rows.
*   `FND_PRODUCT_GROUPS`: supplies the EBS release name used to filter the reference rows.
*   `DUAL`: the source for the inline reference rows.

#### Logical Relationships
1.  The reference rows are generated in a common table expression from literal selects against `DUAL`, each carrying a parameter name, a category, the statement scope and the required value.
2.  A second common table expression reads the database version from `V$INSTANCE` and the EBS release from `FND_PRODUCT_GROUPS`.
3.  The reference rows are filtered to the running database version and EBS release.
4.  Each section of the output is a union of outer joins from the reference rows to `V$SYSTEM_PARAMETER2`, so parameters that are not set still appear.
5.  The final result is ordered by section, check result and parameter name.

### Parameters & Filtering
*   **Only show errors:** When Yes, the report returns rows with an ERROR check, parameters to be removed and hidden parameters that should not be set. When cleared, every checked parameter is listed.

### Performance & Optimization
*   **Small Driving Sets:** The reference rows are a fixed in-memory list, so each join is against a small set and the instance parameter view is read only a few times.
*   **Filtering Before Joining:** The version and release filters are applied to the reference rows before they are joined to the parameter view.
*   **Single Pass Per Section:** Each section is a separate branch of a union, so no section depends on another section's result.
*   **Prerequisite Grant:** APPS must be able to select from the parameter view. The description gives the synonym and grant statements needed where that access is missing.

### FAQ
**Q: Which database parameters does this report check?**
A: It checks the mandatory parameters for the running database version and EBS release, the parameters that should be removed, and any other non-default parameters on the instance.

**Q: Why does the report show a row with NOT FOUND:OK?**
A: The parameter is not set on the instance, but its default value matches the required value, so the check passes.

**Q: What does the report need to run?**
A: APPS needs SELECT on the V$SYSTEM_PARAMETER2 view. The report description gives the synonym and grant statements to run as SYSDBA when that access is not already in place.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-parameter-validation)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-parameter-validation)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-parameter-validation)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-parameter-validation)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-parameter-validation)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-parameter-validation)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-database-parameter-validation)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
