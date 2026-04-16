---
layout: default
title: 'FND Data Groups | Oracle EBS SQL Report'
description: ' – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Data, Groups, fnd_data_groups, fnd_data_group_units, fnd_application_vl'
permalink: /FND%20Data%20Groups/
---

# FND Data Groups – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-data-groups/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
None

## Report Parameters
Data Group Name

## Oracle EBS Tables Used
[fnd_data_groups](https://www.enginatics.com/library/?pg=1&find=fnd_data_groups), [fnd_data_group_units](https://www.enginatics.com/library/?pg=1&find=fnd_data_group_units), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_oracle_userid](https://www.enginatics.com/library/?pg=1&find=fnd_oracle_userid)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Applications](/FND%20Applications/ "FND Applications Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [FND Audit Setup](/FND%20Audit%20Setup/ "FND Audit Setup Oracle EBS SQL Report"), [CAC WIP Material Usage Variance](/CAC%20WIP%20Material%20Usage%20Variance/ "CAC WIP Material Usage Variance Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Data Groups 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/fnd-data-groups/) |
| Blitz Report™ XML Import | [FND_Data_Groups.xml](https://www.enginatics.com/xml/fnd-data-groups/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-data-groups/](https://www.enginatics.com/reports/fnd-data-groups/) |

## Executive Summary
The **FND Data Groups** report documents the Data Group configuration in EBS. Data Groups determine which Oracle ID (database schema) a concurrent program connects to when it runs.

## Business Challenge
*   **Multi-Schema Support:** Managing environments where different applications store data in different schemas (common in custom bolt-ons).
*   **Security:** Verifying that programs are connecting with the appropriate privileges.
*   **Troubleshooting:** Solving "Table or View does not exist" errors when a program runs in the wrong context.

## The Solution
This Blitz Report lists the mapping between Applications and Oracle IDs within each Data Group:
*   **Group Definition:** Shows the name of the Data Group (e.g., "Standard").
*   **Application Mapping:** Lists every application (e.g., "Assets") and the Oracle User (e.g., "FA") it maps to in that group.

## Technical Architecture
The report queries `FND_DATA_GROUPS` and `FND_DATA_GROUP_UNITS`. It joins `FND_ORACLE_USERID` to show the actual database schema name.

## Parameters & Filtering
*   **Data Group Name:** Filter for a specific group.

## Performance & Optimization
*   **Configuration Report:** Runs instantly.

## FAQ
*   **Q: What is the "Standard" data group?**
    *   A: It is the default group where each application maps to its own standard schema (e.g., GL maps to GL schema).
*   **Q: Why would I change this?**
    *   A: You might create a custom Data Group to point a standard report to a reporting schema or a custom schema for specific processing needs.


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
