---
layout: default
last_modified_at: 2026-10-16
title: 'FND Application Context File | Oracle EBS SQL Report'
description: 'Context XML files retrieved from the database – Oracle EBS Application Object Library SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Application, Context, File, fnd_oam_context_files'
permalink: /FND%20Application%20Context%20File/
report_name: 'FND Application Context File'
report_web_name: fnd-application-context-file
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Application Context File – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-application-context-file/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-application-context-file) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-application-context-file).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Context XML files retrieved from the database

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-application-context-file) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[fnd_oam_context_files](https://www.enginatics.com/library/?pg=1&find=fnd_oam_context_files&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-application-context-file)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-application-context-file)

## Related Reports
[DBA Database Parameter Validation](/DBA%20Database%20Parameter%20Validation/ "DBA Database Parameter Validation Oracle EBS SQL Report"), [XDO Publisher Data Definitions](/XDO%20Publisher%20Data%20Definitions/ "XDO Publisher Data Definitions Oracle EBS SQL Report"), [AD Applied Patches](/AD%20Applied%20Patches/ "AD Applied Patches Oracle EBS SQL Report"), [DBA Data Files](/DBA%20Data%20Files/ "DBA Data Files Oracle EBS SQL Report"), [DBA Tablespace Usage](/DBA%20Tablespace%20Usage/ "DBA Tablespace Usage Oracle EBS SQL Report"), [Blitz Report Templates](/Blitz%20Report%20Templates/ "Blitz Report Templates Oracle EBS SQL Report"), [DBA Blocking Sessions](/DBA%20Blocking%20Sessions/ "DBA Blocking Sessions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Application%20Context%20File/FND%20Application%20Context%20File.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-application-context-file) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Application Context File 06-Jul-2019 174000.xlsx](https://www.enginatics.com/example/fnd-application-context-file/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-application-context-file) |
| Blitz Report™ XML Import | [FND_Application_Context_File.xml](https://www.enginatics.com/xml/fnd-application-context-file/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-application-context-file) |
| SQL Source | [FND Application Context File.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Application%20Context%20File/FND%20Application%20Context%20File.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-application-context-file/](https://www.enginatics.com/reports/fnd-application-context-file/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-application-context-file) |

## Executive Summary
The **FND Application Context File** report retrieves the content of the Oracle E-Business Suite context file directly from the database. This file contains critical configuration details about the environment, such as port numbers, hostnames, and directory paths.

## Business Challenge
*   **Configuration Management:** Keeping track of environment-specific configurations without logging into the OS.
*   **Troubleshooting:** Quickly checking parameter values (e.g., `s_web_port`) during system issues.
*   **Cloning Verification:** Verifying that context variables were correctly updated after a clone.

## The Solution
This Blitz Report provides immediate access to the context file:
*   **Database Access:** Reads the XML stored in `FND_OAM_CONTEXT_FILES`, eliminating the need for shell access.
*   **Version History:** Can potentially show previous versions of the context file if they are stored in the history table.
*   **Searchability:** The output can be searched in Excel for specific variable names.

## Technical Architecture
The report queries `FND_OAM_CONTEXT_FILES`. This table is populated by the `adautocfg.sh` (AutoConfig) process. The report typically retrieves the most recent active file.

## Parameters & Filtering
*   **None:** Typically runs for the current environment.

## Performance & Optimization
*   **Data Size:** The context file is a large XML CLOB. The report handles this by extracting relevant fields or downloading the full content.

## FAQ
*   **Q: Can I edit the context file here?**
    *   A: No, this is a read-only report. Changes must be made via the Oracle OAM dashboard or by editing the XML file on the OS and running AutoConfig.
*   **Q: Why is the table empty?**
    *   A: If AutoConfig has never been run or the feature to upload the context file to the database is disabled, this table might be empty.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-application-context-file)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-application-context-file)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-application-context-file)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-application-context-file)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-application-context-file)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-application-context-file)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-application-context-file)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
