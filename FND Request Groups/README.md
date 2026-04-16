---
layout: default
title: 'FND Request Groups | Oracle EBS SQL Report'
description: 'FND request groups and their assigned units, such as concurrent programs, request sets or applications'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Request, Groups, fnd_request_groups, fnd_application_vl, fnd_request_group_units'
permalink: /FND%20Request%20Groups/
---

# FND Request Groups – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-request-groups/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
FND request groups and their assigned units, such as concurrent programs, request sets or applications

## Report Parameters
Request Group, Group Application, Concurrent Program Name

## Oracle EBS Tables Used
[fnd_request_groups](https://www.enginatics.com/library/?pg=1&find=fnd_request_groups), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_request_group_units](https://www.enginatics.com/library/?pg=1&find=fnd_request_group_units), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl), [fnd_request_sets_vl](https://www.enginatics.com/library/?pg=1&find=fnd_request_sets_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Responsibility Access 11i](/FND%20Responsibility%20Access%2011i/ "FND Responsibility Access 11i Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/ "FND Concurrent Requests 11i Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report"), [XDO Publisher Data Definitions](/XDO%20Publisher%20Data%20Definitions/ "XDO Publisher Data Definitions Oracle EBS SQL Report"), [FND Concurrent Programs and Executables 11i](/FND%20Concurrent%20Programs%20and%20Executables%2011i/ "FND Concurrent Programs and Executables 11i Oracle EBS SQL Report"), [FND Concurrent Programs and Executables](/FND%20Concurrent%20Programs%20and%20Executables/ "FND Concurrent Programs and Executables Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Request Groups 27-Jun-2024 161133.xlsx](https://www.enginatics.com/example/fnd-request-groups/) |
| Blitz Report™ XML Import | [FND_Request_Groups.xml](https://www.enginatics.com/xml/fnd-request-groups/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-request-groups/](https://www.enginatics.com/reports/fnd-request-groups/) |

## Executive Summary
The **FND Request Groups** report documents which concurrent programs are assigned to which Request Groups. This is the mechanism that controls which reports a user can run.

## Business Challenge
*   **Security Audit:** Verifying that sensitive reports (e.g., "Employee Salary Report") are not in standard request groups.
*   **Troubleshooting:** Explaining why a user cannot find a specific report in the "Submit Request" window.
*   **Configuration:** Documenting the contents of custom request groups.

## The Solution
This Blitz Report lists the assignments:
*   **Request Group:** The name of the group (e.g., "GL Concurrent Program Group").
*   **Unit Type:** Program, Set, or Application.
*   **Unit Name:** The specific report or set assigned.

## Technical Architecture
The report queries `FND_REQUEST_GROUPS` and `FND_REQUEST_GROUP_UNITS`.

## Parameters & Filtering
*   **Request Group:** Filter by the group name.
*   **Concurrent Program Name:** Find all groups that contain a specific report (Reverse Search).

## Performance & Optimization
*   **Fast Execution:** Runs quickly against the configuration tables.

## FAQ
*   **Q: What does "Application" unit type mean?**
    *   A: It means *all* reports belonging to that application are automatically included in the group.


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
