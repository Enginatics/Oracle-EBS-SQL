---
layout: default
last_modified_at: 2026-10-16
title: 'FND FNDLOAD Object Transfer | Oracle EBS SQL Report'
description: 'Generates FNDLOAD download and upload linux commands for automated setup transfer between environments'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, FNDLOAD, Object, Transfer, fnd_concurrent_programs_vl, fnd_form_functions, fnd_lookup_types'
permalink: /FND%20FNDLOAD%20Object%20Transfer/
report_name: 'FND FNDLOAD Object Transfer'
report_web_name: fnd-fndload-object-transfer
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND FNDLOAD Object Transfer – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-fndload-object-transfer/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-fndload-object-transfer) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-fndload-object-transfer).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Generates FNDLOAD download and upload linux commands for automated setup transfer between environments

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-fndload-object-transfer) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Object Type, Object Name, Application Short Name, Output File Location, Apps Password Download, Apps Password Upload

## Oracle EBS Tables Used
[fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-fndload-object-transfer), [fnd_form_functions](https://www.enginatics.com/library/?pg=1&find=fnd_form_functions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-fndload-object-transfer), [fnd_lookup_types](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-fndload-object-transfer), [fnd_application](https://www.enginatics.com/library/?pg=1&find=fnd_application&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-fndload-object-transfer), [fnd_profile_options](https://www.enginatics.com/library/?pg=1&find=fnd_profile_options&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-fndload-object-transfer)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-fndload-object-transfer)

## Related Reports
[FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND Forms Personalizations](/FND%20Forms%20Personalizations/ "FND Forms Personalizations Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [FND Attachment Functions](/FND%20Attachment%20Functions/ "FND Attachment Functions Oracle EBS SQL Report"), [FND Debug and Trace Settings](/FND%20Debug%20and%20Trace%20Settings/ "FND Debug and Trace Settings Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [FND Flex Value Sets, Usages and Values](/FND%20Flex%20Value%20Sets-%20Usages%20and%20Values/ "FND Flex Value Sets, Usages and Values Oracle EBS SQL Report"), [INV Item Templates](/INV%20Item%20Templates/ "INV Item Templates Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20FNDLOAD%20Object%20Transfer/FND%20FNDLOAD%20Object%20Transfer.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-fndload-object-transfer) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/fnd-fndload-object-transfer/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-fndload-object-transfer) |
| Blitz Report™ XML Import | [FND_FNDLOAD_Object_Transfer.xml](https://www.enginatics.com/xml/fnd-fndload-object-transfer/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-fndload-object-transfer) |
| SQL Source | [FND FNDLOAD Object Transfer.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20FNDLOAD%20Object%20Transfer/FND%20FNDLOAD%20Object%20Transfer.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-fndload-object-transfer/](https://www.enginatics.com/reports/fnd-fndload-object-transfer/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-fndload-object-transfer) |

## Executive Summary
The **FND FNDLOAD Object Transfer** report is a DevOps utility that generates the Linux commands required to migrate Oracle EBS configurations between environments (e.g., DEV to TEST).

## Business Challenge
*   **Deployment Automation:** Reducing the manual effort of typing complex FNDLOAD commands.
*   **Error Reduction:** Preventing syntax errors in migration scripts.
*   **Standardization:** Ensuring consistent migration practices across the development team.

## The Solution
This Blitz Report generates the exact shell commands:
*   **Download Command:** The `FNDLOAD` syntax to extract the object from the source instance.
*   **Upload Command:** The `FNDLOAD` syntax to import the object into the target instance.
*   **Object Support:** Supports common objects like Concurrent Programs, Lookups, Profile Options, and Functions.

## Technical Architecture
The report uses a large `DECODE` or `CASE` statement to map the user-selected "Object Type" to the specific `.lct` configuration file and download parameters required by the FNDLOAD utility.

## Parameters & Filtering
*   **Object Type:** Select the type of object (e.g., "Concurrent Program").
*   **Object Name:** The specific name of the object to migrate.
*   **Apps Password:** Optional parameter to embed the password in the command (use with caution).

## Performance & Optimization
*   **Utility Report:** Runs instantly.

## FAQ
*   **Q: Does this run the migration?**
    *   A: No, it generates the *text* of the command. You must copy and paste this into a Linux terminal or put it in a shell script.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-fndload-object-transfer)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-fndload-object-transfer)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-fndload-object-transfer)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-fndload-object-transfer)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-fndload-object-transfer)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-fndload-object-transfer)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-fndload-object-transfer)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
