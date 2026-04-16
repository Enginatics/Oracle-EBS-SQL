---
layout: default
title: 'FND Profile Option Values | Oracle EBS SQL Report'
description: 'Profile option values on all setup levels. Unlike Oracle''s SQL script from note 201945.1, this report also shows the user visible profile option value in…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Profile, Option, Values, fnd_application_vl, fnd_profile_options_vl, fnd_profile_option_values'
permalink: /FND%20Profile%20Option%20Values/
---

# FND Profile Option Values – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-profile-option-values/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Profile option values on all setup levels.
Unlike Oracle's SQL script from note 201945.1, this report also shows the user visible profile option value in addition to the internal system profile option value.

## Report Parameters
User Profile Name starts with, User Profile Name any lang, Setup Level, Setup Level Value, Application Name, Application Short Name, System Profile Name starts with, Last Update Date From, Last Update Date To, Last Updated By, Profile System Value like, Redundant

## Oracle EBS Tables Used
[fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_profile_options_vl](https://www.enginatics.com/library/?pg=1&find=fnd_profile_options_vl), [fnd_profile_option_values](https://www.enginatics.com/library/?pg=1&find=fnd_profile_option_values), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [fnd_nodes](https://www.enginatics.com/library/?pg=1&find=fnd_nodes)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND User Login History](/FND%20User%20Login%20History/ "FND User Login History Oracle EBS SQL Report"), [FND Responsibilities](/FND%20Responsibilities/ "FND Responsibilities Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/ "FND Concurrent Requests 11i Oracle EBS SQL Report"), [FND Responsibility Access 11i](/FND%20Responsibility%20Access%2011i/ "FND Responsibility Access 11i Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Profile Option Values 11-May-2017 124115.xlsx](https://www.enginatics.com/example/fnd-profile-option-values/) |
| Blitz Report™ XML Import | [FND_Profile_Option_Values.xml](https://www.enginatics.com/xml/fnd-profile-option-values/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-profile-option-values/](https://www.enginatics.com/reports/fnd-profile-option-values/) |

## Executive Summary
The **FND Profile Option Values** report is the definitive tool for auditing system configuration. It shows the value of every profile option at every level (Site, Application, Responsibility, User, Server, Org).

## Business Challenge
*   **Troubleshooting:** Investigating why a user sees different behavior than others (often due to a User-level profile override).
*   **Environment Comparison:** Checking if the "Site" level profiles match between PROD and TEST.
*   **Security Audit:** Verifying that critical security profiles (e.g., "Signon Password Hard to Guess") are set correctly.

## The Solution
This Blitz Report lists the profile values:
*   **Profile Name:** The user-friendly name (e.g., "MO: Operating Unit").
*   **Level:** The hierarchy level (Site, Resp, User, etc.).
*   **Value:** The actual setting (e.g., "Vision Operations").
*   **Visible Value:** It decodes internal IDs (like Org ID 204) into readable names (like "Vision Operations").

## Technical Architecture
The report queries `FND_PROFILE_OPTION_VALUES` and joins to context tables like `FND_USER`, `FND_RESPONSIBILITY`, and `HR_ALL_ORGANIZATION_UNITS`.

## Parameters & Filtering
*   **User Profile Name:** Search by the friendly name.
*   **Setup Level:** Filter to see only "Site" or "User" level settings.
*   **Redundant:** A special filter to find values set at lower levels that are identical to the Site level (cleanup opportunity).

## Performance & Optimization
*   **Volume:** There are millions of profile values. Always filter by Profile Name or Level.

## FAQ
*   **Q: Why are there two value columns?**
    *   A: "Profile System Value" is what is stored in the DB (often an ID). "Profile User Value" is the translated, human-readable meaning.


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
