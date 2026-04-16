---
layout: default
title: 'Blitz Report Access Upload | Oracle EBS SQL Report'
description: 'Upload to update value for profile option ''Blitz Report Access'' at user or responsibility level. Someone having this upload assigned, can maintain the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Blitz, Report, Access, fnd_profile_options_vl, fnd_profile_option_values, fnd_user'
permalink: /Blitz%20Report%20Access%20Upload/
---

# Blitz Report Access Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-access-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Upload to update value for profile option 'Blitz Report Access' at user or responsibility level.

Someone having this upload assigned, can maintain the profile option values for other users or responsibilities up to their own access level.
He could, for example, set the value to 'User' for other users, but not to anything higher, such as 'Developer'.
Someone with Developer access could set the value for other users and developers, but not to the highest level 'System'.

## Report Parameters
Level, Value

## Oracle EBS Tables Used
[fnd_profile_options_vl](https://www.enginatics.com/library/?pg=1&find=fnd_profile_options_vl), [fnd_profile_option_values](https://www.enginatics.com/library/?pg=1&find=fnd_profile_option_values), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[FND Responsibilities](/FND%20Responsibilities/ "FND Responsibilities Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND Profile Option Values](/FND%20Profile%20Option%20Values/ "FND Profile Option Values Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [FND Profile Options](/FND%20Profile%20Options/ "FND Profile Options Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Report Access Upload 25-Apr-2024 060349.xlsm](https://www.enginatics.com/example/blitz-report-access-upload/) |
| Blitz Report™ XML Import | [Blitz_Report_Access_Upload.xml](https://www.enginatics.com/xml/blitz-report-access-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-report-access-upload/](https://www.enginatics.com/reports/blitz-report-access-upload/) |

## Blitz Report Access Upload - Case Study & Technical Analysis

### Executive Summary

The **Blitz Report Access Upload** is an administrative utility designed to streamline the management of user access rights within the Blitz Report framework. It allows authorized administrators to bulk-update the `Blitz Report Access` profile option for multiple users or responsibilities via an Excel upload. This tool is essential for maintaining security and governance in large environments where managing access one-by-one is inefficient.

### Business Challenge

Controlling who can create, edit, or run reports is critical for system security and performance.
*   **Scalability:** In an organization with thousands of users, manually setting profile options for each user or responsibility is time-consuming.
*   **Consistency:** Ensuring that all "Finance Users" have the same level of access (e.g., "User" level) and all "Developers" have higher access (e.g., "Developer" level) is difficult to audit and maintain manually.
*   **Delegation:** Central IT often wants to delegate the management of report access to functional leads without giving them full System Administrator privileges.

### Solution

The **Blitz Report Access Upload** tool solves these challenges by:
*   **Bulk Processing:** Enabling the update of hundreds of access records in a single upload.
*   **Validation:** Checking that the user performing the upload has sufficient privileges to grant the requested access level (preventing privilege escalation).
*   **Granularity:** Supporting updates at both the "User" and "Responsibility" levels.

### Technical Architecture

The tool interacts with the standard Oracle FND Profile Option tables.

#### Key Tables & Joins

*   **Profile Definition:** `FND_PROFILE_OPTIONS_VL` identifies the specific profile option being updated (`Blitz Report Access`).
*   **Profile Values:** `FND_PROFILE_OPTION_VALUES` stores the actual assigned values (e.g., 'User', 'Developer', 'System').
*   **User/Resp:** `FND_USER` and `FND_RESPONSIBILITY_VL` are used to validate the entities receiving the access.

#### Logic

1.  **Input:** The user uploads an Excel sheet with columns for `Level` (User/Responsibility), `Level Value` (UserName/RespName), and `Value` (The access level to grant).
2.  **Validation:**
    *   Checks if the target User/Responsibility exists.
    *   **Security Check:** Verifies that the uploader's own access level is greater than or equal to the level they are trying to grant. For example, a "Developer" cannot grant "System" access.
3.  **Update:** Uses standard FND APIs (e.g., `FND_PROFILE.SAVE`) to apply the changes safely.

### Parameters

*   **Level:** The scope of the update (e.g., 'User', 'Responsibility').
*   **Value:** The specific access level to assign (e.g., 'User', 'Developer', 'Admin').

### FAQ

**Q: What are the different access levels?**
A: Typically:
    *   *User:* Can run assigned reports.
    *   *Developer:* Can create and edit SQL queries.
    *   *System:* Full administrative control.

**Q: Can I use this to remove access?**
A: Yes, by uploading a blank value or a specific "No Access" value, depending on the configuration.

**Q: Is this safe?**
A: Yes, the tool enforces a hierarchy check. You cannot grant permissions higher than what you possess yourself, preventing unauthorized elevation of privileges.


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
