---
layout: default
title: 'FND Concurrent Programs and Executables 11i | Oracle EBS SQL Report'
description: 'Concurrent programs, executables and program parameters – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Concurrent, Programs, Executables, fnd_application_vl, fnd_concurrent_programs_vl, fnd_executables_vl'
permalink: /FND%20Concurrent%20Programs%20and%20Executables%2011i/
---

# FND Concurrent Programs and Executables 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-concurrent-programs-and-executables-11i/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Concurrent programs, executables and program parameters

## Report Parameters
Concurrent Program Name like, Concurrent Progr. (all languages), Concurrent Program Short Name, Creation Date From, Application Name, Application Short Name, Executable Name, Executable Short Name, Executable Description, Execution Method, Execution File Name (Package), Output Format, Show Parameters, Parameter Default Type

## Oracle EBS Tables Used
[fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl), [fnd_executables_vl](https://www.enginatics.com/library/?pg=1&find=fnd_executables_vl), [fnd_descr_flex_col_usage_vl](https://www.enginatics.com/library/?pg=1&find=fnd_descr_flex_col_usage_vl), [fnd_flex_value_sets](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_sets), [fnd_concurrent_request_class](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_request_class)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Concurrent Programs and Executables](/FND%20Concurrent%20Programs%20and%20Executables/ "FND Concurrent Programs and Executables Oracle EBS SQL Report"), [FND Flex Value Sets, Usages and Values](/FND%20Flex%20Value%20Sets-%20Usages%20and%20Values/ "FND Flex Value Sets, Usages and Values Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/ "FND Concurrent Requests 11i Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [FND Responsibility Access 11i](/FND%20Responsibility%20Access%2011i/ "FND Responsibility Access 11i Oracle EBS SQL Report"), [FND Concurrent Requests Summary](/FND%20Concurrent%20Requests%20Summary/ "FND Concurrent Requests Summary Oracle EBS SQL Report"), [XDO Publisher Data Definitions](/XDO%20Publisher%20Data%20Definitions/ "XDO Publisher Data Definitions Oracle EBS SQL Report"), [FND Descriptive Flexfields](/FND%20Descriptive%20Flexfields/ "FND Descriptive Flexfields Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/fnd-concurrent-programs-and-executables-11i/) |
| Blitz Report™ XML Import | [FND_Concurrent_Programs_and_Executables_11i.xml](https://www.enginatics.com/xml/fnd-concurrent-programs-and-executables-11i/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-concurrent-programs-and-executables-11i/](https://www.enginatics.com/reports/fnd-concurrent-programs-and-executables-11i/) |

## Executive Summary
The **FND Concurrent Programs and Executables 11i** report is the legacy version of the program definition report, specifically tailored for the Oracle E-Business Suite 11i data model.

## Business Challenge
*   **Legacy Support:** Maintaining documentation for older 11i environments.
*   **Upgrade Analysis:** Comparing program definitions between 11i and R12 during an upgrade project.

## The Solution
This Blitz Report provides the same detailed breakdown as the R12 version but is optimized for the 11i schema:
*   **Program Definitions:** Executable, Output Format, and Print Style.
*   **Parameter Details:** Value sets, defaults, and prompts.

## Technical Architecture
The query structure is similar to the R12 version but accounts for schema differences present in the 11i version of `FND` tables.

## Parameters & Filtering
*   **Program Name:** Filter by specific program.
*   **Application:** Filter by module.

## Performance & Optimization
*   **Usage:** Only use this report if you are running on an 11i instance. For R12, use the standard "FND Concurrent Programs and Executables" report.

## FAQ
*   **Q: Will this work on R12?**
    *   A: It might run, but some columns or joins may be deprecated. Always use the version matching your EBS release.


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
