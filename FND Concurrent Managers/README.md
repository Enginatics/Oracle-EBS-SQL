---
layout: default
title: 'FND Concurrent Managers | Oracle EBS SQL Report'
description: 'Concurrent managers'' setup and current status, e.g. processes and requests running, pending etc. Shows the same information as…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Concurrent, Managers, fnd_concurrent_queues_vl, fnd_application_vl, fnd_cp_services_vl'
permalink: /FND%20Concurrent%20Managers/
---

# FND Concurrent Managers – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-concurrent-managers/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Concurrent managers' setup and current status, e.g. processes and requests running, pending etc.
Shows the same information as Concurrent->Manager->Administer and Concurrent->Manager->Define

## Report Parameters
Manager Name, Show Specialization Rules, Show Processes, Active Processes only, Show Requests, Active Requests only

## Oracle EBS Tables Used
[fnd_concurrent_queues_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_queues_vl), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_cp_services_vl](https://www.enginatics.com/library/?pg=1&find=fnd_cp_services_vl), [fnd_concurrent_worker_requests](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_worker_requests), [fnd_concurrent_queue_content](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_queue_content), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl), [fnd_concurrent_processes](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_processes), [fnd_concurrent_requests](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_requests)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/ "FND Concurrent Requests 11i Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [ECC Admin - Concurrent Programs](/ECC%20Admin%20-%20Concurrent%20Programs/ "ECC Admin - Concurrent Programs Oracle EBS SQL Report"), [FND Concurrent Requests Summary](/FND%20Concurrent%20Requests%20Summary/ "FND Concurrent Requests Summary Oracle EBS SQL Report"), [FND Concurrent Request Conflicts](/FND%20Concurrent%20Request%20Conflicts/ "FND Concurrent Request Conflicts Oracle EBS SQL Report"), [FND Attachment Functions](/FND%20Attachment%20Functions/ "FND Attachment Functions Oracle EBS SQL Report"), [XDO Publisher Data Definitions](/XDO%20Publisher%20Data%20Definitions/ "XDO Publisher Data Definitions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Concurrent Managers 27-Jan-2019 005502.xlsx](https://www.enginatics.com/example/fnd-concurrent-managers/) |
| Blitz Report™ XML Import | [FND_Concurrent_Managers.xml](https://www.enginatics.com/xml/fnd-concurrent-managers/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-concurrent-managers/](https://www.enginatics.com/reports/fnd-concurrent-managers/) |

## Executive Summary
The **FND Concurrent Managers** report provides a real-time dashboard of the concurrent processing system. It details the configuration and current status of all concurrent managers, including their workload and specialization rules.

## Business Challenge
*   **Bottleneck Detection:** Identifying managers that have a backlog of pending requests.
*   **Capacity Planning:** Determining if more processes (workers) need to be assigned to a specific manager.
*   **Troubleshooting:** Checking if a manager is actually running or if it has deactivated due to errors.

## The Solution
This Blitz Report replicates and enhances the "Administer Concurrent Managers" form:
*   **Comprehensive Status:** Shows Target vs. Actual processes, Running Requests, and Pending Requests.
*   **Specialization Visibility:** Details the "Include/Exclude" rules that determine which programs a manager can run.
*   **Queue Analysis:** Provides insight into the depth of the queue for each manager.

## Technical Architecture
The report queries `FND_CONCURRENT_QUEUES` (Managers) and joins with `FND_CONCURRENT_PROCESSES` (Workers) and `FND_CONCURRENT_REQUESTS` (Workload). It calculates the "Pending" and "Running" counts dynamically.

## Parameters & Filtering
*   **Manager Name:** Filter for a specific manager (e.g., "Standard Manager").
*   **Show Specialization Rules:** Toggle to list the programs included/excluded for the manager.

## Performance & Optimization
*   **Real-Time Data:** This report queries active transaction tables. It is generally fast but reflects the system state at the exact moment of execution.

## FAQ
*   **Q: What is the "Standard Manager"?**
    *   A: It is the default manager that picks up any request not routed to a specialized manager.
*   **Q: Why is "Actual" less than "Target"?**
    *   A: The Internal Manager Manager (ICM) might still be starting up processes, or the manager might have encountered an error and scaled down.


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
