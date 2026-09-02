---
layout: default
title: 'DBA Database Parameter Validation | Oracle EBS SQL Report'
description: 'Replicates the database initialization-parameter validation performed by Oracle''s EBS Database Performance and Statistics Analyzer (My Oracle Support Doc…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, Database, Parameter, Validation, ref, v$system_parameter2'
permalink: /DBA%20Database%20Parameter%20Validation/
---

# DBA Database Parameter Validation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-database-parameter-validation/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
Only show errors

## Oracle EBS Tables Used
[ref](https://www.enginatics.com/library/?pg=1&find=ref), [v$system_parameter2](https://www.enginatics.com/library/?pg=1&find=v$system_parameter2)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[QP Price List Upload](/QP%20Price%20List%20Upload/ "QP Price List Upload Oracle EBS SQL Report"), [QP Modifier Upload](/QP%20Modifier%20Upload/ "QP Modifier Upload Oracle EBS SQL Report"), [BOM Routing Upload](/BOM%20Routing%20Upload/ "BOM Routing Upload Oracle EBS SQL Report"), [BOM Routings](/BOM%20Routings/ "BOM Routings Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Database Parameter Validation 16-Jun-2026 163655.xlsx](https://www.enginatics.com/example/dba-database-parameter-validation/) |
| Blitz Report™ XML Import | [DBA_Database_Parameter_Validation.xml](https://www.enginatics.com/xml/dba-database-parameter-validation/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-database-parameter-validation/](https://www.enginatics.com/reports/dba-database-parameter-validation/) |



---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
