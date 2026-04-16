---
layout: default
title: 'FND Concurrent Request Conflicts | Oracle EBS SQL Report'
description: 'Lists concurrent requests that were held by the conflict resolution manager and shows their conflicting / blocking requests which were running at the time…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Concurrent, Request, Conflicts, fnd_concurrent_requests, fnd_concurrent_program_serial, fnd_concurrent_programs_vl'
permalink: /FND%20Concurrent%20Request%20Conflicts/
---

# FND Concurrent Request Conflicts – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-concurrent-request-conflicts/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Lists concurrent requests that were held by the conflict resolution manager and shows their conflicting / blocking requests which were running at the time between the requested start date and conflict release date.
This might not work 100% (it doesn't consider request set conflicts yet), but should give a good indication of most conflicting scenarios.

## Report Parameters
Concurrent Program Name, Started within Days, Requested Start Date From, Requested Start Date To

## Oracle EBS Tables Used
[fnd_concurrent_requests](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_requests), [fnd_concurrent_program_serial](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_program_serial), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/ "FND Concurrent Requests 11i Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [ECC Admin - Concurrent Programs](/ECC%20Admin%20-%20Concurrent%20Programs/ "ECC Admin - Concurrent Programs Oracle EBS SQL Report"), [FND Concurrent Managers](/FND%20Concurrent%20Managers/ "FND Concurrent Managers Oracle EBS SQL Report"), [FND Concurrent Requests Summary](/FND%20Concurrent%20Requests%20Summary/ "FND Concurrent Requests Summary Oracle EBS SQL Report"), [FND Concurrent Program Incompatibilities](/FND%20Concurrent%20Program%20Incompatibilities/ "FND Concurrent Program Incompatibilities Oracle EBS SQL Report"), [INV Item Import Performance](/INV%20Item%20Import%20Performance/ "INV Item Import Performance Oracle EBS SQL Report"), [FND Request Groups](/FND%20Request%20Groups/ "FND Request Groups Oracle EBS SQL Report"), [FND Flex Value Sets, Usages and Values](/FND%20Flex%20Value%20Sets-%20Usages%20and%20Values/ "FND Flex Value Sets, Usages and Values Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Concurrent Request Conflicts 25-Jun-2023 132118.xlsx](https://www.enginatics.com/example/fnd-concurrent-request-conflicts/) |
| Blitz Report™ XML Import | [FND_Concurrent_Request_Conflicts.xml](https://www.enginatics.com/xml/fnd-concurrent-request-conflicts/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-concurrent-request-conflicts/](https://www.enginatics.com/reports/fnd-concurrent-request-conflicts/) |

## Executive Summary
The **FND Concurrent Request Conflicts** report analyzes the "Conflict Resolution Manager" (CRM) activity. It identifies requests that were delayed because they were incompatible with currently running jobs.

## Business Challenge
*   **Wait Time Analysis:** Understanding why a request stayed in "Pending" status for a long time.
*   **Incompatibility Tuning:** Identifying if incompatibility rules are too aggressive and causing unnecessary bottlenecks.
*   **SLA Monitoring:** Explaining delays in critical report delivery to business users.

## The Solution
This Blitz Report reconstructs the conflict scenario:
*   **Blocked Request:** Identifies the request that was held.
*   **Blocking Request:** Identifies the specific request ID that was running and caused the conflict.
*   **Time Impact:** Shows the duration of the delay caused by the conflict.

## Technical Architecture
The report logic looks at requests where the `PHASE_CODE` was 'P' (Pending) and analyzes the CRM logs or infers conflicts based on the `FND_CONCURRENT_PROGRAM_SERIAL` rules and execution timestamps of overlapping requests.

## Parameters & Filtering
*   **Program Name:** Filter for the program that was blocked.
*   **Date Range:** Analyze conflicts within a specific window.

## Performance & Optimization
*   **Complex Logic:** Determining conflicts retrospectively is complex. The report uses heuristic logic to match blocked requests with potential blockers.
*   **History:** Only works for requests that are still in the `FND_CONCURRENT_REQUESTS` table (not purged).

## FAQ
*   **Q: Does it show Request Set conflicts?**
    *   A: As noted in the description, it focuses on individual program conflicts and may not fully capture complex Request Set incompatibilities.


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
