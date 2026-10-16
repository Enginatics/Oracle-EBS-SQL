---
layout: default
last_modified_at: 2026-10-16
title: 'FND Concurrent Program Incompatibilities | Oracle EBS SQL Report'
description: 'Concurrent Program Incompatibilities – Oracle EBS Application Object Library SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Concurrent, Program, Incompatibilities, fnd_concurrent_program_serial, fnd_concurrent_programs_vl, fnd_application_vl'
permalink: /FND%20Concurrent%20Program%20Incompatibilities/
report_name: 'FND Concurrent Program Incompatibilities'
report_web_name: fnd-concurrent-program-incompatibilities
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Concurrent Program Incompatibilities – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-concurrent-program-incompatibilities/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-program-incompatibilities) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-program-incompatibilities).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Concurrent Program Incompatibilities

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-program-incompatibilities) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Concurrent Program Name, Concurrent Program Short Name, Application Name

## Oracle EBS Tables Used
[fnd_concurrent_program_serial](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_program_serial&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-program-incompatibilities), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-program-incompatibilities), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-program-incompatibilities)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-program-incompatibilities)

## Related Reports
[FND Concurrent Request Conflicts](/FND%20Concurrent%20Request%20Conflicts/ "FND Concurrent Request Conflicts Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [FND Request Groups](/FND%20Request%20Groups/ "FND Request Groups Oracle EBS SQL Report"), [Blitz Report RDF Import Validation](/Blitz%20Report%20RDF%20Import%20Validation/ "Blitz Report RDF Import Validation Oracle EBS SQL Report"), [XDO Publisher Data Definitions](/XDO%20Publisher%20Data%20Definitions/ "XDO Publisher Data Definitions Oracle EBS SQL Report"), [FND Flex Value Sets, Usages and Values](/FND%20Flex%20Value%20Sets-%20Usages%20and%20Values/ "FND Flex Value Sets, Usages and Values Oracle EBS SQL Report"), [ECC Admin - Concurrent Programs](/ECC%20Admin%20-%20Concurrent%20Programs/ "ECC Admin - Concurrent Programs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Concurrent%20Program%20Incompatibilities/FND%20Concurrent%20Program%20Incompatibilities.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-program-incompatibilities) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Concurrent Program Incompatibilities 27-Jan-2019 115110.xlsx](https://www.enginatics.com/example/fnd-concurrent-program-incompatibilities/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-program-incompatibilities) |
| Blitz Report™ XML Import | [FND_Concurrent_Program_Incompatibilities.xml](https://www.enginatics.com/xml/fnd-concurrent-program-incompatibilities/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-program-incompatibilities) |
| SQL Source | [FND Concurrent Program Incompatibilities.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Concurrent%20Program%20Incompatibilities/FND%20Concurrent%20Program%20Incompatibilities.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-concurrent-program-incompatibilities/](https://www.enginatics.com/reports/fnd-concurrent-program-incompatibilities/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-program-incompatibilities) |

## Executive Summary
The **FND Concurrent Program Incompatibilities** report documents the exclusion rules defined between concurrent programs. It ensures that conflicting jobs (e.g., two programs updating the same table) do not run simultaneously.

## Business Challenge
*   **Data Integrity:** Preventing race conditions where two programs try to modify the same data at the same time.
*   **Performance Protection:** Ensuring that resource-intensive programs do not run in parallel.
*   **Setup Validation:** Verifying that necessary incompatibilities are correctly defined after a new module implementation.

## The Solution
This Blitz Report lists all defined incompatibilities:
*   **Conflict Mapping:** Shows Program A and Program B, and the scope of the incompatibility (Global or Domain).
*   **Scope Clarity:** Identifies if the incompatibility applies to the entire system or just within the same argument set.
*   **Bi-Directional Check:** Helps verify that the rule is effective in both directions if required.

## Technical Architecture
The report queries `FND_CONCURRENT_PROGRAM_SERIAL`, which stores the incompatibility rules. It joins `FND_CONCURRENT_PROGRAMS` twice (once for the running program, once for the incompatible program) to resolve names.

## Parameters & Filtering
*   **Program Name:** Search for a specific program to see what it is incompatible with.
*   **Application:** Filter by module.

## Performance & Optimization
*   **Static Data:** This is a configuration report and runs instantly.

## FAQ
*   **Q: What is a "Global" incompatibility?**
    *   A: It means the two programs can never run at the same time, regardless of who runs them or with what parameters.
*   **Q: Can I set incompatibilities here?**
    *   A: No, this is a reporting tool. Incompatibilities are defined in the "Concurrent Programs" setup form.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-program-incompatibilities)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-program-incompatibilities)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-program-incompatibilities)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-program-incompatibilities)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-program-incompatibilities)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-program-incompatibilities)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-program-incompatibilities)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
