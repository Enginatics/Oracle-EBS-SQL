---
layout: default
title: 'FND Concurrent Programs and Executables | Oracle EBS SQL Report'
description: 'Concurrent programs, executables and program parameters – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, FND, Concurrent, Programs, Executables, fnd_application_vl, fnd_concurrent_programs_vl, fnd_executables_vl'
permalink: /FND%20Concurrent%20Programs%20and%20Executables/
---

# FND Concurrent Programs and Executables – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-concurrent-programs-and-executables/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Concurrent programs, executables and program parameters

## Report Parameters
Concurrent Program Name like, Concurrent Progr. (all languages), Concurrent Progr. Short Name like, Enabled, Creation Date From, Application Name, Application Short Name, Executable Name, Executable Short Name, Executable Description, Execution Method, Execution File Name like, Output Format, Show Parameters, Parameter Default Type, Show Reports only

## Oracle EBS Tables Used
[fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl), [fnd_executables_vl](https://www.enginatics.com/library/?pg=1&find=fnd_executables_vl), [fnd_descr_flex_col_usage_vl](https://www.enginatics.com/library/?pg=1&find=fnd_descr_flex_col_usage_vl), [fnd_flex_value_sets](https://www.enginatics.com/library/?pg=1&find=fnd_flex_value_sets), [fnd_concurrent_request_class](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_request_class), [fnd_conc_prog_onsite_info](https://www.enginatics.com/library/?pg=1&find=fnd_conc_prog_onsite_info)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[FND Concurrent Programs and Executables 11i](/FND%20Concurrent%20Programs%20and%20Executables%2011i/ "FND Concurrent Programs and Executables 11i Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/ "FND Concurrent Requests 11i Oracle EBS SQL Report"), [FND Flex Value Sets, Usages and Values](/FND%20Flex%20Value%20Sets-%20Usages%20and%20Values/ "FND Flex Value Sets, Usages and Values Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND Responsibility Access 11i](/FND%20Responsibility%20Access%2011i/ "FND Responsibility Access 11i Oracle EBS SQL Report"), [XDO Publisher Data Definitions](/XDO%20Publisher%20Data%20Definitions/ "XDO Publisher Data Definitions Oracle EBS SQL Report"), [PER Organizations](/PER%20Organizations/ "PER Organizations Oracle EBS SQL Report"), [FND Concurrent Requests Summary](/FND%20Concurrent%20Requests%20Summary/ "FND Concurrent Requests Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Concurrent Programs and Executables 24-Jul-2017 144449.xlsx](https://www.enginatics.com/example/fnd-concurrent-programs-and-executables/) |
| Blitz Report™ XML Import | [FND_Concurrent_Programs_and_Executables.xml](https://www.enginatics.com/xml/fnd-concurrent-programs-and-executables/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-concurrent-programs-and-executables/](https://www.enginatics.com/reports/fnd-concurrent-programs-and-executables/) |

## Executive Summary
The **FND Concurrent Programs and Executables** report is the definitive documentation tool for all concurrent programs in the system. It provides a complete technical specification of each program, including its executable logic, parameters, and value sets.

## Business Challenge
*   **Documentation:** Keeping technical documentation up to date with system changes.
*   **Impact Analysis:** Identifying all programs that use a specific PL/SQL package or value set before making changes.
*   **Cleanup:** Finding obsolete or disabled programs that clutter the system.

## The Solution
This Blitz Report extracts the full definition of concurrent programs:
*   **Full Hierarchy:** Links the Program -> Executable -> Execution File (e.g., PL/SQL package name).
*   **Parameter Detail:** Lists every parameter, its sequence, prompt, and associated value set.
*   **Output Configuration:** Shows the default output format (Text, PDF, XML) and print style.

## Technical Architecture
The report joins `FND_CONCURRENT_PROGRAMS`, `FND_EXECUTABLES`, and `FND_DESCR_FLEX_COL_USAGE` (for parameters). It provides a flattened view where header information is repeated for each parameter row.

## Parameters & Filtering
*   **Program Name:** Search by user-friendly name or short code.
*   **Execution File:** Find all programs that call a specific SQL script or package.
*   **Show Parameters:** Toggle to show detailed parameter rows or just the program header.

## Performance & Optimization
*   **Data Volume:** There are thousands of standard programs. Always filter by Application or Name to avoid a massive export.

## FAQ
*   **Q: Can I see the SQL code of the program?**
    *   A: This report gives the *name* of the execution file (e.g., `XX_MY_PKG`). You would need a separate tool or SQL developer to view the package code itself.
*   **Q: Does it show Request Groups?**
    *   A: No, this report focuses on the program definition. Use "FND Request Groups" to see where the program is assigned.


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
