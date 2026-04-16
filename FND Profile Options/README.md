---
layout: default
title: 'FND Profile Options | Oracle EBS SQL Report'
description: 'FND profile option definition – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Profile, Options, fnd_profile_options_vl, fnd_application_vl'
permalink: /FND%20Profile%20Options/
---

# FND Profile Options – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-profile-options/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
FND profile option definition

## Report Parameters
User Profile Name starts with, System Profile Name starts with, Application, Creation Date From, Show active only, Show Display Value

## Oracle EBS Tables Used
[fnd_profile_options_vl](https://www.enginatics.com/library/?pg=1&find=fnd_profile_options_vl), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Inventory Accounts Setup](/CAC%20Inventory%20Accounts%20Setup/ "CAC Inventory Accounts Setup Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [FND Profile Option Values](/FND%20Profile%20Option%20Values/ "FND Profile Option Values Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND FNDLOAD Object Transfer](/FND%20FNDLOAD%20Object%20Transfer/ "FND FNDLOAD Object Transfer Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [FND Responsibilities](/FND%20Responsibilities/ "FND Responsibilities Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Profile Options 03-Apr-2018 105618.xlsx](https://www.enginatics.com/example/fnd-profile-options/) |
| Blitz Report™ XML Import | [FND_Profile_Options.xml](https://www.enginatics.com/xml/fnd-profile-options/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-profile-options/](https://www.enginatics.com/reports/fnd-profile-options/) |

## Executive Summary
The **FND Profile Options** report documents the *definition* of profile options, not their values. It shows the metadata about the profile itself.

## Business Challenge
*   **Custom Development:** Checking if a custom profile option is defined correctly (e.g., valid at User level).
*   **System Discovery:** Finding all profile options related to a specific module (e.g., all "INV%" profiles).

## The Solution
This Blitz Report lists the profile definition:
*   **Profile Name:** The internal code and user name.
*   **Hierarchy:** Which levels (Site, App, Resp, User) are enabled and updateable.
*   **SQL Validation:** The SQL statement used to validate the values entered by the admin.

## Technical Architecture
The report queries `FND_PROFILE_OPTIONS_VL`.

## Parameters & Filtering
*   **User Profile Name:** Search by name.
*   **Application:** Filter by owning module.

## Performance & Optimization
*   **Fast Execution:** Runs quickly against the metadata tables.

## FAQ
*   **Q: Can I see the values here?**
    *   A: No, use "FND Profile Option Values" to see the actual settings. This report just shows the rules for the profile.


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
