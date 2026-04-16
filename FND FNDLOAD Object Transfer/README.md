---
layout: default
title: 'FND FNDLOAD Object Transfer | Oracle EBS SQL Report'
description: 'Generates FNDLOAD download and upload linux commands for automated setup transfer between environments'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, FNDLOAD, Object, Transfer, fnd_concurrent_programs_vl, fnd_form_functions, fnd_lookup_types'
permalink: /FND%20FNDLOAD%20Object%20Transfer/
---

# FND FNDLOAD Object Transfer – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-fndload-object-transfer/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Generates FNDLOAD download and upload linux commands for automated setup transfer between environments

## Report Parameters
Object Type, Object Name, Application Short Name, Output File Location, Apps Password Download, Apps Password Upload

## Oracle EBS Tables Used
[fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl), [fnd_form_functions](https://www.enginatics.com/library/?pg=1&find=fnd_form_functions), [fnd_lookup_types](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_types), [fnd_application](https://www.enginatics.com/library/?pg=1&find=fnd_application), [fnd_profile_options](https://www.enginatics.com/library/?pg=1&find=fnd_profile_options)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND Responsibility Access 11i](/FND%20Responsibility%20Access%2011i/ "FND Responsibility Access 11i Oracle EBS SQL Report"), [FND Forms Personalizations](/FND%20Forms%20Personalizations/ "FND Forms Personalizations Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [FND Attachment Functions](/FND%20Attachment%20Functions/ "FND Attachment Functions Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [FND Flex Value Sets, Usages and Values](/FND%20Flex%20Value%20Sets-%20Usages%20and%20Values/ "FND Flex Value Sets, Usages and Values Oracle EBS SQL Report"), [FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/ "FND Concurrent Requests 11i Oracle EBS SQL Report"), [FND Concurrent Programs and Executables 11i](/FND%20Concurrent%20Programs%20and%20Executables%2011i/ "FND Concurrent Programs and Executables 11i Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/fnd-fndload-object-transfer/) |
| Blitz Report™ XML Import | [FND_FNDLOAD_Object_Transfer.xml](https://www.enginatics.com/xml/fnd-fndload-object-transfer/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-fndload-object-transfer/](https://www.enginatics.com/reports/fnd-fndload-object-transfer/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
